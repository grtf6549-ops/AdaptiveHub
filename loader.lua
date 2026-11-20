-- ==========================================
-- Amin Hub | Spy & Discovery Engine
-- ==========================================

local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
local RS = game:GetService("ReplicatedStorage")

local Window = WindUI:CreateWindow({
    Title = "Amin Hub | Ultimate Spy",
    SubTitle = "Undetectable Remote Scanner",
    Theme = "Dark"
})

-- 1. إنشاء التبويبات
local SpyTab = Window:Tab({ Title = "Spy Tools", Icon = "eye" })
local ScannerTab = Window:Tab({ Title = "Scanner", Icon = "search" })

-- 2. إضافة زر لفتح أداة التجسس (SimpleSpy)
SpyTab:Button({
    Title = "فتح أداة التجسس (Open Remote Spy)",
    Callback = function()
        -- تحميل أداة SimpleSpy الشهيرة
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/78n/SimpleSpy/main/SimpleSpy.lua"))()
        end)
        
        if success then
            WindUI:Notify({
                Title = "Spy Activated",
                Content = "افتح الأداة من الزر الجديد على الشاشة",
                Duration = 5
            })
        else
            WindUI:Notify({
                Title = "Error",
                Content = "فشل تحميل أداة التجسس",
                Duration = 5
            })
        end
    end
})

-- 3. إضافة زر لمسح الأحداث (مثل الكود السابق)
ScannerTab:Button({
    Title = "مسح الأحداث (Scan Remotes)",
    Callback = function()
        local count = 0
        for _, obj in pairs(RS:GetDescendants()) do
            if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
                count = count + 1
                -- إنشاء سويتش لكل حدث
                ScannerTab:Toggle({
                    Title = obj.Name,
                    Default = false,
                    Callback = function(state)
                        if state then
                            task.spawn(function()
                                while state do
                                    pcall(function() obj:FireServer() end)
                                    task.wait(0.5)
                                end
                            end)
                        end
                    end
                })
            end
        end
        WindUI:Notify({Title = "Done", Content = "تم العثور على " .. count .. " حدث", Duration = 5})
    end
})

print("✅ Amin Hub Spy Ready!")
