-- ==========================================
-- Amin Hub | Smart Data Injection v2
-- ==========================================

local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
local RS = game:GetService("ReplicatedStorage")

local Window = WindUI:CreateWindow({
    Title = "Amin Hub | Data Injector",
    SubTitle = "Auto-Testing Values...",
    Theme = "Dark"
})

local InjectTab = Window:Tab({ Title = "Injector", Icon = "zap" })

InjectTab:Button({
    Title = "محاولة إعطاء الذهب (Try Give Gold)",
    Callback = function()
        local Event = RS:FindFirstChild("Remotes") and RS.Remotes:FindFirstChild("Send")
        if not Event then
            WindUI:Notify({Title = "Error", Content = "لم يتم العثور على الحدث Send", Duration = 3})
            return
        end

        -- محاولة إرسال البيانات بطرق مختلفة
        -- 1. الطريقة القديمة (التي جربتها)
        Event:FireServer(24, "games_save", { ["Monster Slayer"] = { gold = 999999 } })
        
        -- 2. الطريقة الجديدة: إرسال الأرقام فقط
        Event:FireServer(24, "gold", 999999)
        
        -- 3. إرسال النص فقط
        Event:FireServer("give_gold", 999999)
        
        -- 4. إرسال جدول بسيط
        Event:FireServer({ type = "save", gold = 999999 })

        WindUI:Notify({
            Title = "Attempted",
            Content = "تم إرسال 4 محاولات مختلفة. راقب اللعبة!",
            Duration = 5
        })
    end
})

-- دالة لمراقبة الأحداث (للتجسس المباشر)
InjectTab:Button({
    Title = "تشغيل أداة التجسس (Cobalt)",
    Callback = function()
        loadstring(game:HttpGet("https://gitlab.com/upio/cobalt/-/releases/permalink/latest/downloads/Cobalt.luau"))()
    end
})

print("✅ Smart Injector Ready!")
