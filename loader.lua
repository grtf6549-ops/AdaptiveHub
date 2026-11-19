-- ==========================================
-- Amin Hub | Smart Discovery (Auto-Attempt)
-- ==========================================

local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
local RS = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Window = WindUI:CreateWindow({
    Title = "Amin Hub | Smart Scan",
    SubTitle = "Smart Attempt Enabled",
    Theme = "Dark"
})

local DiscoveryTab = Window:Tab({ Title = "Discovered Features", Icon = "search" })

local function GenerateDiscoveryButtons()
    local count = 0
    
    for _, obj in pairs(RS:GetDescendants()) do
        if obj:IsA("RemoteEvent") then
            count = count + 1
            
            DiscoveryTab:Button({
                Title = obj.Name,
                Callback = function()
                    -- [1] المحاولة الأولى: طلب فارغ (الذي جربناه سابقاً)
                    obj:FireServer()
                    
                    -- [2] المحاولة الثانية: إرسال اسم اللاعب (لأحداث الطرد أو التفاعل)
                    obj:FireServer(LocalPlayer.Name)
                    
                    -- [3] المحاولة الثالثة: إرسال معرف اللاعب (UserId)
                    obj:FireServer(LocalPlayer.UserId)
                    
                    -- [4] المحاولة الرابعة: إرسال رقم كبير (لأحداث المال أو النقاط)
                    obj:FireServer(99999)
                    
                    -- [5] المحاولة الخامسة: إرسال "true" (لتفعيل الأشياء)
                    obj:FireServer(true)
                    
                    WindUI:Notify({
                        Title = "Smart Attempt",
                        Content = "Tried 5 different arguments for: " .. obj.Name,
                        Duration = 3
                    })
                end
            })
            
            if count >= 30 then break end
        end
    end
end

GenerateDiscoveryButtons()
