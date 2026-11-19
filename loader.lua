-- loader.lua (Universal Adaptive System)
local PlaceId = game.PlaceId
local HttpService = game:GetService("HttpService")

-- 1. تحميل مكتبة الواجهة (WindUI)
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

-- 2. إنشاء النافذة الأساسية
local Window = WindUI:CreateWindow({
    Title = "Amin Hub | Universal",
    SubTitle = "Game ID: " .. PlaceId,
    Theme = "Dark"
})

-- 3. قاعدة بيانات الميزات (Features Database)
-- هنا نضع الميزات التي تعمل في أي لعبة
local UniversalFeatures = {
    -- ميزة الحركة (تعمل في 90% من الألعاب)
    Speed = function(val)
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = val
        end
    end,
    
    -- ميزة الطيران
    Fly = function(state)
        -- كود الطيران (يمكنك إضافة كود معقد هنا)
        print("Fly: " .. tostring(state))
    end,
    
    -- ميزة الرؤية الليلية
    Fullbright = function(state)
        game.Lighting.Brightness = state and 3 or 1
    end
}

-- 4. بناء التبويبات
local MainTab = Window:Tab({ Title = "Universal", Icon = "globe" })

MainTab:Slider({
    Title = "WalkSpeed",
    Value = { Min = 16, Max = 200, Default = 16 },
    Callback = UniversalFeatures.Speed
})

MainTab:Toggle({
    Title = "Fullbright",
    Default = false,
    Callback = UniversalFeatures.Fullbright
})

-- 5. نظام التوجيه للعبة "99 ليلة" (مثال)
if PlaceId == 920587237 then -- ضع الـ PlaceId الحقيقي هنا
    local GameTab = Window:Tab({ Title = "99 Nights", Icon = "moon" })
    GameTab:Button({
        Title = "Skip Night",
        Callback = function()
            game.ReplicatedStorage.RemoteEvents.RequestActivateNightSkipMachine:FireServer()
        end
    })
end

print("✅ Amin Hub Loaded Successfully!")
