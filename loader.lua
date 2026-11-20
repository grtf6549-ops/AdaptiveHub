-- ==========================================
-- Amin Hub | Advanced Smart Scanner v2
-- ==========================================

local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
local RS = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Window = WindUI:CreateWindow({
    Title = "Amin Hub | Advanced",
    SubTitle = "Manual & Auto Control",
    Theme = "Dark"
})

local ScanTab = Window:Tab({ Title = "Scanner", Icon = "search" })

-- 1. صندوق نصي لإدخال القيمة (الرقم)
local InputValue = "99999"
ScanTab:Input({
    Title = "Value to Send (القيمة المرسلة)",
    Default = InputValue,
    Placeholder = "اكتب رقماً هنا",
    Callback = function(Text)
        InputValue = Text
        print("تم تغيير القيمة إلى: " .. InputValue)
    end
})

ScanTab:Section({ Title = "الطلبات المكتشفة (انقر للتجربة)" })

local function CreateSmartToggle(name, remoteObj)
    local isActive = false
    local connection
    
    ScanTab:Toggle({
        Title = name,
        Default = false,
        Callback = function(state)
            isActive = state
            if isActive then
                -- عند التفعيل، يبدأ السكريبت بإرسال الطلب بشكل مستمر
                connection = task.spawn(function()
                    while isActive do
                        -- إرسال الطلب بالقيمة التي كتبتها في الصندوق
                        remoteObj:FireServer(tonumber(InputValue) or InputValue)
                        task.wait(0.5) -- تأخير نصف ثانية لمنع الطرد
                    end
                end)
            else
                -- عند الإيقاف، يتوقف السكريبت عن الإرسال
                if connection then
                    task.cancel(connection)
                end
            end
        end
    })
end

-- 2. مسح الأحداث
local count = 0
for _, obj in pairs(RS:GetDescendants()) do
    if obj:IsA("RemoteEvent") then
        count = count + 1
        -- ننشئ "سويتش" لكل حدث نجده
        CreateSmartToggle(obj.Name, obj)
        
        if count >= 20 then break end -- نكتفي بـ 20 حدثاً لتجنب البطء
    end
end

print("✅ Advanced Scanner Ready!")
