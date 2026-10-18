--[[              Catsaken is not open-source software, and its source code, features, and implementations 
                  are not provided for public use, copying, modification, or redistribution. The code is
  ／l、           intentionally obfuscated to make it harder for others to extract, copy, or recreate its
（ﾟ､ ｡ ７         features. Deobfuscating the script, obtaining leaked source code, or otherwise
  l  ~ヽ          gaining access to its underlying implementation does not grant permission to use, copy,
  じしf_,)ノ      redistribute, or incorporate that code or its features into another project.
]]

if getthreadidentity() < 8 then
    return game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = identifyexecutor();
        Text = "Sorry, But your executor (level " .. getthreadidentity() .. ") cannot run this, it's too weak!";
        Duration = 15;
        Button1 = "I will upgrade my executor";
    })
end

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local maintenence = false
if maintenence then
  return Fluent:Notify({
      Title = "Catsaken",
      Content = "Catsaken Remastered, the forsaken script you just ran, is currently not working due to a change in forsaken's internal systems or a severe error in catsaken remastered's code. Please wait up to 24 hours for a fix to be applied",
      Duration = 40
  })
end

loadstring(game:HttpGet('https://raw.githubusercontent.com/aibabylaugh/catsaken/refs/heads/main/Beta/catsaken.lua'))('gg/VzHp67sw9a')
