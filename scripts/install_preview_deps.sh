#!/bin/bash

# CrystaShell - Instalador de Dependências para Previews do Yazi
# Instala ferramentas necessárias para visualização de diferentes tipos de arquivo

echo "🔧 Instalador de Dependências - Yazi Preview"
echo "=============================================="
echo ""

# Função para verificar se um comando existe
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Função para instalar pacotes
install_package() {
    local package="$1"
    local description="$2"
    
    echo "📦 Instalando $package ($description)..."
    
    if command_exists apt; then
        sudo apt update && sudo apt install -y "$package"
    elif command_exists dnf; then
        sudo dnf install -y "$package"
    elif command_exists pacman; then
        sudo pacman -S --noconfirm "$package"
    elif command_exists zypper; then
        sudo zypper install -y "$package"
    else
        echo "❌ Gerenciador de pacotes não suportado"
        return 1
    fi
}

echo "🔍 Verificando dependências instaladas..."
echo ""

# Verificar e instalar dependências

# Para previews de imagem
if ! command_exists chafa; then
    echo "📸 Instalando chafa (preview de imagens)..."
    install_package "chafa" "Preview de imagens no terminal"
else
    echo "✅ chafa já instalado"
fi

# Para previews de PDF
if ! command_exists pdftotext; then
    echo "📄 Instalando poppler-utils (preview de PDF)..."
    install_package "poppler-utils" "Utilitários para PDF"
else
    echo "✅ poppler-utils já instalado"
fi

# Para previews de vídeo/áudio
if ! command_exists ffprobe; then
    echo "🎬 Instalando ffmpeg (informações de mídia)..."
    install_package "ffmpeg" "Processamento de áudio e vídeo"
else
    echo "✅ ffmpeg já instalado"
fi

# Para syntax highlighting
if ! command_exists bat; then
    echo "🎨 Instalando bat (syntax highlighting)..."
    install_package "bat" "Cat com syntax highlighting"
else
    echo "✅ bat já instalado"
fi

# Para preview de documentos Office
if ! command_exists pandoc; then
    echo "📄 Instalando pandoc (conversão de documentos)..."
    install_package "pandoc" "Conversor universal de documentos"
else
    echo "✅ pandoc já instalado"
fi

# Para arquivos JSON
if ! command_exists jq; then
    echo "📋 Instalando jq (processamento JSON)..."
    install_package "jq" "Processador de JSON"
else
    echo "✅ jq já instalado"
fi

# Para archives
if ! command_exists unzip; then
    echo "📦 Instalando unzip..."
    install_package "unzip" "Descompactador ZIP"
else
    echo "✅ unzip já instalado"
fi

if ! command_exists 7z; then
    echo "📦 Instalando p7zip-full..."
    install_package "p7zip-full" "Suporte a 7z"
else
    echo "✅ p7zip já instalado"
fi

# Dependências opcionais
echo ""
echo "📋 Dependências Opcionais (recomendadas):"
echo ""

# Img2txt (alternativa para imagens)
if ! command_exists img2txt; then
    echo "🖼️  img2txt (caca-utils) - Preview de imagens ASCII"
    echo "   Para instalar: sudo apt install caca-utils"
fi

# Timg (outra alternativa para imagens)
if ! command_exists timg; then
    echo "🖼️  timg - Preview de imagens com cores"
    echo "   Para instalar: sudo apt install timg"
fi

# Catdoc para documentos Word antigos
if ! command_exists catdoc; then
    echo "📄 catdoc - Preview de documentos .doc"
    echo "   Para instalar: sudo apt install catdoc"
fi

# Unrar para arquivos RAR
if ! command_exists unrar; then
    echo "📦 unrar - Suporte a arquivos RAR"
    echo "   Para instalar: sudo apt install unrar"
fi

echo ""
echo "✅ Instalação concluída!"
echo ""
echo "🧪 Para testar os previews:"
echo "1. Execute: yazi"
echo "2. Navegue até um arquivo de imagem, PDF ou vídeo"
echo "3. O preview deve aparecer automaticamente"
echo ""
echo "📋 Tipos de arquivo suportados:"
echo "• 📸 Imagens: jpg, png, gif, bmp, svg, webp"
echo "• 📄 PDFs: pdf"
echo "• 🎬 Vídeos: mp4, mkv, avi, mov, webm"
echo "• 🎵 Áudio: mp3, wav, flac, ogg, aac"
echo "• 📦 Arquivos: zip, rar, 7z, tar, gz"
echo "• 📄 Office: docx, xlsx, pptx, odt"
echo "• 💻 Código: todos os formatos com syntax highlighting"
echo ""
echo "🔧 Configuração atualizada em:"
echo "   /home/paulo/projetos/CrystaShell/yazi/"
