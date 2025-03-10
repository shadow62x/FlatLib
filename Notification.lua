local TweenService = game:GetService("TweenService")
local FlatLib = game:GetObjects("rbxassetid://89161195198423")[1]
local NotificationArea = FlatLib.NotificationArea
local Example = NotificationArea.Example
Example.Visible = false

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "NotificationScreen"
screenGui.Parent = game.Players.LocalPlayer.PlayerGui

NotificationArea.Parent = screenGui

FlatLib.Parent = nil  

local UIListLayout = NotificationArea:FindFirstChild("UIListLayout")
if not UIListLayout then
    UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Parent = NotificationArea
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 10) 
end

function Notify(data)
    local newNotification = Example:Clone()

    if not newNotification then
        warn("couldn't clone notification.")
        return
    end

    newNotification.Parent = NotificationArea

    newNotification.Title.Text = data.Title or "Example Text"
    newNotification.Description.Text = data.Content or "Example Content. Example Content."

    if data.Image then
        local icon = newNotification:FindFirstChild("Icon")
        if icon then

            icon.Image = "rbxassetid://" .. tostring(data.Image)
        else
            warn("Icon not found in notification template")
        end
    end

    newNotification.Visible = true

    local bounds = {newNotification.Title.TextBounds.Y, newNotification.Description.TextBounds.Y}
    newNotification.Size = UDim2.new(1, -60, 0, -NotificationArea:FindFirstChild("UIListLayout").Padding.Offset)

    newNotification.Icon.Size = UDim2.new(0, 32, 0, 32)
    newNotification.Icon.Position = UDim2.new(0, 20, 0.5, 0)

    TweenService:Create(newNotification, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {Size = UDim2.new(1, 0, 0, math.max(bounds[1] + bounds[2] + 31, 60))}):Play()

    task.wait(0.15)

    TweenService:Create(newNotification, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {BackgroundTransparency = 0.45}):Play()
    TweenService:Create(newNotification.Title, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {TextTransparency = 0}):Play()

    task.wait(0.05)

    TweenService:Create(newNotification.Icon, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {ImageTransparency = 0}):Play()

    task.wait(0.05)
    TweenService:Create(newNotification.Description, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {TextTransparency = 0.35}):Play()
    TweenService:Create(newNotification.UIStroke, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {Transparency = 0.95}):Play()
    TweenService:Create(newNotification.Shadow, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {ImageTransparency = 0.82}):Play()

    local waitDuration = math.min(math.max((#newNotification.Description.Text * 0.1) + 2.5, 3), 10)
    task.wait(data.Duration or waitDuration)

    newNotification.Icon.Visible = false
    TweenService:Create(newNotification, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {BackgroundTransparency = 1}):Play()
    TweenService:Create(newNotification.UIStroke, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {Transparency = 1}):Play()
    TweenService:Create(newNotification.Shadow, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {ImageTransparency = 1}):Play()
    TweenService:Create(newNotification.Title, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {TextTransparency = 1}):Play()
    TweenService:Create(newNotification.Description, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {TextTransparency = 1}):Play()

    TweenService:Create(newNotification, TweenInfo.new(1, Enum.EasingStyle.Exponential), {Size = UDim2.new(1, -90, 0, 0)}):Play()

    task.wait(1)

    TweenService:Create(newNotification, TweenInfo.new(1, Enum.EasingStyle.Exponential), {Size = UDim2.new(1, -90, 0, -NotificationArea:FindFirstChild("UIListLayout").Padding.Offset)}):Play()

    newNotification.Visible = false
    newNotification:Destroy()
end

