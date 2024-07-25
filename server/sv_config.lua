--[[ ===================================================== ]] --
--[[             MH RP Trunks Script by MaDHouSe           ]] --
--[[ ===================================================== ]] --
SV_Config = {}

SV_Config.Animations = {
    bag = {
        pickup = {
            lib = "missfbi4prepp1",
            anim = "_bag_walk_garbage_man",
            prop = "prop_money_bag_01",
            bone = 57005,
            coords = vector3(0.29, -0.29, -0.28),
            rotation = vector3(-44.56, -35.52, 0.0)
        },
        drop = {
            lib = "missfbi4prepp1",
            anim = "exit"
        }
    },
    box = {
        pickup = {
            lib = "anim@heists@box_carry@",
            anim = "idle",
            prop = "v_ind_cf_chckbox2",
            bone = 60309,
            coords = vector3(0.2, 0.08, 0.2),
            rotation = vector3(-45.0, 290.0, 0.0)

        },
        drop = {
            lib = "anim@heists@box_carry@",
            anim = "exit"
        }
    },
    smallbox = {
        pickup = {
            lib = "anim@heists@box_carry@",
            anim = "idle",
            prop = "prop_cs_box_clothes",
            bone = 60309,
            coords = vector3(0.2, 0.08, 0.2),
            rotation = vector3(-45.0, 290.0, 0.0)

        },
        drop = {
            lib = "anim@heists@box_carry@",
            anim = "exit"
        }
    }
}

SV_Config.Vehicles = {

    ['blista'] = { 
        doors = 5,
        maxCapacity = 2,
        countCapacity = 0,
        prop = { weed = "prop_weed_block_01", coke = "prop_coke_block_01", box = "prop_cs_box_clothes", drank = "prop_beer_box_01" },
        storages = {
            [1] =  { coords = vector3(0.25, -1.5, 0.11), rotation = vector3(0.0, 0.0, 0.0), loaded = false, entity = nil, itemType = nil },
            [2] =  { coords = vector3(-0.25, -1.5, 0.11), rotation = vector3(0.0, 0.0, 0.0), loaded = false, entity = nil, itemType = nil },
        },
    },

    ['adder'] = { 
        doors = 4,
        maxCapacity = 2,
        countCapacity = 0,
        prop = { weed = "prop_weed_block_01", coke = "prop_coke_block_01", box = "prop_cs_box_clothes", drank = "prop_beer_box_01" },
        storages = {
            [1] =  { coords = vector3(0.25, 1.6, 0.11), rotation = vector3(0.0, 0.0, 90.0), loaded = false, entity = nil, itemType = nil },
            [2] =  { coords = vector3(-0.25, 1.6, 0.11), rotation = vector3(0.0, 0.0, 90.0), loaded = false, entity = nil, itemType = nil },
        },
    },

    ["speedo"] = { 
        doors = {2, 3},
        maxCapacity = 24,
        countCapacity = 0,
        prop = "v_ind_cf_chckbox2", -- don't change the prop
        storages = {
            -- bottum layer
            [1] = { coords = vector3(-0.5, -0.5, 0.0),   rotation = vector3(0.0, 0.0, 0.0), loaded = false, entity = nil, itemType = nil },
            [2] = { coords = vector3(-0.0, -0.5, 0.0),   rotation = vector3(0.0, 0.0, 0.0), loaded = false, entity = nil, itemType = nil },
            [3] = { coords = vector3(0.5, -0.5, 0.0),    rotation = vector3(0.0, 0.0, 0.0), loaded = false, entity = nil, itemType = nil },

            [4] = { coords = vector3(-0.5, -0.5, 0.5),   rotation = vector3(0.0, 0.0, 0.0), loaded = false, entity = nil, itemType = nil }, 
            [5] = { coords = vector3(-0.0, -0.5, 0.5),   rotation = vector3(0.0, 0.0, 0.0), loaded = false, entity = nil, itemType = nil },
            [6] = { coords = vector3(0.5, -0.5, 0.5),    rotation = vector3(0.0, 0.0, 0.0), loaded = false, entity = nil, itemType = nil },

            [7] = { coords = vector3(-0.5, -1.0, 0.0),   rotation = vector3(0.0, 0.0, 0.0), loaded = false, entity = nil, itemType = nil },
            [8] = { coords = vector3(-0.0, -1.0, 0.0),   rotation = vector3(0.0, 0.0, 0.0), loaded = false, entity = nil, itemType = nil }, 
            [9] = { coords = vector3(0.5, -1.0, 0.0),    rotation = vector3(0.0, 0.0, 0.0), loaded = false, entity = nil, itemType = nil },

            [10] = { coords = vector3(-0.5, -1.0, 0.5),  rotation = vector3(0.0, 0.0, 0.0), loaded = false, entity = nil, itemType = nil },
            [11] = { coords = vector3(-0.0, -1.0, 0.5),  rotation = vector3(0.0, 0.0, 0.0), loaded = false, entity = nil, itemType = nil },
            [12] = { coords = vector3(0.5, -1.0, 0.5),   rotation = vector3(0.0, 0.0, 0.0), loaded = false, entity = nil, itemType = nil },
            --top layer 
            [13] = { coords = vector3(-0.5, -1.5, 0.0),  rotation = vector3(0.0, 0.0, 0.0), loaded = false, entity = nil, itemType = nil },
            [14] = { coords = vector3(-0.0, -1.5, 0.0),  rotation = vector3(0.0, 0.0, 0.0), loaded = false, entity = nil, itemType = nil },
            [15] = { coords = vector3(0.5, -1.5, 0.0),   rotation = vector3(0.0, 0.0, 0.0), loaded = false, entity = nil, itemType = nil },

            [16] = { coords = vector3(-0.5, -1.5, 0.5),  rotation = vector3(0.0, 0.0, 0.0), loaded = false, entity = nil, itemType = nil },
            [17] = { coords = vector3(-0.0, -1.5, 0.5),  rotation = vector3(0.0, 0.0, 0.0), loaded = false, entity = nil, itemType = nil },
            [18] = { coords = vector3(0.5, -1.5, 0.5),   rotation = vector3(0.0, 0.0, 0.0), loaded = false, entity = nil, itemType = nil },

            [19] = { coords = vector3(-0.5, -2.0, 0.0),  rotation = vector3(0.0, 0.0, 0.0), loaded = false, entity = nil, itemType = nil },
            [20] = { coords = vector3(-0.0, -2.0, 0.0),  rotation = vector3(0.0, 0.0, 0.0), loaded = false, entity = nil, itemType = nil },
            [21] = { coords = vector3(0.5, -2.0, 0.0),   rotation = vector3(0.0, 0.0, 0.0), loaded = false, entity = nil, itemType = nil },

            [22] = { coords = vector3(-0.5, -2.0, 0.5),  rotation = vector3(0.0, 0.0, 0.0), loaded = false, entity = nil, itemType = nil },
            [23] = { coords = vector3(-0.0, -2.0, 0.5),  rotation = vector3(0.0, 0.0, 0.0), loaded = false, entity = nil, itemType = nil },
            [24] = { coords = vector3(0.5, -2.0, 0.5),   rotation = vector3(0.0, 0.0, 0.0), loaded = false, entity = nil, itemType = nil }
        }
    },
    
    ["stockade"] = {
        doors = {2, 3},
        maxCapacity = 15,
        countCapacity = 0,
        prop = "prop_money_bag_01", -- don't change the prop
        storages = {
            [1] = { coords = vector3(-0.5, -1.0, 0.65), rotation = vector3(0.0, 0.0, 0.0), loaded = false, entity = nil, itemType = nil },
            [2] = { coords = vector3(-0.0, -1.0, 0.65), rotation = vector3(0.0, 0.0, 0.0), loaded = false, entity = nil, itemType = nil },
            [3] = { coords = vector3(0.5, -1.0, 0.65),  rotation = vector3(0.0, 0.0, 0.0), loaded = false, entity = nil, itemType = nil },
            [4] = { coords = vector3(-0.5, -1.5, 0.65), rotation = vector3(0.0, 0.0, 0.0), loaded = false, entity = nil, itemType = nil },
            [5] = { coords = vector3(-0.0, -1.5, 0.65), rotation = vector3(0.0, 0.0, 0.0), loaded = false, entity = nil, itemType = nil },
            [6] = { coords = vector3(0.5, -1.5, 0.65),  rotation = vector3(0.0, 0.0, 0.0), loaded = false, entity = nil, itemType = nil },
            [7] = { coords = vector3(-0.5, -2.0, 0.65), rotation = vector3(0.0, 0.0, 0.0), loaded = false, entity = nil, itemType = nil },
            [8] = { coords = vector3(-0.0, -2.0, 0.65), rotation = vector3(0.0, 0.0, 0.0), loaded = false, entity = nil, itemType = nil },
            [9] = { coords = vector3(0.5, -2.0, 0.65),  rotation = vector3(0.0, 0.0, 0.0), loaded = false, entity = nil, itemType = nil },
            [10] = { coords = vector3(-0.5, -2.5, 0.65), rotation = vector3(0.0, 0.0, 0.0), loaded = false, entity = nil, itemType = nil },
            [11] = { coords = vector3(-0.0, -2.5, 0.65), rotation = vector3(0.0, 0.0, 0.0), loaded = false, entity = nil, itemType = nil },
            [12] = { coords = vector3(0.5, -2.5, 0.65),  rotation = vector3(0.0, 0.0, 0.0), loaded = false, entity = nil, itemType = nil },
            [13] = { coords = vector3(-0.5, -3.0, 0.65), rotation = vector3(0.0, 0.0, 0.0), loaded = false, entity = nil, itemType = nil },
            [14] = { coords = vector3(-0.0, -3.0, 0.65), rotation = vector3(0.0, 0.0, 0.0), loaded = false, entity = nil, itemType = nil },
            [15] = { coords = vector3(0.5, -3.0, 0.65),  rotation = vector3(0.0, 0.0, 0.0), loaded = false, entity = nil, itemType = nil },
        }
    },
}