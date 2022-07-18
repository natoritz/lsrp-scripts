// Defines

#define MAX_DYNAMIC_VEHICLES (200)

/* Vehicle Label Timer */
#define VLT_TYPE_TOWING  			1
#define VLT_TYPE_PERMITFACTION		2
#define VLT_TYPE_LOCK		  		3
#define VLT_TYPE_UNREGISTER    		4
#define VLT_TYPE_REGISTER           5
#define VLT_TYPE_OPERAFAILED	  	6
#define VLT_TYPE_UPGRADELOCK      	7
#define VLT_TYPE_UPGRADEALARM     	8
#define VLT_TYPE_UPGRADEIMMOB       9
#define VLT_TYPE_UPGRADEINSURANCE 	10
#define VLT_TYPE_BREAKIN		 	11
#define VLT_TYPE_ARMOUR			 	12
#define VLT_TYPE_REFILL			 	13
#define VLT_TYPE_OPERAOUTOFRANG    	14
#define VLT_TYPE_UPGRADEBATTERY     15
#define VLT_TYPE_UPGRADEENGINE  	16

// Variables

enum E_VEHICLE_DATA
{
    vVehicleID,
	vVehicleModelID,
	Float:vVehiclePosition[3],
	Float:vVehicleRotation,
	vVehicleFaction,
	vVehicleColour[2],
	vVehicleScriptID,
	vVehiclePlate[24],
	vVehicleSiren,
	vVehicleCarsign[50]
};

enum E_CORE_VEH_DATA
{
	Float:vehFuel,
	startup_delay,
	startup_delay_sender,
	startup_delay_random,
	Float:vehCrash,
	vehDamage[4],
    bool:vradioOn,
    vradioURL[128],
	vOwnerID,
	vUpgradeID,
	vHitStamp,
	Text3D:vehSignText,
	vehSign,
	vbreakin,
	vbreaktime,
	vbreakdelay,
	vbreakeffect,
	vSiren,
	vSiren2,
	vehicleBadlyDamage,
	vehicleCrate[MAX_TRUCKER_ITEMS],
	vehicleObj[6],
	vehicleIsCargoLoad,
	vehicleCargoTime,
	vehicleCargoStorage,
	vehicleCargoPlayer,
	vehicleCargoAction, // 0 - Buy,  1 - Sell
	vehicleEngineStamp,
	vehicleCarID,
	bool:vehicleEngineStatus,
	vLastPlayerInCar,
	vLastDriverInCar,
	vHasEngine,
	Float:vSpeed
};

new CoreVehicles[MAX_VEHICLES][E_CORE_VEH_DATA];
new vehicleVariables[MAX_DYNAMIC_VEHICLES][E_VEHICLE_DATA];
new Iterator:sv_servercar<MAX_DYNAMIC_VEHICLES>;

// Functions

Vehicle_Save(id)
{
	if(Iter_Contains(sv_servercar, id))
	{
	    new queryString[400];

	    mysql_format(dbCon, queryString, sizeof(queryString), "UPDATE `vehicles` SET `vehicleModelID` = '%d', `vehiclePosX` = '%.4f', `vehiclePosY` = '%.4f', `vehiclePosZ` = '%.4f', `vehiclePosRotation` = '%.4f', `vehicleFaction` = '%d', `vehicleCol1` = '%d', `vehicleCol2` = '%d', `vehiclePlate` = '%e', `vehicleSiren` = '%d', `vehicleSign` = '%e' WHERE `vehicleID` = '%d' LIMIT 1", vehicleVariables[id][vVehicleModelID],	vehicleVariables[id][vVehiclePosition][0],
		vehicleVariables[id][vVehiclePosition][1], vehicleVariables[id][vVehiclePosition][2], vehicleVariables[id][vVehicleRotation], vehicleVariables[id][vVehicleFaction], vehicleVariables[id][vVehicleColour][0], vehicleVariables[id][vVehicleColour][1], vehicleVariables[id][vVehiclePlate], vehicleVariables[id][vVehicleSiren], vehicleVariables[id][vVehicleCarsign], vehicleVariables[id][vVehicleID]);
		mysql_pquery(dbCon, queryString);
	}
	return true;
}

Vehicle_GetID(id)
{
	foreach (new i : sv_servercar)
	{
		if(vehicleVariables[i][vVehicleScriptID] == id)
		{
			return i;
		}
	}
	return -1;
}

IsAFactionCar(vehicleid, factionid)
{
    if(vehicleid != INVALID_VEHICLE_ID)
	{
		foreach (new i : sv_servercar)
		{
			if(vehicleVariables[i][vVehicleScriptID] == vehicleid && vehicleVariables[i][vVehicleFaction] != -1 && vehicleVariables[i][vVehicleFaction] == factionid)
			{
				return i;
			}
		}
	}
	return -1;
}