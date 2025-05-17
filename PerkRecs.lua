-- PerkRecs.lua
-- This file will contain recommended perks or bonuses for new players, or for different classes/situations.
-- Define your recommendations as a Lua table below. Expand as needed for your tutorial or perks system.

PerkRecs = {
    -- Template for class perk recommendations:
    -- ["CLASS"] = {
    --     Spec = "SpecName",
    --     OffensePerks = {"perk1", "perk2", "perk3", "perk4", "perk5"},
    --     DefensePerks = {"perk1", "perk2", "perk3", "perk4", "perk5"},
    --     SupportPerks = {"perk1", "perk2", "perk3", "perk4", "perk5"},
    --     UtilityPerks = {"perk1", "perk2", "perk3", "perk4", "perk5"},
    --     ClassPerks = {"perk1", "perk2", "perk3", "perk4", "perk5"},
    -- },
    ["WARRIOR"] = {
        Spec = "Arms",
        OffensePerks = {"Mortal Strike", "Overpower", "Bladestorm", "Sweeping Strikes", "Execute"},
        DefensePerks = {"Defensive Stance", "Shield Wall", "Last Stand", "Shield Block", "Disarm"},
        SupportPerks = {"Battle Shout", "Commanding Shout", "Intervene", "Vigilance", "Shattering Throw"},
        UtilityPerks = {"Charge", "Intercept", "Berserker Rage", "Hamstring", "Intimidating Shout"},
        ClassPerks = {"Dual Wield", "Plate Specialization", "Weapon Mastery", "Enrage", "Blood Craze"},
    },
}

-- Add your perk recommendations below as needed.
