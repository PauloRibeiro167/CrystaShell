require 'tty-prompt'
require_relative 'menu_base'
require_relative '../funcionalidades/temas/gerenciador'
require_relative '../funcionalidades/aliases/gerenciador'
require_relative '../funcionalidades/ferramentas_git/gerenciador'
require_relative '../funcionalidades/ferramentas_docker/gerenciador'
require_relative '../funcionalidades/projetos/gerenciador'
require_relative '../funcionalidades/variaveis_ambiente/gerenciador'
require_relative '../funcionalidades/backup_restore/gerenciador'

module GerenciadorTerminal
  module Interface
    class MenuPrincipal < MenuBase
      def initialize(data_path, config_loader)
        super()
        @data_path = data_path
        @config_loader = config_loader
        @titulo = "Menu Principal"
      end

      def executar
        loop do
          system('clear') || system('cls')
          exibir_titulo
          pastel = Pastel.new
          opcoes = [
        { name: 'Temas do Terminal', value: 'gerenciar_aparencia', action: :menu_temas },
        { name: 'Atalhos (Aliases)', value: 'gerenciar_aliases', action: :menu_aliases },
        { name: 'Git', value: 'gerenciar_git', action: :menu_git },
        { name: 'Docker', value: 'gerenciar_docker', action: :menu_docker },
        { name: 'Projetos', value: 'gerenciar_projetos', action: :menu_projetos },
        { name: 'Variáveis de Ambiente', value: 'gerenciar_variaveis', action: :menu_variaveis },
        { name: 'Backup e Restauração', value: 'gerenciar_backup', action: :menu_backup },
        { name: pastel.red.bold("Sair"), value: 'sair_app', action: :sair }
          ]
          escolha = @prompt.select("", opcoes)
          opcao = opcoes.find { |o| o[:value] == escolha }
          if opcao && respond_to?(opcao[:action], true)
        resultado = send(opcao[:action])
        if escolha == 'sair_app'
          break
        end
          end
        rescue TTY::Reader::InputInterrupt, Interrupt
          system('clear') || system('cls')
          pastel = Pastel.new
          puts pastel.red("\nOperação cancelada.")
          break
        end
      end

      private

      def menu_temas
        begin
          GerenciadorTerminal::Funcionalidades::Temas::Gerenciador.new(@prompt, @data_path, @config_loader).executar_menu
        rescue => e
          puts "[Menu Temas] Erro: #{e.class} - #{e.message}"
        end
      end

      def menu_aliases
        puts "[Menu Aliases] Entrando no gerenciador de aliases."
        GerenciadorTerminal::Funcionalidades::Aliases::Gerenciador.new(@prompt, @data_path, @config_loader).executar_menu
      end

      def menu_git
        puts "[Menu Git] Entrando no gerenciador de Git."
        GerenciadorTerminal::Funcionalidades::FerramentasGit::Gerenciador.new(@prompt).executar_menu
      end

      def menu_docker
        puts "[Menu Docker] Entrando no gerenciador de Docker."
        GerenciadorTerminal::Funcionalidades::FerramentasDocker::Gerenciador.new(@prompt).executar_menu
      end

      def menu_projetos
        puts "[Menu Projetos] Entrando no gerenciador de projetos."
        GerenciadorTerminal::Funcionalidades::Projetos::Gerenciador.new(@prompt, @data_path).executar_menu
      end

      def menu_variaveis
        puts "[Menu Variáveis] Entrando no gerenciador de variáveis de ambiente."
        GerenciadorTerminal::Funcionalidades::VariaveisAmbiente::Gerenciador.new(@prompt, @data_path).executar_menu
      end

      def menu_backup
        puts "[Menu Backup] Entrando no gerenciador de backup e restauração."
        GerenciadorTerminal::Funcionalidades::BackupRestore::Gerenciador.new(@prompt, @data_path).executar_menu
      end

      def sair
        pastel = Pastel.new
        puts pastel.blue("Saindo do CrystaShell. Até a próxima!")
        sleep 1
        system('clear') || system('cls')
      end
    end
  end
end

data_path = File.expand_path('../gerenciador_terminal/data', __dir__)