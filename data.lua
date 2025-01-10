--data.lua
local asteroid_util = require("__space-age__.prototypes.planet.asteroid-spawn-definitions")


--START MAP GEN
function MapGen_Gerkizia()
    -- Nauvis-based generation
    local map_gen_setting = table.deepcopy(data.raw.planet.nauvis.map_gen_settings)
    --map_gen_setting.property_expression_names.elevation = "lakes"

    --map_gen_setting.terrain_segmentation = "very-high"

    map_gen_setting.autoplace_controls = {
        ["stone"] = { frequency = 9, size = 9, richness = 12 },
        ["iron-ore"] = { frequency = 6, size = 6, richness = 6 },
        ["coal"] = { frequency = 6, size = 6, richness = 6 },
        ["copper-ore"] = { frequency = 6, size = 6, richness = 6 },
        ["crude-oil"] = { frequency = 6, size = 6, richness = 6 },
        ["trees"] = { frequency = 6, size = 6, richness = 6 },
        ["water"] = { frequency = 12, size = 6, richness = 6 },
        ["uranium-ore"] = { frequency = 0, size = 0, richness = 0 },
    }
    return map_gen_setting
end
-- increse stone patch size in start area
-- data.raw["resource"]["stone"]["autoplace"]["starting_area_size"] = 5500 * (0.005 / 3)

--END MAP GEN

local nauvis = data.raw["planet"]["nauvis"]
local planet_lib = require("__PlanetsLib__.lib.planet")

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
    map_gen_settings = MapGen_Gerkizia()
}

gerkizia.orbit = {
    parent = {
        type = "space-location",
        name = "star",
    },
    distance = 1,
    orientation = 0.78
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