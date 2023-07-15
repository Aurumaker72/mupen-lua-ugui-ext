---Places a Spinner, or NumericUpDown control
---
---Additional fields in the `control` table:
---
--- `value` — `number` The spinner's numerical value
--- `minimum_value` — `number` The spinner's minimum numerical value
--- `maximum_value` — `number` The spinner's maximum numerical value
---@param control table A table abiding by the mupen-lua-ugui control contract (`{ uid, is_enabled, rectangle }`)
---@return _ number The new value
Mupen_lua_ugui.spinner = function(control)
    if not Mupen_lua_ugui.stylers.windows_10.spinner_button_thickness then
        Mupen_lua_ugui.stylers.windows_10.spinner_button_thickness = 15
    end

    local value = control.value

    local new_text = Mupen_lua_ugui.textbox({
        uid = control.uid,
        is_enabled = true,
        rectangle = {
            x = control.rectangle.x,
            y = control.rectangle.y,
            width = control.rectangle.width - Mupen_lua_ugui.stylers.windows_10.spinner_button_thickness * 2,
            height = control.rectangle.height,
        },
        text = tostring(value),
    })

    if tonumber(new_text) then
        value = tonumber(new_text)
    end

    if control.is_horizontal then
        if (Mupen_lua_ugui.button({
                uid = control.uid + 1,
                is_enabled = not (value == control.minimum_value),
                rectangle = {
                    x = control.rectangle.x + control.rectangle.width -
                        Mupen_lua_ugui.stylers.windows_10.spinner_button_thickness * 2,
                    y = control.rectangle.y,
                    width = Mupen_lua_ugui.stylers.windows_10.spinner_button_thickness,
                    height = control.rectangle.height,
                },
                text = "-",
            }))
        then
            value = value - 1
        end

        if (Mupen_lua_ugui.button({
                uid = control.uid + 1,
                is_enabled = not (value == control.maximum_value),
                rectangle = {
                    x = control.rectangle.x + control.rectangle.width -
                        Mupen_lua_ugui.stylers.windows_10.spinner_button_thickness,
                    y = control.rectangle.y,
                    width = Mupen_lua_ugui.stylers.windows_10.spinner_button_thickness,
                    height = control.rectangle.height,
                },
                text = "+",
            }))
        then
            value = value + 1
        end
    else
        if (Mupen_lua_ugui.button({
                uid = control.uid + 1,
                is_enabled = not (value == control.maximum_value),
                rectangle = {
                    x = control.rectangle.x + control.rectangle.width -
                        Mupen_lua_ugui.stylers.windows_10.spinner_button_thickness * 2,
                    y = control.rectangle.y,
                    width = Mupen_lua_ugui.stylers.windows_10.spinner_button_thickness * 2,
                    height = control.rectangle.height / 2,
                },
                text = "+",
            }))
        then
            value = value + 1
        end

        if (Mupen_lua_ugui.button({
                uid = control.uid + 1,
                is_enabled = not (value == control.minimum_value),
                rectangle = {
                    x = control.rectangle.x + control.rectangle.width -
                        Mupen_lua_ugui.stylers.windows_10.spinner_button_thickness * 2,
                    y = control.rectangle.y + control.rectangle.height / 2,
                    width = Mupen_lua_ugui.stylers.windows_10.spinner_button_thickness * 2,
                    height = control.rectangle.height / 2,
                },
                text = "-",
            }))
        then
            value = value - 1
        end
    end

    value = math.min(value, control.maximum_value)
    value = math.max(value, control.minimum_value)

    return value
end
