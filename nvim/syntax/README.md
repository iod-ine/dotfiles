Custom syntax highlighting files can be placed here.
Set the mappings from file patterns to file types in `lua/config/filetypes.lua`.

```lua
vim.filetype.add({
    extension = {
        yql = "yql",
    },
    filename = {
        ["ya.make"] = "yamake",
    },
})
```
