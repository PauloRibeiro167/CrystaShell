# frozen_string_literal: true

# filepath: /home/paulo/projetos/CrystaShell/scripts/export_theme.rb
require 'yaml'

themes_file = File.expand_path('../../lib/gerenciador_terminal/data/themes.yml', __dir__)
theme_name = ENV['CRYSTASHELL_THEME'] || 'Padrão'
themes = YAML.load_file(themes_file)['temas']
theme = themes.find { |t| t['nome'] == theme_name }

if theme
  puts "export PROMPT_COLOR=\"#{theme['prompt_cor']}\""
  puts "export BACKGROUND_COLOR=\"#{theme['fundo_cor']}\""
  puts "export SUCCESS_COLOR=\"#{theme['sucesso_cor']}\""
  puts "export ERROR_COLOR=\"#{theme['erro_cor']}\""
  puts "export HIGHLIGHT_COLOR=\"#{theme['destaque_cor']}\""
end
