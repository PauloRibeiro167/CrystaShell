#!/bin/bash

# CrystaShell - Teste Direto de Chafa para VS Code

echo "🔍 Teste Rápido de Configurações Chafa para VS Code"
echo "═══════════════════════════════════════════════════"
echo ""

# Testar com arquivo de texto simulando imagem
echo "📝 Usando arquivo de texto como simulação..."
test_file="/home/paulo/projetos/CrystaShell/yazi/yazi.toml"

echo "🧪 Teste 1: Configuração ASCII Básica"
echo "   Comando: chafa --colors=8 --symbols=ascii --fill=space -s \"50x10\""
echo ""

echo "🧪 Teste 2: Configuração com 16 cores"
echo "   Comando: chafa --colors=16 --symbols=ascii --fill=space --dither=none -s \"50x10\""
echo ""

echo "🧪 Teste 3: Configuração com blocos simples"
echo "   Comando: chafa --colors=16 --symbols=block -s \"50x10\""
echo ""

echo "📋 Configuração Recomendada para VS Code:"
echo "chafa --colors=16 --symbols=ascii --fill=space --dither=none -s \"\${width}x\${height}\""
echo ""

echo "🚀 Para testar manualmente:"
echo "chafa --colors=16 --symbols=ascii --fill=space --dither=none -s \"40x8\" qualquer_arquivo"
