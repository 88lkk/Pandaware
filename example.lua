local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/88lkk/Pandaware/refs/heads/main/main.lua"))()
local Window = Library:Window("window")

--                TOGGLE
--                NAME            CALLBACK
Window:Toggle(    "toggle",       print                                                )

--                BUTTON
--                NAME            CALLBACK
Window:Button(    "button",       print                                                )

--                DROPDOWN
--                NAME            OPTIONS        CALLBACK
Window:Dropdown(  "dropdown",     {1, 2, 3},     print                                 )

--                SLIDER
--                NAME            MIN            MAX        DEFAULT       CALLBACK
Window:Slider(    "slider",       0,             10,        5,            print        )
