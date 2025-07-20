-----

Excelente\! Seu `README.md` já é um guia técnico muito bom. Vamos transformá-lo em um documento Markdown ainda mais funcional, visualmente atraente com o uso de **emojis, formatação rica** e, onde aplicável, **"colorimetria"** (que em Markdown se traduz em destaque de blocos de código ou notas).

-----

## ✨ Aprimorando seu `README.md` com Markdown e Estilo

Aqui está a versão revisada e expandida do seu `README.md`. Eu adicionei:

  * **Emojis:** Para tornar a leitura mais rápida e visualmente agradável.
  * **Melhorias na Formatação:** Uso consistente de negrito, itálico, listas e títulos.
  * **Blocos de Código:** Para comandos e estruturas.
  * **Notas/Dicas:** Para destacar informações importantes (simulando "colorimetria" com blocos de citação ou código).
  * **Seções de Introdução e Como Contribuir:** Elementos padrão de um bom README.

-----

```markdown
# 🚀 Gerenciador de Terminal Zsh com Ruby: CrystaShell ✨

---

## 📌 Visão Geral do Projeto

Este projeto, **CrystaShell**, é um **Gerenciador de Terminal Zsh** interativo e modular, construído predominantemente com **Ruby**. Nosso objetivo é transformar a experiência de linha de comando em um ambiente mais produtivo, organizado, estético e automatizado.

**CrystaShell irá:**

✅ **Facilitar a personalização** de temas, atalhos, projetos e ferramentas (Git, Docker).
✅ **Reduzir a necessidade de edição manual** do `.zshrc` ou de scripts complexos.
✅ Oferecer **interfaces CLI interativas, intuitivas e esteticamente agradáveis**.
✅ **Centralizar** suas ferramentas de produtividade em um único lugar no terminal.

---

## 🏗️ Estrutura do Projeto

A organização do CrystaShell é modular, seguindo as melhores práticas de desenvolvimento Ruby para facilitar a manutenção e a expansão.

```

CrystaShell/
├── bin/                  \# 🚦 Scripts executáveis e ponto de entrada da aplicação
│   └── terminal\_manager  \# O executável principal que você chamará no terminal
├── lib/                  \# 💎 Código-fonte principal da aplicação Ruby
│   └── terminal\_manager/
│       ├── core/         \# 🧠 Módulos e classes base: orquestração, utilitários, configuração global
│       │   ├── application.rb
│       │   ├── helpers.rb
│       │   └── config\_loader.rb
│       ├── ui/           \# 🖼️ Lógica da Interface do Usuário: menus e navegação interativa (TTY::Prompt)
│       │   ├── main\_menu.rb
│       │   └── base\_menu.rb
│       ├── cli/          \# ⚙️ Integração com Linha de Comando: execução segura de comandos externos (Git, Docker, etc.)
│       │   └── command\_executor.rb
│       └── features/     \# ✨ Módulos de Funcionalidades Específicas: cada um com sua lógica e dados
│           ├── themes/
│           │   ├── manager.rb
│           │   └── loader.rb
│           ├── aliases/
│           │   ├── manager.rb
│           │   └── loader.rb
│           ├── git\_tools/
│           │   └── manager.rb
│           ├── docker\_tools/
│           │   └── manager.rb
│           ├── projects/
│           │   ├── manager.rb
│           │   └── scanner.rb
│           ├── env\_vars/
│           │   └── manager.rb
│           └── backup\_restore/
│               └── manager.rb
├── data/                 \# 🗄️ Armazenamento Persistente: arquivos YAML/JSON para configurações do usuário
│   ├── themes.yml
│   ├── aliases.yml
│   ├── projects.yml
│   ├── env\_vars.yml
│   └── config.yml
├── .zshrc                \# 🔗 Integração com o Zsh: link simbólico ou trechos para carregar o CrystaShell
├── Gemfile               \# 📦 Gerenciamento de Dependências Ruby (Gems)
└── Gemfile.lock          \# 🔒 Versões exatas das Gems instaladas

````

---

## 🛠️ Pilares do Sistema e Funcionalidades Essenciais

CrystaShell é construído sobre pilares fundamentais, cada um com um conjunto detalhado de funcionalidades:

### 1. 🎨 Gerenciador de Temas e Aparência

| Recurso                | Descrição                                                                                               |
| :--------------------- | :------------------------------------------------------------------------------------------------------ |
| **Criar e Editar Temas** | Defina e personalize cores para prompt, mensagens de sucesso/erro, diretórios e outras saídas do terminal. |
| **Interface CLI Intuitiva** | Navegue pelos temas usando **setas ↑↓**, confirme com **Enter** ou **→**, e visualize mudanças.            |
| **Exportação Automática** | Atualiza automaticamente o `.zshrc` ou arquivos de tema intermediários para aplicar as configurações no Zsh. |

### 2. ⌨️ Gerenciamento de Atalhos de Comandos

| Recurso             | Descrição                                                                    |
| :------------------ | :--------------------------------------------------------------------------- |
| **Mapear Atalhos** | Crie atalhos personalizados (combinação de tecla + ação) para comandos shell, scripts Ruby ou sequências complexas. |
| **Editar/Remover** | Modifique ou exclua atalhos dinamicamente através da interface.                 |
| **Persistência** | Armazenamento seguro em arquivos YAML/JSON, com aplicação automática no Zsh ao iniciar. |

### 3. 🔧 Menus Interativos para Ferramentas

CrystaShell oferece uma ponte interativa para suas ferramentas de linha de comando favoritas:

#### ⚡ Git
* **`status`**: Visualize o status do seu repositório de forma colorida e simplificada.
* **`commit`**: Guie o processo de commit com prompts para a mensagem.
* **`push` / `pull`**: Execute operações de sincronização com feedback visual de progresso.
* **`branch`**: Liste, crie e alterne entre branches de forma interativa.
* **`log`**: Explore o histórico de commits com filtros personalizáveis (ex: últimos N commits).

#### 🐳 Docker
* **`ps`**: Visualize containers em execução ou todos os containers.
* **`start/stop/restart`**: Inicie, pare ou reinicie containers selecionados interativamente.
* **`images`**: Liste e gerencie imagens Docker.
* **`compose up/down`**: Gerencie seus projetos Docker Compose.
* **`logs`**: Monitore os logs de containers específicos.

#### 📝 Extras
* **Ruby CLI:** Crie comandos Ruby personalizados para automatizar sequências de tarefas frequentes, transformando-as em opções de menu.

### 4. 📂 Gerenciador de Projetos no Terminal

| Recurso             | Descrição                                                                                                     |
| :------------------ | :------------------------------------------------------------------------------------------------------------ |
| **Listagem Automática** | O sistema escaneia diretórios configurados para identificar automaticamente seus repositórios Git e projetos Docker. |
| **Atalhos Rápidos** | Acesse projetos rapidamente: navegue para o diretório, abra no VS Code (`code .`) ou execute scripts específicos do projeto. |
| **Organização** | Permita adicionar tags ou agrupar projetos (ex: "pessoal", "trabalho", "open-source") para uma melhor organização. |

### 5. 💾 Sistema de Backup e Restauração

| Recurso            | Descrição                                                                                           |
| :----------------- | :-------------------------------------------------------------------------------------------------- |
| **Backup Fácil** | Crie backups compactados de todas as suas configurações do CrystaShell (.zshrc, aliases, temas, etc.). |
| **Restauração** | Requeira e aplique configurações salvas de forma interativa, facilitando a migração ou recuperação.       |

### 6. 🧠 Interface e Navegação Intuitiva

A navegação em CrystaShell é pensada para ser fluida e eficiente, eliminando a necessidade de números em menus.

| Tecla               | Função                                                                         |
| :------------------ | :----------------------------------------------------------------------------- |
| **↑ / ↓** | Navegar entre opções de menus e listas.                                        |
| **→ / Enter** | Confirmar a seleção de uma opção ou avançar em prompts.                       |
| **ESC / Shift + Tab** | Voltar para a tela ou menu anterior.                                          |
| **Ctrl + C** | Encerrar a aplicação ou o menu atual de forma segura.                          |

> 💡 **Dica:** A consistência na navegação é fundamental para uma experiência de usuário agradável e produtiva.

---

## ✨ Funcionalidades Adicionais (Bônus)

Pense grande! CrystaShell pode evoluir para incluir:

* **Plugins Manager:** 📦 Uma interface para listar, instalar, atualizar e remover plugins Zsh (Oh My Zsh, Zinit).
* **Notificações:** 🔔 Receba notificações de conclusão para tarefas demoradas do terminal (ex: builds, grandes downloads).
* **Fuzzy Finder Integrado:** 🔍 Integre um "fuzzy finder" (como `fzf` ou `peco`) para buscas rápidas de arquivos, pastas e projetos.
* **To-Do List no Terminal:** 📝 Gerencie suas tarefas simples diretamente pela linha de comando, associadas a projetos ou globalmente.
* **Variáveis de Ambiente:** 🔒 Interface para gerenciar suas variáveis de ambiente personalizadas (`.env`, `exports`).
* **Atualização Automática:** 🔄 Recurso para atualizar o próprio CrystaShell via `git pull` e `bundle install`.

---

## 🧰 Stack Técnica e Dependências

| Tecnologia / Ferramenta | Uso                                                                                              |
| :---------------------- | :----------------------------------------------------------------------------------------------- |
| **Ruby** (>= 2.7)       | Núcleo da aplicação, lógica de negócios e orquestração.                                         |
| **Zsh** | Terminal alvo para integração e personalização.                                                  |
| `tty-prompt`            | Criação de menus interativos e prompts de entrada de dados.                                      |
| `tty-spinner`           | Feedback visual de progresso para operações de longa duração.                                    |
| `pastel`, `colorize`, `rainbow` | Gems para estilizar e colorir o texto no terminal.                                       |
| `yaml`, `psych`         | Leitura e escrita de arquivos YAML para persistência das configurações.                          |
| `fileutils`, `zip`      | Manipulação de arquivos e diretórios para backups e outras operações.                            |
| `open3`                 | Execução segura de comandos externos (`git`, `docker`) e captura de suas saídas/erros.           |
| `rspec`, `minitest`     | Frameworks de teste para garantir a robustez e a qualidade do código.                            |

---

## 🚀 Como Rodar o Projeto

Siga estes passos para configurar e iniciar o CrystaShell em seu ambiente:

### 1️⃣ Clonar o projeto:

```bash
git clone [https://github.com/paulo/CrystaShell.git](https://github.com/paulo/CrystaShell.git)
cd CrystaShell
````

### 2️⃣ Instalar as dependências Ruby:

```bash
bundle install
```

### 3️⃣ Integrar com seu `.zshrc`:

Adicione as seguintes linhas ao seu arquivo `~/.zshrc` para que o Zsh reconheça o `terminal_manager`.

```zsh
# --- Configurações do CrystaShell ---

# Adiciona o diretório 'bin' do CrystaShell ao PATH do Zsh
export PATH="$HOME/projetos/CrystaShell/bin:$PATH"

# Adiciona o diretório 'lib' do CrystaShell ao RUBYLIB
# Isso permite que scripts Ruby em 'bin/' encontrem os módulos em 'lib/'
export RUBYLIB="$HOME/projetos/CrystaShell/lib:$RUBYLIB"

# Opcional: Se você usa gerenciadores de versão do Ruby (rbenv, rvm),
# garanta que eles estejam inicializados ANTES destas linhas.
# Exemplo para rbenv:
# if command -v rbenv &>/dev/null; then eval "$(rbenv init - zsh)"; fi

# Crie um alias para chamar o gerenciador facilmente
alias gterm='terminal_manager'

# --- Fim das Configurações do CrystaShell ---
```

Após adicionar as linhas, recarregue seu Zsh:

```bash
source ~/.zshrc
```

### 4️⃣ Rodar a aplicação:

Agora você pode iniciar o CrystaShell a qualquer momento no seu terminal:

```bash
gterm
```

### 5️⃣ Executar testes (durante o desenvolvimento):

```bash
bundle exec rspec
```

> ⚠️ **Atenção:** Certifique-se de que o **Ruby** e o **Bundler** estejam instalados e configurados corretamente em seu sistema.

-----

## 📅 Checklist de Desenvolvimento (Visão Geral)

  * [ ] Estrutura inicial e `Gemfile` configurados.
  * [ ] Definição e mapeamento completo de todas as funcionalidades.
  * [ ] Implementação das classes e métodos principais.
  * [ ] Escrita de testes unitários para cada módulo.
  * [ ] Configuração de ferramentas de qualidade de código (Rubocop, SimpleCov).
  * [ ] Documentação de regras de negócio e detalhes de implementação no README.
  * [ ] Preparação para a entrega (ou futura publicação como gem).

-----

## 📖 Regras e Organização Interna

Para manter o código limpo, consistente e de fácil manutenção:

  * **Organização de Arquivos:** Todo o código de domínio principal reside em `/lib`. Arquivos de execução estão em `/bin`. Testes são organizados em `/spec`.
  * **Convenções de Código:** Priorizamos nomes claros e autoexplicativos. Métodos e classes complexos devem ser documentados com comentários concisos.
  * **Test-Driven Development (TDD):** Novas funcionalidades serão acompanhadas por testes unitários e de integração correspondentes.

-----

## 🎯 Próximos Passos na Implementação

1.  **Mapear as funcionalidades principais** para classes e métodos específicos.
2.  **Definir as entradas e saídas** de cada componente.
3.  **Construir iterações pequenas e testáveis**, focando em uma funcionalidade por vez.
4.  **Refatorar** o código continuamente para melhorar a clareza e a eficiência.

-----

## 🤝 Contribuição

Contribuições são muito bem-vindas\! Se você tiver sugestões, melhorias ou encontrar bugs, sinta-se à vontade para abrir uma *issue* ou enviar um *pull request*.

-----

## 🧑‍💻 Autor

**Paulo** - [paulo@email.com](mailto:paulo@email.com)
GitHub: [https://github.com/paulo](https://github.com/paulo)

-----
