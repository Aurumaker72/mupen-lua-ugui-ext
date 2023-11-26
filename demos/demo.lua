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

local selected_tab_index = 1
local mouse_wheel = 0
local number_value = -50
local treeview_items = {
    {
        uid = 0,
        open = true,
        content = "Item A",
        children = {}
    },
    {
        uid = 1,
        open = true,
        content = "Item B",
        children = {
            {
                uid = 3,
                open = true,
                content = "Item C",
                children = {
                    {
                        uid = 4,
                        open = true,
                        content = "Item D",
                        children = {}
                    }
                }
            },
            {
                uid = 5,
                open = true,
                content = "Item E",
                children = {}
            }
        }
    },
}
for i = 1, 10, 1 do
    treeview_items[1].children[#treeview_items[1].children + 1] = {
        uid = 100 + i,
        open = false,
        content = "Item " .. i,
        children = {}
    }
end

local selected_treeview_item = nil

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
    Mupen_lua_ugui.begin_frame({
        mouse_position = {
            x = keys.xmouse,
            y = keys.ymouse,
        },
        wheel = mouse_wheel,
        is_primary_down = keys.leftclick,
        held_keys = keys,
    })
    mouse_wheel = 0


    number_value = Mupen_lua_ugui.spinner({
        uid = 5,
        rectangle = {
            x = initial_size.width + 10,
            y = 30,
            width = 80,
            height = 23,
        },
        value = number_value,
        is_horizontal = true,
        minimum_value = math.mininteger,
        maximum_value = math.maxinteger,
    })

    number_value = Mupen_lua_ugui.spinner({
        uid = 10,
        rectangle = {
            x = initial_size.width + 10,
            y = 60,
            width = 80,
            height = 23,
        },
        value = number_value,
        is_horizontal = false,
        minimum_value = math.mininteger,
        maximum_value = math.maxinteger,
    })

    selected_tab_index = Mupen_lua_ugui.tabcontrol({
        uid = 15,
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


    number_value = Mupen_lua_ugui.numberbox({
        uid = 20,
        rectangle = {
            x = initial_size.width + 5,
            y = 260,
            width = 120,
            height = 23,
        },
        places = 7,
        value = number_value,
        show_negative = true
    })

    Mupen_lua_ugui.textbox({
        uid = 25,
        rectangle = {
            x = initial_size.width + 5,
            y = 295,
            width = 190,
            height = 20,
        },
        text = selected_treeview_item and
        (selected_treeview_item.content .. " (uid: " .. selected_treeview_item.uid .. ")") or "nothing"
    })
    selected_treeview_item = Mupen_lua_ugui.treeview({
        uid = 30,
        rectangle = {
            x = initial_size.width + 5,
            y = 320,
            width = 190,
            height = 250,
        },
        items = treeview_items,
        selected_item = selected_treeview_item
    })

    Mupen_lua_ugui.end_frame()
end)

emu.atstop(function()
    wgui.resize(initial_size.width, initial_size.height)
end)

emu.atwindowmessage(function(_, msg_id, wparam, _)
    if msg_id == 522 then
        local scroll = math.floor(wparam / 65536)
        if scroll == 120 then
            mouse_wheel = 1
        elseif scroll == 65416 then
            mouse_wheel = -1
        end
    end
end)
