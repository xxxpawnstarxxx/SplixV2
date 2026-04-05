UI Library Documentation
1. Initialization
First, load the library into your script.

Lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xxxpawnstarxxx/SplixV2/refs/heads/main/source.lua"))()
Creating a Window
The main container for your UI.

Lua
local Window = Library:new({
    textsize = 13.5, -- Font size (Default: 12)
    font = Enum.Font.RobotoMono, -- Font style (Default: "RobotoMono")
    name = "UI Name", -- Window title
    color = Color3.fromRGB(225, 58, 81) -- Accent color
})
2. Layout Structure
Pages (Tabs)
Pages act as the main tabs within your window. If you want to use the configuration saving system, you must assign a pointer string.

Lua
local Tab = Window:page({
    name = "Tab Name", 
    pointer = "Tab1Pointer" -- Required if using the config system
})
Sections
Sections organize elements vertically. They are placed on either the left or right side of the page.

Lua
local Section = Tab:section({
    name = "Section Name",
    side = "left", -- "left" or "right"
    size = 250 -- Y-axis size of the section container
})
Multi-Sections
Multi-sections are sections that have their own sub-tabs.

Lua
local MultiContainer = Tab:multisection({
    name = "Multi Section Container",
    side = "right",
    size = 250
})

-- Add tabs inside the Multi-Section
local SubSection = MultiContainer:section({
    name = "Sub Tab 1"
})
3. Interactive Elements
Note on Pointers: For elements that hold a value (toggles, sliders, dropdowns, etc.), providing a pointer = "string" argument is highly recommended. The configloader uses these pointers to save and load user settings.

Toggle
A standard on/off switch.

Lua
Section:toggle({
    name = "Aimbot",
    def = false, -- Default state
    pointer = "AimToggle",
    callback = function(state)
        print("Toggled:", state)
    end
})
Button
A clickable button to execute code.

Lua
Section:button({
    name = "Print Hello",
    callback = function()
        print("Hello World!")
    end
})
Slider
A draggable slider for numerical values.

Lua
Section:slider({
    name = "WalkSpeed",
    def = 16, -- Default value
    min = 16, -- Minimum value
    max = 200, -- Maximum value
    rounding = true, -- If true, returns integers. If false, returns decimals.
    tick = false, -- If true, the slider bar visually snaps to ticks
    measurement = " WS", -- String appended to the value display (e.g., "16 WS")
    pointer = "SpeedSlider",
    callback = function(value)
        print("Slider value:", value)
    end
})
Dropdown
A single-selection dropdown menu.

Lua
Section:dropdown({
    name = "Target Part",
    def = "Head", -- Default selection
    max = 4, -- Maximum number of items visible before scrolling
    options = {"Head", "Torso", "HumanoidRootPart"},
    pointer = "TargetDropdown",
    callback = function(selected)
        print("Selected:", selected)
    end
})
Multi-Box
A dropdown menu that allows for multiple selections.

Lua
Section:multibox({
    name = "ESP Filters",
    def = {"Players"}, -- Default selected array
    max = 4,
    options = {"Players", "NPCs", "Items", "Vehicles"},
    pointer = "ESPMulti",
    callback = function(selectedArray)
        -- Returns an array of selected strings
        print("Selected:", table.concat(selectedArray, ", "))
    end
})
Button-Box
Functions visually like a dropdown but acts as a list of buttons that trigger a callback immediately without maintaining a specific "selected" state like a standard dropdown.

Lua
Section:buttonbox({
    name = "Teleports",
    def = "",
    max = 4,
    options = {"Spawn", "Shop", "Arena"},
    callback = function(buttonPressed)
        print("Teleporting to:", buttonPressed)
    end
})
Textbox
A field for user string input.

Lua
Section:textbox({
    name = "Custom Name",
    def = "", -- Default text
    placeholder = "Enter name here...", -- Ghost text
    pointer = "NameBox",
    callback = function(text)
        print("Input:", text)
    end
})
Keybind
Allows the user to bind a specific action to a key or mouse button.

Lua
Section:keybind({
    name = "Toggle UI",
    def = Enum.KeyCode.RightShift, -- Default bind
    allowed = 1, -- Set to 1 to allow MouseButton inputs (MB1, MB2, MB3)
    pointer = "UIKeybind",
    callback = function(key)
        Window.key = key -- Example: Rebinder for the UI hide/show key
    end
})
Color Picker
An HSV color selection tool.

Lua
local Picker = Section:colorpicker({
    name = "ESP Color",
    cpname = "Customize ESP Color", -- Title inside the extended color popup
    def = Color3.fromRGB(255, 255, 255),
    pointer = "ESPColor",
    callback = function(color)
        print("Color changed:", color)
    end
})
4. Utility & Extra Features
These are powerful features found in source.lua that were missing from your original documentation.

Config Loader
Generates a built-in UI for saving, loading, creating, and deleting configurations. Requires a specific folder path. It saves data mapped to the pointer arguments you provided in your elements.

Lua
Section:configloader({
    folder = "MyHubConfigs/" -- Ensure this folder exists in your executor's workspace
})
Watermark
A customizable floating watermark, usually placed in the corner of the screen.

Lua
local wm = Library:watermark()

-- Update the text inside the watermark
wm:update({
    ["FPS"] = 60,
    ["Ping"] = 45,
    ["Status"] = "Undetected"
})

-- Change position: topleft, topright, bottomleft, bottomright
wm:updateside("topright")

-- Show or hide
wm:toggle(true) 
Loader Window
A clean, centered splash screen/loader that appears before the main UI injects.

Lua
local Loader = Library:loader({
    name = "My Hub Loader",
    scriptname = "Blox Fruits",
    close = function()
        print("User clicked Close")
    end,
    login = function()
        print("User clicked Login - Proceeding to load main UI")
        -- Initialize your Window and UI here
    end
})

Loader:toggle() -- Show the loader
Window Control Methods
You can programmatically alter the window after it is created.

Lua
-- Change the primary UI keybind programmatically
Window:setkey(Enum.KeyCode.RightControl)

-- Change the UI accent color on the fly
Window:settheme("accent", Color3.fromRGB(0, 255, 0))

-- Change global font size
Window:settextsize(14)

-- Restrict window dragging movement
Window:settoggle("x", false) -- Disables dragging on X axis
Window:settoggle("y", false) -- Disables dragging on Y axis
