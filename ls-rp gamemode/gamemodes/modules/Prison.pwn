// Defines

#define MAX_PRISON_CELLS (20)

// Variables

enum 
{
	ARREST_POINT_INVALID,
	ARREST_POINT_ADMIN,
	ARREST_POINT_HARBOUR,
	ARREST_POINT_RECEIVE_RELEASE,
}

new Float:PrisonSpawns[20][4] =
{
	{1259.1826,879.0620,1161.0986,0.3243}, // cell0
	{1255.9192,879.4290,1161.0986,359.9627}, // cell1
	{1252.7668,879.2256,1161.0986,2.0517}, // cell2
	{1249.4446,879.1050,1161.0986,358.0828}, // cell3
	{1246.3043,878.9809,1161.0986,359.1273}, // cell4
	{1241.2770,881.5520,1161.0986,268.3876}, // cell5
	{1241.2383,884.7954,1161.0986,265.7765}, // cell6
	{1241.8746,888.1390,1161.0986,266.8209}, // cell7
	{1241.6023,891.3270,1161.0986,265.5676}, // cell8
	{1259.0790,878.9432,1164.6002,355.4952}, // cell9
	{1255.9172,879.3018,1164.6002,356.2263}, // cell10
	{1252.5100,878.6264,1164.6002,353.4064}, // cell1
	{1249.4583,879.0394,1164.6002,359.2553}, // cell12
	{1246.3431,878.7535,1164.6002,358.0020}, // cell13
	{1241.5663,881.6027,1164.6002,268.4923}, // cell14
	{1241.3690,884.8303,1164.6002,267.1344}, // cell15
	{1241.4137,888.0013,1164.6002,266.2989}, // cell16
	{1241.3083,891.2327,1164.6002,263.4789}, // cell17
	{1241.6770,894.3024,1164.6002,268.3878}, // cell18
	{1241.6345,897.5210,1164.6002,269.0144} // cell19
};

new Float:JailSpawns[3][4] =
{
	{2121.2581,-2185.6255,925.3945,269.0754},
	{2121.1772,-2182.3145,925.3945,267.0910},
	{2121.2546,-2179.0718,925.3945,264.4800}
};

enum E_PRISON_CELL_DATA
{
    bool:cellExists,
    cellObject,
    Float:cellPosition[3],
    bool:cellClosed,
    bool:cellLocked,
};

static const PrisonCells[MAX_PRISON_CELLS][E_PRISON_CELL_DATA];

// Functions

ReturnArrestPoint(playerid)
{
	if(InApartment[playerid] != -1)
	{
		switch(ComplexData[ InApartment[playerid ]][aID])
		{
			case APARTMENT_SQLID_HARBOUR:
			{
				return ARREST_POINT_HARBOUR;
			}
			case APARTMENT_SQLID_RECEIVE_AND_RELEASE:
			{
				return ARREST_POINT_RECEIVE_RELEASE;
			}	
		}
	}

    if(AdminDuty{playerid}) return ARREST_POINT_ADMIN;

	return ARREST_POINT_INVALID;
}

PutPlayerInJail(playerid, cell)
{
    ph_menuid[playerid] = 6;
	ph_sub_menuid[playerid] = 1; 

    if(cell != -1)
    {
        SetPlayerPosEx(playerid, JailSpawns[cell][0], JailSpawns[cell][1], JailSpawns[cell][2], 3000);
        SetPlayerFacingAngle(playerid, JailSpawns[cell][3]);
        SetSpawnInfo(playerid, NO_TEAM, PlayerData[playerid][pModel], JailSpawns[cell][0], JailSpawns[cell][1], JailSpawns[cell][2], JailSpawns[cell][3], -1, -1, -1, -1, -1, -1);
        SetCameraBehindPlayer(playerid);
    }

    GetPlayerPos(playerid, PlayerData[playerid][pPos][0], PlayerData[playerid][pPos][1], PlayerData[playerid][pPos][2]);
 	GetPlayerFacingAngle(playerid, PlayerData[playerid][pPos][3]); 

    DesyncPlayerInterior(playerid);

    foreach (new i : Complex)
    {
        if(ComplexData[i][aID] == APARTMENT_SQLID_HARBOUR)
        {
            if(InApartment[playerid] != i)
            {
                SetPlayerInteriorEx(playerid, ComplexData[i][aInterior]);
                SetPlayerVirtualWorldEx(playerid, ComplexData[i][aWorld]);

                InApartment[playerid] = i;
                PlayerData[playerid][pLocal] = i + LOCAL_APARTMENT;
            }
            break;
        }
    } 
}

PutPlayerInPrison(playerid, cell)
{
	if(PlayerCell[playerid] != cell)
	{
		PlayerCell[playerid] = cell;

		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: You've been assigned to cell A%d as of now. Cell assigning happens upon connect.", PlayerCell[playerid] + 100);
	}

    ph_menuid[playerid] = 6;
	ph_sub_menuid[playerid] = 1; 

	SetPlayerPosEx(playerid, PrisonSpawns[cell][0], PrisonSpawns[cell][1], PrisonSpawns[cell][2], 3000);
	SetPlayerFacingAngle(playerid, PrisonSpawns[cell][3]);
	SetSpawnInfo(playerid, NO_TEAM, PlayerData[playerid][pModel], PrisonSpawns[cell][0], PrisonSpawns[cell][1], PrisonSpawns[cell][2], PrisonSpawns[cell][3], -1, -1, -1, -1, -1, -1);

	DesyncPlayerInterior(playerid);

	SetPlayerInteriorEx(playerid, 0);
	SetPlayerVirtualWorldEx(playerid, 999);

 	PlayerData[playerid][pLocal] = 999; // Prison Local
 	GetPlayerPos(playerid, PlayerData[playerid][pPos][0], PlayerData[playerid][pPos][1], PlayerData[playerid][pPos][2]);
 	GetPlayerFacingAngle(playerid, PlayerData[playerid][pPos][3]);
    SetCameraBehindPlayer(playerid);

	AttachPrisonLabel(playerid);
	SetPlayerTime(playerid, 12, 0);

    AutoLow{playerid} = true;
}

SyncPrisonInterior(playerid, bool:force = false)
{
    if(force || GetPlayerVirtualWorld(playerid) == 999 || IsPlayerInRangeOfPoint(playerid, 300.0, 1259.3942, 890.4816, 1163.7670))
    {
        SetPlayerInteriorEx(playerid, 0);
        SetPlayerVirtualWorldEx(playerid, 999);   
        PlayerData[playerid][pLocal] = 999;
        SetPlayerTime(playerid, 12, 0);
    }
}

ReleaseFromPrison(playerid)
{
	PlayerData[playerid][pJailed] = PUNISHMENT_TYPE_NONE;
	PlayerData[playerid][pSentenceTime] = 0;

    PlayerCell[playerid] = -1;
	RemovePrisonLabel(playerid);
	SetPlayerInteriorEx(playerid, 0);
	SetPlayerVirtualWorldEx(playerid, 0);
    DesyncPlayerInterior(playerid);
	SetPlayerDynamicPos(playerid, 1553.0421, -1675.4706, 16.1953);
	SetSpawnInfo(playerid, NO_TEAM, PlayerData[playerid][pModel], 1553.0421, -1675.4706, 16.1953, 0.0000, -1, -1, -1, -1, -1, -1);
	SetPlayerTime(playerid, ghour, 0);

	AutoLow{playerid} = false;

	mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `characters` SET `ActiveListings` = 0, `Jailed` = 0, `SentenceTime` = 0 WHERE `ID` = %i LIMIT 1", PlayerData[playerid][pID]);
	mysql_pquery(dbCon, gquery);	
}

RemovePrisonLabel(playerid)
{
	if(IsValidDynamic3DTextLabel(PrisonLabel[playerid])) DestroyDynamic3DTextLabel(PrisonLabel[playerid]);
}

AttachPrisonLabel(playerid)
{
	if(IsValidDynamic3DTextLabel(PrisonLabel[playerid])) DestroyDynamic3DTextLabel(PrisonLabel[playerid]);

	new str[20];
	format(str, 20, "A%d", PlayerCell[playerid] + 100);
 	PrisonLabel[playerid] = CreateDynamic3DTextLabel(str, 0x04FF00FF, 0.0, 0.0, 0.3, 20.0, playerid);
}

FindNearestCell(playerid)
{
    if(PlayerData[playerid][pLocal] != 999) return -1;

    new idx = -1, Float:fDistance[2] = {99999.0, 0.0};

    for(new i = 0; i < MAX_PRISON_CELLS; i++)
    {   
		fDistance[1] = GetPlayerDistanceFromPoint(playerid, PrisonCells[i][cellPosition][0], PrisonCells[i][cellPosition][1], PrisonCells[i][cellPosition][2]);

		if(fDistance[1] < fDistance[0])
		{
			fDistance[0] = fDistance[1];

			idx = i;
		}
    }

  	if(idx != -1 && fDistance[0] < 3)
	{  
        return idx;
    }

    return -1;
}

CMD:paccess(playerid, params[])
{
    if(GetFactionType(playerid) != FACTION_CORRECTIONAL)
        return SendUnauthMessage(playerid, "Unauthorized.");

    if(!PlayerData[playerid][pOnDuty])     
        return SendUnauthMessage(playerid, "You're not on duty.");

    new lock, cell[30];   

    if(sscanf(params, "ds[30]", lock, cell))
        return SendSyntaxMessage(playerid, "/paccess [1/0 (lock/unlock)] [Location, A1, A2, All, A201 etc.)]");

    if(lock < 0 || lock > 1)
        return SendErrorMessage(playerid, "Invalid lock status specified.");

    if(!strcmp(cell, "A1", false))
    {
        for(new i = 0; i < MAX_PRISON_CELLS; ++i)
        {   
            if(lock) 
                ClosePrisonCell(i);
            else 
                OpenPrisonCell(i);
        }
        return true;
    }    
    else if(!strcmp(cell, "A2", false))
    {
        // to do
        return true;
    }
    else if(!strcmp(cell, "All", false))
    {
        for(new i = 0; i < MAX_PRISON_CELLS; ++i)
        {   
            if(lock) 
                ClosePrisonCell(i);
            else 
                OpenPrisonCell(i);
        }  
        return true;    
    }
    else
    {
        new string[30];

        for(new i = 0; i < MAX_PRISON_CELLS; ++i)
        {
            format(string, sizeof(string), "A1%02d", i);

            if(!strcmp(cell, string, false))
            {
                if(lock) 
                    ClosePrisonCell(i);
                else 
                    OpenPrisonCell(i);
                return true;
            }
        }
        
        SendSyntaxMessage(playerid, "/paccess [1/0 (lock/unlock)] [Location, A1, A2, All, A201 etc.)]");
    }

    return true;
}

CMD:gotocell(playerid, params[])
{
    new cell = strval(params);

    if(cell >= MAX_PRISON_CELLS) return false;

    SetPlayerPos(playerid, PrisonCells[cell][cellPosition][0], PrisonCells[cell][cellPosition][1], PrisonCells[cell][cellPosition][2]);

    SendClientMessageEx(playerid, -1, "tp to cell %d", cell);
    return true;
}

CMD:opencells(playerid, params[])
{
    for(new i = 0; i < MAX_PRISON_CELLS; i++)
    {   
        OpenPrisonCell(i);
    }
    return true;
}

CMD:closecells(playerid, params[])
{
    for(new i = 0; i < MAX_PRISON_CELLS; i++)
    {   
        ClosePrisonCell(i);
    }
    return true;
}

CreatePrisonCell(objectid)
{
    for(new i = 0; i < MAX_PRISON_CELLS; i++)
    {   
        if(!PrisonCells[i][cellExists])
        {
            PrisonCells[i][cellExists] = true;
            PrisonCells[i][cellObject] = objectid;
            PrisonCells[i][cellClosed] = true;
            PrisonCells[i][cellLocked] = false;

            GetDynamicObjectPos(PrisonCells[i][cellObject], PrisonCells[i][cellPosition][0], PrisonCells[i][cellPosition][1], PrisonCells[i][cellPosition][2]);   
            return true;
        }
    }

    printf("Failed to create prison cell. Increase MAX_PRISON_CELLS.");
    return true;
}

stock TogglePrisonCell(id)
{
    if(!PrisonCells[id][cellClosed])
    {
        ClosePrisonCell(id);
    }
    else
    {
        OpenPrisonCell(id);
    }
}

/*

y zvoglohet anej ka WC

x rritet ka pjesa e hymjes

*/

stock OpenPrisonCell(id)
{
    if(!PrisonCells[id][cellClosed]) return true;

    PrisonCells[id][cellClosed] = false;

    if((id >= 0 && id <= 4) || (id >= 9 && id <= 13))
    {
        MoveDynamicObject(PrisonCells[id][cellObject], PrisonCells[id][cellPosition][0] - 1.4, PrisonCells[id][cellPosition][1], PrisonCells[id][cellPosition][2], 1.7, 0.0, 0.0, 0.0);
    }
    else
    {
        MoveDynamicObject(PrisonCells[id][cellObject], PrisonCells[id][cellPosition][0], PrisonCells[id][cellPosition][1] - 1.4, PrisonCells[id][cellPosition][2], 1.7, 0.0, 0.0, 90.0);
    }
    return true;
}

stock ClosePrisonCell(id)
{
    if(PrisonCells[id][cellClosed]) return true;

    PrisonCells[id][cellClosed] = true;

    if((id >= 0 && id <= 4) || (id >= 9 && id <= 13))
    {
        MoveDynamicObject(PrisonCells[id][cellObject], PrisonCells[id][cellPosition][0], PrisonCells[id][cellPosition][1], PrisonCells[id][cellPosition][2], 1.7, 0.0, 0.0, 0.0);
    }
    else
    {
        MoveDynamicObject(PrisonCells[id][cellObject], PrisonCells[id][cellPosition][0], PrisonCells[id][cellPosition][1], PrisonCells[id][cellPosition][2], 1.7, 0.0, 0.0, 90.0);
    }
    return true;
}