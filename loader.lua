-- ==========================================
-- Amin Hub | Smart Categorization Engine
-- ==========================================

local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
local RS = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

local Window = WindUI:CreateWindow({
    Title = "Amin Hub | Ultimate",
    SubTitle = "Smart Categorization",
    Theme = "Dark",
    Size = UDim2.fromOffset(550, 500)
})

-- 1. إنشاء التبويبات بناءً على التصنيفات
local Tabs = {
    Money = Window:Tab({ Title = "Money / Gems", Icon = "dollar-sign" }),
    Combat = Window:Tab({ Title = "Combat / Kill", Icon = "sword" }),
    Movement = Window:Tab({ Title = "Movement", Icon = "move" }),
    Items = Window:Tab({ Title = "Items / Inventory", Icon = "box" }),
    Others = Window:Tab({ Title = "Others", Icon = "more-horizontal" })
}

-- 2. دالة لتصنيف الحدث بناءً على اسمه
local function CategorizeRemote(name)
    local lowerName = string.lower(name)
    
    if string.find(lowerName, "money") or string.find(lowerName, "gem") or string.find(lowerName, "coin") or string.find(lowerName, "cash") then
        return "Money"
    elseif string.find(lowerName, "kill") or string.find(lowerName, "damage") or string.find(lowerName, "hit") or string.find(lowerName, "attack") then
        return "Combat"
    elseif string.find(lowerName, "speed") or string.find(lowerName, "jump") or string.find(lowerName, "fly") or string.find(lowerName, "teleport") then
        return "Movement"
    elseif string.find(lowerName, "give") or string.find(lowerName, "add") or string.find(lowerName, "buy") or string.find(lowerName, "item") then
        return "Items"
    else
        return "Others"
    end
end

-- 3. دالة إنشاء السويتش لكل حدث
local function CreateSmartToggle(tabName, remoteObj)
    local targetTab = Tabs[tabName]
    local isActive = false
    local connection
    
    -- إنشاء صندوق نصي لكل حدث لتحديد القيمة
    local valueInput = "99999"
    
    targetTab:Input({
        Title = "Value for " .. remoteObj.Name,
        Default = "99999",
        Placeholder = "اكتب الرقم هنا",
        Callback = function(text)
            valueInput = text
        end
    })
    
    -- إنشاء السويتش
    targetTab:Toggle({
        Title = remoteObj.Name,
        Default = false,
        Callback = function(state)
            isActive = state
            if isActive then
                connection = task.spawn(function()
                    while isActive do
                        -- إرسال القيمة (إذا كانت رقماً، نحولها، وإلا نرسلها كنص)
                        local sendValue = tonumber(valueInput) or valueInput
                        pcall(function()
                            remoteObj:FireServer(sendValue)
                        end)
                        task.wait(0.5) -- تأخير لمنع الحماية
                    end
                end)
            else
                if connection then task.cancel(connection) end
            end
        end
    })
end

-- 4. مسح اللعبة بالكامل وتصنيف الأحداث
local foundCount = 0
local searchedObjects = {}

-- البحث في ReplicatedStorage
for _, obj in pairs(RS:GetDescendants()) do
    if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
        local category = CategorizeRemote(obj.Name)
        CreateSmartToggle(category, obj)
        foundCount = foundCount + 1
    end
end

-- البحث في Workspace (للأحداث المخفية)
for _, obj in pairs(Workspace:GetDescendants()) do
    if (obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction")) and not searchedObjects[obj] then
        searchedObjects[obj] = true
        local category = CategorizeRemote(obj.Name)
        CreateSmartToggle(category, obj)
        foundCount = foundCount + 1
    end
end

-- إشعار بنهاية المسح
WindUI:Notify({
    Title = "Scan Complete",
    Content = "Found and categorized " .. foundCount .. " remotes!",
    Duration = 5
})

print("✅ Smart Engine Loaded! Found: " .. foundCount)
