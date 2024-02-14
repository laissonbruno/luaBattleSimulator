--[[
    | Prismarine Colossus
    | 
    | Huge prismarine statues that measure over 20 meters in height. Their threatening appearance can scare even the bravest warriors.
    | They have bright turquoise eyes, but a compliment won't help you much during a battle.
    | 
    | Attributes
    | Life      ▰▰▰▰▰▰▰▰▰▰
    | Attack    ▰▰▰▰▱▱▱▱▱▱
    | Defense   ▰▰▰▰▰▰▰▰▰▰
    | Agility   ▰▱▱▱▱▱▱▱▱▱

    What are you going to do?
    1. Attack with the sword.
    2. Use regeneration potion.
    3. Throw a stone.
    4. Hide.
    > 2
]]

-- Dependencies
local utils = require("utils")
local player = require("player.player")
local playerActions = require("player.actions")
local colossus = require("colossus.colossus")
local colossusActions = require("colossus.actions")

-- Enable UTF-8 in the terminal
utils.enableUtf8()

-- Header
utils.printHeader()

-- Get monster definition
local boss = colossus
local bossActions = colossusActions

-- Introduce the monster
utils.printCreature(boss)

-- Build actions
playerActions.build()
bossActions.build()

-- Start the battle loop
while true do

    -- Show actions to the player
    print()
    print(string.format("What will be %s next action?", player.name))
    local validPlayerActions = playerActions.getValidActions(player, boss)
    for i, action in pairs(validPlayerActions) do
        print(string.format("%d. %s", i, action.description))
    end
    local chosenIndex = utils.ask()
    local chosenAction = validPlayerActions[chosenIndex]
    local isActionValid = chosenAction ~= nil

    -- Simulate player turn
    if isActionValid then
        chosenAction.execute(player, boss)
    else
        print(string.format("Your choice is invalid. %s missed his turn.", player.name))
    end

    -- Exit point: Creature became lifeless
    if boss.health <= 0 then
        break
    end

    -- Simulate creature's turn
    print()
    local validBossActions = bossActions.getValidActions(player, boss)
    local bossAction = validBossActions[math.random(#validBossActions)]
    bossAction.execute(player, boss)

    -- Exit point: Player ran out of lives
    if player.health <= 0 then
        break
    end
end

-- Process win and lose conditions
if player.health <= 0 then
    print()
    print("---------------------------------------------------------------------")
    print()
    print("😭")
    print(string.format("%s was unable to beat %s.", player.name, boss.name))
    print("Who knows next time...")
    print()
elseif boss.health <= 0 then
    print()
    print("---------------------------------------------------------------------")
    print()
    print("🥳")
    print(string.format("%s prevailed and beat %s.", player.name, boss.name))
    print("Congratulations!!!")
    print()
end
