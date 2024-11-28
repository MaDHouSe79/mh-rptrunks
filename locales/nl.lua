local Translations = {
    info = {
        ['press_to_drop'] = "Press E to drop prop",
    },
    target = {
        ['open_trunk'] = "Open Trunk",
        ['close_trunk'] = "Close Trunk",
        ['load_prop'] = "Laad prop",
        ['take_prop'] = "Pak prop",
        ['load_coke'] = "Laad Coke",
        ['load_weed'] = "Laad Wiet",
        ['load_boxes'] = "Laad Boxes",
        ['load_drank'] = "Laad Drank",
        ['unload_trunk'] = "Unlaad Trunk",
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
