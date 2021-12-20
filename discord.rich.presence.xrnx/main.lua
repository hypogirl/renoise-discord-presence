local options = renoise.Document.create("ExampleToolPreferences") {
    show_debug_prints = false
}

renoise.tool().preferences = options

local function get_song_title(path)
    local title_aux
    for str in string.gmatch(path, "([a-z|0-9]+).xrns") do
            title = str
    end
        return title
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