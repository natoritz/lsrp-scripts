// Functions

public OnQueryError(errorid, const error[], const callback[], const query[], MySQL:handle)
{
	format(sgstr, sizeof(sgstr), "AdmWarn: [MySQL]: (%s) %s.", (callback[0]) ? (callback) : ("n/a"), error);

	foreach (new i : Player)
	{
		if(PlayerData[i][pAdmin] == 1337)
		{
		    if(strlen(sgstr) > 80)
			{
			   	SendClientMessageEx(i, COLOR_LIGHTRED, "%.80s", sgstr);
			    SendClientMessageEx(i, COLOR_LIGHTRED, "%s", sgstr[80]);
			}
			else SendClientMessage(i, COLOR_LIGHTRED, sgstr);
		}
	}

	printf(sgstr);
	return true;
}

SQL_Connect()
{
	new MySQLOpt:options = mysql_init_options();
	mysql_set_option(options, AUTO_RECONNECT, true);
	//mysql_set_option(options, POOL_SIZE, 3);	
	dbCon = mysql_connect(SQL_HOSTNAME, SQL_USERNAME, SQL_PASSWORD, SQL_DATABASE, options);

	if(mysql_errno(dbCon))
		printf("[SQL] Connection to \"%s\" failed! Please check the connection settings...\a", SQL_HOSTNAME);
	else
		printf("[SQL] Connection to \"%s\" passed!", SQL_HOSTNAME);

	return true;
}

SQL_CheckAccount(playerid)
{
	new query[160];

    mysql_format(dbCon, query, sizeof(query), "SELECT `ID`, `Username`, `Admin`, `Email`, `SecretWord`, `LoginDate`, `AdminNote`, `Serial` FROM `accounts` WHERE `Username` = '%e'", ReturnName(playerid));
	mysql_tquery(dbCon, query, "OnQueryFinished", "dd", playerid, THREAD_FIND_ACCOUNT);
}

SQL_CheckBanAccount(playerid)
{
	new query[256];

	format(query, sizeof(query), "SELECT * FROM `bans` WHERE (name = '%s' AND perm = 1) OR (name = '%s' AND expire > NOW() AND perm = 0) OR (playerIP = '%s' AND perm = 1) OR (playerIP = '%s' AND expire > NOW() AND perm = 0)", ReturnName(playerid), ReturnName(playerid), PlayerData[playerid][pIP], PlayerData[playerid][pIP]);
	mysql_tquery(dbCon, query, "OnQueryFinished", "dd", playerid, THREAD_BAN_LOOKUP);
}

SQL_LoadCharacters(playerid)
{
	mysql_format(dbCon, gquery, sizeof(gquery), "SELECT `ID`, `char_name`, `Level`, `Model` FROM `characters` WHERE `master` = '%d' LIMIT 6", AccountData[playerid][aUserid]);
	mysql_tquery(dbCon, gquery, "OnQueryFinished", "dd", playerid, THREAD_CHECK_CHARACTER);
}

SQL_CreateCharacter(playerid, const character[])
{
	new query[300], phoneNumber = randomEx(100000, 999999);
	
	mysql_format(dbCon, query, sizeof(query), "INSERT INTO `characters` (master, char_name, PhoneNumbr, Activated) VALUES (%d, '%e', %d, 1)", AccountData[playerid][aUserid], character, phoneNumber);
    mysql_tquery(dbCon, query, "OnQueryFinished", "dd", playerid, THREAD_CREATE_CHARACTER);
}

SQL_AttemptLogin(playerid, const password[])
{
	new query[300], buffer[129];
	WP_Hash(buffer, sizeof(buffer), password);

	mysql_format(dbCon, query, sizeof(query), "SELECT Null FROM `accounts` WHERE `Username` = '%e' AND `Password` = '%e'", ReturnName(playerid), buffer);
    mysql_tquery(dbCon, query, "OnQueryFinished", "dd", playerid, THREAD_LOGIN);
}

SQL_SecretLogin(playerid, password[])
{
	new query[256];

	mysql_format(dbCon, query, sizeof(query), "SELECT Null FROM `accounts` WHERE `Username` = '%s' AND `SecretWord` = '%e'", ReturnName(playerid), password);
	mysql_tquery(dbCon, query, "OnQueryFinished", "dd", playerid, THREAD_SECRET_CONFIRM);
}

SQL_LogConnection(playerid)
{
	new query[256];

	mysql_format(dbCon, query, sizeof(query), "INSERT INTO logs_connection (master, ip, serial) VALUES ('%e', '%e', '%e')", ReturnName(playerid), PlayerData[playerid][pIP], PlayerSerial[playerid]);
	mysql_tquery(dbCon, query, "OnQueryFinished", "dd", playerid, THREAD_LOG_CON);
}

SQL_LogGraffiti(graffiti, const fmat[], va_args<>)
{
	new str[145], query[256];
	va_format(str, sizeof (str), fmat, va_start<2>);

	mysql_format(dbCon, query, sizeof(query), "INSERT INTO `logs_spray` (SprayID, Log, Timestamp) VALUES (%d, '%e', %d)", graffiti, SQL_ReturnEscaped(str), gettime());
	return mysql_pquery(dbCon, query);
}

SQL_LogAction(playerid, const fmat[], va_args<>)
{
	new str[145], query[256];
	va_format(str, sizeof (str), fmat, va_start<2>);

	mysql_format(dbCon, query, sizeof(query), "INSERT INTO `logs_all` (User, Log, Timestamp) VALUES (%d, '%e', %d)", PlayerData[playerid][pID], str, gettime());
	return mysql_pquery(dbCon, query);
}

SQL_LogPlayerDeath(playerid, killerid, reason)
{
    new str[256], playerName[MAX_PLAYER_NAME];
	ReturnCharacterName(playerid, playerName);

	if(killerid == INVALID_PLAYER_ID)
	{
		mysql_format(dbCon, str, sizeof(str), "INSERT INTO logs_death (killer, victim, reason, killerid, victimid) VALUES ('N/A', '%e', '%d', '-1', '%d')", playerName, reason, AccountData[playerid][aUserid]);
		mysql_pquery(dbCon, str);
		return true;
	}

	new killerName[MAX_PLAYER_NAME];
	ReturnCharacterName(killerid, killerName);

	mysql_format(dbCon, str, sizeof(str), "INSERT INTO logs_death (killer, victim, reason, killerid, victimid) VALUES ('%e', '%e', '%d', '%d', '%d')", killerName, playerName, reason, AccountData[killerid][aUserid], AccountData[playerid][aUserid]);
	mysql_pquery(dbCon, str);
	return true;
}

/*SQL_LogCheat(playerid, const key[], const log[])
{
	new query[512];

	new clean_log[256];
	mysql_escape_string(log, clean_log);

	new clean_key[20];
	mysql_escape_string(key, clean_key);

	format(query, sizeof(query), "INSERT INTO logs_cheat (admin, master_name, char_name, action_key, action_log, stamp) VALUES (%d, '%s', '%s', '%s', '%s', %d)", AccountData[playerid][aUserid], AccountData[playerid][aUsername], ReturnName(playerid), clean_key, clean_log, gettime());
	mysql_pquery(dbCon, query);

    format(query, sizeof(query), "[%s] %s (%s)", ConverTimestampToDate(gettime()), log, key);

	Log_Write("RawLogs/cheats.txt", query);

	//if(!systemVariables[DiscordStatus]) DCC_SendChannelMessage(cheatLogsChannel, query);
}*/

SQL_LogMask(playerid, const key[], const log[])
{
	new query[512];
	mysql_format(dbCon, query,sizeof(query), "INSERT INTO logs_mask (admin, action_key, action_log) VALUES (%d, '%e', '%e')", PlayerData[playerid][pID], key, log);
	mysql_pquery(dbCon, query);
}

SQL_ReturnEscaped(const string[])
{
	new
	    entry[256]
	;

	mysql_escape_string(string, entry);
	return entry;
}

// Callbacks

forward Faction_Load();
public Faction_Load()
{
	new
	    rows,
	    rank[16],
		str[32];

	cache_get_row_count(rows);

	for(new i = 0; i < rows; ++i)
	{
		if(i < MAX_FACTIONS)
		{
		    FactionData[i][factionExists] = true;
			
			cache_get_value_name_int(i, "factionID", FactionData[i][factionID]);
		    cache_get_value_name(i, "factionName", FactionData[i][factionName], 60);
		    cache_get_value_name(i, "factionShort", FactionData[i][factionAbbrv], 20);
		    cache_get_value_name(i, "factionLeader", FactionData[i][factionLeader], MAX_PLAYER_NAME);
			cache_get_value_name_int(i, "factionColor", FactionData[i][factionColor]);
			cache_get_value_name_int(i, "factionColorChat", FactionData[i][factionColorChat]);
			cache_get_value_name_int(i, "factionType", FactionData[i][factionType]);
			cache_get_value_name_int(i, "factionRanks", FactionData[i][factionRanks]);
			cache_get_value_name_int(i, "factionMaxMembers", FactionData[i][factionMaxMembers]);
	        cache_get_value_name_int(i, "factionMaxVehicles", FactionData[i][factionMaxVehicles]);

			for(new j = 0; j < 19; ++j)
			{
			    format(rank, sizeof(rank), "factionRank%d", j + 1);
			    cache_get_value_name(i, rank, str);
			    format(FactionRanks[i][j], 32, str);
			}
		}
	}

	printf("[SERVER]: %d factions were loaded from \"%s\" database...", rows, SQL_DATABASE);
	return true;
}

FUNX::FactionSpawn_Load()
{
	new faction = -1, count[MAX_FACTIONS];

	for(new i = 0; i < MAX_FACTIONS; ++i) count[i] = 0;

 	//for(new i = 0; i < rows; ++i)

 	new rows = cache_num_rows();

 	for(new i = 0; i < rows; ++i)
	{
        faction = -1;

	    new temp;
	    cache_get_value_name_int(i, "factionID", temp);

	    for(new f = 0; f != MAX_FACTIONS; ++f)
		{
			if(!FactionData[f][factionExists]) continue;

			if(FactionData[f][factionID] == temp)
			{
			    faction = f;
			    break;
			}
		}

		if(faction == -1)
		{
			printf("failed to load faction spawn %d for fac id %d", count[faction], temp);
			continue;
		}

		cache_get_value_name_int(i, "id", FactionSpawns[faction][ count[faction] ][spawnID]);
		cache_get_value_name_float(i, "SpawnX", FactionSpawns[faction][ count[faction] ][factionSpawn][0]);
		cache_get_value_name_float(i, "SpawnY", FactionSpawns[faction][ count[faction] ][factionSpawn][1]);
		cache_get_value_name_float(i, "SpawnZ", FactionSpawns[faction][ count[faction] ][factionSpawn][2]);
		cache_get_value_name_float(i, "SpawnA", FactionSpawns[faction][ count[faction] ][factionSpawn][3]);

		cache_get_value_name_int(i, "Interior", FactionSpawns[faction][ count[faction] ][spawnInt]);
		cache_get_value_name_int(i, "World", FactionSpawns[faction][ count[faction] ][spawnWorld]);
		cache_get_value_name_int(i, "Apartment", FactionSpawns[faction][ count[faction] ][spawnApartment]);
		//cache_get_value_name_int(i, "Local", FactionSpawns[faction][ count[faction] ][spawnLocal]);

		cache_get_value_name(i, "Name", FactionSpawns[faction][ count[faction] ][spawnName], 64);

		count[faction] ++;
	}

	printf("[SERVER]: %d faction spawns were loaded from \"%s\" database...", rows, SQL_DATABASE);
	return true;
}

forward Bizz_Load();
public Bizz_Load()
{
	new
	    str[256],
	    rows;

	cache_get_row_count(rows);

	for(new i = 0; i < rows; ++i) if(i < MAX_BUSINESS)
	{
		cache_get_value_name_int(i, "biz_id", BusinessData[i][bID]);
		cache_get_value_name_int(i, "biz_owned", BusinessData[i][bOwned]);

		cache_get_value_name(i, "biz_owner", str);
		format(BusinessData[i][bOwner], 24, str);

		cache_get_value_name(i, "biz_info", str);
		format(BusinessData[i][bInfo], 80, str);

		cache_get_value_name(i, "biz_items", str);
		Business_AssignItems(i, str);

		cache_get_value_name_int(i, "biz_type", BusinessData[i][bType]);
		cache_get_value_name_int(i, "biz_subtype", BusinessData[i][bsubType]);
		cache_get_value_name_float(i, "biz_enX", BusinessData[i][bEntranceX]);
		cache_get_value_name_float(i, "biz_enY", BusinessData[i][bEntranceY]);
		cache_get_value_name_float(i, "biz_enZ", BusinessData[i][bEntranceZ]);
		cache_get_value_name_float(i, "biz_etX", BusinessData[i][bExitX]);
		cache_get_value_name_float(i, "biz_etY", BusinessData[i][bExitY]);
		cache_get_value_name_float(i, "biz_etZ", BusinessData[i][bExitZ]);
		cache_get_value_name_int(i, "biz_level", BusinessData[i][bLevelNeeded]);
		cache_get_value_name_int(i, "biz_price", BusinessData[i][bBuyPrice]);
		cache_get_value_name_int(i, "biz_encost", BusinessData[i][bEntranceCost]);
		cache_get_value_name_int(i, "biz_till", BusinessData[i][bTill]);
		cache_get_value_name_int(i, "biz_locked", BusinessData[i][bLocked]);
		cache_get_value_name_int(i, "biz_interior", BusinessData[i][bInterior]);
		cache_get_value_name_int(i, "biz_world", BusinessData[i][bWorld]);
		cache_get_value_name_int(i, "biz_prod", BusinessData[i][bProducts]);
		cache_get_value_name_int(i, "biz_maxprod", BusinessData[i][bMaxProducts]);
		cache_get_value_name_int(i, "biz_priceprod", BusinessData[i][bPriceProd]);
		cache_get_value_name_float(i, "biz_carX", BusinessData[i][bBuyingCarX]);
		cache_get_value_name_float(i, "biz_carY", BusinessData[i][bBuyingCarY]);
		cache_get_value_name_float(i, "biz_carZ", BusinessData[i][bBuyingCarZ]);
		cache_get_value_name_float(i, "biz_carA", BusinessData[i][bBuyingCarA]);
		cache_get_value_name_float(i, "biz_boatX", BusinessData[i][bBuyingBoatX]);
		cache_get_value_name_float(i, "biz_boatY", BusinessData[i][bBuyingBoatY]);
		cache_get_value_name_float(i, "biz_boatZ", BusinessData[i][bBuyingBoatZ]);
		cache_get_value_name_float(i, "biz_boatA", BusinessData[i][bBuyingBoatA]);
		cache_get_value_name_float(i, "biz_airX", BusinessData[i][bBuyingAirX]);
		cache_get_value_name_float(i, "biz_airY", BusinessData[i][bBuyingAirY]);
		cache_get_value_name_float(i, "biz_airZ", BusinessData[i][bBuyingAirZ]);
		cache_get_value_name_float(i, "biz_airA", BusinessData[i][bBuyingAirA]);

		Business_Refresh(i);

		Iter_Add(Business, i);
	}

    foreach (new i: Business)
    {
        LoadBizFurnitures(i);
    }

	printf("[SERVER]: %d businesses were loaded from \"%s\" database...", rows, SQL_DATABASE);
	return true;
}

forward Signal_Load();
public Signal_Load()
{
    new
	    rows,
		string[64];

    cache_get_row_count(rows);

	for(new i = 0; i < rows; ++i)
	{
		if(i < MAX_SIGNALTOWER)
		{
			cache_get_value_name_int(i, "id", SignalData[i][signalID]);
		    SignalData[i][signalExists] = true;
			cache_get_value_name_float(i, "t_posX", SignalData[i][signalX]);
			cache_get_value_name_float(i, "t_posY", SignalData[i][signalY]);
			cache_get_value_name_float(i, "t_posZ", SignalData[i][signalZ]);
			cache_get_value_name_float(i, "t_range", SignalData[i][signalRange]);

		    cache_get_value_name(i, "t_name", string);
		    format(SignalData[i][signalName], 64, string);
		    //SignalData[i][signalObject] = CreateDynamicObject(13758, SignalData[i][signalX], SignalData[i][signalY], SignalData[i][signalZ], 0.00, 0.00, 0.00);
		}
	}
}

forward Vehicle_Load();
public Vehicle_Load()
{
    new
	    rows,
	    bool: success = true;

	cache_get_row_count(rows);

	for(new i = 0; i < rows; ++i)
	{
        if(systemVariables[vehicleCounts][0] + systemVariables[vehicleCounts][1] + systemVariables[vehicleCounts][2] < MAX_VEHICLES)
		{
			cache_get_value_name_int(i, "vehicleID", vehicleVariables[i][vVehicleID]);
			cache_get_value_name_int(i, "vehicleModelID", vehicleVariables[i][vVehicleModelID]);

			cache_get_value_name_float(i, "vehiclePosX", vehicleVariables[i][vVehiclePosition][0]);
			cache_get_value_name_float(i, "vehiclePosY", vehicleVariables[i][vVehiclePosition][1]);
			cache_get_value_name_float(i, "vehiclePosZ", vehicleVariables[i][vVehiclePosition][2]);
			cache_get_value_name_float(i, "vehiclePosRotation", vehicleVariables[i][vVehicleRotation]);

			cache_get_value_name_int(i, "vehicleFaction", vehicleVariables[i][vVehicleFaction]);
			cache_get_value_name_int(i, "vehicleCol1", vehicleVariables[i][vVehicleColour][0]);
			cache_get_value_name_int(i, "vehicleCol2", vehicleVariables[i][vVehicleColour][1]);
			cache_get_value_name_int(i, "vehicleSiren", vehicleVariables[i][vVehicleSiren]);

			cache_get_value_name(i, "vehiclePlate", vehicleVariables[i][vVehiclePlate]);
			cache_get_value_name(i, "vehicleSign", vehicleVariables[i][vVehicleCarsign]);

			Iter_Add(sv_servercar, i);

			if(vehicleVariables[i][vVehicleColour][0] < 0)
			{
				vehicleVariables[i][vVehicleColour][0] = random(126);
			}

			if(vehicleVariables[i][vVehicleColour][1] < 0)
			{
				vehicleVariables[i][vVehicleColour][1] = random(126);
			}

			vehicleVariables[i][vVehicleScriptID] = CreateVehicle(vehicleVariables[i][vVehicleModelID], vehicleVariables[i][vVehiclePosition][0], vehicleVariables[i][vVehiclePosition][1], vehicleVariables[i][vVehiclePosition][2], vehicleVariables[i][vVehicleRotation], vehicleVariables[i][vVehicleColour][0], vehicleVariables[i][vVehicleColour][1], 60000, vehicleVariables[i][vVehicleSiren]);
			ResetVehicle(vehicleVariables[i][vVehicleScriptID]);

			if(!isnull(vehicleVariables[i][vVehicleCarsign]))
			{
			    new vehicleid = vehicleVariables[i][vVehicleScriptID];

				CoreVehicles[vehicleid][vehSignText] = Create3DTextLabel(vehicleVariables[i][vVehicleCarsign], COLOR_WHITE, 0.0, 0.0, 0.0, 25.0, 0, 0);
				Attach3DTextLabelToVehicle(CoreVehicles[vehicleid][vehSignText], vehicleid, -0.7, -1.9, -0.3);

				CoreVehicles[vehicleid][vehSign] = 1;
			}

			if(vehicleVariables[i][vVehicleFaction] != -1)
			{
			    if(isnull(vehicleVariables[i][vVehiclePlate]))
			    {
					SetVehicleNumberPlate(vehicleVariables[i][vVehicleScriptID], GetInitials(FactionData[vehicleVariables[i][vVehicleFaction]][factionName]));
				}
				else
				{
					SetVehicleNumberPlate(vehicleVariables[i][vVehicleScriptID], vehicleVariables[i][vVehiclePlate]);
				}
			}
			else
			{
				new plate[8];
				format(plate, 8, "%s", RandomVehiclePlate());
				SetVehicleNumberPlate(vehicleVariables[i][vVehicleScriptID], plate);
			}

    		Iter_Add(sv_vehicles, vehicleVariables[i][vVehicleScriptID]);

			SetVehicleHealth(vehicleVariables[i][vVehicleScriptID], GetVehicleDataHealth(vehicleVariables[i][vVehicleModelID]));

			systemVariables[vehicleCounts][0]++;
		}
		else
		{
			success = false;
			printf("ERROR: Vehicle limit reached (MODEL %d, VEHICLEID %d, MAXIMUM %d, TYPE STATIC) [01x08]", vehicleVariables[i][vVehicleModelID], i, MAX_VEHICLES);
		}
	}

	if(success) printf("[SERVER]: %d vehicles were loaded from \"%s\" database...", systemVariables[vehicleCounts][0], SQL_DATABASE);

	return true;
}

forward DynamicTele_Load();
public DynamicTele_Load()
{
    new rows, total;

    cache_get_row_count(rows);

    if(rows)
    {
		for(new i = 0; i < rows; ++i)
		{
			cache_get_value_index_int(i, 0, Teleports[i][aID]);
			cache_get_value_index(i, 1, Teleports[i][aMapName], 32);
			cache_get_value_index_float(i, 2, Teleports[i][aPosX]);
			cache_get_value_index_float(i, 3, Teleports[i][aPosY]);
			cache_get_value_index_float(i, 4, Teleports[i][aPosZ]);

			cache_get_value_index_int(i, 5, Teleports[i][aInterior]);

			Teleports[i][aTeleOn] = 1;
            total++;
		}
    }

    printf("[SERVER]: %d admin teleports were loaded from \"%s\" database...", total, SQL_DATABASE);
    return 1;
}

forward OnTeleportInsert(TeleID);
public OnTeleportInsert(TeleID)
{
	Teleports[TeleID][aID] = cache_insert_id();
	return true;
}

forward Industry_Load();
public Industry_Load()
{
    new rows, total, msg[128];

    cache_get_row_count(rows);

    if(rows)
    {
		for(new i = 0; i < rows; ++i) if(i < MAX_ITEM_STORAGE)
		{
			cache_get_value_index_int(i, 0, StorageData[i][in_id]);
			cache_get_value_index_float(i, 1, StorageData[i][in_posx]);
			cache_get_value_index_float(i, 2, StorageData[i][in_posy]);
			cache_get_value_index_float(i, 3, StorageData[i][in_posz]);
			cache_get_value_index_int(i, 4, StorageData[i][in_item]);
			cache_get_value_index_int(i, 5, StorageData[i][in_industryid]);
			cache_get_value_index_int(i, 6, StorageData[i][in_trading_type]);
			cache_get_value_index_int(i, 7, StorageData[i][in_price]);
			cache_get_value_index_int(i, 8, StorageData[i][in_consumption]);
			cache_get_value_index_int(i, 9, StorageData[i][in_stock]);
			cache_get_value_index_int(i, 10, StorageData[i][in_maximum]);

			//if(StorageData[i][in_item] == 23) printf("%d", i);

			if(!IndustryData[StorageData[i][in_industryid]][in_close])
			{
				StorageData[i][in_pickup] = CreateDynamicPickup(1318, 23, StorageData[i][in_posx], StorageData[i][in_posy], StorageData[i][in_posz], 0, 0);

				format(msg, 128, "[{E5FF00}%s{FFFFFF}]\nStorage: %d / %d\nPrice: %s / unit", GetBusinessCargoDesc(StorageData[i][in_item]), StorageData[i][in_stock], StorageData[i][in_maximum], FormatNumber(StorageData[i][in_price]));
				StorageData[i][in_label] = CreateDynamic3DTextLabel(msg, -1, StorageData[i][in_posx], StorageData[i][in_posy], StorageData[i][in_posz], 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, 100.0);
			}
            total++;

            Iter_Add(Industry, i);
		}
    }

    printf("[SERVER]: %d storages were loaded from \"%s\" database...", total, SQL_DATABASE);
    return 1;
}

forward Gates_Load();
public Gates_Load()
{
	new
	    rows,
		str[64],
		total;

	cache_get_row_count(rows);

	for(new i = 0; i < rows; ++i) if(i < MAX_GATES)
	{
        cache_get_value_index_int(i, 0, Gates[i][gateID]);
        cache_get_value_index_int(i, 1, Gates[i][gateModel]);
        cache_get_value_index_int(i, 2, Gates[i][gateFaction]);

        cache_get_value_index_float(i, 3, Gates[i][gatePosX]);
        cache_get_value_index_float(i, 4, Gates[i][gatePosY]);
        cache_get_value_index_float(i, 5, Gates[i][gatePosZ]);
        cache_get_value_index_float(i, 6, Gates[i][gatePosRX]);
        cache_get_value_index_float(i, 7, Gates[i][gatePosRY]);
        cache_get_value_index_float(i, 8, Gates[i][gatePosRZ]);

        cache_get_value_index_int(i, 9, Gates[i][gateInterior]);
        cache_get_value_index_int(i, 10, Gates[i][gateVirtualWorld]);

        cache_get_value_index(i, 11, str);
        format(Gates[i][gateName], 64, "%s", str);

        cache_get_value_index_float(i, 12, Gates[i][gateOpenSpeed]);
        cache_get_value_index_float(i, 13, Gates[i][gateMoveX]);
        cache_get_value_index_float(i, 14, Gates[i][gateMoveY]);
        cache_get_value_index_float(i, 15, Gates[i][gateMoveZ]);

        cache_get_value_index_float(i, 16, Gates[i][gateMoveRX]);
        cache_get_value_index_float(i, 17, Gates[i][gateMoveRY]);
        cache_get_value_index_float(i, 18, Gates[i][gateMoveRZ]);

		Gates[i][gateObject] = CreateDynamicObject(Gates[i][gateModel], Gates[i][gatePosX], Gates[i][gatePosY], Gates[i][gatePosZ], Gates[i][gatePosRX], Gates[i][gatePosRY], Gates[i][gatePosRZ], -1, -1, -1, 200.0);

		Iter_Add(Gates, i);

		total++;
	}

	printf("[SERVER]: %d dynamic gates were loaded from \"%s\" database...", total, SQL_DATABASE);
	return true;
}

forward Movedoor_Load();
public Movedoor_Load()
{
	new
	    rows,
		str[64],
		total;

	cache_get_row_count(rows);

	for(new i = 0; i < rows; ++i) if(i < MAX_MOVEDOORS)
	{
        cache_get_value_index_int(i, 0, Doors[i][doorID]);
        cache_get_value_index_int(i, 1, Doors[i][doorModel]);
        cache_get_value_index_int(i, 2, Doors[i][doorFaction]);

        cache_get_value_index_float(i, 3, Doors[i][doorPosX]);
        cache_get_value_index_float(i, 4, Doors[i][doorPosY]);
        cache_get_value_index_float(i, 5, Doors[i][doorPosZ]);
        cache_get_value_index_float(i, 6, Doors[i][doorPosRX]);
        cache_get_value_index_float(i, 7, Doors[i][doorPosRY]);
        cache_get_value_index_float(i, 8, Doors[i][doorPosRZ]);

        cache_get_value_index_int(i, 9, Doors[i][doorInterior]);
        cache_get_value_index_int(i, 10, Doors[i][doorVirtualWorld]);

        cache_get_value_index(i, 11, str);
        format(Doors[i][doorName], 64, "%s", str);

        cache_get_value_index_float(i, 12, Doors[i][doorOpenSpeed]);
        cache_get_value_index_float(i, 13, Doors[i][doorMoveX]);
        cache_get_value_index_float(i, 14, Doors[i][doorMoveY]);
        cache_get_value_index_float(i, 15, Doors[i][doorMoveZ]);

        cache_get_value_index_float(i, 16, Doors[i][doorMoveRX]);
        cache_get_value_index_float(i, 17, Doors[i][doorMoveRY]);
        cache_get_value_index_float(i, 18, Doors[i][doorMoveRZ]);

		Doors[i][doorObject] = CreateDynamicObject(Doors[i][doorModel], Doors[i][doorPosX], Doors[i][doorPosY], Doors[i][doorPosZ], Doors[i][doorPosRX], Doors[i][doorPosRY], Doors[i][doorPosRZ], -1, -1, -1, 200.0);

		Iter_Add(Movedoors, i);

		total++;
	}

	printf("[SERVER]: %d dynamic movable doors were loaded from \"%s\" database...", total, SQL_DATABASE);
	return true;
}

forward Apartment_Load();
public Apartment_Load()
{
    new rows, totals;

    cache_get_row_count(rows);

    if(rows)
    {
		for(new i = 0; i < rows; ++i)
		{
			cache_get_value_name_int(i, "ID", ComplexData[i][aID]);
			cache_get_value_name_float(i, "ePosX", ComplexData[i][aEntranceX]);
			cache_get_value_name_float(i, "ePosY", ComplexData[i][aEntranceY]);
			cache_get_value_name_float(i, "ePosZ", ComplexData[i][aEntranceZ]);
			cache_get_value_name_float(i, "iPosX", ComplexData[i][aExitX]);
			cache_get_value_name_float(i, "iPosY", ComplexData[i][aExitY]);
			cache_get_value_name_float(i, "iPosZ", ComplexData[i][aExitZ]);
			cache_get_value_name_int(i, "interior", ComplexData[i][aInterior]);
			cache_get_value_name_int(i, "world", ComplexData[i][aWorld]);

			cache_get_value_name(i, "name", ComplexData[i][aInfo], 128);
			cache_get_value_name(i, "owner", ComplexData[i][aOwner], MAX_PLAYER_NAME);

			cache_get_value_name_int(i, "ownerSQLID", ComplexData[i][aOwnerSQLID]);
			cache_get_value_name_int(i, "owned", ComplexData[i][aOwned]);
			cache_get_value_name_int(i, "locked", ComplexData[i][aLocked]);
			cache_get_value_name_int(i, "price", ComplexData[i][aPrice]);
			cache_get_value_name_int(i, "levelbuy", ComplexData[i][aLevelbuy]);
			cache_get_value_name_int(i, "faction", ComplexData[i][aFaction]);
			cache_get_value_name_int(i, "pickup", ComplexData[i][aPickupEnabled]);

			ComplexData[i][aInterior] = i + 1;

            if(!ComplexData[i][aWorld] || ComplexData[i][aWorld] != i + LOCAL_APARTMENT)
            {
                ComplexData[i][aWorld] = i + LOCAL_APARTMENT;
            }

            Complex_Refresh(i);

			ComplexData[i][aDynamicArea] = CreateDynamicSphere(ComplexData[i][aEntranceX], ComplexData[i][aEntranceY], ComplexData[i][aEntranceZ], 3.0, 0, 0, -1);
			AssignDynamicAreaValue(ComplexData[i][aDynamicArea], AREA_TYPE_COMPLEX, i);

			Iter_Add(Complex, i);

			totals++;
		}
    }

	printf("[SERVER]: %d apartment complexes were loaded from \"%s\" database...", totals, SQL_DATABASE);
    return true;
}

forward Points_Load();
public Points_Load()
{
	new rows, totals;

	cache_get_row_count(rows);

	if(rows)
	{
	    for(new i = 0; i < rows; ++i)
	    {
			cache_get_value_name_int(i, "ID", EntranceData[i][pointID]);

			cache_get_value_name_float(i, "outsideX", EntranceData[i][outsidePos][0]);
			cache_get_value_name_float(i, "outsideY", EntranceData[i][outsidePos][1]);
			cache_get_value_name_float(i, "outsideZ", EntranceData[i][outsidePos][2]);
			cache_get_value_name_float(i, "outsideA", EntranceData[i][outsidePos][3]);

			cache_get_value_name_float(i, "insideX", EntranceData[i][insidePos][0]);
			cache_get_value_name_float(i, "insideY", EntranceData[i][insidePos][1]);
			cache_get_value_name_float(i, "insideZ", EntranceData[i][insidePos][2]);
			cache_get_value_name_float(i, "insideA", EntranceData[i][insidePos][3]);

			cache_get_value_name_int(i, "outsideApartment", EntranceData[i][outsideApartmentSQL]);
			cache_get_value_name_int(i, "insideApartment", EntranceData[i][insideApartmentSQL]);

			cache_get_value_name_float(i, "pointRange", EntranceData[i][pointRange]);
			cache_get_value_name_int(i, "pointType", EntranceData[i][pointType]);
			cache_get_value_name(i, "pointName", EntranceData[i][pointName], 80);

			cache_get_value_name_int(i, "pointLocked", EntranceData[i][pointLocked]);
			cache_get_value_name_int(i, "pointFaction", EntranceData[i][pointFaction]);

			EntranceData[i][outsideApartmentID] = -1;
			EntranceData[i][insideApartmentID] = -1;
			
			if(EntranceData[i][outsideApartmentSQL] != -1 || EntranceData[i][insideApartmentSQL] != -1)
			{
			    foreach (new x : Complex)
			    {
			        if(EntranceData[i][outsideApartmentSQL] != -1 && ComplexData[x][aID] == EntranceData[i][outsideApartmentSQL])
			        {
			            EntranceData[i][outsideApartmentID] = x;
			        }

			        if(EntranceData[i][insideApartmentSQL] != -1 && ComplexData[x][aID] == EntranceData[i][insideApartmentSQL])
			        {
                        EntranceData[i][insideApartmentID] = x;
			        }
			    }
			}

			Iter_Add(Entrance, i);

			totals++;
	    }
	}

	printf("[SERVER]: %d points were loaded from \"%s\" database...", totals, SQL_DATABASE);
	return true;
}

FUNX::LoadATMS()
{
	if(!cache_num_rows())
		return printf("[SERVER]: No atms were loaded from \"%s\" database...", SQL_DATABASE);

    new countAtm = 0;

	for(new i = 0; i < cache_num_rows(); ++i)
	{
        cache_get_value_name_int(i, "ID", ATMS[i][aID]);
        cache_get_value_name_float(i, "posX", ATMS[i][aPos][0]);
        cache_get_value_name_float(i, "posY", ATMS[i][aPos][1]);
        cache_get_value_name_float(i, "posZ", ATMS[i][aPos][2]);
        cache_get_value_name_float(i, "rotX", ATMS[i][aRot][0]);
        cache_get_value_name_float(i, "rotY", ATMS[i][aRot][1]);
        cache_get_value_name_float(i, "rotZ", ATMS[i][aRot][2]);
        cache_get_value_name(i, "CreatedBy", ATMS[i][CreatedBy], MAX_PLAYER_NAME);

        ATMS[i][aObject] = CreateDynamicObject(ATM_OBJECT, ATMS[i][aPos][0], ATMS[i][aPos][1], ATMS[i][aPos][2], ATMS[i][aRot][0], ATMS[i][aRot][1], ATMS[i][aRot][2]);

        countAtm ++;
	}
	printf("[SERVER]: %d atms were loaded from \"%s\" database...", countAtm, SQL_DATABASE);
	return true;
}

forward House_Load();
public House_Load()
{
	new rows = cache_num_rows(), totals = 0, weapons[256], items[64];

    if(rows > 0)
    {
		//for(new i = 0; i < cache_num_rows(); ++i)
		for(new i, j = cache_num_rows(); i < j; ++i)
		{
			cache_get_value_name_int(i, "id", PropertyData[i][hID]);
			cache_get_value_name_float(i, "posx", PropertyData[i][hEntranceX]);
			cache_get_value_name_float(i, "posy", PropertyData[i][hEntranceY]);
			cache_get_value_name_float(i, "posz", PropertyData[i][hEntranceZ]);
			cache_get_value_name_float(i, "exitx", PropertyData[i][hExitX]);
			cache_get_value_name_float(i, "exity", PropertyData[i][hExitY]);
			cache_get_value_name_float(i, "exitz", PropertyData[i][hExitZ]);
			cache_get_value_name_int(i, "ownerSQLID", PropertyData[i][hOwnerSQLID]);

			cache_get_value_name(i, "info", PropertyData[i][hInfo], 64);
			cache_get_value_name(i, "owner", PropertyData[i][hOwner], MAX_PLAYER_NAME);

			cache_get_value_name_int(i, "owned", PropertyData[i][hOwned]);
			cache_get_value_name_int(i, "locked", PropertyData[i][hLocked]);
			cache_get_value_name_int(i, "price", PropertyData[i][hPrice]);
			cache_get_value_name_int(i, "levelbuy", PropertyData[i][hLevelbuy]);
			cache_get_value_name_int(i, "rentprice", PropertyData[i][hRentprice]);
			cache_get_value_name_int(i, "rentable", PropertyData[i][hRentable]);
			cache_get_value_name_int(i, "interior", PropertyData[i][hInterior]);
			cache_get_value_name_int(i, "world", PropertyData[i][hWorld]);
			cache_get_value_name_int(i, "cash", PropertyData[i][hCash]);
			cache_get_value_name(i, "weapons", weapons);
			cache_get_value_name_float(i, "checkx", PropertyData[i][hCheckPosX]);
			cache_get_value_name_float(i, "checky", PropertyData[i][hCheckPosY]);
			cache_get_value_name_float(i, "checkz", PropertyData[i][hCheckPosZ]);
			cache_get_value_name_int(i, "radio", PropertyData[i][hRadio]);
            cache_get_value_name(i, "items", items);
            cache_get_value_name_int(i, "complex", PropertyData[i][hComplexSQL]);

            PropertyData[i][hComplexID] = -1;

            PropertyData[i][hInterior] = i + 1;

            if(!PropertyData[i][hWorld] || PropertyData[i][hWorld] != i + LOCAL_HOUSE)
            {
                PropertyData[i][hWorld] = i + LOCAL_HOUSE;
            }

            if(!PropertyData[i][hCheckPosX] && !PropertyData[i][hCheckPosY] && !PropertyData[i][hCheckPosZ])
            {
                if(PropertyData[i][hExitX] != 0.0)
                {
	                PropertyData[i][hCheckPosX] = PropertyData[i][hExitX];
	                PropertyData[i][hCheckPosY] = PropertyData[i][hExitY];
	                PropertyData[i][hCheckPosZ] = PropertyData[i][hExitZ];

	                Property_Save(i);
				}
            }

			AssignPropertyWeapons(i, weapons);
			AssignPropertyItems(i, items);

			if(PropertyData[i][hComplexSQL] == -1)
			{
				PropertyData[i][hDynamicArea] = CreateDynamicSphere(PropertyData[i][hEntranceX], PropertyData[i][hEntranceY], PropertyData[i][hEntranceZ], 2.5, 0, 0, -1);

				if(isnull(PropertyData[i][hInfo]) || !strlen(PropertyData[i][hInfo]))
				{
					format(PropertyData[i][hInfo], 64, "%s", ReturnDynamicAddress(PropertyData[i][hEntranceX], PropertyData[i][hEntranceY]));
				}
			}
			else
			{
			    foreach (new aptid : Complex)
			    {
			        if(PropertyData[i][hComplexSQL] == ComplexData[aptid][aID])
			        {
			            PropertyData[i][hComplexID] = aptid;

			            if(isnull(PropertyData[i][hInfo]) || !strlen(PropertyData[i][hInfo]))
			            {
			                format(PropertyData[i][hInfo], 64, "%s", ReturnDynamicAddress(ComplexData[aptid][aEntranceX], ComplexData[aptid][aEntranceY]));
			            }
			            break;
			        }
			    }

			    if(PropertyData[i][hComplexID] != -1)
					PropertyData[i][hDynamicArea] = CreateDynamicSphere(PropertyData[i][hEntranceX], PropertyData[i][hEntranceY], PropertyData[i][hEntranceZ], 1.5, ComplexData[ PropertyData[i][hComplexID] ][aWorld], -1, -1);
				else
				    PropertyData[i][hDynamicArea] = CreateDynamicSphere(PropertyData[i][hEntranceX], PropertyData[i][hEntranceY], PropertyData[i][hEntranceZ], 2.5, 0, 0, -1);
			}

			AssignDynamicAreaValue(PropertyData[i][hDynamicArea], AREA_TYPE_PROPERTY, i);

			Property_Refresh(i);

            Iter_Add(Property, i);

			totals++;
		}
    }

    foreach (new i : Property)
    {
        LoadHouseFurnitures(i);
    }

    printf("[SERVER]: %d houses were loaded from \"%s\" database...", totals, SQL_DATABASE);
    return true;
}

forward Particle_Load();
public Particle_Load()
{
	new rows = cache_num_rows(), totals = 0;

    if(rows > 0)
    {
		for(new i, j = cache_num_rows(); i < j; ++i)
		{
			cache_get_value_name_int(i, "ID", Particles[i][particleSQLID]);
			cache_get_value_name(i, "Creator", Particles[i][particleCreator], MAX_PLAYER_NAME);
			cache_get_value_name_int(i, "Model", Particles[i][particleModel]);
			cache_get_value_name_float(i, "PosX", Particles[i][particlePos][0]);
			cache_get_value_name_float(i, "PosY", Particles[i][particlePos][1]);
			cache_get_value_name_float(i, "PosZ", Particles[i][particlePos][2]);
			cache_get_value_name_float(i, "RotX", Particles[i][particlePos][3]);
			cache_get_value_name_float(i, "RotY", Particles[i][particlePos][4]);
			cache_get_value_name_float(i, "RotZ", Particles[i][particlePos][5]);
			cache_get_value_name_int(i, "Stamp", Particles[i][particleStamp]);

			Particles[i][particleEdit] = false;

			Particles[i][particleObject] = CreateDynamicObject(
				Particles[i][particleModel],
				Particles[i][particlePos][0],
				Particles[i][particlePos][1],
				Particles[i][particlePos][2],
				Particles[i][particlePos][3],
				Particles[i][particlePos][4],
				Particles[i][particlePos][5]
			);

			totals++;
		}
	}

    printf("[SERVER]: %d particles were loaded from \"%s\" database...", totals, SQL_DATABASE);
	return true;
}

forward LoadMOTD();
public LoadMOTD()
{
	if(!cache_num_rows())
	{
	    print("[SERVER]: MOTD failed to load");
		return true;
	}

	cache_get_value_name(0, "Line1", MotdTEXT[0], 256);
	cache_get_value_name(0, "Line2", MotdTEXT[1], 256);
	cache_get_value_name(0, "Line3", MotdTEXT[2], 256);
	cache_get_value_name(0, "Line4", MotdTEXT[3], 256);
	cache_get_value_name(0, "Line5", MotdTEXT[4], 256);
	cache_get_value_name(0, "EditedBy", MotdINFO[editedBy], MAX_PLAYER_NAME);
	cache_get_value_name(0, "EditedDate", MotdINFO[editedDate], 128);

	print("[SERVER]: MOTD was loaded successfully");
	return true;
}
