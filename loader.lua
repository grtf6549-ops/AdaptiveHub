-- ==========================================
-- Amin Hub | Data Manipulator (Based on Spy)
-- ==========================================

local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
local RS = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Window = WindUI:CreateWindow({
    Title = "Amin Hub | God Mode",
    SubTitle = "Data Injection Ready",
    Theme = "Dark"
})

local HackTab = Window:Tab({ Title = "God Mode", Icon = "shield" })

-- 1. زر إعطاء الذهب اللانهائي (بناءً على الكود الثالث)
HackTab:Button({
    Title = "Give Infinite Gold & Levels (إعطاء ذهب ومستويات)",
    Callback = function()
        local Event = RS:FindFirstChild("Remotes") and RS.Remotes:FindFirstChild("Send")
        if not Event then
            WindUI:Notify({Title = "Error", Content = "لم يتم العثور على الحدث Remotes.Send", Duration = 3})
            return
        end

        -- البيانات المعدلة (قمت بتغيير الأرقام لقيم ضخمة)
        local HackedData = {
            ["Bouncy Bird"] = {
                difficulty = 999,
                high_score = { 999999, 999999, 999999 }
            },
            ["Stacking Blocks"] = {
                highscore = 999999
            },
            ["Pocket Cookies"] = {
                Factory_level = 999,
                SpaceStation_level = 999,
                multiplier = 999,
                cookies = 999999999, -- كوكيز لا نهائية
                Clicker_level = 999,
                Bakery_level = 999,
                CookiePlanet_level = 999,
                Grandma_level = 999,
                rate = 999999
            },
            ["Balloon Game"] = {
                PopBalloon_level = 999,
                upgrades = {
                    Rate = 999,
                    Auto = 999
                },
                HotBalloon_level = 999,
                Hot2Balloon_level = 999,
                DogBalloon_level = 999,
                ManyBalloon_level = 999,
                ["Balloon Factory_level"] = 999,
                ["Auto Popper_level"] = 999,
                WeirdBalloon_level = 999,
                ["Bigger Balloons_level"] = 999,
                ["Quality Balloons_level"] = 999,
                cosmetics = {
                    Balloon = 1
                },
                ["Heavier Balloons_level"] = 999,
                StareBalloon_level = 999,
                pops = 999999,
                HeartBalloon_level = 999,
                multiplier = 999,
                ["Balloon Rate_level"] = 999,
                ZepellinBalloon_level = 999
            },
            ["Monster Slayer"] = {
                Fireball_level = 999,
                ["Poison Gas_level"] = 999,
                multiplier = 999,
                ["Level Up_level"] = 999,
                ["Auto Attack_level"] = 999,
                kill_count = 999999,
                Execution_level = 999,
                Damage_level = 999,
                gold = 999999999, -- الذهب هنا!
                ["Lightning Storm_level"] = 999,
                level = 999,
                current_monster = "Slime King",
                damage = 999999
            }
        }

        -- إرسال البيانات المخترقة للسيرفر
        local success, err = pcall(function()
            Event:FireServer(24, "games_save", HackedData)
        end)

        if success then
            WindUI:Notify({
                Title = "Injection Successful!",
                Content = "تم إرسال البيانات المخترقة. اذهب وتفقد ألعابك!",
                Duration = 5
            })
        else
            WindUI:Notify({
                Title = "Injection Failed",
                Content = "السيرفر رفض البيانات.",
                Duration = 5
            })
        end
    end
})

-- 2. زر تفعيل الهاتف (الكود الثاني)
HackTab:Button({
    Title = "Force Holding Phone (إجبار حمل الهاتف)",
    Callback = function()
        local Event = RS:FindFirstChild("Remotes") and RS.Remotes:FindFirstChild("Send")
        if Event then
            Event:FireServer(13, "holding_phone", true)
            WindUI:Notify({Title = "Success", Content = "تم تفعيل حمل الهاتف.", Duration = 3})
        end
    end
})

print("✅ God Mode Loaded!")
