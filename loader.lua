-- ==========================================
-- Amin Hub | Deep Code Injector v3
-- ==========================================

local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")

local Window = WindUI:CreateWindow({ Title = "Amin Hub | Deep Injector", Theme = "Dark" })
local InjectTab = Window:Tab({ Title = "Deep Injector", Icon = "terminal" })

-- 1. صندوق الكود
local CodeInput = ""
InjectTab:Input({
    Title = "ألصق الكود هنا (Paste Code)",
    Default = "",
    Placeholder = "local Event = game:GetService...",
    Callback = function(Text) CodeInput = Text end
})

-- 2. زر التنفيذ العميق
InjectTab:Button({
    Title = "تنفيذ عميق (Deep Execute)",
    Callback = function()
        if CodeInput == "" then
            WindUI:Notify({Title = "Error", Content = "الصندوق فارغ!", Duration = 3})
            return
        end
        
        -- تجهيز البيئة (Environment) لتنفيذ الكود
        local env = getfenv() -- جلب البيئة الحالية
        env.game = game
        env.workspace = workspace
        env.Players = Players
        env.RS = RS
        env.LocalPlayer = Players.LocalPlayer

        -- محاولة التنفيذ
        local success, result = pcall(function()
            -- هنا نستخدم loadstring لتنفيذ الكود داخل البيئة
            local func, err = loadstring(CodeInput)
            if not func then error(err) end
            
            -- تشغيل الدالة
            func()
            return "Success"
        end)
        
        -- النتيجة
        if success then
            WindUI:Notify({Title = "Success ✅", Content = "تم التنفيذ بنجاح!", Duration = 4})
        else
            -- إذا فشل، نعرض الخطأ للمستخدم ليعرف السبب
            WindUI:Notify({Title = "Execution Error ❌", Content = tostring(result), Duration = 8})
            warn("Amin Hub Error: " .. tostring(result))
        end
    end
})

-- 3. زر مسح الكود
InjectTab:Button({
    Title = "مسح الكود (Clear Code)",
    Callback = function()
        CodeInput = ""
        WindUI:Notify({Title = "Cleared", Content = "تم مسح الكود", Duration = 2})
    end
})

print("✅ Deep Injector Loaded!")
