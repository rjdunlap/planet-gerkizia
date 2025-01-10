--data.lua

--START MAP GEN
function MapGen_Gerkizia()
    -- Nauvis-based generation
    local map_gen_setting = table.deepcopy(data.raw.planet.nauvis.map_gen_settings)
    map_gen_setting.water = "very high"
    --map_gen_setting.property_expression_names.elevation = "gerkizia"

    map_gen_setting.autoplace_settings.entity.settings = {
        ["uranium-ore"] = {}
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

local gerkizia_connection = {
    type = "space-connection",
    name = "nauvis-gerkizia",
    from = "nauvis",
    to = "gerkizia",
    subgroup = data.raw["space-connection"]["nauvis-vulcanus"].subgroup,
    length = 15000
  
  }

PlanetsLib:extend({gerkizia})

data:extend{gerkizia_connection}

APS.add_planet{name = "gerkizia", filename = "__planet-gerkizia__/data.lua"}