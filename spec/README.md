# 🧪 Testes do CrystaShell

Este diretório contém todos os testes para o projeto CrystaShell.

## 📋 Estrutura dos Testes

```
spec/
├── spec_helper.rb                    # Configurações globais do RSpec
├── crystashell_funcionalidades_spec.rb  # Testes principais das funcionalidades
├── quick_status_spec.rb             # Testes de status rápido
└── support/                         # Arquivos de suporte
    ├── coverage.rb                  # Configuração de cobertura de código
    └── helpers.rb                   # Métodos auxiliares para testes
```

## 🚀 Como Executar os Testes

### Comando Básico
```bash
# Executa todos os testes
bin/test

# Alternativa usando bundle
bundle exec rspec
```

### Opções Avançadas

```bash
# Executa teste específico
bin/test spec/crystashell_funcionalidades_spec.rb

# Executa testes com padrão específico
bin/test -p "Temas"

# Formato de documentação
bin/test -f doc

# Com cobertura de código
bin/test -c

# Para na primeira falha
bin/test --fail-fast

# Mostra os testes mais lentos
bin/test --profile

# Saída verbosa
bin/test -v

# Com seed específico para reproduzir ordem
bin/test -s 12345
```

### Exemplos de Uso

```bash
# Executa apenas testes relacionados a temas
bin/test -p "Gerenciamento de Temas"

# Executa com cobertura e para na primeira falha
bin/test -c --fail-fast

# Executa teste específico com formato doc
bin/test spec/crystashell_funcionalidades_spec.rb -f doc

# Debug de testes com saída verbosa
bin/test -v --profile
```

## 📊 Cobertura de Código

Para executar os testes com análise de cobertura:

```bash
bin/test -c
```

O relatório será gerado em `coverage/index.html` e pode ser visualizado no navegador.

### Métricas de Cobertura

- **Meta mínima**: 70%
- **Grupos monitorados**:
  - Main (lib/gerenciador_terminal/main)
  - Interface (lib/gerenciador_terminal/interface)
  - Funcionalidades (lib/gerenciador_terminal/funcionalidades)
  - CLI (lib/gerenciador_terminal/cli)
  - Scripts (lib/scripts)

## 🔧 Configuração dos Testes

### RSpec
- **Formato padrão**: Progress
- **Ordem**: Aleatória
- **Cores**: Habilitadas
- **Profile**: Top 10 testes mais lentos (quando solicitado)

### Variáveis de Ambiente
- `CRYSTASHELL_ENV=test` - Define ambiente de teste
- `CRYSTASHELL_ROOT` - Caminho raiz do projeto
- `PROFILE=true` - Habilita profiling automático

## 🧰 Helpers Disponíveis

### Métodos Globais
- `crystashell_root` - Retorna o diretório raiz do projeto
- `executable_path` - Caminho para o executável principal
- `fixtures_path` - Diretório de fixtures de teste
- `create_temp_config(content, filename)` - Cria arquivo temporário de configuração
- `mock_tty_prompt_responses(responses)` - Mock para TTY::Prompt

### Exemplo de Uso dos Helpers

```ruby
describe 'Meu Teste' do
  it 'deve usar helpers' do
    # Criar configuração temporária
    temp_config = create_temp_config("test: true", "my_test.yml")
    
    # Mock de prompt
    prompt = mock_tty_prompt_responses(
      select: "Opção 1",
      yes?: true
    )
    
    # Usar em seus testes...
  end
end
```

## 🐛 Debugging

### Executar com Pry
```bash
# Adicione 'binding.pry' no seu código de teste
bin/test spec/meu_teste_spec.rb
```

### Logs de Debug
```bash
# Saída verbosa com detalhes
bin/test -v

# Com informações de profile
bin/test --profile
```

## 📝 Escrevendo Novos Testes

### Estrutura Recomendada

```ruby
require 'spec_helper'

RSpec.describe 'MinhaFuncionalidade' do
  let(:config_path) { File.join(crystashell_root, 'config') }
  let(:prompt) { mock_tty_prompt_responses }

  describe '#metodo_especifico' do
    context 'quando condição X' do
      it 'deve fazer Y' do
        # Arrange
        setup_data
        
        # Act
        result = subject.metodo_especifico
        
        # Assert
        expect(result).to eq(expected_value)
      end
    end
  end
end
```

### Boas Práticas

1. **Use `let` para setup**: Mais limpo que `before`
2. **Descreva contextos**: Use `context` para diferentes cenários
3. **Testes unitários**: Teste uma coisa por vez
4. **Mocks apropriados**: Use mocks para dependências externas
5. **Cleanup**: Limpe arquivos temporários após testes

## 🚨 Problemas Comuns

### Dependências não instaladas
```bash
bundle install
```

### Permissões do executável
```bash
chmod +x bin/test
```

### Arquivos temporários não limpos
Os testes automaticamente limpam arquivos temporários em `/tmp/crystashell_test_*`

### Falhas aleatórias
Use seed específico para reproduzir:
```bash
bin/test -s 12345
```

## 📈 Integração Contínua

Para usar em CI/CD:

```bash
# Formato JSON para parsing
bin/test -f json

# Sem TTY para CI
TERM=dumb bin/test

# Com cobertura obrigatória
bin/test -c --fail-fast
```

## 🔍 Análise de Performance

```bash
# Top 10 testes mais lentos
bin/test --profile

# Com seed para consistência
bin/test --profile -s 42
```

---

**💡 Dica**: Execute `bin/test -h` para ver todas as opções disponíveis!
