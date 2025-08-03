#!/bin/bash

# CrystaShell - Teste Específico para VS Code Terminal
# Testa diferentes configurações de chafa para encontrar a melhor

echo "🔍 Testando Configurações de Imagem para VS Code"
echo "═══════════════════════════════════════════════════"
echo ""

# Criar uma imagem de teste colorida usando ImageMagick
test_img="/tmp/vscode_test.png"
if command -v convert >/dev/null 2>&1; then
    echo "📸 Criando imagem de teste com ImageMagick..."
    convert -size 80x40 \
            -background '#0066cc' \
            -fill white \
            -gravity center \
            -pointsize 16 \
            -annotate +0-5 'VS CODE' \
            -annotate +0+10 'TEST' \
            "$test_img"
elif command -v magick >/dev/null 2>&1; then
    echo "📸 Criando imagem de teste com Magick..."
    magick -size 80x40 \
           -background '#0066cc' \
           -fill white \
           -gravity center \
           -pointsize 16 \
           -annotate +0-5 'VS CODE' \
           -annotate +0+10 'TEST' \
           "$test_img"
else
    echo "⚠️  ImageMagick não encontrado, usando arquivo existente ou texto"
    test_img="dummy"
fi

if [ -f "$test_img" ]; then
    echo "✅ Imagem de teste criada: $test_img"
    echo ""
    
    # Teste 1: Configuração MUITO conservadora
    echo "🧪 Teste 1: ULTRA Conservador (ASCII puro)"
    chafa --colors=8 --symbols=ascii --fill=space -s "60x12" "$test_img" 2>/dev/null || echo "❌ Falhou"
    echo ""
    
    # Teste 2: Configuração conservadora
    echo "🧪 Teste 2: Conservador (16 cores)"
    chafa --colors=16 --symbols=ascii --fill=space --dither=none -s "60x12" "$test_img" 2>/dev/null || echo "❌ Falhou"
    echo ""
    
    # Teste 3: Configuração média
    echo "🧪 Teste 3: Moderado (256 cores)"
    chafa --colors=256 --symbols=block --fill=space -s "60x12" "$test_img" 2>/dev/null || echo "❌ Falhou"
    echo ""
    
    # Teste 4: Apenas blocos simples
    echo "🧪 Teste 4: Blocos Simples"
    chafa --colors=16 --symbols=block -s "60x12" "$test_img" 2>/dev/null || echo "❌ Falhou"
    echo ""
    
    # Teste 5: Mínimo absoluto
    echo "🧪 Teste 5: Mínimo Absoluto"
    chafa --colors=2 --symbols=ascii -s "40x8" "$test_img" 2>/dev/null || echo "❌ Falhou"
    
else
    echo "❌ Não foi possível criar imagem de teste"
fi

echo ""
echo "📋 Recomendação:"
echo "Use a configuração que mostrou melhor resultado acima"
echo "A configuração será aplicada automaticamente no Yazi"

# Limpar
rm -f "$test_img" 2>/dev/null
