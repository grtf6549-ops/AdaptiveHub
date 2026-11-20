-- ==========================================
-- Amin Hub | Ultimate Server Takeover (Attempt)
-- ==========================================

local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
local RS = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local HttpService = game:GetService("HttpService")

local Window = WindUI:CreateWindow({ Title = "Amin Hub | Server Takeover", Theme = "Dark" })
local AdminTab = Window:Tab({ Title = "Admin Takeover", Icon = "shield" })
local PlayerTab = Window:Tab({ Title = "Players Info", Icon = "users" })

-- 1. مسح الأحداث الإدارية (Admin Scanner)
AdminTab:Button({
    Title = "1. البحث عن أحداث الأدمن (Scan Admin Events)",
    Callback = function()
        local found = 0
        for _, obj in pairs(RS:GetDescendants()) do
            if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
                local name = string.lower(obj.Name)
                if string.find(name, "admin") or string.find(name, "command") or string.find(name, "kick") or string.find(name, "ban") then
                    print("🔍 Admin Event Found: " .. obj:GetFullName())
                    found = found + 1
                end
            end
        end
        WindUI:Notify({Title = "Scan Done", Content = "تم العثور على " .. found .. " حدث إداري.", Duration = 5})
    end
})

-- 2. محاولة "انتحال" صلاحيات المطور (Developer Spoofing)
AdminTab:Button({
    Title = "2. محاولة انتحال المطور (Spoof Dev)",
    Callback = function()
        -- البحث عن أي حدث يخص الصلاحيات
        local adminEvents = {}
        for _, obj in pairs(RS:GetDescendants()) do
            if obj:IsA("RemoteEvent") and (string.find(string.lower(obj.Name), "admin") or string.find(string.lower(obj.Name), "command")) then
                table.insert(adminEvents, obj)
            end
        end
        
        -- إرسال طلبات مختلفة لكل حدث
        for _, ev in pairs(adminEvents) do
            pcall(function()
                ev:FireServer("give_admin", LocalPlayer.UserId)
                ev:FireServer("set_rank", LocalPlayer.UserId, "Owner")
                ev:FireServer("I am owner")
            end)
        end
        WindUI:Notify({Title = "Attempted", Content = "تم إرسال طلبات انتحال الصلاحيات.", Duration = 3})
    end
})

-- 3. جمع معلومات اللاعبين (Player Info Collector)
-- هذا الجزء يجمع الأسماء والصور (Avatars) لكل اللاعبين
PlayerTab:Button({
    Title = "جمع معلومات اللاعبين (Collect Players Info)",
    Callback = function()
        print("=== معلومات اللاعبين في السيرفر ===")
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then
                -- الحصول على صورة اللاعب
                local avatarUrl = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. p.UserId .. "&width=150&height=150&format=png"
                print("👤 الاسم: " .. p.Name)
                print("🆔 المعرف: " .. p.UserId)
                print("🖼️ الصورة: " .. avatarUrl)
                print("-------------------------")
            end
        end
        WindUI:Notify({Title = "Info Collected", Content = "تم طباعة معلومات اللاعبين في الكونسول.", Duration = 5})
    end
})

-- 4. محاولة طرد لاعب محدد (Kick Specific Player)
local targetName = ""
PlayerTab:Input({
    Title = "اسم اللاعب المراد طرده",
    Default = "",
    Callback = function(text) targetName = text end
})

PlayerTab:Button({
    Title = "محاولة طرد اللاعب (Try Kick)",
    Callback = function()
        if targetName == "" then return end
        
        -- البحث عن حدث الطرد
        local kickEvent = nil
        for _, obj in pairs(RS:GetDescendants()) do
            if obj:IsA("RemoteEvent") and string.find(string.lower(obj.Name), "kick") then
                kickEvent = obj
                break
            end
        end
        
        if kickEvent then
            local target = Players:FindFirstChild(targetName)
            if target then
                pcall(function()
                    kickEvent:FireServer(target.UserId)
                    kickEvent:FireServer(target.Name)
                end)
                WindUI:Notify({Title = "Attempted", Content = "تم إرسال طلب طرد " .. targetName, Duration = 3})
            else
                WindUI:Notify({Title = "Error", Content = "اللاعب غير موجود.", Duration = 3})
            end
        else
            WindUI:Notify({Title = "Error", Content = "لا يوجد حدث طرد.", Duration = 3})
        end
    end
})

print("✅ Server Takeover Module Loaded!")
