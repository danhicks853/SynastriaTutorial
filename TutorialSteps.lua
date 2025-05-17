TutorialSteps = {
    {
        StepLabel = "WELCOME",
        StepText = "Welcome to Synastria! Thanks for taking the time to download this addon.",
        Action1 = nil,
        Action2 = nil,
        Action3 = nil,
        FrameAnchor = "CENTER",
        NextStepLabel = "SERVER_PREMISE",
        NextStepTrigger = "NEXT_BUTTON"
    },
    {
        StepLabel = "SERVER_PREMISE",
        StepText = "Synastria is a unique server with several custom features. Basically, it all boils down to: Play how you want, and you will always progress. We will go through an overview of all of these features throughout the tutorial.",
        Action1 = nil,
        Action2 = nil,
        Action3 = nil,
        FrameAnchor = "LAST",
        NextStepLabel = "NOTES",
        NextStepTrigger = "NEXT_BUTTON"
    },
    {
        StepLabel = "NOTES",
        StepText = "A quick note: This tutorial is designed to help you create your first level 80 character. \
There are several benefits to creating a level 80 character first, even if you plan on leveling from level 1:\
 1.) You will get a basic overview of all the systems and how they work together to create a unique and engaging experience. \
 2.) Your account will earn Riding skill, learn all professions, and get a few mounts and bags. ",
        Action1 = nil,
        Action2 = nil,
        Action3 = nil,
        FrameAnchor = "LAST",
        NextStepLabel = "INNKEEPER_INTRO",
        NextStepTrigger = "NEXT_BUTTON"
    },
    {
        StepLabel = "INNKEEPER_INTRO",
        StepText = "Let's get started! Near you is an NPC that looks like a storm elemental. He should have a big red arrow over his head. Speak with him.",
        Action1 = nil,
        Action2 = nil,
        Action3 = nil,
        FrameAnchor = "LAST",
        NextStepLabel = "CHOOSE_LEVEL",
        NextStepTrigger = "GOSSIP_SHOW"
    },
    {
        StepLabel = "CHOOSE_LEVEL",
        StepText = "The first thing you want to do is select I would like to skip leveling! Then, select Level 80. Remember, you can always create a new character to level up later!",
        Action1 = {"HighlightGossipOptionByText", "I would like to skip leveling"},
        Action2 = nil,
        Action3 = nil,
        FrameAnchor = "GossipFrame:RIGHT",
        NextStepLabel = "GET_GEAR",
        NextStepTrigger = "PLAYER_LEVEL_UP"
    },
    {
        StepLabel = "GET_GEAR",
        StepText = "Next, you'll need some gear! Go ahead and talk to the innkeeper again, and select 'Can I have some starting equipment?' Select the gear set you'd like if you're offered options, (we usually recommend damage if available), and then we'll continue!",
        Action1 = {"HighlightGossipOptionByText", "Can I have some starting equipment?"},
        Action2 = nil,
        Action3 = nil,
        FrameAnchor = "LAST",
        NextStepLabel = "GO_TO_DALARAN",
        NextStepTrigger = "BAG_UPDATE"
    },
    {
        StepLabel = "GO_TO_DALARAN",
        StepText = "Sweet Loot! After you put some clothes on, you'll probably want to move on over to the Capital City, Dalaran! This is a good hub where you'll most likely run into other players. It has portals to the other major capitals, so it will be easy to get around. Speak with the innkeeper again and select 'Teleport me to Dalaran'",
        Action1 = {"HighlightGossipOptionByText", "Teleport me to Dalaran"},
        Action2 = nil,
        Action3 = nil,
        FrameAnchor = "LAST",
        NextStepLabel = "SET_HEARTHSTONE",
        NextStepTrigger = "ZONE_CHANGED_NEW_AREA"
    },
    {
        StepLabel = "SET_HEARTHSTONE",
        StepText = "Welcome to Dalaran! There's a lot here, but don't get overwhelmed. Our first step is to set our hearthstone. There's nothing more frustrating than forgetting to do that and ending up in the middle of nowhere!",
        Action1 = {"MarkNPC", "Amisi Azuregaze"},
        Action2 = nil,
        Action3 = nil,
        FrameAnchor = "CENTER",
        NextStepLabel = "FIND_AMISI",
        NextStepTrigger = "NEXT_BUTTON"
    },
    {
        StepLabel = "FIND_AMISI",
        StepText = "I've marked the location of the most popular innkeeper in town on your map. (Open your Map by pressing 'M' on your keyboard) and your minimap in the top right corner. Speak with Amisi, tell her to set your hearthstone location, and then we'll continue.",
        Action1 = {"HighlightGossipOptionByText", "Make this inn your home."},
        Action2 = nil,
        Action3 = nil,
        FrameAnchor = "CENTER",
        NextStepLabel = "START_PERK_TUTORIAL",
        NextStepTrigger = "HEARTHSTONE_SET"
    },
    {
        StepLabel = "START_PERK_TUTORIAL",
        StepText = "Great! While you're speaking with the Innkeeper, select the Manage Perks option.",
        Action1 = {"HighlightGossipOptionByText", "Manage perks"},
        Action2 = nil,
        Action3 = nil,
        FrameAnchor = "LAST",
        NextStepLabel = "PERKS_OPEN",
        NextStepTrigger = "PERK_FRAME_OPENED"
    },
    {
        StepLabel = "PERKS_OPEN",
        StepText = "Perks are special bonuses you can pick to make your character stronger or give them new abilities. You can choose perks at an innkeeper by opening the Perks window in your Spellbook.",
        Action1 = nil,
        Action2 = nil,
        Action3 = nil,
        FrameAnchor = "PerkMgrFrame:RIGHT",
        NextStepLabel = "PERKS_OPEN_2",
        NextStepTrigger = "NEXT_BUTTON"
    },
    {
        StepLabel = "PERKS_OPEN_2",
        StepText = "You can have up to 5 perks from each group (Offensive, Defensive, Support, Utility, Class). You can only change perks while talking to an innkeeper.",
        Action1 = nil,
        Action2 = nil,
        Action3 = nil,
        FrameAnchor = "PerkMgrFrame:RIGHT",
        NextStepLabel = "PERKS_OPEN_3",
        NextStepTrigger = "NEXT_BUTTON"
    },
    {
        StepLabel = "PERKS_OPEN_3",
        StepText = "To unlock a perk, do the task shown under 'How to unlock?'. To make a perk stronger, do the challenge under 'How to upgrade?'. Perks can go up to rank 10.",
        Action1 = nil,
        Action2 = nil,
        Action3 = nil,
        FrameAnchor = "PerkMgrFrame:RIGHT",
        NextStepLabel = "PERKS_OPEN_4",
        NextStepTrigger = "NEXT_BUTTON"
    },
    {
        StepLabel = "PERKS_OPEN_4",
        StepText = "Perk ranks are shared on your account, but class perks must be upgraded on that class. Most perks help your pets and guardians too.",
        Action1 = nil,
        Action2 = nil,
        Action3 = nil,
        FrameAnchor = "PerkMgrFrame:RIGHT",
        NextStepLabel = "PERKS_OPEN_5",
        NextStepTrigger = "NEXT_BUTTON"
    },
    {
        StepLabel = "PERKS_OPEN_5",
        StepText = "You get a new perk point every 20 levels, up to 5 per group. Some perks work together for even bigger bonuses. Shift+Click a perk to see its max power. In the next step, we’ll suggest perks that are popular for your class!",
        Action1 = nil,
        Action2 = nil,
        Action3 = nil,
        FrameAnchor = "PerkMgrFrame:RIGHT",
        NextStepLabel = "CLASS_PERK_DESC",
        NextStepTrigger = "NEXT_BUTTON"
    },
    {
        StepLabel = "CLASS_PERK_DESC",
        StepText = "basic perk description",
        Action1 = {"ShowClassPerks"},
        Action2 = nil,
        Action3 = nil,
        FrameAnchor = "PerkMgrFrame:RIGHT",
        NextStepLabel = "NEXT_BUTTON",
        NextStepTrigger = "NEXT_BUTTON"
    },
}