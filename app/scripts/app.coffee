# main file
_ = require "lodash"

ex = require "./example.coffee"
console.log "Hello, #{ex}!"

console.log "lodash version: #{_.VERSION}"


item =
    rarity: "rare" # required. magic, rare, gem, etc

    name:     "Gale Gnarl" # Should gems use name or type?
    baseType: "Imbued Wand"
