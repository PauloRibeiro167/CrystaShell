#!/bin/bash

# CrystaShell - Script de Preview Avançado para Yazi
# Suporte a imagens, PDFs, vídeos e tratamento de erros

set -C -f
IFS="$(printf '%b_' '\n')"; IFS="${IFS%_}"

# Variáveis
FILE_PATH="${1}"
PV_WIDTH="${2:-80}"
PV_HEIGHT="${3:-24}"
IMAGE_CACHE_PATH="${4}"
PV_IMAGE_ENABLED="${5:-1}"

# Função para exibir erro formatado
show_error() {
    local extension="$1"
    local reason="$2"
    echo "┌─────────────────────────────────────────┐"
    echo "│               ❌ ERRO                   │"
    echo "├─────────────────────────────────────────┤"
    echo "│ Não é possível visualizar arquivos      │"
    echo "│ com extensão: .$extension               │"
    echo "│                                         │"
    echo "│ Motivo: $reason"
    echo "│                                         │"
    echo "│ 💡 Dicas:                               │"
    echo "│ • Instale visualizadores apropriados   │"
    echo "│ • Use 'Enter' para abrir externamente  │"
    echo "│ • Verifique permissões do arquivo      │"
    echo "└─────────────────────────────────────────┘"
}

# Função para exibir informações do arquivo
show_file_info() {
    local file="$1"
    echo "📄 Informações do Arquivo"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "📁 Nome: $(basename "$file")"
    echo "📂 Diretório: $(dirname "$file")"
    echo "📏 Tamanho: $(du -h "$file" 2>/dev/null | cut -f1 || echo "N/A")"
    echo "🕒 Modificado: $(date -r "$file" 2>/dev/null || echo "N/A")"
    echo "🔐 Permissões: $(ls -la "$file" 2>/dev/null | cut -d' ' -f1 || echo "N/A")"
    echo "🎭 Tipo MIME: $(file --mime-type -b "$file" 2>/dev/null || echo "N/A")"
    echo ""
}

# Verificar se o arquivo existe
if [ ! -r "$FILE_PATH" ]; then
    echo "❌ Erro: Arquivo não encontrado ou sem permissão de leitura"
    echo "📁 Caminho: $FILE_PATH"
    exit 1
fi

# Obter extensão do arquivo
FILE_EXTENSION="${FILE_PATH##*.}"
FILE_EXTENSION_LOWER="$(echo "$FILE_EXTENSION" | tr '[:upper:]' '[:lower:]')"

# Obter tipo MIME
MIMETYPE="$(file --mime-type -b "$FILE_PATH" 2>/dev/null)"

case "$FILE_EXTENSION_LOWER" in
    # Imagens
    jpg|jpeg|png|gif|bmp|tiff|tif|webp|svg|ico)
        # Detectar terminal e configurar protocolo adequado
        TERM_WIDTH=$(tput cols 2>/dev/null || echo "$PV_WIDTH")
        TERM_HEIGHT=$(tput lines 2>/dev/null || echo "$PV_HEIGHT")
        
        # Configurações otimizadas para VS Code terminal
        if [ "$TERM_PROGRAM" = "vscode" ]; then
            # VS Code terminal - tentar imgcat primeiro
            QUALITY_WIDTH=$((TERM_WIDTH - 2))
            QUALITY_HEIGHT=$((TERM_HEIGHT - 5))
            
            echo "�️ 🚀 VS CODE com protocolo iTerm2 (${QUALITY_WIDTH}x${QUALITY_HEIGHT})"
            echo ""
            
            # 1. Tentar imgcat primeiro (protocolo iTerm2 funciona no VS Code)
            if [ -x "/home/paulo/projetos/CrystaShell/scripts/imgcat" ]; then
                echo "� Usando protocolo iTerm2 inline..."
                /home/paulo/projetos/CrystaShell/scripts/imgcat \
                    -W "${QUALITY_WIDTH}" \
                    -H "${QUALITY_HEIGHT}" \
                    -r \
                    "$FILE_PATH" 2>/dev/null && {
                    echo ""
                    show_file_info "$FILE_PATH"
                    return 0
                }
                echo "⚠️  Protocolo iTerm2 falhou, usando fallback..."
            fi
            
            # 2. Fallback para chafa conservador
            if command -v chafa >/dev/null 2>&1; then
                # Configuração conservadora para VS Code - ASCII básico
                chafa --format=symbols \
                      --fill=space \
                      --symbols=ascii \
                      --colors=16 \
                      --dither=none \
                      --work=1 \
                      --optimize=1 \
                      --clear \
                      -s "${QUALITY_WIDTH}x${QUALITY_HEIGHT}" \
                      "$FILE_PATH" 2>/dev/null || {
                    # Fallback ainda mais simples
                    chafa --colors=8 \
                          --symbols=ascii \
                          --fill=space \
                          -s "30x10" \
                          "$FILE_PATH" 2>/dev/null
                }
            elif command -v viu >/dev/null 2>&1; then
                viu -t -w "$QUALITY_WIDTH" -h "$QUALITY_HEIGHT" \
                    --transparent "$FILE_PATH" 2>/dev/null
            elif command -v timg >/dev/null 2>&1; then
                timg -g"${QUALITY_WIDTH}x${QUALITY_HEIGHT}" \
                     --upscale=i --center --title=off "$FILE_PATH"
            else
                show_file_info "$FILE_PATH"
                show_error "$FILE_EXTENSION_LOWER" "Instale: chafa, viu ou timg"
                return 1
            fi
        else
            # Outros terminais (iTerm2, etc.)
            if [ "$TERM_WIDTH" -gt 200 ] && [ "$TERM_HEIGHT" -gt 60 ]; then
                QUALITY_WIDTH=$((TERM_WIDTH * 2))
                QUALITY_HEIGHT=$((TERM_HEIGHT * 2))
                QUALITY_MODE="� ULTRA 4K"
            elif [ "$TERM_WIDTH" -gt 150 ] && [ "$TERM_HEIGHT" -gt 50 ]; then
                QUALITY_WIDTH=$((TERM_WIDTH * 2))
                QUALITY_HEIGHT=$((TERM_HEIGHT * 2))
                QUALITY_MODE="💎 ULTRA 2K"
            else
                QUALITY_WIDTH=$((TERM_WIDTH - 2))
                QUALITY_HEIGHT=$((TERM_HEIGHT - 5))
                QUALITY_MODE="⚡ OPTIMIZED"
            fi
            
            echo "🖼️ $QUALITY_MODE (${QUALITY_WIDTH}x${QUALITY_HEIGHT})"
            echo ""
            
            # Tentar viu primeiro para terminais que suportam protocolo avançado
            if command -v viu >/dev/null 2>&1; then
                viu -t -w "$QUALITY_WIDTH" -h "$QUALITY_HEIGHT" \
                    --transparent "$FILE_PATH" 2>/dev/null && {
                    echo ""
                    show_file_info "$FILE_PATH"
                    return 0
                }
            fi
            
            # Fallback para chafa
            if command -v chafa >/dev/null 2>&1; then
                chafa --fill=block \
                      --symbols=block+border+space+wide \
                      --colors=truecolor \
                      --dither=fs \
                      --work=9 \
                      --optimize=9 \
                      --preprocess=on \
                      --stretch \
                      --speed=1 \
                      -s "${QUALITY_WIDTH}x${QUALITY_HEIGHT}" \
                      "$FILE_PATH"
            elif command -v timg >/dev/null 2>&1; then
                timg -g"${QUALITY_WIDTH}x${QUALITY_HEIGHT}" \
                     --upscale=i --center "$FILE_PATH"
            else
                show_file_info "$FILE_PATH"
                show_error "$FILE_EXTENSION_LOWER" "Instale: chafa, viu ou timg"
                return 1
            fi
        fi
        
        echo ""
        show_file_info "$FILE_PATH"
        ;;
    
    # PDFs
    pdf)
        if command -v pdftotext >/dev/null 2>&1; then
            echo "📄 Preview do PDF (primeira página)"
            echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
            pdftotext -l 1 -nopgbrk -q "$FILE_PATH" - | head -n "$PV_HEIGHT"
            echo ""
            echo "📊 Informações do PDF:"
            pdfinfo "$FILE_PATH" 2>/dev/null | head -10
        elif command -v mutool >/dev/null 2>&1; then
            echo "📄 Preview do PDF"
            echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
            mutool draw -F txt -o - "$FILE_PATH" 1 | head -n "$PV_HEIGHT"
        else
            show_file_info "$FILE_PATH"
            show_error "pdf" "Instale: poppler-utils ou mupdf-tools"
        fi
        ;;
    
    # Vídeos
    mp4|mkv|avi|mov|wmv|flv|webm|m4v|3gp)
        if command -v ffprobe >/dev/null 2>&1; then
            echo "🎬 Informações do Vídeo"
            echo "━━━━━━━━━━━━━━━━━━━━━━━━━━"
            ffprobe -v quiet -print_format json -show_format -show_streams "$FILE_PATH" 2>/dev/null | \
            jq -r '
                .format.duration as $duration |
                .format.size as $size |
                .streams[] | select(.codec_type=="video") |
                "🎥 Codec: \(.codec_name)",
                "📐 Resolução: \(.width)x\(.height)",
                "🕒 Duração: \($duration | tonumber | . / 60 | floor)m \(. % 60 | floor)s",
                "📏 Tamanho: \($size | tonumber | . / 1024 / 1024 | floor)MB",
                "🎞️  FPS: \(.r_frame_rate)",
                "🎨 Formato de Pixel: \(.pix_fmt // "N/A")"
            ' 2>/dev/null || {
                ffprobe -v quiet -show_format -show_streams "$FILE_PATH" 2>/dev/null | grep -E "(duration|width|height|codec_name)" | head -6
            }
        else
            show_file_info "$FILE_PATH"
            show_error "$FILE_EXTENSION_LOWER" "Instale: ffmpeg"
        fi
        ;;
    
    # Áudio
    mp3|wav|flac|ogg|aac|m4a|wma|opus)
        if command -v ffprobe >/dev/null 2>&1; then
            echo "🎵 Informações do Áudio"
            echo "━━━━━━━━━━━━━━━━━━━━━━━━━━"
            ffprobe -v quiet -print_format json -show_format -show_streams "$FILE_PATH" 2>/dev/null | \
            jq -r '
                .format.duration as $duration |
                .format.size as $size |
                .format.tags // {} as $tags |
                .streams[] | select(.codec_type=="audio") |
                "🎼 Codec: \(.codec_name)",
                "🕒 Duração: \($duration | tonumber | . / 60 | floor)m \(. % 60 | floor)s",
                "📏 Tamanho: \($size | tonumber | . / 1024 / 1024 | floor)MB",
                "🎚️  Sample Rate: \(.sample_rate)Hz",
                "🔊 Canais: \(.channels)",
                "🎤 Título: \($tags.title // "N/A")",
                "👤 Artista: \($tags.artist // "N/A")",
                "💿 Álbum: \($tags.album // "N/A")"
            ' 2>/dev/null || {
                echo "🎵 Informações básicas:"
                ffprobe -v quiet -show_format "$FILE_PATH" 2>/dev/null | grep -E "(duration|size)" | head -4
            }
        else
            show_file_info "$FILE_PATH"
            show_error "$FILE_EXTENSION_LOWER" "Instale: ffmpeg"
        fi
        ;;
    
    # Arquivos compactados
    zip|rar|7z|tar|gz|bz2|xz)
        echo "📦 Conteúdo do Arquivo Compactado"
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        case "$FILE_EXTENSION_LOWER" in
            zip)
                if command -v unzip >/dev/null 2>&1; then
                    unzip -l "$FILE_PATH" | head -n "$PV_HEIGHT"
                else
                    show_error "zip" "Instale: unzip"
                fi
                ;;
            rar)
                if command -v unrar >/dev/null 2>&1; then
                    unrar l "$FILE_PATH" | head -n "$PV_HEIGHT"
                else
                    show_error "rar" "Instale: unrar"
                fi
                ;;
            7z)
                if command -v 7z >/dev/null 2>&1; then
                    7z l "$FILE_PATH" | head -n "$PV_HEIGHT"
                else
                    show_error "7z" "Instale: p7zip-full"
                fi
                ;;
            tar|gz|bz2|xz)
                if command -v tar >/dev/null 2>&1; then
                    tar -tf "$FILE_PATH" | head -n "$PV_HEIGHT"
                else
                    show_error "$FILE_EXTENSION_LOWER" "Instale: tar"
                fi
                ;;
        esac
        ;;
    
    # Documentos Office
    docx|doc|xlsx|xls|pptx|ppt|odt|ods|odp)
        if command -v pandoc >/dev/null 2>&1; then
            echo "📄 Preview do Documento"
            echo "━━━━━━━━━━━━━━━━━━━━━━━━━━"
            pandoc -t plain "$FILE_PATH" 2>/dev/null | head -n "$PV_HEIGHT"
        elif command -v catdoc >/dev/null 2>&1 && [[ "$FILE_EXTENSION_LOWER" == "doc" ]]; then
            echo "📄 Preview do Documento Word"
            echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
            catdoc "$FILE_PATH" | head -n "$PV_HEIGHT"
        else
            show_file_info "$FILE_PATH"
            show_error "$FILE_EXTENSION_LOWER" "Instale: pandoc ou catdoc"
        fi
        ;;
    
    # Código fonte e texto
    txt|md|json|xml|html|css|js|py|rb|go|rs|c|cpp|h|hpp|java|php|sh|bash|zsh|vim|lua|toml|yaml|yml|ini|conf|cfg)
        if command -v bat >/dev/null 2>&1; then
            bat --color=always --style=numbers --line-range=:"$PV_HEIGHT" "$FILE_PATH"
        elif command -v pygmentize >/dev/null 2>&1; then
            pygmentize -g "$FILE_PATH" | head -n "$PV_HEIGHT"
        else
            echo "📝 Conteúdo do Arquivo"
            echo "━━━━━━━━━━━━━━━━━━━━━━━━━━"
            head -n "$PV_HEIGHT" "$FILE_PATH"
        fi
        ;;
    
    # Outros tipos
    *)
        # Tentar detectar se é texto
        if file "$FILE_PATH" | grep -q "text"; then
            echo "📝 Arquivo de Texto"
            echo "━━━━━━━━━━━━━━━━━━━━━━━━"
            head -n "$PV_HEIGHT" "$FILE_PATH"
        else
            show_file_info "$FILE_PATH"
            echo ""
            echo "🔍 Análise Hexadecimal (primeiros bytes):"
            echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
            xxd "$FILE_PATH" | head -8
            echo ""
            show_error "$FILE_EXTENSION_LOWER" "Tipo de arquivo não suportado"
        fi
        ;;
esac

exit 0
