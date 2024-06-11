---@diagnostic disable:undefined-global

local function get_raw_ore_name(name)
    if smm_compat.mtg_available then return name .. "_lump" end
    if smm_compat.mcl_available then return "raw_" .. name end
end
local function get_raw_ore_description(display_name)
    if smm_compat.mtg_available then return display_name .. " Lump" end
    if smm_compat.mcl_available then return "Raw " .. display_name end
end
local function get_raw_ore_node_name(name) return get_raw_ore_name(name) .. "_block" end
local function get_raw_ore_node_description(display_name)
    if smm_compat.mtg_available then return get_raw_ore_description(display_name) .. " Block" end
    if smm_compat.mcl_available then return "Block of " .. get_raw_ore_description(display_name) end
end
local function get_raw_ore_node_groups(hardness)
    if smm_compat.mtg_available then return { cracky = hardness, level = 1 } end
    if smm_compat.mcl_available then return { pickaxey = 2, building_block = 1, blast_furnace_smeltable = 1 } end
end
local function get_ingot_name(name) return name .. "_ingot" end
local function get_ingot_description(display_name) return display_name .. " Ingot" end
local function get_ingot_node_name(name) return name .. "block" end
local function get_ingot_node_description(display_name)
    if smm_compat.mtg_available then return display_name .. " Block" end
    if smm_compat.mcl_available then return "Block of " .. display_name end
end
local function get_ingot_node_groups(hardness)
    if smm_compat.mtg_available then return { cracky = hardness, level = 2 } end
    if smm_compat.mcl_available then return { pickaxey = 2, building_block = 1 } end
end
local function get_ore_node_name(name) return "stone_with_" .. name end
local function get_ore_node_description(display_name) return display_name .. " Ore" end
local function get_ore_wherein()
    if smm_compat.mtg_available then return smm_compat.itemstring.stone end
    if smm_compat.mcl_available then
        return {
            smm_compat.itemstring.stone,
            smm_compat.itemstring.diorite,
            smm_compat.itemstring.andesite,
            smm_compat.itemstring.granite,
        }
    end
end
local function get_ore_node_drop(name, drop_raw_ore)
    return minetest.get_current_modname() .. ":" .. (drop_raw_ore and get_raw_ore_name(name) or name)
end
local function get_ore_node_groups(hardness)
    if smm_compat.mtg_available then return { cracky = hardness, level = 1 } end
    if smm_compat.mcl_available then return { pickaxey = 3, building_block = 1, material_stone = 1, blast_furnace_smeltable = 1 } end
end
local function get_deepslate_ore_node_name(name) return "deepslate_with_" .. name end
local function get_deepslate_ore_node_description(display_name) return "Deepslate " .. display_name .. " Ore" end
local function get_deepslate_ore_node_drop(name, drop_raw_ore) return get_ore_node_drop(name, drop_raw_ore) end
local function get_deepslate_ore_node_groups(hardness) return get_ore_node_groups(hardness) end

function smm_material.register_raw_ore_craftitem(name, display_name)
    local mod_name = minetest.get_current_modname()
    local translator = minetest.get_translator(mod_name)
    local craftitem_name = get_raw_ore_name(name)
    local craftitem_description = get_raw_ore_description(display_name)

    minetest.register_craftitem(mod_name .. ":" .. craftitem_name, {
        description = translator(craftitem_description),
        inventory_image = mod_name .. "_" .. smm_compat.texture_prefix .. "_" .. craftitem_name .. ".png"
    })
end

function smm_material.register_raw_ore_shapeless_craft(name)
    local mod_name = minetest.get_current_modname()

    minetest.register_craft({
        type = "shapeless",
        output = mod_name .. ":" .. get_raw_ore_name(name) .. " 9",
        recipe = { mod_name .. ":" .. get_raw_ore_node_name(name) }
    })
end

function smm_material.register_raw_ore_node(name, display_name, hardness, blast_resistance)
    local mod_name = minetest.get_current_modname()
    local translator = minetest.get_translator(mod_name)
    local node_name = get_raw_ore_node_name(name)
    local node_description = get_raw_ore_node_description(display_name)

    local definition = {
        description = translator(node_description),
        tiles = { mod_name .. "_" .. smm_compat.texture_prefix .. "_" .. node_name .. ".png" },
        groups = get_raw_ore_node_groups(hardness),
        sounds = smm_compat.sound.node_sound_stone_defaults(),
    }
    if smm_compat.mcl_available then
        definition._mcl_hardness = hardness
        definition._mcl_blast_resistance = blast_resistance
    end

    minetest.register_node(mod_name .. ":" .. node_name, definition)
end

function smm_material.register_raw_ore_node_shaped_craft(name)
    local mod_name = minetest.get_current_modname()
    local raw_ore_itemstring = mod_name .. ":" .. get_raw_ore_name(name)

    minetest.register_craft({
        type = "shaped",
        output = mod_name .. ":" .. get_raw_ore_node_name(name),
        recipe = {
            { raw_ore_itemstring, raw_ore_itemstring, raw_ore_itemstring },
            { raw_ore_itemstring, raw_ore_itemstring, raw_ore_itemstring },
            { raw_ore_itemstring, raw_ore_itemstring, raw_ore_itemstring },
        }
    })
end

function smm_material.register_raw_ore(name, display_name, hardness, blast_resistance)
    -- Craftitems/Nodes
    smm_material.register_raw_ore_craftitem(name, display_name)
    smm_material.register_raw_ore_node(name, display_name, hardness, blast_resistance)
    -- Crafts
    smm_material.register_raw_ore_shapeless_craft(name)
    smm_material.register_raw_ore_node_shaped_craft(name)
end

function smm_material.register_ingot_craftitem(name, display_name)
    local mod_name = minetest.get_current_modname()
    local translator = minetest.get_translator(mod_name)
    local craftitem_name = get_ingot_name(name)
    local craftitem_description = get_ingot_description(display_name)

    minetest.register_craftitem(mod_name .. ":" .. craftitem_name, {
        description = translator(craftitem_description),
        inventory_image = mod_name .. "_" .. smm_compat.texture_prefix .. "_" .. craftitem_name .. ".png"
    })
end

function smm_material.register_ingot_shapeless_craft(name)
    local mod_name = minetest.get_current_modname()

    minetest.register_craft({
        type = "shapeless",
        output = mod_name .. ":" .. get_ingot_name(name) .. " 9",
        recipe = { mod_name .. ":" .. get_ingot_node_name(name) }
    })
end

function smm_material.register_ingot_smelting_crafts(name)
    local mod_name = minetest.get_current_modname()
    local ingot_itemstring = mod_name .. ":" .. get_ingot_name(name)

    minetest.register_craft({
        type = "cooking",
        output = ingot_itemstring,
        recipe = mod_name .. ":" .. get_raw_ore_name(name),
        cooktime = 10,
    })
    minetest.register_craft({
        type = "cooking",
        output = ingot_itemstring,
        recipe = mod_name .. ":" .. get_ore_node_name(name),
        cooktime = 10,
    })

    if smm_compat.mcl_available then
        minetest.register_craft({
            type = "cooking",
            output = ingot_itemstring,
            recipe = mod_name .. ":" .. get_deepslate_ore_node_name(name),
            cooktime = 10,
        })
    end
end

function smm_material.register_ingot_node(name, display_name, hardness, blast_resistance)
    local mod_name = minetest.get_current_modname()
    local translator = minetest.get_translator(mod_name)
    local node_name = get_ingot_node_name(name)
    local node_description = get_ingot_node_description(display_name)

    local definition = {
        description = translator(node_description),
        tiles = { mod_name .. "_" .. smm_compat.texture_prefix .. "_" .. node_name .. ".png" },
        groups = get_ingot_node_groups(hardness),
        sounds = smm_compat.sound.node_sound_metal_defaults(),
    }
    if smm_compat.mcl_available then
        definition._mcl_hardness = hardness
        definition._mcl_blast_resistance = blast_resistance
    end

    minetest.register_node(mod_name .. ":" .. node_name, definition)
end

function smm_material.register_ingot_node_shaped_craft(name)
    local mod_name = minetest.get_current_modname()
    local ingot_itemstring = mod_name .. ":" .. get_ingot_name(name)

    minetest.register_craft({
        type = "shaped",
        output = mod_name .. ":" .. get_ingot_node_name(name),
        recipe = {
            { ingot_itemstring, ingot_itemstring, ingot_itemstring },
            { ingot_itemstring, ingot_itemstring, ingot_itemstring },
            { ingot_itemstring, ingot_itemstring, ingot_itemstring },
        }
    })
end

function smm_material.register_ingot_node_smelting_craft(name)
    local mod_name = minetest.get_current_modname()

    minetest.register_craft({
        type = "cooking",
        output = mod_name .. ":" .. get_ingot_node_name(name),
        recipe = mod_name .. ":" .. get_raw_ore_node_name(name),
        cooktime = 90,
    })
end

function smm_material.register_ingot(name, display_name, hardness, blast_resistance)
    -- Craftitems/Nodes
    smm_material.register_ingot_craftitem(name, display_name)
    smm_material.register_ingot_node(name, display_name, hardness, blast_resistance)
    -- Crafts
    smm_material.register_ingot_shapeless_craft(name)
    smm_material.register_ingot_node_shaped_craft(name)
end

function smm_material.register_smeltable_ingot(name, display_name, hardness, blast_resistance)
    -- Craftitems/Nodes
    smm_material.register_ingot_craftitem(name, display_name)
    smm_material.register_ingot_node(name, display_name, hardness, blast_resistance)
    -- Crafts
    smm_material.register_ingot_shapeless_craft(name)
    smm_material.register_ingot_smelting_crafts(name)
    smm_material.register_ingot_node_shaped_craft(name)
    smm_material.register_ingot_node_smelting_craft(name)
end

if smm_compat.mcl_available then
    local function get_nugget_name(name) return name .. "_nugget" end
    local function get_nugget_description(display_name) return display_name .. " Nugget" end

    function smm_material.register_ingot_shaped_craft(name)
        local mod_name = minetest.get_current_modname()
        local nugget_itemstring = mod_name .. ":" .. get_nugget_name(name)

        minetest.register_craft({
            type = "shaped",
            output = mod_name .. ":" .. get_ingot_name(name),
            recipe = {
                { nugget_itemstring, nugget_itemstring, nugget_itemstring },
                { nugget_itemstring, nugget_itemstring, nugget_itemstring },
                { nugget_itemstring, nugget_itemstring, nugget_itemstring },
            }
        })
    end

    function smm_material.register_nugget_craftitem(name, display_name)
        local mod_name = minetest.get_current_modname()
        local translator = minetest.get_translator(mod_name)
        local craftitem_name = get_nugget_name(name)
        local craftitem_description = get_nugget_description(display_name)

        minetest.register_craftitem(mod_name .. ":" .. craftitem_name, {
            description = translator(craftitem_description),
            inventory_image = mod_name .. "_" .. smm_compat.texture_prefix .. "_" .. craftitem_name .. ".png"
        })
    end

    function smm_material.register_nugget_shapeless_craft(name)
        local mod_name = minetest.get_current_modname()

        minetest.register_craft({
            type = "shapeless",
            output = mod_name .. ":" .. get_nugget_name(name) .. " 9",
            recipe = { mod_name .. ":" .. get_ingot_name(name) }
        })
    end

    function smm_material.register_nugget(name, display_name)
        -- Craftitems/Nodes
        smm_material.register_nugget_craftitem(name, display_name)
        -- Crafts
        smm_material.register_ingot_shaped_craft(name)
        smm_material.register_nugget_shapeless_craft(name)
    end
end

function smm_material.register_ore_mapgen(name, clust_scarcity, clust_num_ores, clust_size, y_min, y_max)
    local mod_name = minetest.get_current_modname()
    local node_name = get_ore_node_name(name)

    minetest.register_ore({
        ore = mod_name .. ":" .. node_name,
        ore_type = "scatter",
        clust_scarcity = clust_scarcity,
        clust_num_ores = clust_num_ores,
        clust_size = clust_size,
        y_min = y_min,
        y_max = y_max,
        wherein = get_ore_wherein()
    })
end

function smm_material.register_ore_node(name, display_name, hardness, blast_resistance, drop_raw_ore)
    local mod_name = minetest.get_current_modname()
    local translator = minetest.get_translator(mod_name)
    local node_name = get_ore_node_name(name)
    local node_description = get_ore_node_description(display_name)

    local definition = {
        description = translator(node_description),
        tiles = { smm_compat.tile.stone .. "^" .. mod_name .. "_" .. smm_compat.texture_prefix .. "_" .. node_name .. ".png" },
        is_ground_content = true,
        drop = get_ore_node_drop(name, drop_raw_ore),
        groups = get_ore_node_groups(hardness),
        sounds = smm_compat.sound.node_sound_stone_defaults(),
    }
    if smm_compat.mcl_available then
        definition._mcl_hardness = hardness
        definition._mcl_blast_resistance = blast_resistance
        definition._mcl_silk_touch_drop = true
        definition._mcl_fortune_drop = mcl_core.fortune_drop_ore
    end

    minetest.register_node(mod_name .. ":" .. node_name, definition)
end

function smm_material.register_ore(
    name,
    display_name,
    hardness,
    blast_resistance,
    drop_raw_ore,
    clust_scarcity,
    clust_num_ores,
    clust_size,
    y_min,
    y_max
)
    smm_material.register_ore_node(name, display_name, hardness, blast_resistance, drop_raw_ore)
    smm_material.register_ore_mapgen(name, clust_scarcity, clust_num_ores, clust_size, y_min, y_max)
end

if smm_compat.mcl_available then
    function smm_material.register_deepslate_ore_mapgen(name, clust_scarcity, clust_num_ores, clust_size, y_min, y_max)
        local mod_name = minetest.get_current_modname()
        local node_name = get_deepslate_ore_node_name(name)

        minetest.register_ore({
            ore = mod_name .. ":" .. node_name,
            ore_type = "scatter",
            clust_scarcity = clust_scarcity,
            clust_num_ores = clust_num_ores,
            clust_size = clust_size,
            y_min = y_min,
            y_max = y_max,
            wherein = {
                smm_compat.itemstring.deepslate,
                smm_compat.itemstring.tuff,
            }
        })
    end

    function smm_material.register_deepslate_ore_node(name, display_name, hardness, blast_resistance, drop_raw_ore)
        local mod_name = minetest.get_current_modname()
        local translator = minetest.get_translator(mod_name)
        local node_name = get_deepslate_ore_node_name(name)
        local node_description = get_deepslate_ore_node_description(display_name)

        minetest.register_node(mod_name .. ":" .. node_name, {
            description = translator(node_description),
            tiles = {
                (smm_compat.tile.deepslate_top .. "^" .. mod_name .. "_" .. smm_compat.texture_prefix .. "_" .. node_name .. ".png"),
                (smm_compat.tile.deepslate_top .. "^" .. mod_name .. "_" .. smm_compat.texture_prefix .. "_" .. node_name .. ".png"),
                (smm_compat.tile.deepslate .. "^" .. mod_name .. "_" .. smm_compat.texture_prefix .. "_" .. node_name .. ".png"),
            },
            paramtype2 = "facedir",
            is_ground_content = true,
            drop = get_deepslate_ore_node_drop(name, drop_raw_ore),
            on_place = mcl_util.rotate_axis,
            groups = get_deepslate_ore_node_groups(hardness),
            sounds = smm_compat.sound.node_sound_stone_defaults(),
            _mcl_hardness = hardness,
            _mcl_blast_resistance = blast_resistance,
            _mcl_silk_touch_drop = true,
            _mcl_fortune_drop = mcl_core.fortune_drop_ore,
        })
    end

    function smm_material.register_deepslate_ore(
        name,
        display_name,
        hardness,
        blast_resistance,
        drop_raw_ore,
        clust_scarcity,
        clust_num_ores,
        clust_size,
        y_min,
        y_max
    )
        smm_material.register_deepslate_ore_node(name, display_name, hardness, blast_resistance, drop_raw_ore)
        smm_material.register_deepslate_ore_mapgen(name, clust_scarcity, clust_num_ores, clust_size, y_min, y_max)
    end
end
