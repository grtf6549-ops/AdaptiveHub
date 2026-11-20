-- ==========================================
-- Amin Hub | The Arsenal of Hooks (4-in-1)
-- ==========================================

local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Window = WindUI:CreateWindow({ Title = "Amin Hub | Arsenal", Theme = "Dark" })
local HookTab = Window:Tab({ Title = "Hook Tools", Icon = "shield" })

-- 1. أداة ShydeDev (الأساسية للاعتراض)
HookTab:Button({
    Title = "1. تفعيل مكتبة ShydeDev (Basic Hooks)",
    Callback = function()
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/ShydeDev/Roblox-Universal-Exploiting-Module/refs/heads/main/universalmodule.luau"))()
        end)
        if success then
            WindUI:Notify({Title = "ShydeDev Loaded", Content = "المكتبة جاهزة للاستخدام.", Duration = 3})
        else
            WindUI:Notify({Title = "Error", Content = tostring(err), Duration = 5})
        end
    end
})

-- 2. أداة SimpleSpy (للتجسس على الأحداث)
HookTab:Button({
    Title = "2. تفعيل SimpleSpy (Spy Tool)",
    Callback = function()
        local success = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/exxtremestuffs/SimpleSpySource/master/SimpleSpy.lua"))()
        end)
        if success then
            WindUI:Notify({Title = "SimpleSpy Loaded", Content = "أداة التجسس جاهزة.", Duration = 3})
        end
    end
})

-- 3. أداة Cobalt (للتجسس المتقدم على الحزم المشفرة)
HookTab:Button({
    Title = "3. تفعيل Cobalt (Advanced Spy)",
    Callback = function()
        local success = pcall(function()
            loadstring(game:HttpGet("https://gitlab.com/upio/cobalt/-/releases/permalink/latest/downloads/Cobalt.luau"))()
        end)
        if success then
            WindUI:Notify({Title = "Cobalt Loaded", Content = "أداة التجسس المتقدمة جاهزة.", Duration = 3})
        end
    end
})

-- 4. أداة مخصصة لاعتراض دالة الشراء (من الكود الذي جربناه)
HookTab:Button({
    Title = "4. اعتراض الشراء (Hijack Purchase)",
    Callback = function()
        local RS = game:GetService("ReplicatedStorage")
        local Event = RS:FindFirstChild("Remotes") and RS.Remotes:FindFirstChild("SetPurchaseMetadata")
        
        if Event then
            local oldInvoke = Event.InvokeServer
            Event.InvokeServer = function(self, ...)
                local args = {...}
                -- تغيير السعر إلى 0
                if type(args[2]) == "string" then
                    args[2] = string.gsub(args[2], '"t":%d+', '"t":0')
                    print("[Hook] تم تغيير السعر إلى 0!")
                end
                return oldInvoke(self, unpack(args))
            end
            WindUI:Notify({Title = "Purchase Hacked", Content = "الاعتراض يعمل الآن!", Duration = 3})
        else
            WindUI:Notify({Title = "Error", Content = "الحدث غير موجود.", Duration = 3})
        end
    end
})

print("✅ Arsenal Loaded! Choose your weapon.")
