# frozen_string_literal: true

# Configuração adicional para RSpec

RSpec.configure do |config|
  # Configurações de filtros
  config.filter_run_when_matching :focus
  config.run_all_when_everything_filtered = true
  
  # Configurações de formato
  config.color = true
  config.tty = true
  config.formatter = :progress unless ENV['CI']
  
  # Configurações de execução
  config.profile_examples = 10 if ENV['PROFILE']
  config.order = :random
  Kernel.srand config.seed if config.seed
  
  # Configurações de mock
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
    mocks.verify_doubled_constant_names = true
  end
  
  # Configurações de expectativas
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
    expectations.syntax = :expect
  end
  
  # Limpa o terminal antes de executar os testes
  config.before(:suite) do
    puts "\n" + "=" * 80
    puts "🧪 CrystaShell Test Suite"
    puts "🔧 Ruby #{RUBY_VERSION}"
    puts "📅 #{Time.now.strftime('%Y-%m-%d %H:%M:%S')}"
    puts "=" * 80 + "\n"
  end
  
  # Mostra resumo após execução
  config.after(:suite) do |_|
    puts "\n" + "=" * 80
    puts "✅ Testes finalizados em #{Time.now.strftime('%H:%M:%S')}"
    puts "=" * 80 + "\n"
  end
  
  # Configurações específicas por tipo de teste
  config.define_derived_metadata(file_path: %r{/spec/integration/}) do |metadata|
    metadata[:type] = :integration
  end
  
  config.define_derived_metadata(file_path: %r{/spec/unit/}) do |metadata|
    metadata[:type] = :unit
  end
  
  # Helper para limpar arquivos temporários
  config.after(:each) do
    # Limpa arquivos temporários criados durante os testes
    temp_files = Dir.glob("/tmp/crystashell_test_*")
    temp_files.each { |file| File.delete(file) if File.exist?(file) }
  end
end

# Helpers globais para testes
def crystashell_root
  @crystashell_root ||= File.expand_path('..', __dir__)
end

def executable_path
  @executable_path ||= File.join(crystashell_root, 'bin', 'gerenciador_terminal')
end

def fixtures_path
  @fixtures_path ||= File.join(__dir__, 'fixtures')
end

def create_temp_config(content, filename = 'test_config.yml')
  temp_file = "/tmp/crystashell_test_#{filename}_#{Time.now.to_i}"
  File.write(temp_file, content)
  temp_file
end

def mock_tty_prompt_responses(responses = {})
  prompt = instance_double(TTY::Prompt)
  
  responses.each do |method, response|
    allow(prompt).to receive(method).and_return(response)
  end
  
  # Métodos comuns sempre disponíveis
  allow(prompt).to receive(:say)
  allow(prompt).to receive(:warn)
  allow(prompt).to receive(:error)
  allow(prompt).to receive(:ok)
  
  prompt
end
