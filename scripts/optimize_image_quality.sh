#!/bin/bash

# CrystaShell - Configurador de Qualidade de Imagem para Yazi
# Otimiza a qualidade de preview baseado no terminal e resolução

echo "🖼️  Configurador de Qualidade de Imagem - Yazi"
echo "=============================================="
echo ""

# Detectar informações do terminal
TERM_NAME="${TERM:-unknown}"
TERM_WIDTH=$(tput cols 2>/dev/null || echo "80")
TERM_HEIGHT=$(tput lines 2>/dev/null || echo "24")
COLORTERM="${COLORTERM:-}"

echo "🔍 Detectando ambiente:"
echo "   Terminal: $TERM_NAME"
echo "   Resolução: ${TERM_WIDTH}x${TERM_HEIGHT}"
echo "   Color Term: ${COLORTERM:-N/A}"
echo ""

# Verificar suporte a protocolos de imagem
check_protocol_support() {
    echo "🧪 Verificando suporte a protocolos de imagem:"
    
    # Sixel
    if [ "$TERM" = "xterm-256color" ] || [ "$TERM" = "tmux-256color" ] || echo "$TERM" | grep -q "kitty"; then
        echo "   ✅ Sixel: Suportado"
        SIXEL_SUPPORT=true
    else
        echo "   ❌ Sixel: Não suportado"
        SIXEL_SUPPORT=false
    fi
    
    # Kitty protocol
    if [ "$TERM" = "xterm-kitty" ] || echo "$TERM" | grep -q "kitty"; then
        echo "   ✅ Kitty Protocol: Suportado"
        KITTY_SUPPORT=true
    else
        echo "   ❌ Kitty Protocol: Não suportado"
        KITTY_SUPPORT=false
    fi
    
    # iTerm2
    if [ "$TERM_PROGRAM" = "iTerm.app" ]; then
        echo "   ✅ iTerm2: Suportado"
        ITERM_SUPPORT=true
    else
        echo "   ❌ iTerm2: Não suportado"
        ITERM_SUPPORT=false
    fi
    
    echo ""
}

# Configurar chafa para melhor qualidade
configure_chafa() {
    echo "⚙️  Configurando chafa para máxima qualidade:"
    
    # Criar arquivo de configuração do chafa
    mkdir -p ~/.config/chafa
    
    cat > ~/.config/chafa/chafa.conf << 'EOF'
# Configuração otimizada do chafa para 2K
format=symbols
symbols=block
fill=block
colors=256
dither=fs
work=9
stretch=on
optimize=9
preprocess=on
EOF
    
    echo "   ✅ Arquivo ~/.config/chafa/chafa.conf criado"
    echo ""
}

# Atualizar configuração do Yazi para alta qualidade
update_yazi_config() {
    echo "🔧 Atualizando configuração do Yazi:"
    
    local yazi_config="/home/paulo/projetos/CrystaShell/yazi/yazi.toml"
    
    # Backup da configuração atual
    cp "$yazi_config" "${yazi_config}.backup.$(date +%Y%m%d_%H%M%S)" 2>/dev/null
    
    # Detectar se é um display de alta resolução
    if [ "$TERM_WIDTH" -gt 120 ] && [ "$TERM_HEIGHT" -gt 40 ]; then
        echo "   🖥️  Display de alta resolução detectado"
        MAX_WIDTH=1920
        MAX_HEIGHT=1080
        SIXEL_FRAC=25
        SCALE=3
    else
        echo "   📱 Display padrão detectado"
        MAX_WIDTH=1200
        MAX_HEIGHT=800
        SIXEL_FRAC=20
        SCALE=2
    fi
    
    # Atualizar configurações no arquivo
    if grep -q "max_width" "$yazi_config"; then
        sed -i "s/max_width = .*/max_width = $MAX_WIDTH/" "$yazi_config"
        sed -i "s/max_height = .*/max_height = $MAX_HEIGHT/" "$yazi_config"
        sed -i "s/image_quality = .*/image_quality = 95/" "$yazi_config"
        sed -i "s/sixel_fraction = .*/sixel_fraction = $SIXEL_FRAC/" "$yazi_config"
        sed -i "s/ueberzug_scale = .*/ueberzug_scale = $SCALE/" "$yazi_config"
        
        echo "   ✅ Configurações atualizadas:"
        echo "      - max_width: $MAX_WIDTH"
        echo "      - max_height: $MAX_HEIGHT" 
        echo "      - image_quality: 95"
        echo "      - sixel_fraction: $SIXEL_FRAC"
        echo "      - ueberzug_scale: $SCALE"
    fi
    echo ""
}

# Configurar variáveis de ambiente
configure_environment() {
    echo "🌍 Configurando variáveis de ambiente:"
    
    # Criar configuração para o shell
    cat >> ~/.zshrc << 'EOF'

# CrystaShell - Configurações de qualidade de imagem
export CHAFA_DITHER="fs"
export CHAFA_SYMBOLS="block"
export CHAFA_FILL="block"
export CHAFA_COLORS="256"
export CHAFA_WORK="9"

# Para terminals com suporte a protocolos avançados
if [ "$TERM" = "xterm-kitty" ] || echo "$TERM" | grep -q "kitty"; then
    export YAZI_IMAGE_PROTOCOL="kitty"
elif [ "$TERM_PROGRAM" = "iTerm.app" ]; then
    export YAZI_IMAGE_PROTOCOL="iterm2"
else
    export YAZI_IMAGE_PROTOCOL="sixel"
fi
EOF
    
    echo "   ✅ Variáveis adicionadas ao ~/.zshrc"
    echo ""
}

# Instalar/atualizar ferramentas de qualidade
install_quality_tools() {
    echo "📦 Verificando ferramentas de alta qualidade:"
    
    # Verificar chafa versão mais recente
    if command -v chafa >/dev/null 2>&1; then
        CHAFA_VERSION=$(chafa --version 2>/dev/null | head -1)
        echo "   ✅ Chafa: $CHAFA_VERSION"
    else
        echo "   ❌ Chafa não instalado"
        echo "      Para instalar: sudo apt install chafa"
    fi
    
    # Verificar timg
    if command -v timg >/dev/null 2>&1; then
        echo "   ✅ timg: Instalado"
    else
        echo "   ⚠️  timg não instalado (recomendado para alta qualidade)"
        echo "      Para instalar: sudo apt install timg"
    fi
    
    echo ""
}

# Testar configuração
test_image_quality() {
    echo "🧪 Testando qualidade de imagem:"
    
    # Procurar uma imagem para testar
    test_image=""
    for ext in jpg jpeg png gif; do
        test_image=$(find /home/paulo -name "*.$ext" -type f 2>/dev/null | head -1)
        if [ -n "$test_image" ]; then
            break
        fi
    done
    
    if [ -n "$test_image" ]; then
        echo "   📸 Testando com: $(basename "$test_image")"
        echo "   🔄 Executando preview..."
        
        if command -v chafa >/dev/null 2>&1; then
            chafa --fill=block --symbols=block -c 256 \
                  --dither=fs --work=9 \
                  -s "80x40" --stretch "$test_image" | head -20
        fi
        
        echo ""
        echo "   ✅ Teste concluído!"
    else
        echo "   ⚠️  Nenhuma imagem encontrada para teste"
    fi
    echo ""
}

# Menu principal
main() {
    check_protocol_support
    configure_chafa
    update_yazi_config
    configure_environment
    install_quality_tools
    test_image_quality
    
    echo "🎉 Configuração de qualidade concluída!"
    echo ""
    echo "📋 Próximos passos:"
    echo "1. Reinicie o terminal: source ~/.zshrc"
    echo "2. Execute: yazi"
    echo "3. Navegue até uma imagem para ver a melhoria"
    echo ""
    echo "⚙️  Para problemas de qualidade:"
    echo "• Verifique se seu terminal suporta 256 cores"
    echo "• Use um terminal moderno (kitty, alacritty, iterm2)"
    echo "• Instale timg para melhor qualidade: sudo apt install timg"
    echo ""
    echo "🔧 Configurações aplicadas:"
    echo "• Qualidade de imagem: 95%"
    echo "• Dithering: Floyd-Steinberg"
    echo "• Símbolos: Block characters"
    echo "• Cores: 256"
    echo "• Resolução máxima: ${MAX_WIDTH}x${MAX_HEIGHT}"
}

main "$@"
