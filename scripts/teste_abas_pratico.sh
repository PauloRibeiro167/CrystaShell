#!/bin/bash

# Teste Prático do Sistema de Abas do Yazi
# Execute este script para testar as funcionalidades

echo "🔖 Teste Prático - Sistema de Abas do Yazi"
echo "=========================================="
echo ""
echo "📋 Instruções para testar as abas:"
echo ""
echo "1. 🚀 Abrir Yazi:"
echo "   yazi"
echo ""
echo "2. 📝 Criar nova aba:"
echo "   Pressione: t"
echo "   (ou Ctrl+N)"
echo ""
echo "3. 🔄 Navegar entre abas:"
echo "   Tab        - Próxima aba"
echo "   Shift+Tab  - Aba anterior"
echo "   Ctrl+→/←   - Setas direcionais"
echo ""
echo "4. 🎯 Ir direto para uma aba:"
echo "   Alt+1      - Aba 1"
echo "   Alt+2      - Aba 2"
echo "   Alt+3-9    - Abas 3-9"
echo ""
echo "5. ❌ Fechar aba:"
echo "   Ctrl+W     - Fechar aba atual"
echo ""
echo "6. 📝 Estilo Vim:"
echo "   gt         - Próxima aba"
echo "   gT         - Aba anterior"
echo "   g1, g2...  - Ir para aba específica"
echo ""
echo "🧪 Sequência de teste recomendada:"
echo "1. yazi"
echo "2. Pressione 't' (criar aba)"
echo "3. Navegue para outro diretório"
echo "4. Pressione 't' novamente (criar segunda aba)"
echo "5. Pressione 'Tab' para alternar"
echo "6. Pressione 'Alt+1' para ir à primeira aba"
echo "7. Pressione 'Ctrl+W' para fechar"
echo ""
echo "✨ Dica: As abas aparecem na parte superior do Yazi!"
echo ""

# Verificar se a configuração está carregada
if [ -f "/home/paulo/projetos/CrystaShell/yazi/keymap.toml" ]; then
    echo "✅ Configuração encontrada e carregada"
    atalhos=$(grep -c "prepend_keymap" /home/paulo/projetos/CrystaShell/yazi/keymap.toml)
    echo "📋 Atalhos configurados: $atalhos"
else
    echo "❌ Configuração não encontrada"
fi

echo ""
echo "🎯 Para iniciar o teste, execute:"
echo "   yazi"
