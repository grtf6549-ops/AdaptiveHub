-- ==========================================
-- Amin Hub | Advanced Integrated Spy Panel
-- ==========================================

local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
local RS = game:GetService("ReplicatedStorage")

local Window = WindUI:CreateWindow({
    Title = "Amin Hub | Master Control",
    SubTitle = "Integrated Spy & Scanner",
    Theme = "Dark"
})

-- 1. تبويب أدوات التجسس
local SpyTab = Window:Tab({ Title = "Spy & Intercept", Icon = "eye" })
SpyTab:Paragraph({
    Title = "تحذير هام",
    Desc = "استخدم هذه الأداة لاكتشاف الأحداث، ثم انسخ الكود في ملف loader.lua لتشغيله."
})

-- زر لتشغيل Cobalt (أداة التجسس المتقدمة)
SpyTab:Button({
    Title = "1. تشغيل أداة التجسس (Cobalt)",
    Callback = function()
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://gitlab.com/upio/cobalt/-/releases/permalink/latest/downloads/Cobalt.luau"))()
        end)
        if success then
            WindUI:Notify({Title = "Spy Loaded", Content = "ابحث عن الأحداث في الشاشة", Duration = 5})
        else
            WindUI:Notify({Title = "Error", Content = "فشل تحميل الأداة", Duration = 5})
        end
    end
})

-- 2. تبويب مسح الأحداث التلقائي
local ScanTab = Window:Tab({ Title = "Auto Scanner", Icon = "search" })
ScanTab:Button({
    Title = "2. مسح كل الأحداث (Scan All)",
    Callback = function()
        local count = 0
        local container = Instance.new("ScrollingFrame", ScanTab.Instance)
        -- ملاحظة: هذا الجزء يعتمد على دعم WindUI للـ ScrollingFrame، وهو معقد قليلاً.
        -- لذا سنستخدم الخدعة البسيطة: طباعة الأسماء في الـ Console.
        for _, obj in pairs(RS:GetDescendants()) do
            if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
                print("--------------------------------------------------")
                print("Event Name: " .. obj.Name)
                print("Path: " .. obj:GetFullName())
                count = count + 1
            end
        end
        WindUI:Notify({Title = "Scan Complete", Content = "تم العثور على " .. count .. " حدث. تحقق من الـ Console", Duration = 5})
    end
})

-- 3. إضافة ميزات حساسة يدوياً (التي اكتشفتها أنت)
local FeaturesTab = Window:Tab({ Title = "Manual Features", Icon = "zap" })

FeaturesTab:Button({
    Title = "مثال: قتل تلقائي (يحتاج تعديل)",
    Callback = function()
        -- هنا تضع الكود الذي نسخته من أداة التجسس
        -- مثلاً: game.ReplicatedStorage.Remotes.KillPlayer:FireServer()
        print("قم بتعديل هذا الزر بناءً على ما اكتشفته من الأداة!")
    end
})

print("✅ Amin Hub Master Control Loaded!")
