# frozen_string_literal: true

# Este arquivo serve como o ponto de entrada principal da sua biblioteca Ruby 'gerenciador_terminal'.
# Ele é responsável por carregar todos os módulos e classes necessários para a aplicação.

require_relative 'gerenciador_terminal/main/aplicacao'
require_relative 'gerenciador_terminal/main/ajudantes'
require_relative 'gerenciador_terminal/main/carregador_config'
require_relative 'gerenciador_terminal/interface/menu_principal'
require_relative 'gerenciador_terminal/interface/menu_base'
require_relative 'gerenciador_terminal/cli/executor_comando'
require_relative 'gerenciador_terminal/funcionalidades/temas/gerenciador'
require_relative 'gerenciador_terminal/funcionalidades/temas/carregador'
require_relative 'gerenciador_terminal/funcionalidades/aliases/gerenciador'
require_relative 'gerenciador_terminal/funcionalidades/aliases/carregador'
require_relative 'gerenciador_terminal/funcionalidades/ferramentas_git/gerenciador'
require_relative 'gerenciador_terminal/funcionalidades/ferramentas_docker/gerenciador'
require_relative 'gerenciador_terminal/funcionalidades/projetos/gerenciador'
require_relative 'gerenciador_terminal/funcionalidades/projetos/escaneador'
require_relative 'gerenciador_terminal/funcionalidades/variaveis_ambiente/gerenciador'
require_relative 'gerenciador_terminal/funcionalidades/backup_restore/gerenciador'

module GerenciadorTerminal
  # O Zeitwerk irá autocarregar todos os módulos e classes deste namespace
end