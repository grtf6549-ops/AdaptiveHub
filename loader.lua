-- ==========================================
-- Amin Hub | Global Multi-Game Engine
-- ==========================================

local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
local RS = game:GetService("ReplicatedStorage")
local PlaceId = game.PlaceId

local Window = WindUI:CreateWindow({
    Title = "Amin Hub | Global",
    SubTitle = "Engine Ready",
    Theme = "Dark"
})

-- 1. قاعدة البيانات العالمية (Global Database)
-- هنا نضع الأحداث (Remotes) التي نعرفها مسبقاً لكل لعبة
local GlobalDatabase = {
    -- لعبة 99 ليلة في الغابة
    [920587237] = {
        {Name = "Skip Night", Path = {"RemoteEvents", "RequestActivateNightSkipMachine"}, Args = {}},
        {Name = "Kill All Monsters", Path = {"RemoteEvents", "RequestDissolveEnemy"}, Args = {"All"}},
        {Name = "Give Wood", Path = {"RemoteEvents", "RequestAddWood"}, Args = {99999}},
    },
    
    -- لعبة Blox Fruits (كمثال)
    [2753915549] = {
        {Name = "Auto Farm Level", Path = {"Remotes", "CommF_"}, Args = {"AutoFarm"}},
        {Name = "Kill Aura", Path = {"Remotes", "Combat"}, Args = {"KillAura"}},
    },
    
    -- يمكنك إضافة المزيد من الألعاب هنا...
}

-- 2. دالة التنفيذ الذكية
local function ExecuteSmartFeature(feature)
    -- نحاول الوصول للحدث عبر المسار المخزن في قاعدة البيانات
    local currentObj = RS
    local success = true
    
    for _, step in ipairs(feature.Path) do
        currentObj = currentObj:FindFirstChild(step)
        if not currentObj then
            success = false
            break
        end
    end
    
    -- إذا وجدنا الحدث، نقوم بتشغيله
    if success and currentObj then
        pcall(function()
            currentObj:FireServer(unpack(feature.Args))
            WindUI:Notify({Title = "Success", Content = "Executed: " .. feature.Name, Duration = 3})
        end)
    else
        WindUI:Notify({Title = "Error", Content = "Remote not found for this game.", Duration = 3})
    end
end

-- 3. بناء الواجهة بناءً على قاعدة البيانات
local GameTab = Window:Tab({ Title = "Game Features", Icon = "gamepad-2" })

-- التحقق مما إذا كانت اللعبة مدعومة
if GlobalDatabase[PlaceId] then
    -- اللعبة موجودة في قاعدة البيانات! ننشئ الأزرار تلقائياً
    for _, feature in ipairs(GlobalDatabase[PlaceId]) do
        GameTab:Button({
            Title = feature.Name,
            Callback = function()
                ExecuteSmartFeature(feature)
            end
        })
    end
else
    -- اللعبة غير موجودة في القاعدة، نستخدم الماسح الضوئي (Scanner) كخطة بديلة
    GameTab:Paragraph({Title = "Unknown Game", Desc = "Scanning for common remotes..."})
    
    -- الماسح الضوئي التلقائي (لأي لعبة أخرى)
    for _, obj in pairs(RS:GetDescendants()) do
        if obj:IsA("RemoteEvent") and (string.find(string.lower(obj.Name), "skip") or string.find(string.lower(obj.Name), "give")) then
            GameTab:Button({
                Title = obj.Name .. " (Auto)",
                Callback = function()
                    obj:FireServer()
                end
            })
        end
    end
end

print("✅ Amin Hub Global Engine Loaded!")
