local utils = require("__any-planet-start__.utils")

utils.set_prerequisites("steel-processing", nil)
utils.set_prerequisites("landfill", nil)
utils.set_prerequisites("electric-energy-distribution-1", nil)

utils.set_trigger("landfill", {type = "craft-item", item = "stone-brick", count = 50})
utils.set_trigger("steel-processing", {type = "craft-item", item = "iron-plate", count = 10})
utils.set_trigger("electric-energy-distribution-1", {type = "craft-item", item = "steel-plate", count = 50})
