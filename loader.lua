-- ==========================================
-- Amin Hub | Ultimate Spy & Action Panel
-- ==========================================

local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
local RS = game:GetService("ReplicatedStorage")

local Window = WindUI:CreateWindow({
    Title = "Amin Hub | Master Control",
    SubTitle = "Spy & Execute",
    Theme = "Dark"
})

-- 1. تبويب التجسس (لاكتشاف الأسرار)
local SpyTab = Window:Tab({ Title = "1. Spy (تجسس)", Icon = "eye" })
SpyTab:Button({
    Title = "تشغيل أداة Cobalt",
    Callback = function()
        loadstring(game:HttpGet("https://gitlab.com/upio/cobalt/-/releases/permalink/latest/downloads/Cobalt.luau"))()
    end
})

-- 2. تبويب التنفيذ اليدوي (الذي تضع فيه ما اكتشفته)
local ExecTab = Window:Tab({ Title = "2. Execute (تنفيذ)", Icon = "zap" })

-- هنا تضع الأزرار التي تريدها، بناءً على ما تراه في أداة التجسس
ExecTab:Button({
    Title = "Kill All (طرد/قتل الجميع)",
    Callback = function()
        -- افترض أنك اكتشفت من أداة التجسس أن مسار القتل هو هذا:
        local remote = RS:FindFirstChild("Remotes") and RS.Remotes:FindFirstChild("KillPlayer")
        if remote then
            for _, p in pairs(game.Players:GetPlayers()) do
                if p ~= game.Players.LocalPlayer then
                    remote:FireServer(p) -- إرسال اللاعب كقيمة
                end
            end
        else
            WindUI:Notify({Title = "Error", Content = "Remote not found!", Duration = 3})
        end
    end
})

ExecTab:Button({
    Title = "Give Money (إعطاء مال)",
    Callback = function()
        -- افترض أنك اكتشفت المسار والقيمة
        local remote = RS:FindFirstChild("Remotes") and RS.Remotes:FindFirstChild("GiveMoney")
        if remote then
            remote:FireServer(999999) -- إرسال الرقم
        else
            WindUI:Notify({Title = "Error", Content = "Remote not found!", Duration = 3})
        end
    end
})

-- 3. تبويب المسح التلقائي (لتصنيف ما تم اكتشافه)
local ScanTab = Window:Tab({ Title = "3. Auto Scan (مسح)", Icon = "search" })
ScanTab:Button({
    Title = "مسح كل الأحداث",
    Callback = function()
        local count = 0
        for _, obj in pairs(RS:GetDescendants()) do
            if obj:IsA("RemoteEvent") then
                count = count + 1
                -- نصنع زراً لكل حدث (بدون قيمة سرية، فقط طلب فارغ)
                ScanTab:Button({
                    Title = obj.Name,
                    Callback = function()
                        obj:FireServer() -- طلب فارغ
                        WindUI:Notify({Title = "Fired", Content = obj.Name, Duration = 2})
                    end
                })
            end
        end
        WindUI:Notify({Title = "Scan Done", Content = "وجدت " .. count .. " حدث", Duration = 5})
    end
})

print("✅ Master Control Ready!")
