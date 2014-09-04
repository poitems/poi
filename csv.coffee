fs    = require "fs"
csv   = require "csv"
csvToJson = require "csvtojson"

fs.readFile "data/Mods.csv", { encoding: "utf-8" }, (err, data) ->
    throw err if err

    csv.parse data, (err, output) ->
        console.log output[1]
