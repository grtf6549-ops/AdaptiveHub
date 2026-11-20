-- ==========================================
-- Amin Hub | Visible Hook (إثبات عمل الاعتراض)
-- ==========================================

local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")

local Window = WindUI:CreateWindow({ Title = "Amin Hub | Visible Hook", Theme = "Dark" })
local HookTab = Window:Tab({ Title = "Hook Test", Icon = "eye" })

HookTab:Button({
    Title = "تفعيل الاعتراض المرئي (Activate Visible Hook)",
    Callback = function()
        local Event = RS:FindFirstChild("Remotes") and RS.Remotes:FindFirstChild("SetPurchaseMetadata")
        
        if not Event then
            WindUI:Notify({Title = "Error", Content = "لم يتم العثور على الحدث!", Duration = 3})
            return
        end

        -- حفظ الدالة الأصلية
        local oldInvoke = Event.InvokeServer

        -- استبدال الدالة (Hook)
        Event.InvokeServer = function(self, ...)
            local args = {...}
            
            -- [1] الطباعة في الكونسول لترى أن الاعتراض يعمل
            print("========================================")
            print("[Hook] 🚨 تم اعتراض طلب شراء!")
            print("[Hook] البيانات الأصلية: " .. tostring(args[2]))
            
            -- [2] التعديل (تغيير السعر إلى 0)
            if type(args[2]) == "string" then
                args[2] = string.gsub(args[2], '"t":%d+', '"t":0')
                print("[Hook] ✨ البيانات المعدلة: " .. tostring(args[2]))
            end
            
            -- [3] إرسال البيانات المعدلة للسيرفر
            return oldInvoke(self, unpack(args))
        end
        
        WindUI:Notify({Title = "Hook Active", Content = "الاعتراض يعمل الآن! اذهب واشتر شيئاً.", Duration = 5})
    end
})
