-- ==========================================
-- Amin Hub | The 4-in-1 God Mode Exploit
-- ==========================================

local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RS = game:GetService("ReplicatedStorage")

local Window = WindUI:CreateWindow({ Title = "Amin Hub | 4-in-1 Exploit", Theme = "Dark" })
local Tab = Window:Tab({ Title = "God Mode", Icon = "shield" })

-- ==========================================
-- 1. الاعتراض على مستوى الشبكة (Network Interception)
-- ==========================================
Tab:Button({
    Title = "1. تفعيل المراقبة العميقة (Network Hook)",
    Callback = function()
        local oldIndex
        oldIndex = hookmetamethod(game, "__index", function(self, key)
            if self == RS and key == "Remotes" then
                print("[Network] تم اعتراض الوصول إلى Remotes!")
            end
            return oldIndex(self, key)
        end)
        WindUI:Notify({Title = "Network Hook", Content = "تم تفعيل المراقبة العميقة.", Duration = 3})
    end
})

-- ==========================================
-- 2. التلاعب بالذاكرة (Memory Manipulation)
-- ==========================================
Tab:Button({
    Title = "2. تفعيل التلاعب بالذاكرة (Memory Hack)",
    Callback = function()
        local success = pcall(function()
            -- محاولة تغيير قيم اللاعب مباشرة في الذاكرة
            for _, stat in pairs(LocalPlayer:GetDescendants()) do
                if stat:IsA("IntValue") or stat:IsA("NumberValue") then
                    if string.find(string.lower(stat.Name), "money") or string.find(string.lower(stat.Name), "cash") then
                        stat.Value = 999999
                        print("[Memory] تم تعديل قيمة: " .. stat.Name)
                    end
                end
            end
        end)
        
        if success then
            WindUI:Notify({Title = "Memory Hack", Content = "تم تعديل القيم في الذاكرة.", Duration = 3})
        else
            WindUI:Notify({Title = "Memory Hack", Content = "السيرفر يمنع التعديل المباشر.", Duration = 3})
        end
    end
})

-- ==========================================
-- 3. اعتراض الوظائف (Function Hooking)
-- ==========================================
Tab:Button({
    Title = "3. تفعيل اعتراض الشراء (Purchase Hook)",
    Callback = function()
        local Event = RS:FindFirstChild("Remotes") and RS.Remotes:FindFirstChild("SetPurchaseMetadata")
        if Event then
            local oldInvoke = Event.InvokeServer
            Event.InvokeServer = function(self, ...)
                local args = {...}
                if type(args[2]) == "string" then
                    -- تغيير السعر إلى 0
                    args[2] = string.gsub(args[2], '"t":%d+', '"t":0')
                    print("[Hook] تم تعديل طلب الشراء إلى 0!")
                end
                return oldInvoke(self, unpack(args))
            end
            WindUI:Notify({Title = "Purchase Hook", Content = "تم اعتراض دالة الشراء بنجاح!", Duration = 3})
        else
            WindUI:Notify({Title = "Error", Content = "لم يتم العثور على حدث الشراء.", Duration = 3})
        end
    end
})

-- ==========================================
-- 4. خداع الواجهة (UI Spoofing) - الزر الوهمي
-- ==========================================
Tab:Button({
    Title = "4. إنشاء زر وهمي (Fake Button)",
    Callback = function()
        local screenGui = Instance.new("ScreenGui")
        screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
        
        local fakeBtn = Instance.new("TextButton")
        fakeBtn.Parent = screenGui
        fakeBtn.Size = UDim2.new(0, 150, 0, 50)
        fakeBtn.Position = UDim2.new(0.5, -75, 0.8, 0)
        fakeBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        fakeBtn.Text = "شراء مجاني!"
        fakeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        
        fakeBtn.MouseButton1Click:Connect(function()
            -- محاولة تنفيذ الشراء المجاني
            local Event = RS:FindFirstChild("Remotes") and RS.Remotes:FindFirstChild("SetPurchaseMetadata")
            if Event then
                Event:InvokeServer(LocalPlayer.UserId, '{"fId":0,"type":"weeklyShop","item":"SGX Outfit","t":0}')
            end
        end)
        
        WindUI:Notify({Title = "Fake Button", Content = "تم إنشاء الزر الوهمي!", Duration = 3})
    end
})

print("✅ 4-in-1 Exploit Loaded!")
