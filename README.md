# 🚀 CrystaShell - Gerenciador de Terminal Zsh com Ruby

## 📌 Visão Geral

**CrystaShell** é um gerenciador de terminal Zsh interativo e modular, construído com Ruby, que transforma a experiência de linha de comando em um ambiente mais produtivo, organizado e automatizado.

### ✨ Principais Recursos

- 🎨 **Gerenciador de Temas**: Personalização visual completa do terminal
- 📁 **Gerenciador de Projetos**: Organização automática e navegação rápida
- 🔧 **Ferramentas Git/Docker**: Integração com fluxos de trabalho modernos
- 🖼️ **Integração Yazi**: File manager com preview avançado de imagens
- 🚀 **Interface CLI Interativa**: Menus intuitivos e esteticamente agradáveis
- 💾 **Backup/Restore**: Sistema de backup automático de configurações
- 🌍 **Aliases Inteligentes**: Shortcuts produtivos para comandos comuns

## 🏗️ Estrutura do Projeto

```
CrystaShell/
├── bin/gerenciador_terminal     # Executável principal
├── lib/
│   ├── gerenciador_terminal.rb  # Classe principal
│   ├── yazi_integration.zsh     # Integração com Yazi
│   └── gerenciador_terminal/
│       ├── main/                # Aplicação principal
│       ├── interface/           # Menus e UI
│       ├── funcionalidades/     # Módulos funcionais
│       └── data/               # Arquivos de configuração
├── scripts/                    # Scripts utilitários
├── yazi/                      # Configurações do Yazi
└── DOCS.md                   # Esta documentação
```

## 🚀 Instalação e Configuração

### 1. Instalação do CrystaShell
```bash
cd ~/projetos/CrystaShell
chmod +x bin/gerenciador_terminal
./bin/gerenciador_terminal
```

### 2. Integração com Yazi (File Manager)
```bash
# Instalação automática
./scripts/install_yazi_integration.sh
source ~/.zshrc

# Verificar instalação
./scripts/verify_integration.sh
```

### 3. Configuração de Dependências
```bash
# Instalar dependências de preview
./scripts/install_preview_deps.sh

# Configurar ícones automaticamente
./scripts/configure_icons.sh
```

## 🎮 Comandos Principais

### CrystaShell
```bash
gerenciador_terminal    # Interface principal
gt                     # Alias curto
```

### Yazi (File Manager)
```bash
yazi                   # Yazi melhorado
yc                     # Alias curto
yazi-config           # Editar configurações
yazi-icons            # Reconfigurar ícones
yazi-tabs             # Gerenciar abas
yazi_status           # Status da integração
```

### Abas no Yazi
```bash
t                     # Criar nova aba
Tab/Shift+Tab        # Navegar entre abas
Alt+1-9              # Ir para aba específica
Ctrl+W               # Fechar aba atual
gt/gT                # Navegação estilo Vim
```

## 🔧 Funcionalidades Principais

### 1. Gerenciamento de Temas
- Aplicação automática de temas visuais
- Sincronização com configurações do VS Code
- Suporte a fontes Nerd Font

### 2. Gerenciamento de Projetos
- Escaneamento automático de projetos
- Navegação rápida entre diretórios
- Integração com Git

### 3. Preview de Imagens
- Suporte a múltiplos formatos (PNG, JPG, GIF, etc.)
- Renderização ASCII otimizada para VS Code
- Compatibilidade universal (GNOME, KDE, XFCE, WSL)

### 4. Ferramentas Docker
- Gerenciamento de containers
- Shortcuts para comandos comuns
- Integração com fluxos de desenvolvimento

### 5. Backup e Restore
- Backup automático de configurações
- Restore de estados anteriores
- Versionamento de configurações

## 🖼️ Preview de Imagens

O CrystaShell inclui um sistema avançado de preview de imagens que funciona em:

- ✅ **Desktop**: GNOME, KDE, XFCE
- ✅ **Terminais**: VS Code integrado, GNOME Terminal, Konsole
- ✅ **Servidores**: Via SSH
- ✅ **Containers**: Docker, LXC
- ✅ **WSL**: Windows Subsystem for Linux

### Ferramentas de Renderização
- **chafa**: Renderização ASCII de alta qualidade
- **viu**: Preview rápido e leve
- **img2txt**: Fallback universal

## 🎨 Configurações

### Yazi (yazi.toml)
- Layout otimizado: [1, 4, 3] (preview maior)
- Cache inteligente em `~/.cache/yazi`
- Suporte a 20+ tipos de arquivo
- Qualidade de imagem: 90%

### Scripts Otimizados
- `yazi_preview.sh`: Preview principal
- `vscode_image_viewer.sh`: Visualizador VS Code
- `optimize_image_quality.sh`: Otimização automática

## 🔍 Troubleshooting

### Ícones não aparecem
```bash
# Reconfigurar ícones
yazi-icons

# Verificar fontes
fc-list | grep -i nerd
```

### Preview de imagens não funciona
```bash
# Verificar dependências
./scripts/test_image_preview.sh

# Testar chafa
chafa --version
```

### Comandos não reconhecidos
```bash
# Recarregar configurações
source ~/.zshrc

# Verificar instalação
./scripts/verify_integration.sh
```

## 📋 Arquivos de Configuração

### Principais
- `yazi/yazi.toml`: Configuração principal do Yazi
- `yazi/keymap.toml`: Mapeamento de teclas
- `yazi/theme.lua`: Tema personalizado
- `lib/yazi_integration.zsh`: Integração Zsh

### Data
- `lib/gerenciador_terminal/data/themes.yml`: Temas disponíveis
- `lib/gerenciador_terminal/data/projects.yml`: Projetos detectados
- `lib/gerenciador_terminal/data/aliases.yml`: Aliases configurados

## 🤝 Desenvolvimento

### Estrutura de Classes Ruby
```ruby
# Aplicação principal
class Aplicacao
  # Orquestração geral
end

# Gerenciadores específicos
class GerenciadorTemas
class GerenciadorProjetos
class GerenciadorFerramentasGit
class GerenciadorFerramentasDocker
```

### Extensibilidade
O CrystaShell foi projetado para ser facilmente extensível:
- Módulos independentes
- Interface padronizada
- Sistema de plugins

## 📝 Notas Importantes

- **Ruby necessário**: Versão 2.7 ou superior
- **Zsh obrigatório**: Funciona apenas com Zsh
- **Fontes recomendadas**: Nerd Font para ícones
- **Terminal suportado**: GNOME Terminal, Konsole, VS Code

---

**Desenvolvido por**: Paulo Ribeiro  
**Projeto**: CrystaShell Terminal Manager  
**Licença**: MIT
