
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

## Configuração de Imagens Otimizada ✨

A configuração do CrystaShell inclui otimizações específicas para preview de imagens:

### Configurações de Preview
```toml
[preview]
wrap            = "no"
tab_size        = 4
max_width       = 600      # Largura máxima otimizada
max_height      = 900      # Altura máxima otimizada  
cache_dir       = "~/.cache/yazi"
image_delay     = 30       # Delay otimizado para carregamento
image_filter    = "lanczos3"  # Filtro de alta qualidade
image_quality   = 90       # Qualidade de imagem 90%
ueberzug_scale  = 1
ueberzug_offset = [ 0, 0, 0, 0 ]
```

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

