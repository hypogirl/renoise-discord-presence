local options = renoise.Document.create("ExampleToolPreferences") {
    show_debug_prints = false
}

renoise.tool().preferences = options

local function get_song_title(path)
    local title_aux
    for str in string.gmatch(path, "([a-z]+.xrns)") do
            title_aux = str
    end
    local title = {}
    for str in string.gmatch(title_aux, "([^.]+)") do
        table.insert(title, str)
    end
        return title[1]
end

local function update_drp()
    local file_name = renoise.song().file_name
    local song_title = "Untitled"
    if file_name then
        song_title = get_song_title(file_name)
    end
    local command = "py renoise.py " .. song_title
    os.execute(command)
end

renoise.tool():add_menu_entry {
    name = "Main Menu:Song:Update Rich Presence",
    invoke = function() 
      update_drp()
    end
}

renoise.tool().app_new_document_observable:add_notifier(function()
    update_drp()
end)