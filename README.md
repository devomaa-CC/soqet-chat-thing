# SoqetChat
This is the GH repository for SoqetChat
## What is SoqetChat?
SoqetChat is a chat based on Soqet! (pretty obv)
### How do I use it?
Either get a CC emulator, or install Minecraft and CC: Tweaked on it, then just run (copypasting is allowed) `wget https://raw.githubusercontent.com/devomaa-CC/soqet-chat-thing/client/main.lua` and `main.lua`.
### How does it work?
#### Registering:
It sends a JSON message on Soqet channel "soqetChat", its something like
```json
{
  "action": "REGISTER",
  "credintals": { "username":"username", "password":"SHA512 hash of password" }
}
```
#### Logging in:
Same as registering, just action is "LOGIN"
#### Sending a message
It sends a JSON message on Soqet channel "soqetChat", its something like
```json
{
  "action": "DISTRIBUTE-MESSAGE",
  "message": "AES-encrypted message, encrypted using the User ID of the user.",
  "user": "SHA512 hash of username"
}
```
