#!/bin/bash
# CrystaShell - Script de preview INTELIGENTE para terminais GNOME/VS Code
# Foca em informações úteis + preview básico + ações rápidas

file="$1"
width="$2"
height="$3"
x="$4"
y="$5"

# Função para mostrar informações da imagem
show_image_info() {
    local file="$1"
    local filename=$(basename "$file")
    local filesize=$(du -h "$file" 2>/dev/null | cut -f1)
    local mimetype=$(file -b --mime-type "$file" 2>/dev/null)
    
    # Usar identify do ImageMagick para informações detalhadas
    if command -v identify >/dev/null 2>&1; then
        local imageinfo=$(identify "$file" 2>/dev/null)
        local dimensions=$(echo "$imageinfo" | awk '{print $3}')
        local format=$(echo "$imageinfo" | awk '{print $2}')
        local colorspace=$(echo "$imageinfo" | grep -o '[0-9]*-bit' | head -1)
    fi
    
    # Cabeçalho estilizado
    echo "╭─────────────────────────────────────────╮"
    echo "│  🖼️  PREVIEW DE IMAGEM - CrystaShell    │"
    echo "├─────────────────────────────────────────┤"
    echo "│ 📁 Arquivo: ${filename:0:30}$([ ${#filename} -gt 30 ] && echo '...')"
    echo "│ 📏 Tamanho: $filesize"
    echo "│ 🎨 Formato: ${format:-"N/A"}"
    echo "│ 📐 Dimensões: ${dimensions:-"N/A"}"
    echo "│ 🌈 Cores: ${colorspace:-"N/A"}"
    echo "│ 🔍 MIME: $mimetype"
    echo "├─────────────────────────────────────────┤"
    echo "│ ⚡ AÇÕES RÁPIDAS:                        │"
    echo "│ • ENTER = Abrir no visualizador padrão  │"
    echo "│ • 'o' = Menu de opções                  │"
    echo "│ • 'i' = Informações EXIF               │"
    echo "╰─────────────────────────────────────────╯"
    echo ""
}

# Função para preview básico ASCII
show_ascii_preview() {
    local file="$1"
    local w="$2"
    local h="$3"
    
    # Usar timg se disponível (melhor resultado)
    if command -v timg >/dev/null 2>&1; then
        echo "┌─ PREVIEW ASCII (timg) ─┐"
        timg -g "${w}x$((h-10))" --center "$file" 2>/dev/null || true
        echo "└────────────────────────┘"
    # Fallback para chafa simples
    elif command -v chafa >/dev/null 2>&1; then
        echo "┌─ PREVIEW ASCII (chafa) ─┐"
        chafa --size="$((w-4))x$((h-15))" --colors=16 --symbols=ascii "$file" 2>/dev/null || true
        echo "└─────────────────────────┘"
    else
        echo "┌─ SEM PREVIEW ASCII ─┐"
        echo "│ Instale 'timg' ou   │"
        echo "│ 'chafa' para preview│"
        echo "└─────────────────────┘"
    fi
}

# Verifica se é uma imagem
if [[ $(file -b --mime-type "$file" 2>/dev/null) == image/* ]]; then
    # Mostrar informações detalhadas
    show_image_info "$file"
    
    # Se o terminal for grande o suficiente, mostrar preview ASCII
    if [ "$height" -gt 20 ] && [ "$width" -gt 60 ]; then
        show_ascii_preview "$file" "$width" "$height"
    fi
    
    echo ""
    echo "💡 DICA: Para melhor qualidade, use:"
    echo "   • Kitty terminal + protocolo kitty graphics"
    echo "   • iTerm2 (macOS) + protocolo imgcat"
    echo "   • WezTerm + protocolo sixel"
    echo ""
    echo "🚀 ALTERNATIVA: Pressione ENTER para abrir em visualizador externo!"
    
else
    # Não é uma imagem - usar preview padrão
    exit 1
fi
