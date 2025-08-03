#!/bin/bash

# Script de teste para verificar funcionamento das abas no Yazi

echo "🔖 Teste do Sistema de Abas do Yazi"
echo "=================================="
echo ""

# Verifica se os comandos estão disponíveis
echo "1. 📋 Verificando comandos disponíveis:"
echo ""

if command -v yazi-tabs >/dev/null 2>&1; then
    echo "✅ yazi-tabs        - Disponível"
else
    echo "❌ yazi-tabs        - Não encontrado"
fi

if command -v yazi_status >/dev/null 2>&1; then
    echo "✅ yazi_status      - Disponível"
else
    echo "❌ yazi_status      - Não encontrado"
fi

if command -v yazi-icons >/dev/null 2>&1; then
    echo "✅ yazi-icons       - Disponível"
else
    echo "❌ yazi-icons       - Não encontrado"
fi

if command -v yazi >/dev/null 2>&1; then
    echo "✅ yazi             - Disponível"
else
    echo "❌ yazi             - Não encontrado"
fi

echo ""
echo "2. 📁 Verificando arquivos de configuração:"
echo ""

if [[ -f "/home/paulo/projetos/CrystaShell/yazi/keymap.toml" ]]; then
    echo "✅ keymap.toml      - Existe"
else
    echo "❌ keymap.toml      - Não encontrado"
fi

if [[ -f "/home/paulo/projetos/CrystaShell/lib/yazi_integration.zsh" ]]; then
    echo "✅ yazi_integration - Existe"
else
    echo "❌ yazi_integration - Não encontrado"
fi

if [[ -f "/home/paulo/projetos/CrystaShell/yazi/TABS_GUIDE.md" ]]; then
    echo "✅ TABS_GUIDE.md    - Existe"
else
    echo "❌ TABS_GUIDE.md    - Não encontrado"
fi

echo ""
echo "3. 🔧 Verificando integração:"
echo ""

if [[ -n "$YAZI_CONFIG_HOME" ]]; then
    echo "✅ YAZI_CONFIG_HOME - Definido: $YAZI_CONFIG_HOME"
else
    echo "❌ YAZI_CONFIG_HOME - Não definido"
fi

if [[ -n "$CRYSTASHELL_DIR" ]]; then
    echo "✅ CRYSTASHELL_DIR  - Definido: $CRYSTASHELL_DIR"
else
    echo "❌ CRYSTASHELL_DIR  - Não definido"
fi

echo ""
echo "4. 🎮 Atalhos configurados no keymap.toml:"
echo ""

if [[ -f "/home/paulo/projetos/CrystaShell/yazi/keymap.toml" ]]; then
    tab_commands=$(grep -c "tab_" "/home/paulo/projetos/CrystaShell/yazi/keymap.toml")
    echo "✅ Comandos de aba configurados: $tab_commands"
    
    echo ""
    echo "📋 Principais atalhos encontrados:"
    grep -E "desc.*aba|desc.*tab" "/home/paulo/projetos/CrystaShell/yazi/keymap.toml" | head -5 | sed 's/desc = "/ - /' | sed 's/"$//'
else
    echo "❌ Não foi possível verificar atalhos"
fi

echo ""
echo "5. 🚀 Como testar as abas:"
echo ""
echo "Execute os seguintes comandos:"
echo ""
echo "  yazi                  # Abrir Yazi"
echo "  Digite 't'            # Criar nova aba"
echo "  Digite 'Tab'          # Alternar entre abas"
echo "  Digite 'Alt+1'        # Ir para aba 1"
echo "  Digite 'Alt+2'        # Ir para aba 2"
echo "  Digite 'Ctrl+W'       # Fechar aba atual"
echo ""
echo "6. 📖 Documentação:"
echo ""
echo "  yazi-tabs help        # Ver ajuda completa"
echo "  yazi-tabs list        # Listar todos os atalhos"
echo "  yazi-tabs demo        # Demonstração interativa"
echo ""

# Teste final
echo "7. 🧪 Teste rápido do Yazi:"
echo ""
echo "Executando teste de 2 segundos do Yazi..."
if timeout 2 yazi >/dev/null 2>&1; then
    echo "✅ Yazi executa sem erros!"
else
    echo "⚠️  Yazi pode ter problemas de configuração"
fi

echo ""
echo "🎉 Teste concluído!"
echo ""
echo "Se todos os itens estão marcados com ✅, o sistema de abas está funcionando!"
