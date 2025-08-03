#!/bin/bash

# Script de verificação da integração CrystaShell Yazi
# Verifica se tudo está configurado e funcionando corretamente

echo "🔍 Verificando integração CrystaShell + Yazi..."
echo ""

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Função para verificar status
check_status() {
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ $1${NC}"
    else
        echo -e "${RED}❌ $1${NC}"
    fi
}

# 1. Verificar se o CrystaShell existe
echo "📂 Verificando estrutura do CrystaShell..."
CRYSTASHELL_DIR="$HOME/projetos/CrystaShell"
if [[ -d "$CRYSTASHELL_DIR" ]]; then
    echo -e "${GREEN}✅ Diretório CrystaShell encontrado: $CRYSTASHELL_DIR${NC}"
else
    echo -e "${RED}❌ Diretório CrystaShell não encontrado${NC}"
    exit 1
fi

# 2. Verificar arquivos de integração
echo ""
echo "📋 Verificando arquivos de integração..."

files=(
    "lib/yazi_integration.zsh"
    "scripts/configure_icons.sh"
    "scripts/install_yazi_integration.sh"
    ".vscode/settings.json"
    "yazi/theme.lua"
    "yazi/yazi.lua"
)

for file in "${files[@]}"; do
    if [[ -f "$CRYSTASHELL_DIR/$file" ]]; then
        echo -e "${GREEN}✅ $file${NC}"
    else
        echo -e "${RED}❌ $file${NC}"
    fi
done

# 3. Verificar integração no .zshrc
echo ""
echo "🔧 Verificando integração no .zshrc..."
if grep -q "CrystaShell Yazi Integration" "$HOME/.zshrc" 2>/dev/null; then
    echo -e "${GREEN}✅ Integração encontrada no .zshrc${NC}"
else
    echo -e "${YELLOW}⚠️  Integração não encontrada no .zshrc${NC}"
    echo "   Execute: ./scripts/install_yazi_integration.sh"
fi

# 4. Verificar fontes Nerd Font
echo ""
echo "🎨 Verificando fontes Nerd Font..."
nerd_fonts=$(fc-list | grep -i "nerd" | wc -l)
if [ "$nerd_fonts" -gt 0 ]; then
    echo -e "${GREEN}✅ $nerd_fonts variantes de Nerd Fonts encontradas${NC}"
    echo "   Principais fontes:"
    fc-list | grep -i "jetbrains.*nerd" | head -3 | cut -d: -f2 | sed 's/^/   - /'
else
    echo -e "${RED}❌ Nenhuma Nerd Font encontrada${NC}"
    echo "   Instale com: sudo apt install fonts-firacode"
fi

# 5. Verificar VS Code settings
echo ""
echo "📝 Verificando configurações do VS Code..."
if [[ -f "$CRYSTASHELL_DIR/.vscode/settings.json" ]]; then
    if grep -q "JetBrainsMono NF" "$CRYSTASHELL_DIR/.vscode/settings.json"; then
        echo -e "${GREEN}✅ Configurações de fonte do VS Code corretas${NC}"
    else
        echo -e "${YELLOW}⚠️  Configurações de fonte podem estar incorretas${NC}"
    fi
    
    if grep -q "material-icon-theme" "$CRYSTASHELL_DIR/.vscode/settings.json"; then
        echo -e "${GREEN}✅ Tema de ícones configurado${NC}"
    else
        echo -e "${YELLOW}⚠️  Tema de ícones não configurado${NC}"
    fi
else
    echo -e "${RED}❌ Arquivo settings.json não encontrado${NC}"
fi

# 6. Verificar se Yazi está instalado
echo ""
echo "🚀 Verificando instalação do Yazi..."
if command -v yazi >/dev/null 2>&1; then
    yazi_version=$(yazi --version 2>/dev/null | head -1)
    echo -e "${GREEN}✅ Yazi instalado: $yazi_version${NC}"
else
    echo -e "${RED}❌ Yazi não está instalado${NC}"
    echo "   Instale com: cargo install --locked yazi-fm yazi-cli"
fi

# 7. Teste da integração
echo ""
echo "🧪 Testando integração..."
if source "$CRYSTASHELL_DIR/lib/yazi_integration.zsh" 2>/dev/null; then
    echo -e "${GREEN}✅ Arquivo de integração carrega sem erros${NC}"
    
    if command -v yazi_crystashell >/dev/null 2>&1; then
        echo -e "${GREEN}✅ Função yazi_crystashell disponível${NC}"
    else
        echo -e "${RED}❌ Função yazi_crystashell não encontrada${NC}"
    fi
    
    if [[ -n "$YAZI_CONFIG_HOME" ]]; then
        echo -e "${GREEN}✅ YAZI_CONFIG_HOME definido: $YAZI_CONFIG_HOME${NC}"
    else
        echo -e "${RED}❌ YAZI_CONFIG_HOME não definido${NC}"
    fi
else
    echo -e "${RED}❌ Erro ao carregar integração${NC}"
fi

# 8. Resumo final
echo ""
echo "📊 Resumo da Verificação:"
echo "========================"

# Conta sucessos
success_count=0
total_checks=8

if [[ -d "$CRYSTASHELL_DIR" ]]; then ((success_count++)); fi
if [[ -f "$CRYSTASHELL_DIR/lib/yazi_integration.zsh" ]]; then ((success_count++)); fi
if grep -q "CrystaShell Yazi Integration" "$HOME/.zshrc" 2>/dev/null; then ((success_count++)); fi
if [ "$nerd_fonts" -gt 0 ]; then ((success_count++)); fi
if [[ -f "$CRYSTASHELL_DIR/.vscode/settings.json" ]]; then ((success_count++)); fi
if command -v yazi >/dev/null 2>&1; then ((success_count++)); fi

percentage=$((success_count * 100 / total_checks))

if [ "$percentage" -ge 80 ]; then
    echo -e "${GREEN}🎉 Status: EXCELENTE ($success_count/$total_checks checks passou)${NC}"
    echo -e "${GREEN}   A integração está funcionando corretamente!${NC}"
elif [ "$percentage" -ge 60 ]; then
    echo -e "${YELLOW}⚠️  Status: BOM ($success_count/$total_checks checks passou)${NC}"
    echo -e "${YELLOW}   Algumas configurações podem precisar de ajuste${NC}"
else
    echo -e "${RED}❌ Status: PRECISA DE ATENÇÃO ($success_count/$total_checks checks passou)${NC}"
    echo -e "${RED}   Execute: ./scripts/install_yazi_integration.sh${NC}"
fi

echo ""
echo "🎯 Para usar:"
echo "   source ~/.zshrc    # Recarregar configurações"
echo "   yazi               # Usar com configurações CrystaShell"
echo "   yazi_status        # Ver status detalhado"
