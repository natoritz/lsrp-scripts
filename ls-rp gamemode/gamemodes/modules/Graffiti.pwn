// Defines

#define MAX_SPRAY_LOCATIONS (110)

// Variables

enum E_SPRAY_DATA
{
	graffSQLID,
	graffCreator[MAX_PLAYER_NAME + 1],
	graffName[256],
	Float:Xpos,
	Float:Ypos,
	Float:Zpos,
	Float:XYpos,
	Float:YYpos,
	Float:ZYpos,
	graffModel,
	graffDefault,
	graffFont[24],
	graffObject,
}

new Spray_Data[MAX_SPRAY_LOCATIONS][E_SPRAY_DATA];

static const graffiti_SprayTag[][] =
{
	{18659, "Grove St 4 Life"},
	{18660, "Seville B.V.V.D Families"},
	{18661, "Varrio Los Aztecas"},
	{18662, "Kilo"},
	{18663, "San Fiero Rifa"},
	{18664, "Temple Drive Ballas"},
	{18665, "Los Santos Vargos"},
	{18666, "Front Yard Balas"},
	{18667, "Rolling Heights Ballas"}
};

new GraffitiColors[][] =
{
	"(b)",
	"(w)",
	"(y)",
	"(r)",
	"(o)",
	"(pu)",
	"(bl)",
	"(g)",
	"(gr)",
	"(p)",
	"(br)",
	"(dr)",
	"(l)",
	"(ge)",
	"(sb)",
	"(t)",
	"(s)",
	"(nbl)",
	"(mbl)",
	"(blv)",
	"(dgr)",
	"(gld)",
	"(brz)",
	"(ds)",
	"(ama)",
 	"(fal)",
 	"(ful)",
 	"(gla)",
 	"(mik)",
	"(sma)",
	"(mar)",
	"(lvd)",
	"(dog)",
	"(hpk)",
	"(xnd)"
};

// Functions

Graffiti_Nearest(playerid, Float:radius = 2.5)
{
	for(new i = 0; i < MAX_SPRAY_LOCATIONS; ++i)
	{
	    if(Spray_Data[i][graffSQLID] == -1) continue;

		if(IsPlayerInRangeOfPoint(playerid, radius, Spray_Data[i][Xpos], Spray_Data[i][Ypos], Spray_Data[i][Zpos]))
		{
			return i;
		}
	}

	return -1;
}

ShowGraffitiDialog(playerid)
{
	new string[500];

	strcat(string, "{7e98b6}1\t{a9c4e4}Graffiti Text\n");

	switch(SprayingFont[playerid])
	{
	    case 0: strcat(string, "{7e98b6}2\t{a9c4e4}Graffiti Font {7e98b6}[{a9c4e4}Arial{7e98b6}]\n");
		case 1: strcat(string, "{7e98b6}2\t{a9c4e4}Graffiti Font {7e98b6}[{a9c4e4}Diploma{7e98b6}]\n");
	}

	switch(SprayingType[playerid])
	{
	    case 0: strcat(string, "{7e98b6}3\t{a9c4e4}Spray Type {7e98b6}[{a9c4e4}Spraying On{7e98b6}]");
		case 1: strcat(string, "{7e98b6}3\t{a9c4e4}Spray Type {7e98b6}[{a9c4e4}Cleaning Start{7e98b6}]");
		case 2: strcat(string, "{7e98b6}3\t{a9c4e4}Spray Type {7e98b6}[{a9c4e4}Cleaning End{7e98b6}]");
	}

	Dialog_Show(playerid, Graffiti_Menu, DIALOG_STYLE_LIST, "Graffiti", string, "Select", "Exit");
	return true;
}

ReturnGraffitiText(const grafftext[])
{
	new string[256];

	format(string, 256, grafftext);

	format(string, 256, "%s", strreplace(string, "(n)", "\n"));
 	format(string, 256, "%s", strreplace(string, "(b)", "{000000}"));
 	format(string, 256, "%s", strreplace(string, "(w)", "{FFFFFF}"));
 	format(string, 256, "%s", strreplace(string, "(y)", "{FFFF00}"));
 	format(string, 256, "%s", strreplace(string, "(r)", "{FF0000}"));
 	format(string, 256, "%s", strreplace(string, "(o)", "{FF9600}"));

 	format(string, 256, "%s", strreplace(string, "(pu)", "{AD2AbC}"));
 	format(string, 256, "%s", strreplace(string, "(bl)", "{0006FF}"));
 	format(string, 256, "%s", strreplace(string, "(g)", "{33AA33}"));
 	format(string, 256, "%s", strreplace(string, "(gr)", "{ADADAD}"));
 	format(string, 256, "%s", strreplace(string, "(p)", "{FF6CfD}"));

 	format(string, 256, "%s", strreplace(string, "(br)", "{9E7341}"));
 	format(string, 256, "%s", strreplace(string, "(dr)", "{800000}"));
 	format(string, 256, "%s", strreplace(string, "(l)", "{00FF00}"));
 	format(string, 256, "%s", strreplace(string, "(ge)", "{808080}"));
 	format(string, 256, "%s", strreplace(string, "(sb)", "{87CEEB}"));

 	format(string, 256, "%s", strreplace(string, "(t)", "{40E0D0}"));
 	format(string, 256, "%s", strreplace(string, "(s)", "{C0C0C0}"));
 	format(string, 256, "%s", strreplace(string, "(nbl)", "{000080}"));
 	format(string, 256, "%s", strreplace(string, "(mbl)", "{191970}"));
 	format(string, 256, "%s", strreplace(string, "(blv)", "{8A2BE2}"));

 	format(string, 256, "%s", strreplace(string, "(dgr)", "{065535}"));
 	format(string, 256, "%s", strreplace(string, "(gld)", "{FFD700}"));
 	format(string, 256, "%s", strreplace(string, "(brz)", "{CD7F32}"));
 	format(string, 256, "%s", strreplace(string, "(ds)", "{E9967A}"));
 	format(string, 256, "%s", strreplace(string, "(ama)", "{E52E4E}"));

 	format(string, 256, "%s", strreplace(string, "(fal)", "{801717}"));
 	format(string, 256, "%s", strreplace(string, "(ful)", "{E48400}"));
 	format(string, 256, "%s", strreplace(string, "(gla)", "{6082B6}"));
 	format(string, 256, "%s", strreplace(string, "(mik)", "{FFC40C}"));
 	format(string, 256, "%s", strreplace(string, "(sma)", "{009874}"));

  	format(string, 256, "%s", strreplace(string, "(mar)", "{B03060}"));
 	format(string, 256, "%s", strreplace(string, "(lvd)", "{E6E6fA}"));
 	format(string, 256, "%s", strreplace(string, "(dog)", "{556B2F}"));
 	format(string, 256, "%s", strreplace(string, "(hpk)", "{FF00FF}"));
 	format(string, 256, "%s", strreplace(string, "(xnd)", "{738678}"));

	return string;
}

ShowDefaultGraffitiText(playerid, bool:error = false)
{
	new longString[1600];

	format(longString, sizeof(longString), 
		"{FF6347}WELCOME:\n{FFFFFF}-\tOur graffiti system supports colors by using a (c) tag system.\n\
		{FFFFFF}-\t\t(b):{000000}Black{FFFFFF}, (w):White, (y):{FFFF00}Yellow{FFFFFF}, (r):{FF0000}Red{FFFFFF}, (o):{FF9600}Orange\n\
		{FFFFFF}-\t\t(pu):{AD2AbC}Purple{FFFFFF}, (bl):{0006FF}Blue{FFFFFF}, (g):{33AA33}Green{FFFFFF}, (gr):{ADADAD}Grey{FFFFFF}, (p):{FF6CfD}Pink\n\
		{FFFFFF}-\t\t(br):{9E7341}Brown{FFFFFF}, (dr):{800000}Dark Red{FFFFFF}, (l):{00FF00}Lime{FFFFFF}, (ge):{808080}Grey{FFFFFF}, (sb):{87CEEB}Sky Blue\n\
		{FFFFFF}-\t\t(t):{40E0D0}Turquoise{FFFFFF}, (s):{C0C0C0}Silver{FFFFFF}, (nbl):{000080}Navy Blue{FFFFFF}, (mbl):{191970}Midnight Blue{FFFFFF}, (blv):{8A2BE2}Blue Violet\n\
		{FFFFFF}-\t\t(dgr):{065535}Dark Green{FFFFFF}, (gld):{FFD700}Gold{FFFFFF}, (brz):{CD7F32}Bronze{FFFFFF}, (ds):{E9967A}Dark Salmon{FFFFFF}, (ama):{E52E4E}Amaranth\n\
		{FFFFFF}-\t\t(fal):{801717}Falu{FFFFFF}, (ful):{E48400}Fulvous{FFFFFF}, (gla):{6082B6}Glaucous{FFFFFF}, (mik):{FFC40C}Mikado{FFFFFF}, (sma):{009874}Smaragdine\n\
		{FFFFFF}-\t\t(mar):{B03060}Maroon{FFFFFF}, (lvd):{E6E6fA}Lavender{FFFFFF}, (dog):{556B2F}Dark Olive Green{FFFFFF}, (hpk):{FF00FF}Hot Pink{FFFFFF}, (xnd):{738678}Xanadu\n\n\
		{FFFFFF}-\tThe max characters allowed is {A9C4E4}20{FFFFFF}.\n\
		{FFFFFF}-\tYou need to use at least {A9C4E4}2 {FFFFFF}characters.\n\
		{FFFFFF}-\tYou can use the {A9C4E4}(n) {FFFFFF}tag to produce a new line.\n\
		{FFFFFF}-\tAbusing the graffiti system can lead to admin intervention.\n\
		{FFFFFF}-\tBe mindful of the text you spray. Trolling is not tolerated."
	);

	if(error) strcat(longString, "\n{FF0000}-\tERROR: Max line length reached (20)");

	return Dialog_Show(playerid, Graffiti_PickCustomText, DIALOG_STYLE_INPUT, "Graffiti: Graffiti Text", longString, "Select", "<< Go back");
}

Dialog:Graffiti_Menu(playerid, response, listitem, inputtext[])
{
	if(!response) return true;

	switch(listitem)
	{
		case 0:
		{
			ShowDefaultGraffitiText(playerid);
		}
		case 1:
		{
			Dialog_Show(playerid, Graffiti_PickFont, DIALOG_STYLE_LIST, "Graffiti: Graffiti Font", "0\tArial, Arial\n1\tDiploma, Diploma Regular", "Select", "<< Go back");
		}
		case 2:
		{
	 		switch(SprayingType[playerid])
			{
			    case SPRAY_TYPE_ON: SprayingType[playerid] = SPRAY_TYPE_CLEANING_START;
			    case SPRAY_TYPE_CLEANING_START: SprayingType[playerid] = SPRAY_TYPE_CLEANING_END;
			    case SPRAY_TYPE_CLEANING_END: SprayingType[playerid] = SPRAY_TYPE_ON;
			}

			ShowGraffitiDialog(playerid);
		}
	}
	return true;
}

Dialog:Graffiti_PickImage(playerid, response, listitem, inputtext[])
{
    if(!response)
        return Dialog_Show(playerid, Graffiti_Menu, DIALOG_STYLE_LIST, "Main Menu:", "Choose a graffiti\nNeed custom text?\nChoose font (For custom text)", "Select", "<<");

	SendClientMessageEx(playerid, COLOR_YELLOW, "-> Graffiti image set to: %s", graffiti_SprayTag[listitem][1]);
	format(GraffitiName[playerid], 256, graffiti_SprayTag[listitem][1]);
	GraffiModel[playerid] = graffiti_SprayTag[listitem][0];
	SprayAmmountCH[playerid] = 5;

	Dialog_Show(playerid, Graffiti_PickImage, DIALOG_STYLE_LIST, "Choose a graffiti:", "Grove St 4 Life\nSeville B.V.V.D Families\nVarrio Los Aztecas\nKilo\nSan Fiero Rifa\nTemple Drive Ballas\nLos Santos Vargos\nFront Yard Balas\nRolling Heights Ballas", "Select", "<<");
	return true;
}

IsForbiddenText(const text[])
{
	if(strfind(text, "fuck", true) != -1) return true;
	if(strfind(text, "nigga", true) != -1) return true;
	if(strfind(text, "nigger", true) != -1) return true;
	if(strfind(text, "bitch", true) != -1) return true;
	if(strfind(text, "pussy", true) != -1) return true;
	if(strfind(text, "fuck", true) != -1) return true;
	if(strfind(text, "penis", true) != -1) return true;
	if(strfind(text, "dick", true) != -1) return true;
	if(strfind(text, "gay", true) != -1) return true;
	return false;
}

Dialog:Graffiti_PickCustomText(playerid, response, listitem, inputtext[])
{
    if(!response) return ShowGraffitiDialog(playerid);

	if(response)
	{
	    if(strlen(inputtext) < 2)
			return ShowDefaultGraffitiText(playerid);

	    new bool:huge_text = false, idx = 0;

	    if(IsForbiddenText(inputtext))
			return ShowDefaultGraffitiText(playerid);

	    for(new i = 0; i < strlen(inputtext); ++i)
		{
		    if(i >= strlen(inputtext)) break;

			new finds = strfind(inputtext, "(n)", true, idx);

			if(finds != -1)
			{
			    new strr[128];

			    strmid(strr, inputtext, idx, finds);

			    if(strlen(strr) > 20)
			    {
				    huge_text = true;
				    break;
			    }

				idx = i + 3;
			}
			else
			{
			    if(strlen(inputtext[idx]) > 20)
			    {
				    huge_text = true;
				    break;
			    }
			}
		}

	    if(huge_text) return ShowDefaultGraffitiText(playerid, true);

	    SprayAmmountCH[playerid] = strlen(inputtext);
	    format(GraffitiName[playerid], 256, inputtext);

	    ShowGraffitiDialog(playerid);
	}
	return true;
}

Dialog:Graffiti_PickFont(playerid, response, listitem, inputtext[])
{
	if(response)
	{
	    SprayingFont[playerid] = listitem;

	    switch(listitem)
	    {
	        case 0: format(GraffitiFont[playerid], 24, "Arial");
	        case 1: format(GraffitiFont[playerid], 24, "Diploma");
	    }

	    ShowGraffitiDialog(playerid);
	}
	return true;
}

ReturnGraffitiName(const stringu[])
{
	new string[128];

	format(string, 128, stringu);

	for(new i = 0; i < sizeof(GraffitiColors); ++i)
	{
		format(string, 128, "%s", strreplace(string, GraffitiColors[i], ""));
	}

	format(string, 128, "%s", strreplace(string, "(n)", " "));

	return string;
}

ReturnCleanName(const stringu[])
{
	new string[128];

	format(string, 128, stringu);

	for(new i = 0; i < sizeof(GraffitiColors); ++i)
	{
		format(string, 128, "%s", strreplace(string, GraffitiColors[i], ""));
	}

	format(string, 128, "%s", strreplace(string, "(n)", "\n"));

	return string;
}

FUNX::SprayTimer(playerid, id)
{
    if(IsPlayerInRangeOfPoint(playerid, 3.0, Spray_Data[id][Xpos], Spray_Data[id][Ypos], Spray_Data[id][Zpos]))
    {
        switch(SprayingType[playerid])
        {
            case 0: // Spraying
            {
 				if(SprayAmmount[playerid] == -1)
				{
				    GameTextForPlayer(playerid, "~y~] KEEP SPRAYING ]", 3000, 5);

                    if(IsValidDynamicObject(Spray_Data[id][graffObject]))
					{
						DestroyDynamicObject(Spray_Data[id][graffObject]);

						if(!strlen(GraffitiFont[playerid])) format(Spray_Data[id][graffFont], 24, "Arial");
						else format(Spray_Data[id][graffFont], 24, "%s", GraffitiFont[playerid]);

						Spray_Data[id][graffObject] = CreateDynamicObject(19482, Spray_Data[id][Xpos], Spray_Data[id][Ypos], Spray_Data[id][Zpos], Spray_Data[id][XYpos], Spray_Data[id][YYpos], Spray_Data[id][ZYpos] + 180, -1, 0, -1, 200 );

                        ResyncGraffiti(playerid);
					}

					SprayAmmount[playerid] = 0;
				}

				SprayAmmount[playerid] ++;

				if(SprayAmmount[playerid] == SprayAmmountCH[playerid]) //replace the graffiti
				{
                    GameTextForPlayer(playerid, "~g~] SPRAYED ]", 3000, 4);

			    	ReplaceGraffiti(playerid);

			    	ResetSprayVariables(playerid);
			 		return true;
				}
				else
				{
				    /*new tempstr[256], tempstr2[256], chars;

				    format(tempstr2, 256, "%s", ReturnGraffitiText(GraffitiName[playerid]));

				    chars = strfind(tempstr2, "{", false, SprayIndex[playerid]);

				    if(chars == -1)
					{
						SprayIndex[playerid] += 1;
					}
					else
					{
						if((chars - SprayIndex[playerid]) > 0 && SprayIndex[playerid] != 0)
						{
							SprayIndex[playerid] = chars + 8;
						}
						else SprayIndex[playerid] += 1;
					}

					strmid(tempstr, tempstr2, 0, SprayIndex[playerid], 256);

					SendClientMessage(playerid, COLOR_CYAN, tempstr);*/

				    new tempstr[256], tempstr2[256];

				    format(tempstr2, 256, "%s", ReturnCleanName(GraffitiName[playerid]));

					strmid(tempstr, tempstr2, 0, SprayAmmount[playerid], 256);

				    SetDynamicObjectMaterialText(Spray_Data[id][graffObject], 0, tempstr, 130, Spray_Data[id][graffFont], 65, 1, 0xFFFFFFFF, 0, 1);

				    SetPVarString(playerid, "GraffitiName", tempstr);

                    ResyncGraffiti(playerid);
				}
			}
			case 1, 2: // Cleaning
			{
				if(SprayAmmount[playerid] == -1)
				{
				    if(!IsValidDynamicObject(Spray_Data[id][graffObject])) Spray_Data[id][graffObject] = CreateDynamicObject(19482, Spray_Data[id][Xpos], Spray_Data[id][Ypos], Spray_Data[id][Zpos], Spray_Data[id][XYpos], Spray_Data[id][YYpos], Spray_Data[id][ZYpos] + 180, -1, 0, -1, 200);

				    SetDynamicObjectMaterialText(Spray_Data[id][graffObject], 0, ReturnCleanName(Spray_Data[id][graffName]), 130, Spray_Data[id][graffFont], 65, 1, 0xFFFFFFFF, 0, 1);

				    SprayAmmount[playerid] = 0;

                    ResyncGraffiti(playerid);
				    return true;
				}

				SprayAmmount[playerid] ++;

				if(SprayAmmount[playerid] == SprayAmmountCH[playerid]) //clean the graffiti
				{
				    GameTextForPlayer(playerid, "~g~] REMOVED! ]", 2000, 3);

					RestoreGraffiti(playerid, id);

					ResetSprayVariables(playerid);

					SQL_LogGraffiti(id, "Cleared by %s", ReturnName(playerid));
			 		return true;
				}
				else
				{
				    new tempstr[256], tempstr2[256];

				    format(tempstr2, 256, "%s", ReturnCleanName(Spray_Data[id][graffName]));

					if(SprayingType[playerid] == 1)
						strmid(tempstr, tempstr2, SprayAmmount[playerid], strlen(tempstr2), 256);
					else
						strmid(tempstr, tempstr2, 0, strlen(tempstr2) - SprayAmmount[playerid], 256);

				    SetDynamicObjectMaterialText(Spray_Data[id][graffObject], 0, tempstr, 130, Spray_Data[id][graffFont], 65, 1, 0xFFFFFFFF, 0, 1);

				    SetPVarString(playerid, "GraffitiName", tempstr);

                    ResyncGraffiti(playerid);
				}

                GameTextForPlayer(playerid, "~y~] KEEP SPRAYING ]", 2000, 3);
			}
		}
	}
	else
	{
		GameTextForPlayer(playerid, "~r~Spray canceled", 5000, 5);

		ResetSprayVariables(playerid);
	}
	return true;
}

ResetSprayVariables(playerid)
{
	KillTimer(spraytimer[playerid]);
	SprayAmmount[playerid] = 0;
	SprayIndex[playerid] = 0;
	SprayAmmountCH[playerid] = 0;

	DeletePVar(playerid, "SprayID");
	DeletePVar(playerid, "GraffitiName");
	ReplacingGraffiti{playerid} = false;
}

RestoreGraffiti(playerid, id)
{
	Spray_Data[id][graffName][0] = EOS;
	Spray_Data[id][graffFont][0] = EOS;
	Spray_Data[id][graffCreator][0] = EOS;

	DestroyDynamicObject(Spray_Data[id][graffObject]);
	Spray_Data[id][graffObject] = CreateDynamicObject(Spray_Data[id][graffDefault], Spray_Data[id][Xpos], Spray_Data[id][Ypos], Spray_Data[id][Zpos], Spray_Data[id][XYpos], Spray_Data[id][YYpos], Spray_Data[id][ZYpos], -1, 0, -1, 200);

	ResyncGraffiti(playerid);

	SaveGraffiti(id);
}

ReplaceGraffiti(playerid)
{
	new id = GetPVarInt(playerid, "SprayID");

	DeletePVar(playerid, "SprayID");
	ReplacingGraffiti{playerid} = false;

	SprayAmmount[playerid] = 0;

	format(Spray_Data[id][graffName], 256, GraffitiName[playerid]);
	Spray_Data[id][graffCreator] = ReturnName(playerid);

	if(!strlen(GraffitiFont[playerid])) format(Spray_Data[id][graffFont], 24, "Arial");
	else format(Spray_Data[id][graffFont], 24, "%s", GraffitiFont[playerid]);

	if(IsValidDynamicObject(Spray_Data[id][graffObject])) DestroyDynamicObject(Spray_Data[id][graffObject]);

	CreateGraffitiObject(id);

    ResyncGraffiti(playerid);

	SaveGraffiti(id);

	SQL_LogGraffiti(id, "%s sprayed \"%s\"", ReturnName(playerid), ReturnGraffitiName(GraffitiName[playerid]));
	return true;
}

CreateGraffitiObject(id)
{
	if(strlen(Spray_Data[id][graffName]) > 0)
	{
	    Spray_Data[id][graffModel] = 19482;

		Spray_Data[id][graffObject] = CreateDynamicObject(Spray_Data[id][graffModel], Spray_Data[id][Xpos], Spray_Data[id][Ypos], Spray_Data[id][Zpos], Spray_Data[id][XYpos], Spray_Data[id][YYpos], Spray_Data[id][ZYpos] + 180, -1, 0, -1, 200);

		SetDynamicObjectMaterialText(Spray_Data[id][graffObject], 0, ReturnGraffitiText(Spray_Data[id][graffName]), 130, Spray_Data[id][graffFont], 65, 1, 0xFFFFFFFF, 0, 1);
	}
	else Spray_Data[id][graffObject] = CreateDynamicObject(Spray_Data[id][graffDefault], Spray_Data[id][Xpos], Spray_Data[id][Ypos], Spray_Data[id][Zpos], Spray_Data[id][XYpos], Spray_Data[id][YYpos], Spray_Data[id][ZYpos], -1, 0, -1, 200);
}

ResyncGraffiti(playerid)
{
	Streamer_Update(playerid, STREAMER_TYPE_OBJECT);

	foreach (new i : StreamedPlayer[playerid])
	{
	    if(i == playerid) continue;

		Streamer_Update(i, STREAMER_TYPE_OBJECT);

	    /*if(IsPlayerInRangeOfPoint(i, 30.0, Spray_Data[id][Xpos], Spray_Data[id][Ypos], Spray_Data[id][Zpos]))
	    {
	    	Streamer_Update(i, STREAMER_TYPE_OBJECT);
        }*/
	}
}

FUNX::Graffitis_Load()
{
    new rows, total, query[128];

    cache_get_row_count(rows);

    if(rows)
    {
		for(new i = 0; i < rows; ++i)
		{
			cache_get_value_name_int(i, "ID", Spray_Data[i][graffSQLID]);
			cache_get_value_name(i, "creator", Spray_Data[i][graffCreator], MAX_PLAYER_NAME + 1);
			cache_get_value_name(i, "name", Spray_Data[i][graffName], 256);
			cache_get_value_name(i, "font", Spray_Data[i][graffFont], 24);

			cache_get_value_name_int(i, "model", Spray_Data[i][graffModel]);
			cache_get_value_name_int(i, "defaultModel", Spray_Data[i][graffDefault]);

			if(Spray_Data[i][graffDefault] == -1)
			{
				new tempModel = random(sizeof(graffiti_SprayTag));

				mysql_format(dbCon, query, sizeof(query), "UPDATE `spraylocations` SET `defaultModel` = '%d' WHERE `ID` = '%d' LIMIT 1", tempModel, Spray_Data[i][graffSQLID]);
				mysql_tquery(dbCon, query);

		        Spray_Data[i][graffDefault] = tempModel;				
			}

			cache_get_value_name_float(i, "posX", Spray_Data[i][Xpos]);
			cache_get_value_name_float(i, "posY", Spray_Data[i][Ypos]);
			cache_get_value_name_float(i, "posZ", Spray_Data[i][Zpos]);
			cache_get_value_name_float(i, "rotX", Spray_Data[i][XYpos]);
			cache_get_value_name_float(i, "rotY", Spray_Data[i][YYpos]);
			cache_get_value_name_float(i, "rotZ", Spray_Data[i][ZYpos]);

			CreateGraffitiObject(i);

            total++;
		}
    }

    printf("[SERVER]: %d spray locations were loaded from \"%s\" database...", total, SQL_DATABASE);	
}

SaveGraffiti(sprayid)
{
	new longQuery[500];
	mysql_format(dbCon, longQuery, sizeof(longQuery), "UPDATE `spraylocations` SET `creator` = '%e', `name` = '%e', `posX` = '%f', `posY` = '%f', `posZ` = '%f', `rotX` = '%f', `rotY` = '%f', `rotZ` = '%f', `model` = '%d', `defaultModel` = '%d', `font` = '%e' WHERE `ID` = '%d' LIMIT 1",
	Spray_Data[sprayid][graffCreator],
	Spray_Data[sprayid][graffName],
	Spray_Data[sprayid][Xpos],
	Spray_Data[sprayid][Ypos],
	Spray_Data[sprayid][Zpos],
	Spray_Data[sprayid][XYpos],
	Spray_Data[sprayid][YYpos],
	Spray_Data[sprayid][ZYpos],
	Spray_Data[sprayid][graffModel],
	Spray_Data[sprayid][graffDefault],
	Spray_Data[sprayid][graffFont],
	Spray_Data[sprayid][graffSQLID]);
	mysql_tquery(dbCon, longQuery);
}

CreateSprayLocation(playerid, Float: x, Float: y, Float: z, Float: rx, Float: ry, Float: rz, model)
{
	new longQuery[500];
	mysql_format(dbCon, longQuery, sizeof(longQuery), "INSERT INTO spraylocations(posX, posY, posZ, rotX, rotY, rotZ, model, defaultModel) VALUES(%f, %f, %f, %f, %f, %f, %d, %d)", x, y, z, rx, ry, rz, model, model);
	mysql_tquery(dbCon, longQuery, "OnSprayLocationInsert", "iffffffi", playerid, x, y, z, rx, ry, rz, model);
}

AddSprayLocation(playerid)
{
	new	Float:X[4];
	GetPlayerPos(playerid, X[0], X[1], X[2]);
	GetPlayerFacingAngle(playerid, X[3]);

	new rdmodel = random(sizeof(graffiti_SprayTag));
	GraffiObj[playerid] = CreateDynamicObject(graffiti_SprayTag[rdmodel][0], X[0], X[1], X[2], 0.0, 0.0, X[3]+90, 0, 0, playerid, 200);
 	format(GraffitiName[playerid], 256, graffiti_SprayTag[rdmodel][1]);
	SprayAmmountCH[playerid] = strlen(graffiti_SprayTag[rdmodel][1]);
	GraffiModel[playerid] = graffiti_SprayTag[rdmodel][0];

	EditDynamicObject(playerid, GraffiObj[playerid]);

	SetPVarInt(playerid, "GraffitiCreating", 1);
}

DeleteGraffiti(sprayid)
{
	mysql_format(dbCon, gquery, sizeof(gquery), "DELETE FROM `spraylocations` WHERE `ID` = '%d' LIMIT 1", Spray_Data[sprayid][graffSQLID]);
	mysql_tquery(dbCon, gquery, "OnSprayLocationDelete", "d", sprayid);		
}

FUNX::OnSprayLocationDelete(sprayid)
{
	DestroyDynamicObject(Spray_Data[sprayid][graffObject]);

	Spray_Data[sprayid][graffSQLID] = -1;
	Spray_Data[sprayid][graffName][0] = EOS;
	Spray_Data[sprayid][graffFont][0] = EOS;
	Spray_Data[sprayid][graffCreator][0] = EOS;
	Spray_Data[sprayid][graffModel] = 0;
	Spray_Data[sprayid][graffDefault] = 0;
	Spray_Data[sprayid][Xpos] = 0.0;
	Spray_Data[sprayid][Ypos] = 0.0;
	Spray_Data[sprayid][Zpos] = 0.0;
	Spray_Data[sprayid][XYpos] = 0.0;
	Spray_Data[sprayid][YYpos] = 0.0;
	Spray_Data[sprayid][ZYpos] = 0.0;
}

FUNX::OnSprayLocationInsert(playerid, Float: x, Float: y, Float: z, Float: rx, Float: ry, Float: rz, model)
{
	new sprayid = -1;

	for(new i = 0; i < MAX_SPRAY_LOCATIONS; ++i)
	{
		if(Spray_Data[i][graffSQLID] == -1)
		{
			sprayid = i;
			break;
		}
	}

	if(sprayid == -1) return SendErrorMessage(playerid, "Failed creating the spray location. MAX_SPRAY_LOCATIONS limit (%d) has been reached.", MAX_SPRAY_LOCATIONS);

	Spray_Data[sprayid][graffSQLID] = cache_insert_id();
	Spray_Data[sprayid][Xpos] = x;
	Spray_Data[sprayid][Ypos] = y;
	Spray_Data[sprayid][Zpos] = z;
	Spray_Data[sprayid][XYpos] = rx;
	Spray_Data[sprayid][YYpos] = ry;
	Spray_Data[sprayid][ZYpos] = rz;
	Spray_Data[sprayid][graffModel] = model;
	Spray_Data[sprayid][graffDefault] = model;
	Spray_Data[sprayid][graffObject] = CreateDynamicObject(model, Spray_Data[sprayid][Xpos],Spray_Data[sprayid][Ypos],Spray_Data[sprayid][Zpos], Spray_Data[sprayid][XYpos], Spray_Data[sprayid][YYpos], Spray_Data[sprayid][ZYpos], -1, 0, -1, 200);

    SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(4): %s created spray location #%d.", ReturnName(playerid), sprayid);	
	return true;
}