#!/bin/bash

# CrystaShell - Launcher do Yazi com Configurações Otimizadas
# Script para iniciar o Yazi com suporte completo a imagens

# Definir diretório de configuração
export YAZI_CONFIG_HOME="/home/paulo/projetos/CrystaShell/yazi"

# Definir variáveis de ambiente para otimização
export COLORTERM="truecolor"
export YAZI_IMAGE_QUALITY="95"
export YAZI_IMAGE_PROTOCOL="chafa"

# Verificar se estamos no terminal VS Code
if [ "$TERM_PROGRAM" = "vscode" ]; then
    echo "🔥 Iniciando Yazi otimizado para VS Code..."
    export YAZI_VS_CODE_MODE="1"
else
    echo "🚀 Iniciando Yazi com configurações padrão..."
fi

# Verificar dependências críticas
if ! command -v chafa >/dev/null 2>&1; then
    echo "⚠️  Aviso: chafa não encontrado. Instale com:"
    echo "   sudo apt install chafa"
fi

if ! command -v viu >/dev/null 2>&1; then
    echo "💡 Dica: instale viu para melhor qualidade de imagem:"
    echo "   cargo install viu"
fi

# Iniciar Yazi
echo "📁 Diretório atual: $(pwd)"
echo "⚙️  Configurações em: $YAZI_CONFIG_HOME"
echo ""

# Executar Yazi com configurações personalizadas
exec yazi "$@"
