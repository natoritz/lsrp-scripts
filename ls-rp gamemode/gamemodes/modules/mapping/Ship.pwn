	gShipRamp1 = CreateDynamicObject(3069, 2810.9445, -2387.2998, 12.6255, -20.4000, 0.0000, -90.3000); //d9_ramp
	gShipRamp2 = CreateDynamicObject(3069, 2810.6875, -2436.9775, 12.6250, -20.4000, 0.0000, -90.3000); //d9_ramp

	CreateDynamicObject(3077, 2809.9897, -2392.7746, 12.6257, 0.0000, 0.0000, 90.3998);

	gShipTextLine1 = CreateDynamicObject(19482, 2809.9184, -2392.7329, 15.2910, 0.0000, 0.0000, 180.0000);
    SetDynamicObjectMaterialText(gShipTextLine1, 0, "OCEAN DOCKS SHIP", OBJECT_MATERIAL_SIZE_256x256, "Arial", 16, 1, 0xFFFFFFFF, 0, 1);

    gShipTime = gettime();

 	new gShipHour, gShipMinute, gShipSecond;

    TimestampToTime(gShipTime + 2440, gShipHour, gShipMinute, gShipSecond);

	gShipTextLine2 = CreateDynamicObject(19482, 2809.9284, -2392.7329, 14.6810, 0.0000, 0.0000, 180.0000);
	format(sgstr, sizeof(sgstr), "Departure: %02d:%02d:%02d", gShipHour, gShipMinute, gShipSecond);
	SetDynamicObjectMaterialText(gShipTextLine2, 0, sgstr, OBJECT_MATERIAL_SIZE_256x256, "Arial", 16, 1, 0xFFFFFFFF, 0, 1);

    TimestampToTime(gShipTime + 2740, gShipHour, gShipMinute, gShipSecond);

	gShipTextLine3 = CreateDynamicObject(19482, 2809.9184, -2392.7329, 14.2610, 0.0000, 0.0000, 180.0000);
	format(sgstr, sizeof(sgstr), "Next arrival: %02d:%02d:%02d", gShipHour, gShipMinute, gShipSecond);
	SetDynamicObjectMaterialText(gShipTextLine3, 0, sgstr, OBJECT_MATERIAL_SIZE_256x256, "Arial", 16, 1, 0xFFFFFFFF, 0, 1);
