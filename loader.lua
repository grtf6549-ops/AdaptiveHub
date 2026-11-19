-- ==========================================
-- Amin Hub | Universal Auto-Discovery
-- ==========================================

local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
local RS = game:GetService("ReplicatedStorage")

local Window = WindUI:CreateWindow({
    Title = "Amin Hub | Discovery",
    SubTitle = "Auto Scanning...",
    Theme = "Dark"
})

-- إنشاء تبويب خاص بالاكتشاف التلقائي
local DiscoveryTab = Window:Tab({ Title = "Discovered Features", Icon = "search" })

-- دالة لإنشاء الأزرار لكل حدث
local function GenerateDiscoveryButtons()
    local count = 0
    
    -- البحث في كل مكان داخل ReplicatedStorage
    for _, obj in pairs(RS:GetDescendants()) do
        -- نبحث عن الأحداث (RemoteEvent) فقط
        if obj:IsA("RemoteEvent") then
            count = count + 1
            
            -- إنشاء زر لكل حدث
            DiscoveryTab:Button({
                Title = obj.Name, -- اسم الحدث الحقيقي
                Callback = function()
                    -- عند الضغط، نرسل طلباً فارغاً (قد يعمل أو لا)
                    obj:FireServer()
                    WindUI:Notify({
                        Title = "Action Sent",
                        Content = "Triggered: " .. obj.Name,
                        Duration = 3
                    })
                end
            })
            
            -- إذا وصلنا إلى 50 زراً، نتوقف لتجنب بطء الهاتف
            if count >= 50 then
                break
            end
        end
    end
    
    -- إذا لم نجد أي شيء
    if count == 0 then
        DiscoveryTab:Paragraph({ Title = "No Remotes", Desc = "This game hides its remotes." })
    else
        print("✅ Found " .. count .. " Remote Events!")
    end
end

-- تشغيل المولد
GenerateDiscoveryButtons()

print("✅ Auto-Discovery Engine Loaded!")
