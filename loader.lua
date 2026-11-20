-- ==========================================
-- Amin Hub | The Ultimate Chaos & Admin Panel
-- ==========================================

local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local SoundService = game:GetService("SoundService")

-- 1. الدخول الفخم (الموسيقى والإشعار)
local Music = Instance.new("Sound")
Music.SoundId = "rbxassetid://1837879082" -- موسيقى ملحمية
Music.Volume = 2
Music.Looped = true
Music.Parent = SoundService
Music:Play()

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "⚠️ HACKER JOINED ⚠️",
    Text = "Amin Hub | Chaos Edition",
    Duration = 10
})

-- 2. إنشاء اللوحة
local Window = WindUI:CreateWindow({ Title = "Amin Hub | Chaos & Admin", Theme = "Dark" })
local ChaosTab = Window:Tab({ Title = "Griefing (تخريب)", Icon = "skull" })
local AdminTab = Window:Tab({ Title = "Admin (صلاحيات)", Icon = "shield" })
local MusicTab = Window:Tab({ Title = "Entrance (دخول)", Icon = "music" })

-- ==========================================
-- 3. قسم التخريب (Chaos)
-- ==========================================
ChaosTab:Button({
    Title = "🔥 إغراق السيرفر بالرسائل (Spam Chat)",
    Callback = function()
        local ChatEvent = RS:FindFirstChild("DefaultChatSystemChatEvents") and RS.DefaultChatSystemChatEvents:FindFirstChild("SayMessageRequest")
        if ChatEvent then
            for i = 1, 50 do
                ChatEvent:FireServer("Amin Hub is here! 😈", "All")
                task.wait(0.1)
            end
            WindUI:Notify({Title = "Chat Spam", Content = "تم إغراق الشات!", Duration = 3})
        end
    end
})

ChaosTab:Button({
    Title = "💥 محاولة طرد الجميع (Kick All)",
    Callback = function()
        local kickRemote = nil
        for _, obj in pairs(RS:GetDescendants()) do
            if obj:IsA("RemoteEvent") and (string.find(string.lower(obj.Name), "kick") or string.find(string.lower(obj.Name), "remove")) then
                kickRemote = obj
                break
            end
        end
        
        if kickRemote then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer then
                    pcall(function()
                        kickRemote:FireServer(p.Name)
                        kickRemote:FireServer(p.UserId)
                    end)
                end
            end
            WindUI:Notify({Title = "Kick Attempt", Content = "تم إرسال طلبات الطرد!", Duration = 3})
        else
            WindUI:Notify({Title = "Failed", Content = "لا يوجد حدث طرد متاح.", Duration = 3})
        end
    end
})

ChaosTab:Button({
    Title = "🌪️ تحطيم الماب (Destroy Map)",
    Callback = function()
        for _, obj in pairs(Workspace:GetChildren()) do
            if obj:IsA("BasePart") and obj.Name ~= "Baseplate" then
                obj.Anchored = false
                obj.CanCollide = false
                obj.Velocity = Vector3.new(math.random(-100, 100), 100, math.random(-100, 100))
            end
        end
        WindUI:Notify({Title = "Map Destroyed", Content = "تم تخريب الماب (محلياً).", Duration = 3})
    end
})

-- ==========================================
-- 4. قسم الصلاحيات (Admin)
-- ==========================================
AdminTab:Paragraph({ Title = "تحذير", Desc = "هذه الأدوات تحاول انتحال صلاحيات الأدمن. قد تؤدي لطردك." })

AdminTab:Button({
    Title = "1. انتحال اسم أدمن (Spoof Name)",
    Callback = function()
        local adminNames = {"Admin", "Owner", "Creator"}
        for _, name in pairs(adminNames) do
            pcall(function() LocalPlayer.Name = name end)
        end
        WindUI:Notify({Title = "Spoofed", Content = "تم تغيير الاسم محلياً.", Duration = 3})
    end
})

AdminTab:Button({
    Title = "2. إرسال طلب أدمن مزيف (Fake Request)",
    Callback = function()
        local adminRemote = nil
        for _, obj in pairs(RS:GetDescendants()) do
            if obj:IsA("RemoteEvent") and (string.find(string.lower(obj.Name), "admin") or string.find(string.lower(obj.Name), "command")) then
                adminRemote = obj
                break
            end
        end
        
        if adminRemote then
            adminRemote:FireServer("give_admin", LocalPlayer.UserId)
            adminRemote:FireServer("set_rank", LocalPlayer.UserId, "Owner")
            WindUI:Notify({Title = "Request Sent", Content = "تم إرسال طلب الصلاحيات.", Duration = 3})
        else
            WindUI:Notify({Title = "Failed", Content = "لا يوجد حدث إداري متاح.", Duration = 3})
        end
    end
})

AdminTab:Button({
    Title = "3. سرقة توكن (Steal Token)",
    Callback = function()
        local success = pcall(function()
            local playerScripts = LocalPlayer:FindFirstChild("PlayerScripts")
            if playerScripts then
                for _, obj in pairs(playerScripts:GetDescendants()) do
                    if obj:IsA("StringValue") and string.find(string.lower(obj.Name), "token") then
                        print("🔑 Token Found: " .. obj.Value)
                        local remote = RS:FindFirstChild("Remotes") and RS.Remotes:FindFirstChild("VerifyToken")
                        if remote then remote:FireServer(obj.Value) end
                    end
                end
            end
        end)
        if not success then
            WindUI:Notify({Title = "Failed", Content = "لم يتم العثور على توكن.", Duration = 3})
        end
    end
})

-- ==========================================
-- 5. قسم الدخول (Entrance)
-- ==========================================
MusicTab:Button({
    Title = "▶️ تشغيل الموسيقى",
    Callback = function() Music:Play() end
})

MusicTab:Button({
    Title = "⏹️ إيقاف الموسيقى",
    Callback = function() Music:Stop() end
})

MusicTab:Button({
    Title = "💀 إرسال رسالة دخول للجميع",
    Callback = function()
        local ChatEvent = RS:FindFirstChild("DefaultChatSystemChatEvents") and RS.DefaultChatSystemChatEvents:FindFirstChild("SayMessageRequest")
        if ChatEvent then
            ChatEvent:FireServer("⚠️ HACKER AMIN HAS ARRIVED ⚠️", "All")
        end
    end
})

print("✅ Ultimate Chaos & Admin Panel Loaded!")
