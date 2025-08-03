#!/bin/bash

# CrystaShell - Script de Teste para Exibição de Imagens no Yazi
# Testa diferentes protocolos e configurações

echo "🔍 CrystaShell - Teste de Exibição de Imagens no Yazi"
echo "═══════════════════════════════════════════════════════"
echo ""

# Detectar ambiente
echo "📋 Informações do Ambiente:"
echo "   TERM: $TERM"
echo "   TERM_PROGRAM: $TERM_PROGRAM"
echo "   COLORTERM: $COLORTERM"
echo ""

# Verificar dependências
echo "🔧 Verificando Dependências:"
deps=("yazi" "chafa" "viu" "timg")
for dep in "${deps[@]}"; do
    if command -v "$dep" >/dev/null 2>&1; then
        version=$(command "$dep" --version 2>/dev/null | head -1 || echo "Disponível")
        echo "   ✅ $dep: $version"
    else
        echo "   ❌ $dep: Não encontrado"
    fi
done
echo ""

# Testar chafa específico para VS Code
echo "🎨 Testando Chafa (VS Code otimizado):"
if command -v chafa >/dev/null 2>&1; then
    # Criar uma imagem de teste simples se não existir
    test_image="/tmp/yazi_test.png"
    if ! [ -f "$test_image" ]; then
        echo "📸 Criando imagem de teste..."
        if command -v convert >/dev/null 2>&1; then
            convert -size 200x100 xc:blue -fill white -gravity center -pointsize 20 -annotate +0+0 "CrystaShell\nTeste" "$test_image"
        elif command -v magick >/dev/null 2>&1; then
            magick -size 200x100 xc:blue -fill white -gravity center -pointsize 20 -annotate +0+0 "CrystaShell\nTeste" "$test_image"
        else
            echo "   ⚠️  ImageMagick não encontrado, usando arquivo existente ou criando placeholder"
            # Criar um arquivo PNG mínimo (1x1 pixel azul)
            echo -e '\x89PNG\r\n\x1a\n\x00\x00\x00\rIHDR\x00\x00\x00\x01\x00\x00\x00\x01\x08\x02\x00\x00\x00\x90wS\xde\x00\x00\x00\x0cIDATx\x9cc\xf8\x0f\x00\x00\x01\x00\x01\x00\x18\xdd\x8d\xb4\x00\x00\x00\x00IEND\xaeB`\x82' > "$test_image"
        fi
    fi
    
    if [ -f "$test_image" ]; then
        echo "   🖼️  Testando exibição com configurações VS Code:"
        chafa --format=symbols \
              --fill=block \
              --symbols=block+border+space+wide \
              --colors=truecolor \
              --dither=fs \
              --work=9 \
              --optimize=9 \
              --preprocess=on \
              --stretch \
              --polite=on \
              -s "80x20" \
              "$test_image" 2>/dev/null || echo "   ❌ Erro ao exibir com chafa"
    else
        echo "   ❌ Não foi possível criar imagem de teste"
    fi
else
    echo "   ❌ Chafa não encontrado"
fi
echo ""

# Testar viu
echo "🌈 Testando VIU:"
if command -v viu >/dev/null 2>&1 && [ -f "/tmp/yazi_test.png" ]; then
    echo "   🖼️  Testando exibição com VIU:"
    viu -t -w 80 -h 20 --transparent "/tmp/yazi_test.png" 2>/dev/null || echo "   ❌ Erro ao exibir com viu"
else
    echo "   ❌ VIU não encontrado ou imagem de teste não disponível"
fi
echo ""

# Verificar configurações do Yazi
echo "⚙️  Verificando Configurações do Yazi:"
yazi_config="$HOME/.config/yazi/yazi.toml"
crystashell_config="/home/paulo/projetos/CrystaShell/yazi/yazi.toml"

if [ -f "$crystashell_config" ]; then
    echo "   ✅ Configuração CrystaShell encontrada: $crystashell_config"
    
    # Verificar configurações de imagem
    if grep -q "image_quality.*95" "$crystashell_config"; then
        echo "   ✅ Qualidade de imagem otimizada (95%)"
    else
        echo "   ⚠️  Qualidade de imagem não otimizada"
    fi
    
    if grep -q "image_delay.*30" "$crystashell_config"; then
        echo "   ✅ Delay de imagem configurado"
    else
        echo "   ⚠️  Delay de imagem não configurado"
    fi
else
    echo "   ❌ Configuração CrystaShell não encontrada"
fi

# Verificar script de preview
preview_script="/home/paulo/projetos/CrystaShell/scripts/yazi_preview.sh"
if [ -f "$preview_script" ] && [ -x "$preview_script" ]; then
    echo "   ✅ Script de preview encontrado e executável"
    
    # Testar script diretamente
    if [ -f "/tmp/yazi_test.png" ]; then
        echo ""
        echo "🚀 Testando Script de Preview Diretamente:"
        echo "   📁 Arquivo de teste: /tmp/yazi_test.png"
        echo ""
        "$preview_script" "/tmp/yazi_test.png" 80 20 "" 1 2>/dev/null || echo "   ❌ Erro ao executar script de preview"
    fi
else
    echo "   ❌ Script de preview não encontrado ou não executável"
fi

echo ""
echo "📋 Resumo do Teste:"
echo "═══════════════════"
echo "✅ Se você vê imagens coloridas acima, a configuração está funcionando!"
echo "⚠️  Se não vê imagens, verifique:"
echo "   1. Se está usando o Yazi dentro do diretório CrystaShell"
echo "   2. Se as configurações estão sendo carregadas corretamente"
echo "   3. Se o terminal suporta cores verdadeiras (truecolor)"
echo ""
echo "🎯 Para usar no Yazi:"
echo "   cd /home/paulo/projetos/CrystaShell"
echo "   YAZI_CONFIG_HOME=/home/paulo/projetos/CrystaShell/yazi yazi"
echo ""

# Limpar arquivo de teste
rm -f "/tmp/yazi_test.png" 2>/dev/null
