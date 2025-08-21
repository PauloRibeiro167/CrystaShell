
# CrystaShell - Configuração do Yazi Terminal File Manager

**Status**: ✅ Configurado e otimizado seguindo as melhores práticas
**Baseado no guia**: https://www.josean.com/posts/how-to-use-yazi-file-manager

## Instalação e Dependências

Todas as dependências necessárias foram instaladas:

```bash
sudo apt update && sudo apt install yazi ffmpegthumbnailer ffmpeg p7zip-full jq poppler-utils fd-find ripgrep fzf imagemagick fonts-firacode
```

**Dependências adicionais instaladas**:
- **zoxide**: Navegação rápida entre diretórios
- **Catppuccin Mocha**: Tema visual otimizado
- **ueberzug**: ✨ **NOVA!** Biblioteca para preview de imagens de alta qualidade

## Configuração de Imagens Otimizada ✨

A configuração do CrystaShell inclui otimizações específicas para preview de imagens:

### Configurações de Preview
```toml
[preview]
wrap            = "no"
tab_size        = 4
max_width       = 900      # Aumentado para aproveitar ueberzug
max_height      = 700      # Otimizado para qualidade  
cache_dir       = "~/.cache/yazi"
image_delay     = 10       # Reduzido com ueberzug
image_filter    = "lanczos3"  # Melhor filtro para ueberzug
image_quality   = 90       # Qualidade máxima permitida (50-90)
ueberzug_scale  = 1.5      # Aumentado para melhor qualidade
ueberzug_offset = [ 0, 0, 0, 0 ]
```

### ✨ Melhorias com Ueberzug
- **Preview de alta qualidade**: Imagens nítidas e detalhadas
- **Suporte a transparência**: Melhor renderização de PNGs
- **Performance otimizada**: Cache inteligente e carregamento rápido
- **Compatibilidade**: Funciona em terminais modernos e VS Code

### Visualizadores de Imagem Configurados
- **Feh**: Visualizador rápido e leve
- **Eye of Gnome (eog)**: Visualizador padrão do GNOME  
- **xdg-open**: Fallback para visualizador padrão do sistema

## Wrapper de Shell Configurado

O wrapper permite navegar automaticamente para o diretório atual ao sair do Yazi:

```bash
# Use 'y' em vez de 'yazi' para ativar o wrapper
y  # Abre o Yazi com navegação automática
```

## Arquivos de Configuração

**Locais dos arquivos de configuração:**
- `~/.config/yazi/yazi.toml` - Configuração principal
- `~/.config/yazi/keymap.toml` - Atalhos de teclado  
- `~/.config/yazi/theme.toml` - Tema visual
- `~/.config/yazi/flavors/` - Temas personalizados

## Atalhos de Teclado Essenciais

Para ver todos os atalhos disponíveis, pressione `~` ou `F1` no Yazi.

**Principais atalhos para imagens:**
- `Enter` - Abrir com visualizador padrão
- `o` - Menu de abertura com opções
- `Space` - Selecionar arquivo
- `v` - Modo visual para seleção múltipla

## Status da Configuração

✅ **Configuração padrão aplicada** - Baseada nos padrões oficiais recomendados  
✅ **Preview de imagens otimizado** - Alta qualidade e performance  
✅ **Tema Catppuccin Mocha** - Visual moderno e elegante  
✅ **Wrapper de shell** - Navegação automática entre diretórios  
✅ **Todas as dependências** - ffmpeg, imagemagick, poppler-utils, etc.

A configuração segue as melhores práticas do guia oficial e está otimizada para o ambiente CrystaShell Linux.

