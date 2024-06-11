---@diagnostic disable:undefined-global
local MOD_NAME = minetest.get_current_modname()
local MOD_PATH = minetest.get_modpath(MOD_NAME)

smm_material = {}
dofile(MOD_PATH .. "/mineral.lua")

-- Register tin items if mineclonia is detected, tin is provided by default in minetest game but not mineclonia
if smm_compat.mcl_available then
    local tin_name = "tin"
    local tin_display_name = "Tin"
    local tin_clust_scarcity = 10 * 10 * 10
    local tin_clust_size = 5
    local tin_clust_num_ores = 3

    smm_material.register_raw_ore(tin_name, tin_display_name, 3, 3)
    smm_material.register_smeltable_ingot(tin_name, tin_display_name, 4, 4)
    smm_material.register_ore(
        tin_name, tin_display_name, 4, 4, true,
        tin_clust_scarcity, tin_clust_num_ores, tin_clust_size, mcl_vars.mg_overworld_min, mcl_worlds.layer_to_y(39)
    )
    smm_material.register_deepslate_ore(
        tin_name, tin_display_name, 4, 4, true,
        tin_clust_scarcity, tin_clust_num_ores, tin_clust_size, mcl_vars.mg_overworld_min, mcl_worlds.layer_to_y(16)
    )
end
