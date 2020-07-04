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
if not fs.exists("sha_all.lua") then
    get("https://raw.githubusercontent.com/devomaa-CC/soqet-chat-thing/master/sha_all_min.lua","sha_all.lua","SHA2 API")
end
if not fs.exists("json.lua") then
    get("https://raw.githubusercontent.com/devomaa-CC/soqet-chat-thing/master/json.lua","json.lua","JSON API")
end
if not fs.exists("soqet.lua") then
    get("https://raw.githubusercontent.com/devomaa-CC/soqet-chat-thing/master/soqet.lua","soqet.lua","Soqet")
end
if not fs.exists("string.random.lua") then
    get("https://raw.githubusercontent.com/devomaa-CC/soqet-chat-thing/master/string.random.lua", "string.random.lua","string.random")
end
if not fs.exists("aes.lua") then
    get("https://raw.githubusercontent.com/devomaa-CC/soqet-chat-thing/master/aes.lua", "aes.lua", "AES API")
end
if not fs.exists("rgb.lua") then
    get("https://raw.githubusercontent.com/devomaa-CC/soqet-chat-thing/master/rgb.lua", "rgb.lua", "RGB API")
end
if not fs.exists("hex2rgb.lua") then
    get("https://raw.githubusercontent.com/devomaa-CC/soqet-chat-thing/master/hex2rgb.lua", "hex2rgb.lua", "Hex to RGB conversion API")
end
local sha = require("sha_all")
local json = require("json")
local soqet = require("soqet")
os.loadAPI("string.random.lua")
local aes = require("aes")
local rgb = require("rgb")
local function chat(username, password)
    print("Loading Chat...")
    soqet.open("soqetChat")
    math.randomseed(sha.sha512(username .. "|/LAZYSALT-PJALS-1-4-1-2-SOQET-CHAT\\|" .. password))
    local userID = stringUtils.random(32)
    soqet.auth(userID)
    soqet.send("soqetChat", "BACKLOG", {["credintals"] = {["userID"] = userID}})
    while true do
        parallel.waitForAny(function() local channel, message, meta = os.pullEvent("soqet_message")
        if channel == "soqetChat" and meta.message and meta.user and message == "MESSAGE" and meta.sendToUserHashed == sha.sha512(username) then
            print(aes.decrypt(userID, meta.user) .. ": " .. aes.decrypt(userID, meta.message))
        end end, function() local input = aes.encrypt(userID, read()) soqet.send("soqetChat", json.encode({["action"] = "DISTRIBUTE-MESSAGE", ["message"] = message, ["user"] = aes.encrypt(userID, username)})  end)
    end
end
if not fs.exists("soqetCredintals.json") then
    print("Enter your new Soqet-Chat username!")
    local username = read()
    print("Enter your new Soqet-Chat password!")
    local password = sha.sha512(read("*"))
    local credintals = {["username"] = username, ["password"] = password}
    local result = json.encode(credintals)
    soqet.open("soqetChat")
    soqet.send("soqetChat", json.encode({["action"] = "REGISTER", ["data"] = result}))
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
    



