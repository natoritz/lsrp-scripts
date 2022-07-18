// Defines

#define MAX_ENTRANCES (20)

// Variables

enum
{
	POINT_TYPE_ONFOOT,
	POINT_TYPE_VEHICLE,
	POINT_TYPE_BOTH,
	POINT_TYPE_ELEVATOR
};

enum E_ENTRANCE_DATA
{
	pointID,
	Float:outsidePos[4],
	Float:insidePos[4],
	outsideApartmentSQL,
	outsideApartmentID,
	insideApartmentSQL,
	insideApartmentID,
	Float:pointRange,
	pointType,
	pointName[80],
	pointLocked,
	pointFaction
};

static const PointTypes[][] =
{
	"On Foot Only",
	"On Vehicle Only",
	"On Foot / Vehicle",
	"Elevator"
};

new EntranceData[MAX_ENTRANCES][E_ENTRANCE_DATA];
new Iterator:Entrance<MAX_ENTRANCES>;

// Functions

Point_Nearest(playerid, Float:radius = 2.5, ignoreid = -1)
{
    foreach (new i : Entrance)
	{
	    if(ignoreid == i) continue;

	    if(InApartment[playerid] != EntranceData[i][outsideApartmentID] && InApartment[playerid] != EntranceData[i][insideApartmentID]) continue;

		if(IsPlayerInRangeOfPoint(playerid, radius, EntranceData[i][outsidePos][0], EntranceData[i][outsidePos][1], EntranceData[i][outsidePos][2]) || IsPlayerInRangeOfPoint(playerid, radius, EntranceData[i][insidePos][0], EntranceData[i][insidePos][1], EntranceData[i][insidePos][2]))
		{
			return i;
		}
	}
	return -1;
}

ShowPointSettings(playerid, point)
{
	gstr[0] = EOS;

	format(gstr, sizeof(gstr), "{7e98b6}1\t{a9c4e4}Name [{7e98b6}%s{a9c4e4}]\n", EntranceData[point][pointName]);
	format(gstr, sizeof(gstr), "%s{7e98b6}2\t{a9c4e4}Outside Apartment ID [{7e98b6}%d{a9c4e4}]\n", gstr, EntranceData[point][outsideApartmentID]);
	format(gstr, sizeof(gstr), "%s{7e98b6}3\t{a9c4e4}Inside Apartment ID [{7e98b6}%d{a9c4e4}]\n", gstr, EntranceData[point][insideApartmentID]);
	format(gstr, sizeof(gstr), "%s{7e98b6}4\t{a9c4e4}Type [{7e98b6}%s{a9c4e4}]\n", gstr, PointTypes[ EntranceData[point][pointType] ]);
	format(gstr, sizeof(gstr), "%s{7e98b6}5\t{a9c4e4}Range [{7e98b6}%.1f{a9c4e4}]\n", gstr, EntranceData[point][pointRange]);
	format(gstr, sizeof(gstr), "%s{7e98b6}6\t{a9c4e4}Faction [{7e98b6}%s{a9c4e4}]\n", gstr, ReturnFactionNameByType(EntranceData[point][pointFaction]));
	format(gstr, sizeof(gstr), "%s{7e98b6}Set enter coordinates (current position)\n{7e98b6}Set exit coordinates (current position)\n{7e98b6}Teleport\n{7e98b6}Delete Point", gstr);

	Dialog_Show(playerid, EditPoint, DIALOG_STYLE_LIST, "Edit Point", gstr, "Select", "Exit");
	return true;
}

Dialog:EditPoint_Type(playerid, response, listitem, inputtext[])
{
    new point = GetPVarInt(playerid, "EditingPoint");

	if(!response)
	{
	    return ShowPointSettings(playerid, point);
	}

    EntranceData[point][pointType] = listitem;

	mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `points` SET `pointType` = '%d' WHERE `ID` = '%d' LIMIT 1", listitem, EntranceData[point][pointID]);
	mysql_pquery(dbCon, gquery);

	SendClientMessageEx(playerid, COLOR_YELLOW, "-> You've successfully set Point %d's type to: %s", EntranceData[point][pointID], PointTypes[listitem]);

	ShowPointSettings(playerid, point);
	return true;
}

Dialog:EditPoint_Range(playerid, response, listitem, inputtext[])
{
    new point = GetPVarInt(playerid, "EditingPoint");

	if(!response)
	{
	    return ShowPointSettings(playerid, point);
	}

	new Float:input = float(strval(inputtext));

	if(input < 2.0 || input > 10.0)
	{
	    SendErrorMessage(playerid, "Invalid range specified, 2.0 to 10.0 allowed only.");

	    return ShowPointSettings(playerid, point);
	}

    EntranceData[point][pointRange] = input;

	mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `points` SET `pointRange` = '%f' WHERE `ID` = '%d' LIMIT 1", input, EntranceData[point][pointID]);
	mysql_pquery(dbCon, gquery);

	SendClientMessageEx(playerid, COLOR_YELLOW, "-> You've successfully set Point %d's range to: %.1f", EntranceData[point][pointID], input);

	ShowPointSettings(playerid, point);
	return true;
}

Dialog:EditPoint_Faction(playerid, response, listitem, inputtext[])
{
    new point = GetPVarInt(playerid, "EditingPoint");

	if(!response)
	{
	    return ShowPointSettings(playerid, point);
	}

	if(listitem == 0) EntranceData[point][pointFaction] = -1;
    else EntranceData[point][pointFaction] = listitem;

	mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `points` SET `pointFaction` = '%d' WHERE `ID` = '%d' LIMIT 1", EntranceData[point][pointFaction], EntranceData[point][pointID]);
	mysql_pquery(dbCon, gquery);

	SendClientMessageEx(playerid, COLOR_YELLOW, "-> You've successfully set Point %d's Faction to: %s", EntranceData[point][pointID], ReturnFactionNameByType(EntranceData[point][pointFaction]));

	ShowPointSettings(playerid, point);
	return true;
}

Dialog:EditPoint(playerid, response, listitem, inputtext[])
{
	if(!response)
	{
	    DeletePVar(playerid, "EditingPoint");
	    return true;
	}

	new point = GetPVarInt(playerid, "EditingPoint");

	switch(listitem)
	{
	    case 3:
	    {
			return Dialog_Show(playerid, EditPoint_Type, DIALOG_STYLE_LIST, "Point Type", "{7e98b6}On Foot Only\n{7e98b6}On Vehicle Only\n{7e98b6}On Foot / Vehicle\n{7e98b6}Elevator", "Select", "<< Go Back");
	    }
	    case 4:
	    {
			return Dialog_Show(playerid, EditPoint_Range, DIALOG_STYLE_INPUT, "Point Range", "{7e98b6}Change point range (Default 3.0)", "Change", "<< Go Back");
	    }
	    case 5:
	    {
			return Dialog_Show(playerid, EditPoint_Faction, DIALOG_STYLE_LIST, "Point Faction", "{7e98b6}NONE\n{7e98b6}POLICE\n{7e98b6}NEWS\n{7e98b6}MEDIC\n{7e98b6}GOV\n{7e98b6}GANG\n{7e98b6}SHERIFF\n{7e98b6}CORRECTIONAL", "Change", "<< Go Back");
	    }		
	    case 6:
	    {
			new Float:playerPos[4], apt = InApartment[playerid];

			GetPlayerPos(playerid, playerPos[0], playerPos[1], playerPos[2]);
			GetPlayerFacingAngle(playerid, playerPos[3]);

			if(IsPlayerInRangeOfPoint(playerid, 4.0, EntranceData[point][insidePos][0], EntranceData[point][insidePos][1], EntranceData[point][insidePos][2]) && apt == EntranceData[point][insideApartmentID])
			{
			    SendErrorMessage(playerid, "You're too close to the exit coordinates.");
			    return ShowPointSettings(playerid, point);
			}

			EntranceData[point][outsidePos][0] = playerPos[0];
			EntranceData[point][outsidePos][1] = playerPos[1];
			EntranceData[point][outsidePos][2] = playerPos[2];
			EntranceData[point][outsidePos][3] = playerPos[3];

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

			mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `points` SET `outsideX` = '%f', `outsideY` = '%f', `outsideZ` = '%f', `outsideA` = '%f', `insideApartment` = '%d' WHERE `ID` = '%d' LIMIT 1", playerPos[0], playerPos[1], playerPos[2], playerPos[3], EntranceData[point][outsideApartmentSQL], EntranceData[point][pointID]);
			mysql_pquery(dbCon, gquery);

	        SendClientMessageEx(playerid, COLOR_YELLOW, "-> Successfully edited Point %d's enter coordinates: %f, %f, %f", EntranceData[point][pointID], playerPos[0], playerPos[1], playerPos[2]);
	        return true;
	    }
	    case 7:
	    {
			new Float:playerPos[4], apt = InApartment[playerid];

			GetPlayerPos(playerid, playerPos[0], playerPos[1], playerPos[2]);
			GetPlayerFacingAngle(playerid, playerPos[3]);

			if(IsPlayerInRangeOfPoint(playerid, 4.0, EntranceData[point][outsidePos][0], EntranceData[point][outsidePos][1], EntranceData[point][outsidePos][2]) && apt == EntranceData[point][outsideApartmentID])
			{
			    SendErrorMessage(playerid, "You're too close to the enter coordinates.");
			    return ShowPointSettings(playerid, point);
			}

			EntranceData[point][insidePos][0] = playerPos[0];
			EntranceData[point][insidePos][1] = playerPos[1];
			EntranceData[point][insidePos][2] = playerPos[2];
			EntranceData[point][insidePos][3] = playerPos[3];

			if(apt == -1)
			{
				EntranceData[point][insideApartmentSQL] = -1;
				EntranceData[point][insideApartmentID] = -1;
			}
			else
			{
				EntranceData[point][insideApartmentSQL] = ComplexData[apt][aID];
				EntranceData[point][insideApartmentID] = apt;
			}

			mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `points` SET `insideX` = '%f', `insideY` = '%f', `insideZ` = '%f', `insideA` = '%f', `insideApartment` = '%d' WHERE `ID` = '%d' LIMIT 1", playerPos[0], playerPos[1], playerPos[2], playerPos[3], EntranceData[point][insideApartmentSQL], EntranceData[point][pointID]);
			mysql_pquery(dbCon, gquery);

	        SendClientMessageEx(playerid, COLOR_YELLOW, "-> Successfully edited Point %d's exit coordinates: %f, %f, %f", EntranceData[point][pointID], playerPos[0], playerPos[1], playerPos[2]);
	        return true;
	    }
	    case 8:
	    {
	        DeletePVar(playerid, "EditingPoint");

	        SetPlayerPosEx(playerid, EntranceData[point][outsidePos][0], EntranceData[point][outsidePos][1], EntranceData[point][outsidePos][2]);

	        if(EntranceData[point][outsideApartmentID] != -1)
	        {
				SetPlayerInteriorEx(playerid, ComplexData[ EntranceData[point][outsideApartmentID] ][aInterior]);
				SetPlayerVirtualWorldEx(playerid, ComplexData[ EntranceData[point][outsideApartmentID] ][aWorld]);

				PlayerData[playerid][pLocal] = EntranceData[point][outsideApartmentID] + LOCAL_APARTMENT;
	        }
	        else PlayerData[playerid][pLocal] = 255;

            InApartment[playerid] = EntranceData[point][outsideApartmentID];
            return true;
	    }
	    case 9:
	    {
	        DeletePVar(playerid, "EditingPoint");

			mysql_format(dbCon, gquery, sizeof(gquery), "DELETE FROM `points` WHERE `ID` = '%d' LIMIT 1", EntranceData[point][pointID]);
			mysql_pquery(dbCon, gquery);

	        EntranceData[point][pointID] = -1;

	        Iter_Remove(Entrance, point);

	        SendClientMessageEx(playerid, COLOR_YELLOW, "-> Successfully removed the point.", EntranceData[point][pointID]);
	        return true;
	    }
	}

    ShowPointSettings(playerid, point);
	return true;
}
