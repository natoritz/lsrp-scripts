#define SendErrorMessage(%0,%1) \
	SendClientMessageEx(%0, COLOR_LIGHTRED, "ERROR:{FFFFFF} "%1)

#define SendSyntaxMessage(%0,%1) \
	SendClientMessageEx(%0, COLOR_LIGHTRED, "USAGE:{FFFFFF} "%1)

#define SendUnauthMessage(%0,%1) \
	SendClientMessageEx(%0, COLOR_LIGHTRED, "ACCESS DENIED:{FFFFFF} "%1)

#define SendServerMessage(%0,%1) \
	SendClientMessageEx(%0, COLOR_LIGHTRED, "SERVER: "%1)

#define SendNoticeMessage(%0,%1) \
	SendClientMessageEx(%0, COLOR_LIGHTRED, "[ ! ]{FFFFFF} "%1)
	
ClearChatBox(playerid)
{
	for(new i = 0; i < 100; ++i)
	{
		SendClientMessage(playerid, -1, "");
	}
}

SendClientMessageEx(playerid, colour, const fmat[], va_args<>)
{
	new str[145];
	va_format(str, sizeof (str), fmat, va_start<3>);
	return SendClientMessage(playerid, colour, str);
}

SendClientMessageToAllEx(color, const fmat[], va_args<>)
{
	new str[145];
	va_format(str, sizeof (str), fmat, va_start<2>);
 	return SendClientMessageToAll(color, str);
}

GameTextForPlayerEx(playerid, const fmat[], time, style, va_args<>)
{
	new str[40];
	va_format(str, sizeof (str), fmat, va_start<4>);
	return GameTextForPlayer(playerid, str, time, style);
}

SendAdminAlert(colour, level, const fmat[], va_args<>)
{
	new str[145];
	va_format(str, sizeof (str), fmat, va_start<3>);

	foreach (new i : Player)
	{
 		if(PlayerData[i][pID] == -1 || PlayerData[i][pAdmin] <= 0) continue;

		if(PlayerData[i][pAdmin] >= level)
		{
  		    SendClientMessage(i, colour, str);
		}
	}
	return true;
}

SendTesterAlert(colour, const fmat[], va_args<>)
{
	new str[145];
	va_format(str, sizeof (str), fmat, va_start<2>);

	foreach (new i : Player)
	{
 		if(PlayerData[i][pID] == -1) continue;

		if(PlayerData[i][pAdmin] == -1 || PlayerData[i][pAdmin] >= 1)
		{
  		    SendClientMessage(i, colour, str);
		}
	}
	return true;
}

SendNearbyMessage(playerid, Float:radius, color, const fmat[], va_args<>)
{
	new str[145];
	va_format(str, sizeof (str), fmat, va_start<4>);

    SendClientMessage(playerid, color, str);

	foreach (new i : Player)
	{
		if(PlayerData[i][pID] == -1 || i == playerid) continue;

		if(IsPlayerNearPlayer(i, playerid, radius))
		{
			SendClientMessage(i, color, str);
		}
	}
	return true;
}

SendPoliceMessage(color, const fmat[], va_args<>)
{
	new str[145];
	va_format(str, sizeof (str), fmat, va_start<2>);

	foreach (new i : Player)
	{
 		if(PlayerData[i][pID] == -1 || PlayerData[i][pFaction] == -1) continue;

		if(IsPolice(i) && PlayerData[i][pOnDuty])
		{
			SendClientMessage(i, color, str);
		}
	}
	return true;
}

SendMedicMessage(color, const fmat[], va_args<>)
{
	new str[145];
	va_format(str, sizeof (str), fmat, va_start<3>);

	foreach (new i : Player)
	{
		if(PlayerData[i][pFaction] == -1) continue;

		if(GetFactionType(i) == 3 && PlayerData[i][pOnDuty])
		{
		    SendClientMessage(i, color, str);
		}
	}
	return true;
}

SendFactionMessage(factionid, color, const fmat[], va_args<>)
{
	new str[145];
	va_format(str, sizeof (str), fmat, va_start<3>);

	foreach (new i : Player)
	{
		if(PlayerData[i][pFaction] == factionid)
		{
		    SendClientMessage(i, color, str);
		}
	}
	return true;
}

SendFactionMessageEx(type, color, const fmat[], va_args<>)
{
	new str[145];
	va_format(str, sizeof (str), fmat, va_start<3>);

	foreach (new i : Player)
	{
		if(PlayerData[i][pID] == -1 || PlayerData[i][pFaction] == -1) continue;

		if(GetFactionType(i) == type && !PlayerFlags[i][factionChat])
		{
		    SendClientMessage(i, color, str);
	 	}
	}
	return true;
}

SendJobMessage(jobid, color, const fmat[], va_args<>)
{
	new str[145];
	va_format(str, sizeof (str), fmat, va_start<3>);

	foreach (new i : Player)
	{
		if(PlayerData[i][pJob] == jobid || PlayerData[i][pSideJob] == jobid)
		{
	 		if(jobid == JOB_TAXI)
			{
			    if(TaxiDuty{i})
				{
			        SendClientMessage(i, color, str);
			    }
			}
			else SendClientMessage(i, color, str);
		}
	}
	return true;
}

ProxDetectorRadio(playerid, Float:radius, const str[])
{
	new Float:posx, Float:posy, Float:posz;
	new Float:oldposx, Float:oldposy, Float:oldposz;
	new Float:tempposx, Float:tempposy, Float:tempposz;

	GetPlayerPos(playerid, oldposx, oldposy, oldposz);

	foreach (new i : Player)
	{
	    if(PlayerData[i][pID] == -1) continue;

	    if(i == playerid) continue;

		if(PlayerData[i][pSpectating] != playerid)
		{
			if(!IsPlayerStreamedIn(i, playerid)) continue;
		}

		if(GetPlayerInterior(playerid) == GetPlayerInterior(i) && GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(i))
		{
			GetPlayerPos(i, posx, posy, posz);

			tempposx = (oldposx -posx);
			tempposy = (oldposy -posy);
			tempposz = (oldposz -posz);

			if(((tempposx < radius/16) && (tempposx > -radius/16)) && ((tempposy < radius/16) && (tempposy > -radius/16)) && ((tempposz < radius/16) && (tempposz > -radius/16)))
			{
				SendClientMessage(i, COLOR_FADE1, str);
			}
			else if(((tempposx < radius/8) && (tempposx > -radius/8)) && ((tempposy < radius/8) && (tempposy > -radius/8)) && ((tempposz < radius/8) && (tempposz > -radius/8)))
			{
				SendClientMessage(i, COLOR_FADE2, str);
			}
			else if(((tempposx < radius/4) && (tempposx > -radius/4)) && ((tempposy < radius/4) && (tempposy > -radius/4)) && ((tempposz < radius/4) && (tempposz > -radius/4)))
			{
				SendClientMessage(i, COLOR_FADE3, str);
			}
			else if(((tempposx < radius/2) && (tempposx > -radius/2)) && ((tempposy < radius/2) && (tempposy > -radius/2)) && ((tempposz < radius/2) && (tempposz > -radius/2)))
			{
				SendClientMessage(i, COLOR_FADE4, str);
			}
			else if(((tempposx < radius) && (tempposx > -radius)) && ((tempposy < radius) && (tempposy > -radius)) && ((tempposz < radius) && (tempposz > -radius)))
			{
				SendClientMessage(i, COLOR_FADE5, str);
			}
		}
	}
	return true;
}

ProxDetector(playerid, Float:radius, const str[])
{
	SendClientMessage(playerid, COLOR_FADE1, str);

	new Float:posx, Float:posy, Float:posz;
	new Float:oldposx, Float:oldposy, Float:oldposz;
	new Float:tempposx, Float:tempposy, Float:tempposz;

	GetPlayerPos(playerid, oldposx, oldposy, oldposz);

	foreach (new i : Player)
	{
	    if(PlayerData[i][pID] == -1) continue;

	    if(i == playerid) continue;

		if(PlayerData[i][pSpectating] == INVALID_PLAYER_ID)
		{
			//if(!IsPlayerStreamedIn(i, playerid)) continue;

			if(GetPlayerInterior(playerid) != GetPlayerInterior(i) || GetPlayerVirtualWorld(playerid) != GetPlayerVirtualWorld(i)) continue;

			GetPlayerPos(i, posx, posy, posz);
		}
		else // If the player is spectating
		{
		    if(!IsPlayerConnected(PlayerData[i][pSpectating])) continue;

		    GetPlayerPos(PlayerData[i][pSpectating], posx, posy, posz);
		}

		tempposx = (oldposx -posx);
		tempposy = (oldposy -posy);
		tempposz = (oldposz -posz);

		if(((tempposx < radius/16) && (tempposx > -radius/16)) && ((tempposy < radius/16) && (tempposy > -radius/16)) && ((tempposz < radius/16) && (tempposz > -radius/16)))
		{
			SendClientMessage(i, COLOR_FADE1, str);
		}
		else if(((tempposx < radius/8) && (tempposx > -radius/8)) && ((tempposy < radius/8) && (tempposy > -radius/8)) && ((tempposz < radius/8) && (tempposz > -radius/8)))
		{
			SendClientMessage(i, COLOR_FADE2, str);
		}
		else if(((tempposx < radius/4) && (tempposx > -radius/4)) && ((tempposy < radius/4) && (tempposy > -radius/4)) && ((tempposz < radius/4) && (tempposz > -radius/4)))
		{
			SendClientMessage(i, COLOR_FADE3, str);
		}
		else if(((tempposx < radius/2) && (tempposx > -radius/2)) && ((tempposy < radius/2) && (tempposy > -radius/2)) && ((tempposz < radius/2) && (tempposz > -radius/2)))
		{
			SendClientMessage(i, COLOR_FADE4, str);
		}
		else if(((tempposx < radius) && (tempposx > -radius)) && ((tempposy < radius) && (tempposy > -radius)) && ((tempposz < radius) && (tempposz > -radius)))
		{
			SendClientMessage(i, COLOR_FADE5, str);
		}
	}
	return true;
}

ProxDetectorOOC(playerid, Float:radius, const str[])
{
	SendClientMessage(playerid, COLOR_GREY, str);

	new Float:playerPos[3];
	GetPlayerPos(playerid, playerPos[0], playerPos[1], playerPos[2]);

	foreach (new i : Player)
	{
	    if(PlayerData[i][pID] == -1) continue;

	    if(i == playerid) continue;

        if(BlockedOOC[i][playerid] && PlayerData[playerid][pAdmin] < 1) continue;

		if(PlayerData[i][pSpectating] == INVALID_PLAYER_ID)
		{
			//if(!IsPlayerStreamedIn(i, playerid)) continue;

			if(GetPlayerInterior(playerid) != GetPlayerInterior(i) || GetPlayerVirtualWorld(playerid) != GetPlayerVirtualWorld(i)) continue;

			if(!IsPlayerInRangeOfPoint(i, radius, playerPos[0], playerPos[1], playerPos[2])) continue;
		}
		else // If the player is spectating
		{
		    if(!IsPlayerConnected(PlayerData[i][pSpectating])) continue;

		    if(!IsPlayerInRangeOfPoint(PlayerData[i][pSpectating], radius, playerPos[0], playerPos[1], playerPos[2])) continue;
		}

		SendClientMessage(i, COLOR_GREY, str);
	}
	return true;
}

ProxJoinServer(playerid, const str[])
{
	foreach (new i : Player)
	{
		if(playerid == i) continue;

		if(PlayerFlags[i][joinAlerts] || PlayerData[i][pID] == -1)
		{
			SendClientMessage(i, COLOR_GRAD1, str);
		}
	}
	return true;
}
