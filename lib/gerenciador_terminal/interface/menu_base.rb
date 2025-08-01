require 'tty-prompt'
require 'tty-screen'
require 'pastel'
require 'rainbow'

module GerenciadorTerminal
  module Interface
    class MenuBase
      attr_reader :prompt

      def initialize
        @prompt = TTY::Prompt.new
      end

      def exibir_titulo(titulo = nil, cor_fundo = :green)
        titulo ||= @titulo || "Menu"
        width = TTY::Screen.width
        pastel = Pastel.new
        puts pastel.send("on_#{cor_fundo}").black.bold(titulo.center(width))
      end
      
      def escolher_opcao(opcoes, mensagem = "Selecione uma opção:", cor_fundo = :green)
        width = TTY::Screen.width
        pastel = Pastel.new
        puts pastel.send("on_#{cor_fundo}").black.bold(mensagem.center(width))
        prompt.select("", opcoes)
      end

      def executar
        raise NotImplementedError, "Você deve implementar o método 'executar' no menu específico."
      end

      def sair
        puts "\nSaindo do menu...\n"
      end
    end
  end
end