# main file
_ = require "lodash"
# Should we require jquery here?

nunjucks = require "nunjucks"
env = nunjucks.configure "scripts/template"

###item =
    #verified: true
    #w: 2
    #h: 3
    #support: true ???
    #league: "Standard"
    #sockets: Array #TODO
    #socketedItems: [] #TODO
    #icon: "http://bla.bla" #TODO

    name: "Bino's Kitchen Knife"
    typeLine: "Slaughter Knife" # Move typeLine up when there is no name. normal/magic/gems/etc uses typeLine as header
    frameType: 3 # index of rarity

    corrupted: true
    identified: true
    mirrored: true

    properties: [{
        name: "Dagger"
        values: []
        displayMode: 0
    }, { # Stats such as change to block and armour
        name: "Quality" # Put quality somewhere else?
        values: [
            ["+20%", 1] # Use only integer? | Does 1 mean augmented?
        ]
        displayMode: 0 # What is this?
    }, {
        name: "Physical Damage"
        values: [
            ["80-245", 1] # Use only integer?
        ]
        displayMode: 0
    }, {
        name: "Critical Strike Chance"
        values: [
            ["9.52%", 1] # Use an integer instead of string
        ]
        displayMode: 0
    }, {
        name: "Attacks per Second"
        values: [
            ["1.40", 0]
        ]
        displayMode: 0
    }]

    # { ^ Weapons have this prop to show the type
    #     name: "Dagger"
    #     values: []
    #     displayMode: 0
    # }


    requirements: [{
        name: "Level"
        values: [
            ["65", 0]
        ]
        displayMode: 0
    }, {
        name: "Dex"
        values: [
            ["81", 0]
        ]
        displayMode: 1 # ???
    }, {
        name: "Int"
        values: [
            ["117", 0]
        ]
        displayMode: 1 # ???
    }]

    implicitMods: [
        "40% increased Global Critical Strike Chance"
    ]

    explicitMods: [
        "30% increased Damage over Time"
        "Adds 58-126 Physical Damage"
        "46% increased Critical Strike Chance"
        "11% increased Global Critical Strike Multiplier"
        "+12% to Chaos Resistance"
        "On killing a Poisoned enemy, nearby enemies are Poisoned"
        "On killing a Poisoned enemy, nearby allies Regenerate Life"
    ]

    flavourText: [
        "Calling it poison would imply",
        "that it was even edible."
    ]

    cosmeticMods: [
        "Has Divine Weapon Effect"
        "Has Extra Gore"
        "Has Heartbreaker Skin"
    ]###

item =
    #verified: true
    #w: 2
    #h: 3
    #support: true ???
    #league: "Standard"
    #sockets: Array #TODO
    #socketedItems: [] #TODO
    #icon: "http://bla.bla" #TODO

    name: "Gale Gnarl"
    typeLine: "Imbued Wand" # Move typeLine up when there is no name. normal/magic/gems/etc uses typeLine as header
    frameType: 2 # index of rarity

    corrupted: true
    identified: true
    mirrored: true

    properties: [{
        name: "Wand"
        values: []
        displayMode: 0
    }, { # Stats such as change to block and armour
        name: "Quality" # Put quality somewhere else?
        values: [
            ["+20%", 1] # Use only integer? | Does 1 mean augmented?
        ]
        displayMode: 0 # What is this?
    }, {
        name: "Physical Damage"
        values: [
            ["154-279", 1] # Use only integer?
        ]
        displayMode: 0
    }, {
        name: "Critical Strike Chance"
        values: [
            ["11.04%", 1] # Use an integer instead of string
        ]
        displayMode: 0
    }, {
        name: "Attacks per Second"
        values: [
            ["1.69", 1]
        ]
        displayMode: 0
    }]

    requirements: [{
        name: "Level"
        values: [
            ["59", 0]
        ]
        displayMode: 0
    }, {
        name: "Int"
        values: [
            ["188", 0]
        ]
        displayMode: 1 # ???
    }]

    implicitMods: [
        #"20% increased Spell Damage"
        "Culling Strike"
    ]

    explicitMods: [
        "249% increased Physical Damage"
        "Adds 25-45 Physical Damage"
        "13% increased Attack Speed"
        "38% increased Critical Strike Chance"
        "38% increased Global Critical Strike Multiplier"
        "+135 to Accuracy Rating"
    ]

    ###flavourText: [
        "Calling it poison would imply",
        "that it was even edible."
    ]###

    cosmeticMods: [
        "Has Divine Weapon Effect"
        "Has Extra Gore"
        "Has Lifesprig Skin"
    ]


# Clean up
if item.corrupted and item.explicitMods?.length
    item.explicitMods.push "<span class=\"corrupted\">Corrupted</span>"

if not item.identified and item.explicitMods?.length
    item.explicitMods.push "<span class=\"unindentified\">Unindentified</span>"

stuff = { # rename
    frameTypes: [
        "normal"
        "magic"
        "rare"
        "unique"
        "gem"
        "currency"
        "quest"
    ]

    displayModes: [ # ???
        "nameValue"
        "valueName"
        "progess" # used for gem experience bar?
        "inject"
    ]

    valueStyles: [
        "value-default" # "default" site js uses default but color is wrong in named_colours
        "augmented"
        "unmet"
        "physical-damage"
        "fire-damage"
        "cold-damage"
        "lightning-damage"
        "chaos-damage"
        "magic-item"
        "rare-item"
        "unique-item"
    ]
}

env.addFilter "displayProperty", (prop, delimiter, brTag) ->
    console.log prop

    ret = ""

    if prop.values.length
        value = prop.values[0] # only seen props with 1 value so far

        val = value[0]
        valueStyle = value[1]

        innerSpan = "<span class=\"color-" + stuff.valueStyles[valueStyle] + "\">" + val + "</span>"
        outerSpan = "<span>" + prop.name + delimiter + innerSpan + "</span>"

        ret += outerSpan

        if brTag
            ret += "<br>"
    else
        ret += "<span>" + prop.name + "</span><br>"

    return ret

env.render "item.html", _.merge(item, stuff), (err, res) ->
    throw err if err

    console.log res
    $(".item-placeholder").append res
