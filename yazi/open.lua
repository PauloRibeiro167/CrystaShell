YAZI_CONFIG.open = YAZI_CONFIG.open or {}
YAZI_CONFIG.open.rules = {
  {
    mime = "inode/directory",
    run = function(file)
      yazi.shell('code "' .. file.path .. '"', { block = false, orphan = true })
    end,
    desc = "Abrir pasta no VS Code"
  },
  {
    mime = "*",
    run = function(file)
      yazi.shell('code "' .. file.path .. '"', { block = false, orphan = true })
    end,
    desc = "Abrir arquivo no VS Code"
  }
}