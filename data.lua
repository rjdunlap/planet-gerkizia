--data.lua
local asteroid_util = require("__space-age__.prototypes.planet.asteroid-spawn-definitions")


--START MAP GEN
function MapGen_Gerkizia()
    -- Nauvis-based generation
    local map_gen_setting = table.deepcopy(data.raw.planet.nauvis.map_gen_settings)

    map_gen_setting.autoplace_controls = {
        ["stone"] = { frequency = 9, size = 4, richness = 6 },
        ["iron-ore"] = { frequency = 6, size = 4, richness = 3 },
        ["coal"] = { frequency = 6, size = 4, richness = 3 },
        ["copper-ore"] = { frequency = 6, size = 4, richness = 3 },
        ["crude-oil"] = { frequency = 6, size = 4, richness = 4 },
        ["trees"] = { frequency = 6, size = 4, richness = 6 },
        ["water"] = { frequency = 12, size = 6, richness = 6 },
    }
    map_gen_setting.territory_settings = {
      units = {"small-demolisher", "medium-demolisher", "big-demolisher"},
      territory_index_expression = "demolisher_territory_expression",
      territory_variation_expression = "demolisher_variation_expression",
      minimum_territory_size = 10
    }
    return map_gen_setting
end

--END MAP GEN

local nauvis = data.raw["planet"]["nauvis"]
local planet_lib = require("__PlanetsLib__.lib.planet")
local start_astroid_spawn_rate =
{
  probability_on_range_chunk =
  {
    {position = 0.1, probability = asteroid_util.nauvis_chunks, angle_when_stopped = asteroid_util.chunk_angle},
    {position = 0.9, probability = asteroid_util.gleba_chunks, angle_when_stopped = asteroid_util.chunk_angle}
  },
  type_ratios =
  {
    {position = 0.1, ratios = asteroid_util.nauvis_ratio},
    {position = 0.9, ratios = asteroid_util.gleba_ratio},
  }
}
local start_astroid_spawn = asteroid_util.spawn_definitions(start_astroid_spawn_rate, 0.1)

local gerkizia= 
{
    type = "planet",
    name = "gerkizia", 
    solar_power_in_space = nauvis.solar_power_in_space,
    icon = "__planet-gerkizia__/graphics/planet-gerkizia.png",
    icon_size = 512,
    label_orientation = 0.55,
    starmap_icon = "__planet-gerkizia__/graphics/planet-gerkizia.png",
    starmap_icon_size = 512,
    magnitude = nauvis.magnitude,
    surface_properties = {
        ["solar-power"] = 100,
        ["pressure"] = nauvis.surface_properties["pressure"],
        ["magnetic-field"] = nauvis.surface_properties["magnetic-field"],
        ["day-night-cycle"] = nauvis.surface_properties["day-night-cycle"],
    },
    map_gen_settings = MapGen_Gerkizia(),
    asteroid_spawn_influence = 1,
    asteroid_spawn_definitions = start_astroid_spawn,
    pollutant_type = "pollution"
    
}

gerkizia.orbit = {
    parent = {
        type = "space-location",
        name = "star",
    },
    distance = 16,
    orientation = 0.34
}

local gerkizia_connection = {
    type = "space-connection",
    name = "nauvis-gerkizia",
    from = "nauvis",
    to = "gerkizia",
    subgroup = data.raw["space-connection"]["nauvis-vulcanus"].subgroup,
    length = 15000,
    asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_gleba),
  }

PlanetsLib:extend({gerkizia})
PlanetsLib.borrow_music(data.raw["planet"]["nauvis"], gerkizia)


data:extend{gerkizia_connection}

data:extend {{
    type = "technology",
    name = "planet-discovery-gerkizia",
    icons = util.technology_icon_constant_planet("__planet-gerkizia__/graphics/planet-gerkizia.png"),
    icon_size = 256,
    essential = true,
    localised_description = {"space-location-description.gerkizia"},
    effects = {
        {
            type = "unlock-space-location",
            space_location = "gerkizia",
            use_icon_overlay_constant = true
        },
    },
    prerequisites = {
        "space-science-pack",
    },
    unit = {
        count = 200,
        ingredients = {
            {"automation-science-pack",      1},
            {"logistic-science-pack",        1},
            {"chemical-science-pack",        1},
            {"space-science-pack",           1}
        },
        time = 60,
    },
    order = "ea[gerkizia]",
}}


APS.add_planet{name = "gerkizia", filename = "__planet-gerkizia__/gerkizia.lua", technology = "planet-discovery-gerkizia"}