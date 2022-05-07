if not syn then return end

if not game:IsLoaded() then game.Loaded:Wait() end

local function checkFolder(name,path)
    if not isfolder((path or "").."/"..name) then
        makefolder((path or "").."/"..name)
        return true
    else
        return true
    end
end

local function checkFile(name,path,checkcontent,content)
    if not isfile((path or "").."/"..name) then
        writefile((path or "").."/"..name,content)
        return true
    else
        if checkcontent then
            if readfile((path or "").."/"..name) == content then
                return true
            else
                writefile((path or "").."/"..name,content)
                return true
            end
        end
    end
end

checkFolder("FLibrary")
checkFile("CustomFunctions.FLibraryFile","/FLibrary",false,"")

_G.FLib = {}

local contents = "local functions = {}\n\nfunctions.ExampleFunction = function(whattoprint)\n    print(whattoprint)\nend\n\nreturn functions"

local success = pcall(function()
    if readfile("/FLibrary/CustomFunctions.FLibraryFile") == "" then
        writefile("/FLibrary/CustomFunctions.FLibraryFile",contents)
        _G.FLib["CustomFunctions"] = loadstring(contents)()
    else
        _G.FLib["CustomFunctions"] = loadstring(readfile("/FLibrary/CustomFunctions.FLibraryFile"))()
    end
end)

if not success then 
    game.StarterGui:SetCore("SendNotification", {Title = "Error";Text = "One or more custom functions have errored, custom functions deactivated.";Icon = "rbxassetid://9568997684";Duration = 10}) 
else
    game.StarterGui:SetCore("SendNotification", {Title = "FLibrary";Text = "Successfully loaded custom functions, you can use them now (with _G.FLib.CustomFunctions).";Icon = "rbxassetid://9568997684";Duration = 10}) 
end

local function loadFunctions()
    local success = pcall(function()
        _G.FLib["Functions"] = loadstring(game:HttpGet("https://raw.githubusercontent.com/FelixDMxx/FLibrary/main/Functions.lua",true))()
    end)
    if not success then 
        game.StarterGui:SetCore("SendNotification", {Title = "Error";Text = "Couldn't load functions, retrying.";Icon = "rbxassetid://9568997684";Duration = 10})
        loadFunctions()
    else
        game.StarterGui:SetCore("SendNotification", {Title = "FLibrary";Text = "Successfully loaded functions, you can use them now (with _G.FLib.Functions).";Icon = "rbxassetid://9568997684";Duration = 10})
    end
end
loadFunctions()
