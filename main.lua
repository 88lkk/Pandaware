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
	Font = Enum.Font.MontserratBold,
	TextStrokeTransparency = 0
})

local Normal = Style({
	TextScaled = true,
	TextColor3 = Color3.new(1, 1, 1),
	Font = Enum.Font.Montserrat,
	TextStrokeTransparency = 0
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
		Active = true,
		Draggable = true
	})
	Center(Frame)
	Ratio(Frame, 0.8)
	Stroke(Frame):Size(2):Trans(0.75):Col(Color3.new(1, 1, 1))

	local Title = _("TextLabel", {
		Parent = Frame,
		Size = UDim2.new(1, 0, 0.07, 0),
		Text = WindowName or "pandware",
		TextXAlignment = Enum.TextXAlignment.Left,
		BackgroundTransparency = 1
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

	local ModulesLayout = _("UIListLayout", {
		Parent = Modules,
		Padding = UDim.new(0.01, 0),
		SortOrder = Enum.SortOrder.LayoutOrder
	})

	local WindowTree = {}

	function WindowTree:Destroy()
		Screen:Destroy()
	end

	function WindowTree:Toggle(ToggleName, Callback)
		local ToggleFrame = _("Frame", {
			Parent = Modules,
			Size = UDim2.new(1, 0, 0.1, 0),
			BackgroundTransparency = 0.85,
			BackgroundColor3 = Color3.new(1, 1, 1)
		})
		Pad(ToggleFrame):A(0.2):L(0.025):R(0.025)

		local ToggleLayout = _("UIListLayout", {
			Parent = ToggleFrame,
			FillDirection = Enum.FillDirection.Horizontal,
			SortOrder = Enum.SortOrder.LayoutOrder,
			HorizontalFlex = Enum.UIFlexAlignment.SpaceBetween
		})

		local ToggleTitle = _("TextLabel", {
			Parent = ToggleFrame,
			Text = ToggleName,
			Size = UDim2.new(0.7, 0, 1, 0),
			TextXAlignment = Enum.TextXAlignment.Left,
			BackgroundTransparency = 1
		})
		Normal:Apply(ToggleTitle)

		local ToggleButton = _("TextButton", {
			Parent = ToggleFrame,
			Text = "",
			Position = UDim2.new(0.725, 0, 0, 0),
			Size = UDim2.new(0.25, 0, 1, 0),
			BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)
		})
		CenterY(ToggleButton)
		Ratio(ToggleButton)
		Round(ToggleButton, 1)
		Stroke(ToggleButton):Apply("Border"):Line("Round")

		local Toggled = false
		ToggleButton.Activated:Connect(function()
			Toggled = not Toggled
			Callback(Toggled)

			ToggleButton.BackgroundColor3 = Toggled and Color3.new(0, 1, 0) or Color3.new(0.5, 0.5, 0.5)
		end)
	end

	function WindowTree:Button(ButtonName, Callback)
		local Button = _("TextButton", {
			Parent = Modules,
			Size = UDim2.new(1, 0, 0.1, 0),
			BackgroundTransparency = 0.85,
			BackgroundColor3 = Color3.new(1, 1, 1),
			TextXAlignment = Enum.TextXAlignment.Left,
			Text = ButtonName
		})
		Pad(Button):A(0.2):L(0.025):R(0.025)
		Normal:Apply(Button)
		Button.Activated:Connect(Callback)
	end

	function WindowTree:Dropdown(DropdownName, Options, Callback)
		local SelectedOption = Options[1]

		local DropdownFrame = _("Frame", {
			Parent = Modules,
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0.1, 0)
		})

		local DropdownTitle = _("TextLabel", {
			Parent = DropdownFrame,
			Text = DropdownName,
			Size = UDim2.new(0.45, 0, 1, 0),
			TextXAlignment = Enum.TextXAlignment.Left,
			BackgroundTransparency = 1
		})
		Normal:Apply(DropdownTitle)
		Pad(DropdownTitle):A(0.2):L(0.025):R(0.025)
		
		local DropdownButton = _("TextButton", {
			Parent = DropdownFrame,
			Size = UDim2.new(0.5, 0, 1, 0),
			Position = UDim2.new(0.5, 0, 0, 0),
			BackgroundTransparency = 0.85,
			BackgroundColor3 = Color3.new(1, 1, 1),
			Text = SelectedOption
		})
		Pad(DropdownButton):A(0.2):L(0.025):R(0.025)
		Normal:Apply(DropdownButton)

		local DropdownArrow = _("TextLabel", {
			Parent = DropdownButton,
			Text = "▼",
			Size = UDim2.new(0.3, 0, 1, 0),
			Position = UDim2.new(1, 0, 0, 0),
			AnchorPoint = Vector2.new(1, 0),
			TextXAlignment = Enum.TextXAlignment.Right,
			TextTransparency = 0.5,
			BackgroundTransparency = 1,
			ZIndex = 2
		})
		Normal:Apply(DropdownArrow)

		local Dropped = false
		local Archive = {}

		local function EndDropdown()
			for i, Inst in Archive do
				Inst:Destroy()
			end
			Dropped = false
			DropdownArrow.Text = "▼"
		end

		DropdownButton.Activated:Connect(function()
			if Dropped then
				EndDropdown()
				return
			end
			Dropped = true
			DropdownArrow.Text = "▲"

			Archive = {}
			local Num = 0

			for i, Option in pairs(Options) do
				if Option == SelectedOption then continue end

				Num += 1
				local Clone = DropdownButton:Clone()
				Clone.Parent = DropdownFrame
				Clone.Text = Option
				Clone.Size = UDim2.new(0.5, 0, 1, 0)
				Clone.Position = UDim2.new(0.5, 0, Num, 0)

				local CloneArrow = Clone:FindFirstChild("TextLabel")
				if CloneArrow then CloneArrow:Destroy() end

				table.insert(Archive, Clone)

				Clone.Activated:Connect(function()
					EndDropdown()
					SelectedOption = Option
					DropdownButton.Text = Option
				end)
			end
		end)
	end

	function WindowTree:Slider(SliderName, Min, Max, Default, Callback)
		local SliderFrame = _("Frame", {
			Parent = Modules,
			Size = UDim2.new(1, 0, 0.1, 0),
			BackgroundTransparency = 1
		})

		local SliderLayout = _("UIListLayout", {
			Parent = SliderFrame,
			FillDirection = Enum.FillDirection.Horizontal,
			SortOrder = Enum.SortOrder.LayoutOrder,
			HorizontalFlex = Enum.UIFlexAlignment.SpaceBetween
		})

		local SliderTitle = _("TextLabel", {
			Parent = SliderFrame,
			Text = SliderName,
			Size = UDim2.new(0.5, 0, 1, 0),
			TextXAlignment = Enum.TextXAlignment.Left,
			BackgroundTransparency = 1
		})
		Normal:Apply(SliderTitle)
		Pad(SliderTitle):A(0.2):L(0.025):R(0.025)

		local SliderBack = _("Frame", {
			Parent = SliderFrame,
			Size = UDim2.new(0.5, 0, 1, 0),
			BackgroundTransparency = 0.85,
			BackgroundColor3 = Color3.new(1, 1, 1)
		})

		local Fraction = (Default - Min) / (Max - Min)

		local SliderFill = _("Frame", {
			Parent = SliderBack,
			Size = UDim2.new(Fraction, 0, 1, 0),
			BackgroundColor3 = Color3.new(1, 1, 1)
		})

		local SliderValue = _("TextLabel", {
			Parent = SliderBack,
			Text = tostring(Default),
			Size = UDim2.new(1, 0, 1, 0),
			TextXAlignment = Enum.TextXAlignment.Center,
			BackgroundTransparency = 1,
			ZIndex = 2
		})
		Normal:Apply(SliderValue)
		Pad(SliderValue):A(0.2):L(0.025):R(0.025)

		local SliderButton = _("TextButton", {
			Parent = SliderBack,
			Text = "",
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundTransparency = 1,
			ZIndex = 3
		})

		local Dragging = false

		SliderButton.InputBegan:Connect(function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
				Dragging = true
			end
		end)

		UserInputService.InputEnded:Connect(function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
				Dragging = false
			end
		end)

		UserInputService.InputChanged:Connect(function(Input)
			if Dragging and (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) then
				local RelativeX = math.clamp((Input.Position.X - SliderBack.AbsolutePosition.X) / SliderBack.AbsoluteSize.X, 0, 1)
				local Value = math.floor(Min + (RelativeX * (Max - Min)))

				SliderFill.Size = UDim2.new(RelativeX, 0, 1, 0)
				SliderValue.Text = tostring(Value)

				Callback(Value)
			end
		end)
	end

	return WindowTree
end

return Library
