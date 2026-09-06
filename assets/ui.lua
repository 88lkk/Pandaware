---------------------------
-- 88lkk Util
---------------------------

local Util = loadstring(game:HttpGet("https://raw.githubusercontent.com/88lkk/Util/refs/heads/main/main.lua"))()

---------------------------
-- Setup
---------------------------

local Header = Style({
	TextScaled = true,
	TextColor3 = Color3.new(1, 1, 1),
	BackgroundTransparency = 1,
	Font = Enum.Font.MontserratBold
})

local Normal = Style({
	TextScaled = true,
	TextColor3 = Color3.new(1, 1, 1),
	BackgroundTransparency = 1,
	Font = Enum.Font.Montserrat
})

SetDefaultProperty("Frame", "BorderSizePixel", 0)

---------------------------
-- Library
---------------------------

local Library = {}

function Library:Window(WindowName)
	local Screen = NewScreen()

	local Frame = _("Frame", {
		Parent = Screen,
		BackgroundColor3 = Color3.new(0, 0, 0),
		Size = UDim2.new(0.6, 0, 0.25, 0),
		BackgroundTransparency = 0.25,
	})
	Center(Frame)
	Ratio(Frame, 0.8)
	Stroke(Frame):Size(2):Trans(0.75):Col(Color3.new(1, 1, 1))

	local Title = _("TextLabel", {
		Parent = Frame,
		Size = UDim2.new(1, 0, 0.07, 0),
		Text = WindowName or "pandware",
		TextXAlignment = Enum.TextXAlignment.Left,
	})
	Pad(Title):A(0.1):L(0.02)
	Header:Apply(Title)

	local Underline = _("Frame", {
		Parent = Frame,
		Size = UDim2.new(0.96, 0, 0, 2),
		Position = UDim2.new(0, 0, 0.07, 0),
		BackgroundColor3 = Color3.new(1, 1, 1),
		BackgroundTransparency = 0.85
	})
	CenterX(Underline)

	local Modules = _("ScrollingFrame", {
		Parent = Frame,
		Size = UDim2.new(0.96, 0, 0.89, 0),
		Position = UDim2.new(0, 0, 0.09, 0),
		BackgroundTransparency = 1,
		ScrollBarThickness = 5,
		ScrollBarImageColor3 = Color3.new(1, 1, 1),
		CanvasSize = UDim2.new(0, 0, 0, 0),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		ElasticBehavior = Enum.ElasticBehavior.Never
	})
	CenterX(Modules)

	local TabLayout = _("UIListLayout", {
		Parent = Modules,
		Padding = UDim.new(0.01, 0)
	})

	local WindowTree = {}

	function WindowTree:Destroy()
		Screen:Destroy()
	end

	function WindowTree:Toggle(TabName, Callback)
		local TabFrame = _("Frame", {
			Parent = Modules,
			Size = UDim2.new(1, 0, 0.1, 0),
			BackgroundTransparency = 0.85,
			BackgroundColor3 = Color3.new(1, 1, 1)
		})
		Pad(TabFrame):A(0.2):L(0.025):R(0.025)

		local TabLayout = _("UIListLayout", {
			Parent = TabFrame,
			FillDirection = Enum.FillDirection.Horizontal,
			SortOrder = Enum.SortOrder.LayoutOrder,
			HorizontalFlex = Enum.UIFlexAlignment.SpaceBetween
		})

		local TabTitle = _("TextLabel", {
			Parent = TabFrame,
			Text = TabName,
			Size = UDim2.new(0.7, 0, 1, 0),
			TextXAlignment = Enum.TextXAlignment.Left
		})
		Normal:Apply(TabTitle)

		local TabToggle = _("TextButton", {
			Parent = TabFrame,
			Text = "",
			Position = UDim2.new(0.725, 0, 0, 0),
			Size = UDim2.new(0.25, 0, 1, 0),
			BorderSizePixel = 0,
			BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)
		})
		CenterY(TabToggle)
		Ratio(TabToggle)
		Round(TabToggle, 1)

		local Toggled = false
		TabToggle.MouseButton1Down:Connect(function()
			Toggled = not Toggled
			Callback(Toggled)

			TabToggle.BackgroundColor3 = Toggled and Color3.new(0, 1, 0) or Color3.new(0.5, 0.5, 0.5)
		end)
	end

	return WindowTree
end

return Library
