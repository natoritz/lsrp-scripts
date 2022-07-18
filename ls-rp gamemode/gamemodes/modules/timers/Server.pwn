task Server[60000]()
{
	if(GlobalMinute == 59)
	{
		if(GlobalHour == 23) GlobalHour = 00, GlobalMinute = 00;
		else GlobalHour++, GlobalMinute = 00;
	}
	else GlobalMinute++;

	if(GlobalMinute == 5)
	{
		new bool: done;

		for(new c = 0; c < sizeof(CarRent); ++c)
		{
	        done = false;

			foreach (new i : Player)
			{
				if(gLastCar[i] == CarRent[c] || RentCarKey[i] == CarRent[c])
				{
					done = true;
				}
			}

			if(!done) SetVehicleToRespawn(CarRent[c]);
		}
	}

	new tmphour, tmpminute, tmpsecond;
	gettime(tmphour, tmpminute, tmpsecond);
	FixHour(tmphour);
	tmphour = shifthour;

	if((tmphour > ghour) || (tmphour == 0 && ghour == 23))
	{
	    //TollsLocked = 0;
	    TollsPayed = 0;
		//TollsTaxed = 0;
		TollsOpenCount = 0;

	    format(sgstr, sizeof(sgstr), "SERVER TIME:[ %d:00 ]", tmphour);
		SendClientMessageToAll(COLOR_WHITE, sgstr);

		ghour = tmphour;

		SetWorldTime(tmphour);

		foreach (new i : Player)
		{
			if(PlayerData[i][pJailed] == PUNISHMENT_TYPE_PRISON)
			{
				SetPlayerTime(i, 15, 0);
			}
		}

		MDC_Global_Cache[PoliceCalls] = 0;
		MDC_Global_Cache[Arrests] = 0;
		MDC_Global_Cache[Fines] = 0;
		MDC_Global_Cache[MedicCalls] = 0;

		PayDay();
		IndustryTime();
		DecayDrugs();
	}

	if(!gShipDeparture)
	{
		if((gettime() - gShipTime) > 7200000)
		{
			RampsClosed();
		}
	}

 	for(new i = 0; i < MAX_DROP_ITEMS; ++i)
	{
	    /*if(CORPSES[i][corpseSpawned])
	    {
            CORPSES[i][corpseMinutes] += 1;

            if(CORPSES[i][corpseMinutes] >= 20)
            {
                new Float:playerPos[3];
	 	    	GetActorPos(CORPSES[i][corpseActor], playerPos[0], playerPos[1], playerPos[2]);

				foreach (new x : Player)
				{
			    	if(IsPlayerInRangeOfPoint(x, 20.0, playerPos[0], playerPos[1], playerPos[2]))
			    	{
						SendClientMessage(x, COLOR_PURPLE, "* (( The corpse was despawned. ))");
			    	}
				}

                DestroyActor(CORPSES[i][corpseActor]);
                CORPSES[i][corpseActor] = INVALID_PLAYER_ID;
                CORPSES[i][corpseName][0] = EOS;
                CORPSES[i][corpseMinutes] = 0;
                CORPSES[i][corpseSpawned] = false;
            }
	    }*/

	    if(DroppedWeapons[i][DropExists])
	    {
	        DroppedWeapons[i][DropMinutes] += 1;

		    if(DroppedWeapons[i][DropMinutes] >= 30)
		    {
		        ResetDropWeapon(i);
		    }
	    }
	}
}

IndustryTime()
{
	foreach (new i : Industry)
	{
	    if(StorageData[i][in_id])
		{
			if(StorageData[i][in_trading_type]) StorageData[i][in_stock] -= StorageData[i][in_consumption];
			else StorageData[i][in_stock] += StorageData[i][in_consumption];
			if(StorageData[i][in_stock] > StorageData[i][in_maximum]) StorageData[i][in_stock]=StorageData[i][in_maximum];
			else if(StorageData[i][in_stock] < 0) StorageData[i][in_stock] = 0;

	        UpdateStorage(i);
         	saveStorage(i);
        }
	}
}