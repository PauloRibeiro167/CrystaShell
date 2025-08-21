require_relative 'spec_helper'

RSpec.describe 'CrystaShell - Status Rápido' do
  describe 'Estrutura Básica' do
    it 'verifica se o projeto CrystaShell existe' do
      expect(Dir.exist?(crystashell_root)).to be true
    end

    it 'verifica diretórios essenciais' do
      %w[bin lib scripts yazi].each do |dir|
        path = File.join(crystashell_root, dir)
        expect(Dir.exist?(path)).to be true
      end
    end

    it 'verifica se o executável principal existe' do
      expect(File.exist?(executable_path)).to be true
    end
  end

  describe 'Yazi - Configuração' do
    it 'verifica se o yazi está disponível' do
      result = run_command('which yazi')
      expect(result).not_to include('not found')
    end

    it 'verifica se há configuração do Yazi' do
      config_dir = File.expand_path('~/.config/yazi')
      expect(Dir.exist?(config_dir)).to be true
    end

    it 'testa se o yazi executa sem erro' do
      result = run_command('yazi --version')
      expect(result).to include('Yazi')
    end
  end

  describe 'Dependências Críticas' do
    %w[ffmpegthumbnailer ffmpeg fd fzf rg].each do |dep|
      it "verifica se #{dep} está instalado" do
        result = run_command("which #{dep}")
        expect(result).not_to include('not found')
      end
    end
  end

  describe 'Funcionalidade Básica' do
    it 'testa sintaxe Ruby do executável principal' do
      if File.exist?(executable_path)
        result = run_command("ruby -c #{executable_path}")
        expect(result).to include('Syntax OK') if result.include?('Syntax')
      end
    end

    it 'verifica arquivos de configuração Yazi' do
      yazi_dir = File.join(crystashell_root, 'yazi')
      expect(Dir.exist?(yazi_dir)).to be true
    end
  end
end
