local function get(what,where,name)
    print("Downloading " .. name)
    local handle = fs.open(where,"w")
    local otherHandle = http.get(what)
    handle.write(otherHandle.readAll())
    handle.close()
    otherHandle.close()
end
if not http then
    error("Please enable HTTP in CC config.")
end
if not http.websocket then
    error("Please enable WebSockets (either by downloading CC:Tweaked and installing it, or enabling it in CC:Tweaked config.")
end
if not fs.exists("sha256.lua") then
    get("https://pastebin.com/raw/qmHNTqad","sha256.lua","SHA256 API")
end
if not fs.exists("json.lua") then
    get("https://raw.githubusercontent.com/rxi/json.lua/master/json.lua","json.lua","JSON API")
end
if not fs.exists("soqet.lua") then
    get("https://raw.githubusercontent.com/Ale32bit/Soqet/master/soqet.lua","soqet.lua","Soqet")
end
if not fs.exists("string.random.lua") then
    get("https://gist.githubusercontent.com/haggen/2fd643ea9a261fea2094/raw/e9f2ada3154a3d207231d7426e4a00835c298a64/string.random.lua", "string.random.lua","string.random")
end
if not fs.exists("aes.lua") then
    get("https://gist.githubusercontent.com/devomaa/ca179f070adb8ce44f4982a3a3464de4/raw/80987437d1d128c04446d91b65b2060e5ebe7db2/aeslua.min.lua", "aes.lua", "AES API")
end
if not fs.exists("rgb.lua") then
    get("https://pastebin.com/raw/wJdm2Hwg", "rgb.lua", "RGB API")
end
if not fs.exists("hex2rgb.lua") then
    get("https://raw.githubusercontent.com/Perkovec/colorise-lua/master/src/colorise.lua", "hex2rgb.lua", "Hex to RGB conversion API")
local sha = require("sha256")
local json = require("json")
local soqet = require("soqet")
os.loadAPI("string.random.lua")
local aes = require("aes")
local rgb = require("rgb")
local function chat(username, password)
    print("Loading Chat...")
    soqet.open("soqetChat")
    math.randomseed(sha(username .. "|/LAZYSALT-PJALS-1-4-1-2-SOQET-CHAT\|" .. password))
    local userID = string.random(32)
    soqet.auth(userID)
    soqet.send("soqetChat", "BACKLOG", {["credintals"] = {["userID"] = userID}})
    while true do
        parallel.waitForAny(function() local channel, message, meta = os.pullEvent("soqet_message")
        if channel == "soqetChat" and meta.message and meta.user and message == "MESSAGE" and meta.sendToUserHashed == sha(username) then
            print(aes.decrypt(userID, meta.user) .. ": " .. aes.decrypt(userID, meta.message))
        end end, function() local input = aes.encrypt(userID, read()) soqet.send("soqetChat", "DISTRIBUTE-MESSAGE", {["message"] = message, ["user"] = aes.encrypt(userID, username)})  end)
    end
end
if not fs.exists("soqetCredintals.json") then
    print("Enter your new Soqet-Chat username!")
    local username = read()
    print("Enter your new Soqet-Chat password!")
    local password = sha(read("*"))
    local credintals = {["username"] = username, ["password"] = password}
    local result = json.encode(credintals)
    soqet.open("soqetChat")
    soqet.send("soqetChat", "REGISTER", {["data"] = result})
    local file = fs.open("soqetCredintals.json","w")
    file.write(result)
    file.close()
else
    local file = fs.open("soqetCredintals.json","r")
    local contents = file.readAll()
    local credintals = json.decode(contents)
    file.close()
    print("Logging in as " .. credintals.username)
    while true do
        print("Please enter your password")
        local password = sha(read("*"))
        if credintals.password == password then
            chat(credintals.username, credintals.password)
            break
        else
            print("Wrong Password!")
        end
    end 
end
    



