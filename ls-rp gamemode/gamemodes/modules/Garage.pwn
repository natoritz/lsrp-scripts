enum E_GARAGE_DATA
{
    garageID,
    garageHouse,
    bool:garageLocked,
    Float:garageEnter[4]
};

new GarageData[MAX_PROPERTIES][E_GARAGE_DATA];
new Iterator:Garage<MAX_PROPERTIES>;

stock Garage_Create(house, Float: x, Float: y, Float: z, Float: angle)
{
    mysql_format(dbCon, gquery, sizeof(gquery), "INSERT INTO `garages` (garageHouse, garageEnterX, garageEnterY, garageEnterZ, garageEnterA) VALUES (%d, %f, %f, %f, %f)");
    mysql_tquery(dbCon, gquery, "OnGarageCreation", "dffff", house, x, y, z, angle);
}

stock Garage_Remove(g)
{
    Iter_Remove(Garage, g);

    GarageData[g][garageID] = -1;
    GarageData[g][garageHouse] = -1;
    GarageData[g][garageLocked] = false;
    GarageData[g][garageEnter][0] = 0.0;
    GarageData[g][garageEnter][1] = 0.0;
    GarageData[g][garageEnter][2] = 0.0;
    GarageData[g][garageEnter][3] = 0.0;
}

stock Garage_Nearest(playerid)
{
    new Float: range = 6.0;

    if(!IsPlayerInAnyVehicle(playerid)) range = 2.5;

    foreach (new i : Garage)
    {
        if(IsPlayerInRangeOfPoint(playerid, range, GarageData[i][garageEnter][0], GarageData[i][garageEnter][1], GarageData[i][garageEnter][2]))
        {
            return i;
        }
    }
    return -1;
}

stock Garage_Enter(playerid, garageid)
{
    InGarage[playerid] = garageid;

    new vehicleid = GetPlayerVehicleID(playerid);

    if(vehicleid > 0)
    {
		SetVehiclePos(vehicleid, 1449.0339, -2518.7883, 13.7018);
		SetVehicleZAngle(vehicleid, 90.0);
 		SetVehicleVirtualWorld(vehicleid, LOCAL_GARAGE + garageid);
		LinkVehicleToInterior(vehicleid, 1);       

  		foreach (new i : VehicleOccupant(vehicleid))
		{
            SetPlayerVirtualWorldEx(i, LOCAL_GARAGE + garageid);  
            SetPlayerInteriorEx(i, 1);

            InGarage[i] = garageid;
            PlayerData[i][pLocal] = LOCAL_GARAGE + garageid;
		}     
    }
    else
    {
        SetPlayerPosEx(playerid, 1452.6891, -2516.3198, 13.5750);
        SetPlayerVirtualWorldEx(playerid, LOCAL_GARAGE + garageid);  
        SetPlayerInteriorEx(playerid, 1);

        InGarage[playerid] = garageid;
        PlayerData[playerid][pLocal] = LOCAL_GARAGE + garageid;
    }
}

stock Garage_Exit(playerid)
{
    new g = InGarage[playerid];

	if(IsPlayerInAnyVehicle(playerid))
	{
		new vehicleid = GetPlayerVehicleID(playerid);

		SetVehiclePos(vehicleid, GarageData[g][garageEnter][0], GarageData[g][garageEnter][1], GarageData[g][garageEnter][2]);
        SetVehicleZAngle(vehicleid, GarageData[g][garageEnter][3]);
		SetVehicleVirtualWorld(vehicleid, 0);
		LinkVehicleToInterior(vehicleid, 0);

		foreach (new i : VehicleOccupant(vehicleid))
		{
			SetPlayerVirtualWorldEx(i, 0);
			SetPlayerInteriorEx(i, 0);

            DesyncPlayerInterior(i);
		}
		return true;
	}
	else
	{
		SetPlayerPos(playerid, GarageData[g][garageEnter][0], GarageData[g][garageEnter][1], GarageData[g][garageEnter][2]);
        SetPlayerFacingAngle(playerid, GarageData[i][garageEnter][3]);
		SetPlayerVirtualWorldEx(playerid, 0);
		SetPlayerInteriorEx(playerid, 0);

		DesyncPlayerInterior(i);
	}    
}

FUNX::OnGarageCreation(house, Float: x, Float: y, Float: z, Float: angle)
{
    new g = Iter_Free(Garage);

    if(g == -1) return true;

    GarageData[g][garageID] = cache_insert_id();
    GarageData[g][garageHouse] = house;
    GarageData[g][garageLocked] = false;
    GarageData[g][garageEnter][0] = x;
    GarageData[g][garageEnter][1] = y;
    GarageData[g][garageEnter][2] = z;
    GarageData[g][garageEnter][3] = angle;
    return true;
}