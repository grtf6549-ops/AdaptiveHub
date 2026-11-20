-- ==========================================
-- Amin Hub | Live Code Injector
-- ==========================================

local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
local Window = WindUI:CreateWindow({ Title = "Amin Hub | Injector", Theme = "Dark" })

local InjectTab = Window:Tab({ Title = "Code Injector", Icon = "code" })

-- 1. صندوق نصي (TextArea) للصق الكود
local CodeInput = ""
InjectTab:Input({
    Title = "الصق الكود هنا (Paste Code)",
    Default = "",
    Placeholder = "local Event = ...",
    Callback = function(Text)
        CodeInput = Text
    end
})

-- 2. زر التنفيذ
InjectTab:Button({
    Title = "تنفيذ الكود (Execute)",
    Callback = function()
        if CodeInput == "" then
            WindUI:Notify({Title = "Error", Content = "الصندوق فارغ! الصق الكود أولاً.", Duration = 3})
            return
        end
        
        -- محاولة تشغيل الكود الذي لصقته
        local success, err = pcall(function()
            loadstring(CodeInput)() -- هنا يتم تنفيذ الكود المعدل!
        end)
        
        if success then
            WindUI:Notify({Title = "Success", Content = "تم تنفيذ الكود بنجاح!", Duration = 3})
        else
            WindUI:Notify({Title = "Error", Content = "فشل التنفيذ: " .. tostring(err), Duration = 5})
        end
    end
})
