CMD:respawnrental(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
		return SendUnauthMessage(playerid, "Unauthorized.");

	if(!IsPlayerInAnyVehicle(playerid) || GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	    return SendErrorMessage(playerid, "You need to be in the driver seat of a vehicle.");

	new vehicleid = GetPlayerVehicleID(playerid);

    if(!IsVehicleRental(vehicleid))
        return SendServerMessage(playerid, "You are not in a rental vehicle.");

	SetVehicleToRespawn(vehicleid);

    foreach (new i : Player)
	{
		if(RentCarKey[i] == vehicleid)
		{
			RentCarKey[i] = 0;
		}
	}

	SendClientMessageEx(playerid, COLOR_RADIO, "Rental vehicle %d respawned.", vehicleid);
	return true;
}

CMD:createcar(playerid, params[])
{
 	if(PlayerData[playerid][pAdmin] < 4)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");
    
    new userid, model, color1, color2, lock, immob, alarm, xm;
    	
    if(sscanf(params, "uddddddd", userid, model, color1, color2, lock, immob, alarm, xm))
		return SendSyntaxMessage(playerid, "/createcar [playerid/PartOfName] [model] [color1] [color2] [lock] [immob] [alarm] [xm]");

	if(!AdminDuty{playerid})	
		return SendUnauthMessage(playerid, "You must be on admin duty to perform this command.");	

	new command = Command_GetID("createcar");	

	if(command == -1) return true;

	if(DisabledCommands[command] == 1)
		return SendUnauthMessage(playerid, "This command is currently disabled by the Management.");		
		
	if(!IsPlayerConnected(userid))
		return SendErrorMessage(playerid, "The player you specified isn't connected.");

	if(!SQL_IsLogged(userid))
		return SendErrorMessage(playerid, "The player you specified isn't logged in.");
		
	if(color1 < 0 || color1 > 255 || color2 < 0 || color2 > 255)
	    return SendErrorMessage(playerid, "Invalid color range specified. (0-255)");
	    
	if(lock < 0 || lock > 4)
	    return SendErrorMessage(playerid, "Invalid lock level specified. (0-4)");
		
	if(immob < 0 || immob > 4)
	    return SendErrorMessage(playerid, "Invalid immobiliser level specified. (0-4)");
	    
	if(alarm < 0 || alarm > 4)
	    return SendErrorMessage(playerid, "Invalid alarm level specified. (0-4)");
	    
	if(xm < 0 || xm > 1)
	    return SendErrorMessage(playerid, "Invalid xmRadio value specified. (0-1)");
		
	CreatePlayerVehicle(playerid, userid, model, color1, color2, lock, immob, alarm, xm);
	
	SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmCmd: %s created a player vehicle for %s.", ReturnName(playerid), ReturnName(userid));
	return true;
}

YCMD:aduty(playerid, params[], help) = adminduty;

CMD:adminduty(playerid, params[])
{
 	if(PlayerData[playerid][pAdmin] < 1)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	if(TesterDuty{playerid})
	    return SendErrorMessage(playerid, "You can't do that while on tester duty.");

	if(!Spawned{playerid})
		return SendErrorMessage(playerid, "You're not spawned.");

	AdminDuty{playerid} = !AdminDuty{playerid};		

	if(AdminDuty{playerid})
	{
		SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmCmd: %s is now on adminduty.", ReturnName(playerid));

		TesterColor{playerid} = false;

		SetPVarFloat(playerid, "HealthCache", PlayerData[playerid][pHealth]);

        SetPlayerHealthEx(playerid, 150.0);
		SetPlayerToTeamColor(playerid);
	}
	else
	{
		SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmCmd: %s is now off adminduty.", ReturnName(playerid));

		SetPlayerHealthEx(playerid, GetPVarFloat(playerid, "HealthCache"));
		SetPlayerToTeamColor(playerid);

		DeletePVar(playerid, "HealthCache");
	}

	foreach (new i : Player)
	{
		if(i != playerid)
		{
			RefreshMaskStatus(playerid, i);
		}
	}	
	return true;
}

CMD:kick(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 1)
		return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	new userid, reason[128];

	if(sscanf(params, "us[128]", userid, reason))
		return SendSyntaxMessage(playerid, "/kick [playerid/PartOfName] [reason]");

	if(!IsPlayerConnected(userid))
		return SendErrorMessage(playerid, "The player you specified isn't connected.");

	if(PlayerData[playerid][pAdmin] == PlayerData[userid][pAdmin] || PlayerData[playerid][pAdmin] < PlayerData[userid][pAdmin])
	    return SendErrorMessage(playerid, "You can't kick admins your level or higher than.");

	if(userid == playerid)
	    return SendErrorMessage(playerid, "You can't kick yourself.");

	if(strlen(reason) > 56)
	{
		SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: %s was kicked by %s, Reason: %.56s", ReturnName(userid), ReturnName(playerid), reason);
		SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: ...%s", reason[56]);
	}
	else SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: %s was kicked by %s, Reason: %s", ReturnName(userid), ReturnName(playerid), reason);

	if(SQL_IsLogged(userid))
	{
	    new largeQuery[512];

		mysql_format(dbCon, largeQuery, sizeof(largeQuery), "INSERT INTO `logs_kick` (`IP`, `Character`, `KickedBy`, `Reason`, `character_id`, `user_id`) VALUES ('%e', '%e', '%e', '%e', %d, %d)", ReturnIP(userid), ReturnName(userid), ReturnName(playerid), reason, PlayerData[userid][pID], AccountData[userid][aUserid]);
		mysql_pquery(dbCon, largeQuery);
	}

    KickEx(userid);
	return true;
}

CMD:ban(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 1)
		return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	new userid, reason[128], ip[16];

	if(sscanf(params, "us[128]", userid, reason))
		return SendSyntaxMessage(playerid, "/ban [playerid/PartOfName] [reason]");

	if(!IsPlayerConnected(userid))
		return SendErrorMessage(playerid, "The player you specified isn't connected.");

	if(!SQL_IsLogged(userid))
		return SendErrorMessage(playerid, "The player you specified isn't logged in.");

	if(PlayerData[playerid][pAdmin] == PlayerData[userid][pAdmin] || PlayerData[playerid][pAdmin] < PlayerData[userid][pAdmin])
	    return SendErrorMessage(playerid, "You can't ban admins your level or higher than.");

	if(userid == playerid)
	    return SendErrorMessage(playerid, "You can't ban yourself.");

	format(ip, 16, "%s", ReturnIP(userid));

	if(strlen(reason) > 56)
	{
		SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: %s was banned by %s, reason: %.56s", ReturnName(userid), ReturnName(playerid), reason);
		SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: ... %s", reason[56]);
	}
	else SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: %s was banned by %s, reason: %s", ReturnName(userid), ReturnName(playerid), reason);

	new largeQuery[512];

	mysql_format(dbCon, largeQuery, sizeof(largeQuery), "INSERT INTO `bans` (`name`, `bannedby`, `reason`, `playerIP`, `serial`) VALUES ('%e', '%e', '%e', '%e', '%e')", AccountData[userid][aUsername], ReturnName(playerid), reason, ip, PlayerSerial[userid]);
	mysql_pquery(dbCon, largeQuery);

	mysql_format(dbCon, largeQuery, sizeof(largeQuery), "INSERT INTO `logs_ban` (`Character`, `BannedBy`, `Reason`, `IP`, `character_id`, `user_id`) VALUES ('%e', '%e', '%e', '%e', %d, %d)", ReturnName(userid), ReturnName(playerid), reason, ip, PlayerData[userid][pID], AccountData[userid][aUserid]);
	mysql_pquery(dbCon, largeQuery);

    KickEx(userid);
	return true;
}

CMD:unban(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
		return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	if(isnull(params))
		return SendSyntaxMessage(playerid, "/unban [Firstname_Lastname]");

	if(strlen(params) < 3)
	    return SendErrorMessage(playerid, "Input is too short.");

	mysql_format(dbCon, gquery, sizeof(gquery), "DELETE FROM `bans` WHERE `name` = '%e'", params);
	mysql_tquery(dbCon, gquery, "OnAccountUnbanned", "is", playerid, params);
	return true;
}

CMD:unbanip(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
		return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	if(isnull(params))
    	return SendSyntaxMessage(playerid, "/unbanip [IP address]");

 	if(strlen(params) < 3)
	    return SendErrorMessage(playerid, "Input is too short.");

	new Regex:r = Regex_New(".*\\d{1,3}\\.+\\d{1,3}\\.+\\d{1,3}\\.+\\d{1,3}.*"), RegexMatch:m;

	if(!Regex_Match(params, r, m))
		return SendErrorMessage(playerid, "Invalid IP Address specified.");

	mysql_format(dbCon, gquery, sizeof(gquery), "DELETE FROM `bans` WHERE `playerIP` = '%e'", params);
	mysql_tquery(dbCon, gquery, "OnIPAddressUnbanned", "is", playerid, params);
	return true;
}

CMD:getip(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 1)
	    return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	new
	    userid
	;

	if(sscanf(params, "u", userid))
	    return SendSyntaxMessage(playerid, "/getip [playerid/PartOfName]");

    if(!IsPlayerConnected(userid))
        return SendErrorMessage(playerid, "The player you specified isn't connected.");

	if(PlayerData[userid][pAdmin] == 1337)
		return SendErrorMessage(playerid, "You can't.");	

	SendServerMessage(playerid, "%s's IP Address is \"%s\".", ReturnName(userid), PlayerData[userid][pIP]);
	return true;
}

CMD:arecord(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
		return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	new
		userid
	;

	if(sscanf(params, "u", userid))
		return SendSyntaxMessage(playerid, "/arecord [playerid/partOfName]");

	if(!IsPlayerConnected(userid))
		return SendErrorMessage(playerid, "The player you specified isn't connected.");

	if(!SQL_IsLogged(userid))
		return SendErrorMessage(playerid, "The player you specified isn't logged in.");

	new date[64], reason[128], rows;

	gstr[0] = EOS;

	format(gquery, sizeof(gquery), "SELECT `Date`, `Reason` FROM `logs_ban` WHERE `user_id` = '%d'", AccountData[userid][aUserid]);
	new Cache:cache = mysql_query(dbCon, gquery);

	rows = cache_num_rows();

	strcat(gstr, "Bans:");

	if(!rows) strcat(gstr, "\n");

	for(new i = 0; i < rows; ++i)
	{
	    cache_get_value_name(i, "Date", date, 64);
		cache_get_value_name(i, "Reason", reason, 128);

	    format(gstr, sizeof(gstr), "%s\n\t%s\t%s", gstr, date, reason);
	}

	cache_delete(cache);

	format(gquery, sizeof(gquery), "SELECT `Date`, `Reason` FROM `logs_jail` WHERE `user_id` = '%d'", AccountData[userid][aUserid]);
	new Cache:cache2 = mysql_query(dbCon, gquery);

	rows = cache_num_rows();

	strcat(gstr, "\n\nAjails:");

	if(!rows) strcat(gstr, "\n");

	for(new i = 0; i < rows; ++i)
	{
	    cache_get_value_name(i, "Date", date, 64);
		cache_get_value_name(i, "Reason", reason, 128);

	    format(gstr, sizeof(gstr), "%s\n\t%s\t%s", gstr, date, reason);
	}

	cache_delete(cache2);

	format(gquery, sizeof(gquery), "SELECT `Date`, `Reason` FROM `logs_kick` WHERE `user_id` = '%d'", AccountData[userid][aUserid]);
	new Cache:cache3 = mysql_query(dbCon, gquery);

	rows = cache_num_rows();

	strcat(gstr, "\n\nKicks:");

	if(!rows) strcat(gstr, "\n");

	for(new i = 0; i < rows; ++i)
	{
	    cache_get_value_name(i, "Date", date, 64);
		cache_get_value_name(i, "Reason", reason, 128);

	    format(gstr, sizeof(gstr), "%s\n\t%s\t%s", gstr, date, reason);
	}

	cache_delete(cache3);

	Dialog_Show(playerid, AdminRecord, DIALOG_STYLE_MSGBOX, ReturnName(userid), gstr, "OK", "");
	return true;
}

CMD:ajailed(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
		return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	SendClientMessage(playerid, COLOR_LIGHTRED, "Players ajailed:");

	new count;

	foreach (new i : Player)
	{
	    if(PlayerData[i][pJailed] == PUNISHMENT_TYPE_AJAIL)
	    {
	        SendClientMessageEx(playerid, COLOR_GRAD2, "%s [Jail Time: %d]", ReturnName(i), PlayerData[i][pSentenceTime]);

	        count++;
	    }
	}

	if(!count) SendClientMessageEx(playerid, COLOR_GRAD2, "Nobody is currently ajailed.");

	return true;
}

CMD:ajail(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
		return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	new userid, time, reason[128];

	if(sscanf(params, "uds[128]", userid, time, reason))
		return SendSyntaxMessage(playerid, "/ajail [playerid/partOfName] [time] [reason]");

	if(!IsPlayerConnected(userid))
		return SendErrorMessage(playerid, "The player you specified isn't connected.");

	if(!SQL_IsLogged(userid))
		return SendErrorMessage(playerid, "The player you specified isn't logged in.");

	if(userid == playerid)
	    return SendErrorMessage(playerid, "You can't ajail yourself.");

	if(time <= 0)
		return SendClientMessage(playerid, COLOR_GRAD1, "Time must be greater than 0!");

	if(PlayerData[userid][pJailed])
		return SendErrorMessage(playerid, "The player you specified is already admin jailed.");

	if(strlen(reason) > 45)
	{
		SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: %s was admin jailed by %s for %d min, Reason: %.56s", ReturnName(userid), ReturnName(playerid), time, reason);
		SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: ... %s", reason[56]);
	}
	else SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: %s was admin jailed by %s for %d min, Reason: %s", ReturnName(userid), ReturnName(playerid), time, reason);

	PlayerData[userid][pJailed] = PUNISHMENT_TYPE_AJAIL;
	PlayerData[userid][pSentenceTime] = time * 60;

	SendClientMessageEx(playerid, COLOR_GRAD2, " %s was successfully admin jailed for %d minutes", ReturnName(userid), time);

	DesyncPlayerInterior(userid);
	SetPlayerPosEx(userid, 2689.2698, 2689.3066, 22.9472);
	SetPlayerInteriorEx(userid, 0);
	SetPlayerVirtualWorldEx(userid, userid + 200);
	SetSpawnInfo(userid, NO_TEAM, PlayerData[userid][pModel], 2689.2698, 2689.3066, 22.9472, 1.0, -1, -1, -1, -1, -1, -1);

	new largeQuery[512];

	mysql_format(dbCon, largeQuery, sizeof(largeQuery), "INSERT INTO `logs_jail` (`Character`, `JailedBy`, `Minutes`, `Reason`, `IP`, `character_id`, `user_id`) VALUES ('%e', '%e', '%d', '%e', '%e', %d, %d)", ReturnName(userid), ReturnName(playerid), time, reason, ReturnIP(userid), PlayerData[userid][pID], AccountData[userid][aUserid]);
	mysql_pquery(dbCon, largeQuery);
	return true;
}

CMD:unjail(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
		return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	new
	    userid;

	if(sscanf(params, "u", userid))
		return SendSyntaxMessage(playerid, "/unjail [playerid/PartOfName]");

	if(!IsPlayerConnected(userid))
		return SendErrorMessage(playerid, "The player you specified isn't connected.");

	if(!PlayerData[userid][pJailed])
		return SendErrorMessage(playerid, "The player you specified isn't admin jailed.");

	ReleaseFromPrison(userid);

	SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: %s was released from admin jail by %s", ReturnName(userid), ReturnName(playerid));
	SendClientMessageToAllEx(COLOR_LIGHTRED, "AdmCmd: %s was released from prison/jail by %s", ReturnName(userid), ReturnName(playerid));
	return true;
}

CMD:makedonator(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4)
		return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new userid, level, time;

	if(sscanf(params, "uiI(30)", userid, level, time))
		return SendSyntaxMessage(playerid, "/makedonator [playerid/PartOfName] [level(1-3)] [days]");

	if(!IsPlayerConnected(userid))
		return SendErrorMessage(playerid, "The player you specified isn't connected.");

	if(!SQL_IsLogged(userid))
		return SendErrorMessage(playerid, "The player you specified isn't logged in.");

	if(level == 0)
	{
	    PlayerData[userid][pDonateRank] = 0;

		SendAdminAlert(COLOR_LIGHTRED, JUNIOR_ADMINS, "AdmWarn(4): %s revoked %s's donator status.", ReturnName(playerid), ReturnName(userid));

		SendServerMessage(userid, "Admin %s has revoked your donator status.", ReturnName(playerid));

		mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `characters` SET `DonateRank` = '0', `DonateExpired` = '0' WHERE `ID` = '%d' LIMIT 1", PlayerData[userid][pID]);
		mysql_pquery(dbCon, gquery);
		return true;
	}

	if(!time)
		return SendErrorMessage(playerid, "Invalid expiry date specified.");

	if(level < 1 || level > 3)
		return SendErrorMessage(playerid, "Invalid donator level (0 - 3).");

	PlayerData[userid][pDonateRank] = level;
	PlayerData[userid][pDonateUnix] = gettime() + (time * 86400);

	SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(4): %s set %s's donator status to %s for %d days.", ReturnName(playerid), ReturnName(userid), ReturnDonateRank(level), time);

	SendServerMessage(userid, "Admin %s has provided you with donator status (%s).", ReturnName(playerid), ReturnDonateRank(level));

	mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `characters` SET `DonateRank` = '%d', `DonateExpired` = '%d' WHERE `ID` = '%d' LIMIT 1", level, PlayerData[userid][pDonateUnix], PlayerData[userid][pID]);
	mysql_pquery(dbCon, gquery);
	return true;
}

CMD:flipcar(playerid, params[])
{
	new vehicleid;

    if(PlayerData[playerid][pAdmin] < 1)
		return SendErrorMessage(playerid, "You're not authorized to use this command.");

	if(sscanf(params, "d", vehicleid))
	    return SendSyntaxMessage(playerid, "/flipcar [vehicleid]");

	if(vehicleid < 1 || vehicleid > MAX_VEHICLES || !IsValidVehicle(vehicleid))
		return SendErrorMessage(playerid, "Invalid vehicle ID specified.");

    new Float:angle;
    GetVehicleZAngle(vehicleid, angle);
    SetVehicleZAngle(vehicleid, angle);

    SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(1): %s flipped vehicle %d.", ReturnName(playerid), vehicleid);
    return true;
}

YCMD:spectate(playerid, params[], help) = watchplayer;
YCMD:spec(playerid, params[], help) = watchplayer;
YCMD:awp(playerid, params[], help) = watchplayer;

CMD:watchplayer(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

 	new
        userid
	;

	if(sscanf(params, "u", userid))
		return SendSyntaxMessage(playerid, "/watchplayer [playerid]");

	if(!IsPlayerConnected(userid) || !SQL_IsLogged(userid) || PlayerData[userid][pID] == -1)
		return SendClientMessage(playerid, COLOR_GREY, "The specified player is not connected, or has not authenticated.");

	if(userid == playerid)
	    return SendClientMessage(playerid, COLOR_GREY, "You can't spectate yourself.");

	if(PlayerData[playerid][pTutorialStep])
		return SendClientMessage(playerid, COLOR_GREY, "Player is currently doing the tutorial.");

	if(PlayerData[userid][pSpectating] != INVALID_PLAYER_ID)
	    return SendClientMessage(playerid, COLOR_GREY, "Player is currently spectating someone.");

	if(PlayerData[userid][pAdmin] == 1337)
		return SendClientMessage(playerid, COLOR_GREY, "You're not authorized to spectate this admin.");	

	if(PlayerData[playerid][pSpectating] == INVALID_PLAYER_ID)
	{
		GetPlayerPos(playerid, PlayerData[playerid][pPos][0], PlayerData[playerid][pPos][1], PlayerData[playerid][pPos][2]);

		PlayerData[playerid][pInterior] = GetPlayerInterior(playerid);
		PlayerData[playerid][pWorld] = GetPlayerVirtualWorld(playerid);
	}

	PlayerData[playerid][pSpectating] = userid;

	TogglePlayerSpectating(playerid, true);
	SetPlayerInterior(playerid, GetPlayerInterior(userid));
	SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(userid));	

	if(IsPlayerInAnyVehicle(userid))
	{
 		PlayerSpectateVehicle(playerid, GetPlayerVehicleID(userid));
	}
	else
	{
		PlayerSpectatePlayer(playerid, userid);
	}
	return true;
}

YCMD:spectatecar(playerid, params[], help) = watchcar;
YCMD:speccar(playerid, params[], help) = watchcar;
YCMD:awc(playerid, params[], help) = watchcar;

CMD:watchcar(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new vehicleid = GetPlayerVehicleID(playerid);

	if(sscanf(params, "i", vehicleid))
		return SendSyntaxMessage(playerid, "/watchcar [vehicleid]");

	if(!IsValidVehicle(vehicleid))
		return SendErrorMessage(playerid, "You specified an invalid vehicle.");

	if(PlayerData[playerid][pSpectating] == INVALID_PLAYER_ID)
	{
		GetPlayerPos(playerid, PlayerData[playerid][pPos][0], PlayerData[playerid][pPos][1], PlayerData[playerid][pPos][2]);

		PlayerData[playerid][pInterior] = GetPlayerInterior(playerid);
		PlayerData[playerid][pWorld] = GetPlayerVirtualWorld(playerid);
	}

	PlayerData[playerid][pSpectating] = vehicleid;

	TogglePlayerSpectating(playerid, true);
	SetPlayerInterior(playerid, GetVehicleVirtualWorld(vehicleid));
	PlayerSpectateVehicle(playerid, vehicleid);
	return true;
}

YCMD:specoff(playerid, params[], help) = watchoff;

CMD:watchoff(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	if(PlayerData[playerid][pSpectating] == INVALID_PLAYER_ID)
		return SendClientMessage(playerid, COLOR_GREY, "You're not spectating anyone.");

	PlayerData[playerid][pSpectating] = INVALID_PLAYER_ID;

	TogglePlayerSpectating(playerid, false);
	SetCameraBehindPlayer(playerid);

	SetPlayerDynamicPos(playerid, PlayerData[playerid][pPos][0], PlayerData[playerid][pPos][1], PlayerData[playerid][pPos][2]);
	SetPlayerInterior(playerid, PlayerData[playerid][pInterior]);
	SetPlayerVirtualWorld(playerid, PlayerData[playerid][pWorld]);

	SetPlayerWeapons(playerid);
	return true;
}

CMD:setint(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
		return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new userid, interior;

	if(sscanf(params, "ud", userid, interior))
		return SendSyntaxMessage(playerid, "/setint [playerid/PartOfName] [Interior ID]");

	if(!IsPlayerConnected(userid))
		return SendErrorMessage(playerid, "The player you specified isn't connected.");

	SetPlayerInteriorEx(userid, interior);

	SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(1): %s has set %s's interior to %d.", ReturnName(playerid), ReturnName(userid), interior);
	return true;
}

CMD:setworld(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
		return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new userid, world;

	if(sscanf(params, "ud", userid, world))
		return SendSyntaxMessage(playerid, "/setworld [playerid/PartOfName] [World ID]");

	if(!IsPlayerConnected(userid))
		return SendErrorMessage(playerid, "The player you specified isn't connected.");

	SetPlayerVirtualWorldEx(userid, world);

	SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(1): %s has set %s's world to %d.", ReturnName(playerid), ReturnName(userid), world);
	return true;
}

CMD:getworld(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
		return SendErrorMessage(playerid, "You're not authorized to use this command.");

	SendClientMessageEx(playerid, COLOR_GRAD1, " Your current virtual world is %d.", GetPlayerVirtualWorld(playerid));
	return true;
}

//report system

YCMD:report(playerid, params[], help) = re;

CMD:re(playerid, params[])
{
	new inputOne[128], inputSec[128], userid = INVALID_PLAYER_ID;

	if(sscanf(params, "s[128]S()[128]", inputOne, inputSec))
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "Report USAGE: /re [(Optional ID/partOfName)] [report text]");

    sscanf(inputOne, "u", userid);

	if(userid != INVALID_PLAYER_ID && IsPlayerConnected(userid))
	{
	    if(isnull(inputSec))
	        return SendClientMessage(playerid, COLOR_LIGHTRED, "Your message is either too short or too long.");

	    PlayerData[playerid][pReportPlayer] = userid;
		strcpy(PlayerData[playerid][pReportMessage], inputSec, 128);
	}
	else
	{
	    if(isnull(params))
	        return SendClientMessage(playerid, COLOR_LIGHTRED, "Your message is either too short or too long.");

	    PlayerData[playerid][pReportPlayer] = INVALID_PLAYER_ID;
		strcpy(PlayerData[playerid][pReportMessage], params, 128);
	}

	new reportBody[1500];

	format(reportBody, sizeof(reportBody), "{FF0000}WARNING:\n{FFFFFF}You are about to send all online administrators the following report: %s\n\n", PlayerData[playerid][pReportMessage]);

	strcat(reportBody, "- Reporting actions which do not happen at the moment is extremely difficult for online admins to handle on the spot, since no proof is presented to them.\n");
	strcat(reportBody, "It is highly recommended to head to the forums and submit a forum report with evidence, instead.\n\n");
	strcat(reportBody, "- It is important you do not send in-game reports about things which are better handled on the forums, such as the aforementioned and/or donation issues,\n");
	strcat(reportBody, "refund requests after server rollbacks, ban appeals and so forth. If you think you've been deathmatched, do consider asking the killing party for a reason first.\n\n");
	strcat(reportBody, "- Please remember that whether you are reporting about a player who you feel have violated the rules or a bug you may have encountered, screenshots are your best chance at proving it.\n");
	strcat(reportBody, "We encourage you to take screenshots before and after reporting.\n\n");
	strcat(reportBody, "- Should you request a teleport, unfreeze, slap or any other similarities, you must state why. Generally, you are required to be descriptive in your reports.\n");
	strcat(reportBody, "- Please do not spam your reports. Be patient and an administrator will assist you as soon as possible.\n");
	strcat(reportBody, "You should not attempt to disrupt or stall the roleplay unless admin assistance is being given/the other player is making you sexually uncomfortable.");

	Dialog_Show(playerid, ReportConfirm, DIALOG_STYLE_MSGBOX, "Warning, you're about to send a /re", reportBody, "Proceed", "Don't send");
	return true;
}

stock FindFreeReportID()
{
	for(new i = 0; i < MAX_REPORTS; ++i)
	{
		if(Reports[i][reportBy] == INVALID_PLAYER_ID)
		{
		    return i;
		}
	}
	return -1;
}

stock IsValidReport(id)
{
	if(id < 0 || id >= MAX_REPORTS) return false;

	if(Reports[id][reportBy] != INVALID_PLAYER_ID) return true;

	return false;
}

stock DeleteReport(id)
{
	Reports[id][reportBy] = INVALID_PLAYER_ID;
	Reports[id][reportPlayer] = INVALID_PLAYER_ID;
	Reports[id][reportReason][0] = EOS;
}

stock SaveReport(id, by, player, text[])
{
	Reports[id][reportBy] = by;
	Reports[id][reportPlayer] = player;
	format(Reports[id][reportReason], 128, text);
}

/*if(!IsValidReport(report))
	return SendClientMessage(playerid, COLOR_GREY, "Invalid report specified.");*/

CMD:ar(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
		return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new
		userid
	;

	if(sscanf(params, "u", userid))
		return SendClientMessage(playerid, COLOR_GREY, "USAGE: /ar [playerid]");

	if(!IsPlayerConnected(userid))
		return SendClientMessage(playerid, COLOR_GREY, "The specified player ID is either not connected or has not authenticated.");

	if(PlayerData[userid][pReport] < 1)
	    return SendClientMessage(playerid, COLOR_GREY, "The player did not report in.");

	SendClientMessageEx(userid, COLOR_ORANGE, "SERVER: Admin %s is responding to your report, wait for them to contact you.", ReturnName(playerid));

	SendAdminAlert(COLOR_ORANGE, JUNIOR_ADMINS, "[Report] Admin %s has accepted report %d", ReturnName(playerid), playerid);

	SendClientMessage(playerid, COLOR_YELLOW, "__Here is some information on the report you accepted__");

	if(PlayerData[userid][pReportPlayer] != INVALID_PLAYER_ID && IsPlayerConnected(PlayerData[userid][pReportPlayer]))
		SendClientMessageEx(playerid, COLOR_WHITE, "{FF9900}Reported by:{AFAFAF} %s{FF9900} on player{AFAFAF} %s (%d), %d{FF9900} seconds ago.", ReturnName(userid), ReturnName(PlayerData[userid][pReportPlayer]), PlayerData[userid][pReportPlayer], (gettime() - PlayerData[userid][pReportStamp]));
	else
	    SendClientMessageEx(playerid, COLOR_WHITE, "{FF9900}Reported by:{AFAFAF} %s, %d{FF9900} seconds ago.", ReturnName(userid), (gettime() - PlayerData[userid][pReportStamp]));

	SendClientMessageEx(playerid, COLOR_WHITE, " %s", PlayerData[userid][pReportMessage]);

	PlayerData[userid][pReport] = 0;
	PlayerData[userid][pReportPlayer] = INVALID_PLAYER_ID;
	PlayerData[userid][pReportMessage][0] = EOS;
	PlayerData[userid][pReportStamp] = 0;
	return true;
}

CMD:dr(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
		return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new userid, reason[128];

	if(sscanf(params, "uS()[128]", userid, reason))
		return SendClientMessage(playerid, COLOR_GREY, "USAGE: /dr [playerid] [(Optional Reason)]");

	if(!IsPlayerConnected(userid))
		return SendClientMessage(playerid, COLOR_GREY, "The specified player ID is either not connected or has not authenticated.");

	if(PlayerData[userid][pReport] < 1)
	    return SendClientMessage(playerid, COLOR_GREY, "The player did not report in.");

	PlayerData[userid][pReport] = 0;
	PlayerData[userid][pReportPlayer] = INVALID_PLAYER_ID;
	PlayerData[userid][pReportMessage][0] = EOS;

	if(!strlen(reason))
	{
		SendClientMessageEx(userid, COLOR_LIGHTRED, "SERVER: Admin %s has disregarded your report.", ReturnName(playerid));
	}
	else
	{
	    if(strlen(reason) > 50)
	    {
			SendClientMessageEx(userid, COLOR_LIGHTRED, "SERVER: Admin %s disregarded your report, they said: %.50s", ReturnName(playerid), reason);
			SendClientMessageEx(userid, COLOR_LIGHTRED, "%s", reason[50]);
		}
		else SendClientMessageEx(userid, COLOR_LIGHTRED, "SERVER: Admin %s disregarded your report, they said: %s", ReturnName(playerid), reason);
	}

	SendAdminAlert(COLOR_ORANGE, JUNIOR_ADMINS, "[Report] Admin %s has disregarded report %d", ReturnName(playerid), playerid);
	return true;
}

CMD:reports(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
		return SendErrorMessage(playerid, "You're not authorized to use this command.");

	SendClientMessage(playerid, COLOR_WHITE, "-------------------------------------------------------------------------------------------------------------------------------");

	new
		reportCount
	;

	foreach (new i : Player)
	{
		if(PlayerData[i][pReport] >= 1)
		{
			SendClientMessageEx(playerid, COLOR_REPORT, "[ACTIVE]{FFFFFF} %s {FF6347}[%d] {FFFF91}: %s", ReturnName(i), i, PlayerData[i][pReportMessage]);

			reportCount++;
		}
	}

	SendClientMessageEx(playerid, COLOR_WHITE, "ACTIVE REPORTS: %d (Use /ar to confirm)", reportCount);

	SendClientMessage(playerid, COLOR_WHITE, "-------------------------------------------------------------------------------------------------------------------------------");
	return true;
}

CMD:createpoint(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1337)
	    return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new name[80], point;

	if(sscanf(params, "s[80]", name))
	    return SendSyntaxMessage(playerid, "/createpoint [Point-Name]");

	if(InProperty[playerid] != -1 || InBusiness[playerid] != -1)
	    return SendErrorMessage(playerid, "You can only do this inside complexes, or outside.");

	point = Iter_Free(Entrance);

	if(point == -1)
	    return SendErrorMessage(playerid, "Failed to create point, MAX_ENTRANCES reached.");

	new Float:playerPos[4];

	GetPlayerPos(playerid, playerPos[0], playerPos[1], playerPos[2]);
	GetPlayerFacingAngle(playerid, playerPos[3]);

	EntranceData[point][outsidePos][0] = playerPos[0];
	EntranceData[point][outsidePos][1] = playerPos[1];
	EntranceData[point][outsidePos][2] = playerPos[2];
	EntranceData[point][outsidePos][3] = playerPos[3];

	EntranceData[point][insidePos][0] = 0.0;
	EntranceData[point][insidePos][1] = 0.0;
	EntranceData[point][insidePos][2] = 0.0;
	EntranceData[point][insidePos][3] = 0.0;

	EntranceData[point][pointRange] = 3.0;
	EntranceData[point][pointType] = POINT_TYPE_ONFOOT;

	format(EntranceData[point][pointName], 80, name);

	EntranceData[point][pointLocked] = 0;
	EntranceData[point][pointFaction] = -1;	

	new apt = InApartment[playerid];

	if(apt == -1)
	{
		EntranceData[point][outsideApartmentSQL] = -1;
		EntranceData[point][outsideApartmentID] = -1;
	}
	else
	{
		EntranceData[point][outsideApartmentSQL] = ComplexData[apt][aID];
		EntranceData[point][outsideApartmentID] = apt;
	}

	EntranceData[point][insideApartmentSQL] = -1;
	EntranceData[point][insideApartmentID] = -1;

	AddPointToFile(point, name, playerPos[0], playerPos[1], playerPos[2], playerPos[3], EntranceData[point][outsideApartmentSQL], EntranceData[point][insideApartmentSQL]);

	Iter_Add(Entrance, point);

	SendClientMessageEx(playerid, COLOR_YELLOW, "-> Point successfully created with id #%d.", point);
	return true;
}

stock AddPointToFile(point, name[], Float:x, Float:y, Float:z, Float:a, outsideApt, insideApt)
{
	new biggestQuery[500];
	mysql_format(dbCon, biggestQuery, sizeof(biggestQuery), "INSERT INTO `points` (outsideX, outsideY, outsideZ, outsideA, outsideApartment, insideApartment, pointName) VALUES (%f, %f, %f, %f, %d, %d, '%e')", x, y, z, a, outsideApt, insideApt, name);
	mysql_tquery(dbCon, biggestQuery, "OnPointInsert", "d", point);
	return true;
}

CMD:points(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1337)
	    return SendErrorMessage(playerid, "You're not authorized to use this command.");

	SendClientMessage(playerid, COLOR_GREY, "Listing all points...");

	foreach (new i: Entrance)
	{
	    SendClientMessageEx(playerid, COLOR_GRAD2, "%d [%s]", i, EntranceData[i][pointName]);
	}
	return true;
}

CMD:editpoint(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1337)
	    return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new point;

	if(sscanf(params, "d", point))
	    return SendSyntaxMessage(playerid, "/editpoint [Point-ID]");

	if(point < 0 || point > MAX_ENTRANCES)
		return SendErrorMessage(playerid, "Invalid point ID specified.");

	if(!Iter_Contains(Entrance, point))
	    return SendErrorMessage(playerid, "Point doesn't exist.");

	SetPVarInt(playerid, "EditingPoint", point);

    ShowPointSettings(playerid, point);
	return true;
}

YCMD:pgun(playerid, params[], help) = particlegun;

CMD:particlegun(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 1337)
		return SendUnauthMessage(playerid, "Only admins and faction members with right permissions can access the particle gun.");

	new option[30];

	if(sscanf(params, "s[30]", option))
	{
	    ShowParticleDialog(playerid);
	    return SendClientMessage(playerid, COLOR_YELLOW, "-> Hint: you can also use /particlegun list to view active particles.");
	}

	if(!strcmp(option, "list", true))
	{
	    ParticleOffset[playerid] = 0;

	    ShowParticleList(playerid);
	}
	else SendErrorMessage(playerid, "Invalid option.");

	return true;
}

// graffiti
CMD:creategraffiti(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 4)
		return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	AddSprayLocation(playerid);
	return true;
}

CMD:editgraffiti(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 4)
		return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	new
        graffid
	;

	if(sscanf(params, "d", graffid))
		return SendSyntaxMessage(playerid, "/editgraffiti [id]");

	if(graffid < 0 || graffid > MAX_SPRAY_LOCATIONS)
		return SendSyntaxMessage(playerid, "Invalid ID, 0 - %d", MAX_SPRAY_LOCATIONS);

	if(Spray_Data[graffid][graffSQLID] == -1)
		return SendErrorMessage(playerid, "Graffiti doesn't exist.");

	if(!IsPlayerInRangeOfPoint(playerid, 5.0, Spray_Data[graffid][Xpos], Spray_Data[graffid][Ypos], Spray_Data[graffid][Zpos]))
	    return SendErrorMessage(playerid, "You're not near the graffiti.");

	SetPVarInt(playerid, "EditingGraffti", graffid);

    EditingGraffiti{playerid} = true;

    EditDynamicObject(playerid, Spray_Data[graffid][graffObject]);

    SendClientMessageEx(playerid, COLOR_YELLOW, "-> You're now editing Graffiti ID: %d", graffid);
	return true;
}

CMD:destroygraffiti(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 4)
		return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	for(new ID = 0; ID < MAX_SPRAY_LOCATIONS; ++ID)
	{
		if(Spray_Data[ID][graffSQLID] == -1) continue;

		if(IsPlayerInRangeOfPoint(playerid, 3.0, Spray_Data[ID][Xpos], Spray_Data[ID][Ypos], Spray_Data[ID][Zpos]))
		{
			DeleteGraffiti(ID);

    		SendAdminAlert(COLOR_YELLOW, LEAD_ADMINS, "AdmWarn(4): %s deleted graffiti ID %d.", ReturnName(playerid), ID);
			return true;
		}
	}

	SendErrorMessage(playerid, "Nothing nearby.");
	return true;
}

CMD:makeadmin(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] != 1337/* && !IsPlayerAdmin(playerid)*/)
        return SendUnauthMessage(playerid, "You're not authorized to use this command.");

    new
        userid,
		adminlevel
	;

	if(sscanf(params, "ud", userid, adminlevel))
        return SendSyntaxMessage(playerid, "/makeadmin [playerid/PartOfName] [admin-level]");

	if(!IsPlayerConnected(userid))
		return SendErrorMessage(playerid, "The player you specified isn't connected.");

	if(!SQL_IsLogged(userid))
		return SendErrorMessage(playerid, "The player you specified isn't logged in.");

	if(PlayerData[userid][pAdmin] >= PlayerData[playerid][pAdmin] && (PlayerData[playerid][pAdmin] != 1337 && !IsPlayerAdmin(playerid)))
		return SendErrorMessage(playerid, "You cannot change admin level of a a higher-rank administrator.");

	if(PlayerData[userid][pAdmin] == adminlevel)
	    return SendErrorMessage(playerid, "Player is already that level.");

	if(adminlevel < 0)
	    return SendErrorMessage(playerid, "Invalid level specified.");

	PlayerData[userid][pAdmin] = adminlevel;

	SendServerMessage(userid, "Admin %s has set your admin level to %d.", ReturnName(playerid, 0), adminlevel);

	SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmCmd: %s set %s's admin level to %d.", ReturnName(playerid), ReturnName(userid), adminlevel);

	mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `accounts` SET `Admin` = '%d' WHERE `ID` = %d LIMIT 1", adminlevel, AccountData[userid][aUserid]);
	mysql_pquery(dbCon, gquery);
	return true;
}

CMD:maketester(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] != 1337/* && !IsPlayerAdmin(playerid)*/)
        return SendUnauthMessage(playerid, "You're not authorized to use this command.");

    new
    	userid
	;

    if(sscanf(params, "u", userid))
        return SendSyntaxMessage(playerid, "/maketester [playerid/PartOfName]");

	if(!IsPlayerConnected(userid))
		return SendErrorMessage(playerid, "The player you specified isn't connected.");

	if(!SQL_IsLogged(userid))
		return SendErrorMessage(playerid, "The player you specified isn't logged in.");

	if(PlayerData[userid][pAdmin] == -1)
	{
	    PlayerData[userid][pAdmin] = 0;

	    SendServerMessage(userid, "Admin %s has removed your tester roles.", ReturnName(playerid));

	    SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmCmd: %s removed %s's tester roles.", ReturnName(playerid), ReturnName(userid));
	}
	else
	{
	    PlayerData[userid][pAdmin] = -1;

	    SendServerMessage(userid, "Admin %s has made you a tester.", ReturnName(playerid));

	    SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmCmd: %s made %s a tester.", ReturnName(playerid), ReturnName(userid), userid);
	}

	mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `accounts` SET `Admin` = '%d' WHERE `ID` = %d LIMIT 1", PlayerData[userid][pAdmin], AccountData[userid][aUserid]);
	mysql_pquery(dbCon, gquery);
	return true;
}

CMD:updatemotd(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1337)
		return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	Dialog_Show(playerid, MotdList, DIALOG_STYLE_LIST, "Update Motd", "Line 1\nLine 2\nLine 3\nLine 4\nLine 5", "Update", "Cancel");
	return true;
}

CMD:forceunmask(playerid, params[])
{
 	if(PlayerData[playerid][pAdmin] < 3)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new
		userid = INVALID_PLAYER_ID
	;

	if(sscanf(params, "u", userid))
		return SendSyntaxMessage(playerid, "/forceunmask [playerid/PartOfName]");

	if(userid == INVALID_PLAYER_ID)
	{
		new maskid[MAX_PLAYER_NAME];
		sscanf(params, "s[24]", maskid);
		if((userid = GetPlayerMaskID(maskid)) == INVALID_PLAYER_ID)
		{
			return SendErrorMessage(playerid, "The player you specified isn't connected.");
		}
	}

	if(userid == playerid)
		return SendClientMessage(playerid, COLOR_GRAD1, "You can't use it on yourself.");

 	if(IsMasked{userid})
	{
   		IsMasked{userid} = false;

    	foreach (new i : Player)
       	{
	     	if(i != userid)
	    	{
				RefreshMaskStatus(userid,i);
			}
     	}

       	SendNoticeMessage(userid, "Your OOC Mask has been forced off by an admin.");
 	}
 	return true;
}

stock TrashVehicleRequest(id)
{
	VehicleRequests[id][requestActive] = false;
	VehicleRequests[id][requestPlayer] = INVALID_PLAYER_ID;
	VehicleRequests[id][requestCar] = INVALID_VEHICLE_ID;
	VehicleRequests[id][requestName][0] = EOS;
	VehicleRequests[id][requestStamp][0] = EOS;
}

CMD:vehiclerequests(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 3)
		return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	new request;

	if(sscanf(params, "d", request))
		return ShowVehicleRequests(playerid);

	if(request < 1 || request > 100)
	    return SendErrorMessage(playerid, "Invalid request number specified.");

	request--;

	if(!VehicleRequests[request][requestActive])
	    return SendErrorMessage(playerid, "This request doesn't exist.");

	ShowVehicleRequestDetails(playerid, request);
	return true;
}

stock ShowVehicleRequests(playerid)
{
	new count;

	gstr[0] = EOS;
 
	for(new i = 0; i < 100; ++i)
	{
	    if(VehicleRequests[i][requestActive])
	    {
	        format(gstr, sizeof(gstr), "%s{7e98b6}%d\t{a9c4e4}%s (%s)\t%s\n", gstr, i + 1, ReturnVehicleModelNameEx(CarData[ VehicleRequests[i][requestCar] ][carModel]), ReturnName(VehicleRequests[i][requestPlayer]), VehicleRequests[i][requestStamp]);

	        count++;
	    }
	}

	if(!count) return SendNoticeMessage(playerid, "There are no active vehicle requests.");

	Dialog_Show(playerid, VehicleRequests, DIALOG_STYLE_LIST, "Vehicle Requests", gstr, "Select", "Cancel");
    return true;
}

Dialog:VehicleRequests(playerid, response, listitem, inputtext[])
{
	if(!response) return true;

	new request = strval(inputtext) - 1;

    SetPVarInt(playerid, "VehicleRequest", request);

    ShowVehicleRequestDetails(playerid, request);
	return true;
}

stock ShowVehicleRequestDetails(playerid, request)
{
    new header[60], carid = VehicleRequests[request][requestCar];
	
	gstr[0] = EOS;

    format(gstr, sizeof(gstr), "{7e98b6}1\t{a9c4e4}Request ID [{7e98b6}%d{a9c4e4}]\n\
	{7e98b6}2\t{a9c4e4}Vehicle Model [{7e98b6}%s{a9c4e4}]\n\
	{7e98b6}3\t{a9c4e4}Vehicle ID [{7e98b6}%d{a9c4e4}]\n\
	{7e98b6}4\t{a9c4e4}Custom Name [{7e98b6}%s{a9c4e4}]\n\
    {7e98b6}5\t{a9c4e4}Submitted By [{7e98b6}%s{a9c4e4}]\n\
    {7e98b6}6\t{a9c4e4}Submitted At [{7e98b6}%s{a9c4e4}]\n\
	{7e98b6}7\t{a9c4e4}{a9c4e4}Approve\n\
	{7e98b6}8\t{a9c4e4}{a9c4e4}Deny",
	request + 1, ReturnVehicleModelNameEx(CarData[carid][carModel]), CarData[carid][carID], VehicleRequests[request][requestName], ReturnName(VehicleRequests[request][requestPlayer]), VehicleRequests[request][requestStamp]);

	format(header, sizeof(header), "Viewing Request #%d", request + 1);

	Dialog_Show(playerid, VehicleRequest_Details, DIALOG_STYLE_LIST, header, gstr, "Select", "Back");
}

Dialog:VehicleRequest_Details(playerid, response, listitem, inputtext[])
{
	if(!response)
	{
	    DeletePVar(playerid, "VehicleRequest");
	    return ShowVehicleRequests(playerid);
	}

	new request = GetPVarInt(playerid, "VehicleRequest");

	switch(listitem)
	{
	    case 6:
	    {
	        new carid = VehicleRequests[request][requestCar];

			format(CarData[carid][carName], 64, VehicleRequests[request][requestName]);
		    Car_SaveID(carid);

		    SendNoticeMessage(VehicleRequests[request][requestPlayer], "Your vehiclename request #%d has been accepted by %s.", request + 1, ReturnName(playerid));

		    TrashVehicleRequest(request);

		    DeletePVar(playerid, "VehicleRequest");

		    return ShowVehicleRequests(playerid);
	    }
	    case 7:
	    {
	        SendNoticeMessage(VehicleRequests[request][requestPlayer], "Your vehiclename request #%d has been denied by %s.", request + 1, ReturnName(playerid));

	        TrashVehicleRequest(request);

	        DeletePVar(playerid, "VehicleRequest");

	        return ShowVehicleRequests(playerid);
		}
		default: ShowVehicleRequestDetails(playerid, request);
	}

	return true;
}

stock DeleteVehicleNameRequest(id)
{
    VehicleRequests[id][reqID] = -1;
	VehicleRequests[id][reqPlayer] = INVALID_PLAYER_ID;
	VehicleRequests[id][reqVehID] = INVALID_VEHICLE_ID;
    VehicleRequests[id][reqName][0] = EOS;
}

CMD:watchradio(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 2)
		return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new channel;

	if(sscanf(params, "d", channel))
	{
	    if(WatchRadio[playerid])
	    {
	        SendClientMessageEx(playerid, COLOR_CYAN, "You'll no longer be listening to frequency %d.", WatchRadio[playerid]);

	        WatchRadio[playerid] = 0;
	        return true;
	    }
	    return SendSyntaxMessage(playerid, "/watchradio [frequency]");
	}

	if(channel < 1 || channel > 1000000)
		return SendClientMessage(playerid, COLOR_WHITE, "Only channels 1 - 1000000 supported");

    WatchRadio[playerid] = channel;

	SendClientMessageEx(playerid, COLOR_CYAN, "You'll now be listening to frequency %d, /watchradio to stop.");
	return true;
}

CMD:propinfo(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 1)
    	return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	new house;

	if(sscanf(params, "d", house))
	    return SendSyntaxMessage(playerid, "/propinfo [houseid]");

	if(!Iter_Contains(Property, house))
	    return SendErrorMessage(playerid, "Property doesn't exist.");

	SendClientMessageEx(playerid, COLOR_GRAD3, "House (#%d) %s, San Andreas.", house, ReturnPropertyAddress(house));
	SendClientMessageEx(playerid, COLOR_GRAD3, "Price: %s, Locked: %s", FormatNumber(PropertyData[house][hPrice]), (PropertyData[house][hLocked]) ? ("Yes") : ("No"));
	SendClientMessageEx(playerid, COLOR_GRAD3, "Cashbox: %s, Alarm: 0, Lock: %d, Level: %d", FormatNumber(PropertyData[house][hCash]), PropertyData[house][hLocked], PropertyData[house][hLevelbuy]);
	SendClientMessageEx(playerid, COLOR_GRAD3, "Owner: %s", PropertyData[house][hOwner]);
	return true;
}

CMD:desynced(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 1)
    	return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	new userid;

	if(sscanf(params, "u", userid))
		return SendSyntaxMessage(playerid, "/desynced [playerid/PartOfName]");

	if(!IsPlayerConnected(userid))
		return SendErrorMessage(playerid, "The player you specified isn't connected.");

	new Float:Packetloss = NetStats_PacketLossPercent(userid);

	if(Packetloss >= 5)
	    SendNoticeMessage(playerid, "%s is desynced [P: %d, PL: %.6f].", ReturnName(userid), GetPlayerPing(userid), Packetloss);
	else
		SendNoticeMessage(playerid, "%s is not desynced [P: %d, PL: %.6f].", ReturnName(userid), GetPlayerPing(userid), Packetloss);

	return true;
}

CMD:whereami(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 1)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new id = -1;

    if((id = nearProperty_var[playerid]) != -1)
        SendClientMessageEx(playerid, COLOR_GRAD1, " You are standing near House ID: %d", id);

    if((id = Business_Nearest(playerid)) != -1)
        SendClientMessageEx(playerid, COLOR_GRAD1, " You are standing near Business ID: %d", id);

    if((id = Apartment_Nearest(playerid)) != -1)
    	SendClientMessageEx(playerid, COLOR_GRAD1, " You are standing near Apartment ID: %d", id);

    if((id = Point_Nearest(playerid)) != -1)
        SendClientMessageEx(playerid, COLOR_GRAD1, " You are standing near Point ID: %d", id);

    if((id = Graffiti_Nearest(playerid)) != -1)
    	SendClientMessageEx(playerid, COLOR_GRAD1, " You are standing near Graffiti ID: %d", id);

    if((id = ATM_Nearest(playerid)) != -1)
    	SendClientMessageEx(playerid, COLOR_GRAD1, " You are standing near ATM ID: %d", id);

    if((id = GetClosestSignal(playerid)) != -1)
	    SendClientMessageEx(playerid, COLOR_GRAD1, " You are standing near Radio Tower ID: %d", id);

	return true;
}

CMD:neargraffiti(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 1)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new id = -1;

    if((id = Graffiti_Nearest(playerid)) != -1)
    	SendClientMessageEx(playerid, COLOR_GRAD1, " You are standing near Graffiti ID: %d", id);
    else
        SendClientMessage(playerid, COLOR_GRAD1, "You're not standing near a graffiti.");

	return true;
}

CMD:createsignal(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 1337)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	if(isnull(params) || strlen(params) > 32)
	    return SendSyntaxMessage(playerid, "/createsignal [name]");

	new id = Signal_Create(playerid, params);

	if(id == -1)
	    return SendClientMessage(playerid, COLOR_GRAD1, "   This server has Radio Tower exceeded the limit");

	SendClientMessageEx(playerid, COLOR_GRAD1, "   You have succeeded in creating Radio Tower ID: %d", id);
	return true;
}

CMD:editsignal(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1337)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new id, type[24], string[128];

	if(sscanf(params, "ds[24]S()[128]", id, type, string))
 	{
	 	SendSyntaxMessage(playerid, "/editsignal [id] [name]");
	    SendClientMessage(playerid, COLOR_GREY, "Available names: location, range, name");
		return true;
	}
	if((id < 0 || id >= MAX_SIGNALTOWER) || !SignalData[id][signalID])
	    return SendClientMessage(playerid, COLOR_GRAD1, "   You identify Radio Tower incorrect");

	if(!strcmp(type, "location", true))
	{
	    GetPlayerPos(playerid, SignalData[id][signalX], SignalData[id][signalY], SignalData[id][signalZ]);

      	/*if(IsValidDynamicObject(SignalData[id][signalObject]))
			DestroyDynamicObject(SignalData[id][signalObject]);

     	SignalData[id][signalObject] = CreateDynamicObject(13758, SignalData[id][signalX], SignalData[id][signalY], SignalData[id][signalZ], 0.00, 0.00, 0.00);
*/
		Signal_Save(id);

		SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn: %s has adjusted the position of Radio Tower ID %d", ReturnName(playerid), id);
	}
	else if(!strcmp(type, "name", true))
	{
	    new name[64];

	    if(sscanf(string, "s[64]", name))
	        return SendSyntaxMessage(playerid, "/editsignal [id] [name] [new name]");

	    format(SignalData[id][signalName], 64, name);

	    Signal_Save(id);

		SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn: %s has adjusted the name of Radio Tower ID %d to \"%s\"", ReturnName(playerid), id, name);
	}
	else if(!strcmp(type, "range", true))
	{

	    new num;

	    if(sscanf(string, "d", num))
	        return SendSyntaxMessage(playerid, "/editsignal [id] [range] [number]");

	    SignalData[id][signalRange] = num;
	    Signal_Save(id);

	    SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn: %s has adjusted the range of Radio Tower ID %d", ReturnName(playerid), id);
	}
	return true;
}

CMD:destroysignal(playerid, params[])
{
	new
	    id = 0;

    if(PlayerData[playerid][pAdmin] < 5)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	if(sscanf(params, "d", id))
	    return SendSyntaxMessage(playerid, "/destroysignal [signal id]");

	if((id < 0 || id >= MAX_SIGNALTOWER) || !SignalData[id][signalExists])
	    return SendClientMessage(playerid, COLOR_GRAD1, "   You identify Radio Tower incorrect");

	Signal_Delete(id);
	SendClientMessageEx(playerid, COLOR_GRAD1, "   You have succeeded in destroying. Radio Tower ID: %d", id);
	return true;
}

CMD:xyz(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1337)
		return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	new Float:x, Float:y, Float:z;

	if(sscanf(params, "fff", x, y, z))
		return SendSyntaxMessage(playerid, "/goto [x] [y] [z]");

	SetPlayerDynamicPos(playerid, x, y, z);

	//DesyncPlayerInterior(playerid);

	SendClientMessage(playerid, COLOR_GREY, "You have been teleported.");
	return true;
}

CMD:goto(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
		return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	new userid, Float:x, Float:y, Float:z;

	if(sscanf(params, "u", userid))
		return SendSyntaxMessage(playerid, "/goto [playerid/PartOfName]");

	if(!AdminDuty{playerid})	
		return SendUnauthMessage(playerid, "You must be on admin duty to perform this command.");		

	if(!IsPlayerConnected(userid))
		return SendErrorMessage(playerid, "The player you specified isn't connected.");

	if(PlayerData[userid][pSpectating] != INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "This admin is currently spectating someone.");

	GetPlayerPos(userid, x, y, z);

	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		SetVehicleDynamicPos(GetPlayerVehicleID(playerid), x, y, z, playerid);
	}
	else
	{
		if(PlayerData[playerid][pFreeze])
		{
		    KillTimer(PlayerData[playerid][pFreezeTimer]);
		    PlayerData[playerid][pFreeze] = 0;
		}
		SetPlayerDynamicPos(playerid, x, y ,z);
	}

    SetPlayerInteriorEx(playerid, GetPlayerInterior(userid));
	SetPlayerVirtualWorldEx(playerid, GetPlayerVirtualWorld(userid));

	SyncPlayerToPlayer(playerid, userid);

    SendClientMessage(playerid, COLOR_GREY, " You have been teleported.");
	return true;
}

CMD:icv(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 1337)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");
    	
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT)
		return SendErrorMessage(playerid, "You need to be on foot.");

	new vehicleid = INVALID_VEHICLE_ID, Float:temp, Float:distance = 9999.0, Float:TempPos[3];

	foreach (new cars : Vehicle)
	{
	    if(GetPlayerVirtualWorld(playerid) != GetVehicleVirtualWorld(cars))
			continue;
			
		if(IsVehicleOccupied(cars) != INVALID_PLAYER_ID)
		    continue;
	
	    GetVehiclePos(cars, TempPos[0], TempPos[1], TempPos[2]);

	    temp = GetPlayerDistanceFromPoint(playerid, TempPos[0], TempPos[1], TempPos[2]);

	    if(temp < distance)
	    {
	        distance = temp;

	    	vehicleid = cars;
		}
	}

	if(vehicleid == INVALID_VEHICLE_ID)
		return SendErrorMessage(playerid, "Couldn't find a vehicle.");

    LastTeleport[playerid] = gettime();

	PutPlayerInVehicle(playerid, vehicleid, 0);

	SendClientMessage(playerid, COLOR_GREY, "You've been teleported into the closest vehicle.");
	return true;
}

CMD:gotocar(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 1)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new
		vehicleid
	;

	if(sscanf(params, "d", vehicleid))
	    return SendSyntaxMessage(playerid, "/gotocar [veh]");

	if(vehicleid < 1 || vehicleid > MAX_VEHICLES || !IsValidVehicle(vehicleid))
		return SendErrorMessage(playerid, "Invalid vehicle ID specified.");

	new
	    Float:x,
	    Float:y,
	    Float:z;

	GetVehiclePos(vehicleid, x, y, z);
	SetPlayerDynamicPos(playerid, x, y - 2, z + 2);

	DesyncPlayerInterior(playerid);
	return true;
}

CMD:getcar(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 1)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new
		vehicleid
	;

	if(sscanf(params, "d", vehicleid))
	    return SendSyntaxMessage(playerid, "/getcar [veh]");

	if(vehicleid < 1 || vehicleid > MAX_VEHICLES || !IsValidVehicle(vehicleid))
		return SendErrorMessage(playerid, "Invalid vehicle ID specified.");

	new
	    Float:x,
	    Float:y,
	    Float:z;

	GetPlayerPos(playerid, x, y, z);
	SetVehiclePos(vehicleid, x, y - 2, z + 2);
	LinkVehicleToInterior(vehicleid, 0);
	SetVehicleVirtualWorld(vehicleid, 0);
	return true;
}

CMD:lastincar(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 2)
		return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	new
		vehicleid
	;

	if(sscanf(params, "d", vehicleid))
	{
		if(!IsPlayerInAnyVehicle(playerid))
			return SendSyntaxMessage(playerid, "/lastincar [veh]");

		vehicleid = GetPlayerVehicleID(playerid);	
	}

	if(vehicleid < 1 || vehicleid > MAX_VEHICLES || !IsValidVehicle(vehicleid))
		return SendErrorMessage(playerid, "Invalid vehicle ID specified.");	

	if(CoreVehicles[vehicleid][vLastPlayerInCar] == -1 && CoreVehicles[vehicleid][vLastDriverInCar] == -1)
		return SendErrorMessage(playerid, "There is no passenger / driver data for this vehicle.");	
		
	if(CoreVehicles[vehicleid][vLastPlayerInCar] != -1 && CoreVehicles[vehicleid][vLastDriverInCar] == -1)
	{
		SendClientMessageEx(playerid, COLOR_LIGHTRED, "Last in the %s was %s (dbid: %d).", 
			ReturnVehicleName(vehicleid), 
			ReturnDBIDName(CoreVehicles[vehicleid][vLastPlayerInCar]), 
			CoreVehicles[vehicleid][vLastPlayerInCar]
		);
	}
	else if(CoreVehicles[vehicleid][vLastPlayerInCar] == -1 && CoreVehicles[vehicleid][vLastDriverInCar] != -1)
	{
		SendClientMessageEx(playerid, COLOR_LIGHTRED, "Last driver in the %s was %s (dbid: %d).", 
			ReturnVehicleName(vehicleid), 
			ReturnDBIDName(CoreVehicles[vehicleid][vLastDriverInCar]), 
			CoreVehicles[vehicleid][vLastDriverInCar]
		);
	}
	else
	{
		SendClientMessageEx(playerid, COLOR_LIGHTRED, "Last in the %s was %s (dbid: %d). Last driver was %s (dbid: %d).", 
			ReturnVehicleName(vehicleid), 
			ReturnDBIDName(CoreVehicles[vehicleid][vLastPlayerInCar]), 
			CoreVehicles[vehicleid][vLastPlayerInCar],	
			ReturnDBIDName(CoreVehicles[vehicleid][vLastDriverInCar]), 
			CoreVehicles[vehicleid][vLastDriverInCar]
		);	
	}

	//Last in the %s dbid#%d
	return true;
}

CMD:entercarseat(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 2)
		return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	new vehicleid, seat;

	if(sscanf(params, "dd", vehicleid, seat))
		return SendSyntaxMessage(playerid, "/entercarseat [vehicleid] [seat 0-3]");

	if(!IsValidVehicle(vehicleid))
	    return SendErrorMessage(playerid, "Invalid vehicle ID specified.");

	if(seat < 0 || seat > 3)
	    return SendErrorMessage(playerid, "Invalid seat specified.");

	LastTeleport[playerid] = gettime();	

	SetPlayerInterior(playerid, 0); SetPlayerVirtualWorld(playerid, GetVehicleVirtualWorld(vehicleid));
	PutPlayerInVehicle(playerid, vehicleid, seat);

	SendAdminAlert(COLOR_YELLOW, GAME_ADMINS, "AdmWarn(2): %s has teleported into seat %d of car %d.", ReturnName(playerid), seat, vehicleid);
	return true;
}

CMD:explosion(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 2)
		return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new userid, Float:slx, Float:sly, Float:slz;

	if(sscanf(params, "u", userid))
		return SendSyntaxMessage(playerid, "/explosion [playerid]");

	if(!IsPlayerConnected(userid))
		return SendErrorMessage(playerid, "The player you specified isn't connected.");

	GetPlayerPos(userid, slx, sly, slz);
	CreateExplosion(slx, sly, slz, 7, 1.00);

	SendAdminAlert(COLOR_YELLOW, GAME_ADMINS, "AdmWarn(2): %s exploded player %s.", ReturnName(playerid), ReturnName(userid));
	return true;
}

CMD:gotofs(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
		return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	new faction, spawn;

	if(sscanf(params, "dd", faction, spawn))
	{
		/*new str[MAX_PLAYER_NAME + (64 * 5)], count;

		for(new i = 0; i < 5; ++i)
		{
		    if(FactionSpawns[faction][i][spawnID] != 0)
			{
				format(str, sizeof(str), "%s[%d: %s]", str, i, FactionSpawns[faction][i][spawnName]);

				count++;
			}
		}

		if(!count) return SendErrorMessages(playerid, "This faction doesn't have any spawns.");

		if(strlen(str) > 128)
		{
		    SendClientMessageEx(playerid, COLOR_GREY, "%.128s", str);
		    SendClientMessageEx(playerid, COLOR_GREY, "%s", str[128]);
		}
		else SendClientMessage(playerid, COLOR_GREY, str);*/

	    return SendSyntaxMessage(playerid, "/gotofs [factionid] [spawn-id]");
	}

	if((faction < 0 || faction >= MAX_FACTIONS) || !FactionData[faction][factionExists])
	    return SendNoticeMessage(playerid, "You specified an invalid faction.");

	if((spawn < 0 || spawn >= 5) || FactionSpawns[faction][spawn][spawnID] < 1)
	    return SendNoticeMessage(playerid, "This spawn point doesn't exist.");

	SetPlayerPosEx(playerid, FactionSpawns[faction][spawn][factionSpawn][0], FactionSpawns[faction][spawn][factionSpawn][1], FactionSpawns[faction][spawn][factionSpawn][2] + 0.5);
	SetPlayerFacingAngle(playerid, FactionSpawns[faction][spawn][factionSpawn][3]);

	if(FactionSpawns[faction][spawn][spawnApartment] != -1)
	{
		new id = FactionSpawns[faction][spawn][spawnApartment];

		if(Iter_Contains(Complex, id))
		{
		    SetPlayerInteriorEx(playerid, ComplexData[id][aInterior]);
		    SetPlayerVirtualWorldEx(playerid, ComplexData[id][aWorld]);

			InApartment[playerid] = id;
			InProperty[playerid] = -1;
			InBusiness[playerid] = -1;

			PlayerData[playerid][pLocal] = id + LOCAL_APARTMENT;
		}
	}
	else
	{
		SetPlayerInteriorEx(playerid, FactionSpawns[faction][spawn][spawnInt]);
		SetPlayerVirtualWorldEx(playerid, FactionSpawns[faction][spawn][spawnWorld]);
	}
	return true;
}

CMD:p2p(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
		return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	new userid, targetid;

	if(sscanf(params, "uu", userid, targetid))
		return SendSyntaxMessage(playerid, "/p2p [playerid] [targetid]");

	if(!IsPlayerConnected(userid) || !IsPlayerConnected(targetid))
		return SendErrorMessage(playerid, "A player you specified isn't connected to the server.");

	new Float:PlayerPos[3];

	GetPlayerPos(targetid, PlayerPos[0], PlayerPos[1], PlayerPos[2]);
	SetPlayerDynamicPos(userid, PlayerPos[0], PlayerPos[1], PlayerPos[2]);
	SetPlayerInterior(userid, GetPlayerInterior(targetid)); SetPlayerVirtualWorld(userid, GetPlayerVirtualWorld(targetid));

	SyncPlayerToPlayer(userid, targetid);

	SendClientMessage(userid, COLOR_GREY, "You have been teleported.");

	SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(1): %s teleported %s [%d] to %s [%d]", ReturnName(playerid), ReturnName(userid), userid, ReturnName(targetid), targetid);
	return true;
}

stock SyncPlayerToPlayer(playerid, userid)
{
    InProperty[playerid] = InProperty[userid];
    InBusiness[playerid] = InBusiness[userid];
	InApartment[playerid] = InApartment[userid];
	PlayerData[playerid][pLocal] = PlayerData[userid][pLocal];
}

CMD:p2v(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
		return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	new userid, vehicleid;

	if(sscanf(params, "ud", userid, vehicleid))
		return SendSyntaxMessage(playerid, "/p2v [playerid] [vehicleid]");

	if(!IsPlayerConnected(userid))
		return SendErrorMessage(playerid, "The player you specified isn't connected.");

	if(!IsValidVehicle(vehicleid))
	    return SendErrorMessage(playerid, "Invalid vehicle ID specified.");

	new Float:VehiclePos[3];

	GetVehiclePos(vehicleid, VehiclePos[0], VehiclePos[1], VehiclePos[2]);
	SetPlayerDynamicPos(userid, VehiclePos[0], VehiclePos[1] - 2, VehiclePos[2] + 2);

    DesyncPlayerInterior(userid);

	SetPlayerInteriorEx(userid, 0);
	SetPlayerVirtualWorldEx(userid, GetVehicleVirtualWorld(vehicleid));

    SendClientMessage(userid, COLOR_GREY, "You have been teleported.");

	SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(1): %s teleported %s [%d] to vehicle [%d]", ReturnName(playerid), ReturnName(userid), userid, vehicleid);
	return true;
}

CMD:p2iw(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
		return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	new userid, interior, world;

	if(sscanf(params, "udd", userid, interior, world))
		return SendSyntaxMessage(playerid, "/p2iw [playerid] [interior] [world]");

	if(!IsPlayerConnected(userid))
		return SendErrorMessage(playerid, "The player you specified isn't connected.");

	SetPlayerInterior(userid, interior);
	SetPlayerVirtualWorld(userid, world);

	SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(1): %s teleported %s [%d] to Interior [%d] and World [%d]", ReturnName(playerid), ReturnName(userid), userid, interior, world);
	return true;
}

CMD:p2fs(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
		return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	new userid, faction;

	if(sscanf(params, "ud", userid,  faction))
		return SendSyntaxMessage(playerid, "/p2fs [playerid] [factionid]");

	if(!IsPlayerConnected(userid))
		return SendErrorMessage(playerid, "The player you specified isn't connected.");

	if((faction < 0 || faction >= MAX_FACTIONS) || !FactionData[faction][factionExists])
	    return SendNoticeMessage(playerid, "You specified an invalid faction.");

	SetPlayerPosEx(userid, FactionSpawns[faction][0][factionSpawn][0], FactionSpawns[faction][0][factionSpawn][1], FactionSpawns[faction][0][factionSpawn][2] + 0.5);
	SetPlayerFacingAngle(userid, FactionSpawns[faction][0][factionSpawn][3]);

	if(FactionSpawns[faction][0][spawnApartment] != -1)
	{
		new id = FactionSpawns[faction][0][spawnApartment];

		if(Iter_Contains(Complex, id))
		{
		    SetPlayerInteriorEx(userid, ComplexData[id][aInterior]);
		    SetPlayerVirtualWorldEx(userid, ComplexData[id][aWorld]);

			InApartment[userid] = id;
			InProperty[userid] = -1;
			InBusiness[userid] = -1;

			PlayerData[userid][pLocal] = id + LOCAL_APARTMENT;
		}
	}
	else
	{
		SetPlayerInteriorEx(userid, FactionSpawns[faction][0][spawnInt]);
		SetPlayerVirtualWorldEx(userid, FactionSpawns[faction][0][spawnWorld]);
	}

	SendClientMessage(userid, COLOR_GREY, "You have been teleported.");

	SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(1): %s teleported %s to %s (#%d) faction spawn.", ReturnName(playerid), ReturnName(userid), FactionData[faction][factionAbbrv], faction);
	return true;
}

CMD:gethere(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
		return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	new userid, Float:x, Float:y, Float:z;

	if(sscanf(params, "u", userid))
		return SendSyntaxMessage(playerid, "/gethere [playerid]");

	if(!AdminDuty{playerid})	
		return SendUnauthMessage(playerid, "You must be on admin duty to perform this command.");		

	if(!IsPlayerConnected(userid))
		return SendErrorMessage(playerid, "The player you specified isn't connected.");

	if(PlayerData[userid][pSpectating] != INVALID_PLAYER_ID)
	    return SendErrorMessage(playerid, "This admin is currently spectating someone.");

	if(PlayerData[userid][pInTuning])
	    return SendErrorMessage(playerid, "Player is currently in tunning menu.");

	GetPlayerPos(playerid, x, y, z);

	if(GetPlayerState(userid) == PLAYER_STATE_DRIVER) SetVehicleDynamicPos(GetPlayerVehicleID(userid), x, y, z, userid);
	else
	{
		if(PlayerData[userid][pFreeze])
		{
		    KillTimer(PlayerData[userid][pFreezeTimer]);
		    PlayerData[userid][pFreeze] = 0;
		}

		SetPlayerDynamicPos(userid, x, y ,z);
	}

    SetPlayerInteriorEx(userid, GetPlayerInterior(playerid));
	SetPlayerVirtualWorldEx(userid, GetPlayerVirtualWorld(playerid));

    SyncPlayerToPlayer(userid, playerid);

    SendClientMessage(playerid, COLOR_GREY, "1 player/s teleported.");
    SendClientMessage(userid, COLOR_GREY, "You have been teleported.");
	return true;
}

CMD:sf(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 2)
  		return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new
	    userid
	;

	if(sscanf(params, "u", userid))
	    return SendSyntaxMessage(playerid, "/sf [playerid/PartOfName]");

	if(!IsPlayerConnected(userid))
		return SendErrorMessage(playerid, "The player you specified isn't connected.");

	TogglePlayerControllable(userid, false);
	PlayerData[playerid][pAdminFreeze] = 1;

	SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(1): %s silently froze player %s.", ReturnName(playerid), ReturnName(userid));
	return true;
}

CMD:freeze(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1 && !IsTester(playerid))
  		return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new userid;

	if(sscanf(params, "u", userid))
	    return SendSyntaxMessage(playerid, "/freeze [playerid/PartOfName]");

	if(!IsPlayerConnected(userid))
		return SendErrorMessage(playerid, "The player you specified isn't connected.");

	TogglePlayerControllable(userid, false);
	PlayerData[playerid][pAdminFreeze] = 1;

	format(sgstr, sizeof(sgstr), "AdmCmd: %s was Frozen by %s", ReturnName(userid), ReturnName(playerid));
	ProxDetectorOOC(playerid, 20.0, sgstr);

	SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(1): %s froze player %s.", ReturnName(playerid), ReturnName(userid));

	SQL_LogAction(userid, "AdmCmd: %s was Frozen by %s", ReturnName(userid), ReturnName(playerid));
	return true;
}

YCMD:unfreeze(playerid, params[], help) = thaw;

CMD:thaw(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
  		return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new
	    userid
	;

	if(sscanf(params, "u", userid))
	    return SendSyntaxMessage(playerid, "/thaw [playerid/PartOfName]");

	if(!IsPlayerConnected(userid))
		return SendErrorMessage(playerid, "The player you specified isn't connected.");

	TogglePlayerControllable(userid, true);
	PlayerData[playerid][pAdminFreeze] = 0;

	format(sgstr, sizeof(sgstr), "AdmCmd: %s was UnFrozen by %s", ReturnName(userid), ReturnName(playerid));
	ProxDetectorOOC(playerid, 20.0, sgstr);

	SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(1): %s unfroze player %s.", ReturnName(playerid), ReturnName(userid));

	SQL_LogAction(userid, "AdmCmd: %s was UnFrozen by %s", ReturnName(userid), ReturnName(playerid));
	return true;
}

CMD:mute(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
  		return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new
		userid
	;

	if(sscanf(params, "u", userid))
	    return SendSyntaxMessage(playerid, "/mute [playerid/PartOfName]");

	if(!IsPlayerConnected(userid))
		return SendErrorMessage(playerid, "The player you specified isn't connected.");

	if(PlayerData[userid][pMuted])
	{
		PlayerData[userid][pMuted] = 0;

		SendClientMessageEx(userid, COLOR_LIGHTRED, "You were un-muted by admin %s.", ReturnName(playerid));

		format(sgstr, sizeof(sgstr), "%s was un-muted by admin %s.", ReturnName(userid), ReturnName(playerid));
		ProxDetectorOOC(playerid, 20.0, sgstr);

		SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(1): %s un-muted player %s.", ReturnName(playerid), ReturnName(userid));

		SQL_LogAction(userid, "AdmCmd: %s was UnMuted by %s", ReturnName(userid), ReturnName(playerid));
	}
	else
	{
		PlayerData[userid][pMuted] = 1;

		SendClientMessageEx(userid, COLOR_LIGHTRED, "You were muted by admin %s.", ReturnName(playerid));
		SendClientMessage(userid, COLOR_LIGHTRED, "[ ! ]{AFAFAF} You cannot use OOC chat for the time being. Using IC chats to avoid the mute is not allowed.");

		format(sgstr, sizeof(sgstr), "%s was muted by admin %s.", ReturnName(userid), ReturnName(playerid));
		ProxDetectorOOC(playerid, 20.0, sgstr);

		SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(1): %s muted player %s.", ReturnName(playerid), ReturnName(userid));

		SQL_LogAction(userid, "AdmCmd: %s was Muted by %s", ReturnName(userid), ReturnName(playerid));
	}
	return true;
}

CMD:playsound(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 4)
		return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new userid, soundid;

	if(sscanf(params, "ud", userid, soundid))
		return SendSyntaxMessage(playerid, "/playsound [playerid/PartOfName] [soundid]");

	if(!IsPlayerConnected(userid))
		return SendErrorMessage(playerid, "The player you specified isn't connected.");

	PlayerPlaySoundEx(playerid, soundid);
	return true;
}

CMD:slapcar(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
		return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new vehicleid, Float:slx, Float:sly, Float:slz;

	if(sscanf(params, "i", vehicleid))
		return SendSyntaxMessage(playerid, "/slapcar [vehicleid]");

	if(!IsValidVehicle(vehicleid))
		return SendErrorMessage(playerid, "You specified an invalid vehicle.");

	GetVehiclePos(vehicleid, slx, sly, slz);
	SetVehiclePos(vehicleid, slx, sly, slz + 5);

	SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(1): %s slapped vehicle %d.", ReturnName(playerid), vehicleid);
	return true;
}

CMD:slap(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
		return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new userid, Float:slx, Float:sly, Float:slz;

	if(sscanf(params, "u", userid))
		return SendSyntaxMessage(playerid, "/slap [playerid]");

	if(!IsPlayerConnected(userid))
		return SendErrorMessage(playerid, "The player you specified isn't connected.");

	if(PlayerData[userid][pInTuning])
	    return SendErrorMessage(playerid, "Player is currently in tunning menu.");

	GetPlayerPos(userid, slx, sly, slz);
	SetPlayerDynamicPos(userid, slx, sly, slz + 5);
	PlayerPlaySound(userid, 1130, slx, sly, slz + 5);

	format(sgstr, sizeof(sgstr), "AdmCmd: %s was slapped by %s", ReturnName(userid), ReturnName(playerid));
	ProxDetectorOOC(playerid, 20.0, sgstr);

	SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(1): %s slapped player %s.", ReturnName(playerid), ReturnName(userid));

	SQL_LogAction(userid, "AdmCmd: %s was slapped by %s", ReturnName(userid), ReturnName(playerid));
	return true;
}

CMD:gotopizza(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
		return SendErrorMessage(playerid, "You're not authorized to use this command.");

	SetPlayerDynamicPos(playerid, 2087.6670,-1806.5240,13.5469);
	SetPlayerInterior(playerid, 0);
	SetPlayerVirtualWorld(playerid, 0);
	SendClientMessage(playerid, COLOR_GREY, "You have been teleported to Pizza Stacks.");

    DesyncPlayerInterior(playerid);
	return true;
}

CMD:gotospawn(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
  		return SendErrorMessage(playerid, "You're not authorized to use this command.");

	if(GetPlayerState(playerid) == 2)
	{
		new tmpcar = GetPlayerVehicleID(playerid);
		SetVehicleDynamicPos(tmpcar, 1643.0010, -2331.7056, -2.6797, playerid);
		LinkVehicleToInterior(tmpcar, 0);
		SetVehicleVirtualWorld(tmpcar, 0);
	}
	else
	{
		SetPlayerDynamicPos(playerid, 1643.0010,-2331.7056,-2.6797);
		SendClientMessage(playerid, COLOR_GREY, "You have been teleported to Airport.");
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
	}

    DesyncPlayerInterior(playerid);
	return true;
}

CMD:gotoprison(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
  		return SendErrorMessage(playerid, "You're not authorized to use this command.");

	SetPlayerPosEx(playerid, 1251.0468, 896.0416, 1161.0986);
	SyncPrisonInterior(playerid, true);
	return true;
}

CMD:gotols(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
  		return SendErrorMessage(playerid, "You're not authorized to use this command.");

	if(GetPlayerState(playerid) == 2)
	{
		new tmpcar = GetPlayerVehicleID(playerid);
		SetVehicleDynamicPos(tmpcar, 1529.6,-1691.2,13.3, playerid);
		LinkVehicleToInterior(tmpcar, 0);
		SetVehicleVirtualWorld(tmpcar, 0);
	}
	else
	{
		SetPlayerDynamicPos(playerid, 1529.6,-1691.2,13.3);
		SendClientMessage(playerid, COLOR_GREY, "You have been teleported to Los Santos.");
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
	}

    DesyncPlayerInterior(playerid);
	return true;
}

CMD:gotosf(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 1)
  		return SendErrorMessage(playerid, "You're not authorized to use this command.");

    if(GetPlayerState(playerid) == 2)
	{
		new tmpcar = GetPlayerVehicleID(playerid);
		SetVehicleDynamicPos(tmpcar, -1417.0,-295.8,14.1, playerid);
		LinkVehicleToInterior(tmpcar, 0);
		SetVehicleVirtualWorld(tmpcar, 0);
	}
	else
	{
		SetPlayerDynamicPos(playerid, -1417.0,-295.8,14.1);
		SendClientMessage(playerid, COLOR_GREY, "You have been teleported to San Fierro.");
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
	}

    DesyncPlayerInterior(playerid);
	return true;
}

CMD:gotolv(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 1)
  		return SendErrorMessage(playerid, "You're not authorized to use this command.");

    if(GetPlayerState(playerid) == 2)
	{
		new tmpcar = GetPlayerVehicleID(playerid);
		SetVehicleDynamicPos(tmpcar, 1699.2, 1435.1, 10.7, playerid);
		LinkVehicleToInterior(tmpcar, 0);
		SetVehicleVirtualWorld(tmpcar, 0);
	}
	else
	{
		SetPlayerDynamicPos(playerid, 1699.2,1435.1, 10.7);
		SendClientMessage(playerid, COLOR_GREY, "You have been teleported to Las Venturas.");
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
	}

    DesyncPlayerInterior(playerid);
	return true;
}

CMD:gopos(playerid, params[])
{
    new Float:Pos[3], int;

	if(PlayerData[playerid][pAdmin] < 4)
		return SendErrorMessage(playerid, "You're not authorized to use this command.");

	if(sscanf(params, "fffi", Pos[0], Pos[1], Pos[2], int))
		return SendSyntaxMessage(playerid, "/gopos [x] [y] [z] [int]");

	SetPlayerDynamicPos(playerid, Pos[0], Pos[1], Pos[2]);
	SetPlayerInterior(playerid, int);

    DesyncPlayerInterior(playerid);
	return true;
}

CMD:gocp(playerid, params[])
{
	if(gPlayerCheckpointStatus[playerid] == CHECKPOINT_NONE)
		return 1;

	if(PlayerData[playerid][pAdmin] < 4)
		return SendErrorMessage(playerid, "You're not authorized to use this command.");

	SetPlayerPosEx(playerid, gPlayerCheckpointX[playerid], gPlayerCheckpointY[playerid], gPlayerCheckpointZ[playerid]);
	SetPlayerInterior(playerid, 0);
	SetPlayerVirtualWorld(playerid, 0);

	DesyncPlayerInterior(playerid);
	return true;
}

CMD:gorcp(playerid, params[])
{
	if(PlayerData[playerid][pCP_Type] == -1)
		return true;

	if(PlayerData[playerid][pAdmin] < 4)
		return SendErrorMessage(playerid, "You're not authorized to use this command.");

	SetPlayerPosEx(playerid, PlayerData[playerid][pCP_X], PlayerData[playerid][pCP_Y], PlayerData[playerid][pCP_Z]);
	SetPlayerInterior(playerid, 0);
	SetPlayerVirtualWorld(playerid, 0);

	DesyncPlayerInterior(playerid);
	return true;
}

CMD:backup(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	foreach (new i : Player) SQL_SaveCharacter(i, false);
	foreach (new i : Property) Property_Save(i);
	foreach (new i : Business) Business_Save(i);
	foreach (new i : Complex) Complex_Save(i);
	foreach (new i : sv_playercar) Car_SaveID(i);

    SendServerMessage(playerid, "You have saved all the information.");
	return true;
}

YCMD:cac(playerid, params[], help) = clearallchat;

CMD:clearallchat(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	for(new i = 0; i < 50; ++i)
	{
		SendClientMessageToAll(COLOR_WHITE, " ");
	}
	return true;
}

CMD:clearguns(playerid, params[])
{
	new
	    userid;

    if(PlayerData[playerid][pAdmin] < 1)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	if(sscanf(params, "u", userid))
	    return SendSyntaxMessage(playerid, "/clearguns [playerid/PartOfName]");

	if(!IsPlayerConnected(userid))
		return SendErrorMessage(playerid, "The player you specified isn't connected.");

	ResetWeapons(userid);

	SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(1): %s disarmed player %s.", ReturnName(playerid), ReturnName(userid));
	return true;
}

CMD:checkafk(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	SendClientMessage(playerid, COLOR_LIGHTRED, "Listing all AFK players...");

	foreach (new i : Player)
	{
		if(IsAFK{i})
		{
			SendClientMessageEx(playerid, COLOR_LIGHTRED, "[ID: %d] %s: %d seconds", i, ReturnName(i), AFKCount[i]);
		}
	}

	return true;
}

CMD:masked(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	SendClientMessage(playerid, COLOR_LIGHTRED, "Listing all masked players...");

	foreach (new i : Player)
	{
		if(IsMasked{i})
		{
			SendClientMessageEx(playerid, COLOR_LIGHTRED, "[ID: %d] %s: [Mask %i_%i]", i, ReturnName(i), PlayerData[i][pMaskID][0], PlayerData[i][pMaskID][1]);
		}
	}

	return true;
}

CMD:ismasked(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new
		userid
	;

	if(sscanf(params, "u", userid))
		return SendSyntaxMessage(playerid, "/isafk [playerid/PartOfName]");

	if(!IsPlayerConnected(userid))
		return SendErrorMessage(playerid, "The player you specified isn't connected.");

	if(IsMasked{userid})
	    SendNoticeMessage(playerid, "%s (%d) is masked [Mask %i_%i].", ReturnName(userid), userid, PlayerData[userid][pMaskID][0], PlayerData[userid][pMaskID][1]);
	else
	    SendNoticeMessage(playerid, "%s (%d) is not masked.", ReturnName(userid), userid);

	return true;
}

/*CMD:fly(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1337) return false;
	if(PfSpec[playerid][FlySpec] == 0) StartFlyEditor(playerid);
	else if(PfSpec[playerid][FlySpec] == 1) EndFlyEditor(playerid);
	return true;
}*/

CMD:biztypes(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	SendClientMessage(playerid, COLOR_GRAD2, "1: Gas Station | 2: Ammunation | 3: 24/7 4: Vehicle Dealership | 5: Car Modding Shop | 6: Pay & Spray | 7: Clothing Shop");
	SendClientMessage(playerid, COLOR_GRAD2, "8: Bars | 9: Restaurant | 10: Furniture Shop | 11: Advertisement Center | 12: Bank | 13: Weapon Factory");
	return true;
}

CMD:showbusinesses(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	gstr[0] = EOS;

	for(new i = 0; i != sizeof(BusinessData); ++i)
	{
		if(BusinessData[i][bID])
		{
			format(gstr, sizeof(gstr), "%s\n<%d>{66FF66}%s", gstr, i, BusinessData[i][bInfo]);
		}
	}

	Dialog_Show(playerid, AdminBusinesses, DIALOG_STYLE_LIST, ""EMBED_YELLOW"Admin Business(s):"EMBED_RED"", gstr, "Teleport", "Cancel");
	return true;
}

CMD:whatbusiness(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

    new str[128];

	foreach (new i : Business)
	{
		if(IsPlayerInRangeOfPoint(playerid, 3.0, BusinessData[i][bEntranceX], BusinessData[i][bEntranceY], BusinessData[i][bEntranceZ]))
		{
			format(str, sizeof(str), "You're standing near business: [Normal ID: %d] [MySQL ID: %d]", i, BusinessData[i][bID]);
			SendClientMessage(playerid, COLOR_WHITE, str);
			break;
		}
	}
	return true;
}

CMD:makebusiness(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new bizid = Iter_Free(Business), level, price, type, Float:x, Float:y, Float:z;

	if(sscanf(params, "ddd", level, price, type))
		return SendSyntaxMessage(playerid, "/makebusiness [buylevel] [price] [type(/biztypes)]");

	if(type < 1 || type > 13)
		return SendClientMessage(playerid, COLOR_GRAD2, "Invalid business type (1-13).");

	if(bizid != -1)
	{
		GetPlayerPos(playerid, x, y, z);

		BusinessData[bizid][bEntranceX] = x;
		BusinessData[bizid][bEntranceY] = y;
		BusinessData[bizid][bEntranceZ] = z;
		BusinessData[bizid][bExitX] = 0.0;
		BusinessData[bizid][bExitY] = 0.0;
		BusinessData[bizid][bExitZ] = 0.0;
		BusinessData[bizid][bLevelNeeded] = level;
		BusinessData[bizid][bBuyPrice] = price;
		BusinessData[bizid][bOwned] = 0;
		BusinessData[bizid][bLocked] = 0;
		BusinessData[bizid][bInterior] = 0;
		BusinessData[bizid][bWorld] = bizid;
		BusinessData[bizid][bTill] = 0;
		BusinessData[bizid][bEntranceCost] = 0;
		BusinessData[bizid][bProducts] = 0;
		format(BusinessData[bizid][bOwner], 24, "The State");
		format(BusinessData[bizid][bInfo], 80, "Business");
		BusinessData[bizid][bType] = type;

		if(type == 12 || type == 11 || type == 10)
		{
            BusinessData[bizid][bOwned] = 1;
		}

		switch(type)
		{
		    case 1: { // Gas Station
		        format(BusinessData[bizid][bInfo], 80, "Gas Station");
		        BusinessData[bizid][bItems][0] = 50;
                BusinessData[bizid][bMaxProducts] = 2400;
		    }
		    case 2: { // Ammunations
		        format(BusinessData[bizid][bInfo], 80, "Ammunations");
                BusinessData[bizid][bMaxProducts] = 1000;
		    }
		    case 3: { // 24-7
		        format(BusinessData[bizid][bInfo], 80, "24-7");

		        BusinessData[bizid][bItems][0] = 500;
		        BusinessData[bizid][bItems][1] = 10000;
		        BusinessData[bizid][bItems][2] = 1500;
		        BusinessData[bizid][bItems][3] = 500;
		        BusinessData[bizid][bItems][4] = 200;
		        BusinessData[bizid][bItems][5] = 500;
		        BusinessData[bizid][bItems][6] = 5000;
		        BusinessData[bizid][bItems][7] = 200;
		        BusinessData[bizid][bItems][8] = 500;
		        BusinessData[bizid][bItems][9] = 2000;
		        BusinessData[bizid][bItems][10] = 5000;
		        BusinessData[bizid][bItems][11] = 8000;

                BusinessData[bizid][bMaxProducts] = 500;
		    }
		    case 4: {
		        format(BusinessData[bizid][bInfo], 80, "Vehicle Dealerships");
		        BusinessData[bizid][bMaxProducts] = 200;
		    }
		    case 5: {
		        format(BusinessData[bizid][bInfo], 80, "Car Modding Shops");
		        BusinessData[bizid][bMaxProducts] = 1000;
		    }
		    case 6: {
		        format(BusinessData[bizid][bInfo], 80, "Pay & Spray");
		        BusinessData[bizid][bMaxProducts] = 600;
		    }
		    case 7: {
		        format(BusinessData[bizid][bInfo], 80, "Clothing Shops");
		        BusinessData[bizid][bMaxProducts] = 500;
		    }
		    case 8: {
		        format(BusinessData[bizid][bInfo], 80, "Bars");
		        BusinessData[bizid][bMaxProducts] = 500;
		    }
		    case 9: { // Restaurant
		        format(BusinessData[bizid][bInfo], 80, "Restaurant");
		        BusinessData[bizid][bItems][0] = 100;
		        BusinessData[bizid][bItems][1] = 200;
		        BusinessData[bizid][bItems][2] = 300;
		        BusinessData[bizid][bItems][3] = 300;
		        BusinessData[bizid][bMaxProducts] = 500;
		    }
		    case 10: {
		        format(BusinessData[bizid][bInfo], 80, "Furniture Shop");
		        BusinessData[bizid][bMaxProducts] = 10000;
		    }
		    case 11: { // Advertisement
		        format(BusinessData[bizid][bInfo], 80, "Advertisement");
                BusinessData[bizid][bMaxProducts] = 5000;
		    }
		    case 12: { // Bank
		        format(BusinessData[bizid][bInfo], 80, "Bank");
                BusinessData[bizid][bMaxProducts] = 10000;
		    }
		    case 13: { // Weapon Factory
		        format(BusinessData[bizid][bInfo], 80, "Weapon Factory");
                BusinessData[bizid][bMaxProducts] = 300;
		    }
		}

		BusinessData[bizid][bsubType] = 0;
		BusinessData[bizid][bPickup] = CreateDynamicPickup(1239, 2, x, y, z, -1, -1, -1, 100.0);

		AddBizToFile(bizid, price, type, BusinessData[bizid][bOwner], BusinessData[bizid][bInfo], x, y, z);

		SendClientMessageEx(playerid, COLOR_GREEN, "The new business has been added [Level: %d Price: %d Type: %s]", level, price, BusinessData[bizid][bInfo]);
	}
	return true;
}

CMD:removebusiness(playerid, params[])
{
	new bizid, msg[128];

	if(PlayerData[playerid][pAdmin] < 4)
  		return SendErrorMessage(playerid, "You're not authorized to use this command.");

    if((bizid = Business_Nearest(playerid)) != -1)
	{
		DestroyDynamicPickup(BusinessData[bizid][bPickup]);

		new ply = INVALID_PLAYER_ID;

		if((ply = GetIDByName(BusinessData[bizid][bOwner])) != INVALID_PLAYER_ID)
		{
			PlayerData[ply][pPbiskey] = -1;

			SendClientMessageEx(ply, COLOR_GRAD2, "An administrator has removed your business from the database.", ReturnName(playerid));

			if(BusinessData[bizid][bTill] > 0)
			{
				SendClientMessageEx(ply, COLOR_GRAD2, "You got back $%d from the till.", BusinessData[bizid][bTill]);

				SendPlayerMoney(ply, BusinessData[bizid][bTill]);
			}
		}
		else
		{
			mysql_format(dbCon, msg, sizeof(msg), "UPDATE `characters` SET `PlayerBusinessKey` = -1 WHERE `char_name` = '%e'", BusinessData[bizid][bOwner]);
			mysql_tquery(dbCon, msg);

			if(BusinessData[bizid][bTill] > 0)
			{
				mysql_format(dbCon, msg, sizeof(msg), "UPDATE `characters` SET `Cash` = (Cash + %d) WHERE `char_name` = '%e'", BusinessData[bizid][bTill], BusinessData[bizid][bOwner]);
				mysql_tquery(dbCon, msg);
			}
		}

		mysql_format(dbCon, msg, sizeof(msg), "DELETE FROM `business` WHERE `biz_id` = '%d' LIMIT 1", BusinessData[bizid][bID]);
		mysql_tquery(dbCon, msg, "OnBizRemove", "i", bizid);

		SendClientMessageEx(playerid, COLOR_YELLOW, "-> You've successfully destroyed business #%d.", bizid);

		Iter_Remove(Business, bizid);
	}
	return true;
}

CMD:asellbusiness(playerid, params[])
{
	new bizid, msg[128];

	if(PlayerData[playerid][pAdmin] < 4)
  		return SendErrorMessage(playerid, "You're not authorized to use this command.");

	if(sscanf(params, "d", bizid))
		return SendSyntaxMessage(playerid, "/asellbusiness [bizid]");

	if(!BusinessData[bizid][bID])
		return SendClientMessage(playerid, COLOR_GRAD2, "Invalid business ID.");

	if(!BusinessData[bizid][bOwned])
		return SendClientMessage(playerid, COLOR_GRAD2, "No one bought this business.");

	new ply = INVALID_PLAYER_ID;

	if((ply = GetIDByName(BusinessData[bizid][bOwner])) != INVALID_PLAYER_ID)
	{
		PlayerData[ply][pPbiskey] = -1;

		format(msg, sizeof(msg), "An administrator %s have sold your business to the market.", ReturnName(playerid));
		SendClientMessage(ply, COLOR_GRAD2, msg);

		if(BusinessData[bizid][bTill] > 0)
		{
			format(msg, sizeof(msg), "Your money is in Cashbox you get back $%d", BusinessData[bizid][bTill]);
			SendClientMessage(ply, COLOR_GRAD2, msg);

			SendPlayerMoney(ply, BusinessData[bizid][bTill]);
		}
	}
	else
	{
		format(msg, sizeof(msg), "UPDATE `characters` SET `PlayerBusinessKey` = %d WHERE `char_name` = '%s'", -1, BusinessData[bizid][bOwner]);
		mysql_tquery(dbCon, msg);

		if(BusinessData[bizid][bTill] > 0)
		{
			format(msg, sizeof(msg), "UPDATE `characters` SET `Cash` = (Cash + %d) WHERE `char_name` = '%s'", BusinessData[bizid][bTill], BusinessData[bizid][bOwner]);
			mysql_tquery(dbCon, msg);
		}
	}

	mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `business` SET `biz_owner` = '%e', `biz_owned` = %d, `biz_locked` = %d, `biz_till` = %d, `biz_encost` = %d WHERE `biz_id` = %d", "The State", 0, 1, 0, 0, BusinessData[bizid][bID]);
	mysql_tquery(dbCon, gquery, "OnAdminSellBusiness", "i", bizid);
	return true;
}

CMD:businessenter(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4)
		return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new bizid;

    if(sscanf(params, "d", bizid))
		return SendSyntaxMessage(playerid, "/businessenter [bizid]");

	if(!BusinessData[bizid][bID])
		return SendClientMessage(playerid, COLOR_GRAD2, "Invalid business ID.");

	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);

	DestroyDynamicPickup(BusinessData[bizid][bPickup]);

	BusinessData[bizid][bPickup] = CreateDynamicPickup(1239, 2, x, y, z, -1, -1, -1, 100.0);

	mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `business` SET `biz_enX` = '%.4f', `biz_enY` = '%.4f', `biz_enZ` = '%.4f' WHERE `biz_id` = %d", x, y, z, BusinessData[bizid][bID]);
	mysql_pquery(dbCon, gquery);

	BusinessData[bizid][bEntranceX] = x;
	BusinessData[bizid][bEntranceY] = y;
	BusinessData[bizid][bEntranceZ] = z;

	SendClientMessage(playerid, COLOR_GRAD2, "Succeeded");
	return true;
}

CMD:businessex1(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4)
		return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new bizid, status;

    if(sscanf(params, "dD()", bizid, status))
		return SendSyntaxMessage(playerid, "/businessex1 [bizid] [1-Disabled]");

	if(!BusinessData[bizid][bID])
		return SendClientMessage(playerid, COLOR_GRAD2, "Invalid business ID.");

	if(status)
	{
		mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `business` SET `biz_carX` = '%.4f', `biz_carY` = '%.4f', `biz_carZ` = '%.4f', `biz_carA` = '%.4f' WHERE `biz_id` = %d", 0.0, 0.0, 0.0, 0.0, BusinessData[bizid][bID]);
		mysql_tquery(dbCon, gquery);

		BusinessData[bizid][bBuyingCarX] = 0.0;
		BusinessData[bizid][bBuyingCarY] = 0.0;
		BusinessData[bizid][bBuyingCarZ] = 0.0;
		BusinessData[bizid][bBuyingCarA] = 0.0;

	    SendClientMessage(playerid, COLOR_GRAD2, "Succeeded");
	}
	else
	{
		new Float:x, Float:y, Float:z, Float:a;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, a);

		mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `business` SET `biz_carX` = '%.4f', `biz_carY` = '%.4f', `biz_carZ` = '%.4f', `biz_carA` = '%.4f' WHERE `biz_id` = %d", x, y, z, a, BusinessData[bizid][bID]);
		mysql_tquery(dbCon, gquery);

		BusinessData[bizid][bBuyingCarX] = x;
		BusinessData[bizid][bBuyingCarY] = y;
		BusinessData[bizid][bBuyingCarZ] = z;
		BusinessData[bizid][bBuyingCarA] = a;

		SendClientMessage(playerid, COLOR_GRAD2, "Succeeded");
	}
	return true;
}

CMD:businessex2(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4)
		return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new bizid, status;

    if(sscanf(params,"dD()",bizid, status))
		return SendSyntaxMessage(playerid, "/businessex2 [bizid] [1-Disabled]");

	if(!BusinessData[bizid][bID])
		return SendClientMessage(playerid, COLOR_GRAD2, "Invalid business ID.");

	if(status)
	{
		format(gquery, sizeof(gquery), "UPDATE `business` SET `biz_boatX` = '%.4f', `biz_boatY` = '%.4f', `biz_boatZ` = '%.4f', `biz_boatA` = '%.4f' WHERE `biz_id` = %d", 0.0, 0.0, 0.0, 0.0, BusinessData[bizid][bID]);
		mysql_tquery(dbCon, gquery);

		BusinessData[bizid][bBuyingBoatX] = 0.0;
		BusinessData[bizid][bBuyingBoatY] = 0.0;
		BusinessData[bizid][bBuyingBoatZ] = 0.0;
		BusinessData[bizid][bBuyingBoatA] = 0.0;

	    SendClientMessage(playerid, COLOR_GRAD2, "Succeeded");
	}
	else
	{
		new Float:x, Float:y, Float:z, Float:a;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, a);

		format(gquery, sizeof(gquery), "UPDATE `business` SET `biz_boatX` = '%.4f', `biz_boatY` = '%.4f', `biz_boatZ` = '%.4f', `biz_boatA` = '%.4f' WHERE `biz_id` = %d", x, y, z, a, BusinessData[bizid][bID]);
		mysql_tquery(dbCon, gquery);

		BusinessData[bizid][bBuyingBoatX] = x;
		BusinessData[bizid][bBuyingBoatY] = y;
		BusinessData[bizid][bBuyingBoatZ] = z;
		BusinessData[bizid][bBuyingBoatA] = a;

		SendClientMessage(playerid, COLOR_GRAD2, "Succeeded");
	}
	return true;
}

CMD:businessex3(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4)
		return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new bizid, status;

    if(sscanf(params,"dD()",bizid, status))
		return SendSyntaxMessage(playerid, "/businessex3 [bizid] [1-Disabled]");

	if(!BusinessData[bizid][bID])
		return SendClientMessage(playerid, COLOR_GRAD2, "Invalid business ID.");

	if(status)
	{
		format(gquery, sizeof(gquery), "UPDATE `business` SET `biz_airX` = '%.4f', `biz_airY` = '%.4f', `biz_airZ` = '%.4f', `biz_airA` = '%.4f' WHERE `biz_id` = %d", 0.0, 0.0, 0.0, 0.0, BusinessData[bizid][bID]);
		mysql_tquery(dbCon, gquery);

		BusinessData[bizid][bBuyingAirX] = 0.0;
		BusinessData[bizid][bBuyingAirY] = 0.0;
		BusinessData[bizid][bBuyingAirZ] = 0.0;
		BusinessData[bizid][bBuyingAirA] = 0.0;

	    SendClientMessage(playerid, COLOR_GRAD2, "Succeeded");
	}
	else
	{
		new Float:x, Float:y, Float:z, Float:a;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, a);

		format(gquery, sizeof(gquery), "UPDATE `business` SET `biz_airX` = '%.4f', `biz_airY` = '%.4f', `biz_airZ` = '%.4f', `biz_airA` = '%.4f' WHERE `biz_id` = %d", x, y, z, a, BusinessData[bizid][bID]);
		mysql_tquery(dbCon, gquery);

		BusinessData[bizid][bBuyingAirX] = x;
		BusinessData[bizid][bBuyingAirY] = y;
		BusinessData[bizid][bBuyingAirZ] = z;
		BusinessData[bizid][bBuyingAirA] = a;

		SendClientMessage(playerid, COLOR_GRAD2, "Succeeded");
	}
	return true;
}

CMD:businessexit(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4)
		return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new bizid;

    if(sscanf(params, "d", bizid))
		return SendSyntaxMessage(playerid, "/businessexit [bizid]");

	if(!BusinessData[bizid][bID])
		return SendErrorMessage(playerid, "Invalid business ID specified.");

	new Float:playerPos[3], interior = GetPlayerInterior(playerid);

	GetPlayerPos(playerid, playerPos[0], playerPos[1], playerPos[2]);

	mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `business` SET `biz_etX` = '%.4f', `biz_etY` = '%.4f', `biz_etZ` = '%.4f', `biz_interior` = '%d' WHERE `biz_id` = '%d'", playerPos[0], playerPos[1], playerPos[2], interior, BusinessData[bizid][bID]);
	mysql_tquery(dbCon, gquery);

	BusinessData[bizid][bExitX] = playerPos[0];
	BusinessData[bizid][bExitY] = playerPos[1];
	BusinessData[bizid][bExitZ] = playerPos[2];
	BusinessData[bizid][bInterior] = interior;

	SendClientMessage(playerid, COLOR_GRAD2, "Business exit successfully set.");
	return true;
}

CMD:bizz(playerid, params[])
{
	new
		bizid
	;

	if(PlayerData[playerid][pAdmin] < 4)
  		return SendErrorMessage(playerid, "You're not authorized to use this command.");

    if(sscanf(params, "d", bizid))
		return SendSyntaxMessage(playerid, "/businessenter [bizid]");

	if(!BusinessData[bizid][bID])
		return SendClientMessage(playerid, COLOR_GRAD2, "Invalid business ID.");

	SetPlayerPosEx(playerid, BusinessData[bizid][bEntranceX], BusinessData[bizid][bEntranceY], BusinessData[bizid][bEntranceZ]);
	return true;
}

CMD:editbusiness(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4)
		return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new text[256], type, bizid;

	if(sscanf(params,"ds[256]",type,text))
	{
		SendSyntaxMessage(playerid, "/editbusiness [names] [input]");
		SendClientMessage(playerid, COLOR_GRAD2, "Available codes: 1-Price, 2-Level, 3-SubType, 4-Name, 5-Entrance, 6-Cash, 7-Lock/Unlock");
		SendClientMessage(playerid, COLOR_GRAD2, "Available codes: 8-Product, 9-Max Product, 10-Cargo Price");
	}

	if((bizid = Business_Nearest(playerid)) != -1)
	{
		new input = strval(text);

		if(type == 1)
		{
		    BusinessData[bizid][bBuyPrice] = input;

			mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `business` SET `biz_till` = '%d' WHERE `biz_id` = '%d'", input, BusinessData[bizid][bID]);
			mysql_tquery(dbCon, gquery);
		}
		else if(type == 2)
		{
		    BusinessData[bizid][bLevelNeeded] = input;

			mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `business` SET `biz_level` = '%d' WHERE `biz_id` = '%d'", input, BusinessData[bizid][bID]);
			mysql_tquery(dbCon, gquery);
		}
		else if(type == 3)
		{
		    BusinessData[bizid][bsubType] = input;

			mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `business` SET `biz_subtype` = '%d' WHERE `biz_id` = '%d'", input, BusinessData[bizid][bID]);
			mysql_tquery(dbCon, gquery);
		}
		else if(type == 4)
		{
		    format(BusinessData[bizid][bInfo], 80, "%s", text);

			mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `business` SET `biz_info` = '%e' WHERE `biz_id` = '%d'", text, BusinessData[bizid][bID]);
			mysql_tquery(dbCon, gquery);
		}
		else if(type == 5)
		{
		    BusinessData[bizid][bEntranceCost] = input;

			mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `business` SET `biz_encost` = '%d' WHERE `biz_id` = '%d'", input, BusinessData[bizid][bID]);
			mysql_tquery(dbCon, gquery);
		}
		else if(type == 6)
		{
		    BusinessData[bizid][bTill] = input;

			mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `business` SET `biz_till` = '%d' WHERE `biz_id` = '%d'", input, BusinessData[bizid][bID]);
			mysql_tquery(dbCon, gquery);
		}
		else if(type == 7)
		{
			if(BusinessData[bizid][bLocked])
			{
				BusinessData[bizid][bLocked] = 0;

				SendClientMessage(playerid, COLOR_GRAD2, "Business locked.");

				PlayerPlaySoundEx(playerid, 1145);
				return true;
			}
			else
			{
				BusinessData[bizid][bLocked] = 1;

				SendClientMessage(playerid, COLOR_GRAD2, "Business unlocked.");

				PlayerPlaySoundEx(playerid, 1145);
				return true;
			}
		}
		else if(type == 8)
		{
		    if(input > BusinessData[bizid][bMaxProducts])
		        return SendErrorMessage(playerid, "Max business products is %d.", BusinessData[bizid][bMaxProducts]);

		    BusinessData[bizid][bProducts] = input;

			mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `business` SET `biz_prod` = '%d' WHERE `biz_id` = '%d'", input, BusinessData[bizid][bID]);
			mysql_tquery(dbCon, gquery);
		}
		else if(type == 9)
		{
		    BusinessData[bizid][bMaxProducts] = input;

			mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `business` SET `biz_maxprod` = '%d' WHERE `biz_id` = '%d'", input, BusinessData[bizid][bID]);
			mysql_tquery(dbCon, gquery);
		}
		else if(type == 10)
		{
		    BusinessData[bizid][bPriceProd] = input;

			mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `business` SET `biz_priceprod` = '%d' WHERE `biz_id` = '%d'", input, BusinessData[bizid][bID]);
			mysql_tquery(dbCon, gquery);
		}
		else return SendClientMessage(playerid, COLOR_GREY, "Invalid stat-code.");
	}
	else return SendClientMessage(playerid, COLOR_GRAD2, "You're not near a business.");

	SendClientMessage(playerid, COLOR_GRAD2, "Business has been successfully adjusted.");
	return true;
}

CMD:businessint(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4)
		return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new interior, business;

	if(sscanf(params, "d", interior))
	{
		SendSyntaxMessage(playerid, "/businessint [id (0-48)]");
		SendClientMessage(playerid, COLOR_GRAD2, "0: None - 1: Marcos Bistro (Eat) - 2: Big Spread Ranch (Bar) - 3: Burger Shot (Eat) - 4: Cluckin Bell (Eat)");
		SendClientMessage(playerid, COLOR_GRAD2, "5: Well Stacked Pizza (Eat) - 6: Rusty Browns Dohnuts (Eat) - 7: Jays Diner (Eat) - 8: Pump Truck Stop Diner (Eat)");
		SendClientMessage(playerid, COLOR_GRAD2, "9: Alhambra (Drink) - 10: Mistys (Drink) - 11: Lil' Probe Inn (Drink) - 12: Exclusive (Clothes) - 13: Binco (Clothes)");
		SendClientMessage(playerid, COLOR_GRAD2, "14: ProLaps (Clothes) - 15: SubUrban (Clothes) - 16: Victim (Clothes) - 17: Zip (Clothes) - 18: Redsands Casino");
		SendClientMessage(playerid, COLOR_GRAD2, "19: Off Track Betting - 20: Sex Shop - 21: Zeros RC Shop - 22-25: Ammunations (Gun) - 26: Jizzy's (Drink)");
		SendClientMessage(playerid, COLOR_GRAD2, "27-32: 24-7's (Buy) - 33: Advertising/Phone Network - 34: Bothel - 35: Four Dragons Casino 36: Bikers Garage 37: Ganton gym");
		SendClientMessage(playerid, COLOR_GRAD2, "38: Tattoo 1 39: Tatto 2 40: Tatto 3 41: Crack Den 42: Zero RC shop 43: Record Studio 44: LS Court Room 45: Meat Factory 46: Betting Place");
		SendClientMessage(playerid, COLOR_GRAD2, "47: Barber Shop 48: Pleasure Domes");
		return true;
	}

	if((business = Business_Nearest(playerid)) != -1)
	{
		if(interior < 0 || interior > 48)
			return SendErrorMessage(playerid, "Invalid interior ID specified (0-48).");

		SetBusinessInterior(playerid, business, interior);
	}
	return true;
}

stock EditApartmentInterior(playerid, houseid)
{
	sgstr[0] = EOS;

	for(new i = 0; i < sizeof(A_INTERIORS); ++i)
	{
		format(sgstr, sizeof(sgstr), "%s%s\n", sgstr, A_INTERIORS[i][aName]);
	}

	strcat(sgstr, "Current Location");

	SetPVarInt(playerid, "EditingComplex", houseid);

	Dialog_Show(playerid, ApartmentInterior, DIALOG_STYLE_LIST, "Choose an interior", sgstr, "Select", "Cancel");
	return true;
}

CMD:setapt(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new houseid, type, text[128];

	if(sscanf(params, "ddS()[128]", houseid, type, text))
	{
		SendSyntaxMessage(playerid, "/setapt [houseid] [statcode] [input]");
		SendClientMessage(playerid, COLOR_GRAD2, "Available codes: 1-Price, 2-Level, 3-Interior, 4-Owner Name, 5-Faction SQLID, 6-Pickup");
		return true;
	}

	if(!Iter_Contains(Complex, houseid))
		return SendErrorMessage(playerid, "Invalid complex ID specified.");

	if(type >= 1 && type <= 6)
	{
		new input = strval(text);

		if(type == 1)
		{
		    if(isnull(text) || input < 1)
		        return SendErrorMessage(playerid, "Invalid price value specified.");

		    SendClientMessageEx(playerid, COLOR_GREEN, "Price value has been set to %d for Complex ID %d.", input, houseid);

		    ComplexData[houseid][aPrice] = input;

		    Complex_Refresh(houseid);

			format(gquery, sizeof(gquery), "UPDATE `apartments` SET `price` = %d WHERE `id` = %d", input, ComplexData[houseid][aID]);
			mysql_tquery(dbCon, gquery);
		}
		if(type == 2)
		{
		    if(isnull(text) || input < 1)
		        return SendErrorMessage(playerid, "Invalid buy level value specified.");

		    SendClientMessageEx(playerid, COLOR_GREEN, "Buy level has been adjusted to %d for Complex ID %d.", input, houseid);

		    ComplexData[houseid][aLevelbuy] = input;

		    Complex_Refresh(houseid);

			format(gquery, sizeof(gquery), "UPDATE `apartments` SET `levelbuy` = %d WHERE `id` = %d", input, ComplexData[houseid][aID]);
			mysql_tquery(dbCon, gquery);
		}
		if(type == 3)
		{
            EditApartmentInterior(playerid, houseid);
		}
		if(type == 4)
		{
		    if(isnull(text))
		        return SendErrorMessage(playerid, "Invalid owner name specified.");

		    SendClientMessageEx(playerid, COLOR_GREEN, "Owner has been set to %s for Complex ID %d.", text, houseid);

		    format(ComplexData[houseid][aOwner], MAX_PLAYER_NAME, "%s", text);

		    if(isnull(ComplexData[houseid][aOwner]) || strlen(ComplexData[houseid][aOwner]) < 1)
		    {
		        ComplexData[houseid][aOwned] = 0;
		        ComplexData[houseid][aOwner][0] = EOS;
				ComplexData[houseid][aOwnerSQLID] = -1;
		    }
		    else ComplexData[houseid][aOwned] = 1;

		    Complex_Refresh(houseid);

			new clean_name[MAX_PLAYER_NAME];
			mysql_escape_string(text, clean_name);

			format(gquery, sizeof(gquery), "UPDATE `apartments` SET `owned` = '%d', `owner` = '%s' WHERE `id` = %d", ComplexData[houseid][aOwned], clean_name, ComplexData[houseid][aID]);
			mysql_tquery(dbCon, gquery);
		}
		if(type == 5)
		{
		    if(isnull(text) || input < -1 || input >= MAX_FACTIONS)
				return SendErrorMessage(playerid, "Invalid faction ID specified.");

			SendClientMessageEx(playerid, COLOR_GREEN, "Faction ID has been adjusted to %d for Complex ID %d.", input, houseid);

			ComplexData[houseid][aFaction] = input;

			format(gquery, sizeof(gquery), "UPDATE `apartments` SET `faction` = %d WHERE `id` = %d", input, ComplexData[houseid][aID]);
			mysql_tquery(dbCon, gquery);
		}
		if(type == 6)
		{
		    if(isnull(text) || input < 0 || input > 1)
				return SendErrorMessage(playerid, "Invalid pickup value specified (0 - 1).");

			SendClientMessageEx(playerid, COLOR_GREEN, "Pickup has been %s for Complex ID %d.", input ? ("enabled") : ("disabled"), houseid);

			ComplexData[houseid][aPickupEnabled] = input;

			Complex_Refresh(houseid);

			format(gquery, sizeof(gquery), "UPDATE `apartments` SET `pickup` = %d WHERE `id` = %d", input, ComplexData[houseid][aID]);
			mysql_tquery(dbCon, gquery);
		}
	}
	else SendClientMessage(playerid, COLOR_GREY, "Invalid stat-code.");

	return true;
}

YCMD:createapartment(playerid, params[], help) = createapt;

CMD:createapt(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1337)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new houseid, houseinfo[60], pickup, faction, Float:x, Float:y, Float:z;

	if(sscanf(params,"dds[60]", pickup, faction, houseinfo))
		return SendSyntaxMessage(playerid, "/createapt [Pickup Enabled: (0 / 1)] [Faction SQLID: (-1 for none)] [Information]");

	if(pickup < 0 || pickup > 1)
	    return SendErrorMessage(playerid, "Invalid pickup option specified (0 or 1).");

	if(faction < -1 || faction >= MAX_FACTIONS)
	    return SendErrorMessage(playerid, "Invalid pickup option specified (0 or 1).");

	if(strlen(houseinfo) > 60)
	    return SendErrorMessage(playerid, "Information is too long, must be less than 60 characters.");

	houseid = Iter_Free(Complex);

	if(houseid == -1)
	    return SendErrorMessage(playerid, "Failed to create apartment, MAX_COMPLEXES reached.");

	GetPlayerPos(playerid, x, y, z);

    format(ComplexData[houseid][aInfo], 60, "%s", houseinfo);
    format(ComplexData[houseid][aOwner], MAX_PLAYER_NAME, "The State");

	ComplexData[houseid][aEntranceX] = x;
	ComplexData[houseid][aEntranceY] = y;
	ComplexData[houseid][aEntranceZ] = z;
	ComplexData[houseid][aExitX] = 0.0;
	ComplexData[houseid][aExitY] = 0.0;
	ComplexData[houseid][aExitZ] = 0.0;
	ComplexData[houseid][aFaction] = faction;
	ComplexData[houseid][aPickupEnabled] = pickup;
	ComplexData[houseid][aOwned] = 0;
	ComplexData[houseid][aPrice] = 100000;
	ComplexData[houseid][aLevelbuy] = 0;
	ComplexData[houseid][aInterior] = houseid + 1;
	ComplexData[houseid][aWorld] = houseid + LOCAL_APARTMENT;
	ComplexData[houseid][aOwnerSQLID] = -1;
	ComplexData[houseid][aRentable] = 0;
	ComplexData[houseid][aRentprice] = 0;

	Complex_Refresh(houseid);

	ComplexData[houseid][aDynamicArea] = CreateDynamicSphere(ComplexData[houseid][aEntranceX], ComplexData[houseid][aEntranceY], ComplexData[houseid][aEntranceZ], 3.0, -1, -1, -1);

	AssignDynamicAreaValue(ComplexData[houseid][aDynamicArea], AREA_TYPE_COMPLEX, houseid);

	AddApartmentToFile(houseid, houseinfo, faction, pickup, x, y, z, ComplexData[houseid][aWorld]);

	Iter_Add(Complex, houseid);

	SendClientMessageEx(playerid, COLOR_GREEN, "Apartment successfully created [SQLID: %d | Information: %s | Pickup: %s | Faction: %d]", houseid, houseinfo, (pickup) ? ("Enabled") : ("Disabled"), faction);

	EditApartmentInterior(playerid, houseid);
	return true;
}

YCMD:removeapp(playerid, params[], help) = removeapt;
YCMD:removeapartment(playerid, params[], help) = removeapt;

CMD:removeapt(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1337)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new houseid;

	if(sscanf(params,"d",houseid))
		return SendSyntaxMessage(playerid, "/removeapt [Apartment ID]");

	if(!Iter_Contains(Complex, houseid))
		return SendErrorMessage(playerid, "Invalid apartment ID specified.");

	new appid = ComplexData[houseid][aID];

	ComplexData[houseid][aID] = -1;
	ComplexData[houseid][aEntranceX] = 0.0;
	ComplexData[houseid][aEntranceY] = 0.0;
	ComplexData[houseid][aEntranceZ] = 0.0;
	ComplexData[houseid][aExitX] = 0.0;
	ComplexData[houseid][aExitY] = 0.0;
	ComplexData[houseid][aExitZ] = 0.0;
	ComplexData[houseid][aFaction] = -1;

	if(ComplexData[houseid][aPickupEnabled]) DestroyDynamicPickup(ComplexData[houseid][aPickup]);

	if(IsValidDynamic3DTextLabel(Text3D:ComplexData[houseid][aLabel])) DestroyDynamic3DTextLabel(Text3D:ComplexData[houseid][aLabel]);

	ComplexData[houseid][aPickupEnabled] = 0;

	Iter_Remove(Complex, houseid);

	mysql_format(dbCon, gquery, sizeof(gquery), "DELETE FROM `apartments` WHERE `ID` = '%d' LIMIT 1", appid);
	mysql_tquery(dbCon, gquery);

	SendClientMessageEx(playerid, COLOR_GREEN, "Apartment ID %d has been successfully removed from the database.", houseid);
	return true;
}

Dialog:ApartmentInterior(playerid, response, listitem, inputtext[])
{
	if(!response)
	{
		DeletePVar(playerid, "EditingComplex");
		return true;
	}

	new houseid = GetPVarInt(playerid, "EditingComplex"), i = listitem;

	DeletePVar(playerid, "EditingComplex");

	if(!strcmp(inputtext, "Current Location", false))
	{
	    new Float:playerPos[3];
	    GetPlayerPos(playerid, playerPos[0], playerPos[1], playerPos[2]);

		mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `apartments` SET `iPosX` = '%f', `iPosY` = '%f', `iPosZ` = '%f' WHERE `ID` = '%d'", playerPos[0], playerPos[1], playerPos[2], ComplexData[houseid][aID]);
		mysql_tquery(dbCon, gquery, "OnApartmentMoved", "ifff", houseid, playerPos[0], playerPos[1], playerPos[2]);
	}
	else
	{
		mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `apartments` SET `iPosX` = '%f', `iPosY` = '%f', `iPosZ` = '%f' WHERE `ID` = '%d'", A_INTERIORS[i][aPos][0], A_INTERIORS[i][aPos][1], A_INTERIORS[i][aPos][2], ComplexData[houseid][aID]);
		mysql_tquery(dbCon, gquery, "OnApartmentMoved", "ifff", houseid, A_INTERIORS[i][aPos][0], A_INTERIORS[i][aPos][1], A_INTERIORS[i][aPos][2]);
	}

	SendClientMessageEx(playerid, COLOR_GREEN, "Interior has been successfully adjusted for Complex ID %d.", houseid);
	return true;
}

CMD:createprop(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new type, value;

	if(sscanf(params,"dd", type, value))
		return SendSyntaxMessage(playerid, "/createprop [type 1-34] [value]");

	if(type < 1 || type > 34)
	    return SendErrorMessage(playerid, "Invalid type specified 1-34.");

	if(value < 1)
	    return SendErrorMessage(playerid, "Invalid value specified.");

	new houseid = Iter_Free(Property);

	if(houseid == -1)
	    return SendErrorMessage(playerid, "Failed to create property, MAX_PROPERTIES reached.");

	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);

	PropertyData[houseid][hEntranceX] = x;
	PropertyData[houseid][hEntranceY] = y;
	PropertyData[houseid][hEntranceZ] = z;
	PropertyData[houseid][hExitX] = HouseInteriorss[type - 1][0];
	PropertyData[houseid][hExitY] = HouseInteriorss[type - 1][1];
	PropertyData[houseid][hExitZ] = HouseInteriorss[type - 1][2];
	PropertyData[houseid][hCheckPosX] = PropertyData[houseid][hExitX];
	PropertyData[houseid][hCheckPosY] = PropertyData[houseid][hExitY];
	PropertyData[houseid][hCheckPosZ] = PropertyData[houseid][hExitZ];
	PropertyData[houseid][hPrice] = value;
	PropertyData[houseid][hOwnerSQLID] = -1;
	PropertyData[houseid][hOwned] = 0;
	PropertyData[houseid][hLocked] = 1;
	PropertyData[houseid][hRentprice] = 0;
	PropertyData[houseid][hRentable] = 0;
	PropertyData[houseid][hInterior] = houseid + 1;
	PropertyData[houseid][hWorld] = houseid + LOCAL_HOUSE;
	PropertyData[houseid][hCash] = 0;
	PropertyData[houseid][hRadio] = 0;
	PropertyData[houseid][hLevelbuy] = 1;

	new apt = InApartment[playerid];

	if(apt != -1)
	{
		PropertyData[houseid][hComplexSQL] = ComplexData[apt][aID];
		PropertyData[houseid][hComplexID] = apt;

		format(PropertyData[houseid][hInfo], 64, "%s", ReturnDynamicAddress(ComplexData[apt][aEntranceX], ComplexData[apt][aEntranceY]));
	}
	else
	{
		PropertyData[houseid][hComplexSQL] = -1;
		PropertyData[houseid][hComplexID] = -1;

		format(PropertyData[houseid][hInfo], 64, "%s", ReturnDynamicAddress(PropertyData[houseid][hEntranceX], PropertyData[houseid][hEntranceY]));
	}

	format(PropertyData[houseid][hOwner], MAX_PLAYER_NAME, "The State");

	Property_Refresh(houseid);

	if(PropertyData[houseid][hComplexID] == -1)
		PropertyData[houseid][hDynamicArea] = CreateDynamicSphere(PropertyData[houseid][hEntranceX], PropertyData[houseid][hEntranceY], PropertyData[houseid][hEntranceZ], 2.5, 0, -1, -1);
	else
		PropertyData[houseid][hDynamicArea] = CreateDynamicSphere(PropertyData[houseid][hEntranceX], PropertyData[houseid][hEntranceY], PropertyData[houseid][hEntranceZ], 1.5, ComplexData[ PropertyData[houseid][hComplexID] ][aWorld], -1, -1);

	AssignDynamicAreaValue(PropertyData[houseid][hDynamicArea], AREA_TYPE_PROPERTY, houseid);

	AddHouseToFile(houseid, value, PropertyData[houseid][hInfo], x, y, z, PropertyData[houseid][hExitX], PropertyData[houseid][hExitY], PropertyData[houseid][hExitZ], PropertyData[houseid][hComplexSQL], PropertyData[houseid][hWorld]);

	SendClientMessageEx(playerid, COLOR_GREEN, "Property successfully created [Type: %d | Value: %d]", type, value);

	Iter_Add(Property, houseid);
	return true;
}

CMD:removeprop(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1337)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new houseid = -1;

	if((houseid = ReturnClosestProperty(playerid)) == -1)
		return SendErrorMessage(playerid, "You're not near a house.");

	if(PropertyData[houseid][hOwned])
		return SendErrorMessage(playerid, "This house has a owner. Use /asellhouse.");

	DestroyDynamic3DTextLabel(Text3D:PropertyData[houseid][hLabel]);

	mysql_format(dbCon, gquery, sizeof(gquery), "DELETE FROM `houses` WHERE `id` = '%d' LIMIT 1",PropertyData[houseid][hID]);
	mysql_tquery(dbCon, gquery, "OnHouseRemove", "i", houseid);

	SendClientMessageEx(playerid, COLOR_YELLOW, "-> You've successfully destroyed property #%d.",houseid);
	return true;
}

CMD:asellhouse(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1337)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new
	    houseid
	;

	if(sscanf(params, "d", houseid))
		return SendSyntaxMessage(playerid, "/asellhouse [houseid]");

	if(!Iter_Contains(Property, houseid))
		return SendErrorMessage(playerid, "Invalid house ID specified.");

	if(!PropertyData[houseid][hOwned])
		return SendErrorMessage(playerid, "Nobody owns this house.");

	foreach (new i : Player)
	{
	    if(PlayerData[i][pHouseKey] == houseid)
	    {
	        PlayerData[i][pHouseKey] = -1;

			SendClientMessageEx(i, COLOR_LIGHTRED, "Administrator %s has sold your property, you're no longer a resident at %s.", ReturnName(playerid), PropertyData[houseid][hInfo]);
	        break;
	    }
	}

	mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `characters` SET `playerHouseKey` = '-1' WHERE `playerHouseKey` = '%d' LIMIT 1", houseid);
	mysql_tquery(dbCon, gquery);

	mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `houses` SET `owner` = 'The State', `owned` = '0', `locked` = '1', `rentprice` = '0', `rentable` = '0' WHERE `id` = '%d' LIMIT 1", PropertyData[houseid][hID]);
	mysql_tquery(dbCon, gquery, "OnAdminSellHouse", "i", houseid);
	return true;
}

CMD:houseenter(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new houseid, Float:px, Float:py, Float:pz;

	if(sscanf(params, "d", houseid))
		return SendSyntaxMessage(playerid, "/houseenter [houseid]");

	if(!Iter_Contains(Property, houseid))
		return SendErrorMessage(playerid, "Invalid house ID specified.");

	GetPlayerPos(playerid, px, py, pz);

	mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `houses` SET `posx` = '%f', `posy` = '%f', `posz` = '%f' WHERE `id` = '%d'", px, py, pz, PropertyData[houseid][hID]);
	mysql_tquery(dbCon, gquery, "OnHouseMoved", "ifff", houseid, px, py, pz);

	SendClientMessage(playerid, COLOR_GRAD1, "You have successfully modified the entrance of the house.");
	return true;
}

CMD:houseexit(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new houseid,  Float:px, Float:py, Float:pz;

	if(sscanf(params, "d", houseid))
		return SendSyntaxMessage(playerid, "/houseexit [houseid]");

	if(!Iter_Contains(Property, houseid))
		return SendErrorMessage(playerid, "Invalid house ID specified.");

	GetPlayerPos(playerid, px, py, pz);

	mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `houses` SET `exitx` = %f, `exity` = %f, `exitz` = %f WHERE `id` = %d", px, py, pz, PropertyData[houseid][hID]);
	mysql_tquery(dbCon, gquery, "OnHouseExitMoved", "ifff", houseid, px, py, pz);

	SendClientMessage(playerid, COLOR_GRAD1, "You have successfully modified the exit of the house.");
	return true;
}

CMD:setprop(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new houseid, type, text[128];

	if(sscanf(params, "dds[256]", houseid, type, text))
	{
		SendSyntaxMessage(playerid, "/setprop [houseid] [statcode] [input]");
		SendClientMessage(playerid, COLOR_GRAD2, "Available codes: 1-Price, 2-Level, 3-Type, 4-World");
		return true;
	}

	if(!Iter_Contains(Property, houseid))
		return SendErrorMessage(playerid, "Invalid house ID specified.");

	if(type >= 1 && type <= 5)
	{
		new input = strval(text);

		if(type == 1)
		{
		    SendClientMessageEx(playerid, COLOR_GREEN, "Value has been set to %d for House ID %d.", input, houseid);

		    PropertyData[houseid][hPrice] = input;

			if(PropertyData[houseid][hOwned] == 0) Property_Refresh(houseid);

			mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `houses` SET `price` = '%d' WHERE `id` = '%d'", input, PropertyData[houseid][hID]);
			mysql_tquery(dbCon, gquery);
		}
		if(type == 2)
		{
		    SendClientMessageEx(playerid, COLOR_GREEN, "Buy level has been adjusted to %d for House ID %d.", input, houseid);

		    PropertyData[houseid][hLevelbuy] = input;

			if(PropertyData[houseid][hOwned] == 0) Property_Refresh(houseid);

			mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `houses` SET `levelbuy` = '%d' WHERE `id` = '%d'", input, PropertyData[houseid][hID]);
			mysql_tquery(dbCon, gquery);
		}
		if(type == 3)
		{
		    if(input < 1 || input > 34)
		            return SendErrorMessage(playerid, "Invalid type specified 1-34.");

		    SendClientMessageEx(playerid, COLOR_GREEN, "Interior Type has been adjusted to %d for House ID %d.", input, houseid);

			PropertyData[houseid][hExitX] = HouseInteriorss[input - 1][0];
			PropertyData[houseid][hExitY] = HouseInteriorss[input - 1][1];
			PropertyData[houseid][hExitZ] = HouseInteriorss[input - 1][2];
			PropertyData[houseid][hCheckPosX] = PropertyData[houseid][hExitX];
			PropertyData[houseid][hCheckPosY] = PropertyData[houseid][hExitY];
			PropertyData[houseid][hCheckPosZ] = PropertyData[houseid][hExitZ];			

			if(PropertyData[houseid][hOwned] == 0) Property_Refresh(houseid);

			mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `houses` SET `exitx` = '%f', `exity` = '%f', `exitz` = '%f', `checkx` = '%f', `checky` = '%f', `checkz` = '%f' WHERE `id` = '%d'", 
			PropertyData[houseid][hExitX], PropertyData[houseid][hExitY], PropertyData[houseid][hExitZ], 
			PropertyData[houseid][hCheckPosX], PropertyData[houseid][hCheckPosY], PropertyData[houseid][hCheckPosZ], 
			PropertyData[houseid][hID]);
			mysql_tquery(dbCon, gquery);
		}
		if(type == 4)
		{
		    SendClientMessageEx(playerid, COLOR_GREEN, "Virtual World has been set to %d for House ID %d.", input, houseid);

		    PropertyData[houseid][hWorld] = input;

			mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `houses` SET `world` = '%d' WHERE `id` = '%d'", input, PropertyData[houseid][hID]);
			mysql_pquery(dbCon, gquery);
		}
	}
	else SendClientMessage(playerid, COLOR_GREY, "Invalid stat-code.");

	return true;
}

CMD:gotograffiti(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new sprayid;

	if(sscanf(params, "d", sprayid))
		return SendSyntaxMessage(playerid, "/gotograffiti [id]");

	if(sprayid < 0 || sprayid > MAX_SPRAY_LOCATIONS)
		return SendSyntaxMessage(playerid, "Invalid ID, 0 - %d", MAX_SPRAY_LOCATIONS);

	if(Spray_Data[sprayid][graffSQLID] == -1)
		return SendErrorMessage(playerid, "Graffiti doesn't exist.");	

	SetPlayerDynamicPos(playerid, Spray_Data[sprayid][Xpos], Spray_Data[sprayid][Ypos], Spray_Data[sprayid][Zpos]);
	SendClientMessageEx(playerid, COLOR_GREY, "You've been teleported to graffiti #%d.", sprayid);
	return true;
}

CMD:cleangraffiti(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new sprayid;

	if(sscanf(params, "d", sprayid))
		return SendSyntaxMessage(playerid, "/cleangraffiti [id]");

	if(sprayid < 0 || sprayid > MAX_SPRAY_LOCATIONS)
		return SendSyntaxMessage(playerid, "Invalid ID, 0 - %d", MAX_SPRAY_LOCATIONS);

	if(Spray_Data[sprayid][graffSQLID] == -1)
		return SendErrorMessage(playerid, "Graffiti doesn't exist.");	

	RestoreGraffiti(playerid, sprayid);
	SendClientMessageEx(playerid, COLOR_GREY, "You've cleaned graffiti #%d.", sprayid);
	return true;
}

YCMD:gotoapt(playerid, params[], help) = gotoapp;

CMD:gotoapp(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new houseid;

	if(sscanf(params, "d", houseid))
		return SendSyntaxMessage(playerid, "/gotoapp [app id]");

	if(!Iter_Contains(Complex, houseid))
		return SendClientMessage(playerid, -1, "Invalid apartment ID.");

	SetPlayerDynamicPos(playerid, ComplexData[houseid][aEntranceX], ComplexData[houseid][aEntranceY], ComplexData[houseid][aEntranceZ]);
	SetPlayerInterior(playerid, 0);
	SetPlayerVirtualWorld(playerid, 0);

	DesyncPlayerInterior(playerid);
	return true;
}

CMD:house(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new
		houseid
	;

	if(sscanf(params, "d", houseid))
		return SendSyntaxMessage(playerid, "/house [house-id]");

	if(!Iter_Contains(Property, houseid))
		return SendErrorMessage(playerid, "Invalid house ID specified.");

	SetPlayerPosEx(playerid, PropertyData[houseid][hEntranceX], PropertyData[houseid][hEntranceY], PropertyData[houseid][hEntranceZ]);

	if(PropertyData[houseid][hComplexID] != -1)
	{
		new aptid = PropertyData[houseid][hComplexID];

		SetPlayerInteriorEx(playerid, ComplexData[aptid][aInterior]);
		SetPlayerVirtualWorldEx(playerid, ComplexData[aptid][aWorld]);

		InApartment[playerid] = aptid;
		InProperty[playerid] = -1;
		InBusiness[playerid] = -1;

		PlayerData[playerid][pLocal] = aptid + LOCAL_APARTMENT;
	}
	else
	{
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);

		DesyncPlayerInterior(playerid);
	}
	return true;
}

CMD:properties(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 1337)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");	

	ShowPropertyDialogue(playerid, 0);
	return true;
}

ShowPropertyDialogue(playerid, page, index = 0)
{
	new count = 0, next_page = true;

	gstr[0] = EOS;

	format(gstr, sizeof(gstr), "#\tDescription\tPrice\tOwner\tFlags");

	for(new i = index; i < MAX_PROPERTIES; ++i)
	{
		if(PropertyData[i][hID])
		{
			if(count == 15)
			{
				next_page = true;
				break;
			}
		}

		if(!PropertyData[i][hID]) continue;

		if(!count) PropertyViewPageIndexes[page][0] = i;

		format(gstr, sizeof(gstr), "%s\n{7e98b6}%d\t{a9c4e4}%d %s%s\t{7e98b6}%d\t{a9c4e4}%s\t{7e98b6}%s", gstr, i, PropertyData[i][hID], ReturnPropertyAddress(i), (PropertyData[i][hExitX] == 0.0 && PropertyData[i][hExitY] == 0.0 ? " {FF0000}(( NO INTERIOR SET ))" : ""), PropertyData[i][hPrice], PropertyData[i][hOwner]);
	
		count++;

		PropertyViewPageIndexes[page][1] = i;
	}	

	if(page) strcat(gstr, "\n{7e98b6}Last Page");
	if(next_page) strcat(gstr, "\n{7e98b6}Next Page");

	PropertyViewPage[playerid] = page;

	Dialog_Show(playerid, HouseList, DIALOG_STYLE_TABLIST_HEADERS, "Server Properties (%i)", gstr, "Teleport", "Close", Iter_Count(Property));
}

Dialog:HouseList(playerid, response, listitem, inputtext[])
{
	if(!response) return true;

	if(strcmp(inputtext, "Next Page", false) == 0)
	{
		ShowPropertyDialogue(playerid, PropertyViewPage[playerid] + 1, PropertyViewPageIndexes[ PropertyViewPage[playerid] ][1] + 1);
		return true;
	}

	if(strcmp(inputtext, "Last Page", false) == 0)
	{
		ShowPropertyDialogue(playerid, PropertyViewPage[playerid] - 1, PropertyViewPageIndexes[ PropertyViewPage[playerid] - 1 ][0]);
		return true;
	}	

	//SendClientMessageEx(playerid, -1, "DEBUG: Clicked on property %d.", strval(inputtext));
	return true;
}

YCMD:teles(playerid, params[], help) = tp;

CMD:tp(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 3)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	if(!AdminDuty{playerid})	
		return SendUnauthMessage(playerid, "You must be on admin duty to perform this command.");			

	new
	    filter[32]
	;

	if(sscanf(params, "s[32]", filter))
	{
		new count;

		gstr[0] = EOS;

		for(new i = 0; i < MAX_INTERIORS; ++i)
		{
			if(Teleports[i][aTeleOn])
			{
				format(gstr, sizeof(gstr), "%s\n{a9c4e4}%d\t{7e98b6}%s", gstr, i, Teleports[i][aMapName]);

				count++;
			}
		}

		if(!count) return SendErrorMessage(playerid, "There are no teleports created.");

		Dialog_Show(playerid, AdminTeles, DIALOG_STYLE_LIST, "Admin Teleports", gstr, "Select", "Cancel");

		return SendSyntaxMessage(playerid, "/tp [location]");
	}

	new id = -1;

	if(!IsNumeric(filter))
	{
	    if(strlen(filter) < 3)
	        return SendErrorMessage(playerid, "Filter must be at least 3 characters long.");

		for(new i = 0; i < MAX_INTERIORS; ++i)
		{
			if(strfind(Teleports[i][aMapName], filter, true) != -1)
			{
				id = i;
				break;
			}
		}
	}
	else id = strval(filter);

	if((id < 0 || id >= MAX_INTERIORS) || !Teleports[id][aTeleOn])
	    return SendErrorMessage(playerid, "Unrecognized teleport (/tp).");

	TeleportPlayerToPoint(playerid, id);
	return true;
}

CMD:maketele(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 3)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new name[32], interior, teleid = -1, Float:X, Float:Y, Float:Z;

	if(sscanf(params, "s[32]", name))
		return SendSyntaxMessage(playerid, "/maketele [name]");

	if(strlen(name) < 3 || strlen(name) > 32)
	    return SendErrorMessage(playerid, "Text length must be higher than 3 and lower than 32");

	for(new i = 0; i < MAX_INTERIORS; ++i)
	{
		if(!Teleports[i][aTeleOn])
		{
		    teleid = i;
		    break;
		}
	}

	if(teleid == -1)
	    return SendErrorMessage(playerid, "Max teleports exceeded.");

	GetPlayerPos(playerid, X, Y, Z);
	interior = GetPlayerInterior(playerid);

	Teleports[teleid][aPosX] = X;
	Teleports[teleid][aPosY] = Y;
	Teleports[teleid][aPosZ] = Z;
	Teleports[teleid][aInterior] = interior;
	format(Teleports[teleid][aMapName], 32, "%s", name);
	Teleports[teleid][aTeleOn] = 1;

	AddTeleToFile(teleid, name, interior, X, Y, Z);

	SendClientMessageEx(playerid, COLOR_GREEN, "Teleport Created. [Name: %s Position: %f, %f, %f]", name, X, Y, Z);
	return true;
}

CMD:removetele(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 3)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

    new teleid;

	if(sscanf(params, "d", teleid))
		return SendSyntaxMessage(playerid, "/removetele [id]");

	if(!Teleports[teleid][aTeleOn])
	    return SendErrorMessage(playerid,"This tele does not exist.");

    SendClientMessageEx(playerid, COLOR_GREY, "You removed teleport %s (dbid #%d).", Teleports[teleid][aMapName], Teleports[teleid][aID]);

	mysql_format(dbCon, gquery, sizeof(gquery), "DELETE FROM `ateles` WHERE `id` = '%d' LIMIT 1", Teleports[teleid][aID]);
	mysql_tquery(dbCon, gquery, "OnTeleportRemove", "i", teleid);
	return true;
}

CMD:fixveh(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new
		vehicleid,
		Float:angle
	;

	if(sscanf(params, "i", vehicleid))
		return SendSyntaxMessage(playerid, "/fixveh [vehicle id]");

	if(!IsValidVehicle(vehicleid))
		return SendErrorMessage(playerid, "You specified an invalid vehicle.");

	SendAdminAlert(COLOR_YELLOW, LEAD_ADMINS, "AdmWarn(4): %s repaired vehicle %d.", ReturnName(playerid), vehicleid);

	SetVehicleHealth(vehicleid, GetVehicleDataHealth(GetVehicleModel(vehicleid)));
	SetVehicleDamageStatus(vehicleid, 0, 0, 0, 0);

	CoreVehicles[vehicleid][startup_delay_sender] = INVALID_PLAYER_ID;
	CoreVehicles[vehicleid][startup_delay] = 0;
	CoreVehicles[vehicleid][startup_delay_random] = 0;
	CoreVehicles[vehicleid][vehCrash] = 0;
	CoreVehicles[vehicleid][vehicleBadlyDamage] = 0;

	GetVehicleZAngle(vehicleid, angle);
	SetVehicleZAngle(vehicleid, angle);
	return true;
}

CMD:healcar(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	if(!IsPlayerInAnyVehicle(playerid))
		return SendErrorMessage(playerid, "You must be in a vehicle.");

	new
		vehicleid = GetPlayerVehicleID(playerid),
		Float:angle
	;

	SendAdminAlert(COLOR_YELLOW, LEAD_ADMINS, "AdmWarn(4): %s repaired their vehicle.", ReturnName(playerid));

	SetVehicleHealth(vehicleid, GetVehicleDataHealth(GetVehicleModel(vehicleid)));
	SetVehicleDamageStatus(vehicleid, 0, 0, 0, 0);

	CoreVehicles[vehicleid][startup_delay_sender] = INVALID_PLAYER_ID;
	CoreVehicles[vehicleid][startup_delay] = 0;
	CoreVehicles[vehicleid][startup_delay_random] = 0;
	CoreVehicles[vehicleid][vehCrash] = 0;
	CoreVehicles[vehicleid][vehicleBadlyDamage] = 0;

	GetVehicleZAngle(vehicleid, angle);
	SetVehicleZAngle(vehicleid, angle);
	return true;
}

CMD:descar(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1337)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	if(!IsPlayerInAnyVehicle(playerid))
		return SendErrorMessage(playerid, "You must be in a vehicle.");

	SetVehicleHealth(GetPlayerVehicleID(playerid), 250);
	return true;
}

CMD:respawn(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 1)
		return SendClientMessage(playerid, COLOR_GREY, "You are not allowed to use this command.");

	new userid;

	if(sscanf(params, "u", userid))
		return SendSyntaxMessage(playerid, "/respawn [playerid OR name]");

	if(!IsPlayerConnected(userid))
		return SendClientMessage(playerid, COLOR_LIGHTRED, "The player you specified isn't connected.");

	if(!SQL_IsLogged(userid))
		return SendClientMessage(playerid,  COLOR_LIGHTRED, "That player isn't logged in.");

	if(PlayerData[userid][pInjured] || DeathMode{userid})
	{
		RevivePlayer(userid);
	}

	DesyncPlayerInterior(userid);

	SetPlayerSpawn(userid);

    SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(1): %s respawned player %s.", ReturnName(playerid), ReturnName(userid));
	return true;
}

CMD:revive(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 1)
		return SendClientMessage(playerid, COLOR_GREY, "You are not allowed to use this command.");

	new
		userid
	;

	if(sscanf(params, "u", userid))
		return SendSyntaxMessage(playerid, "/revive [playerid OR name]");

	if(!IsPlayerConnected(userid))
		return SendClientMessage(playerid, COLOR_LIGHTRED, "The player you specified isn't connected.");

	if(!PlayerData[userid][pInjured] && !DeathMode{userid})
		return SendClientMessage(playerid, COLOR_LIGHTRED, "That player isn't dead or brutally wounded.");

    RevivePlayer(userid);
	SetPlayerHealthEx(userid, 150.0);
	TogglePlayerControllable(userid, true);

	if(PlayerData[userid][pJailed] == 3) AttachPrisonLabel(userid);

	SetPlayerChatBubble(userid, "(( Revived ))", COLOR_WHITE, 10.0, 400);

	SendClientMessage(playerid, COLOR_YELLOW, "Woke him up!");

	SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(1): %s revived player %s.", ReturnName(playerid), ReturnName(userid));
	return true;
}

CMD:sethealth(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new userid, Float:health;

	if(sscanf(params, "uf", userid, health))
		return SendSyntaxMessage(playerid, "/sethealth [playerid/PartOfName] [amount]");

	if(!AdminDuty{playerid})	
		return SendUnauthMessage(playerid, "You must be on admin duty to perform this command.");				

	if(!IsPlayerConnected(userid))
		return SendErrorMessage(playerid, "The player you specified isn't connected.");

	if(health > MAX_SERVER_HEALTH)
	    return SendErrorMessage(playerid, "Max server health is %.0f.", MAX_SERVER_HEALTH);

	SetPlayerHealthEx(userid, health);

	SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(1): %s set %s's health to %.0f.", ReturnName(playerid), ReturnName(userid), health);
	return true;
}

CMD:gethealth(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
 		return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new
		Float:health
	;

	if(sscanf(params, "f", health))
		return SendSyntaxMessage(playerid, "/gethealth [amount]");

	if(health > MAX_SERVER_HEALTH)
	    return SendErrorMessage(playerid, "Max server health is %.0f.", MAX_SERVER_HEALTH);

	SetPlayerHealthEx(playerid, health);

	SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(1): %s has set their health to %.0f.", ReturnName(playerid), health);
	return true;
}

CMD:tod(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 2)
		return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new
	    time
	;

	if(sscanf(params, "d", time))
		return SendSyntaxMessage(playerid, "/tod [time] (0-23)");

	SetWorldTime(time);

	SendClientMessageToAllEx(COLOR_GRAD1, "Time changed to %d:00", time);
	return true;
}

CMD:weather(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 3)
		return SendErrorMessage(playerid, "You're not authorized to use this command.");

    new
		weather
	;

	if(sscanf(params, "d", weather))
		return SendSyntaxMessage(playerid, "/weather [weatherid]");

	if(weather < 0 || weather > 45)
		return SendErrorMessage(playerid, "Weather ID can't be below 0 or above 45.");

	SetPlayerWeather(playerid, weather);

	SendClientMessage(playerid, COLOR_GREY, "Weather was changed!");
	return true;
}

CMD:weatherall(playerid, params[])
{
	new weather;

	if(PlayerData[playerid][pAdmin] < 3)
		return SendErrorMessage(playerid, "You're not authorized to use this command.");

	if(sscanf(params, "d", weather))
		return SendSyntaxMessage(playerid, "/weather [weatherid]");

	if(weather < 0||weather > 45)
		return SendClientMessage(playerid, COLOR_GREY, "   Weather ID can't be below 0 or above 45!");

	SetWeather(weather);
	SendClientMessage(playerid, COLOR_GREY, "The weather was changing for everyone!");
	return true;
}

CMD:givegun(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 4)
		return SendClientMessage(playerid, COLOR_GREY, "You are not allowed to use this command.");	

	new userid, weaponid, ammo;

	if(sscanf(params, "uii", userid, weaponid, ammo))
	{
		SendClientMessage(playerid, COLOR_LIGHTRED, "USAGE: /givegun [playerid/PartOfName] [weaponid(eg. 46 = Parachute)] [ammo]");
		SendClientMessage(playerid, COLOR_LIGHTRED, "Warning: Invalid WeaponID's will crash the server");
		return true;
	}

	if(!AdminDuty{playerid})	
		return SendUnauthMessage(playerid, "You must be on admin duty to perform this command.");	

	new command = Command_GetID("givegun");	

	if(command == -1) return true;

	if(DisabledCommands[command] == 1)
		return SendUnauthMessage(playerid, "This command is currently disabled by the Management.");

	if(!IsPlayerConnected(userid))
		return SendErrorMessage(playerid, "The player you specified isn't connected.");

	if(!SQL_IsLogged(userid))
		return SendErrorMessage(playerid, "The player you specified isn't logged in.");

	if(PlayerData[userid][pLevel] < 2)
	    return SendErrorMessage(playerid, "Player is not level 2.");

	if(IsInvalidWeapon(weaponid))
	    return SendErrorMessage(playerid, "Invalid weapon id specified.");
	    
	if(weaponid == 26 || weaponid == 27)
	    return SendErrorMessage(playerid, "Invalid weapon id specified.");

	new max_ammo = GetWeaponPackage(g_aWeaponSlots[weaponid]);

	if(!ammo || ammo > max_ammo)
	    return SendErrorMessage(playerid, "Invalid ammo specified, max is %d for this weapon.", max_ammo);

	if(weaponid == 25) BeanbagActive{userid} = false;

    GivePlayerValidWeapon(userid, weaponid, ammo, 0, false);

	SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(3): %s gave a %s and %d ammo to %s.", ReturnName(playerid), ReturnWeaponName(weaponid), ammo, ReturnName(userid));
	return true;
}

CMD:givemoney(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 3)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new userid, amount;

	if(sscanf(params, "ud", userid, amount))
		return SendSyntaxMessage(playerid, "/givemoney [playerid/PartOfName] [amount]");

	if(!AdminDuty{playerid})	
		return SendUnauthMessage(playerid, "You must be on admin duty to perform this command.");				

	if(!IsPlayerConnected(userid))
		return SendErrorMessage(playerid, "The player you specified isn't connected.");

	if(!SQL_IsLogged(userid))
		return SendErrorMessage(playerid, "The player you specified isn't logged in.");

    SendPlayerMoney(userid, amount);

    SendAdminAlert(COLOR_YELLOW, LEVEL_THREE_ADMINS, "AdmWarn(1): %s gave %s to %s [%d].", ReturnName(playerid), FormatNumber(amount), ReturnName(userid), userid);
	return true;
}

CMD:takemoney(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 3)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new userid, amount;

	if(sscanf(params, "ud", userid, amount))
		return SendSyntaxMessage(playerid, "/takemoney [playerid/PartOfName] [amount]");

	if(!AdminDuty{playerid})	
		return SendUnauthMessage(playerid, "You must be on admin duty to perform this command.");				

	if(!IsPlayerConnected(userid))
		return SendErrorMessage(playerid, "The player you specified isn't connected.");

	if(!SQL_IsLogged(userid))
		return SendErrorMessage(playerid, "The player you specified isn't logged in.");

    TakePlayerMoney(userid, amount);

    SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(1): %s took %s from %s [%d].", ReturnName(playerid), FormatNumber(amount), ReturnName(userid), userid);
	return true;
}

CMD:setarmour(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new userid, Float:health;

	if(sscanf(params, "uf", userid, health))
		return SendSyntaxMessage(playerid, "/setarmour [playerid/PartOfName] [amount]");

	if(!AdminDuty{playerid})	
		return SendUnauthMessage(playerid, "You must be on admin duty to perform this command.");				

	if(!IsPlayerConnected(userid))
		return SendErrorMessage(playerid, "The player you specified isn't connected.");

	if(health > 200)
	    return SendErrorMessage(playerid, "Invalid amount specified.");

	SetPlayerArmourEx(userid, health);

	SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(1): %s set %s's armour to %.0f.", ReturnName(playerid), ReturnName(userid), health);
	return true;
}

CMD:setskin(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new userid, skin;

	if(sscanf(params, "ud", userid, skin))
		return SendSyntaxMessage(playerid, "/setskin [playerid/PartOfName] [skinid]");

	if(!AdminDuty{playerid})	
		return SendUnauthMessage(playerid, "You must be on admin duty to perform this command.");				

	if(!IsPlayerConnected(userid))
		return SendErrorMessage(playerid, "The player you specified isn't connected.");

	SetPlayerSkin(userid, skin);

	SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(1): %s set %s's skin to %d.", ReturnName(playerid), ReturnName(userid), skin);
	return true;
}

/*CMD:togdiscord(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1337)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

    if(systemVariables[DiscordStatus] == 1)
    {
		systemVariables[DiscordStatus] = 0;

		SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(4): %s enabled discord logging.", ReturnName(playerid), playerid);
	}
	else
	{
		systemVariables[DiscordStatus] = 1;

		SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(4): %s disabled discord logging.", ReturnName(playerid), playerid);
	}
	return true;
}*/

CMD:createaccount(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1337)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

    new username[MAX_PLAYER_NAME], password[64], quiz;

	if(sscanf(params, "s[24]s[64]d", username, password, quiz))
		return SendSyntaxMessage(playerid, "/createaccount [username] [password] [quiz]");

	if(strlen(username) < 3 || strlen(username) > MAX_PLAYER_NAME)
	    return SendErrorMessage(playerid, "Invalid username length given.");

	if(strlen(password) < 3 || strlen(password) > 64)
	    return SendErrorMessage(playerid, "Invalid password length given.");

	if(IsValidAccount(username))
	    return SendErrorMessage(playerid, "An account already exists with that username.");

	if(quiz < 0 || quiz > 1)
		return SendErrorMessage(playerid, "Quiz value must be either 0 or 1.");

	new buffer[129];
	WP_Hash(buffer, sizeof(buffer), password);

	mysql_format(dbCon, gquery, sizeof(gquery), "INSERT INTO accounts (Username, Password, Quiz) VALUES ('%e', '%e', %d)", username, buffer, quiz);
	mysql_tquery(dbCon, gquery, "OnAccountCreated", "ds", playerid, username);
	return true;
}

CMD:createcharacter(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1337)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

    new username[MAX_PLAYER_NAME], character[MAX_PLAYER_NAME], tutorial;

	if(sscanf(params, "s[24]s[24]d", username, character, tutorial))
		return SendSyntaxMessage(playerid, "/createcharacter [accountName] [Firstname_Lastname] [Tutorial (0/1)");	

	if(strlen(username) < 3 || strlen(username) > MAX_PLAYER_NAME)
	    return SendErrorMessage(playerid, "Invalid username length given.");

	if(!IsValidRoleplayName(character))
		return SendErrorMessage(playerid, "Invalid character name specified, must be Firstname_Lastname.");	

	if(tutorial < 0 || tutorial > 1)
		return SendErrorMessage(playerid, "Tutorial value must be either 0 or 1.");			

	SendServerMessage(playerid, "Checking account validity for '%s'...", username);	

	mysql_format(dbCon, gquery, sizeof(gquery), "SELECT `ID` from `accounts` WHERE `Username` = '%e' LIMIT 1", username);
	mysql_tquery(dbCon, gquery, "OnAccountCheck", "dssd", playerid, username, character, tutorial);		
	return true;
}

FUNX::OnAccountCheck(playerid, const account[], const character[], tutorial)
{
	if(!cache_num_rows())
		return SendServerMessage(playerid, "Account '%s' doesn't exist in the database.", account);

	new accountSQLID, query[128], phoneNumber = randomEx(100000, 999999);
	cache_get_value_name_int(0, "ID", accountSQLID);	

	SendServerMessage(playerid, "Account %s (%d) is valid, now creating character '%s'.", account, accountSQLID, character);	

	mysql_format(dbCon, query, sizeof(query), "INSERT INTO `characters` (master, char_name, PhoneNumbr, Activated, Tutorial) VALUES (%d, '%e', %d, 1, %d)", accountSQLID, character, phoneNumber, tutorial);
    mysql_tquery(dbCon, query, "OnCharacterCreated", "dsds", playerid, account, accountSQLID, character);	
	return true;
}

FUNX::OnCharacterCreated(playerid, const account[], accountSQLID, const character[])
{
	new characterSQLID = cache_insert_id();

	SendServerMessage(playerid, "Character %s #%d has been succesfully added to account %s (%d).", character, characterSQLID, account, accountSQLID);
}

FUNX::OnAccountCreated(playerid, const username[])
{
    SendServerMessage(playerid, "Account %s (dbid #%d) successfully created.", username, cache_insert_id());
}

CMD:checkaccount(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1337)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

    new username[MAX_PLAYER_NAME];

	if(sscanf(params, "s[24]", username))
		return SendSyntaxMessage(playerid, "/checkaccount [username]");	

	if(strlen(username) < 3 || strlen(username) > MAX_PLAYER_NAME)
	    return SendErrorMessage(playerid, "Invalid username length given.");

	new accountSQLID = ReturnAccountDBID(username);

	if(accountSQLID == -1)
		return SendErrorMessage(playerid, "Account '%s' doesn't exist in the database.", username);

	mysql_format(dbCon, gquery, sizeof(gquery), "SELECT ID, Online, char_name, Tutorial, Model, PhoneNumbr, LastLogin from `characters` WHERE `master` = '%d' LIMIT 6", accountSQLID);
	mysql_tquery(dbCon, gquery, "OnAccountExtraCheck", "dsd", playerid, username, accountSQLID);				
	return true;
}

FUNX::OnAccountExtraCheck(playerid, account[], accountSQLID)
{
	SendClientMessageEx(playerid, COLOR_LIGHTRED, "Listing characters for account %s (#%d)...", account, accountSQLID);

	new characterSQLID, characterOnline, characterName[MAX_PLAYER_NAME], characterTutorial, characterModel, characterNumber, characterLastLogin, count;

	for(new i = 0, j = cache_num_rows(); i < j; ++i)
	{
		count++;

		cache_get_value_name_int(i, "ID", characterSQLID);
		cache_get_value_name_int(i, "Online", characterOnline);
		cache_get_value_name(i, "char_name", characterName, MAX_PLAYER_NAME);
		cache_get_value_name_int(i, "Tutorial", characterTutorial);
		cache_get_value_name_int(i, "Model", characterModel);
		cache_get_value_name_int(i, "PhoneNumbr", characterNumber);

		if(!characterOnline) cache_get_value_name_int(i, "LastLogin", characterLastLogin);

		SendClientMessageEx(playerid, COLOR_WHITE, "%d. Character: %s (DBID:%d) | Tutorial: %d | Skin Model: %d | Phone Number: %d | Last Online: %s", 
		count, characterName, characterSQLID, characterTutorial, characterModel, characterNumber, characterOnline == 1 ? "None" : HowLongAgo(gettime() - characterLastLogin));
	}
	return true;
}

stock IsValidAccount(master[])
{
	new checkQuery[128], results;

	mysql_format(dbCon, checkQuery, sizeof(checkQuery), "SELECT `ID` FROM `accounts` WHERE `Username` = '%e'", master);
	new Cache:cache = mysql_query(dbCon, checkQuery);

	results = cache_num_rows();

	cache_delete(cache);
	return results;
}

CMD:changename(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 2)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new userid, newName[MAX_PLAYER_NAME];

	if(sscanf(params, "us[24]", userid, newName))
		return SendSyntaxMessage(playerid, "/changename [playerid/PartOfName] [New_Name]");

	if(!IsPlayerConnected(userid))
		return SendErrorMessage(playerid, "The player you specified isn't connected.");

	if(!SQL_IsLogged(userid))
		return SendErrorMessage(playerid, "The player you specified isn't logged in.");

	if(!IsValidRoleplayName(newName))
	    return SendErrorMessage(playerid, "Please use a valid roleplay name.");

	new oldName[MAX_PLAYER_NAME];
	GetPlayerName(userid, oldName, MAX_PLAYER_NAME);	

	mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `characters` SET `char_name` = '%e' WHERE `ID` = %d", newName, PlayerData[userid][pID]);
	mysql_tquery(dbCon, gquery);

	mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `houses` SET `owner` = '%e' WHERE `owner` = '%e'", newName, ReturnName(userid));
	mysql_tquery(dbCon, gquery);

	SetPlayerName(userid, newName);

	SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(2): %s changed %s's name to %s.", (playerid == userid ? oldName : ReturnName(playerid)), oldName, newName);
	return true;
}

stock IsValidRoleplayName(const name[])
{
	if(strfind(name, "_", true) == -1) return false;
	if(strfind(name, "[", true) != -1) return false;
	if(strfind(name, "]", true) != -1) return false;
	if(strfind(name, "!", true) != -1) return false;
	if(strfind(name, "@", true) != -1) return false;
	if(strfind(name, "#", true) != -1) return false;
	if(strfind(name, "!", true) != -1) return false;
	if(strfind(name, "?", true) != -1) return false;
	if(strfind(name, "%", true) != -1) return false;
	if(strfind(name, "^", true) != -1) return false;
	if(strfind(name, "&", true) != -1) return false;
	if(strfind(name, "*", true) != -1) return false;
	if(strfind(name, "(", true) != -1) return false;
	if(strfind(name, ")", true) != -1) return false;
    if(strfind(name, "+", true) != -1) return false;
    if(strfind(name, "-", true) != -1) return false;
	return true;
}

CMD:setstat(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 3)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new pid, statcode, amount;

	if(sscanf(params, "udd", pid, statcode, amount))
	{
		SendClientMessage(playerid, COLOR_WHITE, "USAGE: /setstat [playerid] [statcode] [amount]");
		SendClientMessage(playerid, COLOR_GRAD4, "|1 Level |2 Skin(not saved) |3 RespectPoints |4 Sex |5 Bank");
		SendClientMessage(playerid, COLOR_GRAD4, "|6 Hours |7 Cash |8 Donator |9 Upgrade(removed) |10 Phone Number ");
		SendClientMessage(playerid, COLOR_GRAD4, "|11 Savings |12 House Key |13 Radio |14 Channel(removed)");
		SendClientMessage(playerid, COLOR_GRAD4, "|15 Bizz Key |16 Faction(removed) |17 Faction Rank(removed) |18 Job |19 Side Job");
		SendClientMessage(playerid, COLOR_GRAD4, "|20 Job Rank | 21 Career | 22 Skin(saved) | 23 Car License | 24 Weapon License | 25 CCW License");
		return true;
	}

	if(!IsPlayerConnected(pid))
		return SendErrorMessage(playerid, "The player you specified isn't connected.");

	if(!SQL_IsLogged(pid) || PlayerData[pid][pID] == -1)
		return SendErrorMessage(playerid, "The player you specified isn't logged in.");

	if(PlayerData[playerid][pAdmin] < PlayerData[pid][pAdmin])
	    return SendErrorMessage(playerid, "You can't use this on admins higher than you.");

	switch(statcode)
	{
		case 1:
		{
		    if(amount < 1)
		        return SendErrorMessage(playerid, "Invalid level specified.");

			PlayerData[pid][pLevel] = amount;
			SetPlayerScore(pid, amount);

			SendClientMessageEx(pid, COLOR_YELLOW, "%s set %s's level to %d", ReturnName(playerid), ReturnName(pid), amount);

            SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(3) %s has set %s's Level to %d.", ReturnName(playerid), ReturnName(pid), amount);
		}
		case 2:
		{
			SetPlayerSkin(pid, amount);

			SendClientMessageEx(pid, COLOR_YELLOW, "%s set %s's skin to %d", ReturnName(playerid), ReturnName(pid), amount);

            SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(3) %s set %s's Skin to %d.", ReturnName(playerid), ReturnName(pid), amount);
		}
		case 3:
		{
			PlayerData[pid][pExp] = amount;

			SendClientMessageEx(pid, COLOR_YELLOW, "%s set %s's exp to %d", ReturnName(playerid), ReturnName(pid), amount);

			SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(3) %s has set %s's Experience Points to %d.", ReturnName(playerid), ReturnName(pid), amount);
		}
		case 4:
		{
            SendClientMessageEx(pid, COLOR_YELLOW, "%s set %s's gender to %d", ReturnName(playerid), ReturnName(pid), amount);

			SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(3) %s has set %s's Gender to %d.", ReturnName(playerid), ReturnName(pid), amount);
		}
		case 5:
		{
			PlayerData[pid][pAccount] = amount;

			SendClientMessageEx(pid, COLOR_YELLOW, "%s set %s's bank account to %d", ReturnName(playerid), ReturnName(pid), amount);

			SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(3) %s has set %s's Bank Account to %d.", ReturnName(playerid), ReturnName(pid), amount);
		}
		case 6:
		{
			PlayerData[pid][pPlayingSeconds] = amount * 3600;

			SendClientMessageEx(pid, COLOR_YELLOW, "%s set %s's playing hours to %d", ReturnName(playerid), ReturnName(pid), amount);

			SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(3) %s has set %s's Playing Hours to %d.", ReturnName(playerid), ReturnName(pid), amount);
		}
		case 7:
		{
		    PlayerData[pid][pCash] = amount;

		    ResetPlayerMoney(pid);
		    GivePlayerMoney(pid, PlayerData[pid][pCash]);

			SendClientMessageEx(pid, COLOR_YELLOW, "%s set %s's cash to %d", ReturnName(playerid), ReturnName(pid), amount);

			SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(3) %s has set %s's Cash to $%d.", ReturnName(playerid), ReturnName(pid), amount);
		}
		case 8:
		{
			PlayerData[pid][pDonateRank] = amount;

			SendClientMessageEx(pid, COLOR_YELLOW, "%s set %s's donator level to %d", ReturnName(playerid), ReturnName(pid), amount);

			SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(3) %s has set %s's Donator Level to %d.", ReturnName(playerid), ReturnName(pid), amount);
		}
		case 9:
		{
			/*PlayerData[pid][pPUpgrade] = amount;

			SendClientMessageEx(pid, COLOR_YELLOW, "%s set %s's upgrade points to %d", ReturnName(playerid), ReturnName(pid), amount);

			SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(3) %s has set %s's Upgrade Points to %d.", ReturnName(playerid), ReturnName(pid), amount);*/
		}
		case 10:
		{
			PlayerData[pid][pPnumber] = amount;

			SendClientMessageEx(pid, COLOR_YELLOW, "%s set %s's phone number to %d", ReturnName(playerid), ReturnName(pid), amount);

			SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(3) %s has set %s's Phone Number to %d.", ReturnName(playerid), ReturnName(pid), amount);
		}
		case 11:
		{
			PlayerData[pid][pSavingsCollect] = amount;

			SendClientMessageEx(pid, COLOR_YELLOW, "%s set %s's savings to $%d", ReturnName(playerid), ReturnName(pid), amount);

            SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(3) %s has set %s's Savings to %d.", ReturnName(playerid), ReturnName(pid), amount);
		}
		case 12:
		{
			PlayerData[pid][pHouseKey] = amount;

			SendClientMessageEx(pid, COLOR_YELLOW, "%s set %s's house key to %d", ReturnName(playerid), ReturnName(pid), amount);

			SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(3) %s has set %s's House Key to %d.", ReturnName(playerid), ReturnName(pid), amount);
		}
		case 13:
		{
			PlayerData[pid][pRadio] = amount;

			SendClientMessageEx(pid, COLOR_YELLOW, "%s set %s's radio to %d", ReturnName(playerid), ReturnName(pid), amount);

			SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(3) %s has set %s's Radio to %d.", ReturnName(playerid), ReturnName(pid), amount);
		}
		/*case 14:
		{
			PlayerData[pid][pRChannel] = amount;

			SendClientMessageEx(pid, COLOR_YELLOW, "%s set %s's radio channel to %d", ReturnName(playerid), ReturnName(pid), amount);

			SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(3) %s has set %s's radio channel to %d.", ReturnName(playerid), ReturnName(pid), amount);
		}*/
		case 15:
		{
			PlayerData[pid][pPbiskey] = amount;

			SendClientMessageEx(pid, COLOR_YELLOW, "%s set %s's business key to %d", ReturnName(playerid), ReturnName(pid), amount);

			SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(3) %s has set %s's Business Key to %d.", ReturnName(playerid), ReturnName(pid), amount);
		}
		/*case 16:
		{
		    if((amount < 0 || amount >= MAX_FACTIONS) || (amount != -1 && !FactionData[amount][factionExists]))
			    return SendErrorMessage(playerid, "Invalid faction ID.");

			if(amount == -1)
			{
			    ResetFaction(pid);
			}
			else
			{
				SetFaction(pid, amount);
			}

			SendClientMessageEx(pid, COLOR_YELLOW, "%s set %s's faction to %d", ReturnName(playerid), ReturnName(pid), amount);

			SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(3) %s has set %s's Faction to %d.", ReturnName(playerid), ReturnName(pid), amount);
		}
		case 17:
		{
		    new factionid;

			if((factionid = PlayerData[pid][pFaction]) == -1)
			    return SendErrorMessage(playerid, "Player is not in a faction.");

		    if(amount < 1 || amount > FactionData[factionid][factionRanks])
		        return SendErrorMessage(playerid, "Invalid rank specified 1-%d.", FactionData[factionid][factionRanks]);

			PlayerData[pid][pFactionRank] = amount;

			SendClientMessageEx(pid, COLOR_YELLOW, "%s set %s's faction rank to %d", ReturnName(playerid), ReturnName(pid), amount);

			SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(3) %s has set %s's Rank to %d.", ReturnName(playerid), ReturnName(pid), amount);
		}*/
		case 18:
		{
			PlayerData[pid][pJob] = amount;

			SendClientMessageEx(pid, COLOR_YELLOW, "%s set %s's job to %d", ReturnName(playerid), ReturnName(pid), amount);

			SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(3) %s has set %s's Job to %d.", ReturnName(playerid), ReturnName(pid), amount);
		}
		case 19:
		{
			PlayerData[pid][pSideJob] = amount;

			SendClientMessageEx(pid, COLOR_YELLOW, "%s set %s's side job to %d", ReturnName(playerid), ReturnName(pid), amount);

			SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(3) %s has set %s's Side Job to %d.", ReturnName(playerid), ReturnName(pid), amount);
		}
		case 20:
		{
			PlayerData[pid][pJobRank] = amount;

			SendClientMessageEx(pid, COLOR_YELLOW, "%s set %s's job rank to %d", ReturnName(playerid), ReturnName(pid), amount);

			SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(3) %s has set %s's Job Rank to %d.", ReturnName(playerid), ReturnName(pid), amount);
		}
		case 21:
		{
			PlayerData[pid][pCareer] = amount;

			SendClientMessageEx(pid, COLOR_YELLOW, "%s set %s's career to %d", ReturnName(playerid), ReturnName(pid), amount);

			SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(3) %s has set %s's Career to %d.", ReturnName(playerid), ReturnName(pid), amount);
		}
		case 22:
		{
            SetPlayerSkin(pid, amount);
            PlayerData[pid][pModel] = amount;

            SendClientMessageEx(pid, COLOR_YELLOW, "%s set %s's skin model to %d", ReturnName(playerid), ReturnName(pid), amount);

            SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(3) %s has set %s's Skin Model to %d.", ReturnName(playerid), ReturnName(pid), amount);
		}
		case 23:
		{
			PlayerData[pid][pCarLic] = amount;

			SendClientMessageEx(pid, COLOR_YELLOW, "%s set %s's driving license to %d", ReturnName(playerid), ReturnName(pid), amount);

			SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(3) %s has set %s's Driving License to %d.", ReturnName(playerid), ReturnName(pid), amount);
		}
		case 24:
		{
            PlayerData[pid][pWepLic] = amount;

            SendClientMessageEx(pid, COLOR_YELLOW, "%s set %s's weapon license to %d", ReturnName(playerid), ReturnName(pid), amount);

            SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(3) %s has set %s's Weapon License to %d.", ReturnName(playerid), ReturnName(pid), amount);
		}
		case 25:
		{
            PlayerData[pid][pCCWLic] = amount;

            SendClientMessageEx(pid, COLOR_YELLOW, "%s set %s's CCW license to %d", ReturnName(playerid), ReturnName(pid), amount);

            SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(3) %s has set %s's CCW License to %d.", ReturnName(playerid), ReturnName(pid), amount);
		}
		default:
		{
			return SendClientMessage(playerid, COLOR_GRAD2, "Invalid stat code.");
		}
	}
	return true;
}

CMD:gotocmdspot(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 2)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new house = InProperty[playerid];

	if(house == -1)
		return SendClientMessage(playerid, COLOR_GRAD1, "You must be in a home owned.");

	SetPlayerDynamicPos(playerid, PropertyData[house][hCheckPosX], PropertyData[house][hCheckPosY], PropertyData[house][hCheckPosZ]);
	return true;
}

CMD:hints(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 1337)
		return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	gstr[0] = EOS;

	for(new i = 0; i < sizeof(HouseInteriorss); ++i)
	{
	    format(gstr, 500, "%sInterior %d\n", gstr, i + 1);
	}

	Dialog_Show(playerid, HouseInteriorss, DIALOG_STYLE_LIST, "House Interiors", gstr, "Select", "Cancel");
	return true;
}

CMD:variables(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1337) return true;

	SendClientMessageEx(playerid, -1, "pInjured %d | DeathMode %s | Knockedout %s | ApartmentEntered %d | HouseEntered %d | Payday %d | pLocal %d",
		PlayerData[playerid][pInjured], (DeathMode{playerid} == true) ? ("Yes") : ("No"), (KnockedOut{playerid} == true) ? ("Yes") : ("No"), InApartment[playerid], InProperty[playerid], PlayerData[playerid][pPayDay], PlayerData[playerid][pLocal]
	);
	return true;
}

CMD:asetrank(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 4)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new
		userid,
		rank,
		factionid
	;

	if(sscanf(params, "ud", userid, rank))
	    return SendSyntaxMessage(playerid, "/asetrank [playerid/PartOfName] [rank id]");

	if(!IsPlayerConnected(userid))
		return SendErrorMessage(playerid, "The player you specified isn't connected.");

	if((factionid = PlayerData[userid][pFaction]) == -1)
	    return SendClientMessage(playerid, COLOR_GRAD1, "   The player is not a member of any faction or group");

    if(rank < 1 || rank > FactionData[factionid][factionRanks])
        return SendClientMessageEx(playerid, COLOR_GRAD1, "   The rank is not valid. The rank of this faction or group is between 1 and %d", FactionData[factionid][factionRanks]);

	new oldrank = PlayerData[userid][pFactionRank] - 1;

	PlayerData[userid][pFactionRank] = rank;

	SendClientMessageEx(playerid, COLOR_YELLOW, "You updated %s's rank from %s to %s", ReturnName(userid, 0), ReturnRank(factionid, oldrank), Faction_GetRank(userid));
	SendClientMessageEx(userid, COLOR_YELLOW, "Your rank has been updated from %s to %s by %s", ReturnRank(factionid, oldrank), Faction_GetRank(userid), ReturnName(playerid, 0));
    return true;
}

CMD:makeleader(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 4)
		return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new
		userid,
		id
	;

	if(sscanf(params, "ud", userid, id))
	    return SendSyntaxMessage(playerid, "/makeleader [playerid/PartOfName] [faction id] (Use -1 to remove from faction)");

	if(userid == INVALID_PLAYER_ID)
	{
		new maskid[MAX_PLAYER_NAME];
		sscanf(params, "s[24]{d}", maskid);
		if((userid = GetPlayerMaskID(maskid)) == INVALID_PLAYER_ID)
		{
			return SendErrorMessage(playerid, "The player you specified isn't connected.");
		}
	}

	if(!SQL_IsLogged(userid))
		return SendErrorMessage(playerid, "The player you specified isn't logged in.");

    if((id < -1 || id >= MAX_FACTIONS) || (id != -1 && !FactionData[id][factionExists]))
	    return SendErrorMessage(playerid, "Invalid faction ID.");

	new
	    string[128]
	;

	if(id == -1)
	{
	    ResetFaction(userid);

	    SendClientMessageEx(playerid, COLOR_YELLOW, "You removed %s from their faction.", ReturnName(userid, 0));
    	SendClientMessageEx(userid, COLOR_YELLOW, "%s has removed you from your faction.", ReturnName(playerid, 0));

		mysql_format(dbCon, string, sizeof(string), "UPDATE `characters` SET `Faction` = '-1' WHERE `ID` = '%d'", PlayerData[userid][pID]);
		mysql_pquery(dbCon, string);
	}
	else
	{
		SetFaction(userid, id);

		if(!PlayerData[userid][pFactionRank])
			PlayerData[userid][pFactionRank] = 1;

	    format(FactionData[id][factionLeader], MAX_PLAYER_NAME, ReturnName(userid));

		SendClientMessageEx(playerid, COLOR_YELLOW, "You've set %s as the leader of\"%s\"", ReturnName(userid, 0), FactionData[id][factionName]);
    	SendClientMessageEx(userid, COLOR_YELLOW, "%s made you the leader of \"%s\"", ReturnName(playerid, 0), FactionData[id][factionName]);

  		if(IsPolice(userid) && PlayerData[userid][pAdmin] < 1)
		{
			if(!MDC_Created{userid})
			{
				InitMDC(userid);
			}
		}

		mysql_format(dbCon, string, sizeof(string), "UPDATE `characters` SET `Faction` = '%d', `FactionRank` = '1' WHERE `ID` = '%d'", PlayerData[userid][pFactionID], PlayerData[userid][pID]);
		mysql_pquery(dbCon, string);

  		Faction_Save(id);
	}
    return true;
}

CMD:viewfactions(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4)
	    return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	ViewFactions(playerid);
	return true;
}

CMD:createfaction(playerid, params[])
{
	new faction = -1, type, name[32];

    if(PlayerData[playerid][pAdmin] < 4)
	    return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	if(sscanf(params, "ds[32]", type, name))
	{
	    SendSyntaxMessage(playerid, "/createfaction [type] [name]");
	    SendClientMessage(playerid, COLOR_GREY, "Available types: 1: LSPD | 2: NEWS | 3: LSFD | 4: GOV | 5: MAFIA | 6: LSSD | 7: DOC");
		return true;
	}

	if(type < 1 || type > 7)
	    return SendNoticeMessage(playerid, "The categories listed are between 1 and 7.");

	faction = Faction_Create(name, type);

	if(faction == -1)
	    return SendClientMessage(playerid, COLOR_GRAD1, "Failed to create the faction, contact a developer.");

	SendClientMessageEx(playerid, COLOR_YELLOW, "-> You've successfully created Faction ID %d.", faction);
	return true;
}

CMD:removefaction(playerid, params[])
{
	new
	    id = 0;

    if(PlayerData[playerid][pAdmin] < 4)
	    return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	if(sscanf(params, "d", id))
	    return SendSyntaxMessage(playerid, "/destroyfaction [faction id]");

	if((id < 0 || id >= MAX_FACTIONS) || !FactionData[id][factionExists])
	    return SendNoticeMessage(playerid, "You specified an invalid faction.");

	Faction_Delete(id);

	SendClientMessageEx(playerid, COLOR_YELLOW, "-> You've successfully deleted Faction %d.", id);

	SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn: %s deleted Faction ID %d.", ReturnName(playerid), id);
	return true;
}

CMD:setfaction(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4)
	    return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	new
	    id,
	    type[24],
	    string[128];

	if(sscanf(params, "ds[24]S()[128]", id, type, string))
 	{
	 	SendSyntaxMessage(playerid, "/setfaction [id] [stat code]");
	    SendClientMessage(playerid, COLOR_GRAD1, "[type]: name, color, type");
		return true;
	}

	if((id < 0 || id >= MAX_FACTIONS) || !FactionData[id][factionExists])
	    return SendErrorMessage(playerid, "Invalid faction specified.");

    if(!strcmp(type, "name", true))
	{
	    new name[32], clean_name[32];

	    if(sscanf(string, "s[32]", name))
	        return SendSyntaxMessage(playerid, "/setfaction [id] [name] [new name]");

	    format(FactionData[id][factionName], 32, name);

	    Faction_Save(id);
		SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn: %s changed the name of faction %d to \"%s\"", ReturnName(playerid), id, clean_name);
	}
	else if(!strcmp(type, "color", true))
	{
	    new color;

	    if(sscanf(string, "x", color))
	        return SendSyntaxMessage(playerid, "/setfaction [id] [color] [hex color]");

	    FactionData[id][factionColor] = color;
	    Faction_Update(id);

	    Faction_Save(id);
		SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn: %s adjusted the color {%06x} of Faction ID: %d", ReturnName(playerid), color >>> 8, id);
	}
	else if(!strcmp(type, "type", true))
	{
	    new typeint;

	    if(sscanf(string, "d", typeint))
     	{
		 	SendSyntaxMessage(playerid, "/setfaction [id] [type] [faction type]");
            SendClientMessage(playerid, COLOR_YELLOW, "[TYPES]:{FFFFFF} 1: Police | 2: News | 3: Medical | 4: Government | 5: Gang");
            return 1;
		}
		if(typeint < 1 || typeint > 5)
		    return SendClientMessage(playerid, COLOR_GRAD1, "   The specified type is invalid (Please use 1 to 5)");

	    FactionData[id][factionType] = typeint;

	    Faction_Save(id);
		SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn: %s has changed the faction type of Faction: %d to %s", ReturnName(playerid), id, GetFactionTypeName(typeint));
	}
	return true;
}

CMD:makegate(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1337)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new objectid, modelid, faction, name[64], Float:X, Float:Y, Float:Z;

	if(sscanf(params, "dds[64]", modelid, faction, name))
	{
		SendSyntaxMessage(playerid, "/makegate [modelid] [Faction Type] [Description]");
		SendClientMessage(playerid, COLOR_GREY, "Faction types: 1: LSPD | 2: NEWS | 3: LSFD | 4: GOV | 5: MAFIA | 6: LSSD | 7: DOC");
		return true;
	}

	GetPlayerPos(playerid, X, Y, Z);

    if((objectid = Iter_Free(Gates)) != -1)
	{
		Gates[objectid][gateModel] = modelid;
		Gates[objectid][gatePosX] = X;
		Gates[objectid][gatePosY] = Y;
		Gates[objectid][gatePosZ] = Z;
		Gates[objectid][gatePosRX] = 0.0;
		Gates[objectid][gatePosRY] = 0.0;
		Gates[objectid][gatePosRZ] = 0.0;
		Gates[objectid][gateInterior] = GetPlayerInterior(playerid);
		Gates[objectid][gateFaction] = faction;
		Gates[objectid][gateOpened] = 0;
		Gates[objectid][gateLocked] = 0;
		Gates[objectid][gateVirtualWorld] = GetPlayerVirtualWorld(playerid);

		format(Gates[objectid][gateName], 64, "%s", name);
		Gates[objectid][gateObject] = CreateDynamicObject(modelid, X, Y, Z, 0.0, 0.0, 0.0, Gates[objectid][gateVirtualWorld], Gates[objectid][gateInterior], -1, 200.0);

		AddGateToFile(objectid, Gates[objectid][gateModel], Gates[objectid][gateFaction], Gates[objectid][gateInterior], Gates[objectid][gateVirtualWorld], Gates[objectid][gatePosX], Gates[objectid][gatePosY], Gates[objectid][gatePosZ], Gates[objectid][gateName]);

		SendClientMessageEx(playerid, COLOR_YELLOW, "-> You've sccessfully created Gate #%d with description \"%s\".", objectid, Gates[objectid][gateName]);

		Iter_Add(Gates, objectid);
	}
	return true;
}

CMD:dupgate(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1337)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new objectid, gateid, name[64];

	if(sscanf(params, "ds[64]", gateid,name))
		return SendSyntaxMessage(playerid, "/dupgate [gateid] [Description]");

	if(!Iter_Contains(Gates, gateid))
		return SendClientMessage(playerid, COLOR_WHITE, "ERROR: The specified sliding door was not found!");

	if((objectid = Iter_Free(Gates)) != -1)
	{
		Gates[objectid][gateModel] = Gates[gateid][gateModel];
		Gates[objectid][gatePosX] = Gates[gateid][gatePosX];
		Gates[objectid][gatePosY] = Gates[gateid][gatePosY];
		Gates[objectid][gatePosZ] = Gates[gateid][gatePosZ];
		Gates[objectid][gatePosRX] = Gates[gateid][gatePosRX];
		Gates[objectid][gatePosRY] = Gates[gateid][gatePosRY];
		Gates[objectid][gatePosRZ] = Gates[gateid][gatePosRZ];
		Gates[objectid][gateInterior] = Gates[gateid][gateInterior];
		Gates[objectid][gateFaction] = Gates[gateid][gateFaction];
		Gates[objectid][gateOpened] = Gates[gateid][gateOpened];
		Gates[objectid][gateLocked] = Gates[gateid][gateLocked];
		Gates[objectid][gateVirtualWorld] = Gates[gateid][gateVirtualWorld];

		format(Gates[objectid][gateName], 64, "%s", name);

		Gates[objectid][gateObject] = CreateDynamicObject(Gates[objectid][gateModel], Gates[objectid][gatePosX], Gates[objectid][gatePosY], Gates[objectid][gatePosZ], Gates[objectid][gatePosRX], Gates[objectid][gatePosRY], Gates[objectid][gatePosRZ], Gates[objectid][gateVirtualWorld], Gates[objectid][gateInterior], -1, 200.0);

		AddGateToFile(objectid, Gates[objectid][gateModel], Gates[objectid][gateFaction], Gates[objectid][gateInterior], Gates[objectid][gateVirtualWorld], Gates[objectid][gatePosX], Gates[objectid][gatePosY], Gates[objectid][gatePosZ], Gates[objectid][gateName]);

		SendClientMessageEx(playerid, COLOR_GREEN, "New gate was copied [GateID: %d, ModelID: %d, Description: %s]", objectid, Gates[objectid][gateModel], Gates[objectid][gateName]);
        SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn: %s copied gate Model id:%d Gates Description: %s.", ReturnName(playerid), objectid, Gates[objectid][gateModel], Gates[objectid][gateName]);
		Iter_Add(Gates, objectid);
	}
	return true;
}

CMD:removegate(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1337)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new objectid;

	if(sscanf(params, "d", objectid))
		return SendSyntaxMessage(playerid, "/removegate [gateid]");

	if(!Iter_Contains(Gates, objectid))
	    return SendErrorMessage(playerid, "Invalid gate specified.");

	mysql_format(dbCon, gquery, sizeof(gquery), "DELETE FROM `gates` WHERE `id` = '%d'",Gates[objectid][gateID]);
	mysql_tquery(dbCon, gquery, "OnGateRemove", "i", objectid);

	Iter_Remove(Gates, objectid);

	SendClientMessageEx(playerid, COLOR_YELLOW, "-> Gate %d successfully removed from the database.", objectid);
	return true;
}

CMD:editgate(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1337)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new objectid, type, input[64];

	if(sscanf(params, "ddS()[64]", objectid, type, input))
	{
		SendSyntaxMessage(playerid, "/editgate [doorid] [type (1-Object, 2-Move, 3-OpenSpeed, 4-Name, 5-Faction Type)]");
		SendClientMessage(playerid, COLOR_GREY, "Faction types: 1: LSPD | 2: NEWS | 3: LSFD | 4: GOV | 5: MAFIA | 6: LSSD | 7: DOC");
		return true;
	}

	if(!Iter_Contains(Gates, objectid))
		return SendErrorMessage(playerid, "Invalid gate specified.");

	if(type == 1)
	{
		SetPVarInt(playerid, "EditingGate", 1);
		SetPVarInt(playerid, "ObjectEditing", objectid);

		EditDynamicObject(playerid, Gates[objectid][gateObject]);

		SendClientMessageEx(playerid, COLOR_YELLOW, "-> You're now adjusting Gate %d's default position.", objectid);
	}
	else if(type == 2)
	{
		SetPVarInt(playerid, "EditingGateMove", 1);
		SetPVarInt(playerid, "ObjectEditing", objectid);

		EditDynamicObject(playerid, Gates[objectid][gateObject]);

		SendClientMessageEx(playerid, COLOR_YELLOW, "-> You're now adjusting Gate %d's moving position.", objectid);
	}
	else if(type == 3)
	{
	    if(strlen(input))
		{
		    new Float:speed = floatstr(input);

			Gates[objectid][gateOpenSpeed] = speed;

			mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `gates` SET `openspeed` = %f WHERE `id` = '%d'", speed, Gates[objectid][gateID]);
			mysql_pquery(dbCon, gquery);

	      	SendClientMessageEx(playerid, COLOR_YELLOW, "-> You've successfully set Gate %d's moving speed to: %f", objectid, speed);
      	}
      	else SendSyntaxMessage(playerid, "/editgate %d 3 [speed]", objectid);
	}
	else if(type == 4)
	{
	    if(strlen(input))
		{
			mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `gates` SET `name` = '%e' WHERE `id` = '%d'", input, Gates[objectid][gateID]);
			mysql_pquery(dbCon, gquery);

	      	SendClientMessageEx(playerid, COLOR_YELLOW, "-> You've successfully set Gate %d's name to: %s", objectid, input);
		}
		else SendSyntaxMessage(playerid, "/editgate %d 4 [name]", objectid);
	}
	else if(type == 5)
	{
	    if(strlen(input))
		{
			new faction = strval(input);

			if(faction > 0 || faction == -1)
			{
			    Gates[objectid][gateFaction] = faction;

				mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `gates` SET `faction` = '%d' WHERE `id` = '%d'", faction, Gates[objectid][gateID]);
				mysql_pquery(dbCon, gquery);

				SendClientMessageEx(playerid, COLOR_YELLOW, "-> You've successfully set Gate %d's faction to: %d", objectid, faction);
	      	}
		}
		else SendSyntaxMessage(playerid, "/editgate %d 5 [faction type]", objectid);
	}
	return true;
}

CMD:whatgate(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1337)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new Float:fDistance[2] = {99999.0, 0.0}, i = -1;

	foreach (new x: Gates)
	{
		fDistance[1] = GetPlayerDistanceFromPoint(playerid, Gates[x][gatePosX], Gates[x][gatePosY], Gates[x][gatePosZ]);

		if(fDistance[1] < fDistance[0])
		{
			fDistance[0] = fDistance[1];
			i = x;
		}
	}

	if(i != -1 && fDistance[0] < 5)
	{
		SendClientMessageEx(playerid, COLOR_GRAD2, "You're standing near Gate: [Script ID: %d] [MySQL ID: %d]", i, Gates[i][gateID]);
	}
	else SendClientMessage(playerid, COLOR_GRAD2, "Nothing nearby.");

	return true;
}

CMD:showgates(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1337)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	gstr[0] = EOS;

	format(gstr, sizeof(gstr), "ID\tDescription\tFaction\n");

	foreach (new i : Gates)
	{
		format(gstr, sizeof(gstr), "%s%d\t%s\t%s (%d)\n", gstr, i, Gates[i][gateName], ReturnFactionNameByType(Gates[i][gateFaction]), Gates[i][gateFaction]);
	}

	Dialog_Show(playerid, ShowGates, DIALOG_STYLE_TABLIST_HEADERS, "Server Gates", gstr, "Teleport", "Cancel");
	return true;
}

CMD:showmovedoors(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1337)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	gstr[0] = EOS;

	format(gstr, sizeof(gstr), "ID\tDescription\tFaction\n");

	foreach (new i : Movedoors)
	{
		format(gstr, sizeof(gstr), "%s%d\t%s\t%s (%d)\n", gstr, i, Doors[i][doorName], ReturnFactionNameByType(Doors[i][doorFaction]), Doors[i][doorFaction]);
	}

	Dialog_Show(playerid, ShowMovedoors, DIALOG_STYLE_TABLIST_HEADERS, "Server Moving Doors", gstr, "Teleport", "Cancel");
	return true;
}

Dialog:ShowGates(playerid, response, listitem, inputtext[])
{
	if(!response) return true;

	new gate = strval(inputtext);

	SendClientMessageEx(playerid, -1, "Teleported to Gate %d.", gate);

	SetPlayerDynamicPos(playerid, Gates[gate][gatePosX], Gates[gate][gatePosY], Gates[gate][gatePosZ]);
	return true;
}

Dialog:ShowMovedoors(playerid, response, listitem, inputtext[])
{
	if(!response) return true;

	new gate = strval(inputtext);

	SendClientMessageEx(playerid, -1, "Teleported to Movedoor %d.", gate);

	SetPlayerDynamicPos(playerid, Doors[gate][doorPosX], Doors[gate][doorPosY], Doors[gate][doorPosZ]);
	return true;
}

CMD:makemovedoor(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1337)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new objectid, modelid, faction, name[64], Float:X, Float:Y, Float:Z;

	if(sscanf(params, "dds[64]", modelid, faction, name))
	{
		SendSyntaxMessage(playerid, "/makemovedoor [modelid] [Faction Type] [Description]");
		SendClientMessage(playerid, COLOR_GREY, "Faction types: 1: LSPD | 2: NEWS | 3: LSFD | 4: GOV | 5: MAFIA | 6: LSSD | 7: DOC");
		return true;
	}

	GetPlayerPos(playerid, X, Y, Z);

    if((objectid = Iter_Free(Movedoors)) != -1)
	{
		Doors[objectid][doorModel] = modelid;
		Doors[objectid][doorPosX] = X;
		Doors[objectid][doorPosY] = Y;
		Doors[objectid][doorPosZ] = Z;
		Doors[objectid][doorPosRX] = 0.0;
		Doors[objectid][doorPosRY] = 0.0;
		Doors[objectid][doorPosRZ] = 0.0;
		Doors[objectid][doorInterior] = GetPlayerInterior(playerid);
		Doors[objectid][doorFaction] = faction;
		Doors[objectid][doorOpened] = 0;
		Doors[objectid][doorLocked] = 0;
		Doors[objectid][doorVirtualWorld] = GetPlayerVirtualWorld(playerid);

		format(Doors[objectid][doorName], 64, "%s", name);
		Doors[objectid][doorObject] = CreateDynamicObject(modelid, X, Y, Z, 0.0, 0.0, 0.0, Doors[objectid][doorVirtualWorld], Doors[objectid][doorInterior], -1, 200.0);

		AddMoveDoorToFile(objectid, Doors[objectid][doorModel], Doors[objectid][doorFaction], Doors[objectid][doorInterior], Doors[objectid][doorVirtualWorld], Doors[objectid][doorPosX], Doors[objectid][doorPosY], Doors[objectid][doorPosZ], Doors[objectid][doorName]);

		SendClientMessageEx(playerid, COLOR_GREEN, "New moving door has been added [DoorID: %d, ModelID: %d, Description: %s]", objectid, modelid, Doors[objectid][doorName]);

		Iter_Add(Movedoors, objectid);
	}
	return true;
}

CMD:dupmovedoor(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1337)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new objectid, doorid, name[64];

	if(sscanf(params, "ds[64]", doorid, name))
		return SendSyntaxMessage(playerid, "/dupmovedoor [doorid] [Description]");

	if(!Iter_Contains(Movedoors, doorid))
		return SendClientMessage(playerid, COLOR_WHITE, "ERROR: The specified sliding door was not found!");

	if((objectid = Iter_Free(Movedoors)) != -1)
	{
		Doors[objectid][doorModel] = Doors[doorid][doorModel];
		Doors[objectid][doorPosX] = Doors[doorid][doorPosX];
		Doors[objectid][doorPosY] = Doors[doorid][doorPosY];
		Doors[objectid][doorPosZ] = Doors[doorid][doorPosZ];
		Doors[objectid][doorPosRX] = Doors[doorid][doorPosRX];
		Doors[objectid][doorPosRY] = Doors[doorid][doorPosRY];
		Doors[objectid][doorPosRZ] = Doors[doorid][doorPosRZ];
		Doors[objectid][doorInterior] = Doors[doorid][doorInterior];
		Doors[objectid][doorFaction] = Doors[doorid][doorFaction];
		Doors[objectid][doorOpened] = Doors[doorid][doorOpened];
		Doors[objectid][doorLocked] = Doors[doorid][doorLocked];
		Doors[objectid][doorVirtualWorld] = Doors[doorid][doorVirtualWorld];

		format(Doors[objectid][doorName], 64, "%s", name);

		Doors[objectid][doorObject] = CreateDynamicObject(Doors[objectid][doorModel], Doors[objectid][doorPosX], Doors[objectid][doorPosY], Doors[objectid][doorPosZ], Doors[objectid][doorPosRX], Doors[objectid][doorPosRY], Doors[objectid][doorPosRZ], Doors[objectid][doorVirtualWorld], Doors[objectid][doorInterior], -1, 200.0);

		AddMoveDoorToFile(objectid, Doors[objectid][doorModel], Doors[objectid][doorFaction], Doors[objectid][doorInterior], Doors[objectid][doorVirtualWorld], Doors[objectid][doorPosX], Doors[objectid][doorPosY], Doors[objectid][doorPosZ], Doors[objectid][doorName]);

		SendClientMessageEx(playerid, COLOR_GREEN, "New sliding door was copied [DoorID: %d, ModelID: %d, Description: %s]", objectid, Doors[objectid][doorModel], Doors[objectid][doorName]);

		Iter_Add(Movedoors, objectid);
	}
	return true;
}

CMD:removemovedoor(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1337)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new objectid;

	if(sscanf(params, "d", objectid))
		return SendSyntaxMessage(playerid, "/removemovedoor [doorid]");

	if(!Iter_Contains(Movedoors, objectid))
	    return SendErrorMessage(playerid, "Invalid moving door specified.");

	mysql_format(dbCon, gquery, sizeof(gquery), "DELETE FROM `movedoors` WHERE `id` = '%d'", Doors[objectid][doorID]);
	mysql_tquery(dbCon, gquery, "OnMoveDoorRemove", "i", objectid);

	Iter_Remove(Movedoors, objectid);

	SendClientMessageEx(playerid, COLOR_YELLOW, "-> Moving door %d successfully removed from the database.", objectid);
	return true;
}

CMD:cancelmovedoor(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1337)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	CancelEdit(playerid);

	DeletePVar(playerid, "EditingMoveDoor");
	DeletePVar(playerid, "ObjectEditing");
	return true;
}

CMD:editmovedoor(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1337)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new objectid, type, input[64];

	if(sscanf(params, "ddS()[64]", objectid, type, input))
	{
		SendSyntaxMessage(playerid, "/editmovedoor [doorid] [type (1-Object, 2-Move, 3-OpenSpeed, 4-Name, 5-Faction Type)]");
		SendClientMessage(playerid, COLOR_GREY, "Faction types: 1: LSPD | 2: NEWS | 3: LSFD | 4: GOV | 5: MAFIA | 6: LSSD | 7: DOC");
		return true;
	}

	if(!Iter_Contains(Movedoors, objectid))
		return SendErrorMessage(playerid, "Invalid moving door specified.");

	if(type == 1)
	{
		if(GetPVarInt(playerid, "EditingMoveDoor") == 1)
			return SendClientMessage(playerid, COLOR_FADE1, "You're already editing another door.");

		SetPVarInt(playerid, "EditingMoveDoor", 1);
		SetPVarInt(playerid, "ObjectEditing", objectid);

		EditDynamicObject(playerid, Doors[objectid][doorObject]);

		SendClientMessageEx(playerid, COLOR_YELLOW, "-> You're now adjusting moving door %d's default position.", objectid);
	}
	else if(type == 2)
	{
		if(GetPVarInt(playerid, "EditingMoveDoorMove") == 1)
			return SendClientMessage(playerid, COLOR_FADE1, "You're already editing another door.");

		SetPVarInt(playerid, "EditingMoveDoorMove", 1);
		SetPVarInt(playerid, "ObjectEditing", objectid);

		EditDynamicObject(playerid, Doors[objectid][doorObject]);

		SendClientMessageEx(playerid, COLOR_YELLOW, "-> You're now adjusting moving door %d's moving position.", objectid);
	}
	else if(type == 3)
	{
	    if(strlen(input))
		{
		    new Float:speed = floatstr(input);

			Doors[objectid][doorOpenSpeed] = speed;

			mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `movedoors` SET `openspeed` = '%f' WHERE `id` = %d", speed, Doors[objectid][doorID]);
			mysql_pquery(dbCon, gquery);

	      	SendClientMessageEx(playerid, COLOR_GREEN, "-> Moving door %d's speed has been adjusted to: %.0f", speed);
      	}
      	else SendSyntaxMessage(playerid, "/editmovedoor %d 3 [speed]", objectid);
	}
	else if(type == 4)
	{
	    if(strlen(input))
		{
			format(Doors[objectid][doorName], 64, "%s", input);

			mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `movedoors` SET `name` = '%e' WHERE `id` = %d", input, Doors[objectid][doorID]);
			mysql_pquery(dbCon, gquery);

	      	SendClientMessageEx(playerid, COLOR_GREEN, "-> Moving door %d's name has been adjusted to: %s", input);
		}
		else SendSyntaxMessage(playerid, "/editmovedoor %d 4 [name]", objectid);
	}
	else if(type == 5)
	{
	    if(strlen(input))
		{
			new faction = strval(input);

			if(faction && faction < MAX_FACTIONS || faction == -1)
			{
			    Doors[objectid][doorFaction] = faction;

				mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `movedoors` SET `faction` = '%d' WHERE `id` = %d", faction, Doors[objectid][doorID]);
				mysql_pquery(dbCon, gquery);

				SendClientMessageEx(playerid, COLOR_GREEN, "-> Moving door %d's faction has been adjusted to: %d", Doors[objectid][doorFaction]);
	      	}
		}
		else SendSyntaxMessage(playerid, "/editmovedoor %d 5 [faction type]", objectid);
	}
	return true;
}

CMD:whatmovedoor(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1337)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new Float:fDistance[2] = {99999.0, 0.0}, i = -1 ;

	foreach (new x: Movedoors)
	{
		fDistance[1] = GetPlayerDistanceFromPoint(playerid, Doors[x][doorPosX], Doors[x][doorPosY], Doors[x][doorPosZ]);

		if(fDistance[1] < fDistance[0])
		{
			fDistance[0] = fDistance[1];
			i = x;
		}
	}

	if(i != -1 && fDistance[0] < 5)
	{
		SendClientMessageEx(playerid, COLOR_GRAD2, "You're standing near moving door: [Script ID: %d] [MySQL ID: %d]", i, Doors[i][doorID]);
	}
	else SendClientMessage(playerid, COLOR_GRAD2, "Nothing nearby.");

	return true;
}

CMD:gotojet(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 3)
		return SendErrorMessage(playerid, "You're not authorized to use this command.");

    SetPlayerDynamicPos(playerid, 1.5491, 23.3183, 1199.5938);
	SetPlayerInterior(playerid, 1);
	SetPlayerVirtualWorld(playerid, 0);

	SendClientMessage(playerid, COLOR_GREY, "You have been teleported to Jet Interior.");

	DesyncPlayerInterior(playerid);
	return true;
}

CMD:gotoin(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 3)
		return SendErrorMessage(playerid, "You're not authorized to use this command.");

    SetPlayerDynamicPos(playerid, 1412.639892, -1.787510, 1000.924377);
	SetPlayerInterior(playerid, 1);
	SetPlayerVirtualWorld(playerid, 0);

	SendClientMessage(playerid, COLOR_GREY, "You have been teleported to Old Warehouse.");

	DesyncPlayerInterior(playerid);
	return true;
}

CMD:gotostad(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 3)
		return SendErrorMessage(playerid, "You're not authorized to use this command.");

    SetPlayerDynamicPos(playerid, -1395.958, -208.197, 1051.170);
	SetPlayerInterior(playerid, 0);
	SetPlayerVirtualWorld(playerid, 0);

	SendClientMessage(playerid, COLOR_GREY, "You have been teleported to Race Interior.");

	DesyncPlayerInterior(playerid);
	return true;
}

CMD:sslap(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 3)
		return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new targetid, Float:slx, Float:sly, Float:slz;

	if(sscanf(params, "u", targetid))
		return SendSyntaxMessage(playerid, "/sslap [playerid/PartOfName]");

	if(!IsPlayerConnected(targetid))
		return SendErrorMessage(playerid, "The player you specified isn't connected.");

	if(!SQL_IsLogged(targetid))
		return SendErrorMessage(playerid, "The player you specified isn't logged in.");

	GetPlayerPos(targetid, slx, sly, slz);
	SetPlayerDynamicPos(targetid, slx, sly, slz + 5);
	PlayerPlaySound(targetid, 1130, slx, sly, slz + 5);

	SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(3): %s silently slapped player %s.", ReturnName(playerid), ReturnName(targetid), targetid);

	SQL_LogAction(targetid, "AdmCmd: Silently slapped by %s.", ReturnName(playerid));
	return true;
}

CMD:smack(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 3)
		return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new targetid, Float:slx, Float:sly, Float:slz;

	if(sscanf(params, "u", targetid))
		return SendSyntaxMessage(playerid, "/smack [playerid/PartOfName]");

	if(!IsPlayerConnected(targetid))
		return SendErrorMessage(playerid, "The player you specified isn't connected.");

	if(!SQL_IsLogged(targetid))
		return SendErrorMessage(playerid, "The player you specified isn't logged in.");

	GetPlayerPos(targetid, slx, sly, slz);
	SetPlayerDynamicPos(targetid, slx + 2, sly + 5, slz + 2);
	PlayerPlaySound(targetid, 1130, slx, sly, slz + 5);

	SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(3): %s smacked player %s.", ReturnName(playerid), ReturnName(targetid), targetid);
	return true;
}

CMD:enabletp(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 3)
		return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new userid;

	if(sscanf(params, "u", userid))
	    return SendSyntaxMessage(playerid, "/enabletp [playerid/PartOfName]");

	if(!IsPlayerConnected(userid))
		return SendErrorMessage(playerid, "The player you specified isn't connected.");

	if(!SQL_IsLogged(userid))
		return SendErrorMessage(playerid, "The player you specified isn't logged in.");

	if(EnableTP{userid})
        return SendErrorMessage(playerid, "Player already has right click on map teleportation enabled.");

	EnableTP{userid} = true;

    SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(3): %s enabled %s's ability to teleport by right click on map.", ReturnName(playerid), ReturnName(userid));
	return true;
}

CMD:disabletp(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 3)
		return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new userid;

	if(sscanf(params, "u", userid))
	    return SendSyntaxMessage(playerid, "/disabletp [playerid/PartOfName]");

	if(!IsPlayerConnected(userid))
		return SendErrorMessage(playerid, "The player you specified isn't connected.");

	if(!SQL_IsLogged(userid))
		return SendErrorMessage(playerid, "The player you specified isn't logged in.");

	if(!EnableTP{userid})
        return SendErrorMessage(playerid, "Player doesn't have right click on map teleportation enabled.");

	EnableTP{userid} = false;

    SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(3): %s disabled %s's ability to teleport by right click on map.", ReturnName(playerid), ReturnName(userid));
	return true;
}

CMD:kickfromjob(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 3)
		return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new userid;

	if(sscanf(params, "u", userid))
	    return SendSyntaxMessage(playerid, "/disabletp [playerid/PartOfName]");

	if(!IsPlayerConnected(userid))
		return SendErrorMessage(playerid, "The player you specified isn't connected.");

	if(!SQL_IsLogged(userid))
		return SendErrorMessage(playerid, "The player you specified isn't logged in.");

	if(PlayerData[userid][pJob] == JOB_NONE)
	    return SendErrorMessage(playerid, "This player doesn't have a job.");

    PlayerData[userid][pJob] = JOB_NONE;

	SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(3): %s kicked %s [%d] from their job.", ReturnName(playerid), ReturnName(userid), userid);
	return true;
}

CMD:givepack(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4)
		return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new userid;

	if(sscanf(params, "u", userid))
	    return SendSyntaxMessage(playerid, "/givepack [playerid/PartOfName]");

	if(!IsPlayerConnected(userid))
		return SendErrorMessage(playerid, "The player you specified isn't connected.");

	if(!SQL_IsLogged(userid))
		return SendErrorMessage(playerid, "The player you specified isn't logged in.");

	if(PlayerData[userid][pAdmin] < 1)
	    return SendErrorMessage(playerid, "Player is not an admin.");

	SetPlayerSpecialAction(userid, SPECIAL_ACTION_USEJETPACK);

    SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(4): %s gave %s a jetpack", ReturnName(playerid), ReturnName(userid));
	return true;
}

YCMD:la(playerid, params[], help) = leadadmin;
YCMD:ladmin(playerid, params[], help) = leadadmin;

CMD:leadadmin(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4)
		return SendErrorMessage(playerid, "You're not authorized to use this command.");

	if(isnull(params))
		return SendClientMessage(playerid, COLOR_LIGHTRED, "USAGE: (/la)dmin [lead admin chat]");

	new str1[128], str2[128], bool:splitted = false;	

	if(strlen(params) > 80)
	{
		format(str1, sizeof(str1), "* Lead Admin %s: %s", ReturnName(playerid), params);
		format(str2, sizeof(str2), "* Lead Admin %s: ... %s", ReturnName(playerid), params[80]);

		splitted = true;
	}
	else
	{
		format(str1, sizeof(str1), "* Lead Admin %s: %s", ReturnName(playerid), params);
	}

 	foreach (new i : Player)
	{
	    if(PlayerData[i][pID] == -1) continue;

		if(PlayerData[i][pAdmin] >= 4)
		{
			if(splitted)
			{
				SendClientMessage(i, COLOR_YELLOW, str1);
				SendClientMessage(i, COLOR_YELLOW, str2);
			}
			else
			{
				SendClientMessage(i, COLOR_YELLOW, str1);
			}
		}
	}
	return true;
}

YCMD:a(playerid, params[], help) = admin;

CMD:admin(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
		return SendErrorMessage(playerid, "You're not authorized to use this command.");

	if(isnull(params))
		return SendClientMessage(playerid, COLOR_LIGHTRED, "USAGE: (/a)dmin [admin chat]");

	new str1[128], str2[128], bool:splitted = false;	

	if(strlen(params) > 80)
	{
		format(str1, sizeof(str1), "*Admin[%d] %s: %.80s ...", PlayerData[playerid][pAdmin] == 1338 ? 2 : PlayerData[playerid][pAdmin], AccountName(playerid), params);
		format(str2, sizeof(str2), "*Admin[%d] %s: ... %s", PlayerData[playerid][pAdmin] == 1338 ? 2 : PlayerData[playerid][pAdmin], AccountName(playerid), params[80]);

		splitted = true;
	}
	else
	{
		format(str1, sizeof(str1), "*Admin[%d] %s: %s", PlayerData[playerid][pAdmin] == 1338 ? 2 : PlayerData[playerid][pAdmin], AccountName(playerid), params);
	}

 	foreach (new i : Player)
	{
		if(PlayerData[i][pID] == -1) continue;

		if(PlayerData[i][pAdmin] >= 1)
		{
			if(splitted)
			{
				SendClientMessage(i, COLOR_YELLOW, str1);
				SendClientMessage(i, COLOR_YELLOW, str2);
			}
			else
			{
				SendClientMessage(i, COLOR_YELLOW, str1);
			}
		}
	}

    /*if(!systemVariables[DiscordStatus])
    {
		format(sgstr, sizeof(sgstr), "*Admin[%d] %s: %s", PlayerData[playerid][pAdmin], AccountName(playerid), params);
		DCC_SendChannelMessage(adminChatChannel, sgstr);
	}*/
	return true;
}

CMD:at(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 1 && !IsTester(playerid))
		return SendClientMessage(playerid, COLOR_LIGHTRED, "You are not a tester!");

	if(isnull(params))
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "USAGE: /at [all staff chat]");	

	new str1[128], str2[128], bool:splitted = false;

	if(strlen(params) > 80)
	{
		format(str1, sizeof(str1), "*STAFF[%d] %s: %.80s ...", PlayerData[playerid][pAdmin] == 1338 ? 2 : PlayerData[playerid][pAdmin], AccountName(playerid), params);
		format(str2, sizeof(str2), "*STAFF[%d] %s: %s: ... %s", PlayerData[playerid][pAdmin] == 1338 ? 2 : PlayerData[playerid][pAdmin], AccountName(playerid), params[80]);

		splitted = true;
	}
	else
	{
		format(str1, sizeof(str1), "*STAFF[%d] %s: %s", PlayerData[playerid][pAdmin] == 1338 ? 2 : PlayerData[playerid][pAdmin], AccountName(playerid), params);
	}

 	foreach (new i : Player)
	{
	    if(PlayerData[i][pID] == -1) continue;

		if(PlayerData[i][pAdmin] >= 1 || PlayerData[i][pAdmin] == -1)
		{
			if(splitted)
			{
				SendClientMessage(i, 0x40BF00FF, str1);
				SendClientMessage(i, 0x40BF00FF, str2);
			}
			else
			{
				SendClientMessage(i, 0x40BF00FF, str1);
			}
		}
	}
	return true;
}

YCMD:ao(playerid, params[], help) = aooc;
YCMD:announce(playerid, params[], help) = aooc;

CMD:aooc(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	if(isnull(params))
	    return SendSyntaxMessage(playerid, "/(a)ooc [message]");

	if(strlen(params) > 70)
	{
	    SendClientMessageToAllEx(COLOR_ORANGE, "[AOOC] Admin %s: %.70s", AccountName(playerid), params);
	    SendClientMessageToAllEx(COLOR_ORANGE, "[AOOC] Admin %s: ... %s", AccountName(playerid), params[70]);
	}
	else
	{
	    SendClientMessageToAllEx(COLOR_ORANGE, "[AOOC] Admin %s: %s", AccountName(playerid), params);
	}

	//format(sgstr, sizeof(sgstr), "[AOOC] Admin %s: %s", AccountName(playerid), params);
    //SQL_LogChat(playerid, "/announce", sgstr);
	return true;
}

CMD:setplate(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4)
		return SendUnauthMessage(playerid, "You're not authorized to use this command.");

    if(!IsPlayerInAnyVehicle(playerid))
		return SendClientMessage(playerid, COLOR_GRAD2, "You must be in a vehicle to use this.");

	new vehicleid = GetPlayerVehicleID(playerid);

 	SetVehicleNumberPlate(vehicleid, params);
 	SetVehicleToRespawn(vehicleid);

	SendClientMessageEx(playerid, COLOR_YELLOW, "Plate has been set to %s.", params);
	return true;
}

CMD:pmears(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4)
		return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	if(!PrivateMessageEars{playerid})
	{
	    PrivateMessageEars{playerid} = true;

	    SendNoticeMessage(playerid, "PM ears enabled, you'll now receive every private message.");
	}
	else
	{
	    PrivateMessageEars{playerid} = false;

	    SendNoticeMessage(playerid, "PM ears disabled.");
	}
	return true;
}

CMD:factionears(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4)
		return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	if(!FactionEars{playerid})
	{
	    FactionEars{playerid} = true;

	    SendNoticeMessage(playerid, "Faction ears enabled, you'll now receive every faction message.");
	}
	else
	{
	    FactionEars{playerid} = false;

	    SendNoticeMessage(playerid, "Faction ears disabled.");
	}
	return true;
}

CMD:veh(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] >= 3)
	{
		new
			carid[32],
			Float: carSpawnPos[4], // 3 for the usual dimensions, +1 for the rotation/angle.
			color1,
			color2
		;

        if(!sscanf(params, "s[32]I(-1)I(-1)", carid, color1, color2))
		{
			if((carid[0] = GetVehicleModelByName(carid)) == 0)
			    return SendClientMessage(playerid, COLOR_GREY, "Invalid vehicle model specified.");

			if(systemVariables[vehicleCounts][0] + systemVariables[vehicleCounts][1] + systemVariables[vehicleCounts][2] < MAX_VEHICLES)
			{
                for(new i = 0; i != MAX_ADMIN_VEHICLES; ++i)
				{
					if(!AdminSpawnedVehicles[i])
					{
						GetPlayerPos(playerid, carSpawnPos[0], carSpawnPos[1], carSpawnPos[2]);
						GetPlayerFacingAngle(playerid, carSpawnPos[3]);

						AdminSpawnedVehicles[i] = CreateVehicle(carid[0], carSpawnPos[0], carSpawnPos[1], carSpawnPos[2], carSpawnPos[3], color1, color2, -1);
						systemVariables[vehicleCounts][2]++;

			    		Iter_Add(sv_vehicles, AdminSpawnedVehicles[i]);

			    		ResetVehicle(AdminSpawnedVehicles[i]);

						LinkVehicleToInterior(AdminSpawnedVehicles[i], GetPlayerInterior(playerid));
						SetVehicleVirtualWorld(AdminSpawnedVehicles[i], GetPlayerVirtualWorld(playerid));

						PutPlayerInVehicle(playerid, AdminSpawnedVehicles[i], 0);

						SetEngineStatus(AdminSpawnedVehicles[i], true);

						switch(carid[0])
						{
							case 427, 428, 432, 601, 528:
							{
								SetVehicleHealth(AdminSpawnedVehicles[i], 5000.0);
							}
						}

						SendClientMessageEx(playerid, COLOR_GREY, "Vehicle spawned (ID %d).", AdminSpawnedVehicles[i]);

						SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(3): %s spawned a %s with /veh (ID: %d).", ReturnName(playerid), ReturnVehicleModelName(carid[0]), AdminSpawnedVehicles[i]);
						break;
					}
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_GENANNOUNCE, "(error) 01x08");
				printf("ERROR: Vehicle limit reached (MODEL %d, MAXIMUM %d, TYPE ADMIN) [01x08]", carid, MAX_VEHICLES);
			}
        }
        else
		{
            SendSyntaxMessage(playerid, "/veh [model id/name] <color 1> <color 2>");
        }
        return true;
    }

    SendUnauthMessage(playerid, "You're not authorized to use this command.");
	return true;
}

CMD:fuelveh(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
	    return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	new id;

	if(sscanf(params, "d", id))
 	{
		if(IsPlayerInAnyVehicle(playerid))
			id = GetPlayerVehicleID(playerid);
		else
			return SendSyntaxMessage(playerid, "/fuelveh [vehicle id]");
	}

	if(id < 1 || id > MAX_VEHICLES || !IsValidVehicle(id))
		return SendErrorMessage(playerid, "Invalid vehicle ID specified.");

	CoreVehicles[id][vehFuel] = GetVehicleDataFuel(GetVehicleModel(id));

	SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(1): %s refueled vehicle %d.", ReturnName(playerid), id);
	return true;
}

CMD:fillallcars(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 3)
	    return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	foreach (new i : sv_vehicles)
	{
		CoreVehicles[i][vehFuel] = GetVehicleDataFuel(GetVehicleModel(i));
	}

	SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(3): %s has refueled all vehicles.", ReturnName(playerid));
	return true;
}

CMD:despawncars(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 3)
	    return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	new vehicleCount;

	for(new i = 0; i != MAX_ADMIN_VEHICLES; ++i)
	{
 		if(AdminSpawnedVehicles[i])
		{
			DestroyVehicle(AdminSpawnedVehicles[i]);

			Iter_Remove(sv_vehicles, AdminSpawnedVehicles[i]);

			AdminSpawnedVehicles[i] = 0;

			systemVariables[vehicleCounts][2]--;

			vehicleCount++;
		}
	}

	if(!vehicleCount) return SendErrorMessage(playerid, "No admin vehicles found.");

	SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(3): %s destroyed %d admin created vehicles.", ReturnName(playerid), vehicleCount);
	return true;
}

CMD:despawncar(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 3)
	    return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	new vehicleid;

	if(sscanf(params, "d", vehicleid))
	{
		if(IsPlayerInAnyVehicle(playerid))
			vehicleid = GetPlayerVehicleID(playerid);
		else
			return SendSyntaxMessage(playerid, "/despawncar [vehicleid]");
	}

	for(new i = 0; i != MAX_ADMIN_VEHICLES; ++i)
	{
		if(AdminSpawnedVehicles[i] == vehicleid)
		{
			SendClientMessageEx(playerid, COLOR_GRAD1, "You destroyed admin vehicle %d (%d).", AdminSpawnedVehicles[i], vehicleid);

			DestroyVehicle(AdminSpawnedVehicles[i]);

			Iter_Remove(sv_vehicles, AdminSpawnedVehicles[i]);

			AdminSpawnedVehicles[i] = 0;

			systemVariables[vehicleCounts][2]--;
			return true;
		}
	}

	SendErrorMessage(playerid, "This is not an admin created vehicle.");
	return true;
}

CMD:testcar(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
	    return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	new vehicleid, id = -1;

	if(sscanf(params, "d", vehicleid))
	{
		if(IsPlayerInAnyVehicle(playerid))
	 		vehicleid = GetPlayerVehicleID(playerid);
		else
			return SendSyntaxMessage(playerid, "/testcar [vehicleid]");
	}

	if(!IsValidVehicle(vehicleid))
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "Vehicle doesn't exist.");

    if((id = Car_GetID(vehicleid)) == -1)
        return SendClientMessage(playerid, COLOR_LIGHTRED, "You can't use this on non-player vehicles.");

    Car_PrintStats(playerid, id);

	SendClientMessageEx(playerid, COLOR_CYAN, "Owner ID: %d", CarData[id][carOwner]);
	return true;
}

CMD:apark(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
	    return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	new vehicleid, id = -1;

	if(sscanf(params, "d", vehicleid))
	{
		if(IsPlayerInAnyVehicle(playerid))
			vehicleid = GetPlayerVehicleID(playerid);
		else
			return SendClientMessage(playerid, COLOR_LIGHTRED, "USAGE: /apark [vehicleid]");
	}

	if(!IsValidVehicle(vehicleid))
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "Vehicle doesn't exist.");

	if((id = Car_GetID(vehicleid)) == -1)
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "You can't apark a non-player vehicle.");

    SendClientMessageEx(playerid, COLOR_GREY, "Vehicle %d successfully despawned.", vehicleid);

 	foreach (new x : Player)
	{
		if(CarData[id][carOwner] == PlayerData[playerid][pID])
		{
	        RemoveVehicleKey(playerid, id);
			break;
		}
	}

   	SaveVehicleDamageID(id);

	Car_SaveID(id);
 	Car_DespawnEx(id);
	return true;
}

CMD:saveveh(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] >= 4)
	{
		if(!IsPlayerInAnyVehicle(playerid))
			return SendClientMessage(playerid, COLOR_LIGHTRED, "You must be on a vehicle to save it.");

		if(GetPVarInt(playerid, "sCc") == 1)
		{
			new i = Iter_Free(sv_servercar);

		    if(i != -1)
			{
				    new
				        queryString[255],
				        Float: vPos[4],
						vehicleid = GetPlayerVehicleID(playerid); // x, y, z + z angle

				    GetVehiclePos(vehicleid, vPos[0], vPos[1], vPos[2]);
				    GetVehicleZAngle(vehicleid, vPos[3]);

				    format(queryString, sizeof(queryString), "INSERT INTO vehicles (vehicleModelID, vehiclePosX, vehiclePosY, vehiclePosZ, vehiclePosRotation) VALUES('%d', '%f', '%f', '%f', '%f')", GetVehicleModel(vehicleid), vPos[0], vPos[1], vPos[2], vPos[3]);
				    new Cache:cache = mysql_query(dbCon, queryString);

				    new insertid = cache_insert_id();

				    cache_delete(cache);

				    SendClientMessage(playerid, COLOR_GRAD1, "   Vehicle is saved !");

					vehicleVariables[i][vVehicleID] = insertid;
				    vehicleVariables[i][vVehicleModelID] = GetVehicleModel(vehicleid);
				    vehicleVariables[i][vVehiclePosition][0] = vPos[0];
				    vehicleVariables[i][vVehiclePosition][1] = vPos[1];
				    vehicleVariables[i][vVehiclePosition][2] = vPos[2];
				    vehicleVariables[i][vVehicleRotation] = vPos[3];
				    vehicleVariables[i][vVehicleFaction] = -1;
				    vehicleVariables[i][vVehicleSiren] = 0;

				    vehicleVariables[i][vVehicleScriptID] = vehicleid;

				    Iter_Add(sv_servercar, i);

					for(new x = 0; x != MAX_ADMIN_VEHICLES; ++x)
					{
						if(AdminSpawnedVehicles[x] == vehicleid)
						{
         					AdminSpawnedVehicles[x] = 0; // If the vehicle is admin-spawned, we can remove it from the array and move it to the vehicle script enum/arrays.
                            break;
						}
					}

					systemVariables[vehicleCounts][2]--;
					systemVariables[vehicleCounts][0]++;

					DeletePVar(playerid, "sCc");
					return true;
			}
		}
		else
		{
		    SetPVarInt(playerid, "sCc", 1);
		    return SendClientMessage(playerid, COLOR_LIGHTRED, "Are you sure you want to save this vehicle? Use this command again to confirm.");
		}
	}

	return true;
}

CMD:deleteveh(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 4)
	    return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	new
	    id = 0
	;

	if(sscanf(params, "d", id))
 	{
	 	if(IsPlayerInAnyVehicle(playerid))
		 	id = GetPlayerVehicleID(playerid);

		else return SendSyntaxMessage(playerid, "/deleteveh [vehicle id]");
	}

	if((id = Vehicle_GetID(id)) != -1)
	{
		new string[64];

		mysql_format(dbCon, string, sizeof(string), "DELETE FROM `vehicles` WHERE `vehicleID` = '%d' LIMIT 1", vehicleVariables[id][vVehicleID]);
		mysql_tquery(dbCon, string);

		SendClientMessageEx(playerid, COLOR_GRAD1, " You've destroyed vehicle %d.", vehicleVariables[id][vVehicleScriptID]);

		DestroyVehicle(vehicleVariables[id][vVehicleScriptID]);

		Iter_Remove(sv_servercar, id);
		Iter_Remove(sv_vehicles, vehicleVariables[id][vVehicleScriptID]);
	}
	return true;
}

CMD:editveh(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4)
	    return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	new
	    id,
	    type[24],
	    string[128]
	;

	if(sscanf(params, "ds[24]S()[128]", id, type, string))
 	{
	 	SendSyntaxMessage(playerid, "/editveh [id] [name]");
	    SendClientMessage(playerid, COLOR_GREY, "Available names: location, faction, color1, color2, siren, plate");
		return true;
	}

	if((id = Vehicle_GetID(id)) != -1)
	{
		if(!strcmp(type, "location", true))
		{
		    if(GetPlayerVehicleID(playerid) == vehicleVariables[id][vVehicleScriptID])
		    {
				GetVehiclePos(vehicleVariables[id][vVehicleScriptID], vehicleVariables[id][vVehiclePosition][0], vehicleVariables[id][vVehiclePosition][1], vehicleVariables[id][vVehiclePosition][2]);
				GetVehicleZAngle(vehicleVariables[id][vVehicleScriptID], vehicleVariables[id][vVehicleRotation]);
			}
			else
			{
		 		GetPlayerPos(playerid, vehicleVariables[id][vVehiclePosition][0], vehicleVariables[id][vVehiclePosition][1], vehicleVariables[id][vVehiclePosition][2]);
				GetPlayerFacingAngle(playerid, vehicleVariables[id][vVehicleRotation]);
			}

			Vehicle_Save(id);
			DestroyVehicle(vehicleVariables[id][vVehicleScriptID]);
			Iter_Remove(sv_vehicles, vehicleVariables[id][vVehicleScriptID]);

			vehicleVariables[id][vVehicleScriptID] = CreateVehicle(vehicleVariables[id][vVehicleModelID], vehicleVariables[id][vVehiclePosition][0], vehicleVariables[id][vVehiclePosition][1], vehicleVariables[id][vVehiclePosition][2], vehicleVariables[id][vVehicleRotation], vehicleVariables[id][vVehicleColour][0], vehicleVariables[id][vVehicleColour][1], 60000, vehicleVariables[id][vVehicleSiren]);

		  	Iter_Add(sv_vehicles, vehicleVariables[id][vVehicleScriptID]);

			SetPlayerPosEx(playerid, vehicleVariables[id][vVehiclePosition][0], vehicleVariables[id][vVehiclePosition][1], vehicleVariables[id][vVehiclePosition][2] + 2.0, 1000);
			SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn: %s adjusted vehicle %d's position.", ReturnName(playerid), vehicleVariables[id][vVehicleScriptID]);

		}
		else if(!strcmp(type, "faction", true))
		{
		    new typeint;

		    if(sscanf(string, "d", typeint))
		 	{
		 	    SendSyntaxMessage(playerid, "/editcar [id] [faction] [id]");
			 	return true;
			}

			vehicleVariables[id][vVehicleFaction] = typeint;

			Vehicle_Save(id);

			SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn: %s adjusted vehicle %d's faction to: %d", ReturnName(playerid), vehicleVariables[id][vVehicleScriptID], typeint);
		}
		else if(!strcmp(type, "color1", true))
		{
		    new color1;

		    if(sscanf(string, "d", color1))
				return SendSyntaxMessage(playerid, "/editcar [id] [color1] [color]");

			if(color1 < 0 || color1 > 255)
			    return SendClientMessage(playerid, COLOR_GRAD1, "   Color must not be lower than 0 or than 255");

			vehicleVariables[id][vVehicleColour][0] = color1;

			DestroyVehicle(vehicleVariables[id][vVehicleScriptID]);
			Iter_Remove(sv_vehicles, vehicleVariables[id][vVehicleScriptID]);

			vehicleVariables[id][vVehicleScriptID] = CreateVehicle(vehicleVariables[id][vVehicleModelID], vehicleVariables[id][vVehiclePosition][0], vehicleVariables[id][vVehiclePosition][1], vehicleVariables[id][vVehiclePosition][2], vehicleVariables[id][vVehicleRotation], vehicleVariables[id][vVehicleColour][0], vehicleVariables[id][vVehicleColour][1], 60000, vehicleVariables[id][vVehicleSiren]);

		  	Iter_Add(sv_vehicles, vehicleVariables[id][vVehicleScriptID]);

			Vehicle_Save(id);
			SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn: %s adjusted vehicle %d's 1st color to: %d", ReturnName(playerid), vehicleVariables[id][vVehicleScriptID], color1);
		}
		else if(!strcmp(type, "color2", true))
		{
		    new color2;

		    if(sscanf(string, "d", color2))
				return SendSyntaxMessage(playerid, "/editcar [id] [color2] [color]");

			if(color2 < 0 || color2 > 255)
			    return SendClientMessage(playerid, COLOR_GRAD1, "   Color must not be lower than 0 or than 255");

			vehicleVariables[id][vVehicleColour][1] = color2;

			DestroyVehicle(vehicleVariables[id][vVehicleScriptID]);
			Iter_Remove(sv_vehicles, vehicleVariables[id][vVehicleScriptID]);

			vehicleVariables[id][vVehicleScriptID] = CreateVehicle(vehicleVariables[id][vVehicleModelID], vehicleVariables[id][vVehiclePosition][0], vehicleVariables[id][vVehiclePosition][1], vehicleVariables[id][vVehiclePosition][2], vehicleVariables[id][vVehicleRotation], vehicleVariables[id][vVehicleColour][0], vehicleVariables[id][vVehicleColour][1], 60000, vehicleVariables[id][vVehicleSiren]);

		  	Iter_Add(sv_vehicles, vehicleVariables[id][vVehicleScriptID]);

			Vehicle_Save(id);
			SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn: %s adjusted vehicle %d's 2st color to: %d", ReturnName(playerid), vehicleVariables[id][vVehicleScriptID], color2);
		}
		else if(!strcmp(type, "siren", true))
		{
		    new siren;

		    if(sscanf(string, "d", siren))
				return SendSyntaxMessage(playerid, "/editcar [id] [siren] [value]");

			if(siren < 0 || siren > 1)
			    return SendClientMessage(playerid, COLOR_GRAD1, "   Siren must be 0 or 1");

			vehicleVariables[id][vVehicleSiren] = siren;

			Vehicle_Save(id);
			DestroyVehicle(vehicleVariables[id][vVehicleScriptID]);
			Iter_Remove(sv_vehicles, vehicleVariables[id][vVehicleScriptID]);

			vehicleVariables[id][vVehicleScriptID] = CreateVehicle(vehicleVariables[id][vVehicleModelID], vehicleVariables[id][vVehiclePosition][0], vehicleVariables[id][vVehiclePosition][1], vehicleVariables[id][vVehiclePosition][2], vehicleVariables[id][vVehicleRotation], vehicleVariables[id][vVehicleColour][0], vehicleVariables[id][vVehicleColour][1], 60000, vehicleVariables[id][vVehicleSiren]);

		  	Iter_Add(sv_vehicles, vehicleVariables[id][vVehicleScriptID]);

			SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn: %s adjusted vehicle %d's siren to: %d", ReturnName(playerid), vehicleVariables[id][vVehicleScriptID], siren);
		}
		else if(!strcmp(type, "plate", true))
		{
		    new newPlate[24];

		    if(sscanf(string, "s[24]", newPlate))
				return SendSyntaxMessage(playerid, "/editcar [id] [plate] [text]");

			if(strlen(newPlate) < 3 || strlen(newPlate) > 9)
			    return SendClientMessage(playerid, COLOR_GRAD1, "   Text length must be higher than 3 and lower than 10");

			format(vehicleVariables[id][vVehiclePlate], 24, "%s", newPlate);
			SetVehicleNumberPlate(vehicleVariables[id][vVehicleScriptID], vehicleVariables[id][vVehiclePlate]);

			SetVehicleToRespawn(vehicleVariables[id][vVehicleScriptID]);

			Vehicle_Save(id);
			SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn: %s adjusted vehicle %d's plate to: %s", ReturnName(playerid), vehicleVariables[id][vVehicleScriptID], newPlate);
		}
		else
		{
		 	SendSyntaxMessage(playerid, "/editveh [id] [name]");
		    SendClientMessage(playerid, COLOR_GREY, "Available names: location, faction, color1, color2, siren, plate");
		}
	}
	else
	{
	    SendErrorMessage(playerid, "Invalid vehicle ID specified.");
	}
	return true;
}

CMD:aunlockcar(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 1)
		return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	new id = -1, str[128], vehicleid;

	if((IsPlayerInAnyVehicle(playerid) ? ((vehicleid = GetPlayerVehicleID(playerid)) != 0) : ((vehicleid = Car_Nearest(playerid)) != -1)))
	{
		new
			engine,
			lights,
			alarm,
			doors,
			bonnet,
			boot,
			objective;

		if((id = Car_GetID(vehicleid)) != -1) // player vehicle
		{
			GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

			if(!CarData[id][carLocked])
			{
				CarData[id][carLocked] = true;

				format(str, sizeof(str), "~r~%s Locked", ReturnVehicleName(vehicleid));
				GameTextForPlayer(playerid, str, 1000, 4);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
				SetVehicleParamsEx(vehicleid, engine, lights, alarm, 1, bonnet, boot, objective);
			}
			else
			{
				CarData[id][carLocked] = false;

				format(str, sizeof(str), "~g~%s Unlocked", ReturnVehicleName(vehicleid));
				GameTextForPlayer(playerid, str, 1000, 4);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
				SetVehicleParamsEx(vehicleid, engine, lights, 0, 0, bonnet, boot, objective);
			}
			return true;
		}
		else if(Vehicle_GetID(vehicleid) != -1 || IsVehicleRental(vehicleid)) // server/rental vehicles
		{
			GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

			if(doors != 1)
			{
				format(str, sizeof(str), "~r~%s Locked", ReturnVehicleName(vehicleid));
				GameTextForPlayer(playerid, str, 1000, 4);
				SetVehicleParamsEx(vehicleid, engine, lights, alarm, 1, bonnet, boot, objective);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			else
			{
				format(str, sizeof(str), "~g~%s Unlocked", ReturnVehicleName(vehicleid));
				GameTextForPlayer(playerid, str, 1000, 4);
				SetVehicleParamsEx(vehicleid, engine, lights, alarm, 0, bonnet, boot, objective);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
		    }
		    return true;
		}
	}

	SendClientMessage(playerid, COLOR_LIGHTRED, "There is nothing around you that you can lock.");
	return true;
}

CMD:find(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 1)
    	return SendUnauthMessage(playerid, "You're not authorized to use this command.");

    new skin, weapon, vehicle, masked, Float:range_of_you;

    if(sscanf(params, "ddddf", skin, weapon, vehicle, masked, range_of_you))
        return SendSyntaxMessage(playerid, "/find [skin] [weaponid] [vehiclemodel] [ismasked] [range-of-you]");

	if(range_of_you < 1)
		return SendErrorMessage(playerid, "Range must be greater than 1.");

	if(masked < 0 || masked > 1)
		return SendErrorMessage(playerid, "Masked must be either 1 or 0.");

    foreach (new i : Player)
    {
        if(PlayerData[i][pID] == -1 || !Spawned{i}) continue;

        if(skin != -1)
        {
            if(GetPlayerSkin(i) != skin)
			{
				continue;
			}
        }

        if(weapon != -1)
        {
            if(!PlayerHasWeapon(i, weapon))
            {
                continue;
            }
        }

        if(vehicle != -1)
        {
            if(!IsPlayerInAnyVehicle(i))
            {
                continue;
            }

            if(GetVehicleModel(GetPlayerVehicleID(i)) != vehicle)
            {
                continue;
            }
        }

        if(masked)
        {
            if(!IsMasked{i})
            {
				continue;
            }
        }
		else
		{
            if(IsMasked{i})
            {
				continue;
            }
		}

		SendClientMessageEx(playerid, COLOR_GREY, "Found %s (%d).", ReturnName(i), i);
    }
	return true;
}

CMD:findcars(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 1)
    	return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	new model, occupied, Float:range_of_you;

	if(sscanf(params, "ddf", model, occupied, range_of_you))
	    return SendSyntaxMessage(playerid, "/findcars [model] [occupied] [range-of-you]");

	if(range_of_you < 1)
		return SendErrorMessage(playerid, "Range must be greater than 1.");

	if(occupied < 0 || occupied > 1)
		return SendErrorMessage(playerid, "Occupied must be either 1 or 0.");

	new Float:vehicle_pos[3], Float:player_pos[3], Float:Distance, vehicle_model, count, occupied_by = INVALID_PLAYER_ID;

	GetPlayerPos(playerid, player_pos[0], player_pos[1], player_pos[2]);

    foreach (new i : sv_vehicles)
    {
		vehicle_model = GetVehicleModel(i);

		if(vehicle_model != model) continue;

        occupied_by = IsVehicleOccupied(i);

        if(occupied)
        {
			if(occupied_by == INVALID_PLAYER_ID)
			{
				continue;
			}
		}
		else
		{
            if(occupied_by != INVALID_PLAYER_ID)
			{
				continue;
			}
		}

        GetVehiclePos(i, vehicle_pos[0], vehicle_pos[1], vehicle_pos[2]);

        Distance = GetDistance(player_pos[0], player_pos[1], player_pos[2], vehicle_pos[0], vehicle_pos[1], vehicle_pos[2]);

        if(Distance <= range_of_you)
        {
        	if(occupied)
				SendClientMessageEx(playerid, COLOR_GREY, "Found a %s (ID: %d) within %.0f meters of range (Occupied by %s).", ReturnName(occupied_by), ReturnVehicleModelName(vehicle_model), i, Distance);
        	else
				SendClientMessageEx(playerid, COLOR_GREY, "Found a %s (ID: %d) within %.0f meters of range (Unoccupied).", ReturnVehicleModelName(vehicle_model), i, Distance);

        	count++;
		}
    }

    if(!count) SendClientMessage(playerid, COLOR_GREY, "Nothing found.");

	return true;
}

CMD:vehname(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 2)
		return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new rcount;

	if(isnull(params))
		return SendClientMessage(playerid, COLOR_GREY, "No keyword specified.");

	if(strlen(params) < 3)
		return SendClientMessage(playerid, COLOR_GREY, "Search keyword is too short.");

	for(new v; v < sizeof(g_arrVehicleNames); ++v)
	{
		if(strfind(g_arrVehicleNames[v], params, true) != -1)
		{
			if(rcount == 0)
				format(sgstr, sizeof(sgstr), "%s (ID %d)", g_arrVehicleNames[v], v+400);
			else
				format(sgstr, sizeof(sgstr), "%s | %s (ID %d)", sgstr, g_arrVehicleNames[v], v+400);

			rcount++;
		}
	}

	if(rcount == 0)
	{
		SendClientMessage(playerid, COLOR_GREY, "No results found.");
	}
	else
	{
		if(strlen(sgstr) >= 128)
			SendClientMessage(playerid, COLOR_GREY, "Too many results found.");
		else
			SendClientMessage(playerid, COLOR_WHITE, sgstr);
	}
	return true;
}

CMD:refunddrug(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 2)
		return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	new userid;

	if(sscanf(params, "u", userid))
	    return SendSyntaxMessage(playerid, "/refunddrug [playerid/PartOfName]");

	if(!IsPlayerConnected(userid))
		return SendErrorMessage(playerid, "The player you specified isn't connected.");

	if(!SQL_IsLogged(playerid))
		return SendErrorMessage(playerid, "The player you specified isn't logged in.");

	SetPVarInt(playerid, "d_RefundPlayer", userid);

	new body[256];

	for(new d = 0; d < 10; ++d)
	{
	    strcat(body, d_DATA[d][dName]);
	    strcat(body, "\n");
	}

	Dialog_Show(playerid, Drug_RefundType, DIALOG_STYLE_LIST, "Drug Refund, Select a Drug:", body, "Next", "Cancel");
	return true;
}

//weapon packages

CMD:setwpackage(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 2)
		return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	new userid, weaponid, ammo, slot;

	if(sscanf(params, "uddI(-1)", userid, weaponid, ammo, slot))
	    return SendSyntaxMessage(playerid, "/setwpackage [playerid/PartOfName] [weaponid] [ammo] [slot (Optional)]");

	if(!IsPlayerConnected(userid))
		return SendErrorMessage(playerid, "The player you specified isn't connected.");

	if(!SQL_IsLogged(playerid))
		return SendErrorMessage(playerid, "The player you specified isn't logged in.");

	if(IsInvalidWeapon(weaponid))
	    return SendErrorMessage(playerid, "Invalid weapon id specified.");

	new max_ammo = GetWeaponPackage(g_aWeaponSlots[weaponid]);

	if(ammo < 1 || ammo > max_ammo)
		return SendClientMessageEx(playerid, COLOR_LIGHTRED, "Ammo cannot be lower than 1 or more than %d.", max_ammo);

	if(slot == -1)
	{
	    slot = FindFreePackageSlot(userid);

		if(slot == -1)
		    return SendErrorMessage(playerid, "Player doesn't have any free slots left.");
	}
	else
	{
	    if(slot < 1 || slot > MAX_PLAYER_WEAPON_PACKAGE)
			return SendErrorMessage(playerid, "Invalid slot specified.");

		slot--;

		if(PlayerData[userid][pPackageWP][slot] != 0)
		    return SendErrorMessage(playerid, "That package slot is occupied.");
	}

	PlayerData[userid][pPackageWP][slot] = weaponid;
	PlayerData[userid][pPackageAmmo][slot] = ammo;

	SendClientMessageEx(userid, COLOR_GREEN, "[Package] You've been refunded %s and %d ammo.", GetWeaponPackageName(weaponid), ammo);
	SendClientMessageEx(playerid, COLOR_GREEN, "[Package] You've refunded %s and %d ammo to %s.", GetWeaponPackageName(weaponid), ammo, ReturnName(userid));

	Player_SavePackage(userid);
	return true;
}

CMD:glog(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
	    return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	new dbid;

	if(sscanf(params, "d", dbid))
		return SendSyntaxMessage(playerid, "/glog dbid:graffiti");

	new query[128];
	format(query, sizeof(query), "SELECT `Log`, `Timestamp` FROM `logs_spray` WHERE `SprayID` = '%d' ORDER BY `ID` DESC", dbid);
	mysql_tquery(dbCon, query, "SprayLogsResult", "dd", playerid, dbid);
	return true;
}

FUNX::SprayLogsResult(playerid, graffiti)
{
	if(!cache_num_rows()) return SendErrorMessage(playerid, "No logs found.");

	new log[256], timestamp, header[128];

	format(header, sizeof(header), "Graffiti Logs (%d)", graffiti);

	gstr[0] = EOS;

	for(new i = 0; i < cache_num_rows(); ++i)
	{
	    cache_get_value_name(i, "Log", log, 256);
	    cache_get_value_name_int(i, "Timestamp", timestamp);

		format(gstr, sizeof(gstr), "%s\n{FFFFFF}%s %s", gstr, ConverTimestampToDate(timestamp), log);
	}

	Dialog_Show(playerid, SprayLogs, DIALOG_STYLE_LIST, header, gstr, "OK", "Close");
	return true;
}

CMD:log(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 2)
	    return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	new pName[MAX_PLAYER_NAME], filter[64], userid = INVALID_PLAYER_ID;

	if(sscanf(params, "s[24]S()[64]", pName, filter))
		return SendSyntaxMessage(playerid, "/log dbid:player_dbid OR [PlayerID/partofName] <filter log (optional)>");

	foreach (new i : Player)
	{
		if(IsNumeric(pName))
		{
			if(strval(pName) == i)
			{
			    userid = i;
			    break;
			}
		}
		else
		{
		    if(strcmp(pName, ReturnName(i), true) == 0)
		    {
			    userid = i;
			    break;
		    }
		}
	}

	if(!isnull(filter))
	{
	    if(strlen(filter) < 3)
            return SendErrorMessage(playerid, "Filter must be at least 3 characters long.");
	}

	if(userid == INVALID_PLAYER_ID)
	{
	    new checkQuery[300], rows = 0, start = strfind(pName, "player_", false);

	    if(start != -1)
	    {
	        new dbid, str[MAX_PLAYER_NAME];

	        strmid(str, pName, start + 7, strlen(pName));

	        if(!IsNumeric(str)) return SendErrorMessage(playerid, "No player found.");

	        dbid = strval(str);

			mysql_format(dbCon, checkQuery, sizeof(checkQuery), "SELECT `char_name` FROM `characters` WHERE `ID` = '%d' LIMIT 1", dbid);
			new Cache:cache = mysql_query(dbCon, checkQuery);

			rows = cache_num_rows();

			if(rows)
			{
			    PlayerLogs[playerid][searchingPlayer] = INVALID_PLAYER_ID;
			    PlayerLogs[playerid][searchingSQLID] = dbid;
			    cache_get_value_name(0, "char_name", PlayerLogs[playerid][searchingName], MAX_PLAYER_NAME);
				format(PlayerLogs[playerid][searchingFilter], 64, filter);
				PlayerLogs[playerid][searchingOffset] = 0;

			    ShowPlayerLogs(playerid);
			}
			else SendErrorMessage(playerid, "No player found.");

			cache_delete(cache);
			return true;
	    }
	    else
	    {
			mysql_format(dbCon, checkQuery, sizeof(checkQuery), "SELECT `ID` FROM `characters` WHERE `char_name` = '%e' LIMIT 1", pName);
			new Cache:cache = mysql_query(dbCon, checkQuery);

			rows = cache_num_rows();

			if(rows)
			{
			    PlayerLogs[playerid][searchingPlayer] = INVALID_PLAYER_ID;
			    cache_get_value_name_int(0, "ID", PlayerLogs[playerid][searchingSQLID]);
				format(PlayerLogs[playerid][searchingName], MAX_PLAYER_NAME, pName);
				format(PlayerLogs[playerid][searchingFilter], 64, filter);
				PlayerLogs[playerid][searchingOffset] = 0;

			    ShowPlayerLogs(playerid);
			}
			else SendErrorMessage(playerid, "No player found.");

			cache_delete(cache);
			return true;
		}
	}
	else
	{
	    PlayerLogs[playerid][searchingPlayer] = userid;
	    PlayerLogs[playerid][searchingSQLID] = PlayerData[userid][pID];
	    format(PlayerLogs[playerid][searchingName], MAX_PLAYER_NAME, ReturnName(userid));
	    format(PlayerLogs[playerid][searchingFilter], 64, filter);
	    PlayerLogs[playerid][searchingOffset] = 0;

		ShowPlayerLogs(playerid);
	}

	return true;
}

stock ShowPlayerLogs(playerid)
{
	new
		query[256]
	;

	/*if(strlen(PlayerLogs[playerid][searchingFilter]) >= 3)
	{
	    new str[5];

	    format(str, 5, "%.1s", query);

	    if(!strcmp(str, "s", true))
	    {
	        format(query, sizeof(query), "%s", query[1]);
	    }

	    if(strfind(query, "s", true) == 0)
	    {
		    PlayerLogs[playerid][searchingPlayer] = INVALID_PLAYER_ID;
		    PlayerLogs[playerid][searchingSQLID] = -1;
		    PlayerLogs[playerid][searchingName][0] = EOS;
		    PlayerLogs[playerid][searchingFilter][0] = EOS;
		    PlayerLogs[playerid][searchingOffset] = 0;

			return SendErrorMessage(playerid, "No logs found.");
	    }

		mysql_format(dbCon, query, sizeof(query), "SELECT `Log`, `Timestamp` FROM `logs_all` WHERE `User` = '%d' AND `Log` LIKE '%e%%' OR `User` = '%d' AND `Log` LIKE '%%%e%%' ORDER BY `ID` DESC LIMIT 22 OFFSET %i", PlayerLogs[playerid][searchingSQLID], PlayerLogs[playerid][searchingFilter], PlayerLogs[playerid][searchingSQLID], PlayerLogs[playerid][searchingFilter], PlayerLogs[playerid][searchingOffset] * 21);
		mysql_tquery(dbCon, query, "SearchLogsResult", "d", playerid);
	}*/

	if(strlen(PlayerLogs[playerid][searchingFilter]) >= 3)
	{
		mysql_format(dbCon, query, sizeof(query), "SELECT `Log`, `Timestamp` FROM `logs_all` WHERE `User` = '%d' AND `Log` LIKE '%e%%' ORDER BY `ID` DESC LIMIT 22 OFFSET %i", PlayerLogs[playerid][searchingSQLID], PlayerLogs[playerid][searchingFilter], PlayerLogs[playerid][searchingOffset] * 21);
		mysql_tquery(dbCon, query, "SearchLogsResult", "d", playerid);
	}
	else
	{
		format(query, sizeof(query), "SELECT `Log`, `Timestamp` FROM `logs_all` WHERE `User` = '%d' ORDER BY `ID` DESC LIMIT 22 OFFSET %i", PlayerLogs[playerid][searchingSQLID], PlayerLogs[playerid][searchingOffset] * 21);
		mysql_tquery(dbCon, query, "SearchLogsResult", "d", playerid);
	}

	return true;
}

FUNX::SearchLogsResult(playerid)
{
	if(!cache_num_rows())
	{
	    PlayerLogs[playerid][searchingPlayer] = INVALID_PLAYER_ID;
	    PlayerLogs[playerid][searchingSQLID] = -1;
	    PlayerLogs[playerid][searchingName][0] = EOS;
	    PlayerLogs[playerid][searchingFilter][0] = EOS;
	    PlayerLogs[playerid][searchingOffset] = 0;

		return SendErrorMessage(playerid, "No logs found.");
	}

	new body[2000], rows = cache_num_rows(), log[256], timestamp, header[128], count;

	if(PlayerLogs[playerid][searchingPlayer] != INVALID_PLAYER_ID)
	    format(header, sizeof(header), "%s (%d)", PlayerLogs[playerid][searchingName], PlayerLogs[playerid][searchingPlayer]);
	else
	    format(header, sizeof(header), "%s", PlayerLogs[playerid][searchingName]);

	for(new i = 0; i < rows; ++i)
	{
	    if(count == 21) break;

	    cache_get_value_name(i, "Log", log, 256);
	    cache_get_value_name_int(i, "Timestamp", timestamp);

	    if(!strcmp(log, "Logged In", true) || strfind(log, "Left the server", true) != -1)
			format(body, sizeof(body), "%s\n{FF6347}%s %s", body, ConverTimestampToDate(timestamp), log);
	    else
			format(body, sizeof(body), "%s\n{FFFFFF}%s %s", body, ConverTimestampToDate(timestamp), log);

		count++;
	}

	if(PlayerLogs[playerid][searchingOffset] > 0) strcat(body, "\n{FFFF00}Back Page");
	if(rows > 21) strcat(body, "\n{FFFF00}Next Page");

	new checkQuery[128];

	if(strlen(PlayerLogs[playerid][searchingFilter]) >= 3)
	    mysql_format(dbCon, checkQuery, sizeof(checkQuery), "SELECT COUNT(ID) AS `Results` FROM `logs_all` WHERE `User` = '%d' AND `Log` LIKE '%e%%'", PlayerLogs[playerid][searchingSQLID], PlayerLogs[playerid][searchingFilter]);
	else
		mysql_format(dbCon, checkQuery, sizeof(checkQuery), "SELECT COUNT(ID) AS `Results` FROM `logs_all` WHERE `User` = '%d'", PlayerLogs[playerid][searchingSQLID]);

	new Cache:cache = mysql_query(dbCon, checkQuery);

 	cache_get_value_name_int(0, "Results", rows);

	cache_delete(cache);

	format(header, sizeof(header), "%s [%d/%d]", header, PlayerLogs[playerid][searchingOffset], floatround(rows / 21, floatround_ceil));

	Dialog_Show(playerid, LogsResult, DIALOG_STYLE_LIST, header, body, "OK", "Close");
	return true;
}

stock ConverTimestampToDate(stamp)
{
	new
	    str[256],
		date[6]
	;

	TimestampToDate(stamp, date[0], date[1], date[2], date[3], date[4], date[5], 1);

	format(str, sizeof(str), "%02d-%02d-%d: %02d:%02d:%02d", date[2], date[1], date[0], date[3], date[4], date[5]);

    return str;
}

Dialog:LogsResult(playerid, response, listitem, inputtext[])
{
	if(!response)
	{
	    PlayerLogs[playerid][searchingPlayer] = INVALID_PLAYER_ID;
	    PlayerLogs[playerid][searchingSQLID] = -1;
	    PlayerLogs[playerid][searchingName][0] = EOS;
	    PlayerLogs[playerid][searchingFilter][0] = EOS;
	    PlayerLogs[playerid][searchingOffset] = 0;
		return true;
	}

	if(!strcmp("Next Page", inputtext, true))
	{
	    PlayerLogs[playerid][searchingOffset] += 1;
	}
	else if(!strcmp("Back Page", inputtext, true))
	{
	    PlayerLogs[playerid][searchingOffset] -= 1;
	}

	ShowPlayerLogs(playerid);
	return true;
}

CMD:aconfig(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
	    return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	Dialog_Show(playerid, AdminConfig, DIALOG_STYLE_TABLIST_HEADERS, "Administator Configuration Panel",
	"Name\tStatus\tInfo\n\
	Admin Duty Message\t{00bf00}ON\tToggles admin duty notification.\n\
	Tester Duty Message\t{00bf00}ON\tToggles tester duty notification.\n\
	Admin Chat\t{00bf00}ON\tToggles the admin chat.\n\
	Tester Chat\t{00bf00}ON\tToggles the testers chat.\n\
	Pay Logs\t{00bf00}ON\tToggles nottifications that admins get when a payment above 50K is made between players.\n\
	Kill - Death Logs\t{00bf00}ON\tIt sends a message for each kill death or execution on the server.\n\
	Warnings OnPlayerLogin\t\t{00bf00}ON\tSends a warning everytime a player with a flag on them logs on to the server.\n\
	Bunnyhop Log\t{00bf00}ON\tSends an admin warning for players that bunnyhop on the server (Recomanded off due to spam).\n\
	Hacking Logs\t{00bf00}ON\tSends out warning for any type of cheat deteced on the server.",
	"Ok", "Close");
	return true;
}

CMD:adminsys(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
	    return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	SendClientMessage(playerid, COLOR_GRAD1, "/adminsys is disabled.");
	return true;
}

CMD:checkall(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
	    return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	SendClientMessage(playerid, COLOR_GRAD1, "/checkall is disabled.");
	return true;
}

CMD:killlog(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
	    return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	SendClientMessage(playerid, COLOR_GRAD1, "/killlog is disabled.");
	return true;
}

CMD:blacklist(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
	    return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	SendClientMessage(playerid, COLOR_GRAD1, "/blacklist is disabled.");
	return true;
}

CMD:mark(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
	    return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	new marker;

	if(sscanf(params, "d", marker))
	    return SendSyntaxMessage(playerid, "/mark [1-4]");

	if(marker < 1 || marker > 4)
	    return SendErrorMessage(playerid, "Marker ID is 1-4 only.");

	marker--;

	GetPlayerPos(playerid, Markers[playerid][marker][markerPos][0], Markers[playerid][marker][markerPos][1], Markers[playerid][marker][markerPos][2]);

	SendClientMessageEx(playerid, COLOR_GREY, "You have successfully marked your position (ID %d).", marker + 1);
	return true;
}

CMD:gotomark(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
	    return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	new marker;

	if(sscanf(params, "d", marker))
	    return SendSyntaxMessage(playerid, "/gotomark [1-4]");

	if(marker < 1 || marker > 4)
	    return SendErrorMessage(playerid, "Marker ID is 1-4 only.");

	marker--;

	if(!Markers[playerid][marker][markerPos][0])
	    return SendErrorMessage(playerid, "You haven't marked your position for id %d.", marker + 1);

	SetPlayerDynamicPos(playerid, Markers[playerid][marker][markerPos][0], Markers[playerid][marker][markerPos][1], Markers[playerid][marker][markerPos][2]);

	SendClientMessageEx(playerid, COLOR_GREY, "You have been teleported to mark (%d).", marker + 1);
	return true;
}

CMD:up(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
		return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new Float:slx, Float:sly, Float:slz;
	GetPlayerPos(playerid, slx, sly, slz);
	SetPlayerDynamicPos(playerid, slx, sly, slz + 5);
	return true;
}

CMD:down(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
		return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new Float:slx, Float:sly, Float:slz;
	GetPlayerPos(playerid, slx, sly, slz);
	SetPlayerDynamicPos(playerid, slx, sly, slz - 5);
	return true;
}

CMD:left(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
		return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new Float:slx, Float:sly, Float:slz;
	GetPlayerPos(playerid, slx, sly, slz);
	SetPlayerDynamicPos(playerid, slx, sly - 5, slz);
	return true;
}

CMD:right(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
		return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new Float:slx, Float:sly, Float:slz;
	GetPlayerPos(playerid, slx, sly, slz);
	SetPlayerDynamicPos(playerid, slx, sly + 5, slz);
	return true;
}

YCMD:ah(playerid, params[], help) = ahelp;

CMD:ahelp(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
	    return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	if(PlayerData[playerid][pAdmin] >= 1) // Junior Admin
	{
		SendClientMessage(playerid, COLOR_GREEN, "[Level 1]: {B4B5B7}/aconfing /intpoints /p2poi /admin /flipcar");
		SendClientMessage(playerid, COLOR_GREEN, "[Level 1]: {B4B5B7}/adminduty /ahelp /whereami /neargraffiti /glog");
		SendClientMessage(playerid, COLOR_GREEN, "[Level 1]: {B4B5B7}/arecord /adminsys /ar /dr /reports /aooc /ooc /nooc");
		SendClientMessage(playerid, COLOR_GREEN, "[Level 1]: {B4B5B7}/ooc /ajail /kick /ban /unjail /as /stats /checkall");
		SendClientMessage(playerid, COLOR_GREEN, "[Level 1]: {B4B5B7}/clearguns /awp /awc /watchoff /afk /slap /slapcar /testcar");
		SendClientMessage(playerid, COLOR_GREEN, "[Level 1]: {B4B5B7}/aunlockcar /house /biz /freeze /unfreeze /mute /goto");
		SendClientMessage(playerid, COLOR_GREEN, "[Level 1]: {B4B5B7}/gotocar /getcar /gethere /gethealth /setarmour /setint");
		SendClientMessage(playerid, COLOR_GREEN, "[Level 1]: {B4B5B7}/blacklist /mark[1-4] /gotols /gotosf /gotolv /gotospawn");
		SendClientMessage(playerid, COLOR_GREEN, "[Level 1]: {B4B5B7}/gotobm /gotop /getworld /setworld /getip /up /down");
		SendClientMessage(playerid, COLOR_GREEN, "[Level 1]: {B4B5B7}/left /right /despawncar /despawncars /asetparamcar /ninjamove");
		SendClientMessage(playerid, COLOR_GREEN, "[Level 1]: {B4B5B7}/prison /impound /apark /revive /find /frisk /handcuff /unhandcuff");
		SendClientMessage(playerid, COLOR_GREEN, "[Level 1]: {B4B5B7}/checkgraffiti /showmain /desynced /propinfo /jail /excusefine");
		SendClientMessage(playerid, COLOR_GREEN, "[Level 1]: {B4B5B7}/p2p /p2v /p2iw /p2fs /gotofs /ismasked /afkkick /sethealth");
		SendClientMessage(playerid, COLOR_GREEN, "[Level 1]: {B4B5B7}/ajailed /vehdrugs /vehpackage /towcars /backup /killlog");
		SendClientMessage(playerid, COLOR_GRAD1, "");
	}
	if(PlayerData[playerid][pAdmin] >= 2) // Game Admin
	{
		SendClientMessage(playerid, COLOR_GREEN, "[Level 2]: {B4B5B7}/quake /sf /ppiv /entercarseat /explosion /changename");
		SendClientMessage(playerid, COLOR_GREEN, "[Level 2]: {B4B5B7}/watchpm /weather /makeimpounder /endround /p2m /p2pos");
		SendClientMessage(playerid, COLOR_GREEN, "[Level 2]: {B4B5B7}/gotocmdspot /watchradio /log");
		SendClientMessage(playerid, COLOR_GRAD1, "");
	}
	if(PlayerData[playerid][pAdmin] >= 3)
	{
	    SendClientMessage(playerid, COLOR_GREEN, "[Level 3]: {B4B5B7}/setstat /fillallcars /sslap /smack /gotojet /gotoin /gotostad /abizinfo");
		SendClientMessage(playerid, COLOR_GREEN, "[Level 3]: {B4B5B7}/givegun /givemoney /takemoney /enabletp /disabletp /kickfromjob /vehiclerequests");
		SendClientMessage(playerid, COLOR_GRAD1, "");
	}
	if(PlayerData[playerid][pAdmin] >= 4) // Lead Admin
	{
	    SendClientMessage(playerid, COLOR_GREEN, "[Level 4]: {B4B5B7}/leadadmin /playsound /healcar /createfaction /removefaction");
		SendClientMessage(playerid, COLOR_GREEN, "[Level 4]: {B4B5B7}/createprop /setprop /createapt /setapt /removeapt /createbiz /setbiz /asellbiz /agivebiz");
		SendClientMessage(playerid, COLOR_GREEN, "[Level 4]: {B4B5B7}/createbm /setbm /createcar /veh /setcar /removecar /pmears /factionears");
		SendClientMessage(playerid, COLOR_GREEN, "[Level 4]: {B4B5B7}/clearreports /setwpackage /throwoff /debugsymbol /givepack /logcommands");
		SendClientMessage(playerid, COLOR_GRAD1, "");
	}
	if(PlayerData[playerid][pAdmin] >= 1337) // Management
	{
	    SendClientMessage(playerid, COLOR_GREEN, "[Level 1337]: {B4B5B7}/signalcmds /serverstats /mysqlstats /debughits /ecmd");
	    SendClientMessage(playerid, COLOR_GREEN, "[Level 1337]: {B4B5B7}/ecmd /createatm /deleteatm /makestreet /maketele /xyz /icv");
  		SendClientMessage(playerid, COLOR_GREEN, "[Level 1337]: {B4B5B7}/housecmds /businesscmds /movedoorcmds /updatemotd /hints");
		SendClientMessage(playerid, COLOR_GREEN, "[Level 1337]: {B4B5B7}/createaccount /createcharacter /checkaccount");
  		SendClientMessage(playerid, COLOR_GRAD1, "");
	}
	return true;
}

CMD:signalcmds(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1337)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	SendClientMessage(playerid, COLOR_GRAD3, "[Level 1337]: /createsignal, /editsignal, /destroysignal");
	return true;
}

CMD:factioncmds(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	SendClientMessage(playerid, COLOR_GRAD3, "[Level 4]: /viewfactions /createfaction, /setfaction, /destroyfaction");
	return true;
}

CMD:vehcmds(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	SendClientMessage(playerid, COLOR_GRAD3, "[Level 4]: /saveveh /deleteveh /editveh");
	return true;
}

CMD:gatecmds(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1337)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	SendClientMessage(playerid, COLOR_GRAD3, "[Level 1337]: {C3C3C3}/makegate /dupgate /removegate /editgate /whatgate /showgates");
	return true;
}

CMD:movedoorcmds(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1337)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	SendClientMessage(playerid, COLOR_GRAD3, "[Level 1337]: {C3C3C3}/makemovedoor /dupmovedoor /removemovedoor /editmovedoor /whatmovedoor /showmovedoors");
	return true;
}

CMD:housecmds(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1337)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	SendClientMessage(playerid, COLOR_GRAD3, "[Level 1337]: /createprop /removeprop /setprop /houseenter /houseexit /asellhouse /gotohouse /serverhouses");
	return true;
}

CMD:businesscmds(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1337)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	SendClientMessage(playerid, COLOR_GRAD3, "[Level 1337]: /makebusiness /removebusiness /editbusiness /businessenter /gotobusiness /serverbusinesses /asellbusiness");
	SendClientMessage(playerid, COLOR_GRAD3, "[Level 1337]: /businessint /businessexit /biztypes /whatbusiness /showbusinesses /businessex1 /businessex2 /businessex3");
	return true;
}

CMD:telecmds(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 3)
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	SendClientMessage(playerid, COLOR_GRAD3, "[Level 3]: /teles /maketele /removetele /serverteles");
	return true;
}

CMD:intpoints(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
	    return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	gstr[0] = EOS;

	format(gstr, sizeof(gstr), "{FFFFFF}%s", OrTeleports[0]);

	for(new OrT = 1; OrT != sizeof(OrTeleports); ++OrT)
	{
		format(gstr, sizeof(gstr), "%s\n%s", gstr, OrTeleports[OrT]);
	}

	Dialog_Show(playerid, Teles, DIALOG_STYLE_LIST, "Select a teleport location", gstr, "Teleport", "Cancel");
	return true;
}

CMD:streamer(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1337)
		return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	SendClientMessageEx(playerid, COLOR_CYAN, "Visible objects: %d", Streamer_GetVisibleItems(STREAMER_TYPE_OBJECT));
	return true;
}

/*CMD:ecmd(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1337)
		return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	new userid, command[64];

	if(sscanf(params, "us[64]", userid, command))
		return SendSyntaxMessage(playerid, "/(e)mulatecommand [playerid/PartOfName] [command]");

	if(!IsPlayerConnected(userid))
		return SendErrorMessage(playerid, "The player you specified isn't connected.");

	if(!SQL_IsLogged(userid))
		return SendErrorMessage(playerid, "The player you specified isn't logged in.");

	if(!DoesCommandExist(command))
	    return SendErrorMessage(playerid, "Command doesn't exist.");

    EmulateCommand(userid, command);

    SendClientMessageEx(playerid, COLOR_ORANGE, "\"%s\" called for player %s (%d).", command, ReturnName(userid), userid);
	return true;
}*/

CMD:as(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1)
		return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	new
	    userid
	;

	if(sscanf(params, "u", userid))
		return SendSyntaxMessage(playerid, "/as [playerid/PartOfName]");

	if(!IsPlayerConnected(userid))
		return SendErrorMessage(playerid, "The player you specified isn't connected.");

	if(!SQL_IsLogged(userid))
		return SendErrorMessage(playerid, "The player you specified isn't logged in.");

	SendClientMessage(playerid, COLOR_GREEN, "______________________________________________");
	SendClientMessageEx(playerid, COLOR_LIGHTRED, "Players name: %s", ReturnName(userid));

	SendClientMessageEx(playerid, COLOR_GRAD2, "Money out: [$%d] - Should have(Userfile): [$%d] - Time left in jail[%d], World: [%d]", GetPlayerMoney(userid), PlayerData[userid][pCash], PlayerData[userid][pSentenceTime], GetPlayerVirtualWorld(userid));

	new weapons[13][2], slot, weaponid, ammo;

	for(new i = 0; i <= 12; ++i)
	{
	    GetPlayerWeaponData(userid, i, weapons[i][0], weapons[i][1]);

	    if(weapons[i][1] > 0)
	    {
	        weaponid = weapons[i][0];
	        ammo = weapons[i][1];

			slot = g_aWeaponSlots[weapons[i][0]];

			if(PlayerData[userid][pGuns][slot] == weaponid)
			{
			    if(PlayerData[userid][pAmmo][slot] != ammo)
					SendClientMessageEx(playerid, COLOR_GRAD2, "Weapon: [%s] - Ammo: [%d](Should have: %d)", ReturnWeaponName(weaponid), ammo, PlayerData[userid][pAmmo][slot]);
			    else
					SendClientMessageEx(playerid, COLOR_GRAD2, "Weapon: [%s] - Ammo: [%d]", ReturnWeaponName(weaponid), ammo);
			}
			else SendClientMessageEx(playerid, COLOR_GRAD2, "Weapon: [%s](Should have: Empty) - Ammo: [%d](Should have: 0)", ReturnWeaponName(weaponid), ammo);
	    }
	}

	SendClientMessage(playerid, COLOR_GREEN, "______________________________________________");
	return true;
}

//atm system
CMD:createatm(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] != 4)
		return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	new ATM = FindFreeATM();

	if(ATM == -1)
		return SendErrorMessage(playerid, "MAX_ATM_LIMIT reached.");

	new Float:PlayerPos[3];
	GetPlayerPos(playerid, PlayerPos[0], PlayerPos[1], PlayerPos[2]);

	ATMS[ATM][aPos][0] = PlayerPos[0];
	ATMS[ATM][aPos][1] = PlayerPos[1];
	ATMS[ATM][aPos][2] = PlayerPos[2];

	format(gquery,sizeof(gquery),"INSERT INTO `atms` (posX, posY, posZ,  CreatedBy) VALUES ('%f', '%f', '%f', '%s')", PlayerPos[0], PlayerPos[1], PlayerPos[2], PlayerName(playerid));
	mysql_tquery(dbCon, gquery, "OnCreateATM", "ddfff", playerid, ATM, PlayerPos[0], PlayerPos[1], PlayerPos[2]);
	return true;
}

CMD:gotoatm(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] != 4)
		return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	new ATM;

	if(sscanf(params, "d", ATM))
		return SendSyntaxMessage(playerid, "/gotoatm [ID]");

	if(ATMS[ATM][aID] == -1)
		return SendErrorMessage(playerid, "Invalid ATM ID.");

	SetPlayerDynamicPos(playerid, ATMS[ATM][aPos][0] + 2, ATMS[ATM][aPos][1], ATMS[ATM][aPos][2]);

	SendNoticeMessage(playerid, "You have teleported to ATM [%d].", ATM);
	return true;
}

CMD:deleteatm(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] != 4)
		return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	DeletingATM{playerid} = true;
    SelectObject(playerid);

    SendNoticeMessage(playerid, "Please select a valid ATM Object in order to proceed further.");
	return true;
}

CMD:editatm(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] != 4)
		return SendUnauthMessage(playerid, "You're not authorized to use this command.");

    SelectObject(playerid);
	return true;
}

CMD:netstats(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4)
		return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	new stats[400 + 1];
    GetNetworkStats(stats, sizeof(stats));
    Dialog_Show(playerid, None, DIALOG_STYLE_MSGBOX, "Server Network Stats", stats, "Close", "");
	return true;
}

YCMD:sstats(playerid, params[], help) = serverstats;

CMD:serverstats(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 4)
		return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	new
	    p_ajailed,
		p_incarcerated,
		p_onfoot,
		p_invehicle,
		p_afk,
		players,
		player_cars = Iter_Count(sv_playercar),
		faction_cars = Iter_Count(sv_vehicles),
		server_cars = Iter_Count(sv_servercar),
		businesses = Iter_Count(Business),
		apartments = Iter_Count(Complex),
		houses = Iter_Count(Property)
	;

	foreach (new i : Player)
	{
	    players++;

	    if(PlayerData[i][pJailed] == PUNISHMENT_TYPE_AJAIL) p_ajailed++;

		if(PlayerData[i][pJailed] > PUNISHMENT_TYPE_AJAIL) p_incarcerated++;

	    if(GetPlayerState(i) == PLAYER_STATE_ONFOOT) p_onfoot++;

     	if(GetPlayerState(i) == PLAYER_STATE_DRIVER) p_invehicle++;

     	if(IsAFK{i}) p_afk++;
	}

    new uptime = gettime() - ServerTime;

    SendClientMessage(playerid, COLOR_GREEN, "|___________________________Server Statistics___________________________|");
    SendClientMessageEx(playerid, COLOR_CYAN, "| Players | OnFoot: [%d] InVehicle: [%d] AFK[%d] Admin Jailed[%d] Incarcerated[%d]", p_onfoot, p_invehicle, p_afk, p_ajailed, p_incarcerated);
    SendClientMessageEx(playerid, COLOR_CYAN, "| Vehicles | Player: [%d] Faction: [%d] Server: [%d] Total:[%d]", player_cars, faction_cars, server_cars, player_cars + faction_cars + server_cars);
    SendClientMessageEx(playerid, COLOR_CYAN, "| Property | Houses: [%d] Apartment Complexes: [%d] Businesses [%d]", houses, apartments, businesses);
    SendClientMessageEx(playerid, COLOR_CYAN, "| Misc | Server uptime: [%s] Server tickrate: [%d] Players Online: [%d/%d]", HowLongAgo(uptime), GetServerTickRate(), players, MAX_PLAYERS);
	return true;
}

/*CMD:asd(playerid, params[])
{
	foreach (new i : Command())
	{
		SendClientMessageEx(playerid, -1, "%s", Command_GetName(i));
	}
	return true;
}*/

CMD:tickrate(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 4)
		return SendUnauthMessage(playerid, "You're not authorized to use this command.");
			
	SendClientMessageEx(playerid, COLOR_WHITE, "Current server tickrate is: %d", GetServerTickRate());
	return true;
}

CMD:runquery(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 1337)
		return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	if(isnull(params) || strlen(params) < 3)
	    return SendErrorMessage(playerid, "Query is too short.");

	mysql_format(dbCon, gquery, sizeof(gquery), "%e", params);
	mysql_pquery(dbCon, gquery);

	SendServerMessage(playerid, "Query was successfully executed.");
	return true;
}

CMD:mysqlstats(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 1337)
		return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	gquery[0] = EOS;
	mysql_stat(gquery);

	if(strlen(gquery) > 120)
	{
		SendClientMessageEx(playerid, COLOR_CYAN, "%.120s ...", gquery);
		SendClientMessageEx(playerid, COLOR_CYAN, "... %s", gquery[120]);
	}
	else SendClientMessage(playerid, COLOR_CYAN, gquery);

	SendClientMessageEx(playerid, COLOR_CYAN, "Unpro Queries: %i", mysql_unprocessed_queries());
	return true;
}

CMD:watchpm(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 2)
		return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	new
		userid
	;

    if(sscanf(params, "u", userid))
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "USAGE: /watchpm [playerid/PON]");

	if(!IsPlayerConnected(userid))
		return SendErrorMessage(playerid, "The player you specified isn't connected.");

    if(!ReadingPMs[playerid][userid])
    {
        ReadingPMs[playerid][userid] = 1;

        SendClientMessageEx(playerid, COLOR_LIGHTRED, "You'll now be receiving incoming and outgoing personal messages from %s.", PlayerName(userid));
    }
    else
    {
        ReadingPMs[playerid][userid] = 0;

        SendClientMessageEx(playerid, COLOR_LIGHTRED, "You'll no longer receive incoming and outgoing personal messages from %s.", PlayerName(userid));
    }

	return true;
}
