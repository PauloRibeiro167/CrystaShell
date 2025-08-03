#!/bin/bash

# CrystaShell - Visualizador de Imagens para Terminal Linux Nativo
# Otimizado para GNOME Terminal com suporte a imagens reais

FILE_PATH="$1"
PV_WIDTH="${2:-120}"
PV_HEIGHT="${3:-40}"
IMAGE_CACHE_PATH="${4}"
PV_IMAGE_ENABLED="${5:-1}"

# Verificar se é uma imagem
if [ ! -r "$FILE_PATH" ]; then
    echo "❌ Arquivo não encontrado: $FILE_PATH"
    exit 1
fi

# Obter informações básicas
FILENAME=$(basename "$FILE_PATH")
FILESIZE=$(du -h "$FILE_PATH" 2>/dev/null | cut -f1 || echo "N/A")
TERMINAL_WIDTH=$(tput cols 2>/dev/null || echo "$PV_WIDTH")
TERMINAL_HEIGHT=$(tput lines 2>/dev/null || echo "$PV_HEIGHT")

echo "🖼️ Imagem: $FILENAME"
echo "📏 Tamanho: $FILESIZE"
echo ""

# Calcular dimensões otimizadas para o terminal
IMG_WIDTH=$((TERMINAL_WIDTH - 4))
IMG_HEIGHT=$((TERMINAL_HEIGHT - 8))

# Protocolo 1: VIU - Melhor para imagens reais no terminal
if command -v viu >/dev/null 2>&1; then
    echo "🌈 Exibindo imagem real com VIU..."
    
    # Tentar com transparência primeiro
    viu -t -w "$IMG_WIDTH" -h "$IMG_HEIGHT" --transparent "$FILE_PATH" 2>/dev/null && {
        echo ""
        echo "✅ Imagem exibida com VIU (protocolo de imagem real)"
        echo ""
        echo "📋 Informações do Arquivo:"
        echo "   📁 Nome: $FILENAME"
        echo "   📂 Diretório: $(dirname "$FILE_PATH")"
        echo "   📏 Tamanho: $FILESIZE"
        
        # Mostrar dimensões se possível
        if command -v identify >/dev/null 2>&1; then
            echo "   📐 Dimensões: $(identify -format "%wx%h" "$FILE_PATH" 2>/dev/null || echo "N/A")"
        fi
        
        echo "   🕒 Modificado: $(date -r "$FILE_PATH" '+%d/%m/%Y %H:%M' 2>/dev/null || echo "N/A")"
        echo "   🎭 Tipo: $(file --mime-type -b "$FILE_PATH" 2>/dev/null || echo "N/A")"
        exit 0
    }
    
    # Fallback sem transparência
    viu -w "$IMG_WIDTH" -h "$IMG_HEIGHT" "$FILE_PATH" 2>/dev/null && {
        echo ""
        echo "✅ Imagem exibida com VIU (fallback sem transparência)"
        exit 0
    }
fi

# Protocolo 2: CHAFA - Melhor qualidade para ASCII
if command -v chafa >/dev/null 2>&1; then
    echo "🎨 Renderizando com Chafa (alta qualidade)..."
    
    # Detectar suporte TrueColor
    if [ "$COLORTERM" = "truecolor" ] || [ "$COLORTERM" = "24bit" ]; then
        # Terminal com TrueColor
        chafa --format=symbols \
              --fill=block \
              --symbols=block+border+space+wide \
              --colors=truecolor \
              --color-space=rgb \
              --dither=fs \
              --work=9 \
              --optimize=9 \
              --preprocess=on \
              --stretch \
              --speed=1 \
              -s "${IMG_WIDTH}x${IMG_HEIGHT}" \
              "$FILE_PATH" 2>/dev/null && {
            echo ""
            echo "✅ Imagem renderizada com Chafa TrueColor"
        }
    else
        # Terminal 256 cores
        chafa --fill=block \
              --symbols=block+border+space \
              --colors=256 \
              --dither=fs \
              --work=5 \
              --optimize=5 \
              -s "${IMG_WIDTH}x${IMG_HEIGHT}" \
              "$FILE_PATH" 2>/dev/null && {
            echo ""
            echo "✅ Imagem renderizada com Chafa 256 cores"
        }
    fi
fi

# Protocolo 3: TIMG - Alternativa robusta
if command -v timg >/dev/null 2>&1; then
    echo "🖼️ Usando TIMG..."
    timg -g"${IMG_WIDTH}x${IMG_HEIGHT}" \
         --upscale=i --center --title=off "$FILE_PATH" 2>/dev/null && {
        echo ""
        echo "✅ Imagem exibida com TIMG"
    }
fi

# Protocolo 4: img2txt (caca-utils) - Fallback ASCII
if command -v img2txt >/dev/null 2>&1; then
    echo "📝 Fallback: img2txt (ASCII art)..."
    img2txt --width="$IMG_WIDTH" --height="$IMG_HEIGHT" \
            --charset=utf8 --dither=fstein "$FILE_PATH" 2>/dev/null && {
        echo ""
        echo "✅ Imagem convertida para ASCII com img2txt"
    }
fi

# Se nenhum método funcionou
echo ""
echo "❌ Nenhum visualizador de imagem funcionou"
echo ""
echo "📦 Para melhor suporte a imagens, instale:"
echo "   sudo apt install chafa"            # ASCII art de alta qualidade
echo "   cargo install viu"                 # Imagens reais no terminal
echo "   sudo apt install caca-utils"       # img2txt fallback
echo "   sudo apt install timg"             # Alternativa robusta

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
