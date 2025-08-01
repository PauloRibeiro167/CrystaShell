require_relative '../../interface/menu_base'
require_relative 'carregador'
require 'yaml'

module GerenciadorTerminal
  module Funcionalidades
    module Temas
      class Gerenciador < Interface::MenuBase
        def initialize(prompt, data_path, config_loader)
          super()
          @prompt = prompt
          @data_path = data_path
          @config_loader = config_loader
          @titulo = "Temas"
        end

        def aplicar_tema(nome_tema)
          temas = YAML.load_file(File.join(@data_path, 'themes.yml'))['temas']
          tema = temas.find { |t| t['nome'] == nome_tema }
          return unless tema

          File.open(File.expand_path("~/.config/zsh/theme_exports.zsh"), "w") do |f|
            f.puts "export PROMPT_COLOR=\"#{tema['prompt_cor']}\""
            f.puts "export BACKGROUND_COLOR=\"#{tema['fundo_cor']}\""
            f.puts "export SUCCESS_COLOR=\"#{tema['sucesso_cor']}\""
            f.puts "export ERROR_COLOR=\"#{tema['erro_cor']}\""
            f.puts "export HIGHLIGHT_COLOR=\"#{tema['destaque_cor']}\""
          end
        end

        def executar_menu
          themes_path = File.join(@data_path, 'themes.yml')
          unless File.exist?(themes_path)
            @prompt.error("Arquivo de temas não encontrado em: #{themes_path}")
            @prompt.keypress("Pressione qualquer tecla para voltar...")
            system("clear")
            return
          end
          temas = YAML.load_file(themes_path)['temas']
          nomes = temas.map { |t| { name: t['nome'], value: t['nome'] } }
          nomes << { name: "\e[1;33mVoltar\e[0m", value: :voltar }
          nomes << { name: "\e[1;31mSair\e[0m", value: :sair_app, action: :sair }
          escolha = @prompt.select("", nomes)
          case escolha.to_sym
          when :voltar
            system("clear")
            return
          when :sair_app
            return
          else
            aplicar_tema(escolha)
            @prompt.ok("Tema '#{escolha}' aplicado! Recarregue o terminal.")
            @prompt.keypress("Pressione qualquer tecla para voltar...")
            system("clear")
          end
        end
      end
    end
  end
end