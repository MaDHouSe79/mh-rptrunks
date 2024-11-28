local Translations = {
    info = {
        ['press_to_drop'] = "Press E to drop prop",
    },
    target = {
        ['open_trunk'] = "Open Trunk",
        ['close_trunk'] = "Close Trunk",
        ['load_prop'] = "Load prop",
        ['take_prop'] = "Take prop",
        ['load_coke'] = "Load Coke",
        ['load_weed'] = "Load Weed",
        ['load_boxes'] = "Load Boxes",
        ['load_drank'] = "Load Drank",
        ['unload_trunk'] = "Unload Trunk",
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
