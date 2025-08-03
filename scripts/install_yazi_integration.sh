#!/bin/bash

# Script de instalação automática da integração CrystaShell Yazi
# Este script configura tudo automaticamente

set -e

CRYSTASHELL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ZSHRC_FILE="$HOME/.zshrc"
BACKUP_FILE="$HOME/.zshrc.backup.$(date +%Y%m%d_%H%M%S)"

echo "🚀 Instalando integração CrystaShell Yazi..."
echo "📂 Diretório: $CRYSTASHELL_DIR"

# Backup do .zshrc
if [[ -f "$ZSHRC_FILE" ]]; then
    echo "📋 Fazendo backup do .zshrc para: $BACKUP_FILE"
    cp "$ZSHRC_FILE" "$BACKUP_FILE"
fi

# Verifica se a integração já existe
if grep -q "CrystaShell Yazi Integration" "$ZSHRC_FILE" 2>/dev/null; then
    echo "✅ Integração já existe no .zshrc"
else
    echo "📝 Adicionando integração ao .zshrc..."
    
    cat >> "$ZSHRC_FILE" << 'EOF'

# --- CrystaShell Yazi Integration ---
# Carrega integração automática do Yazi com configurações do CrystaShell
if [[ -f "$HOME/projetos/CrystaShell/lib/yazi_integration.zsh" ]]; then
    source "$HOME/projetos/CrystaShell/lib/yazi_integration.zsh"
elif [[ -f "$(dirname "${(%):-%x}")/lib/yazi_integration.zsh" ]]; then
    source "$(dirname "${(%):-%x}")/lib/yazi_integration.zsh"
fi
EOF

    echo "✅ Integração adicionada ao .zshrc"
fi

# Torna executável o script de configuração
chmod +x "$CRYSTASHELL_DIR/scripts/configure_icons.sh"

# Executa a configuração inicial
echo "🔧 Executando configuração inicial..."
"$CRYSTASHELL_DIR/scripts/configure_icons.sh"

echo ""
echo "🎉 Instalação concluída!"
echo ""
echo "📋 O que foi configurado:"
echo "   ✅ Backup do .zshrc criado"
echo "   ✅ Integração adicionada ao .zshrc"
echo "   ✅ Configuração de ícones aplicada"
echo "   ✅ Aliases criados (yc, yazi-cs, yazi-config, yazi-icons)"
echo ""
echo "🔄 Para aplicar as mudanças:"
echo "   source ~/.zshrc"
echo "   # ou reinicie o terminal"
echo ""
echo "🎨 Comandos disponíveis:"
echo "   yazi         - Yazi com configuração CrystaShell"
echo "   yc           - Alias curto para yazi"
echo "   yazi-config  - Editar configurações do Yazi"
echo "   yazi-icons   - Reconfigurar ícones"
echo "   yazi_status  - Ver status da configuração"
echo ""
echo "📂 Configurações em: $CRYSTASHELL_DIR/yazi/"
