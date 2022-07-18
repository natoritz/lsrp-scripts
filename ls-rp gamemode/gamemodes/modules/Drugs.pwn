//Drugs

#define MAX_DRUG_SLOT (10)
#define MAX_DRUG_HEALTH (200.0)
#define MAX_PLAYER_DRUGS (10)

enum E_PLAYER_DRUG_DATA
{
	dID,
	dType,
	dStorage,
	Float:dAmount,
	Float:dStrength,
	dStamp
}

new Player_Drugs[MAX_PLAYERS][MAX_PLAYER_DRUGS][E_PLAYER_DRUG_DATA];

enum E_VEHICLE_DRUG_DATA
{
	drug_id,
	drug_type,
	drug_storage,
	Float:drug_amount,
	Float:drug_strength,
	drug_stamp
}

new Vehicle_Drugs[MAX_VEHICLES][MAX_DRUG_SLOT][E_VEHICLE_DRUG_DATA];

new s_NAMES[][] =
{
	"Ziploc Bag - Small",
	"Ziploc Bag - Medium",
	"Ziploc Bag - Large",
	"Plastic Wrap Ball - Small",
	"Plastic Wrap Ball - Medium",
	"Plastic Wrap Ball - Large",
	"Wrapped Foil - Small",
	"Wrapped Foil - Medium",
	"Wrapped Foil - Large",
	"Pill Bottle - Small",
	"Pill Bottle - Medium",
	"Pill Bottle - Large",
	"Wax Paper Wrap - Small",
	"Wax Paper Wrap - Medium",
	"Wax Paper Wrap - Large",
	"Medicine Bottle - Small",
	"Medicine Bottle - Medium",
	"Medicine Bottle - Large"
};

enum E_DRUG_DATA
{
	dName[60],
	bool:IsPill,
	Float:decayAmount,
	decayHour
}

new d_DATA[][E_DRUG_DATA] =
{
	{"Cocaine", false, 0.30, 18},
	{"Marijuana", false, 0.10, 6},
	{"Xanax", false, 0.25, 7},
	{"MDMA", true, 0.25, 7},
	{"Heroin", false, 0.20, 17},
	{"Ketamine", false, 0.10, 6},
	{"Fentanyl", true, 0.10, 6},
	{"Methamphetamine", false, 0.20, 17},
	{"Steroids", false, 0.15, 4},
	{"Oxycodone", false, 0.15, 4}
};

new DrugHours[sizeof(d_DATA)];

Float:ReturnStorageCapacity(storageid, drug)
{
	new Float: capacity = 0.0;

	if(drug == -1)
	{
		switch(storageid)
		{
			case 0, 3, 6, 9, 12, 15: capacity = 7.0;
			case 1, 4, 7, 10, 13, 16: capacity = 14.0;
			case 2, 5, 8, 11, 14, 17: capacity = 28.0;
		}
	}
	else
	{
		if(d_DATA[drug][IsPill])
		{
			switch(storageid)
			{
				case 0, 3, 6, 9, 12, 15: capacity = 16.0;
	    		case 1, 4, 7, 10, 13, 16: capacity = 32.0;
			    case 2, 5, 8, 11, 14, 17: capacity = 50.0;
			}
		}
		else
		{
			switch(storageid)
			{
				case 0, 3, 6, 9, 12, 15: capacity = 7.0;
				case 1, 4, 7, 10, 13, 16: capacity = 14.0;
				case 2, 5, 8, 11, 14, 17: capacity = 28.0;
			}
		}
	}

	return capacity;
}

DecayDrugs()
{
	new vehicleid, stamp = gettime(), decay_protection = 1209600; // 2 weeks

	for(new i = 0; i < sizeof(d_DATA); ++i)
	{
	    DrugHours[i] ++;

	    if(d_DATA[i][decayHour] == DrugHours[i])
	    {
	        DrugHours[i] = 0;

			mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `player_drugs` SET `drugStrength` = `drugStrength` - %f WHERE `drugType` = %d AND %d - `drugStamp` >= 0 AND `drugStrength` - %f > 0", d_DATA[i][decayAmount], i, stamp, d_DATA[i][decayAmount]);
			mysql_tquery(dbCon, gquery);

			foreach (new playerid : Player)
			{
			    for(new d = 0; d < MAX_PLAYER_DRUGS; ++d)
			    {
                    if(Player_Drugs[playerid][d][dType] == i && Player_Drugs[playerid][d][dStrength] >= 0.0)
                    {
                        if((stamp - Player_Drugs[playerid][d][dStamp]) >= decay_protection)
                        {
	                        Player_Drugs[playerid][d][dStrength] -= d_DATA[i][decayAmount];

	                        if(Player_Drugs[playerid][d][dStrength] < 0.0) Player_Drugs[playerid][d][dStrength] = 0.0;

							printf("[SERVER] Decayed %.2f strength of %s from player %d (DBID: %d)", d_DATA[i][decayAmount], d_DATA[i][dName], playerid, PlayerData[playerid][pID]);
						}
                    }
			    }
			}

			mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `vehicle_drugs` SET `drugStrength` = `drugStrength` - %f WHERE `drugType` = %d AND %d - `drugStamp` >= 0 AND `drugStrength` - %f > 0", d_DATA[i][decayAmount], i, stamp, d_DATA[i][decayAmount]);
			mysql_tquery(dbCon, gquery);

			foreach (new carid : sv_playercar)
			{
				vehicleid = CarData[carid][carVehicle];

				for(new d = 0; d < MAX_PLAYER_DRUGS; ++d)
				{
	                if(Vehicle_Drugs[vehicleid][d][drug_type] == i && Vehicle_Drugs[vehicleid][d][drug_strength] >= 0.0)
	                {
	                    if((stamp - Vehicle_Drugs[vehicleid][d][drug_stamp]) >= decay_protection)
	                    {
							Vehicle_Drugs[vehicleid][d][drug_strength] -= d_DATA[i][decayAmount];

							if(Vehicle_Drugs[vehicleid][d][drug_strength] < 0.0) Vehicle_Drugs[vehicleid][d][drug_strength] = 0.0;

							printf("[SERVER] Decayed %.2f strength of %s from vehicle %d (DBID: %d)", d_DATA[i][decayAmount], d_DATA[i][dName], vehicleid, CarData[carid][carID]);
						}
				    }
				}
			}
	    }
	}
}

ShowPlayerDrugs(playerid, toplayer)
{
    SendClientMessageEx(toplayer, COLOR_LIGHTRED, "%s's Drugs:", ReturnName(playerid, 0));

    new
		count
	;

	for(new d = 0; d < MAX_PLAYER_DRUGS; ++d)
	{
		if(Player_Drugs[playerid][d][dID] != -1)
		{
			SendClientMessageEx(toplayer, -1, "{FF6347}[ {FFFFFF}%d. %s (%s: %.1f%s / %.1f%s) (Strength: %.0f) {FF6347}]",
			d + 1, s_NAMES[ Player_Drugs[playerid][d][dStorage] ], d_DATA[ Player_Drugs[playerid][d][dType] ][dName], Player_Drugs[playerid][d][dAmount], (d_DATA[ Player_Drugs[playerid][d][dType] ][IsPill] == true) ? (" Pills") : ("g"), ReturnStorageCapacity(Player_Drugs[playerid][d][dStorage], Player_Drugs[playerid][d][dType]), (d_DATA[ Player_Drugs[playerid][d][dType] ][IsPill] == true) ? (" Pills") : ("g"), Player_Drugs[playerid][d][dStrength]);

			count++;
		}
	}

	if(!count) SendClientMessage(toplayer, COLOR_WHITE, "No drugs to show.");

	return true;
}

InsertVehicleDrug(vehicleid, drug, Float:amount, Float:strength, storage, stamp = -1)
{
	new package = -1;

	for(new i = 0; i < MAX_DRUG_SLOT; ++i)
	{
	    if(Vehicle_Drugs[vehicleid][i][drug_id] == -1)
	    {
	        package = i;
	        break;
		}
	}

	if(package == -1) return false;

	if(stamp < 0) stamp = gettime();

    Vehicle_Drugs[vehicleid][package][drug_id] = 500;
	Vehicle_Drugs[vehicleid][package][drug_type] = drug;
	Vehicle_Drugs[vehicleid][package][drug_storage] = storage;
	Vehicle_Drugs[vehicleid][package][drug_amount] = amount;
	Vehicle_Drugs[vehicleid][package][drug_strength] = strength;
	Vehicle_Drugs[vehicleid][package][drug_stamp] = stamp;

	format(gquery, sizeof(gquery), "INSERT INTO vehicle_drugs (drugType, drugAmount, drugStrength, drugStorage, drugStamp, vehicle) VALUES(%i, %f, %f, %i, %i, %i)", drug, amount, strength, storage, stamp, CarData[ Car_GetID(vehicleid) ][carID]);
	mysql_tquery(dbCon, gquery, "OnVehicleDrugRefund", "ii", vehicleid, package);
	return true;
}

FUNX::OnVehicleDrugRefund(vehicleid, package)
{
    Vehicle_Drugs[vehicleid][package][drug_id] = cache_insert_id();
}

RefundPlayerDrug(playerid, drug, Float:amount, Float:strength, storage, stamp = -1)
{
	new package = -1;

	for(new i = 0; i < MAX_PLAYER_DRUGS; ++i)
	{
	    if(Player_Drugs[playerid][i][dID] == -1)
	    {
	        package = i;
	        break;
		}
	}

	if(package == -1) return false;

	if(stamp < 0) stamp = gettime();

    Player_Drugs[playerid][package][dID] = 500;
	Player_Drugs[playerid][package][dType] = drug;
	Player_Drugs[playerid][package][dStorage] = storage;
	Player_Drugs[playerid][package][dAmount] = amount;
	Player_Drugs[playerid][package][dStrength] = strength;
	Player_Drugs[playerid][package][dStamp] = stamp;

	mysql_format(dbCon, gquery, sizeof(gquery), "INSERT INTO player_drugs (drugType, drugAmount, drugStrength, drugStorage, drugStamp, PlayerSQLID) VALUES(%i, %f, %f, %i, %i, %i)", drug, amount, strength, storage, stamp, PlayerData[playerid][pID]);
	mysql_tquery(dbCon, gquery, "OnPlayerDrugRefund", "ii", playerid, package);
	return true;
}

FUNX::OnPlayerDrugRefund(playerid, package)
{
    Player_Drugs[playerid][package][dID] = cache_insert_id();
}

RemovePlayerDrug(playerid, package)
{
	new drugSQLID = Player_Drugs[playerid][package][dID];

	Player_Drugs[playerid][package][dID] = -1;
	Player_Drugs[playerid][package][dType] = -1;
	Player_Drugs[playerid][package][dStorage] = -1;
	Player_Drugs[playerid][package][dAmount] = 0.0;
	Player_Drugs[playerid][package][dStrength] = 0.0;
    Player_Drugs[playerid][package][dStamp] = 0;

	format(gquery, sizeof(gquery), "DELETE FROM `player_drugs` WHERE `idx` = '%i' LIMIT 1", drugSQLID);
	mysql_tquery(dbCon, gquery);
}

RemoveVehicleDrug(vehicleid, package)
{
	new drugSQLID = Vehicle_Drugs[vehicleid][package][drug_id];

	Vehicle_Drugs[vehicleid][package][drug_id] = -1;
	Vehicle_Drugs[vehicleid][package][drug_type] = -1;
	Vehicle_Drugs[vehicleid][package][drug_storage] = -1;
	Vehicle_Drugs[vehicleid][package][drug_amount] = 0.0;
	Vehicle_Drugs[vehicleid][package][drug_strength] = 0.0;
	Vehicle_Drugs[vehicleid][package][drug_stamp] = 0;

	format(gquery, sizeof(gquery), "DELETE FROM `vehicle_drugs` WHERE `idx` = '%i' LIMIT 1", drugSQLID);
	mysql_tquery(dbCon, gquery);
}

ResetVehicleDrugs(vehicleid)
{
	for(new d; d < MAX_DRUG_SLOT; ++d)
	{
		Vehicle_Drugs[vehicleid][d][drug_id] = -1;
		Vehicle_Drugs[vehicleid][d][drug_type] = -1;
		Vehicle_Drugs[vehicleid][d][drug_storage] = -1;
		Vehicle_Drugs[vehicleid][d][drug_amount] = 0.0;
		Vehicle_Drugs[vehicleid][d][drug_strength] = 0.0;
		Vehicle_Drugs[vehicleid][d][drug_stamp] = 0;
	}
}

FUNX::Query_LoadDrugs(vehicleid)
{
	new x = cache_num_rows();

	for(new i = 0; i < 10; ++i)
	{
		Vehicle_Drugs[vehicleid][i][drug_id] = -1;
		Vehicle_Drugs[vehicleid][i][drug_type] = -1;
		Vehicle_Drugs[vehicleid][i][drug_storage] = -1;
		Vehicle_Drugs[vehicleid][i][drug_amount] = 0.0;
		Vehicle_Drugs[vehicleid][i][drug_strength] = 0.0;
		Vehicle_Drugs[vehicleid][i][drug_stamp] = 0;
	}

	for(new i = 0; i < MAX_DRUG_SLOT; ++i)
	{
	    if(i < x)
	    {
			cache_get_value_name_int(i, "idx", Vehicle_Drugs[vehicleid][i][drug_id]);
			cache_get_value_name_int(i, "drugType", Vehicle_Drugs[vehicleid][i][drug_type]);
			cache_get_value_name_int(i, "drugStorage", Vehicle_Drugs[vehicleid][i][drug_storage]);
			cache_get_value_name_float(i, "drugAmount", Vehicle_Drugs[vehicleid][i][drug_amount]);
			cache_get_value_name_float(i, "drugStrength", Vehicle_Drugs[vehicleid][i][drug_strength]);
			cache_get_value_name_int(i, "drugStamp", Vehicle_Drugs[vehicleid][i][drug_stamp]);
		}
		else
		{
			Vehicle_Drugs[vehicleid][i][drug_id] = -1;
			Vehicle_Drugs[vehicleid][i][drug_type] = -1;
			Vehicle_Drugs[vehicleid][i][drug_storage] = -1;
			Vehicle_Drugs[vehicleid][i][drug_amount] = 0.0;
			Vehicle_Drugs[vehicleid][i][drug_strength] = 0.0;
			Vehicle_Drugs[vehicleid][i][drug_stamp] = 0;
		}
	}
}

LoadVehicleDrugs(carid)
{
	new query[128];
	mysql_format(dbCon, query, sizeof(query), "SELECT * FROM `vehicle_drugs` WHERE `vehicle` = '%d' LIMIT %d", CarData[carid][carID], MAX_DRUG_SLOT);
	return mysql_tquery(dbCon, query, "Query_LoadDrugs", "d", CarData[carid][carVehicle]);	
}

// Dialogs

Dialog:Drug_Menu(playerid, response, listitem, inputtext[])
{
	if(!response) return true;

	new package = GetPVarInt(playerid, "d_TransferPackage"), body[500];

	SetPVarInt(playerid, "d_TransferMenu", listitem);

	format(body, sizeof(body), "{A9C4E4}Your package, {7E98B6}%s{A9C4E4}, contains {7E98B6}%.2f{A9C4E4} of{7E98B6} %s{A9C4E4}.\n{A9C4E4}Enter the amount you want to transfer:",
	s_NAMES[ Player_Drugs[playerid][package][dStorage] ], Player_Drugs[playerid][package][dAmount], d_DATA[ Player_Drugs[playerid][package][dType] ][dName]);

	Dialog_Show(playerid, Drug_Amount, DIALOG_STYLE_INPUT, "Drug Transfer, Amount:", body, "Enter", "Go back");
	return true;
}

Dialog:Drug_Amount(playerid, response, listitem, inputtext[])
{
	if(!response) return Dialog_Show(playerid, Drug_Menu, DIALOG_STYLE_LIST, "Drug Transfer:", "{A9C4E4}Transfer to a new package\n{A9C4E4}Transfer to an existing package", "Select", "Exit");

	new package = GetPVarInt(playerid, "d_TransferPackage"), body[1000];

	format(body, sizeof(body), "{A9C4E4}Your package, {7E98B6}%s{A9C4E4}, contains {7E98B6}%.2f{A9C4E4} of{7E98B6} %s{A9C4E4}.\n{A9C4E4}Enter the amount you want to transfer:",
	s_NAMES[ Player_Drugs[playerid][package][dStorage] ], Player_Drugs[playerid][package][dAmount], d_DATA[ Player_Drugs[playerid][package][dType] ][dName]);

    new Float:amount;

	if(sscanf(inputtext, "f", amount))
	{
		strcat(body, "\n{FF0000}float value only");
		return Dialog_Show(playerid, Drug_Amount, DIALOG_STYLE_INPUT, "Drug Transfer, Amount:", body, "Enter", "Go back");
	}

	if(amount < 0.1)
	{
		strcat(body, "\n{FF0000}Invalid amount entered. Has to be more than 0.0.");
		return Dialog_Show(playerid, Drug_Amount, DIALOG_STYLE_INPUT, "Drug Transfer, Amount:", body, "Enter", "Go back");
	}

	if(amount > Player_Drugs[playerid][package][dAmount])
	{
		strcat(body, "\n{FF0000}You don't have that amount in that package!");
		return Dialog_Show(playerid, Drug_Amount, DIALOG_STYLE_INPUT, "Drug Transfer, Amount:", body, "Enter", "Go back");
	}

	new transfer_menu = GetPVarInt(playerid, "d_TransferMenu");

	SetPVarFloat(playerid, "d_TransferAmount", amount);

	switch(transfer_menu)
	{
		case 0:
		{
			format(body, sizeof(body), "#\tStorage Name\n");

			for(new i = 0; i < sizeof(s_NAMES); ++i)
			{
			        format(body, sizeof(body), "%s%d\t%s (Capacity: %.1f%s)\n", body, i, s_NAMES[i], ReturnStorageCapacity(i, -1), (d_DATA[ Player_Drugs[playerid][package][dType] ][IsPill] == true) ? (" Pills") : ("g"));
			}

			Dialog_Show(playerid, Drug_Transfer, DIALOG_STYLE_TABLIST_HEADERS, "Drug Transfer, Select Storage:", body, "Select", "Go back");
		}
		case 1:
		{
			body[0] = EOS;

			format(body, sizeof(body), "#\tPackage Content\n");

			new count = 0;

			for(new i = 0; i < MAX_PLAYER_DRUGS; ++i)
			{
			    if(i != package && (Player_Drugs[playerid][i][dType] == Player_Drugs[playerid][package][dType] && Player_Drugs[playerid][i][dAmount] + Player_Drugs[playerid][package][dAmount] < ReturnStorageCapacity(i, -1)))
			    {
			        count++;

			        format(body, sizeof(body), "%s%d\t%s (%s: %.1f%s / %.1f%s) (Strength: %.0f)\n",
						body,
						i,
						s_NAMES[ Player_Drugs[playerid][i][dStorage] ],
						d_DATA[ Player_Drugs[playerid][i][dType] ][dName],
						Player_Drugs[playerid][i][dAmount],
						(d_DATA[ Player_Drugs[playerid][i][dType] ][IsPill] == true) ? (" Pills") : ("g"),
						ReturnStorageCapacity(Player_Drugs[playerid][i][dStorage], -1),
						(d_DATA[ Player_Drugs[playerid][i][dType] ][IsPill] == true) ? (" Pills") : ("g"),
						Player_Drugs[playerid][i][dStrength]
					);
			    }
			}

			if(count == 0)
			{
				format(body, sizeof(body), "{A9C4E4}Your package, {7E98B6}%s{A9C4E4}, contains {7E98B6}%.2f{A9C4E4} of{7E98B6} %s{A9C4E4}.\n{A9C4E4}Enter the amount you want to transfer:\n{FF0000}Couldn't find any compatible packages for that amount.",
				s_NAMES[ Player_Drugs[playerid][package][dStorage] ], Player_Drugs[playerid][package][dAmount], d_DATA[ Player_Drugs[playerid][package][dType] ][dName]);

				return Dialog_Show(playerid, Drug_Amount, DIALOG_STYLE_INPUT, "Drug Transfer, Amount:", body, "Enter", "Go back");
			}

			Dialog_Show(playerid, Drug_Transfer, DIALOG_STYLE_TABLIST_HEADERS, "Drug Transfer, Select Package:", body, "Select", "Go back");
		}
	}
	return true;
}

Dialog:Drug_Transfer(playerid, response, listitem, inputtext[])
{
	new package = GetPVarInt(playerid, "d_TransferPackage"), body[400];

	if(!response)
	{
		format(body, sizeof(body), "{A9C4E4}Your package, {7E98B6}%s{A9C4E4}, contains {7E98B6}%.2f{A9C4E4} of{7E98B6} %s{A9C4E4}.\n{A9C4E4}Enter the amount you want to transfer:",
		s_NAMES[ Player_Drugs[playerid][package][dStorage] ], Player_Drugs[playerid][package][dAmount], d_DATA[ Player_Drugs[playerid][package][dType] ][dName]);

		return Dialog_Show(playerid, Drug_Amount, DIALOG_STYLE_INPUT, "Drug Transfer, Amount:", body, "Enter", "Go back");
	}

	new
		Float:amount = GetPVarFloat(playerid, "d_TransferAmount"),
		transfer_menu = GetPVarInt(playerid, "d_TransferMenu")
	;

	switch(transfer_menu)
	{
		case 0:
		{
			SendClientMessageEx(playerid, COLOR_YELLOW, "You've transferred %.1fg of %s into a %s.", amount, d_DATA[ Player_Drugs[playerid][package][dType] ][dName], s_NAMES[listitem]);

			RefundPlayerDrug(playerid, Player_Drugs[playerid][package][dType], Float:amount, Player_Drugs[playerid][package][dStrength], listitem);

			Player_Drugs[playerid][package][dAmount] -= amount;

			if(Player_Drugs[playerid][package][dAmount] < 0.1)
			{
			    RemovePlayerDrug(playerid, package);
			}
			else
			{
				format(gquery, sizeof(gquery), "UPDATE `player_drugs` SET `drugAmount` = '%f' WHERE `idx` = '%i' LIMIT 1", Player_Drugs[playerid][package][dAmount], Player_Drugs[playerid][package][dID]);
				mysql_tquery(dbCon, gquery);
			}
		}
		case 1:
		{
			TransferDrugIntoExistingZiploc(playerid, package, strval(inputtext), amount);
		}
	}
	return true;
}

TransferDrugIntoExistingZiploc(playerid, package, idx, Float: amount)
{
	new Float: difference;

	if(Player_Drugs[playerid][idx][dStrength] > Player_Drugs[playerid][package][dStrength])
	{
		difference = Player_Drugs[playerid][idx][dStrength] - Player_Drugs[playerid][package][dStrength];
	}
	else
	{
		difference = Player_Drugs[playerid][package][dStrength] - Player_Drugs[playerid][idx][dStrength];
	}

	if(difference >= 10)
	{
		Player_Drugs[playerid][idx][dStrength] = (Player_Drugs[playerid][idx][dStrength] / 2) + (Player_Drugs[playerid][package][dStrength] / 2);
	}

    SendClientMessageEx(playerid, COLOR_YELLOW, "You've transferred %.1fg of %s into an existing %s.", amount, d_DATA[ Player_Drugs[playerid][package][dType] ][dName], s_NAMES[ Player_Drugs[playerid][idx][dStorage] ]);

	Player_Drugs[playerid][idx][dAmount] += amount;
	Player_Drugs[playerid][package][dAmount] -= amount;

	format(gquery, sizeof(gquery), "UPDATE `player_drugs` SET `drugAmount` = '%f' WHERE `idx` = '%i'", Player_Drugs[playerid][idx][dAmount], Player_Drugs[playerid][idx][dID]);
	mysql_tquery(dbCon, gquery);

	if(Player_Drugs[playerid][package][dAmount] < 0.1)
	{
		 RemovePlayerDrug(playerid, package);
	}
	else
	{
		format(gquery, sizeof(gquery), "UPDATE `player_drugs` SET `drugAmount` = '%f' WHERE `idx` = '%i' LIMIT 1", Player_Drugs[playerid][package][dAmount], Player_Drugs[playerid][package][dID]);
		mysql_tquery(dbCon, gquery);
	}
	return true;
}

Dialog:Drug_RefundType(playerid, response, listitem, inputtext[])
{
	if(!response) return true;

	SetPVarInt(playerid, "d_RefundDrug", listitem);

	gstr[0] = EOS;

	for(new d = 0; d < sizeof(s_NAMES); ++d)
	{
		strcat(gstr, s_NAMES[d]);
		strcat(gstr, "\n");
	}

	Dialog_Show(playerid, Drug_RefundStorage, DIALOG_STYLE_LIST, "Drug Refund, Select Storage:", gstr, "Next", "Cancel");
	return true;
}

Dialog:Drug_RefundStorage(playerid, response, listitem, inputtext[])
{
	if(!response) return true;

	SetPVarInt(playerid, "d_RefundStorage", listitem);

	new
		body[300],
		userid = GetPVarInt(playerid, "d_RefundPlayer"),
		drug = GetPVarInt(playerid, "d_RefundDrug")
	;

	format(body, sizeof(body), "{A9C4E4}You are about to refund {7E98B6}%s{A9C4E4} a {7E98B6}%s{A9C4E4} containing {7E98B6}%s\n{A9C4E4}Please write the amount you wish to refund:", ReturnName(userid, 0), s_NAMES[listitem], d_DATA[drug][dName]);
	Dialog_Show(playerid, Drug_RefundAmount, DIALOG_STYLE_INPUT, "Drug Refund, Input amount:", body, "Refund", "Cancel");	
	return true;
}

Dialog:Drug_RefundAmount(playerid, response, listitem, inputtext[])
{
	if(!response) return true;

	new
		userid = GetPVarInt(playerid, "d_RefundPlayer"),
		storage = GetPVarInt(playerid, "d_RefundStorage"),
		drug = GetPVarInt(playerid, "d_RefundDrug")
	;

	if(!IsPlayerConnected(userid))
		return SendErrorMessage(playerid, "The player has logged off.");

	if(!SQL_IsLogged(userid))
		return SendErrorMessage(playerid, "The player is not authenticated.");	

	new Float:amount, body[500];

	format(body, sizeof(body), "{A9C4E4}You are about to refund {7E98B6}%s{A9C4E4} a {7E98B6}%s{A9C4E4} containing {7E98B6}%s\n{A9C4E4}Please write the amount you wish to refund:", ReturnName(userid, 0), s_NAMES[storage], d_DATA[drug][dName]);

	if(sscanf(inputtext, "f", amount))
	{
		strcat(body, "\n{FF0000}float value only");
		return Dialog_Show(playerid, Drug_RefundAmount, DIALOG_STYLE_INPUT, "Drug Refund, Input an amount:", body, "Refund", "Cancel");
	}

	if(amount < 0.1)
	{
		strcat(body, "\n{FF0000}Invalid amount entered. Has to be more than 0.0.");
		return Dialog_Show(playerid, Drug_RefundAmount, DIALOG_STYLE_INPUT, "Drug Refund, Input an amount:", body, "Refund", "Cancel");
	}

	if(amount > ReturnStorageCapacity(storage, -1))
	{
		format(body, sizeof(body), "%s\n{FF0000}Invalid amount entered. Has to be less than %.1f.", body, ReturnStorageCapacity(storage, -1));
		return Dialog_Show(playerid, Drug_RefundAmount, DIALOG_STYLE_INPUT, "Drug Transfer, Amount:", body, "Enter", "Go back");
	}

	new idx = -1;

	for(new i = 0; i < MAX_PLAYER_DRUGS; ++i)
	{
		if(Player_Drugs[userid][i][dID] == -1)
		{
			idx = i;
			break;
		}
	}

	if(idx == -1) return SendErrorMessage(playerid, "Player does not have more space for drugs.");

	SendNoticeMessage(userid, "%s (%s) was refunded to you with %.2f amount and 100 strength.", d_DATA[drug][dName], s_NAMES[storage], amount);
	SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmCmd: %s refuded %s with %.2f amount of %s.", ReturnName(playerid), ReturnName(userid), amount, d_DATA[drug][dName]);
	SQL_LogAction(userid, "AdmCmd: %s refuded %s with %.2f amount of %s.", ReturnName(playerid), ReturnName(userid), amount, d_DATA[drug][dName]);

	RefundPlayerDrug(userid, drug, amount, 100.0, storage);
	return true;
}