#!/bin/bash

# CrystaShell - Teste do Protocolo imgcat para VS Code

echo "🧪 Testando protocolo imgcat (iTerm2) no VS Code"
echo "═══════════════════════════════════════════════"
echo ""

# Verificar se imgcat existe
if [ ! -x "/home/paulo/projetos/CrystaShell/scripts/imgcat" ]; then
    echo "❌ Script imgcat não encontrado ou não é executável"
    exit 1
fi

echo "✅ Script imgcat encontrado"
echo ""

# Criar uma imagem de teste simples
test_img="/tmp/imgcat_test.png"
echo "📸 Criando imagem de teste..."

# Tentar criar com ImageMagick
if command -v convert >/dev/null 2>&1; then
    convert -size 100x50 \
            xc:'#ff6600' \
            -gravity center \
            -pointsize 14 \
            -fill white \
            -annotate +0+0 'IMGCAT TEST' \
            "$test_img" 2>/dev/null
elif command -v magick >/dev/null 2>&1; then
    magick -size 100x50 \
           xc:'#ff6600' \
           -gravity center \
           -pointsize 14 \
           -fill white \
           -annotate +0+0 'IMGCAT TEST' \
           "$test_img" 2>/dev/null
else
    # Criar um PNG mínimo
    printf '\x89PNG\r\n\x1a\n\x00\x00\x00\rIHDR\x00\x00\x00\x10\x00\x00\x00\x10\x08\x02\x00\x00\x00\x90\x91h6\x00\x00\x00\x18IDATx\x9cc\xf8\x0f\x00\x01\x01\x01\x00\x18\xdd\x8d\xb4\x00\x00\x00\x00IEND\xaeB`\x82' > "$test_img"
fi

if [ -f "$test_img" ]; then
    echo "✅ Imagem de teste criada: $test_img"
    echo ""
    
    echo "🚀 Testando imgcat com diferentes configurações:"
    echo ""
    
    # Teste 1: Configuração básica
    echo "📋 Teste 1: Configuração básica"
    echo "Comando: imgcat -W 40 -H 10 -r"
    /home/paulo/projetos/CrystaShell/scripts/imgcat -W 40 -H 10 -r "$test_img"
    echo ""
    
    # Teste 2: Configuração menor
    echo "📋 Teste 2: Configuração menor"
    echo "Comando: imgcat -W 30 -H 8"
    /home/paulo/projetos/CrystaShell/scripts/imgcat -W 30 -H 8 "$test_img"
    echo ""
    
    # Teste 3: Configuração percentual
    echo "📋 Teste 3: Configuração percentual"
    echo "Comando: imgcat -W 50% -H 30%"
    /home/paulo/projetos/CrystaShell/scripts/imgcat -W 50% -H 30% "$test_img"
    echo ""
    
    # Teste 4: Auto dimensioning
    echo "📋 Teste 4: Dimensões automáticas"
    echo "Comando: imgcat (sem parâmetros de tamanho)"
    /home/paulo/projetos/CrystaShell/scripts/imgcat "$test_img"
    echo ""
    
else
    echo "❌ Não foi possível criar imagem de teste"
    echo "🔍 Testando com arquivo existente..."
    
    # Usar um arquivo do sistema se existir
    if [ -f "/usr/share/pixmaps/debian-logo.png" ]; then
        test_img="/usr/share/pixmaps/debian-logo.png"
        echo "✅ Usando: $test_img"
        /home/paulo/projetos/CrystaShell/scripts/imgcat -W 30 -H 15 "$test_img"
    else
        echo "❌ Nenhuma imagem de teste disponível"
    fi
fi

echo ""
echo "📊 Resultados:"
echo "══════════════"
echo "Se você vê imagens acima (não apenas texto), o protocolo imgcat está funcionando!"
echo "Se vê apenas texto ou erro, o VS Code pode não suportar o protocolo iTerm2."
echo ""
echo "📝 Para usar no Yazi:"
echo "   cd /home/paulo/projetos/CrystaShell"
echo "   YAZI_CONFIG_HOME=\"/home/paulo/projetos/CrystaShell/yazi\" yazi"
echo ""

# Limpeza
rm -f "$test_img" 2>/dev/null
