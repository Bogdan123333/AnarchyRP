Config = Config or {}

Config.Menus = {
    ['empty'] = {
        title = '',
        options = {},
    },
    ['main'] = {
        title = '',
        options = {
            {label = 'Repara', img = 'img/icons/repair.png', price = 275, onSelect = function() repairVehicle(customVehicle) end},
            {label = 'Modificari', img = 'img/icons/visual.png', openSubMenu = 'visual'},
            {label = 'Performanta', img = 'img/icons/upgrade.png', openSubMenu = 'upgrade'}
        },
        onBack = function() closeUI(1) end,
        defaultOption = 1
    },
    ['upgrade'] = {
        title = 'Performanta',
        options = {
            {label = 'Soft', img = 'img/icons/engine.png', modType = 11, priceMult = {1.0, 3.0, 4.0, 5.5, 7.0, 7.0}},
            {label = 'Frane', img = 'img/icons/brakes.png', modType = 12, priceMult = {1.0, 1.5, 2.0, 2.5, 2.5}},
            {label = 'Transmisie', img = 'img/icons/transmission.png', modType = 13, priceMult = {1.0, 3.0, 3.5, 4.0, 4.0}},
            {label = 'Suspensie', img = 'img/icons/suspension.png', modType = 15, priceMult = {1.0, 3.0, 3.5, 4.0, 10.00, 10.0, 10.0}},
            {label = 'Armura', img = 'img/icons/armor.png', modType = 16, priceMult = {1.0, 4.0, 4.5, 5.0, 5.5, 6.0, 6.0, 6.0}},
            {label = 'Turbina', img = 'img/icons/engine.png', modType = 18, priceMult = {1.0, 10.0}},
        },
        onBack = function() updateMenu('main') end
    },
    ['visual'] = {
        title = 'Modificari',
        options = {
            {label = 'Caroserie', img = 'img/icons/body.png', openSubMenu = 'body_parts'},
            {label = 'Interior', img = 'img/icons/body.png', openSubMenu = 'inside_parts'},
            {label = 'Vopsea', img = 'img/icons/respray.png', openSubMenu = 'respray'},
            {label = 'Jante', img = 'img/icons/wheel.png', openSubMenu = 'wheels', onSelect = function()
                moveToCameraToBoneSmoth(customCamMain, customCamSec, customVehicle, {x = -2.3, y = 1.9, z = 0.1}, {x = -10.0, y = 0.0, z = 20.0})
            end, onSubBack = function()
                SetCamActiveWithInterp(customCamMain, customCamSec, 500, true, true)
            end},
            {label = 'Placute', img = 'img/icons/plate.png', openSubMenu = 'plate'},
            {label = 'Lumini', img = 'img/icons/headlights.png', openSubMenu = 'lights'},
            {label = 'Colant', img = 'img/icons/respray.png', openSubMenu = 'stickers'},
            {label = 'Extra', img = 'img/icons/plus.png', modType = 'extras', priceMult = 0.5},
            {label = 'Folii geamuri', img = 'img/icons/door.png', modType = 'windowTint', priceMult = 0.3, onSelect = function()
                moveToCameraToBoneSmoth(customCamMain, customCamSec, customVehicle, {x = -2.0, y = -0.5, z = 0.3}, {x = 0.0, y = 0.0, z = 0.0})
            end, onSubBack = function()
                SetCamActiveWithInterp(customCamMain, customCamSec, 500, true, true)
            end},
            {label = 'Claxon', img = 'img/icons/horn.png', modType = 14, priceMult = 35.00},
            {label = 'Placute Lowrider', img = '', modType = 35, priceMult = 0.5},
            {label = 'Boxe', img = 'img/icons/speaker.png', modType = 36, priceMult = 1.00},
            {label = 'Portbagaj', img = 'img/icons/trunk.png', modType = 37, priceMult = 1.00, onSelect = function() openDoors(customVehicle, {0,0,0,0,0,1,1}) end},
            {label = 'Hidraulice', img = 'img/icons/hydrulics.png', modType = 38, priceMult = 3.00},
            {label = 'Bloc motor', img = 'img/icons/engine_block.png', modType = 39, priceMult = 2.00, onSelect = function() openDoors(customVehicle, {0,0,0,0,1,0,0}) moveToCameraToBoneSmoth(customCamMain, customCamSec, customVehicle, {x = 0.0, y = 4.0, z = 1.7}, {x = -30.0, y = 0.0, z = 0.0}) end, onSubBack = function()
                SetCamActiveWithInterp(customCamMain, customCamSec, 500, true, true)
            end},
            {label = 'Filtru de aer', img = 'img/icons/air_filter.png', modType = 40, priceMult = 150.00},
            {label = 'Distantier', img = 'img/icons/suspension.png', modType = 41, priceMult = 1.00},
            {label = 'Rezervor', img = 'img/icons/gas_tank.png', modType = 45, priceMult = 1.00},
        },
        onBack = function() updateMenu('main') end
    },
    ['body_parts'] = {
        title = 'Caroserie',
        options = {
            {label = 'Spoiler', img = 'img/icons/spoiler.png', modType = 0, priceMult = 1.50, onSelect = function()
                moveToCameraToBoneSmoth(customCamMain, customCamSec, customVehicle, {x = 0.0, y = -4.3, z = 0.9}, {x = 0.0, y = 0.0, z = 0.0})
            end, onSubBack = function()
                SetCamActiveWithInterp(customCamMain, customCamSec, 500, true, true)
            end},
            {label = 'Bara fata', img = 'img/icons/bumper.png', modType = 1, priceMult = 2.00, onSelect = function()
                moveToCameraToBoneSmoth(customCamMain, customCamSec, customVehicle, {x = 0.0, y = 4.6, z = 0.1}, {x = 0.0, y = 0.0, z = 0.0})
            end, onSubBack = function()
                SetCamActiveWithInterp(customCamMain, customCamSec, 500, true, true)
            end},
            {label = 'Bara spate', img = 'img/icons/bumper.png', modType = 2, priceMult = 2.00, onSelect = function()
                moveToCameraToBoneSmoth(customCamMain, customCamSec, customVehicle, {x = 0.0, y = -4.0, z = 0.1}, {x = 0.0, y = 0.0, z = 0.0})
            end, onSubBack = function()
                SetCamActiveWithInterp(customCamMain, customCamSec, 500, true, true)
            end},
            {label = 'Praguri', img = 'img/icons/bumper.png', modType = 3, priceMult = 1.50, onSelect = function()
                moveToCameraToBoneSmoth(customCamMain, customCamSec, customVehicle, {x = -2.0, y = 2.0, z = 0.0}, {x = 0.0, y = 0.0, z = -20.0})
            end, onSubBack = function()
                SetCamActiveWithInterp(customCamMain, customCamSec, 500, true, true)
            end},
            {label = 'Evacuare', img = 'img/icons/exhaust.png', modType = 4, priceMult = 2.50, onSelect = function()
                moveToCameraToBoneSmoth(customCamMain, customCamSec, customVehicle, {x = 0.0, y = -4.0, z = 0.0}, {x = 0.0, y = 0.0, z = 0.0})
            end, onSubBack = function()
                SetCamActiveWithInterp(customCamMain, customCamSec, 500, true, true)
            end},
            {label = 'Cusca', img = 'img/icons/body.png', modType = 5, priceMult = 1.50, onSelect = function()
                moveToCameraToBoneSmoth(customCamMain, customCamSec, customVehicle, {x = 0.0, y = 1.2, z = 1.1}, {x = -30.0, y = 0.0, z = 0.0})
            end, onSubBack = function()
                SetCamActiveWithInterp(customCamMain, customCamSec, 500, true, true)
            end},
            {label = 'Grila', img = 'img/icons/body.png', modType = 6, priceMult = 1.00, onSelect = function()
                moveToCameraToBoneSmoth(customCamMain, customCamSec, customVehicle, {x = 0.0, y = 3.2, z = 0.1}, {x = 0.0, y = 0.0, z = 0.0})
            end, onSubBack = function()
                SetCamActiveWithInterp(customCamMain, customCamSec, 500, true, true)
            end},
            {label = 'Capota', img = 'img/icons/hood.png', modType = 7, priceMult = 2.00, onSelect = function()
                moveToCameraToBoneSmoth(customCamMain, customCamSec, customVehicle, {x = 0.0, y = 4.0, z = 1.7}, {x = -30.0, y = 0.0, z = 0.0})
            end, onSubBack = function()
                SetCamActiveWithInterp(customCamMain, customCamSec, 500, true, true)
            end},
            {label = 'Aripa stanga', img = 'img/icons/bumper.png', modType = 8, priceMult = 1.00, onSelect = function()
                moveToCameraToBoneSmoth(customCamMain, customCamSec, customVehicle, {x = 2.0, y = 2.5, z = 1.0}, {x = -25.0, y = 0.0, z = 0.0})
            end, onSubBack = function()
                SetCamActiveWithInterp(customCamMain, customCamSec, 500, true, true)
            end},
            {label = 'Aripa dreapta', img = 'img/icons/bumper.png', modType = 9, priceMult = 1.00, onSelect = function()
                moveToCameraToBoneSmoth(customCamMain, customCamSec, customVehicle, {x = -2.5, y = 0.6, z = 0.4}, {x = 0.0, y = 0.0, z = -25.0})
            end, onSubBack = function()
                SetCamActiveWithInterp(customCamMain, customCamSec, 500, true, true)
            end},
            {label = 'Plafon', img = 'img/icons/body.png', modType = 10, priceMult = 2.00, onSelect = function()
                moveToCameraToBoneSmoth(customCamMain, customCamSec, customVehicle, {x = -1.0, y = 2.0, z = 2.1}, {x = -25.0, y = 0.0, z = 0.0})
            end, onSubBack = function()
                SetCamActiveWithInterp(customCamMain, customCamSec, 500, true, true)
            end},
            {label = 'Aparatori', img = 'img/icons/bumper.png', modType = 42, priceMult = 1.00, onSelect = function()
                moveToCameraToBoneSmoth(customCamMain, customCamSec, customVehicle, {x = 0.0, y = -4.0, z = 0.1}, {x = 0.0, y = 0.0, z = 0.0})
            end, onSubBack = function()
                SetCamActiveWithInterp(customCamMain, customCamSec, 500, true, true)
            end},
            {label = 'Antena', img = 'img/icons/body.png', modType = 43, priceMult = 1.00, onSelect = function()
                moveToCameraToBoneSmoth(customCamMain, customCamSec, customVehicle, {x = 0.0, y = -4.0, z = 0.1}, {x = 0.0, y = 0.0, z = 0.0})
            end, onSubBack = function()
                SetCamActiveWithInterp(customCamMain, customCamSec, 500, true, true)
            end},
            {label = 'Aripi', img = 'img/icons/bumper.png', modType = 44, priceMult = 1.50, onSelect = function()
                moveToCameraToBoneSmoth(customCamMain, customCamSec, customVehicle, {x = -2.5, y = 0.6, z = 0.4}, {x = 0.0, y = 0.0, z = -25.0})
            end, onSubBack = function()
                SetCamActiveWithInterp(customCamMain, customCamSec, 500, true, true)
            end},
            {label = 'Oglinzi', img = 'img/icons/door.png', modType = 46, priceMult = 0.5, onSelect = function()
                moveToCameraToBoneSmoth(customCamMain, customCamSec, customVehicle, {x = -2.0, y = 0.4, z = 0.8}, {x = 0.0, y = 0.0, z = 20.0})
            end, onSubBack = function()
                SetCamActiveWithInterp(customCamMain, customCamSec, 500, true, true)
            end},
        },
        onBack = function() updateMenu('visual') end
    },
    ['inside_parts'] = {
        title = 'Interior',
        options = {
            {label = 'Bord', img = 'img/icons/dashboard.png', modType = 29, priceMult = 1.00, onSelect = function()
                moveToCameraToBoneSmoth(customCamMain, customCamSec, customVehicle, {x = 0.1, y = 0.0, z = 0.785}, {x = -20.0, y = 0.0, z = 270.0})
            end, onSubBack = function()
                SetCamActiveWithInterp(customCamMain, customCamSec, 500, true, true)
            end},
            {label = 'Ceasuri', img = 'img/icons/dashboard.png', modType = 30, priceMult = 0.20, onSelect = function()
                moveToCameraToBoneSmoth(customCamMain, customCamSec, customVehicle, {x = 0.1, y = 0.0, z = 0.785}, {x = -10.0, y = 0.0, z = 270.0})
            end, onSubBack = function()
                SetCamActiveWithInterp(customCamMain, customCamSec, 500, true, true)
            end},
            {label = 'Trimuri Usi', img = 'img/icons/speaker.png', modType = 31, priceMult = 1.00, onSelect = function() openDoors(customVehicle, {1,1,1,1,0,0,0}) moveToCameraToBoneSmoth(customCamMain, customCamSec, customVehicle, {x = 0.1, y = 0.0, z = 0.785}, {x = -10.0, y = 0.0, z = 270.0}) end,onSubBack = function()
                SetCamActiveWithInterp(customCamMain, customCamSec, 500, true, true)
            end },
            {label = 'Scaune', img = 'img/icons/seat.png', modType = 32, priceMult = 1.50, onSelect = function()
                moveToCameraToBoneSmoth(customCamMain, customCamSec, customVehicle, {x = 0.0, y = 1.2, z = 1.1}, {x = -30.0, y = 0.0, z = 0.0})
            end, onSubBack = function()
                SetCamActiveWithInterp(customCamMain, customCamSec, 500, true, true)
            end},
            {label = 'Volan', img = 'img/icons/steering_wheel.png', modType = 33, priceMult = 1.00, onSelect = function()
                moveToCameraToBoneSmoth(customCamMain, customCamSec, customVehicle, {x = 0.1, y = 0.0, z = 0.785}, {x = -20.0, y = 0.0, z = 270.0})
            end, onSubBack = function()
                SetCamActiveWithInterp(customCamMain, customCamSec, 500, true, true)
            end},
            {label = 'Schimbator', img = 'img/icons/shifter_leaver.png', modType = 34, priceMult = 1.00, onSelect = function()
                moveToCameraToBoneSmoth(customCamMain, customCamSec, customVehicle, {x = 0.1, y = 0.0, z = 0.785}, {x = -70.0, y = 0.0, z = 270.0})
            end, onSubBack = function()
                SetCamActiveWithInterp(customCamMain, customCamSec, 500, true, true)
            end},
            {label = 'Ornamente', img = '', modType = 28, priceMult = 0.5, onSelect = function()
                moveToCameraToBoneSmoth(customCamMain, customCamSec, customVehicle, {x = 0.1, y = 0.0, z = 0.785}, {x = -20.0, y = 0.0, z = 270.0})
            end, onSubBack = function()
                SetCamActiveWithInterp(customCamMain, customCamSec, 500, true, true)
            end},
            {label = 'Tapiterie', img = 'img/icons/body.png', modType = 27, priceMult = 1.00, onSelect = function()
                moveToCameraToBoneSmoth(customCamMain, customCamSec, customVehicle, {x = 0.0, y = 1.2, z = 1.1}, {x = -30.0, y = 0.0, z = 0.0})
            end, onSubBack = function()
                SetCamActiveWithInterp(customCamMain, customCamSec, 500, true, true)
            end},
            {label = 'Ceasuri Bord Trim', img = 'img/icons/body.png', modType = 'dcol', priceMult = 1.00, onSelect = function()
                moveToCameraToBoneSmoth(customCamMain, customCamSec, customVehicle, {x = 0.0, y = 1.2, z = 1.1}, {x = -30.0, y = 0.0, z = 0.0})
            end, onSubBack = function()
                SetCamActiveWithInterp(customCamMain, customCamSec, 500, true, true)
            end},
            {label = 'Culoare Interior', img = 'img/icons/respray.png', modType = 'interiorColor', priceMult = 0.35, onSelect = function() end},
        },
        onBack = function() updateMenu('visual') end
    },
    ['respray'] = {
        title = 'Vopsea',
        options = {
            {label = 'Principala', img = 'img/icons/respray.png', modType = 'color1', customType = 'customColor', priceMult = 1.12, onSelect = function() openColorPicker('Primary Color', 'color1', true, 1.0) end},
            {label = 'Secundara', img = 'img/icons/respray.png', modType = 'color2', customType = 'customColor', priceMult = 0.66, onSelect = function() openColorPicker('Secondary Color', 'color2', true, 1.0) end},
            {label = 'Tip vopsea Principala', img = 'img/icons/respray.png', modType = 'paintType1', priceMult = 1.0},
            {label = 'Tip vopsea Secundara', img = 'img/icons/respray.png', modType = 'paintType2', priceMult = 1.0},
            {label = 'Perla', img = 'img/icons/respray.png', modType = 'pearlescentColor', customType = 'color', priceMult = 0.88, onSelect = function() openColorPicker('Pearlescent Color', 'pearlescentColor', false, 1.0) end},
        },
        onBack = function() updateMenu('visual') end
    },
    ['wheels'] = {
        title = 'Jante',
        options = {
            {label = 'Tip Jante', img = 'img/icons/wheel.png', onSelect = function() updateMenu('wheels_type') end},
            {label = 'Culoare Jante', img = 'img/icons/respray.png', modType = 'wheelColor', customType = 'color', priceMult = 0.66, onSelect = function() openColorPicker('Wheels Color', 'wheelColor', false, 1.0) end},
            {label = 'Culoare Fum Cauciucuri', img = 'img/icons/respray.png', modType = 'tyreSmokeColor', customType = 'customColor', priceMult = 1.12, onSelect = function() openColorPicker('Tyre Smoke Color', 'tyreSmokeColor', true, 10.0) end},
            {label = 'Cauciucuri Runflat', img = 'img/icons/wheel.png', modType = 'bulletproof', customType = 'bulletproof', priceMult = 500.00, onSelect = function() end},
            {label = 'Cauciucuri Speciale', img = 'img/icons/wheel.png', modType = 'cauciucuriSpeciale', customType = 'cauciucuriSpeciale', priceMult = 10.00, onSelect = function() end},
        },
        onBack = function() updateMenu('visual') SetCamActiveWithInterp(customCamMain, customCamSec, 500, true, true) end
    },
    ['wheels_type'] = {
        title = 'Tip Jante',
        options = {
            {label = 'Jante Sport', img = 'img/icons/wheel.png', modType = 23, priceMult = 20.00, onSelect = function() SetVehicleModData(customVehicle, 'wheels', 0) end},
            {label = 'Jante Muscle ', img = 'img/icons/wheel.png', modType = 23, priceMult = 15.00, onSelect = function() SetVehicleModData(customVehicle, 'wheels', 1) end},
            {label = 'Jante Lowrider', img = 'img/icons/wheel.png', modType = 23, priceMult = 25.00, onSelect = function() SetVehicleModData(customVehicle, 'wheels', 2) end},
            {label = 'Jante SUV', img = 'img/icons/wheel.png', modType = 23, priceMult = 13.00, onSelect = function() SetVehicleModData(customVehicle, 'wheels', 3) end},
            {label = 'Jante Offroad', img = 'img/icons/wheel.png', modType = 23, priceMult = 30.00, onSelect = function() SetVehicleModData(customVehicle, 'wheels', 4) end},
            {label = 'Jante Tuner', img = 'img/icons/wheel.png', modType = 23, priceMult = 55.00, onSelect = function() SetVehicleModData(customVehicle, 'wheels', 5) end},
            {label = 'Jante Super', img = 'img/icons/wheel.png', modType = 23, priceMult = 65.0, onSelect = function() SetVehicleModData(customVehicle, 'wheels', 7) end},
            {label = 'Jante Bennys Sport', img = 'img/icons/wheel.png', modType = 23, priceMult = 65.00, onSelect = function() SetVehicleModData(customVehicle, 'wheels', 8) end},
            {label = 'Jante Bennys Lowrider', img = 'img/icons/wheel.png', modType = 23, priceMult = 35.00, onSelect = function() SetVehicleModData(customVehicle, 'wheels', 9) end},
            {label = 'Jante Drag', img = 'img/icons/wheel.png', modType = 23, priceMult = 50.00, onSelect = function() SetVehicleModData(customVehicle, 'wheels', 10) end},
            {label = 'Jante Street', img = 'img/icons/wheel.png', modType = 23, priceMult = 26.00, onSelect = function() SetVehicleModData(customVehicle, 'wheels', 11) end},
            {label = 'Jante Track', img = 'img/icons/wheel.png', modType = 23, priceMult = 26.00, onSelect = function() SetVehicleModData(customVehicle, 'wheels', 12) end},
        },
        onBack = function() updateMenu('wheels') end
    },
    ['plate'] = {
        title = 'Placute',
        options = {
            {label = 'Tip', img = 'img/icons/plate.png', modType = 25, priceMult = 0.1, onSelect = function()
                moveToCameraToBoneSmoth(customCamMain, customCamSec, customVehicle, {x = 0.0, y = -4.0, z = 0.1}, {x = 0.0, y = 0.0, z = 0.0})
            end, onSubBack = function()
                SetCamActiveWithInterp(customCamMain, customCamSec, 500, true, true)
            end},
            {label = 'Culoare', img = 'img/icons/respray.png', modType = 'plateIndex', priceMult = 0.1, onSelect = function()
                moveToCameraToBoneSmoth(customCamMain, customCamSec, customVehicle, {x = 0.0, y = -4.0, z = 0.1}, {x = 0.0, y = 0.0, z = 0.0})
            end, onSubBack = function()
                SetCamActiveWithInterp(customCamMain, customCamSec, 500, true, true)
            end},
            {label = 'Suport Numar', img = 'img/icons/bumper.png', modType = 26, priceMult = 0.1, onSelect = function()
                moveToCameraToBoneSmoth(customCamMain, customCamSec, customVehicle, {x = 0.0, y = -4.0, z = 0.1}, {x = 0.0, y = 0.0, z = 0.0})
            end, onSubBack = function()
                SetCamActiveWithInterp(customCamMain, customCamSec, 500, true, true)
            end},
        },
        onBack = function() updateMenu('visual') end
    },
    ['lights'] = {
        title = 'Lumini',
        options = {
            {label = 'Xenon', img = 'img/icons/headlights.png', modType = 'modXenon', priceMult = 6.5, onSelect = function() SetVehicleEngineOn(customVehicle, true, false, false) end},
            {label = 'Neon', img = 'img/icons/headlights.png', modType = 'neonColor', customType = 'customColor', priceMult = 5.5, onSelect = function() SetVehicleEngineOn(customVehicle, true, false, false) openColorPicker('Neon Color', 'neonColor', true, 1.0) end},
        },
        onBack = function() updateMenu('visual') end
    },
    ['stickers'] = {
        title = 'Colant',
        options = {
            {label = 'Colant', img = 'img/icons/respray.png', modType = 48, priceMult = 5.0},
            {label = 'Colant', img = 'img/icons/respray.png', modType = 'livery', priceMult = 5.0},
        },
        onBack = function() updateMenu('visual') end
    },
}
