// Defines

#define FACTION_POLICE (1)
#define FACTION_NEWS (2)
#define FACTION_MEDIC (3)
#define FACTION_GOV (4)
#define FACTION_GANG (5)
#define FACTION_SHERIFF (6)
#define FACTION_CORRECTIONAL (7)

#define MAX_FACTIONS (8)
#define MAX_FACTION_SPAWNS (5)

// Variables

enum E_FACTION_DATA
{
	factionID,
	factionExists,
	factionName[60],
	factionAbbrv[20],
	factionLeader[MAX_PLAYER_NAME],
	factionColor,
	factionColorChat,
	factionType,
	factionRanks,
	factionChat,
	factionPickup,
	factionMaxMembers,
	factionMaxVehicles,
	Float:factionSpawn[4]
};

enum E_FACTION_SPAWN_DATA
{
	spawnID,
	Float:factionSpawn[4],
	spawnInt,
	spawnWorld,
	spawnApartment,
	spawnName[64]
};

new FactionData[MAX_FACTIONS][E_FACTION_DATA];
new FactionSpawns[MAX_FACTIONS][MAX_FACTION_SPAWNS][E_FACTION_SPAWN_DATA];
new FactionRanks[MAX_FACTIONS][19][32];

enum e_FACTION_SKIN_DATA
{
	skinModel,
	skinName[15],
	skinRace[17],
	skinGender[10],
	bool:skinAccessories
}

new SkinsLSPD[][e_FACTION_SKIN_DATA] =
{
	{20045, "BFYPD1", "African American", "Female", true},
	{20052, "OFYPD1", "Hispanic", "Female", true},
	{20055, "WFYPD1", "Caucasian", "Female", true},
	{20056, "WFYSGT1", "Caucasian", "Female", true},
	{20046, "BMOPD1", "African American", "Male", true},
	{20047, "BMYPD1", "African American", "Male", true},
	{20048, "BMYPD2", "African American", "Male", true},
	{20049, "HMOPD1", "Hispanic", "Male", true},
	{20050, "HMYPD1", "Hispanic", "Male", true},
	{20051, "HMYPD2", "Hispanic", "Male", true},
	{20053, "OMYPD1", "Asian", "Male", true},
	{20054, "PDBIK1", "Caucasian", "Male", true},
	{20057, "WMOPD1", "Caucasian", "Male", true},
	{20058, "WMYPD1", "Caucasian", "Male", true},
	{20059, "WMYPD2", "Caucasian", "Male", true},
	{20060, "WMYSGT1", "Caucasian", "Male", true},
    {20114, "AMYPD2", "Asian", "Male", true},
    //BMOPD2 missing
    {20115, "HMOSGT1", "Hispanic", "Male", true},
	{20116, "WMYPD3", "Caucasian", "Male", true},
	{20117, "WMYPD4", "Caucasian", "Male", true},
	{20118, "WMYPD5", "Caucasian", "Male", true},
	//BMOSWAT1 missing
	{20199, "BMYPDLG", "African American", "Male", true},
	{20200, "HMYPDLG", "Hispanic", "Male", true},
	{20201, "WFYPDLG", "Caucasian", "Female", true},
	{20130, "WMYFLIGHT1", "Caucasian", "Male", true},
	{20077, "WMYSWAT1", "Caucasian", "Male", true},
	{20202, "WMYPDLG1", "Caucasian", "Male", true},
	{20203, "WMYPDLG2", "Caucasian", "Male", true},
	{20131, "WMYSWAT2", "Caucasian", "Male", true},
	{20132, "WMYSWAT4", "Caucasian", "Male", true},
	{20133, "BMYSWAT1", "African American", "Male", true},
	{20134, "BMYSWAT2", "African American", "Male", true},
	{20135, "HMYSWAT1", "Hispanic", "Male", true}
};

new SkinsLSSD[][e_FACTION_SKIN_DATA] =
{
    {20009, "FASHER", "Asian", "Female", true},
    {20010, "FBIKESHER", "Caucasian", "Female", true},
    {20011, "FBSHER", "African American", "Female", true},
    {20012, "FWSHER", "Caucasian", "Female", true},
    {20013, "MASHER1", "Asian", "Male", true},
    {20014, "MASHER2", "Asian", "Male", true},
    {20015, "MASHER3", "Asian", "Male", true},
    {20016, "MBIKESHER", "Caucasian", "Male", true},
    {20017, "MBSHER1", "African American", "Male", true},
    {20018, "MBSHER2", "African American", "Male", true},
    {20019, "MHSHER", "Hispanic", "Male", true},
    {20020, "MWSGTS", "Caucasian", "Male", true},
    {20021, "MWSHER1", "Caucasian", "Male", true},
    {20022, "MWSHER2", "Caucasian", "Male", true},
    {20023, "MWSHER3", "Caucasian", "Male", true},
    {20024, "MWSHER4", "Caucasian", "Male", true},
    {20230, "BFYSHER", "African American", "Male", true},
    {20231, "BMYSHER", "African American", "Male", true},
    {20232, "BMYSHER2", "African American", "Male", true},
    {20233, "BMYSHERS", "African American", "Male", true},
    {20234, "HMYSHER", "Hispanic", "Male", true},
    {20235, "HMYSHER2", "Hispanic", "Male", true},
    {20236, "HMYSHERS", "Hispanic", "Male", true},
    {20237, "OFYSHER", "Asian", "Female", true},
    {20238, "OMYSHER", "Asian", "Male", true},
    {20239, "OMYSHERS", "Asian", "Male", true},
    {20240, "WFYSHER", "Caucasian", "Female", true},
    {20241, "WFYSHER2", "Caucasian", "Female", true},
    {20242, "WFYSHERB", "Caucasian", "Female", true},
    {20243, "WMOSHER", "Caucasian", "Male", true},
    {20244, "WMOSHERS", "Caucasian", "Male", true},
    {20245, "WMYSHER", "Caucasian", "Male", true},
    {20246, "WMYSHER2", "Caucasian", "Male", true},
    {20247, "WMYSHERB", "Caucasian", "Male", true},
    {20248, "WMYSHERS", "Caucasian", "Male", true}
};

new SkinsLSFD[][e_FACTION_SKIN_DATA] =
{
	{274, "LS-EMT", "African American", "Male", true},
	{276, "SF-EMT", "Caucasian", "Male", true},
	{275, "LV-EMT", "Hispanic", "Male", true},
	{308, "SF-EMT", "Caucasian", "Female", true},
	{277, "LS-EMT", "Caucasian", "Male", true},
	{278, "LV-EMT", "African American", "Male", true},
	{279, "SF-FIRE", "Caucasian", "Male", true},
	{70, "Doctor", "Caucasian", "Male", true},
	{211, "STAFF", "Caucasian", "Female", true},
	{93, "WFYST", "Caucasian", "Female", true}
};

new SkinsDOC[][e_FACTION_SKIN_DATA] =
{
	{20190, "BMYDCR1", "African American", "Male", true},
	{20191, "WMYDCR1", "Caucasian", "Male", true},
	{20192, "WMYDCR2", "Caucasian", "Male", true},
	{20193, "HMYDCR1", "Hispanic", "Male", true},
	{20194, "HMYDCR2", "Hispanic", "Male", true},
	{20196, "WFYDCR1", "Caucasian", "Female", true},
	{20197, "WFYDCR2", "Caucasian", "Female", true},
	{20198, "BFYDCR1", "African American", "Female", true}
};

// Functions

IsNearFactionSpawn(playerid, faction)
{
	if(InApartment[playerid] != -1)
	{
	    new aptid = InApartment[playerid];

	    if(ComplexData[aptid][aFaction] != -1 && ComplexData[aptid][aFaction] == PlayerData[playerid][pFaction])
			return true;
	}

	for(new i = 0; i < 5; ++i)
	{
	    if(FactionSpawns[faction][i][spawnID] == 0)
			continue;

	    if(IsPlayerInRangeOfPoint(playerid, 10.0, FactionSpawns[faction][i][factionSpawn][0], FactionSpawns[faction][i][factionSpawn][1], FactionSpawns[faction][i][factionSpawn][2]))
			return true;
	}

	return false;
}

IsPolice(playerid)
{
	if(PlayerData[playerid][pFaction] == -1)
		return false;

	new type = GetFactionType(playerid);

	if(type == FACTION_POLICE || type == FACTION_SHERIFF)
	    return true;

	return false;
}

CanFactionDuty(type)
{
    switch(type)
    {
        case FACTION_POLICE, FACTION_SHERIFF, FACTION_MEDIC, FACTION_CORRECTIONAL:
            return true;
		default:
		    return false;
    }

    return false;
}

ReturnFactionNameByType(faction)
{
	new string[60];
	switch(faction)
	{
		case FACTION_POLICE:
		{
			format(string, 60, "LSPD");
		}
		case FACTION_NEWS:
		{
			format(string, 60, "NEWS");
		}
		case FACTION_MEDIC:
		{
			format(string, 60, "MEDIC");
		}
		case FACTION_GOV:
		{
			format(string, 60, "GOV");
		}
		case FACTION_SHERIFF:
		{
			format(string, 60, "SHERIFF");
		}
		case FACTION_CORRECTIONAL:
		{
			format(string, 60, "CORRECTIONAL");
		}
		default:
		{
			format(string, 60, "NONE");
		}
	}
	return string;
}

ViewFactions2(playerid)
{
	new count, members;

	gstr[0] = EOS;

	for(new i = 0; i != MAX_FACTIONS; ++i)
	{
		if(FactionData[i][factionExists])
		{
		    count = 0;
		    members = 0;

			new checkQuery[128];
			mysql_format(dbCon, checkQuery, sizeof(checkQuery), "SELECT `ID` FROM `characters` WHERE `Faction` = '%d'", FactionData[i][factionID]);
			new Cache:cache = mysql_query(dbCon, checkQuery);

			members = cache_num_rows();

			cache_delete(cache);

			foreach (new k : Player)
			{
				if(PlayerData[k][pFaction] == i)
				{
					count++;
				}
			}

			format(gstr, sizeof(gstr), "%s{7e98b6}%d\t{A9C4E4}%s\t{A9C4E4}[{7e98b6}%d out of %d{A9C4E4}]\n", gstr, FactionData[i][factionID], FactionData[i][factionName], count, members);
		}
	}

	Dialog_Show(playerid, Factionss, DIALOG_STYLE_TABLIST, "Factions", gstr, "<< Exit", "");
	return true;
}

ViewFactions(playerid)
{
	new menu[10], count;
	
	gstr[0] = EOS;

	format(gstr, sizeof(gstr), "%s{B4B5B7}Page 1{FFFFFF}\n", gstr);

	SetPVarInt(playerid, "page", 1);

	for(new i = 0; i != MAX_FACTIONS; ++i)
	{
		if(FactionData[i][factionExists])
		{
			if(count == 10)
			{
				format(gstr, sizeof(gstr), "%s{B4B5B7}Page 2{FFFFFF}\n", gstr);
				break;
			}

			format(menu, 10, "menu%d", ++count);

			SetPVarInt(playerid, menu, i);

			format(gstr, sizeof(gstr), "%s{FFFFFF}Faction ({FFBF00}%i{FFFFFF}) | %s\n", gstr, i, FactionData[i][factionName]);
		}
	}

	if(!count) return Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, "Factions List", "No information for Faction.", "Ok", "");

	Dialog_Show(playerid, FactionsList, DIALOG_STYLE_LIST, "Factions List", gstr, "Edit", "Back");
	return true;
}

Faction_GetName(playerid)
{
    new
		factionid = PlayerData[playerid][pFaction],
		name[32] = "None";

 	if(factionid == -1)
	    return name;

	if(!FactionData[factionid][factionExists])
	    return name;

	format(name, 32, FactionData[factionid][factionName]);
	return name;
}

Faction_GetAbbreviation(playerid, type_idx = -1)
{
	new
		abbrv[40],
		type = GetFactionType(playerid)
	;

	if(type_idx != -1) type = type_idx;

	switch(type)
	{
	    case FACTION_POLICE: format(abbrv, 40, "POLICE");

		case FACTION_SHERIFF: format(abbrv, 40, "SHERIFF");

		case FACTION_MEDIC: format(abbrv, 40, "FIRE");

		case FACTION_CORRECTIONAL: format(abbrv, 40, "DCR");

		default: format(abbrv, 40, "N/A");
	}

	return abbrv;
}

Faction_GetRank(playerid)
{
    new
		factionid = PlayerData[playerid][pFaction],
		rank[32] = "None";

 	if(factionid == -1)
	    return rank;

	format(rank, 32, FactionRanks[factionid][PlayerData[playerid][pFactionRank] - 1]);
	return rank;
}

ReturnRank(factionid, id)
{
    new
		rank[32] = "None";

 	if(factionid == -1)
	    return rank;

	format(rank, 32, FactionRanks[factionid][id]);
	return rank;
}

GetFactionByID(sqlid)
{
	for(new i = 0; i != MAX_FACTIONS; ++i)
	{
		if(FactionData[i][factionExists] && FactionData[i][factionID] == sqlid)
		{
	    	return i;
		}
	}

	return -1;
}

CountFactionMembers(factionid)
{
	new members, checkQuery[128];

	mysql_format(dbCon, checkQuery, sizeof(checkQuery), "SELECT NULL FROM `characters` WHERE `Faction` = %d", FactionData[factionid][factionID]);
	new Cache:cache = mysql_query(dbCon, checkQuery);

	members = cache_num_rows();

	cache_delete(cache);

	return members;
}

CountFactionVehicles(factionid)
{
	new
	    count
	;

	foreach (new i : sv_servercar)
	{
		if(vehicleVariables[i][vVehicleFaction] != -1 && vehicleVariables[i][vVehicleFaction] == factionid)
		{
			count++;
		}
	}

	return count;
}

SetFaction(playerid, id)
{
	if(id != -1 && FactionData[id][factionExists])
	{
	    if(PlayerData[playerid][pFaction] != id)
	    {
	        if(PlayerData[playerid][pOnDuty])
	        {
				ResetWeapons(playerid);
				RestorePlayerWeapons(playerid);

				TagColor{playerid} = false;
			    PlayerData[playerid][pOnDuty] = false;
			}

			SetPlayerArmour(playerid, 0);
			SetPlayerToTeamColor(playerid);

		    PlayerData[playerid][pSwat] = false;
		    PlayerData[playerid][pFavUniform] = 0;

		    CallSign[playerid][0] = EOS;

		    if(GetPlayerSkin(playerid) != PlayerData[playerid][pModel])
		    {
		        SetPlayerSkin(playerid, PlayerData[playerid][pModel]);
		    }
	    }

		PlayerData[playerid][pFaction] = id;
		PlayerData[playerid][pFactionID] = FactionData[id][factionID];
	}
	return true;
}

SetFactionColor(playerid)
{
	new factionid = PlayerData[playerid][pFaction];

	if(factionid != -1)
		return SetPlayerColor(playerid, RemoveAlpha(FactionData[factionid][factionColor]));

	return 0;
}

GetFactionColor(factionid)
{
	new color[8] = "FFFFFF";

	if(factionid == -1)
		return color;

	format(color, sizeof(color), "%06x", FactionData[factionid][factionColor] >>> 8);

	return color;
}

forward OnFactionCreated(factionid);
public OnFactionCreated(factionid)
{
	if(factionid == -1 || !FactionData[factionid][factionExists])
	    return false;

	FactionData[factionid][factionID] = cache_insert_id();

	Faction_Save(factionid);
	Faction_SaveRanks(factionid);

	FactionSpawns[factionid][0][factionSpawn][0] = 0.0;
	FactionSpawns[factionid][0][factionSpawn][1] = 0.0;
	FactionSpawns[factionid][0][factionSpawn][2] = 0.0;
	FactionSpawns[factionid][0][factionSpawn][3] = 0.0;
	FactionSpawns[factionid][0][spawnInt] = 0;
	FactionSpawns[factionid][0][spawnWorld] = 0;
	FactionSpawns[factionid][0][spawnApartment] = -1;
	format(FactionSpawns[factionid][0][spawnName], 64, "Primary Spawn");

	new query[500];

	mysql_format(dbCon, query, sizeof(query),"INSERT INTO factionspawns (factionID, SpawnX, SpawnY, SpawnZ, SpawnA, Interior, World, Name) VALUES ('%d', '%f', '%f', '%f', '%f', '%d', '%d', '%e') ",
		FactionData[factionid][factionID], FactionSpawns[factionid][0][factionSpawn][0], FactionSpawns[factionid][0][factionSpawn][1], FactionSpawns[factionid][0][factionSpawn][2], FactionSpawns[factionid][0][factionSpawn][3],
		FactionSpawns[factionid][0][spawnInt], FactionSpawns[factionid][0][spawnWorld], FactionSpawns[factionid][0][spawnName]
	);

	mysql_pquery(dbCon, query);

	FactionSpawns[factionid][0][spawnID] = cache_insert_id();
	return true;
}

Faction_Update(factionid)
{
	if(factionid != -1 || FactionData[factionid][factionExists])
	{
	    foreach (new i : Player)
		{
			if(PlayerData[i][pFaction] == factionid)
			{
	 			if(GetFactionType(i) == FACTION_GANG || (GetFactionType(i) != FACTION_GANG && PlayerData[i][pOnDuty]))
	 			{
				 	SetFactionColor(i);
				}
			}
		}
	}
	return true;
}

Faction_Save(factionid)
{
    if(factionid == -1) return true;

	new query[400];

	mysql_format(dbCon, query, sizeof(query), "UPDATE `factions` SET `factionName` = '%e', `factionShort` = '%e', `factionLeader` = '%e', `factionColor` = '%d', `factionType` = '%d', `factionRanks` = '%d', `factionColorChat` = '%d', `factionMaxMembers` = '%d', `factionMaxVehicles` = '%d' WHERE `factionID` = '%d' LIMIT 1",
		FactionData[factionid][factionName],
		FactionData[factionid][factionAbbrv],
		FactionData[factionid][factionLeader],
		FactionData[factionid][factionColor],
		FactionData[factionid][factionType],
		FactionData[factionid][factionRanks],
		FactionData[factionid][factionColorChat],
		FactionData[factionid][factionMaxMembers],
        FactionData[factionid][factionMaxVehicles],
		FactionData[factionid][factionID]
	);

 	return mysql_tquery(dbCon, query);
}

Faction_SaveSpawnID(factionid, spawnid)
{
	new query[768];

	if(factionid != -1)
	{
	    query[0] = EOS;

		mysql_format(dbCon, query, sizeof(query), "UPDATE `factionspawns` SET `SpawnX` = '%f', `SpawnY` = '%f', `SpawnZ` = '%f', `SpawnA` = '%f', `Interior` = '%d', `World` = '%d', `Apartment` = '%d', `Name` = '%e' WHERE `id` = '%d' LIMIT 1",
	        FactionSpawns[factionid][spawnid][factionSpawn][0],
	        FactionSpawns[factionid][spawnid][factionSpawn][1],
	        FactionSpawns[factionid][spawnid][factionSpawn][2],
	        FactionSpawns[factionid][spawnid][factionSpawn][3],
	        FactionSpawns[factionid][spawnid][spawnInt],
	        FactionSpawns[factionid][spawnid][spawnWorld],
	        FactionSpawns[factionid][spawnid][spawnApartment],
	        FactionSpawns[factionid][spawnid][spawnName],
	        FactionSpawns[factionid][spawnid][spawnID]
		);

		mysql_tquery(dbCon, query);
	}

	return true;
}

Faction_SaveRanks(factionid)
{
	if(factionid == -1) return true;

	new query[900];

	mysql_format(dbCon, query, sizeof(query), "UPDATE `factions` SET `factionRank1` = '%e', `factionRank2` = '%e', `factionRank3` = '%e', `factionRank4` = '%e', `factionRank5` = '%e', `factionRank6` = '%e', `factionRank7` = '%e', `factionRank8` = '%e', `factionRank9` = '%e', `factionRank10` = '%e', `factionRank11` = '%e', `factionRank12` = '%e', `factionRank13` = '%e', `factionRank14` = '%e', `factionRank15` = '%e', `factionRank16` = '%e', `factionRank17` = '%e', `factionRank18` = '%e' WHERE `factionID` = '%d' LIMIT 1",
	    FactionRanks[factionid][0],
	    FactionRanks[factionid][1],
	    FactionRanks[factionid][2],
	    FactionRanks[factionid][3],
	    FactionRanks[factionid][4],
	    FactionRanks[factionid][5],
	    FactionRanks[factionid][6],
	    FactionRanks[factionid][7],
	    FactionRanks[factionid][8],
	    FactionRanks[factionid][9],
	    FactionRanks[factionid][10],
	    FactionRanks[factionid][11],
	    FactionRanks[factionid][12],
	    FactionRanks[factionid][13],
	    FactionRanks[factionid][14],
	    FactionRanks[factionid][15],
	    FactionRanks[factionid][16],
	    FactionRanks[factionid][17],
	    FactionData[factionid][factionID]
	);

	return mysql_tquery(dbCon, query);
}

Faction_Delete(factionid)
{
	if(factionid != -1 && FactionData[factionid][factionExists])
	{
	    new string[128];

		mysql_format(dbCon, string, sizeof(string), "DELETE FROM `factions` WHERE `factionID` = '%d' LIMIT 1", FactionData[factionid][factionID]);
		mysql_tquery(dbCon, string);

		mysql_format(dbCon, string, sizeof(string), "DELETE FROM `factionspawns` WHERE `factionID` = '%d'", FactionData[factionid][factionID]);
		mysql_tquery(dbCon, string);

		mysql_format(dbCon, string, sizeof(string), "UPDATE `characters` SET `Faction` = '-1' WHERE `Faction` = '%d'", FactionData[factionid][factionID]);
		mysql_tquery(dbCon, string);

		foreach (new i : Player)
		{
			if(PlayerData[i][pFaction] == factionid)
			{
		    	PlayerData[i][pFaction] = -1;
		    	PlayerData[i][pFactionID] = -1;
		    	PlayerData[i][pFactionRank] = 0;
			}
			if(PlayerData[i][pFactionEdit] == factionid)
			{
			    PlayerData[i][pFactionEdit] = -1;
			}
		}

		for(new i = 0; i < 5; ++i)
		{
		    FactionSpawns[factionid][i][spawnID] = 0;
		}

		if(IsValidDynamicPickup(FactionData[factionid][factionPickup]))
  			DestroyDynamicPickup(FactionData[factionid][factionPickup]);

	    FactionData[factionid][factionExists] = false;
	    FactionData[factionid][factionType] = 0;
	    FactionData[factionid][factionID] = 0;
	}
	return true;
}

GetFactionType(playerid)
{
	if(PlayerData[playerid][pFaction] == -1)
	    return 0;

	return (FactionData[PlayerData[playerid][pFaction]][factionType]);
}

Faction_Create(const name[], type)
{
	for(new i = 0; i != MAX_FACTIONS; ++i)
	{
		if(!FactionData[i][factionExists])
		{
		    format(FactionData[i][factionName], 60, name);
		    format(FactionData[i][factionAbbrv], 20, "N/A");

	        FactionData[i][factionExists] = true;
	        FactionData[i][factionColor] = 0xFFFFFFFF;
	        FactionData[i][factionColorChat] = 0x01FCFFFF;
	        FactionData[i][factionType] = type;
	        FactionData[i][factionRanks] = 19;
	        FactionData[i][factionMaxMembers] = 90;

	        if(type == FACTION_GANG)
				FactionData[i][factionMaxVehicles] = 10;
	        else
				FactionData[i][factionMaxVehicles] = 100;

            format(FactionRanks[i][0], 32, "Rank 1");
            format(FactionRanks[i][1], 32, "Rank 2");
            format(FactionRanks[i][2], 32, "Rank 3");
			format(FactionRanks[i][3], 32, "Rank 4");

		    for(new j = 4; j < 19; ++j) FactionRanks[i][j][0] = EOS;

		    mysql_tquery(dbCon, "INSERT INTO `factions` (`factionType`) VALUES(0)", "OnFactionCreated", "d", i);
		    return i;
		}
	}
	return -1;
}

ResetFaction(playerid, bool:variables = true)
{
    PlayerData[playerid][pFaction] = -1;
    PlayerData[playerid][pFactionID] = -1;
    PlayerData[playerid][pFactionRank] = 0;

    if(variables)
    {
        if(PlayerData[playerid][pOnDuty])
        {
			ResetWeapons(playerid);
			RestorePlayerWeapons(playerid);

			TagColor{playerid} = false;
			CallSign[playerid][0] = EOS;
			PlayerData[playerid][pHandCuffs] = 0;
			PlayerData[playerid][pOnDuty] = false;

			if(TazerActive{playerid})
			{
				TazerActive{playerid} = false;
				DeletePVar(playerid, "WeaponSlot");
				DeletePVar(playerid, "WeaponSlot2");				
			}

			BeanbagActive{playerid} = false;
			LessLethalActive{playerid} = false;					
		}

		SetPlayerArmour(playerid, 0);
		SetPlayerToTeamColor(playerid);

		PlayerData[playerid][pSwat] = false;
	    PlayerData[playerid][pFavUniform] = 0;

	    if(GetPlayerSkin(playerid) != PlayerData[playerid][pModel])
	    {
	        SetPlayerSkin(playerid, PlayerData[playerid][pModel]);
	    }
	}
}

HasFactionRank(playerid, rank)
{
	if(PlayerData[playerid][pFaction] == -1)
	    return false;

	if(PlayerData[playerid][pFactionRank] <= rank || FactionPermissions[playerid] <= rank)
		return true;

	return false;
}

AssignFactionPermissions(playerid)
{
	new checkQuery[256];

	mysql_format(dbCon, checkQuery, sizeof(checkQuery), "SELECT `FactionRank` FROM `characters` WHERE `master` = '%d' AND `Faction` = '%d' AND `FactionRank` < '%d' ORDER BY FactionRank ASC LIMIT 1", AccountData[playerid][aUserid], PlayerData[playerid][pFactionID], PlayerData[playerid][pFactionRank]);
	new Cache:cache = mysql_query(dbCon, checkQuery);

	if(cache_num_rows())
	{
		cache_get_value_name_int(0, "FactionRank", FactionPermissions[playerid]);

		SendNoticeMessage(playerid, "You inherited faction permissions from your alternative account. (%s, Rank %d)", ReturnRank(PlayerData[playerid][pFaction], FactionPermissions[playerid] - 1), FactionPermissions[playerid]);
	}

	cache_delete(cache);
}

SetPlayerFaction(playerid)
{
	if(PlayerData[playerid][pFactionID] != -1)
	{
		PlayerData[playerid][pFaction] = GetFactionByID(PlayerData[playerid][pFactionID]);

		if(PlayerData[playerid][pFaction] == -1)
		{
			ResetFaction(playerid, false);
		}
		else
		{
			if(PlayerData[playerid][pFactionRank] != 1)
			{
				new checkQuery[256];

				mysql_format(dbCon, checkQuery, sizeof(checkQuery), "SELECT `FactionRank` FROM `characters` WHERE `master` = '%d' AND `Faction` = '%d' AND `FactionRank` < '%d' ORDER BY FactionRank ASC LIMIT 1", AccountData[playerid][aUserid], PlayerData[playerid][pFactionID], PlayerData[playerid][pFactionRank]);
				new Cache:cache = mysql_query(dbCon, checkQuery);

				if(cache_num_rows())
				{
					cache_get_value_name_int(0, "FactionRank", FactionPermissions[playerid]);

					SendClientMessageEx(playerid, COLOR_WHITE, "SERVER: You inherited %s faction permissions from an alt account.", ReturnRank(PlayerData[playerid][pFaction], FactionPermissions[playerid] - 1));
				}

				cache_delete(cache);
			}
		}
	}
}

GetFactionTypeName(type)
{
	new string[32] = "Unknown";

	switch(type)
	{
		case 1: format(string, 32, "Police");
		case 2: format(string, 32, "SAN");
		case 3: format(string, 32, "Fire / Medical");
		case 4: format(string, 32, "Government");
		case 5: format(string, 32, "Mafia");
		case 6: format(string, 32, "Sheriff");
		case 7: format(string, 32, "Correctional");
	}
	return string;
}

ShowFactionSpawns(playerid, factionid = -1)
{
	if(factionid != -1)
		PlayerData[playerid][pFactionEdit] = factionid;
	else
		factionid = PlayerData[playerid][pFactionEdit];

	if(!FactionData[factionid][factionExists]) return true;

	new count;

	gstr[0] = EOS;

	for(new i = 0; i < 5; ++i)
	{
	    if(FactionSpawns[factionid][i][spawnID] != 0)
	    {
	        format(gstr, sizeof(gstr), "%s{7e98b6}%d\t{a9c4e4}%s\n", gstr, i + 1, FactionSpawns[factionid][i][spawnName]);

	        count++;
	    }
	}

	if(count != 5) format(gstr, sizeof(gstr), "{a9c4e4}Add Spawn\n%s", gstr);

	Dialog_Show(playerid, FactionSpawns, DIALOG_STYLE_LIST, "Faction Spawns", gstr, "Select", "<< Exit");
    return true;
}

ShowFactionEditSpawn(playerid, idx)
{
    new factionid = PlayerData[playerid][pFactionEdit], string[256];

	gstr[0] = EOS;

	format(string, 256, "{7e98b6}1\t{a9c4e4}Spawn Name [{7e98b6}%s{a9c4e4}]\n", FactionSpawns[factionid][idx][spawnName]);
	strcat(gstr, string);
	format(string, 256, "{7e98b6}2\t{a9c4e4}Spawn Position [{7e98b6}%.2f, %.2f, %.2f{a9c4e4}]\n", FactionSpawns[factionid][idx][factionSpawn][0], FactionSpawns[factionid][idx][factionSpawn][1], FactionSpawns[factionid][idx][factionSpawn][2]);
	strcat(gstr, string);
	format(string, 256, "{7e98b6}3\t{a9c4e4}Delete Spawn\n");
	strcat(gstr, string);

	Dialog_Show(playerid, FactionSpawns_Menu, DIALOG_STYLE_LIST, "Faction Spawns", gstr, "Select", "<< Exit");
	return true;
}

ShowPlayerEditFaction(playerid, factionid = -1)
{
	if(factionid != -1)
		PlayerData[playerid][pFactionEdit] = factionid;
	else
		factionid = PlayerData[playerid][pFactionEdit];

	if(factionid != -1 && FactionData[factionid][factionExists])
	{
		new string[256];

		gstr[0] = EOS;

		new members = CountFactionMembers(factionid), vehicles = CountFactionVehicles(factionid);

		format(string, 256, "{7e98b6}1\t{a9c4e4}Name [{7e98b6}%s{a9c4e4}]\n", FactionData[factionid][factionName]);
		strcat(gstr, string);
		format(string, 256, "{7e98b6}2\t{a9c4e4}Abbreviation [{7e98b6}%s{a9c4e4}]\n", FactionData[factionid][factionAbbrv]);
		strcat(gstr, string);
		format(string, 256, "{7e98b6}3\t{a9c4e4}Faction Chat Color (RGBA) [{7e98b6}%06x{a9c4e4}]\n", FactionData[factionid][factionColorChat] >>> 8);
		strcat(gstr, string);
		format(string, 256, "{7e98b6}4\t{a9c4e4}Spawn Position [{7e98b6}%.2f, %.2f, %.2f{a9c4e4}]\n", FactionSpawns[factionid][0][factionSpawn][0], FactionSpawns[factionid][0][factionSpawn][1], FactionSpawns[factionid][0][factionSpawn][2]);
		strcat(gstr, string);
		format(string, 256, "{7e98b6}5\t{a9c4e4}Rank Administration\n");
		strcat(gstr, string);
		format(string, 256, "{c9c9c9}6\t{c9c9c9}Faction Founder [{7e98b6}%s{c9c9c9}]\n", FactionData[factionid][factionLeader]);
		strcat(gstr, string);
		format(string, 256, "{c9c9c9}7\t{c9c9c9}Faction Type [{7e98b6}%s{c9c9c9}]\n", GetFactionTypeName(FactionData[factionid][factionType]));
		strcat(gstr, string);
		format(string, 256, "{c9c9c9}8\t{c9c9c9}Faction Permissions\n");
		strcat(gstr, string);
		format(string, 256, "{c9c9c9}9\t{c9c9c9}Faction Tag Color [{7e98b6}%06x{c9c9c9}]\n", FactionData[factionid][factionColor]);
		strcat(gstr, string);
		format(string, 256, "{7e98b6}10\t{a9c4e4}Vehicle Slots In Use [{7e98b6}%d out of %d{a9c4e4}]\n", vehicles, FactionData[factionid][factionMaxVehicles]);
		strcat(gstr, string);
		format(string, 256, "{7e98b6}11\t{a9c4e4}Member Slots In Use [{7e98b6}%d out of %d{a9c4e4}] (Click to resync)\n", members, FactionData[factionid][factionMaxMembers]);
		strcat(gstr, string);
		format(string, 256, "{c9c9c9}12\t{c9c9c9}Max Members [{7e98b6}%d{c9c9c9}]\n", FactionData[factionid][factionMaxMembers]);
		strcat(gstr, string);
		format(string, 256, "{c9c9c9}13\t{c9c9c9}Max Vehicles [{7e98b6}%d{c9c9c9}]\n", FactionData[factionid][factionMaxVehicles]);
		strcat(gstr, string);
		format(string, 256, "{7e98b6}14\t{a9c4e4}Subrank Administration");
		strcat(gstr, string);

		Dialog_Show(playerid, FactionEdit, DIALOG_STYLE_LIST, "Faction Overview", gstr, "Enter", "<< Exit");
	}
	return true;
}

// Dialogs

Dialog:FactionEdit_ChatColor(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new color, string[256], factionid = PlayerData[playerid][pFactionEdit];

		if(sscanf(inputtext, "x", color))
		{
	  		format(string, sizeof(string), "{FFFFFF}Change the factions chat color from RGB/HEX {7e98b6}%06x\n\n{FFFFFF}Default faction color is  {01FCFF}01FCFF{FFFFFF}  and for law factions it's  {8D8DFF}8D8DFF", FactionData[factionid][factionColorChat] >>> 8);
            Dialog_Show(playerid, FactionEdit_ChatColor, DIALOG_STYLE_INPUT, "Chat Color", string, "Enter", "<< Back");
			return true;
		}

	    FactionData[factionid][factionColorChat] = color;
	    Faction_Save(factionid);
	}
	return ShowPlayerEditFaction(playerid);
}

Dialog:FactionEdit_TagColor(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new color, string[256], factionid = PlayerData[playerid][pFactionEdit];

		if(sscanf(inputtext, "x", color))
		{
			format(string, sizeof(string), "{FFFFFF}Change the factions tag color from HEX {a9c4e4}%06x", FactionData[factionid][factionColor]);
			Dialog_Show(playerid, FactionEdit_TagColor, DIALOG_STYLE_INPUT, "Tag Color", string, "Enter", "<< Back");
			return true;
		}

	    FactionData[factionid][factionColor] = color;
	    Faction_Update(factionid);
	    Faction_Save(factionid);
	}
	return ShowPlayerEditFaction(playerid);
}

Dialog:FactionEdit_Name(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new string[256], factionid = PlayerData[playerid][pFactionEdit];

		if(isnull(inputtext) || strlen(inputtext) >= 60)
		{
		    format(string, sizeof(string), "Change the faction name from {7e98b6}%s", FactionData[factionid][factionName]);
		    Dialog_Show(playerid, FactionEdit_Name, DIALOG_STYLE_INPUT, "New name", string, "Enter", "<< Back");
			return true;
		}

		SendClientMessageEx(playerid, COLOR_YELLOW, "-> Changed faction ID %d's name to: %s", FactionData[factionid][factionID], inputtext);

		format(FactionData[factionid][factionName], 60, inputtext);
		Faction_Save(factionid);
	}
	return ShowPlayerEditFaction(playerid);
}

Dialog:FactionEdit_ShortName(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new string[256], factionid = PlayerData[playerid][pFactionEdit];

		if(isnull(inputtext) || strlen(inputtext) >= 20)
		{
			format(string, sizeof(string), "Change the faction abbreviated (short) name from {7e98b6}%s", FactionData[factionid][factionAbbrv]);
			Dialog_Show(playerid, FactionEdit_ShortName, DIALOG_STYLE_INPUT, "New short name", string, "Enter", "<< Back");
			return true;
		}

		SendClientMessageEx(playerid, COLOR_YELLOW, "-> Changed faction ID %d's abbreviated name to: %s", FactionData[factionid][factionID], inputtext);

		format(FactionData[factionid][factionAbbrv], 20, inputtext);
		Faction_Save(factionid);
	}
	return ShowPlayerEditFaction(playerid);
}

Dialog:FactionEdit_Spawn(playerid, response, listitem, inputtext[])
{
	new factionid = PlayerData[playerid][pFactionEdit];

	if(response)
	{
		GetPlayerPos(playerid, FactionSpawns[factionid][0][factionSpawn][0], FactionSpawns[factionid][0][factionSpawn][1], FactionSpawns[factionid][0][factionSpawn][2]);

		SendClientMessageEx(playerid, COLOR_YELLOW, "-> Changed faction ID %d's spawn point to: %.2f, %.2f, %.2f", FactionData[factionid][factionID], FactionSpawns[factionid][0][factionSpawn][0], FactionSpawns[factionid][0][factionSpawn][1], FactionSpawns[factionid][0][factionSpawn][2]);

		FactionSpawns[factionid][0][spawnInt] = GetPlayerInterior(playerid);
		FactionSpawns[factionid][0][spawnWorld] = GetPlayerVirtualWorld(playerid);
		FactionSpawns[factionid][0][spawnApartment] = InApartment[playerid];

		Faction_SaveSpawnID(factionid, 0);
	}
	return ShowPlayerEditFaction(playerid);
}

ShowFactionRankMenu(playerid)
{
    new string[1000], factionid = PlayerData[playerid][pFactionEdit], count;

	for(new i = 0; i < FactionData[factionid][factionRanks]; ++i)
	{
		if(strlen(FactionRanks[factionid][i]) > 0)
		{
			format(string, sizeof(string), "%s\n{7e98b6}%d\t{a9c4e4}%s", string, i + 1, FactionRanks[factionid][i]);

			count++;
		}
	}

	if(count + 1 <= FactionData[factionid][factionRanks]) format(string, sizeof(string), "{7e98b6}Add Rank%s", string);

	Dialog_Show(playerid, FactionEdit_Ranks, DIALOG_STYLE_LIST, "Rank Overview", string, "Select", "<< Back");
	return true;
}

Dialog:FactionEdit_Ranks(playerid, response, listitem, inputtext[])
{
	if(response)
	{
	    new factionid = PlayerData[playerid][pFactionEdit];

	    if(!strcmp(inputtext, "Add Rank", false))
			return Dialog_Show(playerid, FactionEdit_AddRank, DIALOG_STYLE_INPUT, "Rank Name", "Write the name you wish to use for your new rank.", "Create", "<< Back");

		new rank = strval(inputtext) - 1;

		if(!strlen(FactionRanks[factionid][rank]))
		    return ShowFactionRankMenu(playerid);

		EditFactionRank(playerid, rank);
		return true;
	}
	return ShowPlayerEditFaction(playerid);
}

EditFactionRank(playerid, rank)
{
    new string[400], factionid = PlayerData[playerid][pFactionEdit], bool:is_top_rank, bool:is_bottom_rank;

    switch(rank)
    {
        case 0:
		{
			is_top_rank = true;
		}
        case 18:
		{
			is_bottom_rank = true;
		}
        default:
		{
			if(!strlen(FactionRanks[factionid][rank + 1])) is_bottom_rank = true;
		}
    }

    SetPVarInt(playerid, "ModifyFactionRank", rank);

	format(string, sizeof(string), "{7e98b6}1\t{a9c4e4}Rank Name [{7e98b6}%s{a9c4e4}]", FactionRanks[factionid][rank]);

	strcat(string, "\n{7e98b6}2\t{a9c4e4}Rank Skin [{7e98b6}0{a9c4e4}]");
	strcat(string, "\n{7e98b6}3\t{a9c4e4}Rank Paycheck [{7e98b6}$0{a9c4e4}]");
	strcat(string, "\n{7e98b6}4\t{a9c4e4}Rank Permissions");

	if(is_top_rank)
		format(string, sizeof(string), "%s\n{c9c9c9}5\t{a9c4e4}Move Up [{c9c9c9}IS TOP RANK{a9c4e4}]", string);
	else
	    format(string, sizeof(string), "%s\n{7e98b6}5\t{a9c4e4}Move Up [{7e98b6}From %d to %d{a9c4e4}]", string, rank + 1, rank);

	if(is_bottom_rank)
		format(string, sizeof(string), "%s\n{c9c9c9}6\t{a9c4e4}Move Down [{c9c9c9}IS BOTTOM RANK{a9c4e4}]", string);
	else
	    format(string, sizeof(string), "%s\n{7e98b6}6\t{a9c4e4}Move Down [{7e98b6}From %d to %d{a9c4e4}]", string, rank + 1, rank + 2);

	strcat(string, "\n{7e98b6}7\t{a9c4e4}Delete Rank");

	return Dialog_Show(playerid, FactionEdit_ModifyRank, DIALOG_STYLE_LIST, "Modify Rank", string, "Enter", "<< Back");
}

Dialog:FactionEdit_RankName(playerid, response, listitem, inputtext[])
{
	new factionid = PlayerData[playerid][pFactionEdit], rank = GetPVarInt(playerid, "ModifyFactionRank");

	if(response)
	{
		new string[128];

		if(isnull(inputtext))
		{
	    	format(string, sizeof(string), "{FFFFFF}Change rank name from {7e98b6}%s", FactionRanks[factionid][rank]);
	        return Dialog_Show(playerid, FactionEdit_RankName, DIALOG_STYLE_INPUT, "New Rank Name", string, "Enter", "<< Back");
		}

		format(FactionRanks[factionid][rank], 32, inputtext);
		Faction_SaveRanks(factionid);
	}
	return EditFactionRank(playerid, rank);
}

Dialog:FactionEdit_ModifyRank(playerid, response, listitem, inputtext[])
{
	if(response)
	{
	    new factionid = PlayerData[playerid][pFactionEdit], rank = GetPVarInt(playerid, "ModifyFactionRank"), string[128];

	    switch(listitem)
	    {
	        case 0: // Rank Name
	        {
	            format(string, sizeof(string), "{FFFFFF}Change rank name from {7e98b6}%s", FactionRanks[factionid][rank]);
	            return Dialog_Show(playerid, FactionEdit_RankName, DIALOG_STYLE_INPUT, "New Rank Name", string, "Enter", "<< Back");
	        }
	        case 1, 2, 3: // Rank Skin, Paycheck, Permissions (To Do)
	        {

	        }
	        case 4: // Move Up
	        {
	            if(rank == 0)
					return EditFactionRank(playerid, rank);

				format(string, sizeof(string), FactionRanks[factionid][rank]);

				format(FactionRanks[factionid][rank], 32, FactionRanks[factionid][rank - 1]);
				format(FactionRanks[factionid][rank - 1], 32, string);

				Faction_SaveRanks(factionid);
	        }
	        case 5: // Move Down
	        {
	            if(rank == 15)
				{
					return EditFactionRank(playerid, rank);
				}
				else
				{
		            if(!strlen(FactionRanks[factionid][rank + 1]))
		                return EditFactionRank(playerid, rank);
				}

				format(string, sizeof(string), FactionRanks[factionid][rank]);

				format(FactionRanks[factionid][rank], 32, FactionRanks[factionid][rank + 1]);
				format(FactionRanks[factionid][rank + 1], 32, string);

				Faction_SaveRanks(factionid);
	        }
			case 6: // Delete Rank
		    {
		        if(rank <= 2) // First three ranks can't be deleted
		        {
		            SendErrorMessage(playerid, "You can't delete this rank.");
		            return EditFactionRank(playerid, rank);
				}

		        new lastrank = rank - 1;

		        if(lastrank < 0) lastrank = 0;

				for(new i = rank; i < FactionData[factionid][factionRanks]; ++i)
				{
				    FactionRanks[factionid][i][0] = EOS;

				    if(i + 1 == FactionData[factionid][factionRanks]) break;

				    if(strlen(FactionRanks[factionid][i + 1]) > 0)
					{
					    format(FactionRanks[factionid][i], 32, FactionRanks[factionid][i + 1]);

					    lastrank = i;
					}
					else
					{
					    break;
					}
				}

		        foreach (new i : Player)
		        {
		            if(PlayerData[i][pFaction] == factionid && PlayerData[i][pFactionRank] == rank + 1)
		            {
		                PlayerData[i][pFactionRank] = lastrank + 1;

						SendClientMessageEx(i, COLOR_YELLOW, "You rank was deleted and now is %s.", FactionRanks[factionid][lastrank]);
		            }
				}

				format(string, sizeof(string), "UPDATE `characters` SET `FactionRank` = '%d' WHERE `Faction` = '%d' AND `FactionRank` = '%d'", lastrank + 1, FactionData[factionid][factionID], rank + 1);
				mysql_tquery(dbCon, string);

				Faction_SaveRanks(factionid);
		    }
		}
	}

	DeletePVar(playerid, "ModifyFactionRank");

	return ShowFactionRankMenu(playerid);
}

Dialog:FactionEdit_AddRank(playerid, response, listitem, inputtext[])
{
	if(response)
	{
	    if(isnull(inputtext))
	        return Dialog_Show(playerid, FactionEdit_AddRank, DIALOG_STYLE_INPUT, "Rank Name", "Write the name you wish to use for your new rank.\n\n{FF0000}You need to type in the rank name.", "Create", "<< Back");

	    new factionid = PlayerData[playerid][pFactionEdit], rank = 1;

		for(new i = 18; i >= 0; i--)
		{
			if(strlen(FactionRanks[factionid][i]) > 0)
			{
			    if(i + 1 <= 18) rank = i + 1;

				break;
			}
		}

		if(rank != -1)
		{
			format(FactionRanks[factionid][rank], 32, inputtext);
			Faction_SaveRanks(factionid);
		}
	}
	return ShowFactionRankMenu(playerid);
}

Dialog:FactionEdit_MaxMembers(playerid, response, listitem, inputtext[])
{
	if(response)
	{
	    new factionid = PlayerData[playerid][pFactionEdit], members = CountFactionMembers(factionid);

	    if(isnull(inputtext) || !IsNumeric(inputtext) || strval(inputtext) < members)
		{
		    new string[128];
			format(string, sizeof(string), "{FFFFFF}Change the factions max member count, currently %d\n\n(They currently have %d members.)", FactionData[factionid][factionMaxMembers], members);
			return Dialog_Show(playerid, FactionEdit_MaxMembers, DIALOG_STYLE_INPUT, "Max Members", string, "Enter", "<< Back");
		}

        FactionData[factionid][factionMaxMembers] = strval(inputtext);
        Faction_Save(factionid);
	}
	return ShowPlayerEditFaction(playerid);
}

Dialog:FactionEdit_MaxVehicles(playerid, response, listitem, inputtext[])
{
	if(response)
	{
	    new factionid = PlayerData[playerid][pFactionEdit], vehicles = CountFactionVehicles(factionid);

	    if(isnull(inputtext) || !IsNumeric(inputtext) || strval(inputtext) < vehicles)
		{
		    new string[128];
			format(string, sizeof(string), "{FFFFFF}Change the factions max vehicles count, currently %d\n\n(They currently have %d vehicles.)", FactionData[factionid][factionMaxVehicles], vehicles);
			return Dialog_Show(playerid, FactionEdit_MaxVehicles, DIALOG_STYLE_INPUT, "Max Vehicles", string, "Enter", "<< Back");
		}

        FactionData[factionid][factionMaxVehicles] = strval(inputtext);
        Faction_Save(factionid);
	}
	return ShowPlayerEditFaction(playerid);
}

Dialog:FactionEdit_Leader(playerid, response, listitem, inputtext[])
{
	if(response)
	{
	    new factionid = PlayerData[playerid][pFactionEdit];

	    if(strcmp(ReturnName(playerid), FactionData[factionid][factionLeader], false) > 0 && PlayerData[playerid][pAdmin] < 4)
	    {
			SendErrorMessage(playerid, "Permission denied.");
			return ShowPlayerEditFaction(playerid);
	    }

	    new
			userid
		;

	    if(sscanf(inputtext, "u", userid) || !IsPlayerConnected(userid))
	    {
	        new string[128];
			format(string, sizeof(string), "{FFFFFF}Change the factions founder from {7e98b6}%s", FactionData[factionid][factionLeader]);
			return Dialog_Show(playerid, FactionEdit_Leader, DIALOG_STYLE_INPUT, "New owner ID", string, "Enter", "<< Back");
		}

		format(FactionData[factionid][factionLeader], MAX_PLAYER_NAME, ReturnName(userid));
		Faction_Save(factionid);
	}
	return ShowPlayerEditFaction(playerid);
}

Dialog:FactionEdit_Type(playerid, response, listitem, inputtext[])
{
	if(response)
	{
	    new factionid = PlayerData[playerid][pFactionEdit];

	    if(strcmp(ReturnName(playerid), FactionData[factionid][factionLeader], false) > 0 && PlayerData[playerid][pAdmin] < 4)
	    {
			SendErrorMessage(playerid, "Permission denied.");
			return ShowPlayerEditFaction(playerid);
	    }

	    SendClientMessageEx(playerid, COLOR_YELLOW, "-> Changed faction ID %d's type to: %s", FactionData[factionid][factionID], GetFactionTypeName(listitem + 1));

	    FactionData[factionid][factionType] = listitem + 1;
	    Faction_Save(factionid);
	}
	return ShowPlayerEditFaction(playerid);
}

Dialog:FactionEdit(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new string[256], factionid = PlayerData[playerid][pFactionEdit];

		switch(listitem)
		{
			case 0: // Name
			{
				format(string, sizeof(string), "Change the faction name from {7e98b6}%s", FactionData[factionid][factionName]);
				Dialog_Show(playerid, FactionEdit_Name, DIALOG_STYLE_INPUT, "New name", string, "Enter", "<< Back");
			}
			case 1: // Short Name
			{
				format(string, sizeof(string), "Change the faction abbreviated (short) name from {7e98b6}%s", FactionData[factionid][factionAbbrv]);
				Dialog_Show(playerid, FactionEdit_ShortName, DIALOG_STYLE_INPUT, "New short name", string, "Enter", "<< Back");
			}
			case 2: // Chat Color
			{
			    format(string, sizeof(string), "{FFFFFF}Change the factions chat color from RGB/HEX {7e98b6}%06x\n\n{FFFFFF}Default faction color is  {01FCFF}01FCFF{FFFFFF}  and for law factions it's  {8D8DFF}8D8DFF", FactionData[factionid][factionColorChat] >>> 8);
                Dialog_Show(playerid, FactionEdit_ChatColor, DIALOG_STYLE_INPUT, "Chat Color", string, "Enter", "<< Back");
			}
	        case 3: // Spawn Point
	        {
	            format(string, sizeof(string), "{FFFFFF}Change the factions spawn point from {7e98b6}%.2f, %.2f, %.2f to current position?", FactionSpawns[factionid][0][factionSpawn][0], FactionSpawns[factionid][0][factionSpawn][1], FactionSpawns[factionid][0][factionSpawn][2]);
	            return Dialog_Show(playerid, FactionEdit_Spawn, DIALOG_STYLE_MSGBOX, "Change Spawn", string, "Yes", "<< Back");
	        }
			case 4: // Rank Administration
			{
				ShowFactionRankMenu(playerid);
			}
			case 5: // Faction Leader
			{
				format(string, sizeof(string), "{FFFFFF}Change the factions founder from {7e98b6}%s", FactionData[factionid][factionLeader]);
				Dialog_Show(playerid, FactionEdit_Leader, DIALOG_STYLE_INPUT, "New owner ID", string, "Enter", "<< Back");
			}
			case 6:
			{
			    for(new i = 1; i < 8; ++i)
			    {
					format(string, sizeof(string), "%s\n{7e98b6}%d\t{a9c4e4}%s", string, i, GetFactionTypeName(i));
				}

                Dialog_Show(playerid, FactionEdit_Type, DIALOG_STYLE_LIST, "Set Type", string, "Enter", "<< Back");
			}
			case 8: // Faction Tag Color
			{
			    format(string, sizeof(string), "{FFFFFF}Change the factions tag color from HEX {a9c4e4}%06x", FactionData[factionid][factionColor]);
			    Dialog_Show(playerid, FactionEdit_TagColor, DIALOG_STYLE_INPUT, "Tag Color", string, "Enter", "<< Back");
			}
			case 10: // Member Slots (resync)
			{
			    ShowPlayerEditFaction(playerid);
			}
			case 11: // Max Members
			{
				new members = CountFactionMembers(factionid);

				format(string, sizeof(string), "{FFFFFF}Change the factions max member count, currently %d\n\n(They currently have %d members.)", FactionData[factionid][factionMaxMembers], members);
				Dialog_Show(playerid, FactionEdit_MaxMembers, DIALOG_STYLE_INPUT, "Max Members", string, "Enter", "<< Back");
			}
			case 12: // Max Vehicles
			{
                new vehicles = CountFactionVehicles(factionid);

				format(string, sizeof(string), "{FFFFFF}Change the factions max vehicles count, currently %d\n\n(They currently have %d vehicles.)", FactionData[factionid][factionMaxVehicles], vehicles);
				Dialog_Show(playerid, FactionEdit_MaxVehicles, DIALOG_STYLE_INPUT, "Max Vehicles", string, "Enter", "<< Back");
			}
			default:
			{
			    ShowPlayerEditFaction(playerid);
			}
		}
	}
	else
	{
	    PlayerData[playerid][pFactionEdit] = -1;
	}

	return true;
}

Dialog:FactionSpawns(playerid, response, listitem, inputtext[])
{
	if(response)
	{
	    if(!strcmp(inputtext, "Add Spawn", true))
			return Dialog_Show(playerid, FactionSpawns_Add, DIALOG_STYLE_INPUT, "Change Name", "{FFFFFF}Create new spawn point {7e98b6}Name", "Yes", "<< Back");

		new idx = strval(inputtext) - 1;

		SetPVarInt(playerid, "EditingFactionSpawn", idx);

		return ShowFactionEditSpawn(playerid, idx);
	}
	else
	{
	    PlayerData[playerid][pFactionEdit] = -1;
	}

	return true;
}

Dialog:FactionSpawns_Add(playerid, response, listitem, inputtext[])
{
    new factionid = PlayerData[playerid][pFactionEdit];

	if(response)
	{
	    if(isnull(inputtext))
			return Dialog_Show(playerid, FactionSpawns_Add, DIALOG_STYLE_INPUT, "Change Name", "{FFFFFF}Create new spawn point {7e98b6}Name", "Yes", "<< Back");

	    new idx = -1;

		for(new i = 0; i < 5; ++i)
		{
		    if(FactionSpawns[factionid][i][spawnID] == 0)
		    {
                idx = i;
                break;
		    }
		}

	    if(idx != -1)
	    {
		    GetPlayerPos(playerid, FactionSpawns[factionid][idx][factionSpawn][0], FactionSpawns[factionid][idx][factionSpawn][1], FactionSpawns[factionid][idx][factionSpawn][2]);
		    GetPlayerFacingAngle(playerid, FactionSpawns[factionid][idx][factionSpawn][3]);

			FactionSpawns[factionid][idx][spawnInt] = GetPlayerInterior(playerid);
			FactionSpawns[factionid][idx][spawnWorld] = GetPlayerVirtualWorld(playerid);
			FactionSpawns[factionid][idx][spawnApartment] = -1;
			format(FactionSpawns[factionid][idx][spawnName], 64, inputtext);

			new query[500];

			mysql_format(dbCon, query, sizeof(query),"INSERT INTO factionspawns (factionID, SpawnX, SpawnY, SpawnZ, SpawnA, Interior, World, Name) VALUES ('%d', '%f', '%f', '%f', '%f', '%d', '%d', '%e') ",
			FactionData[factionid][factionID], FactionSpawns[factionid][idx][factionSpawn][0], FactionSpawns[factionid][idx][factionSpawn][1], FactionSpawns[factionid][idx][factionSpawn][2], FactionSpawns[factionid][idx][factionSpawn][3],
			FactionSpawns[factionid][idx][spawnInt], FactionSpawns[factionid][idx][spawnWorld], SQL_ReturnEscaped(FactionSpawns[factionid][idx][spawnName]));
			mysql_pquery(dbCon, query);

			FactionSpawns[factionid][idx][spawnID] = cache_insert_id();

			SendClientMessageEx(playerid, COLOR_YELLOW, "-> You have successfully created Spawn ID: %d", idx);
		}
	}

	return ShowFactionSpawns(playerid);
}

Dialog:FactionSpawns_Menu(playerid, response, listitem, inputtext[])
{
	if(response)
	{
	    new factionid = PlayerData[playerid][pFactionEdit], idx = GetPVarInt(playerid, "EditingFactionSpawn"), string[256];

	    switch(listitem)
	    {
			case 0:
			{
	            format(string, sizeof(string), "{FFFFFF}Change the factions spawn name from {7e98b6}%s", FactionSpawns[factionid][idx][spawnName]);
	            return Dialog_Show(playerid, FactionSpawns_Name, DIALOG_STYLE_INPUT, "Change Name", string, "Yes", "<< Back");
			}
			case 1:
			{
	            format(string, sizeof(string), "{FFFFFF}Change the factions spawn point from {7e98b6}%.2f, %.2f, %.2f to current position?", FactionSpawns[factionid][idx][factionSpawn][0], FactionSpawns[factionid][idx][factionSpawn][1], FactionSpawns[factionid][idx][factionSpawn][2]);
	            return Dialog_Show(playerid, FactionSpawns_Point, DIALOG_STYLE_MSGBOX, "Change Spawn", string, "Yes", "<< Back");
			}
			case 2:
			{
			    if(idx == 0)
				{
					SendErrorMessage(playerid, "You can't delete the primary spawn.");
					return ShowFactionEditSpawn(playerid, idx);
				}

				format(string, sizeof(string), "DELETE FROM `factionspawns` WHERE `factionID` = '%d' AND `id` = '%d'", FactionData[factionid][factionID], FactionSpawns[factionid][idx][spawnID]);
				mysql_tquery(dbCon, string);

				FactionSpawns[factionid][idx][spawnID] = 0;

			    SendClientMessageEx(playerid, COLOR_YELLOW, "-> You have successfully deleted Spawn ID: %d", FactionSpawns);

			    return ShowFactionSpawns(playerid);
			}
		}
	}
	else
	{
		DeletePVar(playerid, "EditingFactionSpawn");

		ShowFactionSpawns(playerid);
	}

	return true;
}

Dialog:FactionSpawns_Name(playerid, response, listitem, inputtext[])
{
    new factionid = PlayerData[playerid][pFactionEdit], idx = GetPVarInt(playerid, "EditingFactionSpawn");

	if(response)
	{
	    new string[256];

	    if(isnull(inputtext))
	    {
     		format(string, sizeof(string), "{FFFFFF}Change the factions spawn name from {7e98b6}%s", FactionSpawns[factionid][idx][spawnName]);
     		return Dialog_Show(playerid, FactionSpawns_Name, DIALOG_STYLE_INPUT, "Change Name", string, "Yes", "<< Back");
		}

		format(FactionSpawns[factionid][idx][spawnName], 64, inputtext);
		Faction_SaveSpawnID(factionid, idx);
	}

	return ShowFactionEditSpawn(playerid, idx);
}

Dialog:FactionSpawns_Point(playerid, response, listitem, inputtext[])
{
    new factionid = PlayerData[playerid][pFactionEdit], idx = GetPVarInt(playerid, "EditingFactionSpawn");

	if(response)
	{
		GetPlayerPos(playerid, FactionSpawns[factionid][idx][factionSpawn][0], FactionSpawns[factionid][idx][factionSpawn][1], FactionSpawns[factionid][idx][factionSpawn][2]);

		SendClientMessageEx(playerid, COLOR_YELLOW, "-> Changed faction ID %d's spawn point %d to: %.2f, %.2f, %.2f", FactionData[factionid][factionID], idx + 1, FactionSpawns[factionid][idx][factionSpawn][0], FactionSpawns[factionid][idx][factionSpawn][1], FactionSpawns[factionid][idx][factionSpawn][2]);

		FactionSpawns[factionid][idx][spawnInt] = GetPlayerInterior(playerid);
		FactionSpawns[factionid][idx][spawnWorld] = GetPlayerVirtualWorld(playerid);
		FactionSpawns[factionid][idx][spawnApartment] = InApartment[playerid];

		Faction_SaveSpawnID(factionid, idx);
	}

	return ShowFactionEditSpawn(playerid, idx);
}


Dialog:FactionsList(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new menu[10];

		//Navigate
		if(listitem != 0 && listitem != 11)
		{
			new str_biz[8];
			format(str_biz, 10, "menu%d", listitem);

			PlayerData[playerid][pFactionEdit] = GetPVarInt(playerid, str_biz);

			ShowPlayerEditFaction(playerid);
			return true;
		}

		new currentPage = GetPVarInt(playerid, "page");

		if(!listitem)
		{
			if(currentPage > 1)
			{
				currentPage --;
			}
		}
		else if(listitem == 11)
		{
			currentPage ++;
		}

		new count, skipitem = (currentPage - 1) * 10;

		gstr[0] = EOS;

		format(gstr, sizeof(gstr), "%s{B4B5B7}Page %d{FFFFFF}\n", gstr, (currentPage == 1) ? 1 : currentPage - 1);

		SetPVarInt(playerid, "page", currentPage);

		for(new i = 0; i != MAX_FACTIONS; ++i)
		{
			if(FactionData[i][factionExists])
			{
				if(skipitem)
				{
					skipitem --;
					continue;
				}

				if(count == 10)
				{
					format(gstr, sizeof(gstr), "%s{B4B5B7}Page 2{FFFFFF}\n", gstr);
					break;
				}

				format(menu, 10, "menu %d", count + 1);

				SetPVarInt(playerid, menu, i);

				format(gstr, sizeof(gstr), "%s{FFFFFF}Faction ({FFBF00}%i{FFFFFF}) | %s\n", gstr, i, FactionData[i][factionName]);
			}
		}

		Dialog_Show(playerid, FactionsList, DIALOG_STYLE_LIST, "Factions List", gstr, "Edit", "Back");
	}
	return true;
}