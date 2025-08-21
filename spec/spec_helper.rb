require 'rspec'
require 'open3'
require 'fileutils'
require 'yaml'
require 'json'
require 'colorize'
require 'timeout'

# Carrega arquivos de suporte
Dir[File.join(__dir__, 'support', '**', '*.rb')].each { |f| require f }

def run_command(cmd, timeout_seconds: 10)
  Timeout::timeout(timeout_seconds) do
    stdout, stderr, status = Open3.capture3(cmd)
    
    if status.success?
      stdout
    else
      "#{stdout}#{stderr}"
    end
  end
rescue Timeout::Error
  "Command timed out: #{cmd}"
end

def check_dependency(command)
  result = run_command("which #{command}")
  !result.include?('not found') && !result.include?('timed out')
end

def check_file_exists(path)
  File.exist?(File.expand_path(path))
end

def check_yazi_config
  config_path = File.expand_path('~/.config/yazi/yazi.toml')
  File.exist?(config_path)
end
