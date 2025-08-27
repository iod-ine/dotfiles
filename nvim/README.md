- `init.lua` is the entry point for Neovim.
- `lua/` contains requireable Lua scripts that are run only when `:lua require()`d.
- `plugin/` contains scripts that will be automatically executed during startup.

`require("something")` can mean one of two things:
- `lua/something.lua`
- `lua/something/init.lua`

`require("something.utils")` means `lua/something/utils.lua`.

`require()` treats each script as a function and caches whatever it returns: the same file won't be executed twice.
