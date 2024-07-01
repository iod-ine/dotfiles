Organize the plugins across multiple files.
When lazy.nvim is set up to take the spec from this module, all specs returned by top-level submodules in here will be merged into the final spec.

```lua
{
    "repository/plugin.nvim",
    init = function()
        -- init is called during startup, before the plugin is loaded.
        -- Can be used to set up configuration required for plugins.
    end,
    config = function()
        -- config is called after the plugin is loaded.
        -- Can be used to set up configuration involving the plugin.
    end,
}
```
