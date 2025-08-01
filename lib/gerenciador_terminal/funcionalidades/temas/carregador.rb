require 'yaml'

module GerenciadorTerminal
  module Funcionalidades
    module Temas
      class Carregador
        def self.carregar(data_path)
          temas_path = File.join(data_path, 'themes.yml')
          unless File.exist?(temas_path)
            puts "[Temas] Arquivo de temas não encontrado em: #{temas_path}"
            return nil
          end
          YAML.load_file(temas_path)
        end
      end
    end
  end
end