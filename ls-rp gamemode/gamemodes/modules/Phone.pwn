OnPhoneClick_Selfie(playerid)
{
	if(PlayerData[playerid][pCallConnect] == INVALID_PLAYER_ID && ph_menuid[playerid] != 6)
	{
	    CancelSelectTextDraw(playerid);

	    SetPlayerArmedWeapon(playerid, 0);

	    TogglePlayerControllable(playerid, false);

		SendClientMessage(playerid, COLOR_LIGHTRED, "[ ! ] Press F8 to take screenshot, F7 (twice) to hide your chat.");
		SendClientMessage(playerid, COLOR_LIGHTRED, "[ ! ] Hold W, A, S and D to manipulate the camera, hold ENTER to return back.");
		SendClientMessage(playerid, COLOR_WHITE, "[ ! ] Info: Use /headmove to stop your head from moving.");

		GetPlayerPos(playerid, lX[playerid], lY[playerid], lZ[playerid]);
		GetPlayerFacingAngle(playerid, Degree[playerid]);

		Degree[playerid] += 90.0;
        SelAngle[playerid] = 0.8;

  		static Float: n1X, Float: n1Y;

		n1X = lX[playerid] + Radius * floatcos(Degree[playerid], degrees);
		n1Y = lY[playerid] + Radius * floatsin(Degree[playerid], degrees);

		SetPlayerCameraPos(playerid, n1X, n1Y, lZ[playerid] + Height);
		SetPlayerCameraLookAt(playerid, lX[playerid], lY[playerid], lZ[playerid] + SelAngle[playerid]);
		SetPlayerFacingAngle(playerid, Degree[playerid] - 90);

		RenderPlayerPhone(playerid, 0, 2);

		ApplyAnimation(playerid, "PED", "gang_gunstand", 4.1, 0, 0, 0, 1, 0, 0);

		selfie_timer[playerid] = SetTimerEx("SelfieTimer", 500, true, "d", playerid);
	}
	return true;
}

FUNX::SelfieTimer(playerid)
{
	new Keys, ud, lr;

	if(ph_menuid[playerid] == 0 && ph_sub_menuid[playerid] == 2)
	{
		GetPlayerKeys(playerid, Keys, ud, lr);

		if(lr == KEY_LEFT)
		{
			GetPlayerPos(playerid,lX[playerid],lY[playerid],lZ[playerid]);
			static Float: n1X, Float: n1Y;
			Degree[playerid] += Speed;
			n1X = lX[playerid] + Radius * floatcos(Degree[playerid], degrees);
			n1Y = lY[playerid] + Radius * floatsin(Degree[playerid], degrees);
			SetPlayerCameraPos(playerid, n1X, n1Y, lZ[playerid] + Height);
			SetPlayerCameraLookAt(playerid, lX[playerid], lY[playerid], lZ[playerid]+ SelAngle[playerid]);
			SetPlayerFacingAngle(playerid, Degree[playerid] - 90.0);
		}
		else if(lr == KEY_RIGHT)
		{
			GetPlayerPos(playerid,lX[playerid],lY[playerid],lZ[playerid]);
			static Float: n1X, Float: n1Y;
			Degree[playerid] -= Speed;
			n1X = lX[playerid] + Radius * floatcos(Degree[playerid], degrees);
			n1Y = lY[playerid] + Radius * floatsin(Degree[playerid], degrees);
			SetPlayerCameraPos(playerid, n1X, n1Y, lZ[playerid] + Height);
			SetPlayerCameraLookAt(playerid, lX[playerid], lY[playerid], lZ[playerid]+ SelAngle[playerid]);
			SetPlayerFacingAngle(playerid, Degree[playerid] - 90.0);
		}

		if(ud == KEY_UP)
		{
			GetPlayerPos(playerid,lX[playerid],lY[playerid],lZ[playerid]);
			static Float: n1X, Float: n1Y;

			if(SelAngle[playerid] < 1.0)
				SelAngle[playerid] += 0.1;

			n1X = lX[playerid] + Radius * floatcos(Degree[playerid], degrees);
			n1Y = lY[playerid] + Radius * floatsin(Degree[playerid], degrees);
			SetPlayerCameraPos(playerid, n1X, n1Y, lZ[playerid] + Height);
			SetPlayerCameraLookAt(playerid, lX[playerid], lY[playerid], lZ[playerid]+ SelAngle[playerid]);
			SetPlayerFacingAngle(playerid, Degree[playerid] - 90.0);
		}
		else if(ud == KEY_DOWN)
		{
			GetPlayerPos(playerid,lX[playerid],lY[playerid],lZ[playerid]);
			static Float: n1X, Float: n1Y;

			if(SelAngle[playerid] > 0.8)
				SelAngle[playerid] -= 0.1;

			n1X = lX[playerid] + Radius * floatcos(Degree[playerid], degrees);
			n1Y = lY[playerid] + Radius * floatsin(Degree[playerid], degrees);
			SetPlayerCameraPos(playerid, n1X, n1Y, lZ[playerid] + Height);
			SetPlayerCameraLookAt(playerid, lX[playerid], lY[playerid], lZ[playerid]+ SelAngle[playerid]);
			SetPlayerFacingAngle(playerid, Degree[playerid] - 90.0);
		}

		if(Keys == KEY_SECONDARY_ATTACK)
		{
			ph_menuid[playerid] = 0;
			ph_sub_menuid[playerid] = 0;
			
			RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);

			TogglePlayerControllable(playerid, true);
			
			SetCameraBehindPlayer(playerid);
			ClearAnimations(playerid);
		}
	}
	else
	{
		if(selfie_timer[playerid]) KillTimer(selfie_timer[playerid]);

		selfie_timer[playerid] = 0;
	}
}

PhoneSelfie_Stop(playerid)
{
	if(ph_menuid[playerid] == 0 && ph_sub_menuid[playerid] == 2)
	{
	    if(selfie_timer[playerid]) KillTimer(selfie_timer[playerid]);

	    selfie_timer[playerid] = 0;

		RenderPlayerPhone(playerid, 0, 0);

		TogglePlayerControllable(playerid, true);

		SetCameraBehindPlayer(playerid);
		ClearAnimations(playerid);
	}
	return true;
}

PlayPlayerCallTone(playerid)
{
	switch(ph_CallTone[playerid])
	{
	    case 0: PlayerPlaySoundEx(playerid, 23000);
	    case 1: PlayerPlaySoundEx(playerid, 20600);
	    case 2: PlayerPlaySoundEx(playerid, 20804);
	}
}

PlayPlayerTextTone(playerid)
{
	switch(ph_TextTone[playerid])
	{
	    case 0: PlayerPlaySound(playerid, 41603, 0.0, 0.0, 0.0);
	    case 1: PlayerPlaySound(playerid, 21000, 0.0, 0.0, 0.0);
	    case 2: PlayerPlaySound(playerid, 21001, 0.0, 0.0, 0.0);
	    case 3: PlayerPlaySound(playerid, 21002, 0.0, 0.0, 0.0);
	}
}

PreviewCallTone(playerid, type)
{
	switch(type)
	{
	    case 0: PlayerPlaySound(playerid, 23000, 0.0, 0.0, 0.0);
	    case 1: PlayerPlaySound(playerid, 20600, 0.0, 0.0, 0.0);
	    case 2: PlayerPlaySound(playerid, 20804, 0.0, 0.0, 0.0);
	}
}

PreviewTextTone(playerid, type)
{
	switch(type)
	{
	    case 0: PlayerPlaySound(playerid, 41603, 0.0, 0.0, 0.0);
	    case 1: PlayerPlaySound(playerid, 21000, 0.0, 0.0, 0.0);
	    case 2: PlayerPlaySound(playerid, 21001, 0.0, 0.0, 0.0);
	    case 3: PlayerPlaySound(playerid, 21002, 0.0, 0.0, 0.0);
	}
}

GetContactName(playerid, number)
{
	new name[24], success = false;

	for(new x = 0; x < 40; ++x)
	{
		if(ContactData[playerid][x][contactNumber] == number)
		{
			format(name, 24, "%s", ContactData[playerid][x][contactName]);

			success = true;
			break;
		}
	}

	if(!success) format(name, 24, "%06d", number);

	return name;
}

GetContactID(playerid, number)
{
	new id = -1;

	for(new x = 0; x < 40; ++x)
	{
		if(ContactData[playerid][x][contactNumber] == number)
		{
			id = x;
			break;
		}
	}
	return id;
}

CancelCall(playerid)
{
	new callerid = PlayerData[playerid][pCallConnect];

	if(callerid != INVALID_PLAYER_ID)
	{
		ph_menuid[callerid] = 0;
		ph_sub_menuid[callerid] = 0;

		RenderPlayerPhone(callerid, ph_menuid[callerid], ph_sub_menuid[callerid]);

		if(GetPlayerSpecialAction(callerid) == SPECIAL_ACTION_USECELLPHONE) SetPlayerSpecialAction(callerid,SPECIAL_ACTION_STOPUSECELLPHONE);

		PlayerData[callerid][pCallConnect] = INVALID_PLAYER_ID;
	   	PlayerData[callerid][pCallLine] = INVALID_PLAYER_ID;
	   	PlayerData[callerid][pCellTime] = 0;
	}

	ph_menuid[playerid] = 0;
	ph_sub_menuid[playerid] = 0;

	RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);

	if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USECELLPHONE) SetPlayerSpecialAction(playerid,SPECIAL_ACTION_STOPUSECELLPHONE);

	PlayerData[playerid][pCallConnect] = INVALID_PLAYER_ID;
	PlayerData[playerid][pCallLine] = INVALID_PLAYER_ID;
	PlayerData[playerid][pCellTime] = 0;
}

GetPhoneSignal(playerid)
{
	new tower = GetClosestSignal(playerid), signal, Float:dis, Float:cal;
	
	if(tower == -1) return 0;

	if(PlayerData[playerid][pLocal] != 255)
	{
		if(PlayerData[playerid][pLocal] == 101) dis = GetDistance(1554.4711,-1675.6097,16.1953, SignalData[tower][signalX], SignalData[tower][signalY], SignalData[tower][signalZ]);
        else if(PlayerData[playerid][pLocal] == 102) dis = GetDistance(1481.0662,-1771.3069,18.7958,  SignalData[tower][signalX], SignalData[tower][signalY], SignalData[tower][signalZ]);
        else if(PlayerData[playerid][pLocal] == 103) dis = GetDistance(1173.1841,-1323.3143,15.3952,  SignalData[tower][signalX], SignalData[tower][signalY], SignalData[tower][signalZ]);
        else if(PlayerData[playerid][pLocal] == 104) dis = GetDistance(533.4344,-1812.9364,6.5781,  SignalData[tower][signalX], SignalData[tower][signalY], SignalData[tower][signalZ]);
		else
		{
	 		foreach (new x : Business)
			{
			 	if(PlayerData[playerid][pLocal] - LOCAL_BIZZ == x && GetPlayerInterior(playerid) == BusinessData[x][bInterior])
			 	{
					dis = GetDistance(BusinessData[x][bEntranceX], BusinessData[x][bEntranceY], BusinessData[x][bEntranceZ], SignalData[tower][signalX], SignalData[tower][signalY], SignalData[tower][signalZ]);
				}
			}
		}
	}
	else dis = GetPlayerDistanceFromPoint(playerid, SignalData[tower][signalX], SignalData[tower][signalY], SignalData[tower][signalZ]);
	cal = SignalData[tower][signalRange] / 5;
	if(dis > cal * 4 ) signal = 1;
 	else if(dis > cal * 3 ) signal = 2;
	else if(dis > cal * 2 ) signal = 3;
	else if(dis > cal * 1 ) signal = 4;
	else signal = 5;

	return signal;
}

IsUnreadSMS(playerid)
{
	new count = false;

	for(new x = 0; x < MAX_SMS; ++x)
	{
		if(SmsData[playerid][x][smsExist] && !SmsData[playerid][x][smsRead])
		{
			count = true;
			break;
		}
	}

	return count;
}

CountUnreadSMS(playerid)
{
	new count;

	for(new x = 0; x < MAX_SMS; ++x)
	{
		if(SmsData[playerid][x][smsExist] && !SmsData[playerid][x][smsRead])
		{
			count++;
		}
	}

	return count;
}

CountMissedCall(playerid)
{
	new count;

	for(new x = 0; x < MAX_CALLHISTORY; ++x)
	{
		if(CallHistory[playerid][x][chExists] && !CallHistory[playerid][x][chRead] && CallHistory[playerid][x][chType] == 2)
		{
			count++;
		}
	}

	return count;
}

CheckPhoneStatus(playerid)
{
	if(ph_menuid[playerid] == 6 && ph_sub_menuid[playerid] >= 0)
	    return false;

	return true;
}

RenderPlayerPhone(playerid, menuid, subid, select = 0)
{
    ph_menuid[playerid] = menuid;
	ph_sub_menuid[playerid] = subid;

	if(Dialog_Opened(playerid)) Dialog_Close(playerid);

	if(ph_menuid[playerid] == 6 && ph_sub_menuid[playerid] >= 1)
		PlayerTextDrawBoxColor(playerid, TDPhone_Model[playerid][6], 0x1C1C1CFF);
	else
		PlayerTextDrawBoxColor(playerid, TDPhone_Model[playerid][6], -572662273);

    PlayerTextDrawShow(playerid, TDPhone_Model[playerid][6]);

    HidePlayerPhoneText(playerid);

	new str[64];

	if(!IsUnreadSMS(playerid) || (menuid == 6 && subid > 0))
	{
		PlayerTextDrawColor(playerid, TDPhone_Model[playerid][3], -1);
		PlayerTextDrawShow(playerid, TDPhone_Model[playerid][3]);
	}
	else
	{
		PlayerTextDrawColor(playerid, TDPhone_Model[playerid][3], 0x298A08FF);
		PlayerTextDrawShow(playerid, TDPhone_Model[playerid][3]);
	}

	switch(menuid)
	{
	    case 0:
	    {
			switch(subid)
			{
				case 0, 2: // Main Page
				{
				 	new
				 	    day, month, year, hour, minute, second;

					getdate(year, month, day);
					gettime(hour, minute, second);

					//for(new i = 0, j = GetPhoneSignal(playerid); i != j; ++i)
					//	format(str, sizeof(str), "%sI", str);

					//PlayerTextDrawSetString(playerid, TDPhone_Signal[playerid], (!strlen(str)) ? ("X") : str);
					//PlayerTextDrawShow(playerid, TDPhone_Signal[playerid]);

					format(str, sizeof(str), "%02d:%02d", hour, minute);
					PlayerTextDrawSetString(playerid, TDPhone_BigText[playerid], str);
					PlayerTextDrawShow(playerid, TDPhone_BigText[playerid]);

					format(str, sizeof(str), "%s %d%s", MonthDay[month - 1], day, returnOrdinal(day));
					PlayerTextDrawSetString(playerid, TDPhone_ScreenText[playerid], str);
					PlayerTextDrawShow(playerid, TDPhone_ScreenText[playerid]);

					new missed_msg = CountMissedCall(playerid), unread_msg = CountUnreadSMS(playerid);

					if(missed_msg)
					{
		           		format(str, sizeof(str), "%d missed call", missed_msg);
					}
					else if(unread_msg)
					{
						format(str, sizeof(str), "%d unread message", unread_msg);
					}
					else str[0] = EOS;

	 				PlayerTextDrawSetString(playerid, TDPhone_NotifyText[playerid], str);
					PlayerTextDrawShow(playerid, TDPhone_NotifyText[playerid]);

					PlayerTextDrawSetString(playerid, TDPhone_TFButton[playerid], "Menu");
					PlayerTextDrawShow(playerid, TDPhone_TFButton[playerid]);

					PlayerTextDrawSetString(playerid, TDPhone_TSButton[playerid], "Back");
					PlayerTextDrawShow(playerid, TDPhone_TSButton[playerid]);
				}
				case 1: // List Main menu
				{
					new choice[4][16] = { "Phonebook", "SMS", "Calls", "Settings" };

				    for(new i = 0; i != 4; ++i)
					{
						PlayerTextDrawSetString(playerid, TDPhone_Choice[playerid][i], choice[i]);
						PlayerTextDrawColor(playerid, TDPhone_Choice[playerid][i], (select == i) ? 0x989898FF : 0x000000FF);
						PlayerTextDrawBoxColor(playerid, TDPhone_Choice[playerid][i], (select == i) ? 0x222222FF : 0xAAAAAAFF);
						PlayerTextDrawShow(playerid, TDPhone_Choice[playerid][i]);
				    }
				}
			}
	    }
	    case 1:
	    {
			switch(subid) // Phonebook menu
			{
				case 0:
				{
					PlayerTextDrawSetString(playerid, TDPhone_Choice[playerid][0], "Add a contact");
					PlayerTextDrawColor(playerid, TDPhone_Choice[playerid][0], (select == 0) ? 0x989898FF : 0x000000FF);
					PlayerTextDrawBoxColor(playerid, TDPhone_Choice[playerid][0], (select == 0) ? 0x222222FF : 0xAAAAAAFF);
					PlayerTextDrawShow(playerid, TDPhone_Choice[playerid][0]);

					PlayerTextDrawSetString(playerid, TDPhone_Choice[playerid][1], "List contacts");
					PlayerTextDrawColor(playerid, TDPhone_Choice[playerid][1], (select == 1) ? 0x989898FF : 0x000000FF);
					PlayerTextDrawBoxColor(playerid, TDPhone_Choice[playerid][1], (select == 1) ? 0x222222FF : 0xAAAAAAFF);
					PlayerTextDrawShow(playerid, TDPhone_Choice[playerid][1]);

					PlayerTextDrawSetString(playerid, TDPhone_TFButton[playerid], "Select");
					PlayerTextDrawShow(playerid, TDPhone_TFButton[playerid]);

					PlayerTextDrawSetString(playerid, TDPhone_TSButton[playerid], "Back");
					PlayerTextDrawShow(playerid, TDPhone_TSButton[playerid]);

					ph_page[playerid] = 0;
					ph_select_data[playerid] = -1;
    			}
				case 1: // List contacts
				{
                    new count = 0, next = ph_page[playerid] * 4;

                    for(new i = 0; i != 40; ++i)
                    {
                        if(i < 4) ph_data[playerid][i] = -1;

                    	if(ContactData[playerid][i][contactNumber])
				        {
	                        if(next)
	                        {
	                            next--;
	                            continue;
	                        }

							if(count > 3)
							{
							    break;
							}

							PlayerTextDrawSetString(playerid, TDPhone_Choice[playerid][count], ContactData[playerid][i][contactName]);
							PlayerTextDrawColor(playerid, TDPhone_Choice[playerid][count], (select == count) ? 0x989898FF : 0x000000FF);
							PlayerTextDrawBoxColor(playerid, TDPhone_Choice[playerid][count], (select == count) ? 0x222222FF : 0xAAAAAAFF);
							PlayerTextDrawShow(playerid, TDPhone_Choice[playerid][count]);

							ph_data[playerid][count] = i + 1;

							count++;
						}
					}

					if(!count)
					{
						PlayerTextDrawSetString(playerid, TDPhone_ScreenText[playerid], "Your contact list ~n~is currently empty");
						PlayerTextDrawShow(playerid, TDPhone_ScreenText[playerid]);

						PlayerTextDrawSetString(playerid, TDPhone_TSButton[playerid], "Back");
						PlayerTextDrawShow(playerid, TDPhone_TSButton[playerid]);
					}
					else if(count < 4)
					{
						PlayerTextDrawSetString(playerid, TDPhone_TFButton[playerid], "Select");
						PlayerTextDrawShow(playerid, TDPhone_TFButton[playerid]);

						PlayerTextDrawSetString(playerid, TDPhone_TSButton[playerid], "Back");
						PlayerTextDrawShow(playerid, TDPhone_TSButton[playerid]);
					}
				}
				case 2: // List contacts --> Details
				{
				    if(ph_select_data[playerid] == -1)
						ph_select_data[playerid] = ph_data[playerid][ph_selected[playerid]] - 1;

					format(str, 32, "%s~n~(%d)", ContactData[playerid][ph_select_data[playerid]][contactName], ContactData[playerid][ph_select_data[playerid]][contactNumber]);

					PlayerTextDrawSetString(playerid, TDPhone_ScreenText[playerid], str);
					PlayerTextDrawShow(playerid, TDPhone_ScreenText[playerid]);


					PlayerTextDrawSetString(playerid, TDPhone_TFButton[playerid], "Options");
					PlayerTextDrawShow(playerid, TDPhone_TFButton[playerid]);

					PlayerTextDrawSetString(playerid, TDPhone_TSButton[playerid], "Back");
					PlayerTextDrawShow(playerid, TDPhone_TSButton[playerid]);
				}
				case 3: // List contacts --> Details --> Actions
				{
					PlayerTextDrawSetString(playerid, TDPhone_Choice[playerid][0], "Call");
					PlayerTextDrawColor(playerid, TDPhone_Choice[playerid][0], (select == 0) ? 0x989898FF : 0x000000FF);
					PlayerTextDrawBoxColor(playerid, TDPhone_Choice[playerid][0], (select == 0) ? 0x222222FF : 0xAAAAAAFF);
					PlayerTextDrawShow(playerid, TDPhone_Choice[playerid][0]);

					PlayerTextDrawSetString(playerid, TDPhone_Choice[playerid][1], "Text");
					PlayerTextDrawColor(playerid, TDPhone_Choice[playerid][1], (select == 1) ? 0x989898FF : 0x000000FF);
					PlayerTextDrawBoxColor(playerid, TDPhone_Choice[playerid][1], (select == 1) ? 0x222222FF : 0xAAAAAAFF);
					PlayerTextDrawShow(playerid, TDPhone_Choice[playerid][1]);

					PlayerTextDrawSetString(playerid, TDPhone_Choice[playerid][2], "Delete");
					PlayerTextDrawColor(playerid, TDPhone_Choice[playerid][2], (select == 2) ? 0x989898FF : 0x000000FF);
					PlayerTextDrawBoxColor(playerid, TDPhone_Choice[playerid][2], (select == 2) ? 0x222222FF : 0xAAAAAAFF);
					PlayerTextDrawShow(playerid, TDPhone_Choice[playerid][2]);

					PlayerTextDrawSetString(playerid, TDPhone_TSButton[playerid], "Back");
					PlayerTextDrawShow(playerid, TDPhone_TSButton[playerid]);
				}
			}
	    }
	    case 2:
	    {
			switch(subid) // SMS menu { SMS a contact, SMS a number, Inbox, Archive }
			{
				case 0:
				{
					PlayerTextDrawSetString(playerid, TDPhone_Choice[playerid][0], "SMS a contact");
					PlayerTextDrawColor(playerid, TDPhone_Choice[playerid][0], (select == 0) ? 0x989898FF : 0x000000FF);
					PlayerTextDrawBoxColor(playerid, TDPhone_Choice[playerid][0], (select == 0) ? 0x222222FF : 0xAAAAAAFF);
					PlayerTextDrawShow(playerid, TDPhone_Choice[playerid][0]);

					PlayerTextDrawSetString(playerid, TDPhone_Choice[playerid][1], "SMS a number");
					PlayerTextDrawColor(playerid, TDPhone_Choice[playerid][1], (select == 1) ? 0x989898FF : 0x000000FF);
					PlayerTextDrawBoxColor(playerid, TDPhone_Choice[playerid][1], (select == 1) ? 0x222222FF : 0xAAAAAAFF);
					PlayerTextDrawShow(playerid, TDPhone_Choice[playerid][1]);

					PlayerTextDrawSetString(playerid, TDPhone_Choice[playerid][2], "Inbox");
					PlayerTextDrawColor(playerid, TDPhone_Choice[playerid][2], (select == 2) ? 0x989898FF : 0x000000FF);
					PlayerTextDrawBoxColor(playerid, TDPhone_Choice[playerid][2], (select == 2) ? 0x222222FF : 0xAAAAAAFF);
					PlayerTextDrawShow(playerid, TDPhone_Choice[playerid][2]);

					PlayerTextDrawSetString(playerid, TDPhone_Choice[playerid][3], "Archive");
					PlayerTextDrawColor(playerid, TDPhone_Choice[playerid][3], (select == 3) ? 0x989898FF : 0x000000FF);
					PlayerTextDrawBoxColor(playerid, TDPhone_Choice[playerid][3], (select == 3) ? 0x222222FF : 0xAAAAAAFF);
					PlayerTextDrawShow(playerid, TDPhone_Choice[playerid][3]);

					ph_page[playerid] = 0;
					ph_select_data[playerid] = -1;

				}
				case 1: // SMS a contact
				{
					new count = 0, next = ph_page[playerid] * 4;

                    for(new i = 0; i != 40; ++i)
                    {
                        if(i < 4) ph_data[playerid][i] = -1;

                    	if(ContactData[playerid][i][contactNumber])
				        {
	                        if(next)
	                        {
	                            next--;
	                            continue;
	                        }

							if(count > 3)
							{
							    break;
							}

							PlayerTextDrawSetString(playerid, TDPhone_Choice[playerid][count], ContactData[playerid][i][contactName]);
							PlayerTextDrawColor(playerid, TDPhone_Choice[playerid][count], (select == count) ? 0x989898FF : 0x000000FF);
							PlayerTextDrawBoxColor(playerid, TDPhone_Choice[playerid][count], (select == count) ? 0x222222FF : 0xAAAAAAFF);
							PlayerTextDrawShow(playerid, TDPhone_Choice[playerid][count]);
							ph_data[playerid][count] = i + 1;

							count++;
						}
					}

					if(!count)
					{
						PlayerTextDrawSetString(playerid, TDPhone_ScreenText[playerid], "Your contact list ~n~is currently empty");
						PlayerTextDrawShow(playerid, TDPhone_ScreenText[playerid]);

						PlayerTextDrawSetString(playerid, TDPhone_TSButton[playerid], "Back");
						PlayerTextDrawShow(playerid, TDPhone_TSButton[playerid]);
					}
					else if(count < 4)
					{
						PlayerTextDrawSetString(playerid, TDPhone_TFButton[playerid], "Select");
						PlayerTextDrawShow(playerid, TDPhone_TFButton[playerid]);

						PlayerTextDrawSetString(playerid, TDPhone_TSButton[playerid], "Back");
						PlayerTextDrawShow(playerid, TDPhone_TSButton[playerid]);
					}
				}
				/*case 2: // SMS a number
				{
				    Dialog_Show(playerid, SMSNumber, DIALOG_STYLE_INPUT, "Insert number", "send SMS to Phone Number\n\n\t\tEnter contact number:", "Proceed", "Back");
				}*/

				case 3, 4: // 3- INBOX   4- Archive
 				{
					new count = 0, next = ph_page[playerid] * 4;

                    for(new i = 0; i != MAX_SMS; ++i) if(subid == 3 && !SmsData[playerid][i][smsArchive] || subid == 4 && SmsData[playerid][i][smsArchive])
                    {
                        if(i < 4) ph_data[playerid][i] = -1;

                    	if(SmsData[playerid][i][smsExist])
				        {
	                        if(next)
	                        {
	                            next--;
	                            continue;
	                        }

							if(count > 3)
							{
							    break;
							}

							format(str, sizeof(str), "%s%s", (!SmsData[playerid][i][smsRead]) ? ("~>~ ") : (""), GetContactName(playerid, SmsData[playerid][i][smsOwner]));
                            //printf(str);
							PlayerTextDrawSetString(playerid, TDPhone_Choice[playerid][count], str);
							PlayerTextDrawColor(playerid, TDPhone_Choice[playerid][count], (select == count) ? 0x989898FF : 0x000000FF);
							PlayerTextDrawBoxColor(playerid, TDPhone_Choice[playerid][count], (select == count) ? 0x222222FF : 0xAAAAAAFF);
							PlayerTextDrawShow(playerid, TDPhone_Choice[playerid][count]);
							ph_data[playerid][count] = i + 1;

							count++;
						}
					}

					if(!count)
					{
						PlayerTextDrawSetString(playerid, TDPhone_ScreenText[playerid], "No messages in this~n~directory");
						PlayerTextDrawShow(playerid, TDPhone_ScreenText[playerid]);

						PlayerTextDrawSetString(playerid, TDPhone_TSButton[playerid], "Back");
						PlayerTextDrawShow(playerid, TDPhone_TSButton[playerid]);
					}
					else if(count < 4)
					{
						PlayerTextDrawSetString(playerid, TDPhone_TFButton[playerid], "Select");
						PlayerTextDrawShow(playerid, TDPhone_TFButton[playerid]);

						PlayerTextDrawSetString(playerid, TDPhone_TSButton[playerid], "Back");
						PlayerTextDrawShow(playerid, TDPhone_TSButton[playerid]);
					}
				}
			}
		}
		case 3: // Calls
		{
			switch(subid) // Calls SMS { Dial a contact, Dial a number, View call history }
			{
				case 0:
				{
					PlayerTextDrawSetString(playerid, TDPhone_Choice[playerid][0], "Dial a contact");
					PlayerTextDrawColor(playerid, TDPhone_Choice[playerid][0], (select == 0) ? 0x989898FF : 0x000000FF);
					PlayerTextDrawBoxColor(playerid, TDPhone_Choice[playerid][0], (select == 0) ? 0x222222FF : 0xAAAAAAFF);
					PlayerTextDrawShow(playerid, TDPhone_Choice[playerid][0]);

					PlayerTextDrawSetString(playerid, TDPhone_Choice[playerid][1], "Dial a number");
					PlayerTextDrawColor(playerid, TDPhone_Choice[playerid][1], (select == 1) ? 0x989898FF : 0x000000FF);
					PlayerTextDrawBoxColor(playerid, TDPhone_Choice[playerid][1], (select == 1) ? 0x222222FF : 0xAAAAAAFF);
					PlayerTextDrawShow(playerid, TDPhone_Choice[playerid][1]);

					PlayerTextDrawSetString(playerid, TDPhone_Choice[playerid][2], "View call history");
					PlayerTextDrawColor(playerid, TDPhone_Choice[playerid][2], (select == 2) ? 0x989898FF : 0x000000FF);
					PlayerTextDrawBoxColor(playerid, TDPhone_Choice[playerid][2], (select == 2) ? 0x222222FF : 0xAAAAAAFF);
					PlayerTextDrawShow(playerid, TDPhone_Choice[playerid][2]);

					PlayerTextDrawSetString(playerid, TDPhone_TSButton[playerid], "Back");
					PlayerTextDrawShow(playerid, TDPhone_TSButton[playerid]);

					ph_page[playerid] = 0;
					ph_select_data[playerid] = -1;
				}
				case 1: // Dial a contact
				{
					new count = 0, next = ph_page[playerid] * 4;

                    for(new i = 0; i != 40; ++i)
                    {
                        if(i < 4) ph_data[playerid][i] = -1;

                    	if(ContactData[playerid][i][contactNumber])
				        {
	                        if(next)
	                        {
	                            next--;
	                            continue;
	                        }

							if(count > 3)
							{
							    break;
							}

							PlayerTextDrawSetString(playerid, TDPhone_Choice[playerid][count], ContactData[playerid][i][contactName]);
							PlayerTextDrawColor(playerid, TDPhone_Choice[playerid][count], (select == count) ? 0x989898FF : 0x000000FF);
							PlayerTextDrawBoxColor(playerid, TDPhone_Choice[playerid][count], (select == count) ? 0x222222FF : 0xAAAAAAFF);
							PlayerTextDrawShow(playerid, TDPhone_Choice[playerid][count]);
							ph_data[playerid][count] = i + 1;

							count++;
						}
					}

					if(!count)
					{
						PlayerTextDrawSetString(playerid, TDPhone_ScreenText[playerid], "Your contact list ~n~is currently empty");
						PlayerTextDrawShow(playerid, TDPhone_ScreenText[playerid]);

						PlayerTextDrawSetString(playerid, TDPhone_TSButton[playerid], "Back");
						PlayerTextDrawShow(playerid, TDPhone_TSButton[playerid]);
					}
					else if(count < 4)
					{
						PlayerTextDrawSetString(playerid, TDPhone_TFButton[playerid], "Select");
						PlayerTextDrawShow(playerid, TDPhone_TFButton[playerid]);

						PlayerTextDrawSetString(playerid, TDPhone_TSButton[playerid], "Back");
						PlayerTextDrawShow(playerid, TDPhone_TSButton[playerid]);
					}
				}
				case 3: // View call history
				{
					new count = 0, next = ph_page[playerid] * 4;

                    for(new i = 0; i != MAX_CALLHISTORY; ++i)
                    {
                        if(i < 4) ph_data[playerid][i] = -1;

                    	if(CallHistory[playerid][i][chExists])
				        {
	                        if(next)
	                        {
	                            next--;
	                            continue;
	                        }

							if(count > 3)
							{
							    break;
							}

							format(str, sizeof(str), "%s%s", (!CallHistory[playerid][i][chType]) ? ("~u~") : (CallHistory[playerid][i][chType] == 2) ? ("~d~~r~") : ("~d~"), GetContactName(playerid, CallHistory[playerid][i][chNumber]));
							PlayerTextDrawSetString(playerid, TDPhone_Choice[playerid][count], str);
							PlayerTextDrawColor(playerid, TDPhone_Choice[playerid][count], (select == count) ? 0x989898FF : 0x000000FF);
							PlayerTextDrawBoxColor(playerid, TDPhone_Choice[playerid][count], (select == count) ? 0x222222FF : 0xAAAAAAFF);
							PlayerTextDrawShow(playerid, TDPhone_Choice[playerid][count]);
							ph_data[playerid][count] = i + 1;

							count++;
						}
					}

					if(!count)
					{
						PlayerTextDrawSetString(playerid, TDPhone_ScreenText[playerid], "Your call history is~n~empty");
						PlayerTextDrawShow(playerid, TDPhone_ScreenText[playerid]);

						PlayerTextDrawSetString(playerid, TDPhone_TSButton[playerid], "Back");
						PlayerTextDrawShow(playerid, TDPhone_TSButton[playerid]);
					}
					else if(count < 4)
					{
						PlayerTextDrawSetString(playerid, TDPhone_TFButton[playerid], "Select");
						PlayerTextDrawShow(playerid, TDPhone_TFButton[playerid]);

						PlayerTextDrawSetString(playerid, TDPhone_TSButton[playerid], "Back");
						PlayerTextDrawShow(playerid, TDPhone_TSButton[playerid]);
					}
				}
			}
		}
		case 7:
	    {
	        new
				callstring[128]
			;

			switch(subid)
			{
				case 0: //Dialing
				{
				    format(callstring, 128, "Dialing%s", ph_call_string[playerid]);
					PlayerTextDrawSetString(playerid, TDPhone_ScreenText[playerid], callstring);
					PlayerTextDrawShow(playerid, TDPhone_ScreenText[playerid]);

					PlayerTextDrawSetString(playerid, TDPhone_TSButton[playerid], "Hangup");
					PlayerTextDrawShow(playerid, TDPhone_TSButton[playerid]);
				}
				case 1: //Call with
				{
				    format(callstring, 128, "Call with%s", ph_call_string[playerid]);
					PlayerTextDrawSetString(playerid, TDPhone_ScreenText[playerid], callstring);
					PlayerTextDrawShow(playerid, TDPhone_ScreenText[playerid]);

					PlayerTextDrawSetString(playerid, TDPhone_TSButton[playerid], "Hangup");
					PlayerTextDrawShow(playerid, TDPhone_TSButton[playerid]);
				}
				case 2: //Incoming call
				{
				    format(callstring, 128, "Incoming call%s", ph_call_string[playerid]);
					PlayerTextDrawSetString(playerid, TDPhone_ScreenText[playerid], callstring);
					PlayerTextDrawShow(playerid, TDPhone_ScreenText[playerid]);

					PlayerTextDrawSetString(playerid, TDPhone_TFButton[playerid], "Answer");
					PlayerTextDrawShow(playerid, TDPhone_TFButton[playerid]);

					PlayerTextDrawSetString(playerid, TDPhone_TSButton[playerid], "Igonore");
					PlayerTextDrawShow(playerid, TDPhone_TSButton[playerid]);
				}
			}
		}
	    case 5: // Noti
	    {
			switch(subid)
			{
			    case 0:
			    {
					PlayerTextDrawSetString(playerid, TDPhone_ScreenText[playerid], "Contact is full");
					PlayerTextDrawShow(playerid, TDPhone_ScreenText[playerid]);

					PlayerTextDrawSetString(playerid, TDPhone_TSButton[playerid], "Close");
					PlayerTextDrawShow(playerid, TDPhone_TSButton[playerid]);
			    }
  			    case 1:
			    {
					PlayerTextDrawSetString(playerid, TDPhone_ScreenText[playerid], "Error!~n~Invalid number");
					PlayerTextDrawShow(playerid, TDPhone_ScreenText[playerid]);

					PlayerTextDrawSetString(playerid, TDPhone_TSButton[playerid], "Close");
					PlayerTextDrawShow(playerid, TDPhone_TSButton[playerid]);
			    }
  			    case 2:
			    {
					PlayerTextDrawSetString(playerid, TDPhone_ScreenText[playerid], "Notice!~n~The line is busy");
					PlayerTextDrawShow(playerid, TDPhone_ScreenText[playerid]);

					PlayerTextDrawSetString(playerid, TDPhone_TSButton[playerid], "Close");
					PlayerTextDrawShow(playerid, TDPhone_TSButton[playerid]);
			    }
  			    case 3:
			    {
					PlayerTextDrawSetString(playerid, TDPhone_ScreenText[playerid], "Call failed");
					PlayerTextDrawShow(playerid, TDPhone_ScreenText[playerid]);

					PlayerTextDrawSetString(playerid, TDPhone_TSButton[playerid], "Close");
					PlayerTextDrawShow(playerid, TDPhone_TSButton[playerid]);
			    }
  			    case 4:
			    {
					PlayerTextDrawSetString(playerid, TDPhone_ScreenText[playerid], "Sending ...");
					PlayerTextDrawShow(playerid, TDPhone_ScreenText[playerid]);

					PlayerTextDrawSetString(playerid, TDPhone_TSButton[playerid], "Close");
					PlayerTextDrawShow(playerid, TDPhone_TSButton[playerid]);
			    }
  			    case 5:
			    {
					PlayerTextDrawSetString(playerid, TDPhone_ScreenText[playerid], "Message delivered!");
					PlayerTextDrawShow(playerid, TDPhone_ScreenText[playerid]);

					PlayerTextDrawSetString(playerid, TDPhone_TSButton[playerid], "Close");
					PlayerTextDrawShow(playerid, TDPhone_TSButton[playerid]);
			    }
  			    case 6:
			    {
					PlayerTextDrawSetString(playerid, TDPhone_ScreenText[playerid], "Delivery failed");
					PlayerTextDrawShow(playerid, TDPhone_ScreenText[playerid]);

					PlayerTextDrawSetString(playerid, TDPhone_TSButton[playerid], "Close");
					PlayerTextDrawShow(playerid, TDPhone_TSButton[playerid]);
			    }
  			    case 7:
			    {
					PlayerTextDrawSetString(playerid, TDPhone_ScreenText[playerid], "No signal");
					PlayerTextDrawShow(playerid, TDPhone_ScreenText[playerid]);

					PlayerTextDrawSetString(playerid, TDPhone_TSButton[playerid], "Close");
					PlayerTextDrawShow(playerid, TDPhone_TSButton[playerid]);
			    }
			}
	    }
	    case 6: //OFF PHONE
		{
			switch(subid)
			{
			    case 0:
			    {
					PlayerTextDrawSetString(playerid, TDPhone_ScreenText[playerid], "See you!");
					PlayerTextDrawShow(playerid, TDPhone_ScreenText[playerid]);
			    }
			    case 2:
			    {
					PlayerTextDrawColor(playerid, TDPhone_ScreenText[playerid], 0x111111FF);
					PlayerTextDrawSetString(playerid, TDPhone_ScreenText[playerid], "Loading...");
					PlayerTextDrawShow(playerid, TDPhone_ScreenText[playerid]);
			    }			
			}
	    }
	    case 4: //Setting phone
	    {
			switch(subid) //Change Ringtone , airplane mode, silent mode, Phone Info
			{
			    case 0:
			    {
					PlayerTextDrawSetString(playerid, TDPhone_Choice[playerid][0], "Change Ringtone");
					PlayerTextDrawColor(playerid, TDPhone_Choice[playerid][0], (select == 0) ? 0x989898FF : 0x000000FF);
					PlayerTextDrawBoxColor(playerid, TDPhone_Choice[playerid][0], (select == 0) ? 0x222222FF : 0xAAAAAAFF);
					PlayerTextDrawShow(playerid, TDPhone_Choice[playerid][0]);

					PlayerTextDrawSetString(playerid, TDPhone_Choice[playerid][1], (ph_airmode[playerid]) ? ("Disable airplane mode") : ("Enable airplane mode"));
					PlayerTextDrawColor(playerid, TDPhone_Choice[playerid][1], (select == 1) ? 0x989898FF : 0x000000FF);
					PlayerTextDrawBoxColor(playerid, TDPhone_Choice[playerid][1], (select == 1) ? 0x222222FF : 0xAAAAAAFF);
					PlayerTextDrawShow(playerid, TDPhone_Choice[playerid][1]);

					PlayerTextDrawSetString(playerid, TDPhone_Choice[playerid][2], (ph_silentmode[playerid]) ? ("Disable silent mode") : ("Enable silent mode"));
					PlayerTextDrawColor(playerid, TDPhone_Choice[playerid][2], (select == 2) ? 0x989898FF : 0x000000FF);
					PlayerTextDrawBoxColor(playerid, TDPhone_Choice[playerid][2], (select == 2) ? 0x222222FF : 0xAAAAAAFF);
					PlayerTextDrawShow(playerid, TDPhone_Choice[playerid][2]);

					PlayerTextDrawSetString(playerid, TDPhone_Choice[playerid][3], "Phone Info");
					PlayerTextDrawColor(playerid, TDPhone_Choice[playerid][3], (select == 3) ? 0x989898FF : 0x000000FF);
					PlayerTextDrawBoxColor(playerid, TDPhone_Choice[playerid][3], (select == 3) ? 0x222222FF : 0xAAAAAAFF);
					PlayerTextDrawShow(playerid, TDPhone_Choice[playerid][3]);

					ph_page[playerid] = 0;
					ph_select_data[playerid] = -1;
			    }
			    case 1: // Ringtone
			    {
			    	PlayerTextDrawSetString(playerid, TDPhone_Choice[playerid][0], "Call ringtone");
					PlayerTextDrawColor(playerid, TDPhone_Choice[playerid][0], (select == 0) ? 0x989898FF : 0x000000FF);
					PlayerTextDrawBoxColor(playerid, TDPhone_Choice[playerid][0], (select == 0) ? 0x222222FF : 0xAAAAAAFF);
					PlayerTextDrawShow(playerid, TDPhone_Choice[playerid][0]);

					PlayerTextDrawSetString(playerid, TDPhone_Choice[playerid][1], "Text ringtone");
					PlayerTextDrawColor(playerid, TDPhone_Choice[playerid][1], (select == 1) ? 0x989898FF : 0x000000FF);
					PlayerTextDrawBoxColor(playerid, TDPhone_Choice[playerid][1], (select == 1) ? 0x222222FF : 0xAAAAAAFF);
					PlayerTextDrawShow(playerid, TDPhone_Choice[playerid][1]);

					PlayerTextDrawSetString(playerid, TDPhone_TFButton[playerid], "Select");
					PlayerTextDrawShow(playerid, TDPhone_TFButton[playerid]);

					PlayerTextDrawSetString(playerid, TDPhone_TSButton[playerid], "Back");
					PlayerTextDrawShow(playerid, TDPhone_TSButton[playerid]);
			    }
			    case 2: // Ringtone - Call
				{
					PlayerTextDrawSetString(playerid, TDPhone_Choice[playerid][0], "Ringtone 1");
					PlayerTextDrawColor(playerid, TDPhone_Choice[playerid][0], (select == 0) ? 0x989898FF : 0x000000FF);
					PlayerTextDrawBoxColor(playerid, TDPhone_Choice[playerid][0], (select == 0) ? 0x222222FF : 0xAAAAAAFF);
					PlayerTextDrawShow(playerid, TDPhone_Choice[playerid][0]);

					PlayerTextDrawSetString(playerid, TDPhone_Choice[playerid][1], "Ringtone 2");
					PlayerTextDrawColor(playerid, TDPhone_Choice[playerid][1], (select == 1) ? 0x989898FF : 0x000000FF);
					PlayerTextDrawBoxColor(playerid, TDPhone_Choice[playerid][1], (select == 1) ? 0x222222FF : 0xAAAAAAFF);
					PlayerTextDrawShow(playerid, TDPhone_Choice[playerid][1]);

					PlayerTextDrawSetString(playerid, TDPhone_Choice[playerid][2], "Ringtone 3");
					PlayerTextDrawColor(playerid, TDPhone_Choice[playerid][2], (select == 2) ? 0x989898FF : 0x000000FF);
					PlayerTextDrawBoxColor(playerid, TDPhone_Choice[playerid][2], (select == 2) ? 0x222222FF : 0xAAAAAAFF);
					PlayerTextDrawShow(playerid, TDPhone_Choice[playerid][2]);

					PlayerTextDrawSetString(playerid, TDPhone_TFButton[playerid], "Select");
					PlayerTextDrawShow(playerid, TDPhone_TFButton[playerid]);

					PlayerTextDrawSetString(playerid, TDPhone_TSButton[playerid], "Back");
					PlayerTextDrawShow(playerid, TDPhone_TSButton[playerid]);
			    }
			    case 3: // Ringtone - Text
			    {
					PlayerTextDrawSetString(playerid, TDPhone_Choice[playerid][0], "Ringtone 1");
					PlayerTextDrawColor(playerid, TDPhone_Choice[playerid][0], (select == 0) ? 0x989898FF : 0x000000FF);
					PlayerTextDrawBoxColor(playerid, TDPhone_Choice[playerid][0], (select == 0) ? 0x222222FF : 0xAAAAAAFF);
					PlayerTextDrawShow(playerid, TDPhone_Choice[playerid][0]);

					PlayerTextDrawSetString(playerid, TDPhone_Choice[playerid][1], "Ringtone 2");
					PlayerTextDrawColor(playerid, TDPhone_Choice[playerid][1], (select == 1) ? 0x989898FF : 0x000000FF);
					PlayerTextDrawBoxColor(playerid, TDPhone_Choice[playerid][1], (select == 1) ? 0x222222FF : 0xAAAAAAFF);
					PlayerTextDrawShow(playerid, TDPhone_Choice[playerid][1]);

					PlayerTextDrawSetString(playerid, TDPhone_Choice[playerid][2], "Ringtone 3");
					PlayerTextDrawColor(playerid, TDPhone_Choice[playerid][2], (select == 2) ? 0x989898FF : 0x000000FF);
					PlayerTextDrawBoxColor(playerid, TDPhone_Choice[playerid][2], (select == 2) ? 0x222222FF : 0xAAAAAAFF);
					PlayerTextDrawShow(playerid, TDPhone_Choice[playerid][2]);

					PlayerTextDrawSetString(playerid, TDPhone_Choice[playerid][3], "Ringtone 4");
					PlayerTextDrawColor(playerid, TDPhone_Choice[playerid][3], (select == 3) ? 0x989898FF : 0x000000FF);
					PlayerTextDrawBoxColor(playerid, TDPhone_Choice[playerid][3], (select == 3) ? 0x222222FF : 0xAAAAAAFF);
					PlayerTextDrawShow(playerid, TDPhone_Choice[playerid][3]);
			    }
				case 4: // Phone Info
				{
					PlayerTextDrawSetString(playerid, TDPhone_ScreenText[playerid], "Framework: v1");
					PlayerTextDrawShow(playerid, TDPhone_ScreenText[playerid]);

					PlayerTextDrawSetString(playerid, TDPhone_TSButton[playerid], "Close");
					PlayerTextDrawShow(playerid, TDPhone_TSButton[playerid]);
				}
			}
	    }
	}

	if(!PhoneOpen{playerid})
		ClosePlayerPhone(playerid, true);

	ph_selected[playerid] = select;

	//printf("menu %d sub %d", ph_menuid[playerid], ph_sub_menuid[playerid]);
}

ShowPlayerPhone(playerid)
{
    ClosePlayerPhone(playerid, true);
    SelectTextDraw(playerid, 0x58ACFAFF);

    switch(PlayerData[playerid][pPhoneModel]) //dark grey, blue, green, yellow, purple and pink.
    {
        case 0: // dark grey
        {
        	PlayerTextDrawBoxColor(playerid, TDPhone_Model[playerid][0], 286331391); // the machine
        	PlayerTextDrawColor(playerid, TDPhone_Model[playerid][1], -858993409); // Left border
        	PlayerTextDrawColor(playerid, TDPhone_Model[playerid][2], -858993409); // Right edge
        	PlayerTextDrawColor(playerid,TDPhone_Model[playerid][12], -1717986902); // Side button
        	SetPlayerAttachedObject(playerid, 9, 18868, 6, 0.0789, 0.0050, -0.0049, 84.9999, -179.2999, -1.6999, 1.0000, 1.0000, 1.0000);
        }
        case 1: // Red
		{
        	PlayerTextDrawBoxColor(playerid, TDPhone_Model[playerid][0], 1628113919);
        	PlayerTextDrawColor(playerid, TDPhone_Model[playerid][1], -16776961);
        	PlayerTextDrawColor(playerid, TDPhone_Model[playerid][2], -16776961);
        	PlayerTextDrawColor(playerid,TDPhone_Model[playerid][12], 1124534271);
        	SetPlayerAttachedObject(playerid, 9, 18870, 6, 0.0789, 0.0050, -0.0049, 84.9999, -179.2999, -1.6999, 1.0000, 1.0000, 1.0000);
        }
        case 2: // blue
		{
        	PlayerTextDrawBoxColor(playerid, TDPhone_Model[playerid][0], 405561855);
        	PlayerTextDrawColor(playerid, TDPhone_Model[playerid][1], 65535);
        	PlayerTextDrawColor(playerid, TDPhone_Model[playerid][2], 65535);
        	PlayerTextDrawColor(playerid,TDPhone_Model[playerid][12], 270418943);
        	SetPlayerAttachedObject(playerid, 9, 18872, 6, 0.0789, 0.0050, -0.0049, 84.9999, -179.2999, -1.6999, 1.0000, 1.0000, 1.0000);
        }
        case 3: // green
		{
        	PlayerTextDrawBoxColor(playerid, TDPhone_Model[playerid][0], 388831231);
        	PlayerTextDrawColor(playerid, TDPhone_Model[playerid][1], 8388863);
        	PlayerTextDrawColor(playerid, TDPhone_Model[playerid][2], 8388863);
        	PlayerTextDrawColor(playerid,TDPhone_Model[playerid][12], 270471423);
            SetPlayerAttachedObject(playerid, 9, 18871, 6, 0.0789, 0.0050, -0.0049, 84.9999, -179.2999, -1.6999, 1.0000, 1.0000, 1.0000);
        }
        case 4: // yellow
		{
        	PlayerTextDrawBoxColor(playerid, TDPhone_Model[playerid][0], 2104099071);
        	PlayerTextDrawColor(playerid, TDPhone_Model[playerid][1], -65281);
        	PlayerTextDrawColor(playerid, TDPhone_Model[playerid][2], -65281);
        	PlayerTextDrawColor(playerid,TDPhone_Model[playerid][12], 1464467711);
        	SetPlayerAttachedObject(playerid, 9, 18873, 6, 0.0789, 0.0050, -0.0049, 84.9999, -179.2999, -1.6999, 1.0000, 1.0000, 1.0000);
        }
        case 5: // orange
		{
			//ce9100ff ba7407ff ba7407ff
        	PlayerTextDrawBoxColor(playerid, TDPhone_Model[playerid][0], 0xce9100ff);
        	PlayerTextDrawColor(playerid, TDPhone_Model[playerid][1], 0xba7407ff);
        	PlayerTextDrawColor(playerid, TDPhone_Model[playerid][2], 0xba7407ff);
        	PlayerTextDrawColor(playerid,TDPhone_Model[playerid][12], 0xba7407ff);
        	SetPlayerAttachedObject(playerid, 9, 18865, 6, 0.0789, 0.0050, -0.0049, 84.9999, -179.2999, -1.6999, 1.0000, 1.0000, 1.0000);
        }
        case 6: // pink
		{
        	PlayerTextDrawBoxColor(playerid, TDPhone_Model[playerid][0], -2063576577);
        	PlayerTextDrawColor(playerid, TDPhone_Model[playerid][1], -16711681);
        	PlayerTextDrawColor(playerid, TDPhone_Model[playerid][2], -16711681);
        	PlayerTextDrawColor(playerid,TDPhone_Model[playerid][12], 1560295679);
        	SetPlayerAttachedObject(playerid, 9, 18869, 6, 0.0789, 0.0050, -0.0049, 84.9999, -179.2999, -1.6999, 1.0000, 1.0000, 1.0000);
		}
    }

    for(new i = 0; i != 14; ++i)
	{
		PlayerTextDrawShow(playerid, TDPhone_Model[playerid][i]);
	}

	PhoneOpen{playerid} = true;

	RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], ph_selected[playerid]);
}

ClosePlayerPhone(playerid, bool:noforce = false)
{
	HidePlayerPhoneText(playerid);

    for(new i = 0; i != 14; ++i) PlayerTextDrawHide(playerid, TDPhone_Model[playerid][i]);

	if(!noforce)
	{
	    // reset values
		ph_menuid[playerid] = 0;
		ph_sub_menuid[playerid] = 0;
		ph_selected[playerid] = 0;
		ph_select_data[playerid] = -1;
		ph_page[playerid] = 0;
	    CancelSelectTextDraw(playerid);
	}

    PhoneOpen{playerid} = false;
}

HidePlayerPhoneText(playerid)
{
	for(new i = 0; i != 4; ++i) PlayerTextDrawHide(playerid, TDPhone_Choice[playerid][i]);

	PlayerTextDrawHide(playerid, TDPhone_BigText[playerid]);
	PlayerTextDrawHide(playerid, TDPhone_ScreenText[playerid]);
	PlayerTextDrawHide(playerid, TDPhone_TFButton[playerid]);
	PlayerTextDrawHide(playerid, TDPhone_TSButton[playerid]);
	PlayerTextDrawHide(playerid, TDPhone_Signal[playerid]);
	PlayerTextDrawHide(playerid, TDPhone_NotifyText[playerid]);
	PlayerTextDrawHide(playerid, TDPhone_Picture[playerid]);
}

OnPhoneEvent(playerid, menuid, subid, eventid)
{
	switch(menuid)
	{
		case 0: // MAIN
		{
			switch(subid)
			{
				case 0: // Clock
				{
				    switch(eventid)
				    {
				        case PH_LBUTTON:
				        {
							RenderPlayerPhone(playerid, ph_menuid[playerid], 1);
				        }
  				        case PH_RBUTTON:
				        {
				            ClosePlayerPhone(playerid, true);
				            CancelSelectTextDraw(playerid);

				            RemovePlayerAttachedObject(playerid, 9);

						    Annotation(playerid, "puts their phone away.");
				        }
				    }
				}
 				case 1: // Main Menu { Phonebook, SMS, Calls, Settings }
				{
  				    switch(eventid)
				    {
				        case PH_DOWN:
				        {
							if(ph_selected[playerid] < 3)
							{
							    ph_selected[playerid]++;
							}

							RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], ph_selected[playerid]);
						}
  				        case PH_UP:
				        {
							if(ph_selected[playerid] > 0)
							{
							    ph_selected[playerid]--;
							}

							RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], ph_selected[playerid]);
				        }
				        case PH_LBUTTON, PH_CLICKOPEN:
				        {
							ph_menuid[playerid] = ph_selected[playerid] + 1;
							ph_sub_menuid[playerid] = 0;

							RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
				        }
				        case PH_RBUTTON:
				        {
                    		ph_sub_menuid[playerid] = 0;

						    RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
				        }
				    }
				}
			}
		}
		case 1: // PHONEBOOK
		{
			switch(subid)
			{
				case 0: // Main Phonebook { Add a contact, List contacts }
				{
				  	switch(eventid)
				    {
				        case PH_DOWN:
				        {
							if(ph_selected[playerid] < 1)
							{
							    ph_selected[playerid]++;
							}

							RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], ph_selected[playerid]);
						}
  				        case PH_UP:
				        {
							if(ph_selected[playerid] > 0)
							{
							    ph_selected[playerid]--;
							}

							RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], ph_selected[playerid]);
            			}
				        case PH_RBUTTON:
				        {
                    		ph_menuid[playerid]--;
                    		ph_sub_menuid[playerid]++;

						    RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
				        }
				        case PH_CLICKOPEN, PH_LBUTTON:
				        {
                    		if(ph_selected[playerid] == 0)
                    		{
                    			Dialog_Show(playerid, AddContact, DIALOG_STYLE_INPUT, "Insert name", "Add a contact\n\n\t\tEnter the contact name:", "Proceed", "Back");
                    		}
                    		else
                    		{
                    		    ph_sub_menuid[playerid]++;

                    		    RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
							}
				        }
					}
				}
 				case 1: // List contacts
				{
				  	switch(eventid)
				    {
				        case PH_DOWN:
				        {
							new count = 0;

							for(new i = 0; i != 4; ++i) if(ph_data[playerid][i] != -1) count++;

							if(ph_selected[playerid] < count-1)
							{
							    ph_selected[playerid]++;
							}
							else
							{
							    if(ph_selected[playerid] == 3)
							    {
				                    for(new i = ph_data[playerid][3]; i != 40; ++i)
				                    {
				                    	if(ContactData[playerid][i][contactNumber])
								        {
									        ph_selected[playerid] = 0;
									        ph_page[playerid]++;
											break;
										}
									}
							    }
							}

							ph_select_data[playerid] = ph_data[playerid][ph_selected[playerid]] - 1;
							RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], ph_selected[playerid]);
						}
  				        case PH_UP:
				        {
							if(ph_selected[playerid] > 0)
							{
							    ph_selected[playerid]--;
							}
							else
							{
							    if(ph_selected[playerid] == 0 && ph_page[playerid] > 0)
							    {
									ph_selected[playerid] = 3;
									ph_page[playerid]--;
							    }
							}

							ph_select_data[playerid] = ph_data[playerid][ph_selected[playerid]] - 1;
							RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], ph_selected[playerid]);
            			}
				        case PH_RBUTTON:
				        {
                    		ph_sub_menuid[playerid]--;

						    RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
				        }
				        case PH_CLICKOPEN, PH_LBUTTON:
				        {
						    if(ph_select_data[playerid] == -1)
								ph_select_data[playerid] = ph_data[playerid][ph_selected[playerid]] - 1;

	                   		ph_sub_menuid[playerid]++;

	                   		RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
				        }
					}
				}
 				case 2: // Details NAME (NUMBER)
				{
				  	switch(eventid)
				    {
				        case PH_LBUTTON:
				        {
                    		ph_sub_menuid[playerid]++;

						    RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
				        }
				        case PH_RBUTTON:
				        {
							ph_page[playerid] = 0;
							ph_select_data[playerid] = -1;

                    		ph_sub_menuid[playerid]--;

						    RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
				        }
					}
				}
 				case 3: // ACTION
				{
				  	switch(eventid)
   					{
				        case PH_DOWN:
				        {
							if(ph_selected[playerid] < 2)
							{
							    ph_selected[playerid]++;
							}

							RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], ph_selected[playerid]);
						}
  				        case PH_UP:
				        {
							if(ph_selected[playerid] > 0)
							{
							    ph_selected[playerid]--;
							}

							RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], ph_selected[playerid]);
				        }
				        case PH_LBUTTON, PH_CLICKOPEN:
				        {
							switch(ph_selected[playerid])
							{
							    case 0:
								{
									new nstring[24];
			   						Int32(nstring, ContactData[playerid][ph_select_data[playerid]][contactNumber]);
									CallNumber(playerid, nstring);
								}
							    case 1:
								{
									new nstring[24];
			   						Int32(nstring, ContactData[playerid][ph_select_data[playerid]][contactNumber]);
							        SetPVarString(playerid,"SMSPhoneNumber", nstring);
									Dialog_Show(playerid, SMSText, DIALOG_STYLE_INPUT, "Short Message Service", "Fill out the text:", "Send", "Back");
                       			}
								case 2: Dialog_Show(playerid, DeleteContact, DIALOG_STYLE_MSGBOX, "Are you sure?", "Are you sure you want to delete it? %s (%d) Out of contact list?", "Yes", "No", ContactData[playerid][ph_select_data[playerid]][contactName], ContactData[playerid][ph_select_data[playerid]][contactNumber]);
							}
				        }
				        case PH_RBUTTON:
				        {
                    		ph_sub_menuid[playerid]--;

						    RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
				        }
					}
				}
 				/*case 4: // ACTION -> Call, Text, Delete
				{
					new i = ph_data[playerid][ph_selected[playerid]];
					format(str, 32, "~n~%s~n~(%d)", ContactData[playerid][i][contactName], ContactData[playerid][i][contactNumber]);
				  	switch(eventid)
				    {
				        case PH_RBUTTON:
				        {
                    		ph_sub_menuid[playerid]--;
						    RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
				        }
					}
				}*/
			}
		}
		case 2: // SMS
		{
			switch(subid)
			{
				case 0: // Main SMS { SMS a contact, SMS a number, Inbox, Archive }
				{
  				  	switch(eventid)
   					{
				        case PH_LBUTTON, PH_CLICKOPEN:
				        {
							ph_sub_menuid[playerid] = ph_selected[playerid] + 1;

							if(ph_sub_menuid[playerid] == 2)
							{
							    ph_sub_menuid[playerid] = 0;

							    RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], 1);

								Dialog_Show(playerid, SMSNumber, DIALOG_STYLE_INPUT, "Insert number", "Send SMS via phone number\n\n\t\tEnter contact number:", "Proceed", "Back");
							}
							else
							{
								RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
							}
				        }
				        case PH_RBUTTON:
				        {
						    RenderPlayerPhone(playerid, 0, 1);
				        }
				        case PH_DOWN:
				        {
							if(ph_selected[playerid] < 3)
							{
							    ph_selected[playerid]++;
							}

							RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], ph_selected[playerid]);
						}
  				        case PH_UP:
				        {
							if(ph_selected[playerid] > 0)
							{
							    ph_selected[playerid]--;
							}

							RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], ph_selected[playerid]);
				        }
					}
				}
 				case 1: // SMS a contact
				{
					switch(eventid)
				    {
				        case PH_DOWN:
				        {
							new count = 0;

							for(new i = 0; i != 4; ++i) if(ph_data[playerid][i] != -1) count++;

							if(ph_selected[playerid] < count-1)
							{
							    ph_selected[playerid]++;
							}
							else
							{
							    if(ph_selected[playerid] == 3)
							    {
				                    for(new i = ph_data[playerid][3]; i != 40; ++i)
				                    {
				                    	if(ContactData[playerid][i][contactNumber])
								        {
									        ph_selected[playerid] = 0;
									        ph_page[playerid]++;
											break;
										}
									}
							    }
							}

							ph_select_data[playerid] = ph_data[playerid][ph_selected[playerid]] - 1;

							RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], ph_selected[playerid]);
						}
  				        case PH_UP:
				        {
							if(ph_selected[playerid] > 0)
							{
							    ph_selected[playerid]--;
							}
							else
							{
							    if(ph_selected[playerid] == 0 && ph_page[playerid] > 0)
							    {
									ph_selected[playerid]=3;
									ph_page[playerid]--;
							    }
							}

							ph_select_data[playerid] = ph_data[playerid][ph_selected[playerid]] - 1;

							RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], ph_selected[playerid]);
            			}
				        case PH_RBUTTON:
				        {
                    		ph_sub_menuid[playerid]--;

						    RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
				        }
				        case PH_CLICKOPEN, PH_LBUTTON:
				        {
						    if(ph_select_data[playerid] == -1)
								ph_select_data[playerid] = ph_data[playerid][ph_selected[playerid]] - 1;

							new nstring[24];
			   				Int32(nstring, ContactData[playerid][ph_select_data[playerid]][contactNumber]);
							SetPVarString(playerid, "SMSPhoneNumber", nstring);

							Dialog_Show(playerid, SMSText, DIALOG_STYLE_INPUT, "Short Message Service", "Fill in:", "Send", "Back");
				        }
					}
				}
 				/*case 2: // SMS a number
				{

				}*/
 				case 3, 4: // 3- Inbox 4- Archive
				{
					switch(eventid)
				    {
						case PH_DOWN:
				        {
							new count = 0;

							for(new i = 0; i != 4; ++i) if(ph_data[playerid][i] != -1) count++;

							if(ph_selected[playerid] < count-1)
							{
							    ph_selected[playerid]++;
							}
							else
							{
							    if(ph_selected[playerid] == 3)
							    {
				                    for(new i=ph_data[playerid][3]; i != MAX_SMS; ++i)
									{
										if(subid == 3 && !SmsData[playerid][i][smsArchive] || subid == 4 && SmsData[playerid][i][smsArchive])
					                    {
					                    	if(SmsData[playerid][i][smsExist])
									        {
										        ph_selected[playerid] = 0;
										        ph_page[playerid]++;
												break;
											}
										}
									}
							    }
							}

							ph_select_data[playerid] = ph_data[playerid][ph_selected[playerid]] - 1;
							RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], ph_selected[playerid]);
						}
  				        case PH_UP:
				        {
							if(ph_selected[playerid] > 0)
							{
							    ph_selected[playerid] --;
							}
							else
							{
							    if(ph_selected[playerid] == 0 && ph_page[playerid] > 0)
							    {
									ph_selected[playerid] = 3;
									ph_page[playerid] --;
							    }
							}

							ph_select_data[playerid] = ph_data[playerid][ph_selected[playerid]] - 1;

							RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], ph_selected[playerid]);
            			}
				        case PH_RBUTTON:
				        {
                    		ph_sub_menuid[playerid] = 0;

						    RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
				        }
				        case PH_CLICKOPEN, PH_LBUTTON:
				        {
						    ph_select_data[playerid] = ph_data[playerid][ph_selected[playerid]] - 1;

							new id = ph_select_data[playerid];

							if(SmsData[playerid][id][smsRead])
							{
								Dialog_Show(playerid, SMSRead, DIALOG_STYLE_MSGBOX, "SMS", "{A9C4E4}Sender:\t\t{7e98b6}%s\n{A9C4E4}Sent:  \t\t{7e98b6}%s\n\n{A9C4E4}%s", "Options", "Close", GetContactName(playerid, SmsData[playerid][id][smsOwner]), SmsData[playerid][id][smsDate], SmsData[playerid][id][smsText]);
	                        }
							else
							{
								SmsData[playerid][id][smsRead] = 1;

								RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], ph_selected[playerid]);
							}
				        }
					}
				}
			}
		}
		case 3: // Calls
		{
			switch(subid)
			{
				case 0: // Calls SMS { Dial a contact, Dial a number, View call history }
				{
  				  	switch(eventid)
   					{
				        case PH_LBUTTON, PH_CLICKOPEN:
				        {
							ph_sub_menuid[playerid] = ph_selected[playerid] + 1;

							if(ph_sub_menuid[playerid] == 2)
							{
							    ph_sub_menuid[playerid] = 0;

							    RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], 1);

								Dialog_Show(playerid, CallNumber, DIALOG_STYLE_INPUT, "Insert a number", "Insert number you want to call.", "Call", "Cancel");
							}
							else
							{
								RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
							}
				        }
				        case PH_RBUTTON:
				        {
                    		ph_menuid[playerid] = 0;
                    		ph_sub_menuid[playerid] = 1;

						    RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
				        }
				        case PH_DOWN:
				        {
							if(ph_selected[playerid] < 3)
							{
							    ph_selected[playerid]++;
							}

							RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], ph_selected[playerid]);
						}
  				        case PH_UP:
				        {
							if(ph_selected[playerid] > 0)
							{
							    ph_selected[playerid]--;
							}

							RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], ph_selected[playerid]);
				        }
					}
				}
 				case 1: // Dial a contact
				{
					switch(eventid)
				    {
				        case PH_DOWN:
				        {
							new count = 0;

							for(new i = 0; i != 4; ++i) if(ph_data[playerid][i] != -1) count++;

							if(ph_selected[playerid] < count - 1)
							{
							    ph_selected[playerid]++;
							}
							else
							{
							    if(ph_selected[playerid] == 3)
							    {
				                    for(new i = ph_data[playerid][3]; i < 40; ++i)
				                    {
				                    	if(ContactData[playerid][i][contactNumber])
								        {
									        ph_selected[playerid] = 0;
									        ph_page[playerid]++;
											break;
										}
									}
							    }
							}

							ph_select_data[playerid] = ph_data[playerid][ph_selected[playerid]] - 1;

							RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], ph_selected[playerid]);
						}
  				        case PH_UP:
				        {
							if(ph_selected[playerid] > 0)
							{
							    ph_selected[playerid]--;
							}
							else
							{
							    if(ph_selected[playerid] == 0 && ph_page[playerid] > 0)
							    {
									ph_selected[playerid] = 3;
									ph_page[playerid]--;
							    }
							}

							ph_select_data[playerid] = ph_data[playerid][ph_selected[playerid]] - 1;

							RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], ph_selected[playerid]);
            			}
				        case PH_RBUTTON:
				        {
                    		ph_sub_menuid[playerid]--;

						    RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
				        }
				        case PH_CLICKOPEN, PH_LBUTTON:
				        {
						    if(ph_select_data[playerid] == -1)
								ph_select_data[playerid] = ph_data[playerid][ph_selected[playerid]] - 1;

							new id = ph_select_data[playerid], nstring[24];
						  	Int32(nstring, ContactData[playerid][id][contactNumber]);
							CallNumber(playerid, nstring);
				        }
					}
				}
 				case 3: // View call history
				{
				  	switch(eventid)
				    {
				        case PH_CLICKOPEN, PH_LBUTTON:
				        {
						    if(ph_select_data[playerid] == -1)
								ph_select_data[playerid] = ph_data[playerid][ph_selected[playerid]] - 1;

							new id = ph_select_data[playerid], str[64], list[256];
							new Iscontact = GetContactID(playerid, CallHistory[playerid][id][chNumber]);
							if(Iscontact == -1) format(str, 64, "%s%d", (!CallHistory[playerid][id][chType]) ? ("Outgoing call to ") : (CallHistory[playerid][id][chType] == 2) ? ("Missed call form ") : ("Incoming call form "), CallHistory[playerid][id][chNumber]);
							else format(str, 64, "%s%s (%d)", (!CallHistory[playerid][id][chType]) ? ("Outgoing call to ") : (CallHistory[playerid][id][chType] == 2) ? ("Missed call form ") : ("Incoming call form "), ContactData[playerid][Iscontact][contactName], ContactData[playerid][Iscontact][contactNumber]);

							CallHistory[playerid][id][chRead] = true;

							new diff = gettime()-CallHistory[playerid][id][chSec];
							new mins, hours;
							format(list, 256, "%s\n%s ago\nCall\nText\n%s", str, ConvertTime(diff, mins, hours), (GetContactID(playerid,CallHistory[playerid][id][chNumber]) == -1) ? ("Save number") : ("View contact"));
							Dialog_Show(playerid, CallHistoryDialog, DIALOG_STYLE_LIST, str, list, "Select", "Close");
				        }
				        case PH_DOWN:
				        {
							new count = 0;

							for(new i = 0; i != 4; ++i) if(ph_data[playerid][i] != -1) count++;

							if(ph_selected[playerid] < count-1)
							{
							    ph_selected[playerid]++;
							}
							else
							{
							    if(ph_selected[playerid] == 3)
							    {
				                    for(new i = ph_data[playerid][3]; i < MAX_CALLHISTORY; ++i)
				                    {
				                    	if(CallHistory[playerid][i][chExists])
								        {
									        ph_selected[playerid] = 0;
									        ph_page[playerid]++;
											break;
										}
									}
							    }
							}

							ph_select_data[playerid] = ph_data[playerid][ph_selected[playerid]] - 1;
							RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], ph_selected[playerid]);
						}
  				        case PH_UP:
				        {
							if(ph_selected[playerid] > 0)
							{
							    ph_selected[playerid]--;
							}
							else
							{
							    if(ph_selected[playerid] == 0 && ph_page[playerid] > 0)
							    {
									ph_selected[playerid]=3;
									ph_page[playerid]--;
							    }
							}
							ph_select_data[playerid] = ph_data[playerid][ph_selected[playerid]] - 1;
							RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], ph_selected[playerid]);
            			}
				        case PH_RBUTTON: RenderPlayerPhone(playerid, 3, 0);
					}
				}
			}
		}
	    case 4: // Phone Settings
		{
			switch(subid)
			{
				case 0: //Change Ringtone , airplane mode, silent mode, Phone Info
				{
  				  	switch(eventid)
   					{
				        case PH_LBUTTON, PH_CLICKOPEN:
				        {
							switch(ph_selected[playerid])
							{
							    case 0: ph_sub_menuid[playerid] = 1;
			                	case 1:
								{
		                            if(ph_airmode[playerid]) ph_airmode[playerid] = 0;
		                            else ph_airmode[playerid] = 1;
								}
			                	case 2:
								{
		                            if(ph_silentmode[playerid]) ph_silentmode[playerid] = 0;
		                            else ph_silentmode[playerid] = 1;
								}
							    case 3: ph_sub_menuid[playerid] = 4;
       						}

							RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], ph_selected[playerid]);
				        }
				        case PH_RBUTTON:
				        {
						    RenderPlayerPhone(playerid, 0, 1);
				        }
				        case PH_DOWN:
				        {
							if(ph_selected[playerid] < 3)
							{
							    ph_selected[playerid]++;
							}

							RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], ph_selected[playerid]);
						}
  				        case PH_UP:
				        {
							if(ph_selected[playerid] > 0)
							{
							    ph_selected[playerid]--;
							}

							RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], ph_selected[playerid]);
				        }
					}
				}
				case 1: //Change Ringtone => Call ringtone, Text ringtone
				{
  				  	switch(eventid)
   					{
				        case PH_LBUTTON, PH_CLICKOPEN:
				        {
							switch(ph_selected[playerid])
							{
							    case 0: ph_sub_menuid[playerid] = 2;
							    case 1: ph_sub_menuid[playerid] = 3;
       						}

							RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
				        }
				        case PH_RBUTTON:
				        {
                    		ph_menuid[playerid] = 4;
                    		ph_sub_menuid[playerid] = 0;

						    RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
				        }
				        case PH_DOWN:
				        {
							if(ph_selected[playerid] < 1)
							{
							    ph_selected[playerid]++;
							}

							RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], ph_selected[playerid]);
						}
  				        case PH_UP:
				        {
							if(ph_selected[playerid] > 0)
							{
							    ph_selected[playerid]--;
							}

							RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], ph_selected[playerid]);
				        }
					}
				}
				case 2: //Call ringtone (1 2 3)
				{
  				  	switch(eventid)
   					{
				        case PH_LBUTTON, PH_CLICKOPEN:
				        {
				            SetPVarInt(playerid, "ringtype", 0);

							Dialog_Show(playerid, CallRingtone, DIALOG_STYLE_MSGBOX, "Confirm", "Would you like to use this ringtone?", "Yes", "No");
				        }
				        case PH_RBUTTON:
				        {
                    		ph_menuid[playerid] = 4;
                    		ph_sub_menuid[playerid] = 1;

						    RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
				        }
				        case PH_DOWN:
				        {
							if(ph_selected[playerid] < 2)
							{
							    ph_selected[playerid]++;
							}

							PreviewCallTone(playerid, ph_selected[playerid]);

							RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], ph_selected[playerid]);
						}
  				        case PH_UP:
				        {
							if(ph_selected[playerid] > 0)
							{
							    ph_selected[playerid]--;
							}

							PreviewCallTone(playerid, ph_selected[playerid]);

							RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], ph_selected[playerid]);
				        }
					}
				}
				case 3: //Text ringtone (1 2 3 4)
				{
  				  	switch(eventid)
   					{
				        case PH_LBUTTON, PH_CLICKOPEN:
				        {
				            SetPVarInt(playerid, "ringtype", 1);

							Dialog_Show(playerid, CallRingtone, DIALOG_STYLE_MSGBOX, "Confirm", "Would you like to use this ringtone?", "Yes", "No");
				        }
				        case PH_RBUTTON:
				        {
						    RenderPlayerPhone(playerid, 4, 1);
				        }
				        case PH_DOWN:
				        {
							if(ph_selected[playerid] < 3)
							{
							    ph_selected[playerid]++;
							}

							PreviewTextTone(playerid, ph_selected[playerid]);

							RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], ph_selected[playerid]);
						}
  				        case PH_UP:
				        {
							if(ph_selected[playerid] > 0)
							{
							    ph_selected[playerid]--;
							}

							PreviewTextTone(playerid, ph_selected[playerid]);

							RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], ph_selected[playerid]);
				        }
					}
				}
				case 4: //Info
				{
  				  	switch(eventid)
   					{
				        case PH_RBUTTON:
				        {
						    RenderPlayerPhone(playerid, 4, 0);
				        }
					}
				}
			}
		}
		case 5: // Notify
		{
			switch(subid)
			{
				case 0..7: //
				{
				  	switch(eventid)
				    {
				        case PH_RBUTTON:
				        {
						    RenderPlayerPhone(playerid, 1, 0);
				        }
					}
				}
			}
		}
		case 7: // Dialing / Call with ...
		{
			switch(subid)
			{
				case 0: // Dialing
				{
				  	switch(eventid)
				    {
				        case PH_RBUTTON:
				        {
							if(calltimer[playerid])
							{
								KillTimer(calltimer[playerid]);

								calltimer[playerid] = 0;
							}

                            new targetid = PlayerData[playerid][pCallConnect];

							if(targetid != INVALID_PLAYER_ID)
				            {
                                AddPlayerCallHistory(targetid, PlayerData[playerid][pPnumber], PH_MISSED);

								SendClientMessage(targetid, COLOR_GRAD2, "[ ! ] They hung up.");

	          					PlayerData[targetid][pCallConnect] = INVALID_PLAYER_ID;
	          					PlayerData[targetid][pCallLine] = INVALID_PLAYER_ID;

							    RenderPlayerPhone(targetid, 0, 0);

							    SetPlayerSpecialAction(targetid, SPECIAL_ACTION_STOPUSECELLPHONE);
							}

                    		PlayerData[playerid][pCallLine] = INVALID_PLAYER_ID;
                    		PlayerData[playerid][pCallConnect] = INVALID_PLAYER_ID;

						    RenderPlayerPhone(playerid, 0, 0);

						    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
				        }
					}
				}
				case 1: // Call with
				{
				  	switch(eventid)
				    {
				        case PH_RBUTTON: //Terminate current
				        {
							new targetid = PlayerData[playerid][pCallConnect];

							if(targetid != INVALID_PLAYER_ID)
				            {
				                SendClientMessage(targetid, COLOR_GRAD2, "[ ! ] They hung up.");

								PlayerData[targetid][pCellTime] = 0;
								PlayerData[targetid][pCallLine] = INVALID_PLAYER_ID;

							    RenderPlayerPhone(targetid, 0, 0);

							    SetPlayerSpecialAction(targetid, SPECIAL_ACTION_STOPUSECELLPHONE);

							    PlayerData[targetid][pCallConnect] = INVALID_PLAYER_ID;
							}

							SendClientMessage(playerid, COLOR_GRAD2, "[ ! ] You hung up.");

							PlayerData[playerid][pCellTime] = 0;
							PlayerData[playerid][pCallLine] = INVALID_PLAYER_ID;
							PlayerData[playerid][pCallConnect] = INVALID_PLAYER_ID;

							RenderPlayerPhone(playerid, 0, 0);

							SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
				        }
					}
				}
				case 2: // Incoming
				{
				  	switch(eventid)
				    {
				        case PH_LBUTTON: //Receive calls
				        {
							new targetid = PlayerData[playerid][pCallConnect];

							if(targetid != INVALID_PLAYER_ID)
				            {
				                SendClientMessage(targetid, COLOR_GREY, "[ ! ] You can talk now by using the chat box.");

								PlayerData[targetid][pCellTime] = 0;
								PlayerData[targetid][pCallLine] = playerid;

	                    		ph_sub_menuid[targetid] += 1;

							    RenderPlayerPhone(targetid, ph_menuid[targetid], ph_sub_menuid[targetid]);

							    AddPlayerCallHistory(playerid, PlayerData[targetid][pPnumber], PH_INCOMING);
							}

							PlayerData[playerid][pIncomingCall] = 0;
							PlayerData[playerid][pCellTime] = 0;
							PlayerData[playerid][pCallLine] = targetid;

                    		ph_sub_menuid[playerid] -= 1;

						    RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);

						    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
				        }
				        case PH_RBUTTON: //Cancel incoming calls
				        {
				            new targetid = PlayerData[playerid][pCallConnect];

				            if(targetid != INVALID_PLAYER_ID)
				            {
				                SendClientMessage(targetid, COLOR_GRAD2, "[ ! ] They hung up.");

							    RenderPlayerPhone(targetid, 0, 0);

							    SetPlayerSpecialAction(targetid, SPECIAL_ACTION_STOPUSECELLPHONE);

							    PlayerData[targetid][pCallConnect] = INVALID_PLAYER_ID;
                            	PlayerData[targetid][pCallLine] = INVALID_PLAYER_ID;

							    AddPlayerCallHistory(playerid, PlayerData[targetid][pPnumber], PH_MISSED);
				            }

							SendClientMessage(playerid, COLOR_GRAD2, "[ ! ] You hung up.");

				        	PlayerData[playerid][pIncomingCall] = 0;
				        	PlayerData[playerid][pCallConnect] = INVALID_PLAYER_ID;
							PlayerData[playerid][pCallLine] = INVALID_PLAYER_ID;

						    RenderPlayerPhone(playerid, 0, 0);
				        }
					}
				}
			}
		}
	}
}

FUNX::SendPlayerSMS(playerid, numberid, number)
{
	new text[128], query[256], exist = -1, phonenumb;

    GetPVarString(playerid, "SMSPhoneText", text, 128);
    DeletePVar(playerid, "SMSPhoneText");

    smstimer[playerid] = 0;

	new
		targetid = INVALID_PLAYER_ID
	;

  	foreach (new i : Player)
	{
		if(PlayerData[playerid][pPnumber] != PlayerData[i][pPnumber] && ((numberid != -1 && PlayerData[i][pPnumber] == ContactData[playerid][numberid][contactNumber]) || (number > 0 && PlayerData[i][pPnumber] == number)))
		{
			targetid = i;

			if(number > 0 && PlayerData[i][pPnumber] == number) phonenumb = number;
			else phonenumb = PlayerData[i][pPnumber];

			break;
		}
	}

	if(targetid != INVALID_PLAYER_ID && GetPhoneSignal(targetid) && !ph_airmode[targetid] && ph_menuid[targetid] != 6 && !DeathMode{targetid} && !PlayerData[targetid][pInjured] && !PlayerData[targetid][pJailed])
	{
		for(new x = 0; x < MAX_SMS; ++x)
		{
			if(!SmsData[targetid][x][smsExist])
			{
				exist = x;
				break;
			}
		}

		if(exist != -1)
		{
			if(!PhoneOpen{targetid}) ShowPlayerPhone(targetid);
		    RenderPlayerPhone(targetid, ph_menuid[targetid], ph_sub_menuid[targetid]);
		    ShowEmo_Phone(targetid, 3);
		  	if(!ph_silentmode[targetid]) PlayPlayerTextTone(targetid);

			new pdate[24];
			format(pdate, 24, "%s", ReturnPhoneDateTime());

			SmsData[targetid][exist][smsExist] = true;
			SmsData[targetid][exist][smsOwner] = PlayerData[playerid][pPnumber];
			SmsData[targetid][exist][smsReceive] = phonenumb;
			SmsData[targetid][exist][smsArchive] = 0;
			SmsData[targetid][exist][smsRead] = 0;
			format(SmsData[targetid][exist][smsText], 128, text);
			format(SmsData[targetid][exist][smsDate], 24, pdate);

			mysql_format(dbCon, query, sizeof(query), "INSERT INTO `phone_sms` (`PhoneReceive`, `PhoneOwner`, `PhoneSMS`, `ReadSMS`, `Archive`, `Date`) VALUES ('%d', '%d', '%e', '0', '0', '%e');", phonenumb, PlayerData[playerid][pPnumber], text, pdate);
			mysql_pquery(dbCon, query, "OnPhoneInsertSMS", "dd", targetid, exist);						

			RenderPlayerPhone(playerid, 5, 5);
	        ShowEmo_Phone(playerid, 1);
			GameTextForPlayer(playerid, "~r~$-1", 5000, 1);
			TakePlayerMoney(playerid, 1);
		    return true;
	    }
	}

	ph_menuid[playerid] = 5;
	ph_sub_menuid[playerid] = 6;
	
	ShowEmo_Phone(playerid, 2);
	
	RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
	return true;
}

FUNX::OnPhoneInsertSMS(targetid, exist)
{
	if(IsPlayerConnected(targetid))
	{
		SmsData[targetid][exist][smsID] = cache_insert_id();
	}
}

FUNX::SendPlayerCall(playerid, signal, number, numberid)
{
	calltimer[playerid] = 0;

	if(!signal)
	{
		ph_menuid[playerid] = 5;
		ph_sub_menuid[playerid] = 7;

		RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
	    return 1;
	}

	new targetid = INVALID_PLAYER_ID;

  	foreach (new i : Player)
	{
		if(PlayerData[playerid][pPnumber] != PlayerData[i][pPnumber] && ((numberid != -1 && PlayerData[i][pPnumber] == ContactData[playerid][numberid][contactNumber]) || (number > 0 && PlayerData[i][pPnumber] == number)))
		{
			targetid = i;
			number = PlayerData[i][pPnumber];
			break;
		}
	}

	if(targetid != INVALID_PLAYER_ID && PlayerData[targetid][pSpectating] == INVALID_PLAYER_ID && GetPhoneSignal(targetid) && !ph_airmode[targetid] && ph_menuid[targetid] != 6 && !DeathMode{targetid} && !PlayerData[targetid][pInjured] && !PlayerData[targetid][pJailed])
	{
	    if(PlayerData[targetid][pCallLine] != INVALID_PLAYER_ID)
	    {
		 	ph_menuid[playerid] = 5;
			ph_sub_menuid[playerid] = 2;
			RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
			SetPlayerSpecialAction(playerid,SPECIAL_ACTION_STOPUSECELLPHONE);
			return true;
	    }

		if(!PhoneOpen{targetid})
		{
			SendClientMessage(targetid, COLOR_WHITE, "[ ! ] Note: To toggle the phone, use /phone. To bring up the mouse, use /pc.");
			ShowPlayerPhone(targetid);
		}

		if(!ph_silentmode[targetid])
		{
			PlayPlayerCallTone(targetid);

			AnnounceMyAction(targetid, "phone begins to ring.");

			SendClientMessage(targetid, COLOR_GREY, "[ ! ] To pick up the call, use /pickup");
		}

		new tar_contact = -1;

		for(new i = 0; i != 40; ++i)
		{
			if(ContactData[targetid][i][contactNumber] == PlayerData[playerid][pPnumber])
			{
				tar_contact = i;
				break;
			}
		}

		if(tar_contact == -1)
		{
			format(ph_call_string[targetid], 64, "~n~%d", PlayerData[playerid][pPnumber]);
		}
		else format(ph_call_string[targetid], 64, "~n~%s~n~(%d)", ContactData[targetid][tar_contact][contactName], ContactData[targetid][tar_contact][contactNumber]);

		PlayerData[targetid][pIncomingCall] = 1;
		PlayerData[targetid][pCallLine] = playerid;

		ph_menuid[targetid] = 7;
		ph_sub_menuid[targetid] = 2;
		RenderPlayerPhone(targetid, ph_menuid[targetid], ph_sub_menuid[targetid]);
        PlayerData[targetid][pCallConnect] = playerid;

        // Person variable phone
        PlayerData[playerid][pCallConnect] = targetid;
		return true;
	}

	ph_menuid[playerid] = 5;
	ph_sub_menuid[playerid] = 3;

	RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
	return true;
}

Dialog:CallHistoryDialog(playerid, response, listitem, inputtext[])
{
	if(response)
	{
	    new id = ph_select_data[playerid], nstring[24];

		switch(listitem)
		{
		    case 2:
			{
			  	Int32(nstring, CallHistory[playerid][id][chNumber]);
				CallNumber(playerid, nstring);
		    }
		    case 3:
			{
			 	Int32(nstring, CallHistory[playerid][id][chNumber]);

				SetPVarString(playerid, "SMSPhoneNumber", nstring);

				Dialog_Show(playerid, SMSText, DIALOG_STYLE_INPUT, "Short Message Service", "Fill in:", "Send", "Back");
		    }
		    case 4:
			{
                new exist = -1;

				if((exist = GetContactID(playerid, CallHistory[playerid][id][chNumber])) != -1)
				{
		           	ph_menuid[playerid] = 1;
		       		ph_sub_menuid[playerid]=2;
		       		ph_page[playerid] = 0;
		       		ph_select_data[playerid]=exist;

		       		RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
				}
				else
				{
				    Dialog_Show(playerid, AddHistoryContact, DIALOG_STYLE_INPUT, "Insert name", "Add a contact\n\n\t\tInsert contact name:", "Proceed", "Back");
				}
		    }
		}
	}
	return true;
}

Dialog:CallRingtone(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		if(!GetPVarInt(playerid, "ringtype")) ph_CallTone[playerid] = ph_selected[playerid];
		else ph_TextTone[playerid] = ph_selected[playerid];
	}

	DeletePVar(playerid, "ringtype");
}

Dialog:AddContact(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		if(strlen(inputtext) < 2 || strlen(inputtext) > 20)
		    return Dialog_Show(playerid, AddContact, DIALOG_STYLE_INPUT, "Insert name", "Add a contact\n\n\t\tEnter contact name:\t\tErro: Contact must be long. 2-20 caracters", "Proceed", "Back");

		new Regex:r = Regex_New("^[A-Za-z0-9 ]+$"), RegexMatch:m;

		if(!Regex_Match(inputtext, r, m))
		    return Dialog_Show(playerid, AddContact, DIALOG_STYLE_INPUT, "Insert name", "Add a contact\n\n\t\tEnter contact name:\t\tErro: Invalid symbol detected.", "Proceed", "Back");

		//[a-zA-Z0-9]+
		SetPVarString(playerid, "ContactName", inputtext);

        Dialog_Show(playerid, AddContactNum, DIALOG_STYLE_INPUT, "Insert number", "Add a contact\n\n\t\tEnter contact number:", "Proceed", "Back");
	}
	return true;
}

Dialog:AddContactNum(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new name[24], query[256];

		GetPVarString(playerid, "ContactName", name, sizeof(name));

		if(!IsNumeric(inputtext) || strlen(inputtext) > 10 || strlen(inputtext) <= 0)
			return Dialog_Show(playerid, AddContactNum, DIALOG_STYLE_INPUT, "Insert number", "Add a contact\n\n\t\tEnter contact number:\t\tErro: The specified number is invalid.", "Proceed", "Back");

		new count, con_max, exist = -1;

		switch(PlayerData[playerid][pDonateRank])
		{
		    case 0: con_max = 16;
		    case 1: con_max = 24;
		    case 2: con_max = 32;
		    case 3: con_max = 40;
		}

		for(new i = 0; i < 40; ++i)
		{
		    if(ContactData[playerid][i][contactNumber])
			{
                count++;
		    }
		    else
		    {
		        if(exist == -1)
				{
				    exist = i;
				}
		    }
		}

		if(count < con_max)
		{
			ContactData[playerid][exist][contactNumber] = strval(inputtext);
			format(ContactData[playerid][exist][contactName], 24, name);

	     	format(query, sizeof(query), "INSERT INTO `phone_contacts` (`contactAdded`, `contactAddee`, `contactName`) VALUES ('%d', '%d', '%s')", PlayerData[playerid][pPnumber], ContactData[playerid][exist][contactNumber], ContactData[playerid][exist][contactName]);
			mysql_pquery(dbCon, query);

			ContactData[playerid][exist][contactID] = cache_insert_id();

           	ph_menuid[playerid] = 1;
       		ph_sub_menuid[playerid] = 2;
       		ph_page[playerid] = 0;
       		ph_select_data[playerid]=exist;

       		RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
		}
		else
		{
           	ph_menuid[playerid] = 5;
       		ph_sub_menuid[playerid] = 0;
       		ph_page[playerid] = 0;

       		RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
		}
	}
	else
	{
	    DeletePVar(playerid, "ContactName");
	    Dialog_Show(playerid, AddContact, DIALOG_STYLE_INPUT, "Insert name", "Add a contact\n\n\t\tEnter contact name:", "Proceed", "Back");
	}
	return true;
}

Dialog:DeleteContact(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new query[128];
		format(query, sizeof(query), "DELETE FROM `phone_contacts` WHERE `contactID` = %d", ContactData[playerid][ph_select_data[playerid]][contactID]);
  		mysql_pquery(dbCon, query);

  		ContactData[playerid][ph_select_data[playerid]][contactID] = 0;
  		ContactData[playerid][ph_select_data[playerid]][contactNumber] = 0;

		ph_page[playerid] = 0;
		ph_select_data[playerid] = -1;
     	ph_menuid[playerid] = 1;
      	ph_sub_menuid[playerid] = 1;

		RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
	}
	return true;
}

Dialog:SMSNumber(playerid, response, listitem, inputtext[])
{
	if(response)
	{
	    SetPVarString(playerid,"SMSPhoneNumber",inputtext);
		Dialog_Show(playerid, SMSText, DIALOG_STYLE_INPUT, "Short Message Service", "Fill in:", "Send", "Back");
	}
	return true;
}

Dialog:SMSText(playerid, response, listitem, inputtext[])
{
	if(response)
	{
	    new str[128], phonenumb[16];
		GetPVarString(playerid, "SMSPhoneNumber", phonenumb, 16);
	    format(str, sizeof(str), "%s %s", phonenumb, inputtext);
		SendSMS(playerid, str);
	}

	DeletePVar(playerid, "SMSPhoneNumber");
	return true;
}

Dialog:SMSRead(playerid, response, listitem, inputtext[])
{
	if(response)
	{
	    new id = ph_select_data[playerid];
		Dialog_Show(playerid, SMSOption, DIALOG_STYLE_LIST, "Options", "Reply\nCall\n%s\nForward\nDelete\n%s", "Proceed", "Back", (!SmsData[playerid][id][smsArchive]) ? ("Archive") : ("Remove form archive"), (GetContactID(playerid,SmsData[playerid][id][smsOwner]) == -1) ? ("Save number") : ("View contact"));
	}
	return true;
}

Dialog:SMSOption(playerid, response, listitem, inputtext[])
{
	new nstring[24], id = ph_select_data[playerid];

	if(response)
	{
		switch(listitem)
		{
		    case 0:  // reply
		    {
			 	Int32(nstring, SmsData[playerid][id][smsOwner]);
				SetPVarString(playerid,"SMSPhoneNumber", nstring);
				Dialog_Show(playerid, SMSText, DIALOG_STYLE_INPUT, "Short Message Service", "Fill in:", "Send", "Back");
			}
		    case 1:
			{
			  	Int32(nstring, SmsData[playerid][id][smsOwner]);
				CallNumber(playerid, nstring);
			}
		    case 2:  // archive
			{
				//new query[128];

				if(SmsData[playerid][id][smsArchive]) SmsData[playerid][id][smsArchive] = 0;
				else SmsData[playerid][id][smsArchive] = 1;

				Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_INPUT, "Done", "%s", "OK", "", (SmsData[playerid][id][smsArchive]) ? ("Message archived") : ("Message removed from the archive"));

				RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
			}
		    case 3:
			{
				Dialog_Show(playerid, ForwardSMS, DIALOG_STYLE_INPUT, "Forward SMS", "Enter phone number:", "Send", "Back");
			}
		    case 4:
			{
				Dialog_Show(playerid, DeleteSMS, DIALOG_STYLE_MSGBOX, "Are you sure?", "Are you sure you want to delete this message?", "Yes", "No");
			}
		    case 5:
			{
                new exist = -1;

				if((exist = GetContactID(playerid, SmsData[playerid][id][smsOwner])) != -1)
				{
		           	ph_menuid[playerid] = 1;
		       		ph_sub_menuid[playerid]=2;
		       		ph_page[playerid] = 0;
		       		ph_select_data[playerid]=exist;

		       		RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
				}
				else Dialog_Show(playerid, AddSMSContact, DIALOG_STYLE_INPUT, "Insert name", "Add a contact\n\n\t\tEnter contact name:", "Proceed", "Back");
			}
		}
	}
	return true;
}

Dialog:ForwardSMS(playerid, response, listitem, inputtext[])
{
	if(response)
	{
	    new str[256], phonenumb = strval(inputtext), id = ph_select_data[playerid];

	    if(phonenumb && strlen(inputtext) < 16)
	    {
		    format(str, sizeof(str), "%d %s", phonenumb, SmsData[playerid][id][smsText]);
			SendSMS(playerid, str);
        }
        else SendClientMessage(playerid, COLOR_LIGHTRED, "   The specified number is invalid.");
	}
	return true;
}

Dialog:DeleteSMS(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new query[128], id = ph_select_data[playerid];
		
		mysql_format(dbCon, query, sizeof(query), "DELETE FROM `phone_sms` WHERE `id` = '%d' LIMIT 1", SmsData[playerid][id][smsID]);
		mysql_pquery(dbCon, query);

        SmsData[playerid][id][smsExist] = false;

  		RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
	}
	return true;
}

Dialog:AddHistoryContact(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new query[256], id = ph_select_data[playerid];

		if(strlen(inputtext) < 2 || strlen(inputtext) > 20)
		    return Dialog_Show(playerid, AddContact, DIALOG_STYLE_INPUT, "Insert name", "Add a contact\n\n\t\tEnter contact name:\t\tErro: Contact must be long. 2-20 caracters", "Proceed", "Back");

		new Regex:r = Regex_New("^[A-Za-z0-9 ]+$"), RegexMatch:m;

		if(!Regex_Match(inputtext, r, m))
		    return Dialog_Show(playerid, AddContact, DIALOG_STYLE_INPUT, "Insert name", "Add a contact\n\n\t\tEnter contact name:\t\tErro: Invalid symbol found.", "Proceed", "Back");

		new count, con_max, exist = -1;

		switch(PlayerData[playerid][pDonateRank])
		{
		    case 0: con_max = 16;
		    case 1: con_max = 24;
		    case 2: con_max = 32;
		    case 3: con_max = 40;
		}

		for(new i = 0; i < 40; ++i)
		{
		    if(ContactData[playerid][i][contactNumber])
			{
                count++;
		    }
		    else
		    {
		        if(exist == -1)
				{
				    exist = i;
				}
		    }
		}

		if(count < con_max)
		{
			ContactData[playerid][exist][contactNumber] = CallHistory[playerid][id][chNumber];
			format(ContactData[playerid][exist][contactName], 24, inputtext);

	     	format(query,sizeof(query),"INSERT INTO `phone_contacts` (`contactAdded`, `contactAddee`, `contactName`) VALUES ('%d', '%d', '%s')", PlayerData[playerid][pPnumber], ContactData[playerid][exist][contactNumber], ContactData[playerid][exist][contactName]);
			mysql_pquery(dbCon, query);

			ContactData[playerid][exist][contactID] = cache_insert_id();

           	ph_menuid[playerid] = 1;
       		ph_sub_menuid[playerid]=2;
       		ph_page[playerid] = 0;
       		ph_select_data[playerid]=exist;

       		RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
		}
		else
		{
           	ph_menuid[playerid]=5;
       		ph_sub_menuid[playerid] = 0;
       		ph_page[playerid] = 0;

       		RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
		}
	}
	return true;
}

Dialog:AddSMSContact(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new query[256], id = ph_select_data[playerid];

		if(strlen(inputtext) < 2 || strlen(inputtext) > 20)
		    return Dialog_Show(playerid, AddContact, DIALOG_STYLE_INPUT, "Insert name", "Add a contact\n\n\t\tEnter contact name:\t\tErro: Contact must be long. 2-20 caracters", "Proceed", "Back");

		new Regex:r = Regex_New("^[A-Za-z0-9 ]+$"), RegexMatch:m;

		if(!Regex_Match(inputtext, r, m))
		    return Dialog_Show(playerid, AddContact, DIALOG_STYLE_INPUT, "Insert name", "Add a contact\n\n\t\tEnter contact name:\t\tErro: Invalid symbol found.", "Proceed", "Back");

		new count, con_max, exist = -1;

		switch(PlayerData[playerid][pDonateRank])
		{
		    case 0: con_max = 16;
		    case 1: con_max = 24;
		    case 2: con_max = 32;
		    case 3: con_max = 40;
		}

		for(new i = 0; i < 40; ++i)
		{
		    if(ContactData[playerid][i][contactNumber])
			{
                count++;
		    }
		    else
		    {
		        if(exist == -1)
				{
				    exist = i;
				}
		    }
		}

		if(count < con_max)
		{
			ContactData[playerid][exist][contactNumber] = SmsData[playerid][id][smsOwner];
			format(ContactData[playerid][exist][contactName], 24, inputtext);

	     	format(query, sizeof(query), "INSERT INTO `phone_contacts` (`contactAdded`, `contactAddee`, `contactName`) VALUES ('%d', '%d', '%s')", PlayerData[playerid][pPnumber], ContactData[playerid][exist][contactNumber], ContactData[playerid][exist][contactName]);
			mysql_pquery(dbCon, query);

			ContactData[playerid][exist][contactID] = cache_insert_id();

           	ph_menuid[playerid] = 1;
       		ph_sub_menuid[playerid] = 2;
       		ph_page[playerid] = 0;
       		ph_select_data[playerid] = exist;

       		RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
		}
		else
		{
           	ph_menuid[playerid] = 5;
       		ph_sub_menuid[playerid] = 0;
       		ph_page[playerid] = 0;

       		RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);
		}
	}
	return true;
}

Dialog:AskTurnOff(playerid, response, listitem, inputtext[])
{
	if(response)
	{
        if(ph_menuid[playerid] != 6)
		{
			if(PlayerData[playerid][pCallLine] != INVALID_PLAYER_ID)
			{
	      		SendClientMessage(PlayerData[playerid][pCallLine],  COLOR_GRAD2, "[ ! ] They hung up.");
			    CancelCall(playerid);
			}

			PhoneSelfie_Stop(playerid);

			RenderPlayerPhone(playerid, 6, 0);

			SetTimerEx("PhoneTurnOff", 2000, false, "d", playerid);
		}
	}
	return true;
}

forward PhoneTurnOff(playerid);
public PhoneTurnOff(playerid)
{
	if(IsPlayerConnected(playerid))
	{	
		RenderPlayerPhone(playerid, 6, 1);
	}
}

ForceSwitchPhone(playerid, bool:hide = false)
{
	if(PlayerData[playerid][pCallLine] != INVALID_PLAYER_ID) CancelCall(playerid);

	ph_menuid[playerid] = 6;
	ph_sub_menuid[playerid] = 1;

	PhoneSelfie_Stop(playerid);

	if(hide) ClosePlayerPhone(playerid, true);
}

Dialog:CallNumber(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		CallNumber(playerid, inputtext);
	}
	return true;
}

forward PhoneTurnOn(playerid);
public PhoneTurnOn(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		if(!PlayerData[playerid][pJailed])
		{
			PlayerTextDrawColor(playerid, TDPhone_ScreenText[playerid], 488447487);
			RenderPlayerPhone(playerid, 0, 0);
		}
	}
}

ShowEmo_Phone(playerid, emo)
{
	if(PhoneOpen{playerid})
	{
		switch(emo)
		{
		    case 1: PlayerPlaySound(playerid, 21000, 0.0, 0.0, 0.0), PlayerTextDrawSetString(playerid, TDPhone_Picture[playerid], "ld_chat:thumbup");
		    case 2: PlayerPlaySound(playerid, 21001, 0.0, 0.0, 0.0), PlayerTextDrawSetString(playerid, TDPhone_Picture[playerid], "ld_chat:thumbdn");
		    case 3: PlayPlayerTextTone(playerid), PlayerTextDrawSetString(playerid, TDPhone_Picture[playerid], "ld_chat:goodcha");
		}

		PlayerTextDrawShow(playerid, TDPhone_Picture[playerid]);

		SetTimerEx("HideEmo_Phone", 5000, false, "d", playerid);
	}
	return true;
}

forward HideEmo_Phone(playerid);
public HideEmo_Phone(playerid)
{
	PlayerTextDrawSetString(playerid, TDPhone_Picture[playerid], "_");
	PlayerTextDrawHide(playerid, TDPhone_Picture[playerid]);
	return true;
}

stock SendSMS(playerid, const params[])
{
	if(PlayerData[playerid][pJailed])
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "Error: Your phone was confiscated by the cops.");

    if(PlayerData[playerid][pInjured] || IsCuffed{playerid} || IsTied{playerid})
		return SendErrorMessage(playerid, "You can't do this right now.");

	if(ph_menuid[playerid] == 6)
	    return SendErrorMessage(playerid, "You can't do this now (phone off).");

	if(ph_airmode[playerid])
		return SendErrorMessage(playerid, "You can't do this now (airplane mode on).");

  	if(calltimer[playerid] || smstimer[playerid] || GetPlayerSpecialAction(playerid) > 0 || PlayerData[playerid][pCash] < 1)
	  	return SendErrorMessage(playerid, "You can't do this right now.");

	new phonenumb[24], sms_text[128];

	if(sscanf(params, "s[24]s[128]", phonenumb, sms_text))
		return SendClientMessage(playerid, COLOR_LIGHTRED, "Usage: /sms [number/contact] [text]");

    if(PlayerData[playerid][pPnumber])
	{
	    new phonenumber = strval(phonenumb);


		new nid = -1;

		for(new i = 0; i != 40; ++i)
		{
			if(ContactData[playerid][i][contactNumber] > 0 && (!strcmp(ContactData[playerid][i][contactName], phonenumb, true) || ContactData[playerid][i][contactNumber] == phonenumber))
			{
				nid = i;
    			break;
   			}
  		}

  		Annotation(playerid, "types something on their phone.");

		if(!PhoneOpen{playerid}) ShowPlayerPhone(playerid);

		// SMS Screen
		ph_menuid[playerid] = 5;
		ph_sub_menuid[playerid] = 4;

		RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);

        SetPVarString(playerid,"SMSPhoneText", sms_text);

		new signal = GetPhoneSignal(playerid);
		
		if(signal > 4) smstimer[playerid] = SetTimerEx("SendPlayerSMS", 3000, false, "ddd", playerid, nid, phonenumber);
		else if(signal > 3) smstimer[playerid] = SetTimerEx("SendPlayerSMS", 4000, false, "ddd", playerid, nid, phonenumber);
		else if(signal > 2) smstimer[playerid] = SetTimerEx("SendPlayerSMS", 5000, false, "ddd", playerid, nid, phonenumber);
		else if(signal > 1) smstimer[playerid] = SetTimerEx("SendPlayerSMS", 6000, false, "ddd", playerid, nid, phonenumber);
		else smstimer[playerid] = SetTimerEx("SendPlayerSMS", 7000, false, "ddd", playerid, nid, phonenumber);
	}
	else SendClientMessage(playerid, COLOR_GRAD1, "   You don't have a phone.");

	return true;
}

stock CallNumber(playerid, const params[])
{
	if(PlayerData[playerid][pJailed])
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "Error: Your phone was confiscated by the cops.");

    if(PlayerData[playerid][pInjured] || IsCuffed{playerid} || IsTied{playerid})
		return SendErrorMessage(playerid, "You can't do this right now.");

	if(!CheckPhoneStatus(playerid))
	    return SendErrorMessage(playerid, "You can't do this now (phone off).");

	if(ph_airmode[playerid])
		return SendErrorMessage(playerid, "You can't do this now (airplane mode on).");

  	if(calltimer[playerid] || smstimer[playerid] || GetPlayerSpecialAction(playerid) > 0 || PlayerData[playerid][pCash] < 10)
	  	return SendErrorMessage(playerid, "You can't do this right now.");

	new phonenumb[24];

	if(strlen(params) < 24 && sscanf(params, "s[24]", phonenumb))
	{
		SendClientMessage(playerid, COLOR_GREY, "[ Common numbers ]");
		SendClientMessage(playerid, COLOR_WHITE, "Emergency (police/paramedic): 911");
		SendClientMessage(playerid, COLOR_WHITE, "Police Non-Emergency landline: 991");
		SendClientMessage(playerid, COLOR_WHITE, "Taxi dispatch: 544");
		SendClientMessage(playerid, COLOR_WHITE, "Mechanic dispatch: 555");
		SendClientMessage(playerid, COLOR_WHITE, "Impounder dispatch: 533");
		SendClientMessage(playerid, COLOR_WHITE, "Police Department: 1-800-POLICE");
		SendClientMessage(playerid, COLOR_WHITE, "Sheriff's Department: 1-800-SHERIFF");
		SendClientMessage(playerid, COLOR_WHITE, "Prison Landline: 1-800-PRISON");
		SendClientMessage(playerid, COLOR_WHITE, "Fire Department: 1-800-FIRE");
		SendClientMessage(playerid, COLOR_WHITE, "San Andreas Network: 1-800-SAN");
		SendClientMessage(playerid, COLOR_WHITE, "Roux Enterprise: 1-800-ROUX");
		SendClientMessage(playerid, COLOR_WHITE, "The Government: 1-800-GOV");
		SendClientMessage(playerid, COLOR_WHITE, "Courts: 1-800-COURTS");
		SendClientMessage(playerid, COLOR_WHITE, "Federal Bureau of Investigation: 1-800-FBI");
		SendClientMessage(playerid, COLOR_LIGHTRED, "Usage: /call [number/contact]");
		return true;
	}

    if(PlayerData[playerid][pPnumber])
	{
		new pnumber = strval(phonenumb);

  		if(pnumber == 911)
		{
			PlayerPlaySoundEx(playerid, 3600);

			Annotation(playerid, "dials a number on their phone.");

			if(!PhoneOpen{playerid})
			{
				SendClientMessage(playerid, COLOR_WHITE, "[ ! ] Note: To toggle the phone, use /phone. To bring up the mouse, use /pc.");
				ShowPlayerPhone(playerid);
			}

			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
            format(ph_call_string[playerid], 64, "~n~911");

			RenderPlayerPhone(playerid, 7, 1);

			SendClientMessage(playerid, COLOR_YELLOW, "Emergency Dispatch says (phone): Here is the 911 Emergency Dispatch. What service do you need?");

			PlayerData[playerid][pCallLine] = 911;
			PlayerData[playerid][pIncomingCall] = 0;
			return true;
		}
  		else if(pnumber == 991)
		{
			PlayerPlaySoundEx(playerid, 3600);

			Annotation(playerid, "dials a number on their phone.");

			if(!PhoneOpen{playerid})
			{
				SendClientMessage(playerid, COLOR_WHITE, "[ ! ] Note: To toggle the phone, use /phone. To bring up the mouse, use /pc.");
				ShowPlayerPhone(playerid);
			}

			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
            format(ph_call_string[playerid], 64, "~n~991");

			RenderPlayerPhone(playerid, 7, 1);

			SendClientMessage(playerid, COLOR_YELLOW, "Police Dispatch says (phone): Non-Emergency landline for Law Enforcement services, what is yo ...");
			SendClientMessage(playerid, COLOR_YELLOW, "Police Dispatch says (phone): ... ur current location?");

			PlayerData[playerid][pCallLine] = 991;
			PlayerData[playerid][pIncomingCall] = 0;
			return true;
		}
  		else if(pnumber == 555)
		{
			PlayerPlaySoundEx(playerid, 3600);

			Annotation(playerid, "dials a number on their phone.");

			if(!PhoneOpen{playerid})
			{
				SendClientMessage(playerid, COLOR_WHITE, "[ ! ] Note: To toggle the phone, use /phone. To bring up the mouse, use /pc.");
				ShowPlayerPhone(playerid);
			}
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
            format(ph_call_string[playerid], 64, "~n~555");

            RenderPlayerPhone(playerid, 7, 1);

			SendClientMessage(playerid, COLOR_YELLOW, "Mechanic Dispatch say (phone): Los Santos Mechanical Services, how can we help?");

			PlayerData[playerid][pCallLine] = 555;
			PlayerData[playerid][pIncomingCall] = 0;
			return true;
		}
  		else if(pnumber == 544)
		{
			PlayerPlaySoundEx(playerid, 3600);

			Annotation(playerid, "dials a number on their phone.");

			if(!PhoneOpen{playerid})
			{
				SendClientMessage(playerid, COLOR_WHITE, "[ ! ] Note: To toggle the phone, use /phone. To bring up the mouse, use /pc.");
				ShowPlayerPhone(playerid);
			}

			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
            format(ph_call_string[playerid], 64, "~n~544");

			RenderPlayerPhone(playerid, 7, 1);

			SendClientMessage(playerid, COLOR_YELLOW, "Taxi Dispatch say (phone): Hello, where do you want to go?");

			PlayerData[playerid][pCallLine] = 544;
			PlayerData[playerid][pIncomingCall] = 0;
			return true;
		}
		else
		{
			new nid = -1;

			for(new i = 0; i != 40; ++i)
			{
				if(ContactData[playerid][i][contactNumber] > 0 && (!strcmp(ContactData[playerid][i][contactName], phonenumb, true) || ContactData[playerid][i][contactNumber] == pnumber))
				{
					nid = i;
				 	break;
				}
			}

			if(nid == -1 && pnumber == 0)
			{
				RenderPlayerPhone(playerid, 5, 1);

				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
				return true;
			}

			PlayerPlaySoundEx(playerid, 3600);

			Annotation(playerid, "dials a number on their phone.");

			if(!PhoneOpen{playerid})
			{
				SendClientMessage(playerid, COLOR_WHITE, "[ ! ] Note: To toggle the phone, use /phone. To bring up the mouse, use /pc.");
				ShowPlayerPhone(playerid);
			}

			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);

			if(nid == -1)
			{
				format(ph_call_string[playerid], 64, "~n~555-%06d", pnumber);
				AddPlayerCallHistory(playerid, pnumber, PH_OUTGOING);
			}
			else
			{
				format(ph_call_string[playerid], 64, " %s~n~(%d)", ContactData[playerid][nid][contactName], ContactData[playerid][nid][contactNumber]);
                AddPlayerCallHistory(playerid, ContactData[playerid][nid][contactNumber], PH_OUTGOING);
			}

			RenderPlayerPhone(playerid, 7, 0);

			new signal = GetPhoneSignal(playerid);

			if(signal > 4) calltimer[playerid] = SetTimerEx("SendPlayerCall", 2000, false, "dddd", playerid, signal, pnumber, nid);
			else if(signal > 3) calltimer[playerid] = SetTimerEx("SendPlayerCall", 2500, false, "dddd", playerid, signal, pnumber, nid);
			else if(signal > 2) calltimer[playerid] = SetTimerEx("SendPlayerCall", 3000, false, "dddd", playerid, signal, pnumber, nid);
			else if(signal > 1) calltimer[playerid] = SetTimerEx("SendPlayerCall", 3500, false, "dddd", playerid, signal, pnumber, nid);
			else calltimer[playerid] = SetTimerEx("SendPlayerCall", 4000, false, "dddd", playerid, signal, pnumber, nid);
		}
	}
	else SendClientMessage(playerid, COLOR_GRAD1, "You don't have a mobile phone.");

	return true;
}