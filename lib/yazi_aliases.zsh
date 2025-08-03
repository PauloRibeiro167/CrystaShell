# CrystaShell - Aliases para Yazi Otimizado

# Alias principal para Yazi com configurações otimizadas
alias yc='YAZI_CONFIG_HOME="/home/paulo/projetos/CrystaShell/yazi" yazi'

# Alias para teste de imagens
alias yc-test='/home/paulo/projetos/CrystaShell/scripts/test_image_preview.sh'

# Alias para Yazi otimizado com script launcher
alias yc-opt='/home/paulo/projetos/CrystaShell/scripts/yazi_optimized.sh'

# Função para abrir Yazi em qualquer diretório com configurações CrystaShell
yazi-crysta() {
    local target_dir="${1:-$(pwd)}"
    cd "$target_dir" || return 1
    YAZI_CONFIG_HOME="/home/paulo/projetos/CrystaShell/yazi" yazi
}

# Exportar variáveis de ambiente para melhor suporte a imagens
export COLORTERM="truecolor"
export YAZI_IMAGE_QUALITY="95"

echo "🔥 CrystaShell Yazi aliases carregados!"
echo "   yc         - Yazi com configurações CrystaShell"
echo "   yc-test    - Testar exibição de imagens"
echo "   yc-opt     - Launcher otimizado"
echo "   yazi-crysta [dir] - Abrir Yazi em diretório específico"
