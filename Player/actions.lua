local utils = require "utils"

local actions = {}

actions.list = {}

--- Creates a list of actions that are stored internally.
function actions.build()
    -- Reset list
    actions.list = {}

    -- Attack with sword
    local swordAttack = {
        description = "Attack with the sword.",
        requirement = nil,
        execute = function(playerData, creatureData)
            -- 1. Define chance of success
            local successChance = creatureData.speed == 0 and 1 or playerData.speed / creatureData.speed
            local success = math.random() <= successChance

            -- 2. Calculate damage
            local rawDamage = playerData.attack - math.random() * creatureData.defense
            local damage = math.max(1, math.ceil(rawDamage))

            if success then
                -- 3. Apply damage on success
                creatureData.health = creatureData.health - damage
                
                -- 4. Present result as print
                print(string.format("%s attacked the creature and dealt %d damage", playerData.name, damage))
                local healthRate = math.floor((creatureData.health / creatureData.maxHealth) * 10)
                print(string.format("%s: %s", creatureData.name, utils.getProgressBar(healthRate)))

            else
                print(string.format("%s tried to attack, but forgot the sword in his backpack.", playerData.name))
            end
        end
    }

    -- Use regeneration potion
    local regenPotion = {
        description = "Take a regeneration potion.",
        requirement = function(playerData, creatureData)
            return playerData.potions >= 1
        end,
        execute = function(playerData, creatureData)
            -- Take potion from inventory
            playerData.potions = playerData.potions - 1

            -- Recover life
            local regenPoints = 10
            playerData.health = math.min(playerData.maxHealth, playerData.health + regenPoints)
            print(string.format("%s used a potion and recovered some health.", playerData.name))
        end
    }

    -- Populate list
    actions.list[#actions.list + 1] = swordAttack
    actions.list[#actions.list + 1] = regenPotion
end


--- Returns a list of valid actions
---@param playerData table Player definition
---@param creatureData table Definition of the creature
---@return table
function actions.getValidActions(playerData, creatureData)
    local validActions = {}
    for _, action in pairs(actions.list) do
        local requirement = action.requirement
        local isValid = requirement == nil or requirement(playerData, creatureData)
        if isValid then
            validActions[#validActions+1] = action
        end
    end
    return validActions
end


return actions