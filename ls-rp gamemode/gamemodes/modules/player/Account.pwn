// Defines

#define THREAD_FIND_ACCOUNT 	(1)
#define	THREAD_BAN_LOOKUP		(2)
#define THREAD_LOGIN 			(3)
#define THREAD_LOAD_CHARACTER 	(4)
#define THREAD_LOG_CON			(5)
#define THREAD_PLAYER_CONTACTS	(6)
#define THREAD_PLAYER_SMS		(7)
#define THREAD_PLAYER_CLOTHING	(8)
#define THREAD_SECRET_CONFIRM	(9)
#define THREAD_CHECK_CHARACTER 		(10)
#define THREAD_PLAYER_HOLDWEAPON	(11)
#define THREAD_PLAYER_RADIO         (12)
#define THREAD_CREATE_CHARACTER     (13)
#define THREAD_PLAYER_DRUGS         (14)
#define THREAD_PLAYER_FRIENDS       (15)
#define THREAD_ADMIN_ACTIONS        (16)
#define THREAD_JOIN_ALERTS          (17)
#define THREAD_PLAYER_DAMAGES       (18)

// Variables

enum E_ACCOUNT_DATA
{
	aConnectionID,
	aUserid,
	aUsername[MAX_PLAYER_NAME],
	aEmail[MAX_PLAYER_NAME],
	aSecretWord[MAX_PLAYER_NAME],
	aCombinedLevel[2]
};

new AccountData[MAX_PLAYERS][E_ACCOUNT_DATA];

// Functions

UpdateLastLoginData(extraid)
{
	new query[128];
	format(query, sizeof(query), "UPDATE `characters` SET `Online` = 1, `LastLogin` = '%d', `LastIP` = '%s' WHERE `ID` = '%d' LIMIT 1", gettime(), PlayerData[extraid][pIP], PlayerData[extraid][pID]);
	return mysql_tquery(dbCon, query);
}

forward OnQueryFinished(extraid, threadid);
public OnQueryFinished(extraid, threadid)
{
	if(!IsPlayerConnected(extraid))
	    return false;

	static rows, query[180];

	switch(threadid)
	{
		case THREAD_FIND_ACCOUNT:
		{
   			cache_get_row_count(rows);

			if(rows)
			{
			    new str[MAX_PLAYER_NAME];

			    cache_get_value_name_int(0, "ID", AccountData[extraid][aUserid]);

				cache_get_value_name(0, "Username", str);
				format(AccountData[extraid][aUsername], MAX_PLAYER_NAME, str);

				cache_get_value_name_int(0, "Admin", PlayerData[extraid][pAdmin]);

				cache_get_value_name(0, "Email", str);
				format(AccountData[extraid][aEmail], MAX_PLAYER_NAME, str);

    			cache_get_value_name(0, "SecretWord", str);
    			format(AccountData[extraid][aSecretWord], MAX_PLAYER_NAME, str);

				cache_get_value_name_int(0, "LoginDate", LastLogin[extraid]);

				cache_get_value_name(0, "AdminNote", PlayerData[extraid][AdminNote], 256);
				cache_get_value_name(0, "Serial", LastSerial[extraid], 128);

				AccountChecked{extraid} = true;
			}
		    else
		    {
		        TogglePlayerSpectating(extraid, true);
				RandomLoginScreen(extraid);

		 		SendErrorMessage(extraid, "%s is not a valid account name.", ReturnNameEx(extraid));

		 		SendNoticeMessage(extraid, "Make sure you're using your (main) account name, not a character name to log in!");
			  	SendNoticeMessage(extraid, "To create an account, please visit https://legacy-rp.net/"), KickEx(extraid);
			}
  		}
		case THREAD_BAN_LOOKUP:
		{
		    cache_get_row_count(rows);

		    if(rows)
			{
			    new
			        reason[64],
					date[36],
					username[24],
					banner[24]
				;

          		cache_get_value_name(0, "name", username);
          		cache_get_value_name(0, "bannedby", banner);
		        cache_get_value_name(0, "date", date);
				cache_get_value_name(0, "reason", reason);

				if(!strcmp(username, "null", true) || !username[0])
				{
					SendErrorMessage(extraid, "Your IP Address is banned!");

					SendNoticeMessage(extraid, "Please create a ban appeal at forum.legacy-rp.net before playing again.");
				}
				else
				{
					SendErrorMessage(extraid, "One or more of your characters is banned!");

					SendNoticeMessage(extraid, "Please create a ban appeal at forum.legacy-rp.net before playing again.");
				}

				SendNoticeMessage(extraid, "Please create a ban apeal at forum.legacy-rp.net");

				KickEx(extraid);
		    }
		    else
			{
			    SafeTime[extraid] = 60;

		        Dialog_Show(extraid, LoginScreen, DIALOG_STYLE_PASSWORD, "Welcome to Legacy Roleplay", "Hello,\n\nPlease enter your password below to access character selection.\n\nIf you are not currently registered with Legacy-RP, you can create\n\nyour account at legacy-rp.net.", "Submit", "Exit");
			}
		}
     	case THREAD_LOGIN:
   		{
    	    cache_get_row_count(rows);

    	    if(!rows)
    	    {
				LoginAttempts[extraid]--;

				if(LoginAttempts[extraid] == 0)
				{
					SendClientMessage(extraid, COLOR_LIGHTRED, "[SERVER]: You were kicked for bad password attempts.");
					return KickEx(extraid);
				}

				new
				    str[256]
				;

				format(str, sizeof(str), "Hello,\n\nPlease enter your password below to access character selection.\n\nIf you are not currently registered with Legacy-RP, you can create\n\nyour account at legacy-rp.net.\n\n\n{FF0000}Attempts remaining: %d", LoginAttempts[extraid]);
				return Dialog_Show(extraid, LoginScreen, DIALOG_STYLE_PASSWORD, "Welcome to Legacy Roleplay", str, "Submit", "Exit");
			}
			else
			{
                /*if(LastLogin[extraid] != 0 && (gettime() - LastLogin[extraid]) >= 1209600) // 14 days or 2 weeks
                {
					new email[64], str[64], end, len;

					format(email, 64, "%.1s", AccountData[extraid][aEmail]);

					end = strfind(AccountData[extraid][aEmail], "@", true) - 1;

					if(end == -1) // Invalid Email Address
					{
						SendClientMessage(extraid, COLOR_YELLOW, "It seems you have specified an invalid email address for your account.");
						SendClientMessage(extraid, COLOR_YELLOW, "Update it using the UCP (legacy-rp.net) and then try log back in.");
						return KickEx(extraid);
					}

					strmid(str, AccountData[extraid][aEmail], 1, end);

					len = strlen(str);

					for(new i = 0; i < len; ++i) strcat(email, "*");

					format(email, 64, "%s%s", email, AccountData[extraid][aEmail][end]);

					SendClientMessage(extraid, COLOR_YELLOW, "Two Factor Authentication");
					SendClientMessage(extraid, COLOR_YELLOW, "  You haven't played in a while! For security measures, we need to verify your account before you can play.");
					SendClientMessageEx(extraid, COLOR_YELLOW, "  An email was sent to %s with instructions on how to verify your account.", email);
					SendClientMessage(extraid, COLOR_YELLOW, "  This should take up to two minutes. Make sure to check your spam folder.");

					//format(query,sizeof(query),"ip=%s&time=%d&id=%d&username=%s", PlayerData[extraid][pIP], gettime(), PlayerData[extraid][pID], AccountData[extraid][aUsername]);
				    //HTTP(extraid, HTTP_POST, "localhost/verify_email.php", query, "HttpVerifyRequest");
				}*/

				if(isnull(AccountData[extraid][aSecretWord]))
				{
			 		Dialog_Show(extraid, AddSecretWord, DIALOG_STYLE_PASSWORD,
						"Welcome to Legacy Roleplay",
						"{FFFFFF}SECURITY PRECAUTION:\n\nWe have introduced a SECRET CONFIRMATION CODE, this is basically a secret word that you will be presented with if any connection conditions changes.\n\n\
						You have not yet filled this out, so please take your time and fill in a secret word you {FF0000}will have to remember.\n\n{FFFFFF}IT IS ADVICED THAT THIS IS NOT YOUR PASSWORD!",
						"Enter", "Cancel"
					);
				}
				else
				{
					if(strcmp(LastSerial[extraid], PlayerSerial[extraid], false) != 0)
					{
				 		Dialog_Show(extraid, SecretWord, DIALOG_STYLE_PASSWORD, "Welcome to Legacy Roleplay", "{FF0000}POSSIBLE SECURITY BREACH\n\n{FFFFFF}The server has flagged you as possibly not being this account's owner, please write the secret word of this account in the box below to confirm it is yours.", "Enter", "Cancel");
					}
					else
					{
						format(query, sizeof(query), "UPDATE `accounts` SET `Online` = 1, `LoginDate` = '%d', `LastIP` = '%s', `Serial` = '%s' WHERE `ID` = '%d' LIMIT 1", gettime(), PlayerData[extraid][pIP], PlayerSerial[extraid], AccountData[extraid][aUserid]), mysql_pquery(dbCon, query);

	                    SQL_LoadCharacters(extraid);
					}
				}
			}
		}
		case THREAD_LOAD_CHARACTER:
		{
		    //, active;

			cache_get_row_count(rows);

			if(rows)
			{
				new str[128], playerName[24];
			    cache_get_value_name(0, "char_name", playerName);

			    SetPlayerName(extraid, playerName);

			    PlayerData[extraid][pID] = CharacterCache[extraid][ SelectedCharacter[extraid] ];

				cache_get_value_name_int(0, "Tutorial", PlayerData[extraid][pTutorial]);
				cache_get_value_name_int(0, "Model", PlayerData[extraid][pModel]);
				cache_get_value_name_int(0, "ContractTime", PlayerData[extraid][pContractTime]);

				cache_get_value_name_int(0, "PhoneNumbr", PlayerData[extraid][pPnumber]);
				cache_get_value_name_int(0, "PhoneModel", PlayerData[extraid][pPhoneModel]);
				cache_get_value_name_int(0, "PhoneSilent", ph_silentmode[extraid]);
				cache_get_value_name_int(0, "PhoneAir", ph_airmode[extraid]);
				cache_get_value_name_int(0, "PhoneRingtone", ph_CallTone[extraid]);
				cache_get_value_name_int(0, "PhoneTextRingtone", ph_TextTone[extraid]);

				cache_get_value_name_float(0, "PosX", PlayerData[extraid][pPos][0]);
				cache_get_value_name_float(0, "PosY", PlayerData[extraid][pPos][1]);
				cache_get_value_name_float(0, "PosZ", PlayerData[extraid][pPos][2]);
				cache_get_value_name_float(0, "PosA", PlayerData[extraid][pPos][3]);
				cache_get_value_name_float(0, "SpawnHealth", PlayerData[extraid][pSHealth]);
				cache_get_value_name_int(0, "Interior", PlayerData[extraid][pInterior]);
				cache_get_value_name_int(0, "World", PlayerData[extraid][pWorld]);

				cache_get_value_name_int(0, "Faction", PlayerData[extraid][pFactionID]);
				cache_get_value_name_int(0, "FactionRank", PlayerData[extraid][pFactionRank]);
				cache_get_value_name_int(0, "FactionSpawn", PlayerData[extraid][pFactionSpawn]);

				cache_get_value_name_int(0, "Injured", PlayerData[extraid][pInjured]);
				cache_get_value_name_int(0, "playerTimeout", PlayerData[extraid][pTimeout]);
				cache_get_value_name_int(0, "SpawnPoint", PlayerData[extraid][pSpawnPoint]);
				cache_get_value_name_int(0, "PlayingSeconds", PlayerData[extraid][pPlayingSeconds]);
				cache_get_value_name_int(0, "Level", PlayerData[extraid][pLevel]);

				AccountData[extraid][aCombinedLevel][1] -= PlayerData[extraid][pLevel];

				cache_get_value_name_int(0, "Exp", PlayerData[extraid][pExp]);
				cache_get_value_name_int(0, "ExpCounter", PlayerData[extraid][pExpCounter]);
				cache_get_value_name_int(0, "DonateRank", PlayerData[extraid][pDonateRank]);

				if(PlayerData[extraid][pDonateRank])
				{
					cache_get_value_name_int(0, "DonateExpired", PlayerData[extraid][pDonateUnix]);

					if(gettime() >= PlayerData[extraid][pDonateUnix])
					{
						PlayerData[extraid][pDonateRank] = 0;
						PlayerData[extraid][pDonateUnix] = 0;
					}
				}

				cache_get_value_name_int(0, "PayDay", PlayerData[extraid][pPayDay]);
				cache_get_value_name_int(0, "PayDayHad", PlayerData[extraid][pPayDayHad]);
				cache_get_value_name_int(0, "PayCheck", PlayerData[extraid][pPayCheck]);
				cache_get_value_name_int(0, "ChequeCash", PlayerData[extraid][pChequeCash]);
				cache_get_value_name_int(0, "BankAccount", PlayerData[extraid][pAccount]);
				cache_get_value_name_int(0, "Cash", PlayerData[extraid][pCash]);
				cache_get_value_name_int(0, "Savings", PlayerData[extraid][pSavings]);
				cache_get_value_name_int(0, "SavingsCollect", PlayerData[extraid][pSavingsCollect]);
				cache_get_value_name_int(0, "playerJob", PlayerData[extraid][pJob]);
	            cache_get_value_name_int(0, "playerSideJob", PlayerData[extraid][pSideJob]);
				cache_get_value_name_int(0, "playerJobRank", PlayerData[extraid][pJobRank]);
	            cache_get_value_name_int(0, "playerCareer", PlayerData[extraid][pCareer]);
	            cache_get_value_name_int(0, "playerHouseKey", PlayerData[extraid][pHouseKey]);
				cache_get_value_name_int(0, "playerComplexKey", PlayerData[extraid][pComplexKey]);
	            cache_get_value_name(0, "Attribute", PlayerData[extraid][pAttribute]);

	            cache_get_value_name(0, "PackageWeapons", str);
	            AssignPlayerWeapons(extraid, str);

	            cache_get_value_name_int(0, "Jailed", PlayerData[extraid][pJailed]);
	            cache_get_value_name_int(0, "SentenceTime", PlayerData[extraid][pSentenceTime]);
	            cache_get_value_name_int(0, "PrisonTimes", PlayerData[extraid][pPrisonTimes]);
	            cache_get_value_name_int(0, "JailTimes", PlayerData[extraid][pJailTimes]);
	            cache_get_value_name_int(0, "ActiveListings", PlayerData[extraid][pActiveListings]);

				new masked;
	            cache_get_value_name_int(0, "Masked", masked);
	            cache_get_value_name_int(0, "MaskID", PlayerData[extraid][pMaskID][0]);
	            cache_get_value_name_int(0, "MaskIDEx", PlayerData[extraid][pMaskID][1]);

	            cache_get_value_name_int(0, "FightStyle", PlayerData[extraid][pFightStyle]);
	            cache_get_value_name_int(0, "CarLic", PlayerData[extraid][pCarLic]);
	            cache_get_value_name_int(0, "WepLic", PlayerData[extraid][pWepLic]);
	            cache_get_value_name_int(0, "CCWLicense", PlayerData[extraid][pCCWLic]);
	            cache_get_value_name_int(0, "ADPoint", PlayerData[extraid][pADPoint]);

	            cache_get_value_name_int(0, "FlyLic", PlayerData[extraid][pFlyLic]);
	            cache_get_value_name_int(0, "MedLic", PlayerData[extraid][pMedLic]);
	            cache_get_value_name_int(0, "TruckLic", PlayerData[extraid][pTruckLic]);

				cache_get_value_name_int(0, "Gun1", PlayerData[extraid][pWeapon][0]);
				cache_get_value_name_int(0, "Gun2", PlayerData[extraid][pWeapon][1]);
				cache_get_value_name_int(0, "Gun3", PlayerData[extraid][pWeapon][2]);
				cache_get_value_name_int(0, "Ammo1", PlayerData[extraid][pAmmunation][0]);
				cache_get_value_name_int(0, "Ammo2", PlayerData[extraid][pAmmunation][1]);
				cache_get_value_name_int(0, "Ammo3", PlayerData[extraid][pAmmunation][2]);

				cache_get_value_name_int(0, "PrimaryLicense", PlayerData[extraid][pPrimaryLicense]);
				cache_get_value_name_int(0, "SecondaryLicense", PlayerData[extraid][pSecondaryLicense]);

				cache_get_value_name_int(0, "PlayerCarkey", PlayerData[extraid][pPCarkey]);
				cache_get_value_name_int(0, "PlayerBusinessKey", PlayerData[extraid][pPbiskey]);

				cache_get_value_name_int(0, "Radio", PlayerData[extraid][pRadio]);
				cache_get_value_name_int(0, "RadioChannel", PlayerData[extraid][pRChannel]);
				cache_get_value_name_int(0, "RadioSlot", PlayerData[extraid][pRSlot]);

		        cache_get_value_name_int(0, "MedicBill", MedicBill[extraid]);
				cache_get_value_name_float(0, "Health", PlayerData[extraid][pHealth]);
				cache_get_value_name_float(0, "Armour", PlayerData[extraid][pArmour]);

				cache_get_value_name_int(0, "Fishes", PlayerData[extraid][pFishes]);

				cache_get_value_name_int(0, "Checkpoint_Type", PlayerData[extraid][pCP_Type]);
				cache_get_value_name_float(0, "Checkpoint_X", PlayerData[extraid][pCP_X]);
				cache_get_value_name_float(0, "Checkpoint_Y", PlayerData[extraid][pCP_Y]);
				cache_get_value_name_float(0, "Checkpoint_Z", PlayerData[extraid][pCP_Z]);

				cache_get_value_name_int(0, "pWalk", PlayerData[extraid][pWalk]);
				cache_get_value_name_int(0, "pTalk", PlayerData[extraid][pTalk]);
				cache_get_value_name_int(0, "pJog", PlayerData[extraid][pJog]);
				cache_get_value_name_int(0, "pHUDStyle", PlayerData[extraid][pHUDStyle]);

				if(PlayerData[extraid][pTimeout] > 0)
				{
					if(gettime() - PlayerData[extraid][pTimeout] < 1200)
					{
						cache_get_value_name_int(0, "OnDuty", PlayerData[extraid][pOnDuty]);
						cache_get_value_name_int(0, "OnDutySkin", PlayerData[extraid][pOnDutySkin]);
						cache_get_value_name_int(0, "Local", PlayerData[extraid][pLocal]);

						cache_get_value_name_int(0, "timeoutProp", PlayerData[extraid][pTimeoutType][0]);
						cache_get_value_name_int(0, "timeoutApp", PlayerData[extraid][pTimeoutType][1]);
						cache_get_value_name_int(0, "timeoutBizz", PlayerData[extraid][pTimeoutType][2]);
					}
					else PlayerData[extraid][pTimeout] = 0;
				}

				cache_get_value_name_int(0, "FavUniform", PlayerData[extraid][pFavUniform]);

				new hudtoggled;
				cache_get_value_name_int(0, "HudToggle", hudtoggled);

				cache_get_value_name_int(0, "LoginToggle", PlayerData[extraid][pLoginToggle]);
				cache_get_value_name_int(0, "LoginSound", PlayerData[extraid][pLoginSound]);
				cache_get_value_name_int(0, "LoginNotify", PlayerData[extraid][pLoginNotify]);

				cache_get_value_name_int(0, "SprayBanned", PlayerData[extraid][pSprayBanned]);

				cache_get_value_name_int(0, "Cigarettes", PlayerData[extraid][pCigarettes]);
				cache_get_value_name_int(0, "Drinks", PlayerData[extraid][pDrink]);
				cache_get_value_name_int(0, "GasCan", PlayerData[extraid][pGasCan]);

				cache_get_value_name_int(0, "MainSlot", PlayerData[extraid][pMainSlot]);

				cache_get_value_name_int(0, "TotalDamages", TotalPlayerDamages[extraid]);
				cache_get_value_name_int(0, "LastBlow", DeathReason[extraid]);

				new knockout, adminduty, testerduty;
				cache_get_value_name_int(0, "Knockout", knockout);
				cache_get_value_name_int(0, "DrugStamp", PlayerData[extraid][pDrugStamp]);
				cache_get_value_name_int(0, "AdminDuty", adminduty);
				cache_get_value_name_int(0, "TesterDuty", testerduty);

				if(knockout) ForceKnockout{extraid} = true;

				format(query, sizeof(query), "SELECT * FROM `phone_contacts` WHERE `contactAdded` = %d", PlayerData[extraid][pPnumber]);
				mysql_tquery(dbCon, query, "OnQueryFinished", "dd", extraid, THREAD_PLAYER_CONTACTS);

				format(query, sizeof(query), "SELECT * FROM `phone_sms` WHERE `PhoneReceive` = %d", PlayerData[extraid][pPnumber]);
				mysql_tquery(dbCon, query, "OnQueryFinished", "dd", extraid, THREAD_PLAYER_SMS);

				format(query, sizeof(query), "SELECT * FROM `clothing` WHERE `owner` = %d", PlayerData[extraid][pID]);
				mysql_tquery(dbCon, query, "OnQueryFinished", "dd", extraid, THREAD_PLAYER_CLOTHING);

				format(query, sizeof(query), "SELECT * FROM `weapon` WHERE `owner` = %d", PlayerData[extraid][pID]);
				mysql_tquery(dbCon, query, "OnQueryFinished", "dd", extraid, THREAD_PLAYER_HOLDWEAPON);

				format(query, sizeof(query), "SELECT * FROM `radio` WHERE `owner` = %d", PlayerData[extraid][pID]);
				mysql_tquery(dbCon, query, "OnQueryFinished", "dd", extraid, THREAD_PLAYER_RADIO);

				format(query, sizeof(query), "SELECT * FROM `player_drugs` WHERE `PlayerSQLID` = %d LIMIT %d", PlayerData[extraid][pID], MAX_PLAYER_DRUGS);
				mysql_tquery(dbCon, query, "OnQueryFinished", "dd", extraid, THREAD_PLAYER_DRUGS);

				format(query, sizeof(query), "SELECT * FROM `damages` WHERE `playerID` = '%d' ORDER BY ID ASC LIMIT %d", PlayerData[extraid][pID], TotalPlayerDamages[extraid]);
				mysql_tquery(dbCon, query, "OnQueryFinished", "dd", extraid, THREAD_PLAYER_DAMAGES);

				format(query, sizeof(query), "SELECT friendID, playerID, friendName, playerName FROM ucp_friends WHERE playerID = %d AND friendPending = 0 OR friendID = %d AND friendPending = 0 LIMIT %d", AccountData[extraid][aUserid], AccountData[extraid][aUserid], MAX_FRIENDS);
				mysql_tquery(dbCon, query, "OnQueryFinished", "dd", extraid, THREAD_PLAYER_FRIENDS);

				new
				    count
				;

				foreach (new i : sv_playercar)
				{
					if(CarData[i][carOwner] == PlayerData[extraid][pID])
					{
						GiveVehicleKey(extraid, i);

						count++;
					}

					if(count == 6) break;
				}

				GivePlayerMoney(extraid, PlayerData[extraid][pCash]);

				SetPlayerFaction(extraid);

				LoggedIn{extraid} = true;

				if(PlayerData[extraid][pAdmin] > 0)
				{
					SendClientMessageEx(extraid, COLOR_WHITE, "SERVER: You are logged in as a level %d admin", PlayerData[extraid][pAdmin]);
				}

	            SendClientMessageEx(extraid, COLOR_WHITE, "SERVER: Welcome %s", ReturnName(extraid, 0));

	            if(strlen(PlayerData[extraid][AdminNote]) > 0)
	            {
	                Dialog_Show(extraid, AdminNote, DIALOG_STYLE_MSGBOX, "Admin Message", PlayerData[extraid][AdminNote], "Understood", "");

					PlayerData[extraid][AdminNote][0] = EOS;

	                format(query, sizeof(query), "UPDATE `accounts` SET `AdminNote` = '' WHERE `ID` = '%d' LIMIT 1", AccountData[extraid][aUserid]), mysql_pquery(dbCon, query);
	            }

				if(!PlayerData[extraid][pMaskID])
				{
					PlayerData[extraid][pMaskID][0] = 200000 + random(199991);
					PlayerData[extraid][pMaskID][1] = 40 + random(59);
				}

				if(PlayerData[extraid][pTimeout])
				{
					if(masked)
					{
						SendNoticeMessage(extraid, "Your mask has been returned (/mask).");

						PlayerData[extraid][pHasMask] = 1;
					}

					if(adminduty)
					{
						SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmCmd: %s returned and is back on adminduty.", ReturnName(extraid));

						AdminDuty{extraid} = true;
						TesterColor{extraid} = false;

						SetPVarFloat(extraid, "HealthCache", PlayerData[extraid][pHealth]);

				        SetPlayerHealthEx(extraid, 150.0);
					}

					if(testerduty)
					{
						SendTesterAlert(TEAM_TESTER_COLOR, "[TESTER] {FFBB00}%s returned and is back on tester duty.", ReturnName(extraid));

						TesterDuty{extraid} = true;
						TesterColor{extraid} = true;
					}
				}

				if(hudtoggled) PlayerFlags[extraid][toggleHUD] = true;

				format(str, sizeof(str), "~w~Welcome ~n~~y~   %s", ReturnName(extraid, 0));
				GameTextForPlayer(extraid, str, 5000, 1);

			    format(str, sizeof(str), "*** %s joined the server", ReturnName(extraid));
			    ProxJoinServer(extraid, str);

				CreatePlayerHUD(extraid);

				if(!PlayerFlags[extraid][toggleHUD])
				{
				    TextHud_Update(extraid);
				}

				if(IsPolice(extraid) || PlayerData[extraid][pAdmin]) InitMDC(extraid);

				CheckFightingStyle(extraid);

               	/*if(!active)
				{
					SendClientMessage(extraid, COLOR_LIGHTRED, "NOTE: Until you make your application and character is accepted you won't be able to play");
					SendClientMessage(extraid, COLOR_LIGHTRED, "VISIT: legacy-rp.net");
					SendClientMessage(extraid, COLOR_LIGHTRED, "Your character is not accepted yet!");
					SendClientMessage(extraid, COLOR_LIGHTRED, "Regards, Legacy-RP Administration team.");

					KickEx(extraid);
				}*/

				SetPlayerScore(extraid, PlayerData[extraid][pLevel]);

				if(!PlayerData[extraid][pTutorial])
				{
					PlayerData[extraid][pPos][0] = 1643.0010;
     				PlayerData[extraid][pPos][1] = -2331.7056;
		            PlayerData[extraid][pPos][2] = -2.6797;
		            PlayerData[extraid][pPos][3] = 359.8919;
		            PlayerData[extraid][pTutorial] = 0;
		            PlayerData[extraid][pLevel] = 1;
		            PlayerData[extraid][pSHealth] = 50.0;
		            PlayerData[extraid][pHealth] = 150.0;

		            initiateTutorial(extraid);

					UpdateLastLoginData(extraid);
			        return true;
				}

				SetSpawnInfo(extraid, NO_TEAM, PlayerData[extraid][pModel], PlayerData[extraid][pPos][0], PlayerData[extraid][pPos][1], PlayerData[extraid][pPos][2], PlayerData[extraid][pPos][3], 0, 0, 0, 0, 0, 0);
				TogglePlayerSpectating(extraid, false);
				TogglePlayerControllable(extraid, false);

				UpdateLastLoginData(extraid);

                SQL_LogAction(extraid, "Logged In");
			}
			else Kick(extraid);
		}
	    case THREAD_LOG_CON:
		{
			AccountData[extraid][aConnectionID] = cache_insert_id();
		}
		case THREAD_PLAYER_CONTACTS:
		{
		    cache_get_row_count(rows);

			if(rows)
			{
			    for(new i = 0; i < rows; ++i)
				{
					if(i < 40)
				    {
						cache_get_value_name_int(i, "contactID", ContactData[extraid][i][contactID]);
						cache_get_value_name_int(i, "contactAddee", ContactData[extraid][i][contactNumber]);
						cache_get_value_name(i, "contactName", ContactData[extraid][i][contactName], 24);
					}
				}
			}
		}
		case THREAD_PLAYER_SMS:
		{
		    cache_get_row_count(rows);

			if(rows)
			{
			    for(new i = 0; i < rows; ++i)
				{
					if(i < MAX_SMS)
				    {
	      				SmsData[extraid][i][smsExist] = true;

						cache_get_value_name_int(i, "id", SmsData[extraid][i][smsID]);
						cache_get_value_name_int(i, "PhoneOwner", SmsData[extraid][i][smsOwner]);
						cache_get_value_name_int(i, "PhoneReceive", SmsData[extraid][i][smsReceive]);
						cache_get_value_name_int(i, "Archive", SmsData[extraid][i][smsArchive]);
						cache_get_value_name(i, "PhoneSMS", SmsData[extraid][i][smsText], 128);
						cache_get_value_name(i, "Date", SmsData[extraid][i][smsDate], 24);
						cache_get_value_name_int(i, "ReadSMS", SmsData[extraid][i][smsRead]);
					}
				}
			}
		}
		case THREAD_PLAYER_CLOTHING:
		{
		    cache_get_row_count(rows);

			if(rows)
			{
			    for(new i = 0; i < rows; ++i)
				{
					if(i < MAX_CLOTHES)
				    {
						cache_get_value_name_int(i, "id", ClothingData[extraid][i][cl_sid]);
						cache_get_value_name_int(i, "object", ClothingData[extraid][i][cl_object]);
						cache_get_value_name_float(i, "x", ClothingData[extraid][i][cl_x]);
						cache_get_value_name_float(i, "y", ClothingData[extraid][i][cl_y]);
						cache_get_value_name_float(i, "z", ClothingData[extraid][i][cl_z]);
						cache_get_value_name_float(i, "rx", ClothingData[extraid][i][cl_rx]);
						cache_get_value_name_float(i, "ry", ClothingData[extraid][i][cl_ry]);
						cache_get_value_name_float(i, "rz", ClothingData[extraid][i][cl_rz]);
						cache_get_value_name_float(i, "scalex", ClothingData[extraid][i][cl_scalex]);
						cache_get_value_name_float(i, "scaley", ClothingData[extraid][i][cl_scaley]);
						cache_get_value_name_float(i, "scalez", ClothingData[extraid][i][cl_scalez]);
		    			cache_get_value_name_int(i, "bone", ClothingData[extraid][i][cl_bone]);
						cache_get_value_name_int(i, "slot", ClothingData[extraid][i][cl_slot]);
						cache_get_value_name_int(i, "equip", ClothingData[extraid][i][cl_equip]);
						cache_get_value_name(i, "name", ClothingData[extraid][i][cl_name], 32);
					}
				}
			}
		}
	    case THREAD_SECRET_CONFIRM:
		{
    	    cache_get_row_count(rows);

    	    if(!rows)
    	    {
                Dialog_Show(extraid, SecretWord, DIALOG_STYLE_PASSWORD, "Welcome to Legacy Roleplay", "{FF0000}POSSIBLE SECURITY BREACH\n\n{FFFFFF}The server has flagged you as possibly not being this account's owner, please write the secret word of this account in the box below to confirm it is yours.", "Enter", "Cancel");
			}
			else
			{
		    	SendClientMessage(extraid, COLOR_YELLOW, "Your connection to this account has been authenticated.");

		    	format(query, sizeof(query), "UPDATE `accounts` SET `Online` = 1, `LoginDate` = '%d', `LastIP` = '%s', `Serial` = '%s' WHERE `ID` = '%d' LIMIT 1", gettime(), PlayerData[extraid][pIP], PlayerSerial[extraid], AccountData[extraid][aUserid]), mysql_pquery(dbCon, query);

                SQL_LoadCharacters(extraid);
			}
		}
		case THREAD_PLAYER_HOLDWEAPON:
		{
		    cache_get_row_count(rows);

			if(rows)
			{
			    for(new i = 0; i < rows; ++i)
			    {
			        new weaponid;
			        cache_get_value_name_int(i, "weaponid", weaponid);

			        new slot = g_aWeaponAttach[weaponid];

			        if(slot != -1)
					{
			            cache_get_value_name_int(i, "id", WeaponSettings[extraid][slot][awID]);
						cache_get_value_name_float(i, "x", WeaponSettings[extraid][slot][aPx]);
						cache_get_value_name_float(i, "y", WeaponSettings[extraid][slot][aPy]);
						cache_get_value_name_float(i, "z", WeaponSettings[extraid][slot][aPz]);
						cache_get_value_name_float(i, "rx", WeaponSettings[extraid][slot][aPrx]);
						cache_get_value_name_float(i, "ry", WeaponSettings[extraid][slot][aPry]);
						cache_get_value_name_float(i, "rz", WeaponSettings[extraid][slot][aPrz]);
		    			cache_get_value_name_int(i, "bone", WeaponSettings[extraid][slot][awBone]);
						cache_get_value_name_int(i, "hide", WeaponSettings[extraid][slot][awHide]);
			        }
				}
			}
		}
		case THREAD_PLAYER_RADIO:
		{
		    cache_get_row_count(rows);

		    new idx = PlayerData[extraid][pRadio];

		    if(!idx) idx = 9;

			for(new i = 0; i < idx; ++i) PlayerData[extraid][pRadioChan][i] = 0;

			if(rows)
			{
			    new channel, slot;

			    for(new i = 0; i < rows; ++i)
			    {
			        cache_get_value_name_int(i, "channel", channel);
			        cache_get_value_name_int(i, "slot", slot);

                    PlayerData[extraid][pRadioChan][slot] = channel;
				}
			}
		}
		case THREAD_CREATE_CHARACTER:
		{
		    if(!cache_affected_rows())
		    {
		        SendClientMessage(extraid, COLOR_LIGHTRED, "Something went wrong, please contact an administrator.");
		        return KickEx(extraid);
			}

		    SQL_LoadCharacters(extraid);
		}
		case THREAD_CHECK_CHARACTER:
		{
		    cache_get_row_count(rows);

		    if(!rows)
			{
			    if(RegistrationEnabled)
					return Dialog_Show(extraid, CreateCharacter, DIALOG_STYLE_INPUT, "Character Creation", "Since you have no characters created, you're eligible to create one in-game.\n\nYou can create one right now by typing the name you wish to use down below\n\n{FF0000}**Be sure to type a realistic name or you'll get banned without any questions**", "Create", "Exit");

				SendErrorMessage(extraid, "You don't have any characters created, go to the UCP and create one.");
				return KickEx(extraid);
			}

			CreateCharacterMenuTD(extraid, rows);

		    new
				playerSQLID,
				playerName[MAX_PLAYER_NAME],
				playerLevel,
				playerSkin,
				count = 0,
				string[256]
			;

		    for(new i = 0; i != rows; ++i)
		    {
		        cache_get_value_name_int(i, "ID", playerSQLID);
		        cache_get_value_name(i, "char_name", playerName);
		        cache_get_value_name_int(i, "Level", playerLevel);
		        cache_get_value_name_int(i, "Model", playerSkin);

		    	CharacterCache[extraid][count] = playerSQLID;

		    	format(string, sizeof(string), "%s~n~Level: %d", playerName, playerLevel);
		    	PlayerTextDrawSetPreviewModel(extraid, CharSelectionTD[extraid][count], playerSkin);
		    	PlayerTextDrawSetString(extraid, CharSelectionTD[extraid][count + 6], string);

		    	AccountData[extraid][aCombinedLevel][0] += 1;
				AccountData[extraid][aCombinedLevel][1] += playerLevel;

		    	count++;
		    }

		    PlayerTextDrawShow(extraid, CharSelectionTD[extraid][12]);

		    for(new i = 0; i != count; ++i)
		    {
		        PlayerTextDrawShow(extraid, CharSelectionTD[extraid][i]);
		        PlayerTextDrawShow(extraid, CharSelectionTD[extraid][i + 6]);
		    }

		    SelectTextDraw(extraid, 0x000000CC);
		}
  		case THREAD_PLAYER_DRUGS:
  		{
			for(new i = 0; i < cache_num_rows(); ++i)
			{
				cache_get_value_name_int(i, "idx", Player_Drugs[extraid][i][dID]);
				cache_get_value_name_int(i, "drugType", Player_Drugs[extraid][i][dType]);
				cache_get_value_name_int(i, "drugStorage", Player_Drugs[extraid][i][dStorage]);
				cache_get_value_name_float(i, "drugAmount", Player_Drugs[extraid][i][dAmount]);
				cache_get_value_name_float(i, "drugStrength", Player_Drugs[extraid][i][dStrength]);
				cache_get_value_name_int(i, "drugStamp", Player_Drugs[extraid][i][dStamp]);
			}
  		}
  		case THREAD_PLAYER_FRIENDS:
  		{
			for(new i = 0; i < cache_num_rows(); ++i)
			{
			    new temp_values[2];

				cache_get_value_name_int(i, "friendID", temp_values[0]);
				cache_get_value_name_int(i, "playerID", temp_values[1]);

				if(AccountData[extraid][aUserid] == temp_values[0])
				{
				    Friends[extraid][i][friendID] = temp_values[1];

				    cache_get_value_name(i, "playerName", Friends[extraid][i][friendName], MAX_PLAYER_NAME);
				}
				else if(AccountData[extraid][aUserid] == temp_values[1])
				{
				    Friends[extraid][i][friendID] = temp_values[0];

				    cache_get_value_name(i, "friendName", Friends[extraid][i][friendName], MAX_PLAYER_NAME);
				}

				if(!PlayerData[extraid][pLoginNotify])
				{
					foreach (new p : Player)
					{
					    if(p == extraid) continue;

				 		if(!SQL_IsLogged(p)) continue;

				 		if(PlayerData[p][pLoginToggle]) continue;

						if(AccountData[p][aUserid] == Friends[extraid][i][friendID])
						{
							if(!PlayerData[p][pLoginSound]) PlayerPlaySound(p, LOGIN_SOUND, 0.0, 0.0, 0.0);

							SendClientMessageEx(p, COLOR_GREY, "** %s is {33AA33}online{AFAFAF}! (%s, ID %d)", AccountData[extraid][aUsername], ReturnName(extraid), extraid);
						}
					}
				}
			}
  		}
   		case THREAD_ADMIN_ACTIONS:
  		{
			new
			    count = 0,
			    alert_message[256]
			;

			for(new i = 0; i < cache_num_rows(); ++i)
			{
				cache_get_value_name(i, "Text", alert_message, 256);

				count ++;
			}

			if(count)
			{
			    if(strlen(alert_message) > 30)
			    {
			        SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(1): Player %s has %d active OnAdminAction notes on him, last is: %.30s", ReturnName(extraid), count, alert_message);
			        SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(1): %s", alert_message[30]);
			    }
			    else SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(1): Player %s has %d active OnAdminAction notes on him, last is: %s", ReturnName(extraid), count, alert_message);
			}
  		}
  		case THREAD_JOIN_ALERTS:
  		{
			new
			    count = 0,
			    alert_message[256]
			;

			for(new i = 0; i < cache_num_rows(); ++i)
			{
				cache_get_value_name(i, "action_log", alert_message, 256);

				count ++;
			}

			if(count)
			{
			    if(strlen(alert_message) > 30)
			    {
			        SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(1): Player %s has %d active OnJoinAlert notes on him, last is: %.30s", ReturnName(extraid), count, alert_message);
			        SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(1): %s", alert_message[30]);
			    }
			    else SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(1): Player %s has %d active OnJoinAlert notes on him, last is: %s", ReturnName(extraid), count, alert_message);
			}
  		}
  		case THREAD_PLAYER_DAMAGES:
  		{
  		    new
  		        count
			;

 			for(new i = 0; i < cache_num_rows(); ++i)
			{
				cache_get_value_name_int(i, "ID", DamageInfo[extraid][count][eDamageID]);
				cache_get_value_name_int(i, "damageTaken", DamageInfo[extraid][count][eDamageTaken]);
				cache_get_value_name_int(i, "damageTime", DamageInfo[extraid][count][eDamageTime]);
				cache_get_value_name_int(i, "damageWeapon", DamageInfo[extraid][count][eDamageWeapon]);
				cache_get_value_name_int(i, "damageBodypart", DamageInfo[extraid][count][eDamageBodypart]);
				cache_get_value_name_int(i, "damageArmor", DamageInfo[extraid][count][eDamageArmor]);
				cache_get_value_name_int(i, "damageBy", DamageInfo[extraid][count][eDamageBy]);

				count ++;
			}
  		}
	}
	return true;
}
