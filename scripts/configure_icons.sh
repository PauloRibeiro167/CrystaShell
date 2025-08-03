#!/bin/bash

# Script para configurar fontes Nerd Font no sistema
# Para uso com CrystaShell e Yazi
# Suporte universal para diferentes ambientes

# Detecta o diretório do CrystaShell
CRYSTASHELL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
VSCODE_SETTINGS="$CRYSTASHELL_DIR/.vscode/settings.json"

# Função para aplicar configurações do VS Code
apply_vscode_config() {
    if [[ -f "$VSCODE_SETTINGS" ]]; then
        echo "� Aplicando configurações do VS Code..."
        
        # Extrai a fonte do settings.json
        local font_family=$(grep -o '"editor.fontFamily":[^,]*' "$VSCODE_SETTINGS" 2>/dev/null | cut -d'"' -f4)
        
        if [[ -n "$font_family" ]]; then
            echo "✅ Fonte detectada no VS Code: $font_family"
            export YAZI_FONT="$font_family"
        fi
    fi
}

# Função para detectar e configurar terminal
configure_terminal() {
    local font_name="${1:-JetBrainsMono NF 12}"
    
    if [[ "$XDG_CURRENT_DESKTOP" =~ GNOME|gnome ]]; then
        echo "🔧 Configurando GNOME Terminal..."
        gsettings set org.gnome.desktop.interface monospace-font-name "$font_name"
        echo "✅ GNOME Terminal configurado!"
        
    elif [[ "$XDG_CURRENT_DESKTOP" =~ KDE|kde ]] || [[ "$DESKTOP_SESSION" =~ kde ]]; then
        echo "🔧 Configurando KDE Konsole..."
        # Tenta configurar Konsole via dconf se disponível
        if command -v dconf >/dev/null 2>&1; then
            dconf write /org/kde/konsole/profiles/0/font "'$font_name'" 2>/dev/null || true
        fi
        echo "   Sugerido: Verifique as configurações do Konsole manualmente"
        
    elif [[ "$XDG_CURRENT_DESKTOP" =~ XFCE|xfce ]]; then
        echo "🔧 Para XFCE Terminal, configure manualmente:"
        echo "   Terminal → Preferências → Aparência → Fonte: $font_name"
        
    elif [[ -n "$TMUX" ]]; then
        echo "🔧 Detectado TMUX - configurando via escape sequences..."
        printf '\033]10;%s\007' "$font_name"
        
    else
        echo "🔧 Terminal: ${TERM_PROGRAM:-$TERM}"
        echo "   Configure manualmente para usar: $font_name"
    fi
}

echo "🚀 Configurando suporte a ícones para Yazi..."
echo "📂 CrystaShell Directory: $CRYSTASHELL_DIR"

# Aplica configurações do VS Code
apply_vscode_config

# Configura o terminal
configure_terminal

# Verifica se as fontes estão instaladas
echo ""
echo "🔍 Verificando fontes Nerd Font instaladas..."
nerd_fonts=$(fc-list | grep -i "nerd" | wc -l)

if [ "$nerd_fonts" -gt 0 ]; then
    echo "✅ Encontradas $nerd_fonts variantes de Nerd Fonts"
    echo ""
    echo "📋 Fontes disponíveis:"
    fc-list | grep -i "nerd" | head -5 | cut -d: -f2 | sed 's/^/   - /'
    
    # Exporta variáveis de ambiente para Yazi
    export YAZI_CONFIG_HOME="$CRYSTASHELL_DIR/yazi"
    export YAZI_USE_NERDFONT=1
    
else
    echo "❌ Nenhuma Nerd Font encontrada!"
    echo ""
    echo "📥 Para instalar, execute:"
    echo "   sudo apt install fonts-firacode fonts-noto-color-emoji"
    echo "   # ou baixe de: https://www.nerdfonts.com/"
    exit 1
fi

# Cria aliases para facilitar o uso
echo ""
echo "🔗 Configurando aliases..."

# Função para Yazi com configuração automática
yazi_crystashell() {
    # Aplica configurações automaticamente
    export YAZI_CONFIG_HOME="$CRYSTASHELL_DIR/yazi"
    
    # Executa Yazi com as configurações do CrystaShell
    command yazi "$@"
}

# Exporta a função
export -f yazi_crystashell 2>/dev/null || true

echo "✅ Função yazi_crystashell configurada"
echo ""
echo "🎨 Para testar os ícones, execute: yazi_crystashell"
echo "📝 Configurações do VS Code estão em: .vscode/settings.json"
echo "📂 Configurações do Yazi estão em: $CRYSTASHELL_DIR/yazi/"

# Salva configurações em arquivo temporário para sourcing
cat > "/tmp/crystashell_yazi_config.sh" << EOF
# CrystaShell Yazi Configuration
export CRYSTASHELL_DIR="$CRYSTASHELL_DIR"
export YAZI_CONFIG_HOME="$CRYSTASHELL_DIR/yazi"
export YAZI_USE_NERDFONT=1

yazi_crystashell() {
    export YAZI_CONFIG_HOME="$CRYSTASHELL_DIR/yazi"
    command yazi "\$@"
}

# Alias para facilitar
alias yc='yazi_crystashell'
alias yazi-cs='yazi_crystashell'
EOF

echo ""
echo "💡 Para usar permanentemente, adicione ao seu ~/.zshrc:"
echo "   source /tmp/crystashell_yazi_config.sh"
