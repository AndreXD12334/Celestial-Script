local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

-- Estado para los toggles
local AutoFarmEnabled = false
local ESPEnabled = false

local Window = Rayfield:CreateWindow({
    Name = "🌌 Celestial",
    LoadingTitle = "Celestial On Top 🌠",
    LoadingSubtitle = "sxbxs.19 and andresitoulol",
    ConfigurationSaving = {
        Enabled = false,
        FolderName = nil,
        FileName = "Celestial"
    }
})

-- Tabs
local MainTab = Window:CreateTab("Main Functions✨", nil)
MainTab:CreateSection("Vesteria Game Functions")
local CreditsTab = Window:CreateTab("Credits 👑", nil)

-- AutoFarm Script
local function startAutoFarm()
    local monsterList = {
        ["Aevrul"] = true, ["Baby Scarab"] = true, ["Baby Shroom"] = true, ["Baby Slime"] = true, ["Baby Yeti"] = true,
        ["Baby Yeti Tribute"] = true, ["Bamboo Mage"] = true, ["Bandit"] = true, ["Bandit Skirmisher"] = true,
        ["Battering Shroom"] = true, ["Batty"] = true, ["Bear"] = true, ["Big Slime"] = true, ["Birthday Mage"] = true,
        ["Boar"] = true, ["Book"] = true, ["Bushi"] = true, ["Chad"] = true, ["Chicken"] = true, ["Crabby"] = true,
        ["Crow"] = true, ["Cultist"] = true, ["Dark Cleric"] = true, ["Deathsting"] = true, ["Dragon Boss"] = true,
        ["Dragon Monk"] = true, ["Dummy"] = true, ["Dustwurm"] = true, ["Eldering Shroom"] = true, ["Elder Shroom"] = true,
        ["Enchanted Slime"] = true, ["Enchiridion"] = true, ["Ent Sapling"] = true, ["Ethera"] = true, ["Ethereal Monarch"] = true,
        ["Frightcrow"] = true, ["Fish"] = true, ["First Mate"] = true, ["Fly Trap"] = true, ["Gauntlet Gate"] = true,
        ["Gecko"] = true, ["Goblin"] = true, ["Gorgog Guardian"] = true, ["Guardian"] = true, ["Guardian Dummy"] = true,
        ["Hag"] = true, ["Hermit Crabby"] = true, ["Hitbox"] = true, ["Hog"] = true, ["Horseshoe Crab"] = true,
        ["Humanoid"] = true, ["Jellyfish"] = true, ["Kobra"] = true, ["Lil Shroomie Cage"] = true, ["Lobster"] = true,
        ["Lost Spirit"] = true, ["Mama Hermit Crabby"] = true, ["Master Miyamoto"] = true, ["Mimic Jester"] = true,
        ["Miner Prisoner"] = true, ["Mo Ko Tu Aa"] = true, ["Mogloko"] = true, ["Moglo"] = true, ["Monster"] = true,
        ["Mosquito Parasite"] = true, ["Mummy"] = true, ["Orc"] = true, ["Parasite"] = true, ["Parasite Host"] = true,
        ["Pirate"] = true, ["Pirate Captain"] = true, ["Pirate Summon"] = true, ["Pit Ratty"] = true, ["Possum the Devourer"] = true,
        ["Prisoner"] = true, ["Ram"] = true, ["Ratty"] = true, ["Reanimated Slime"] = true, ["Reaper"] = true,
        ["Redwood Bandit"] = true, ["Redwood Bandit Leader"] = true, ["Rock Slime"] = true, ["Rootbeard"] = true,
        ["Rubee"] = true, ["Runic Titan"] = true, ["Samurai"] = true, ["Scarab"] = true, ["Scarecrow"] = true,
        ["Sensei"] = true, ["Shade"] = true, ["Shaman"] = true, ["Shinobi"] = true, ["Shroom"] = true,
        ["Skeleton"] = true, ["Skull Boss"] = true, ["Slime"] = true, ["Snel"] = true, ["Soulcage"] = true,
        ["Spider"] = true, ["Spider Queen"] = true, ["Spiderling"] = true, ["Stingtail"] = true, ["Sunken Savage"] = true,
        ["Terror of the Deep"] = true, ["The Yeti"] = true, ["Toni"] = true, ["Tortoise"] = true, ["Treemuk"] = true,
        ["Tribute Gate"] = true, ["Trickster Spirit"] = true, ["Tumbleweed"] = true, ["Undead"] = true, ["Wisp"] = true
    }

    local folder = workspace.placeFolders.entityManifestCollection
    local newSize = Vector3.new(1000, 1000, 1000)

    local function shouldModify(part)
        return monsterList[part.Name] ~= nil
    end

    local function processParts()
        for _, part in pairs(folder:GetDescendants()) do
            if part:IsA("BasePart") and shouldModify(part) then
                part.Size = newSize
                part.CanCollide = false
            end
        end
    end

    processParts()

    folder.DescendantAdded:Connect(function(descendant)
        if AutoFarmEnabled and descendant:IsA("BasePart") and shouldModify(descendant) then
            descendant.Size = newSize
            descendant.CanCollide = false
        end
    end)
end

-- ESP Script
local function startESP()
    local nombresValidos = {
        -- (mismos nombres válidos que el AutoFarm, ya están arriba)
        ["Dummy"] = true, ["Goblin"] = true, ["Shroom"] = true, ["Crabby"] = true, ["Batty"] = true,
        -- y todos los demás ya incluidos arriba...
    }

    local folder = workspace:WaitForChild("placeFolders"):WaitForChild("entityManifestCollection")

    local function crearNombreLabel(part)
        if not ESPEnabled then return end
        if not part:IsA("BasePart") then return end
        if not nombresValidos[part.Name] then return end
        if part:FindFirstChild("ESP_NameTag") then return end

        local billboard = Instance.new("BillboardGui")
        billboard.Name = "ESP_NameTag"
        billboard.Size = UDim2.new(0, 200, 0, 50)
        billboard.StudsOffset = Vector3.new(0, 3, 0)
        billboard.AlwaysOnTop = true
        billboard.Parent = part

        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.Text = part.Name
        label.TextColor3 = Color3.fromRGB(255, 0, 0)
        label.TextStrokeTransparency = 0.3
        label.TextScaled = true
        label.Font = Enum.Font.GothamBold
        label.Parent = billboard
    end

    for _, obj in ipairs(folder:GetDescendants()) do
        crearNombreLabel(obj)
    end

    folder.DescendantAdded:Connect(crearNombreLabel)
end

-- 🔘 Toggles
MainTab:CreateToggle({
    Name = "Auto Farm Mobs",
    CurrentValue = false,
    Flag = "AutoFarmToggle",
    Callback = function(Value)
        AutoFarmEnabled = Value
        if AutoFarmEnabled then
            startAutoFarm()
        end
    end,
})

MainTab:CreateToggle({
    Name = "ESP Mobs",
    CurrentValue = false,
    Flag = "EspMobsToggle",
    Callback = function(Value)
        ESPEnabled = Value
        if ESPEnabled then
            startESP()
        end
    end,
})

-- 📌 Créditos
CreditsTab:CreateParagraph({
    Title = "🎩 Script Info",
    Content = "This script was made by these two legends: sxbxs.19 & andresitoulol. Join the Discord to meet us!"
})

CreditsTab:CreateButton({
    Name = "Unirse al Discord",
    Callback = function()
        pcall(function()
            setclipboard("https://discord.gg/c3jdEgr7b6")
            Rayfield:Notify({
                Title = "Enlace copiado",
                Content = "¡Pega esto en tu navegador para unirte!",
                Duration = 5
            })
        end)
    end,
})
