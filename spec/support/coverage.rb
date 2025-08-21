# frozen_string_literal: true

require 'simplecov'

SimpleCov.start do
  add_filter '/spec/'
  add_filter '/vendor/'
  add_filter '/.bundle/'
  
  add_group 'Main', 'lib/gerenciador_terminal/main'
  add_group 'Interface', 'lib/gerenciador_terminal/interface'
  add_group 'Funcionalidades', 'lib/gerenciador_terminal/funcionalidades'
  add_group 'CLI', 'lib/gerenciador_terminal/cli'
  add_group 'Scripts', 'lib/scripts'
  
  minimum_coverage 70
  
  # Formato de saída
  formatter SimpleCov::Formatter::MultiFormatter.new([
    SimpleCov::Formatter::HTMLFormatter,
    SimpleCov::Formatter::SimpleFormatter
  ])
  
  # Diretório de saída
  coverage_dir 'coverage'
end

puts "📊 Cobertura de código habilitada com SimpleCov"
