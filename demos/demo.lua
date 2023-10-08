print("---")
print(
    "This demo is not indicative of mupen-lua-ugui-ext's capaibilities, as it hasn't been brought up to a higher quality standard")
print("---")

function folder(thisFileName)
    local str = debug.getinfo(2, "S").source:sub(2)
    return (str:match("^.*/(.*).lua$") or str):sub(1, -(thisFileName):len() - 1)
end

dofile(folder("demos/demo.lua") .. "mupen-lua-ugui.lua")
dofile(folder("demos/demo.lua") .. "mupen-lua-ugui-ext.lua")

local initial_size = wgui.info()
wgui.resize(initial_size.width + 200, initial_size.height)

local value = 5
local selected_tab_index = 1


local function get_windows_10_nineslice_style()
    local function expand(t)
        return {
            x = t[1],
            y = t[2],
            width = t[3],
            height = t[4],
        }
    end
    return {
        path = folder("demo.lua") .. "res/windows-10-atlas.png",
        background_color = BreitbandGraphics.repeated_to_color(240),
        item_height = 15,
        font_size = 12,
        font_name = 'MS Shell Dlg 2',
        button = {
            text_colors = {
                [1] = BreitbandGraphics.colors.black,
                [2] = BreitbandGraphics.colors.black,
                [3] = BreitbandGraphics.colors.black,
                [0] = BreitbandGraphics.repeated_to_color(131),
            },
            states = {
                [1] = {
                    source = expand({ 1, 1, 11, 9 }),
                    center = expand({ 6, 5, 1, 1 }),
                },
                [2] = {
                    source = expand({ 1, 12, 11, 9 }),
                    center = expand({ 6, 16, 1, 1 }),
                },
                [3] = {
                    source = expand({ 1, 23, 11, 9 }),
                    center = expand({ 6, 27, 1, 1 }),
                },
                [0] = {
                    source = expand({ 1, 34, 11, 9 }),
                    center = expand({ 6, 38, 1, 1 }),
                }
            }
        },
        textbox = {
            text_colors = {
                [1] = BreitbandGraphics.colors.black,
                [2] = BreitbandGraphics.colors.black,
                [3] = BreitbandGraphics.colors.black,
                [0] = BreitbandGraphics.repeated_to_color(109),
            },
            states = {
                [1] = {
                    source = expand({ 74, 1, 5, 5 }),
                    center = expand({ 76, 3, 1, 1 }),
                },
                [2] = {
                    source = expand({ 74, 6, 5, 5 }),
                    center = expand({ 76, 8, 1, 1 }),
                },
                [3] = {
                    source = expand({ 74, 11, 5, 5 }),
                    center = expand({ 76, 13, 1, 1 }),
                },
                [0] = {
                    source = expand({ 74, 16, 5, 5 }),
                    center = expand({ 76, 18, 1, 1 }),
                }
            }
        },
    }
end

emu.atupdatescreen(function()
    BreitbandGraphics.fill_rectangle({
        x = initial_size.width,
        y = 0,
        width = 200,
        height = initial_size.height,
    }, {
        r = 253,
        g = 253,
        b = 253,
    })

    local keys = input.get()

    Mupen_lua_ugui.begin_frame(BreitbandGraphics, Mupen_lua_ugui.stylers.windows_10, {
        pointer = {
            position = {
                x = keys.xmouse,
                y = keys.ymouse,
            },
            is_primary_down = keys.leftclick,
        },
        keyboard = {
            held_keys = keys,
        },
    })


    value = Mupen_lua_ugui.spinner({
        uid = 1,
        is_enabled = true,
        rectangle = {
            x = initial_size.width + 10,
            y = 30,
            width = 80,
            height = 23,
        },
        value = value,
        is_horizontal = true,
        minimum_value = -5,
        maximum_value = 10,
    })

    value = Mupen_lua_ugui.spinner({
        uid = 2,
        is_enabled = true,
        rectangle = {
            x = initial_size.width + 10,
            y = 60,
            width = 80,
            height = 23,
        },
        value = value,
        is_horizontal = false,
        minimum_value = -5,
        maximum_value = 10,
    })

    selected_tab_index = Mupen_lua_ugui.tabcontrol({
        uid = 3,
        is_enabled = true,
        rectangle = {
            x = initial_size.width + 5,
            y = 100,
            width = 190,
            height = 150,
        },
        selected_index = selected_tab_index,
        items = {
            "Tab a",
            "b",
            "Some other tab",
        }
    }).selected_index


    if Mupen_lua_ugui.button({
            uid = 10,
            is_enabled = true,
            rectangle = {
                x = initial_size.width + 10,
                y = 260,
                width = 80,
                height = 23,
            },
            text = "windows 11"
        }) then
        local style = get_windows_10_nineslice_style()
        style.path = folder("demo.lua") .. "res/windows-11-atlas.png"
        Mupen_lua_ugui_ext.apply_nineslice(style)
    end
    if Mupen_lua_ugui.button({
            uid = 11,
            is_enabled = true,
            rectangle = {
                x = initial_size.width + 10,
                y = 290,
                width = 80,
                height = 23,
            },
            text = "windows 10"
        }) then
        Mupen_lua_ugui_ext.apply_nineslice(get_windows_10_nineslice_style())
    end
    if Mupen_lua_ugui.button({
            uid = 12,
            is_enabled = true,
            rectangle = {
                x = initial_size.width + 10,
                y = 330,
                width = 120,
                height = 23,
            },
            text = "windows 10 Dark"
        }) then
        local style = get_windows_10_nineslice_style()
        style.path = folder("demo.lua") .. "res/windows-10-dark-atlas.png"
        Mupen_lua_ugui_ext.apply_nineslice(style)
    end
    Mupen_lua_ugui.end_frame()
end)

emu.atstop(function()
    wgui.resize(initial_size.width, initial_size.height)
end)