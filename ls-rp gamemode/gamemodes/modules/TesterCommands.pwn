//tester commands

CMD:testerhelp(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 1 && !IsTester(playerid))
		return SendClientMessage(playerid, COLOR_LIGHTRED, "You are not a tester!");

    SendClientMessage(playerid, COLOR_WHITE, "[Tester - Helpme Requests] /helplist, /rsd(accept), /drs(disregard)");
	SendClientMessage(playerid, COLOR_WHITE, "[Tester - Misc.] /testerduty, /testercolor, /showmain");
	SendClientMessage(playerid, COLOR_WHITE, "[Tester - Spraycans] /givespray, /banspray, /bansprayid, /checksprayban, /unbanspray");
	return true;
}

CMD:helpme(playerid, params[])
{
	if(isnull(params))
		return SendClientMessage(playerid, COLOR_GREY, "USAGE: /helpme [text]");

	if(PlayerData[playerid][pHelpme] >= 1)
		return SendClientMessage(playerid, COLOR_LIGHTRED, "You currently have 1 open requests, please wait until they are concluded before sending in more.");

	SendClientMessage(playerid, COLOR_GREEN, "Request successfully sent to on-duty testers!");

	strcpy(PlayerData[playerid][pHelpmeMessage], params, 128);
	PlayerData[playerid][pHelpme] = 1;
	PlayerData[playerid][pHelpmeSeconds] = 0;

	if(strlen(PlayerData[playerid][pHelpmeMessage]) > 65)
	{
		SendTesterAlert(COLOR_LIGHTRED, "[SUPPORT: %d] {FFBB00}%s [%d]: %.65s", playerid, ReturnName(playerid), playerid, PlayerData[playerid][pHelpmeMessage]);
		SendTesterAlert(COLOR_LIGHTRED, "[SUPPORT: %d] {FFBB00}...%s", playerid, PlayerData[playerid][pHelpmeMessage][65]);
	}
	else SendTesterAlert(COLOR_LIGHTRED, "[SUPPORT: %d] {FFBB00}%s [%d]: %s", playerid, ReturnName(playerid), playerid, PlayerData[playerid][pHelpmeMessage]);

	return true;
}

CMD:helplist(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 1 && !IsTester(playerid))
		return SendClientMessage(playerid, COLOR_LIGHTRED, "You are not a tester!");

	SendClientMessage(playerid, COLOR_GREEN, "_____________________________SUPPORT REQUESTS_____________________________");

	new
		reportCount
	;

	foreach (new i : Player)
	{
		if(PlayerData[i][pHelpme] >= 1)
		{
			SendClientMessageEx(playerid, COLOR_LIGHTRED, "[SUPPORT]{FAB800} %s [%d]: %s", ReturnName(i), i, PlayerData[i][pHelpmeMessage]);

 			reportCount++;
  		}
   	}

	SendClientMessageEx(playerid, COLOR_WHITE, "TOTAL COUNT OF ACTIVE SUPPORT REQUESTS: %d ", reportCount);

	SendClientMessage(playerid, COLOR_GREEN, "_______________________________________________________________________________________");
	return true;
}

CMD:rsd(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1 && !IsTester(playerid))
  		return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new
		userid
	;

	if(sscanf(params, "u", userid))
		return SendClientMessage(playerid, COLOR_LIGHTRED, "USAGE: /rsd [playerid]");

	if(!IsPlayerConnected(userid) || !SQL_IsLogged(userid))
		return SendClientMessage(playerid, COLOR_LIGHTRED, "The specified player ID is either not connected or has not authenticated.");

	if(!PlayerData[userid][pHelpme])
		return SendClientMessage(playerid, COLOR_LIGHTRED, "Request does not exist.");

	SendTesterAlert(TEAM_TESTER_COLOR, "[TESTER]{FFBB00} %s has accepted request %d by %s (%d)", ReturnName(playerid), userid, ReturnName(userid), userid);

	if(strlen(PlayerData[userid][pHelpmeMessage]) > 80)
	{
		SendClientMessageEx(playerid, COLOR_GRAD1, "%.80s...", PlayerData[userid][pHelpmeMessage]);
		SendClientMessageEx(playerid, COLOR_GRAD1, "...%s", PlayerData[userid][pHelpmeMessage][80]);
	}
	else SendClientMessage(playerid, COLOR_GRAD1, PlayerData[userid][pHelpmeMessage]);


    SendClientMessageEx(userid, COLOR_GREEN, "%s (%d) has responded to your support request, please wait for him/her to contact you! [REF ID: %d]", ReturnName(playerid), playerid, userid);

	SendClientMessage(userid, COLOR_LIGHTRED, "Your request:");

	if(strlen(PlayerData[userid][pHelpmeMessage]) > 80)
	{
		SendClientMessageEx(userid, COLOR_GRAD1, "%.80s...", PlayerData[userid][pHelpmeMessage]);
		SendClientMessageEx(userid, COLOR_GRAD1, "...%s", PlayerData[userid][pHelpmeMessage][80]);
	}
	else SendClientMessage(userid, COLOR_GRAD1, PlayerData[userid][pHelpmeMessage]);

	PlayerData[userid][pHelpme] = 0;
	PlayerData[userid][pHelpmeSeconds] = 0;
 	PlayerData[userid][pHelpmeMessage][0] = EOS;
	return true;
}

CMD:drs(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1 && !IsTester(playerid))
  		return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new
		userid
	;

	if(sscanf(params, "u", userid))
		return SendClientMessage(playerid, COLOR_LIGHTRED, "USAGE: /drs [playerid]");

	if(!IsPlayerConnected(userid))
		return SendClientMessage(playerid, COLOR_LIGHTRED, "The specified player ID is either not connected or has not authenticated.");

	if(!PlayerData[userid][pHelpme])
		return SendClientMessage(playerid, COLOR_LIGHTRED, "That player doesn't have an active report.");

	SendTesterAlert(TEAM_TESTER_COLOR, "[TESTER]{FFBB00} %s has disregarded request %d by %s (%d)", ReturnName(playerid), userid, ReturnName(userid), userid);

	if(strlen(PlayerData[userid][pHelpmeMessage]) > 80)
	{
		SendClientMessageEx(playerid, COLOR_GRAD1, "%.80s...", PlayerData[userid][pHelpmeMessage]);
		SendClientMessageEx(playerid, COLOR_GRAD1, "...%s", PlayerData[userid][pHelpmeMessage][80]);
	}
	else SendClientMessage(playerid, COLOR_GRAD1, PlayerData[userid][pHelpmeMessage]);

	PlayerData[userid][pHelpme] = 0;
	PlayerData[userid][pHelpmeSeconds] = 0;
 	PlayerData[userid][pHelpmeMessage][0] = EOS;
	return true;
}

CMD:testerduty(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 1 && !IsTester(playerid))
		return SendClientMessage(playerid, COLOR_LIGHTRED, "You are not a tester!");

	if(AdminDuty{playerid})
	    return SendErrorMessage(playerid, "You can't do that while on admin duty.");

	TesterDuty{playerid} = !TesterDuty{playerid};		

	if(TesterDuty{playerid})
	{
		SendTesterAlert(TEAM_TESTER_COLOR, "[TESTER] {FFBB00}%s is now on tester duty!", ReturnName(playerid));

		TesterColor{playerid} = true;
	}
	else
	{
		SendTesterAlert(TEAM_TESTER_COLOR, "[TESTER] {FFBB00}%s is now off tester duty!", ReturnName(playerid));

		TesterColor{playerid} = false;
	}

	SetPlayerToTeamColor(playerid);
	return true;
}

CMD:testercolor(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 1 && !IsTester(playerid))
		return SendClientMessage(playerid, COLOR_LIGHTRED, "You are not a tester!");

 	if(AdminDuty{playerid})
	    return SendErrorMessage(playerid, "You can't do that while on admin duty.");

	if(TesterColor{playerid})
	{
	    TesterColor{playerid} = false;

	    SetPlayerToTeamColor(playerid);

	    SendNoticeMessage(playerid, "Tester color has been disabled.");
	}
	else
	{
	    TesterColor{playerid} = true;

	    SetPlayerToTeamColor(playerid);

	    SendNoticeMessage(playerid, "Tester color has been enabled.");
	}
	return true;
}

CMD:showmain(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 1 && !IsTester(playerid))
	    return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	if(ShowMain{playerid})
	{
	    ShowMain{playerid} = false;

	    SendNoticeMessage(playerid, "UCP account name will no longer show next to your in-game name in certain commands.");
	}
	else
	{
	    ShowMain{playerid} = true;

	    SendNoticeMessage(playerid, "UCP account name will now show next to your in-game name in certain commands.");
	}
	return true;
}

CMD:givespray(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1 && !IsTester(playerid) && GetFactionType(playerid) != FACTION_GANG)
  		return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new
		userid
	;

	if(sscanf(params, "u", userid))
		return SendSyntaxMessage(playerid, "/givespray [playerid/partOfName]");

	if(!IsPlayerConnected(userid))
		return SendErrorMessage(playerid, "The player you specified isn't connected.");

	if(PlayerData[userid][pSprayBanned])
		return SendErrorMessage(playerid, "Player is spray banned.");

    GivePlayerWeaponEx(userid, 41, 99999);

	SendClientMessageEx(userid, COLOR_YELLOW, "-> %s granted you spray permission, /graffiti.", ReturnName(playerid, 0));
	SendClientMessageEx(playerid, COLOR_YELLOW, "-> You granted graffiti permission to %s.", ReturnName(userid, 0));

	SendAdminAlert(COLOR_LIGHTRED, JUNIOR_ADMINS, "AdmWarn(1): Player %s [%d] has a Spray Can (41)", ReturnName(userid), userid);
	return true;
}

CMD:banspray(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1 && !IsTester(playerid))
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new
		userid
	;

	if(sscanf(params, "u", userid))
		return SendSyntaxMessage(playerid, "/banspray [playerid/PartOfName]");

	if(!IsPlayerConnected(userid))
		return SendErrorMessage(playerid, "The player you specified isn't connected.");

	if(PlayerData[userid][pSprayBanned])
		return SendErrorMessage(playerid, "Player is already spray banned.");

	PlayerData[userid][pSprayBanned] = 1;

	SendClientMessageEx(playerid, COLOR_YELLOW, "-> You spray banned %s, /unbanspray to unban him.", ReturnName(userid));
	return true;
}

CMD:checksprayban(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1 && !IsTester(playerid))
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new
		userid
	;

	if(sscanf(params, "u", userid))
		return SendSyntaxMessage(playerid, "/checksprayban [playerid/PartOfName]");

	if(!IsPlayerConnected(userid))
		return SendErrorMessage(playerid, "The player you specified isn't connected.");

	if(PlayerData[userid][pSprayBanned])
		SendClientMessageEx(playerid, COLOR_YELLOW, "-> %s is spray banned.", ReturnName(userid));
	else
		SendClientMessageEx(playerid, COLOR_YELLOW, "-> %s is not spray banned.", ReturnName(userid));

	return true;
}

CMD:unbanspray(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 1 && !IsTester(playerid))
    	return SendErrorMessage(playerid, "You're not authorized to use this command.");

	new
		userid
	;

	if(sscanf(params, "u", userid))
		return SendSyntaxMessage(playerid, "/unbanspray [playerid/PartOfName]");

	if(!IsPlayerConnected(userid))
		return SendErrorMessage(playerid, "The player you specified isn't connected.");

	if(!PlayerData[userid][pSprayBanned])
		return SendErrorMessage(playerid, "Player is not spray banned.");

	PlayerData[userid][pSprayBanned] = 0;

	SendClientMessageEx(playerid, COLOR_YELLOW, "-> You unbanned %s from using spray cans.", ReturnName(userid));
	return true;
}

CMD:z(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 1 && !IsTester(playerid))
		return SendClientMessage(playerid, COLOR_LIGHTRED, "You are not a tester!");

	new str1[128], str2[128], bool:splitted = false;

	if(isnull(params))
		return SendClientMessage(playerid, COLOR_LIGHTRED, "USAGE: /z [tester chat]");

	if(strlen(params) > 80)
	{
		format(str1, sizeof(str1), "** %s: %.80s ...", AccountName(playerid), params);
		format(str2, sizeof(str2), "** %s: %s: ... %s", AccountName(playerid), params[80]);

		splitted = true;
	}
	else
	{
		format(str1, sizeof(str1), "** %s: %s", AccountName(playerid), params);
	}

 	foreach (new i : Player)
	{
	    if(!SQL_IsLogged(i) || PlayerData[i][pID] == -1) continue;

		if(PlayerData[i][pAdmin] >= 1 || PlayerData[i][pAdmin] == -1)
		{
			if(splitted)
			{
				SendClientMessage(i, COLOR_LIGHTBLUE, str1);
				SendClientMessage(i, COLOR_LIGHTBLUE, str2);
			}
			else
			{
				SendClientMessage(i, COLOR_LIGHTBLUE, str1);
			}
		}
	}
	return true;
}

CMD:th(playerid, params[])
{
	if(!IsTester(playerid))
	    return SendUnauthMessage(playerid, "You're unauthorized to use this command.");

    SendClientMessage(playerid, COLOR_WHITE, "[Tester - Helpme Requests] /helplist, /rsd(accept), /drs(disregard)");
	SendClientMessage(playerid, COLOR_WHITE, "[Tester - Misc.] /testerduty, /testercolor, /showmain");
	SendClientMessage(playerid, COLOR_WHITE, "[Tester - Spraycans] /givespray, /banspray, /bansprayid, /checksprayban, /unbanspray");
	return true;
}
