Config = {}

Config['General'] = {
    ["License"] = "lol", --- your license here
    ["Core"] = "QBCore", -- This can be ESX , QBCORE , NPBASE
    ["SQLWrapper"] = "oxmysql", -- This can be `| oxmysql or ghmattimysql or mysql-async
    ["EmailEvent"] = "qb-phone:server:sendNewMail",
    ["PoliceJobName"] = "police", -- police job name
    ["MinPolice"] = 0,
    ["UseNotificationsInsteadOfEmails"] = false, -- this is most likely for esx users , cuz they use bunsh of difirent phones , leave as false if you use qbus or np bases
    ["PoliceNeedLaptopToseeNotifications"] = false,
	["BNErewardmultiplier"] = math.random(12, 15) / 10,
}






Config['Utils'] = {
    ["Rewards"] = {
        ["Type"] = "money", -- reward type item or money
        ["RewardItemName"] = "markedbills", -- this will be the reward item name (no need to config if you are using an money as a reward)
        ["RewardMoneyAmount"] = "0", -- this will be the amount the player recieves when he finish the mission (no need to config if you are using an item as a reward)
        ["RewardAccount"] = "cash", -- this can be only ywo values (no need to config if you are using an item as a reward)
    },
    ["Contracts"] = {
        ["TimeBetweenContracts"] = 300000, -- Time in (ms) between contract creations
        ["ContractChance"] = 50, -- This is the luck percentage of getting a contract
    },
    ["VIN"] = {
        ["BNEPrice"] = 500, -- Price (BNE) for start a vin scratch
        ["AmountBneAfterDropOff"] = 50, 
        ["VinLocations"] = {x = 472.08, y = -1310.73, z = 29.22}, -- laptop coords
        ["ForceVin"] = true, -- this will force vin contract optiion on any created contract turn to false to use days instead
        ["VinDays"] = 7, -- amount of days between vin contracts , (irl days) 
    },
    ["ClassPrices"] = {
        ['X'] = "75",
        ['A'] = "60",
        ['B'] = "42",
        ['C'] = "30",
        ['D'] = "17",
        ['M'] = "12",
    },
    ["Blips"] = {
        ["BlipUpdateTime"] = 3000, -- Time in (ms) of the police blip update 1000 = 1 second
        ["DisableTrackingOnDCB"] = false, -- This will disable the police tracking on D , C , B vehicle classes (Turn to false to disable this option)
    },
    ["Notifications"] = {
        ["NotEnoughBNE"] = "Not enough BNE", 
        ["NoTrackerOnThisVehicle"] = "Seems like this vehicle doesn't have a tracker on", 
        ["TrackerRemoved"] = "Tracker removed",
        ["TrackerRemovedVINMission"] = "Tracker removed, head to the scratch location", 
        ["TrackerRemoved"] = "Tracker removed", 
        ["FinishComputer"] = "Head to the vehicle and scratch off the vin!",
        ["VehicleAdded"] = "Vehicle added to your garage!",
        ["DropOffMsg"] = "Get out of the car and leave the area , you will get your money soon", 
        ["UiStillLoadingMsg"] = "Please wait 3 senconds the nui is loading", 
        ["SuccessHack"] = "Success" ,
        ["NoMissionDetected"] = "No ongoing mission detected",
    },
    ["Commands"] = {
        ["boosting_test"] = "boostingtest", -- This Command will send you a test contract for testing purposes leave as nil to disable
        ["force_close_nui"] = "boostingclose", -- This Command will close the nui if it glitches leave as nil to disable
        ["get_vehicle_class"] = "boostingclass", -- This Command will print (F8) the vehicle class of the one ur sitting in
    },
    ["Laptop"] = {
        ["LogoUrl"] = "images/winlogo.png", 
        ["DefaultBackground"] = "images/background.png",
        ["CopNotifyLength"] = 5000, -- Time in (ms) of the police Notify length
    },
}





-------------- SERVER FUNCTIONS --------------


AddBNE = function(cid, pBne, amount)
    SQL('UPDATE boosting SET BNE=@bne WHERE citizenid=@citizenid', {['@citizenid'] = cid , ['@bne'] = pBne + amount})
end

RemoveBNE = function(cid, pBne, amount)
    SQL('UPDATE boosting SET BNE=@bne WHERE citizenid=@citizenid', {['@citizenid'] = cid , ['@bne'] = pBne - amount})
end

-----     VEHCILES TO SPAWN        -------
Config.Vehicles = {

    ---------- S CLASS --------------
    [1] = {vehicle = "t20"},
    [2] = {vehicle = "Zion2"},
    [3] = {vehicle = "Felon"},
    [4] = {vehicle = "Zentorno"},
    -- ---------- A CLASS --------------
    [5] = {vehicle = "Oracle2"},
    [6] = {vehicle = "Windsor2"},
    [7] = {vehicle = "SabreGT2"},
    [8] = {vehicle = "Sentinel2"},
    [9] = {vehicle = "Zion"},
    [10] = {vehicle = "Phoenix"},
    [11] = {vehicle = "Washington"},
    [12] = {vehicle = "Banshee2"},
    [13] = {vehicle = "Infernus2"},
    [14] = {vehicle = "Nero"},
    [15] = {vehicle = "Nero2"},
    [16] = {vehicle = "Brawler"},
    ---------- B CLASS --------------
    [17] = {vehicle = "Prairie"},
    [18] = {vehicle = "Chino"},
    [19] = {vehicle = "Dukes"},
    [20] = {vehicle = "Virgo3"},
    [21] = {vehicle = "Tampa"},
    [22] = {vehicle = "Blade"},
    [23] = {vehicle = "Sultan"},
    [24] = {vehicle = "Primo"},
    [25] = {vehicle = "Primo2"},
    [26] = {vehicle = "Regina"},
    [27] = {vehicle = "ZType"},
    [28] = {vehicle = "Bison3"},
    [29] = {vehicle = "Bison"},
    [30] = {vehicle = "blista"},
    [31] = {vehicle = "blista2"},
    [32] = {vehicle = "Issi2"},
    [33] = {vehicle = "Issi2"},
    [34] = {vehicle = "Buccaneer2"},
    [35] = {vehicle = "Picador"},
    ---------- C CLASS --------------
    [36] = {vehicle = "Emperor2"},
    [37] = {vehicle = "Tornado3"},
    [38] = {vehicle = "BType"},
    [39] = {vehicle = "Sadler"},
    [40] = {vehicle = "Bison2"},
    [41] = {vehicle = "Minivan2"},
    [42] = {vehicle = "RatLoader"},
    [43] = {vehicle = "Virgo2"},
    ---------- D CLASS --------------
    [44] = {vehicle = "Dilettante"},
}


-----     DROP OFF LOCATIONS        -------
Config.BoostingDropOff = {
	[1] =  { ['x'] = 196.87251281738,['y'] = -156.60850524902,['z'] = 56.786975860596},
	[2] =  { ['x'] = -1286.9621582031,['y'] = -274.47973632813,['z'] = 38.724918365479},
	[3] =  { ['x'] = -1330.8432617188,['y'] = -1034.8623046875,['z'] = 7.518029212951},
}
-----     VEHICLE SPAWN LOCATIONS        -------
Config.VehicleCoords = {
    [1] = {x = 487.95, y = -1314.39, z = 29.25, h = 281.08},
    
}



-----     YOU CAN MESS AROUND WITH THESE NAMES CUZ WHY NOT  -------

Config.CitizenNames =  {
    [1] = {name = "Geoffrey Willis"},
    [2] = {name = "Judy Gordon"},
    [3] = {name = "Nathan Ross"},
    [4] = {name = "Mona Collins"},
    [5] = {name = "Arnold Pittman"},
    [6] = {name = "Brittany Wallace"},
    [7] = {name = "Natalie Taylor"},
    [8] = {name = "Garry Stewart"},
    [9] = {name = "Terrell Todd"},
    [10] = {name = "Vincent Price"},
    [11] = {name = "Todd Hardy"},
    [12] = {name = "Elvira Gross"},
    [13] = {name = "Rudy Newman"},
    [14] = {name = "Rickey Nash"},
    [15] = {name = "Shawn Harris"},
    [16] = {name = "Archie Delgado"},
    [17] = {name = "Josephine Hall"},
    [18] = {name = "Gregory Elliott"},
    [19] = {name = "Marjorie Carlson"},
    [20] = {name = "Lois Phillips"},
    [21] = {name = "Darla Lowe"},
    [22] = {name = "Guadalupe Blake"},
    [23] = {name = "Jack Curry"},
    [24] = {name = "Clifford Sanchez"},
    [25] = {name = "Neil Howard"},
    [26] = {name = "Betsy Mitchell"},
    [27] = {name = "Regina Moss"},
    [28] = {name = "Maxine Davis"},
    [29] = {name = "Elisa Estrada"},
    [30] = {name = "Geneva Newton"},
    [31] = {name = "Trevor Shelton"},
    [32] = {name = "Candice Murphy"},
    [33] = {name = "Roman Austin"},
    [34] = {name = "Juanita Rhodes"},
    [35] = {name = "Laurie Thompson"},
    [36] = {name = "Horace Goodwin"},
    [37] = {name = "Julio Kennedy"},
    [38] = {name = "Rosalie Norton"},
    [39] = {name = "Eleanor Gilbert"},
    [40] = {name = "Kristine Frank"},
    [41] = {name = "Lynn Olson"},
    [42] = {name = "Ruben Huff"},
    [43] = {name = "Janice Page"},
    [44] = {name = "Drew Parks"},
    [45] = {name = "Maggie Garner"},
    [46] = {name = "Kenneth Mcdaniel"},
    [47] = {name = "Sara Herrera"},
    [48] = {name = "Allen Morton"},
    [49] = {name = "Howard Klein"},
    [50] = {name = "Jared Little"},
    [51] = {name = "Jesse Fleming"},
    [52] = {name = "Andre Patrick"},
    [53] = {name = "Pam Mccormick"},
    [54] = {name = "Abel Glover"},
    [55] = {name = "Casey Brewer"},
    [56] = {name = "Kimberly Foster"},
    [57] = {name = "Gary Ruiz"},
    [58] = {name = "Theresa Drake"},
    [59] = {name = "Lorraine Frazier"},
    [60] = {name = "Melvin Mendez"},
    [61] = {name = "Courtney Burns"},
    [62] = {name = "Ora Pope"},
    [63] = {name = "Cecil Moreno"},
    [64] = {name = "Kenny Richardson"},
    [65] = {name = "Salvatore Larson"},
    [66] = {name = "Ethel Martinez"},
    [67] = {name = "Ross Sims"},
    [68] = {name = "Peter Hubbard"},
    [69] = {name = "Noel Evans"},
    [70] = {name = "Joseph Hunter"},
    [71] = {name = "Russell Keller"},
    [72] = {name = "Phil Simon"},
    [73] = {name = "Bertha Cruz"},
    [74] = {name = "Rufus Carroll"},
    [75] = {name = "Jeremiah Russell"},
    [76] = {name = "Kim Roy"},
    [77] = {name = "Sally Obrien"},
    [78] = {name = "Joshua Hunt"},
    [79] = {name = "Kurt Singleton"},
    [80] = {name = "Marlon Carter"},
    [81] = {name = "Jane Collier"},
    [82] = {name = "Marshall Johnston"},
    [83] = {name = "Stacey Morris"},
    [84] = {name = "Ivan Lindsey"},
    [85] = {name = "Alberta Oliver"},
    [86] = {name = "Earnest Paul"},
    [87] = {name = "Henrietta Doyle"},
    [88] = {name = "Bryant Green"},
    [89] = {name = "Viola Wagner"},
    [90] = {name = "Roosevelt Jacobs"},
    [91] = {name = "Rolando Clayton"},
    [92] = {name = "Bernice Graham"},
    [92] = {name = "Carl Knight"},
    [94] = {name = "Justin Carr"},
    [95] = {name = "Toni Briggs"},
    [96] = {name = "Amos Williamson"},
    [97] = {name = "Lamar Leonard"},
    [98] = {name = "Wm Allison"},
    [99] = {name = "Johnnie Quinn"},
    [100] = {name = "Jenna Anderson"},
}




--------------BLIPS----------------- DON4T TOUCH ANY OF THESE UNLESS YOU KNOW WHAT YOU ARE DOING
local Circle


function CreateBlip(v)
    Circle = Citizen.InvokeNative(0x46818D79B1F7499A,v.x + math.random(0.0,150.0), v.y + math.random(0.0,80.0), v.z + math.random(0.0,5.0) , 300.0) -- you can use a higher number for a bigger zone
    SetBlipHighDetail(Circle, true)
    SetBlipColour(Circle, 18)
    SetBlipAlpha (Circle, 128)
end
  
function DeleteCircle()
    if DoesBlipExist(Circle) then
        RemoveBlip(Circle)
    end
end
  

function DeleteBlip()
	if DoesBlipExist(blip) then
		RemoveBlip(blip)
	end
end


function CreateDropPoint()
    DeleteBlip()
    rnd = math.random(1,#Config.BoostingDropOff)
    if OnTheDropoffWay then
    blip = AddBlipForCoord(Config.BoostingDropOff[rnd]["x"],Config.BoostingDropOff[rnd]["y"],Config.BoostingDropOff[rnd]["z"])
    end
    SetBlipSprite(blip, 514)
    SetBlipScale(blip, 0.7)
    SetBlipAsShortRange(blip, false)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Drop Off")
    EndTextCommandSetBlipName(blip)
    DropblipCreated = true
end

function DeleteCopBlip()
	if DoesBlipExist(copblip) then
		RemoveBlip(copblip)
	end
end

function CreateCopBlip(cx,cy,cz)
    DeleteCopBlip()
    copblip = AddBlipForCoord(cx,cy,cz)
    SetBlipSprite(copblip , 161)
    SetBlipScale(copblipy , 2.0)
    SetBlipColour(copblip, 8)
    PulseBlip(copblip)
end


function CreateScratchPoint()
    DeleteBlip()
    if vinstarted then
        blip = AddBlipForCoord(Config.ScratchLocation[1]["x"],Config.ScratchLocation[1]["y"],Config.ScratchLocation[1]["z"])
    end
    SetBlipSprite(blip, 514)
    SetBlipScale(blip, 0.7)
    SetBlipAsShortRange(blip, false)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Vin Scratch")
    EndTextCommandSetBlipName(blip)
    DropblipCreated = true
end


function DrawText3D2(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 90)
end


ShowNotification = function(msg, type)
    exports['mythic_notify']:SendAlert(type, msg)
	--exports['co_notify']:SendNotify('boosting', type, msg)
end


function LoadDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(10)
    end
end