
Tabs = {}
ModuleData = {}
List = {"a"}

--

ScreenGUI = Instance.new("ScreenGui",game.CoreGui)
SCFrame = Instance.new("Frame",ScreenGUI)
SCFrame.Size = UDim2.new(1,0,2,0)
SCFrame.Position = UDim2.new(-0.1,0,0.002,0)
SCFrame.BackgroundTransparency = 1

_G.Tabs = Tabs
_G.ModuleData = ModuleData

GetTabs = function()
	return #Tabs
end

local ui = {

	GUIBind = Enum.KeyCode.RightShift,

	MakeTab = function(TabName,image)
		local NewTab = Instance.new("Frame",SCFrame)
		local TabTitle = Instance.new("TextLabel",NewTab)
		local Image = Instance.new("ImageLabel",NewTab)
		table.insert(Tabs,NewTab)
		NewTab.Size = UDim2.new(0.115,0,0.04/2, 0)
		NewTab.BackgroundColor3 = Color3.fromRGB(30,30,30)
		NewTab.BorderSizePixel = 0
		NewTab.Position = UDim2.new(0,0,0.01,0) + UDim2.new(0.13 * GetTabs(),0,0,0)
		TabTitle.Text = " "..TabName
		TabTitle.Font = Enum.Font.GothamBold
		TabTitle.BackgroundTransparency = 1
		TabTitle.Size = UDim2.new(1, 0, 0.8, 0)
		TabTitle.Position = UDim2.new(0,0,0.1,0)
		TabTitle.TextXAlignment = "Left"
		TabTitle.TextColor3 = Color3.fromRGB(255,255,255)
		TabTitle.TextSize = TabTitle.AbsoluteSize.X * 0.115
		Image.Size = UDim2.new(0.175,0,1,0)
		Image.BorderSizePixel = 0
		Image.Position = UDim2.new(0.815,0,0,0)
		Image.BackgroundTransparency = 1
		Image.Image = image
		return NewTab
	end,

	MakeModule = function(Data)
		local NewFrame = Instance.new("Frame",Data.Tab)
		local Button = Instance.new("TextButton",NewFrame)
		local arrow = Instance.new("ImageLabel",NewFrame)
		local tabnum = 0
		if #Data.Tab:GetChildren() > 2 then
			tabnum = #Data.Tab:GetChildren() - 3
		else
			tabnum = 0
		end
		NewFrame.Size = UDim2.new(1,0,0.9,0)
		NewFrame.Position = UDim2.new(0,0,1 + (tabnum * 0.9),0)
		NewFrame.BorderSizePixel = 0
		NewFrame.BackgroundColor3 = Color3.fromRGB(54,56,60)
		Button.Size = UDim2.new(1,0,1,0)
		Button.BackgroundTransparency = 1
		Button.TextXAlignment = "Left"
		Button.Text = " "..Data.Name
		Button.TextColor3 = Color3.fromRGB(255,255,255)
		Button.Font = Enum.Font.GothamBold
		Button.TextSize = Button.AbsoluteSize.X * 0.1
		arrow.Size = UDim2.new(0.1,0,0.4,0)
		arrow.BackgroundTransparency = 1
		arrow.Position = UDim2.new(0.85,0,0.325,0)
		arrow.Image = getsynasset("tenacity/icons/arrow.png")
		Button.MouseButton1Click:Connect(function()
			if Data.Status == false then
				Data.Status = true
				NewFrame.BackgroundColor3 = Color3.fromRGB(185,110,255)
				Data.Function()
			else
				Data.Status = false
				NewFrame.BackgroundColor3 = Color3.fromRGB(54,56,60)
			end
		end)
        local debounce = false
        local opened = false
		Button.MouseButton2Click:Connect(function()
            if debounce == false then
                debounce = true
                spawn(function()
                    for i=1,45 do
                        task.wait()
                        arrow.Rotation = arrow.Rotation + 4
                    end
                end)
                local dropdowncount = 0
                for i,v in pairs(Data.Dropdowns) do
                    dropdowncount = dropdowncount + 1
                end
                for i,v in pairs(Data.Tab:GetChildren()) do
                    if v:IsA("Frame") then
                        if v.Position.Y.Scale > NewFrame.Position.Y.Scale then
                            if opened == false then
                                spawn(function()
                                    for i=1,10 do
                                        task.wait()
                                        v.Position = v.Position + UDim2.new(0,0,dropdowncount/10,0)
                                    end
                                end)
                            else
                                spawn(function()
                                    for i=1,10 do
                                        task.wait()
                                        v.Position = v.Position - UDim2.new(0,0,dropdowncount/10,0)
                                    end
                                end)
                            end
                        end
                    end
                end

                if opened == false then
                    local DropdownFrame = Instance.new("Frame",NewFrame)
                    DropdownFrame.BorderSizePixel = 0
                    DropdownFrame.Name = "Dropdown"
                    DropdownFrame.Position = UDim2.new(0,0,1,0)
                    DropdownFrame.Size = UDim2.new(1,0,dropdowncount + 0.2,0)
                    spawn(function()
                        while wait() do
                            if Data.Status == false then
                                DropdownFrame.BackgroundColor3 = Color3.fromRGB(45,46,49)
                            else
                                DropdownFrame.BackgroundColor3 = Color3.fromRGB(0,95,145)
                            end
                        end
                    end)

                    local added = 0

                    for i,v in pairs(Data.Dropdowns) do
                        if v.Type == "Toggle" then
                            local Frame = Instance.new("Frame",DropdownFrame)
                            local ToggleButton = Instance.new("TextButton",Frame)
                            local slidebar = Instance.new("Frame",Frame)
                            local slideball = Instance.new("Frame",slidebar)
                            local corner1 = Instance.new("UICorner",sliderbar)
                            local corner2 = Instance.new("UICorner",sliderbar)
                            slideball.Size = UDim2.new(0.3,0,1.3,0)
                            slideball.AnchorPoint = Vector2.new(0.5,0.5)
                            slideball.Position = UDim2.new(0,0,0.5,0)
                            corner1.CornerRadius = UDim.new(10,10)
                            corner2.CornerRadius = UDim.new(50,50)
                            slidebar.Size = UDim2.new(0.1,0,0.3,0)
                            slidebar.Position = UDim2.new(0.75,0,0.35,0)
                            Frame.Size = UDim2.new(1,0,1/dropdowncount,0)
                            Frame.Position = UDim2.new(0,0,added*1/dropdowncount,0)
                            Frame.BackgroundTransparency = 1
                            ToggleButton.Text = " "..v.Name
                            ToggleButton.Size = UDim2.new(1,0,1,0)
                            ToggleButton.TextXAlignment = "Left"
                            ToggleButton.Font = Enum.Font.Gotham
                            ToggleButton.BackgroundTransparency = 1
                            ToggleButton.TextColor3 = Color3.fromRGB(255,255,255)
                            ToggleButton.TextSize = ToggleButton.AbsoluteSize.X * 0.09
                            added=added+1
                        end
                    end
                else
                    if NewFrame:FindFirstChild("Dropdown") then
                        NewFrame.Dropdown:Destroy()
                    end
                end

				if opened == true then
					opened = false
				else
					opened = true
				end
                task.wait(.4)
                debounce = false
            end
		end)
	end,
}

ScreenGUI.Name = game:GetService("HttpService"):GenerateGUID(false)
ScreenGUI.Enabled = false

game:GetService("UserInputService").InputBegan:Connect(function()
	local keys = game:GetService("UserInputService"):GetKeysPressed()
	for i,v in pairs(keys) do
		if v.KeyCode == ui.GUIBind then
			ScreenGUI.Enabled = not ScreenGUI.Enabled
		end
	end
end)

return ui
