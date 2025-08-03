#!/bin/bash

# CrystaShell - Visualizador de Imagens para VS Code Terminal
# Otimizado especificamente para limitações do VS Code

FILE_PATH="$1"
PV_WIDTH="${2:-80}"
PV_HEIGHT="${3:-24}"

# Verificar se é uma imagem
if [ ! -r "$FILE_PATH" ]; then
    echo "❌ Arquivo não encontrado: $FILE_PATH"
    exit 1
fi

# Obter informações básicas
FILENAME=$(basename "$FILE_PATH")
FILESIZE=$(du -h "$FILE_PATH" 2>/dev/null | cut -f1 || echo "N/A")

echo "🖼️ Visualizando: $FILENAME"
echo "📏 Tamanho: $FILESIZE"
echo ""

# Configurações conservadoras para VS Code
VS_WIDTH=$((PV_WIDTH - 4))
VS_HEIGHT=$((PV_HEIGHT - 6))

# Tentar diferentes métodos em ordem de preferência
if command -v chafa >/dev/null 2>&1; then
    echo "🎨 Renderizando com Chafa..."
    
    # Método 1: ASCII básico (mais compatível)
    chafa --colors=16 \
          --symbols=ascii \
          --fill=space \
          --dither=none \
          --glyph-file= \
          -s "${VS_WIDTH}x${VS_HEIGHT}" \
          "$FILE_PATH" 2>/dev/null || {
        
        # Método 2: Ainda mais simples
        chafa --colors=8 \
              --symbols=ascii \
              -s "40x12" \
              "$FILE_PATH" 2>/dev/null || {
            
            # Método 3: Mínimo absoluto
            chafa --colors=2 \
                  --symbols=ascii \
                  -s "30x8" \
                  "$FILE_PATH" 2>/dev/null || {
                echo "❌ Chafa falhou com todos os métodos"
            }
        }
    }
    
elif command -v viu >/dev/null 2>&1; then
    echo "🌈 Renderizando com VIU..."
    viu -t -w "$VS_WIDTH" -h "$VS_HEIGHT" --transparent "$FILE_PATH" 2>/dev/null || {
        echo "❌ VIU falhou"
    }
    
elif command -v img2txt >/dev/null 2>&1; then
    echo "📝 Renderizando com img2txt..."
    img2txt --width="$VS_WIDTH" --height="$VS_HEIGHT" --charset=ascii "$FILE_PATH" 2>/dev/null || {
        echo "❌ img2txt falhou"
    }
    
else
    echo "❌ Nenhum visualizador de imagem encontrado"
    echo ""
    echo "📦 Instale um dos seguintes:"
    echo "   sudo apt install chafa"
    echo "   cargo install viu"
    echo "   sudo apt install caca-utils"
fi

echo ""
echo "📋 Informações do Arquivo:"
echo "   📁 Nome: $FILENAME"
echo "   📂 Diretório: $(dirname "$FILE_PATH")"
echo "   📏 Tamanho: $FILESIZE"

# Mostrar metadados se possível
if command -v identify >/dev/null 2>&1; then
    echo "   📐 Dimensões: $(identify -format "%wx%h" "$FILE_PATH" 2>/dev/null || echo "N/A")"
elif command -v file >/dev/null 2>&1; then
    file_info=$(file "$FILE_PATH" 2>/dev/null)
    if echo "$file_info" | grep -q "x"; then
        dimensions=$(echo "$file_info" | grep -o '[0-9]*x[0-9]*' | head -1)
        echo "   📐 Dimensões: $dimensions"
    fi
fi

echo "   🕒 Modificado: $(date -r "$FILE_PATH" '+%d/%m/%Y %H:%M' 2>/dev/null || echo "N/A")"
echo "   🎭 Tipo: $(file --mime-type -b "$FILE_PATH" 2>/dev/null || echo "N/A")"
