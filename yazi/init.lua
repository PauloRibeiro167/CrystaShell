-- CrystaShell - Configuração Lua do Yazi
-- Protocolo de imagens otimizado para VS Code

-- Configurar protocolo de imagem baseado no terminal
local function setup_image_protocol()
    local term_program = os.getenv("TERM_PROGRAM")
    local term = os.getenv("TERM")
    
    -- Configurações específicas para VS Code
    if term_program == "vscode" then
        -- Otimizar para VS Code terminal
        return {
            protocol = "chafa",
            max_width = 120,
            max_height = 30,
            quality = 95,
            format = "truecolor"
        }
    elseif term_program == "iTerm.app" then
        -- iTerm2 - usar protocolo nativo
        return {
            protocol = "iterm2",
            max_width = 200,
            max_height = 50,
            quality = 95,
            format = "iterm2"
        }
    else
        -- Fallback - usar chafa
        return {
            protocol = "chafa",
            max_width = 100,
            max_height = 25,
            quality = 85,
            format = "256"
        }
    end
end

-- Função para otimizar preview de imagens
local function optimize_image_preview()
    local config = setup_image_protocol()
    
    -- Log para debug
    ya.dbg("Yazi Image Config: " .. config.protocol .. " - " .. config.format)
    
    return config
end

-- Configuração principal
local function setup()
    -- Aplicar configurações de imagem
    local image_config = optimize_image_preview()
    
    -- Configurar cache de imagens otimizado
    if ya.preview then
        ya.preview.image_cache_size = 50
        ya.preview.image_cleanup_on_exit = true
    end
end

-- Chama a configuração
setup()
