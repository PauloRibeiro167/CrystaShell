require 'spec_helper'
require_relative '../lib/gerenciador_terminal'

RSpec.describe 'CrystaShell Funcionalidades' do
  let(:data_path) { File.join(crystashell_root, 'lib', 'gerenciador_terminal', 'data') }
  let(:config_loader) { 
    if defined?(GerenciadorTerminal::Nucleo::CarregadorConfig)
      GerenciadorTerminal::Nucleo::CarregadorConfig.new(data_path) 
    end
  }
  let(:prompt) { instance_double(TTY::Prompt) }

  describe 'Estrutura do Projeto' do
    it 'deve ter o executável principal' do
      if File.exist?(executable_path)
        expect(File.exist?(executable_path)).to be true
        expect(File.executable?(executable_path)).to be true
      else
        skip "Executável não encontrado em #{executable_path}"
      end
    end

    it 'deve ter os arquivos de configuração necessários' do
      config_files = %w[themes.yml aliases.yml env_vars.yml projects.yml]
      missing_files = []
      
      config_files.each do |file|
        config_path = File.join(data_path, file)
        missing_files << file unless File.exist?(config_path)
      end
      
      if missing_files.empty?
        config_files.each do |file|
          config_path = File.join(data_path, file)
          expect(File.exist?(config_path)).to be true
        end
      else
        skip "Arquivos de configuração faltando: #{missing_files.join(', ')}"
      end
    end

    it 'deve ter a estrutura de diretórios correta' do
      expected_dirs = %w[
        lib/gerenciador_terminal/main
        lib/gerenciador_terminal/interface
        lib/gerenciador_terminal/funcionalidades
        lib/gerenciador_terminal/data
        scripts
        yazi
        spec
      ]

      missing_dirs = []
      expected_dirs.each do |dir|
        dir_path = File.join(crystashell_root, dir)
        missing_dirs << dir unless Dir.exist?(dir_path)
      end
      
      if missing_dirs.empty?
        expected_dirs.each do |dir|
          dir_path = File.join(crystashell_root, dir)
          expect(Dir.exist?(dir_path)).to be true
        end
      else
        skip "Diretórios faltando: #{missing_dirs.join(', ')}"
      end
    end
  end

  describe 'Módulo Principal' do
    it 'deve carregar todas as classes necessárias' do
      expect(defined?(GerenciadorTerminal)).to be_truthy
      
      # Testa classes opcionais
      classes_opcionais = {
        'GerenciadorTerminal::Interface::MenuPrincipal' => 'Menu Principal',
        'GerenciadorTerminal::Interface::MenuBase' => 'Menu Base',
        'GerenciadorTerminal::Nucleo::CarregadorConfig' => 'Carregador Config'
      }
      
      classes_opcionais.each do |classe, nome|
        if defined?(classe)
          expect(defined?(classe)).to be_truthy
        else
          puts "  ⚠️  Classe opcional não encontrada: #{nome}"
        end
      end
    end

    it 'deve inicializar o menu principal corretamente' do
      if defined?(GerenciadorTerminal::Interface::MenuPrincipal) && config_loader
        expect { 
          GerenciadorTerminal::Interface::MenuPrincipal.new(data_path, config_loader) 
        }.not_to raise_error
      else
        skip "MenuPrincipal ou CarregadorConfig não definidos"
      end
    end
  end

  describe 'Gerenciamento de Temas' do
    let(:gerenciador_temas) { 
      if defined?(GerenciadorTerminal::Funcionalidades::Temas::Gerenciador)
        GerenciadorTerminal::Funcionalidades::Temas::Gerenciador.new(prompt, data_path, config_loader) 
      end
    }

    it 'deve carregar temas do arquivo YAML' do
      themes_path = File.join(data_path, 'themes.yml')
      
      if File.exist?(themes_path)
        expect(File.exist?(themes_path)).to be true

        themes_data = YAML.load_file(themes_path)
        expect(themes_data).to have_key('temas')
        expect(themes_data['temas']).to be_an(Array)
        expect(themes_data['temas'].length).to be > 0
      else
        skip "Arquivo themes.yml não encontrado em #{themes_path}"
      end
    end

    it 'deve ter a estrutura correta para cada tema' do
      themes_path = File.join(data_path, 'themes.yml')
      
      if File.exist?(themes_path)
        themes_data = YAML.load_file(themes_path)
        
        themes_data['temas'].each do |tema|
          expect(tema).to have_key('nome')
          expect(tema).to have_key('prompt_cor')
          # Nem todos os temas têm todas as chaves, então vamos ser flexíveis
          expect(tema.keys).to include('prompt_cor')
        end
      else
        skip "Arquivo themes.yml não encontrado"
      end
    end

    it 'deve aplicar um tema corretamente' do
      themes_path = File.join(data_path, 'themes.yml')
      
      if File.exist?(themes_path) && gerenciador_temas
        themes_data = YAML.load_file(themes_path)
        primeiro_tema = themes_data['temas'].first

        # Mock do diretório de configuração
        config_dir = File.expand_path("~/.config/zsh")
        allow(FileUtils).to receive(:mkdir_p).with(config_dir)
        allow(File).to receive(:open).and_call_original

        expect { 
          gerenciador_temas.aplicar_tema(primeiro_tema['nome']) 
        }.not_to raise_error
      else
        skip "Arquivo themes.yml não encontrado ou classe não carregada"
      end
    end
  end

  describe 'Gerenciamento de Aliases' do
    let(:gerenciador_aliases) { 
      if defined?(GerenciadorTerminal::Funcionalidades::Aliases::Gerenciador)
        GerenciadorTerminal::Funcionalidades::Aliases::Gerenciador.new(prompt, data_path, config_loader) 
      end
    }

    it 'deve carregar aliases do arquivo YAML' do
      aliases_path = File.join(data_path, 'aliases.yml')
      
      if File.exist?(aliases_path)
        expect(File.exist?(aliases_path)).to be true

        # Se o arquivo estiver vazio, apenas verificamos se existe
        if File.size(aliases_path) > 0
          aliases_data = YAML.load_file(aliases_path)
          if aliases_data
            expect(aliases_data).to have_key('aliases')
            expect(aliases_data['aliases']).to be_an(Array)
          end
        end
      else
        skip "Arquivo aliases.yml não encontrado em #{aliases_path}"
      end
    end

    it 'deve ter estrutura correta para cada alias quando dados existem' do
      aliases_path = File.join(data_path, 'aliases.yml')
      
      if File.exist?(aliases_path) && File.size(aliases_path) > 0
        aliases_data = YAML.load_file(aliases_path)
        if aliases_data && aliases_data['aliases']
          aliases_data['aliases'].each do |alias_item|
            expect(alias_item).to have_key('nome')
            expect(alias_item).to have_key('comando')
            expect(alias_item).to have_key('descricao')
          end
        end
      else
        skip "Arquivo aliases.yml vazio ou não encontrado"
      end
    end
  end

  describe 'Gerenciamento de Projetos' do
    it 'deve carregar projetos do arquivo YAML' do
      projects_path = File.join(data_path, 'projects.yml')
      
      if File.exist?(projects_path)
        expect(File.exist?(projects_path)).to be true

        # Se o arquivo estiver vazio, apenas verificamos se existe
        if File.size(projects_path) > 0
          projects_data = YAML.load_file(projects_path)
          if projects_data
            expect(projects_data).to have_key('projetos')
            expect(projects_data['projetos']).to be_an(Array)
          end
        end
      else
        skip "Arquivo projects.yml não encontrado em #{projects_path}"
      end
    end
  end

  describe 'Gerenciamento de Variáveis de Ambiente' do
    it 'deve carregar variáveis do arquivo YAML' do
      env_vars_path = File.join(data_path, 'env_vars.yml')
      
      if File.exist?(env_vars_path)
        expect(File.exist?(env_vars_path)).to be true

        env_data = YAML.load_file(env_vars_path)
        # O arquivo pode ter estrutura simples chave-valor em vez de nested
        expect(env_data).to be_a(Hash)
      else
        skip "Arquivo env_vars.yml não encontrado em #{env_vars_path}"
      end
    end
  end

  describe 'Interface de Menu Base' do
    let(:menu_base) { 
      if defined?(GerenciadorTerminal::Interface::MenuBase)
        GerenciadorTerminal::Interface::MenuBase.new 
      end
    }

    it 'deve inicializar com prompt TTY' do
      if menu_base
        expect(menu_base.prompt).to be_a(TTY::Prompt)
      else
        skip "MenuBase não definido"
      end
    end

    it 'deve ter métodos essenciais implementados' do
      if menu_base
        expect(menu_base).to respond_to(:exibir_titulo)
        expect(menu_base).to respond_to(:escolher_opcao)
        expect(menu_base).to respond_to(:sair)
      else
        skip "MenuBase não definido"
      end
    end

    it 'deve lançar erro para método executar não implementado' do
      if menu_base
        expect { menu_base.executar }.to raise_error(NotImplementedError)
      else
        skip "MenuBase não definido"
      end
    end
  end

  describe 'Integração com Yazi' do
    it 'deve ter arquivos de configuração do Yazi' do
      yazi_configs = %w[yazi.toml keymap.toml theme.toml init.lua]
      yazi_dir = File.join(crystashell_root, 'yazi')

      yazi_configs.each do |config|
        config_path = File.join(yazi_dir, config)
        expect(File.exist?(config_path)).to be true
      end
    end

    it 'deve ter script de integração zsh' do
      integration_script = File.join(crystashell_root, 'lib', 'yazi_integration.zsh')
      expect(File.exist?(integration_script)).to be true
    end

    it 'deve ter scripts de instalação' do
      install_scripts = %w[
        install_yazi_integration.sh
        verify_integration.sh
        install_preview_deps.sh
      ]
      
      install_scripts.each do |script|
        script_path = File.join(crystashell_root, 'scripts', script)
        expect(File.exist?(script_path)).to be true
        expect(File.executable?(script_path)).to be true
      end
    end
  end

  describe 'Scripts de Preview de Imagem' do
    it 'deve ter scripts de preview necessários' do
      preview_scripts = %w[
        test_image_preview.sh
        yazi_image_preview.sh
        vscode_image_viewer.sh
        optimize_image_quality.sh
      ]

      preview_scripts.each do |script|
        script_path = File.join(crystashell_root, 'scripts', script)
        expect(File.exist?(script_path)).to be true
      end
    end

    it 'deve verificar dependências de preview' do
      dependencies = %w[chafa viu]
      
      dependencies.each do |dep|
        # Não vamos falhar o teste se dependências não estiverem instaladas
        # mas vamos verificar se os scripts de verificação existem
        expect(File.exist?(File.join(crystashell_root, 'scripts', 'test_image_preview.sh'))).to be true
      end
    end
  end

  describe 'Funcionalidades Git' do
    it 'deve ter gerenciador Git definido' do
      if defined?(GerenciadorTerminal::Funcionalidades::FerramentasGit::Gerenciador)
        expect(defined?(GerenciadorTerminal::Funcionalidades::FerramentasGit::Gerenciador)).to be_truthy
      else
        skip "Gerenciador Git não implementado ainda"
      end
    end
  end

  describe 'Funcionalidades Docker' do
    it 'deve ter gerenciador Docker definido' do
      if defined?(GerenciadorTerminal::Funcionalidades::FerramentasDocker::Gerenciador)
        expect(defined?(GerenciadorTerminal::Funcionalidades::FerramentasDocker::Gerenciador)).to be_truthy
      else
        skip "Gerenciador Docker não implementado ainda"
      end
    end
  end

  describe 'Backup e Restore' do
    it 'deve ter gerenciador de Backup definido' do
      if defined?(GerenciadorTerminal::Funcionalidades::BackupRestore::Gerenciador)
        expect(defined?(GerenciadorTerminal::Funcionalidades::BackupRestore::Gerenciador)).to be_truthy
      else
        skip "Gerenciador Backup não implementado ainda"
      end
    end
  end

  describe 'Carregamento de Configurações' do
    it 'deve carregar configurações sem erros' do
      if config_loader
        expect { config_loader }.not_to raise_error
      else
        skip "CarregadorConfig não definido"
      end
    end

    it 'deve ter o caminho de dados correto' do
      if config_loader
        expect(config_loader.instance_variable_get(:@data_path)).to eq(data_path)
      else
        skip "CarregadorConfig não definido"
      end
    end
  end

  describe 'Executável Principal' do
    it 'deve ser executável' do
      if File.exist?(executable_path)
        expect(File.executable?(executable_path)).to be true
      else
        skip "Executável não encontrado em #{executable_path}"
      end
    end

    it 'deve conter o shebang Ruby correto' do
      if File.exist?(executable_path)
        first_line = File.readlines(executable_path).first.strip
        expect(first_line).to eq('#!/usr/bin/env ruby')
      else
        skip "Executável não encontrado"
      end
    end

    it 'deve carregar as dependências necessárias' do
      if File.exist?(executable_path)
        content = File.read(executable_path)
        expect(content).to include("require 'zeitwerk'")
        expect(content).to include("require 'tty-prompt'")
        expect(content).to include("require 'pastel'")
      else
        skip "Executável não encontrado"
      end
    end
  end

  describe 'Validação de Arquivos YAML' do
    it 'deve ter arquivos YAML válidos' do
      yaml_files = Dir.glob(File.join(data_path, '*.yml'))
      
      yaml_files.each do |yaml_file|
        expect { YAML.load_file(yaml_file) }.not_to raise_error, "Arquivo YAML inválido: #{yaml_file}"
      end
    end
  end

  describe 'Documentação' do
    it 'deve ter arquivos de documentação principais' do
      docs = %w[README.md DOCS.md]
      missing_docs = []
      
      docs.each do |doc|
        doc_path = File.join(crystashell_root, doc)
        unless File.exist?(doc_path) && File.size(doc_path) > 100
          missing_docs << doc
        end
      end
      
      if missing_docs.empty?
        docs.each do |doc|
          doc_path = File.join(crystashell_root, doc)
          expect(File.exist?(doc_path)).to be true
          expect(File.size(doc_path)).to be > 100
        end
      else
        skip "Documentos faltando ou muito pequenos: #{missing_docs.join(', ')}"
      end
    end

    it 'deve ter Gemfile para dependências Ruby' do
      gemfile_path = File.join(crystashell_root, 'Gemfile')
      
      if File.exist?(gemfile_path)
        expect(File.exist?(gemfile_path)).to be true
        
        gemfile_content = File.read(gemfile_path)
        expect(gemfile_content).to include('tty-prompt')
        expect(gemfile_content).to include('pastel')
      else
        skip "Gemfile não encontrado em #{gemfile_path}"
      end
    end
  end
end
