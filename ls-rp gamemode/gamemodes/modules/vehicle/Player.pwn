// Defines

#define MAX_PLAYER_VEHICLES (200)
#define MAX_CAR_WEAPONS (4)
#define MAX_VEHICLE_KEYS (3)
#define REDUCE_VEHICLE_PRICE (2)

// Variables

new const ColorMenuInfo[][] =
{
	{1, "Basic"},
	{3, "Red"},
	{2, "Blue"},
	{16, "Green"},
	{6, "Yellow"},
	{158, "Orange"},
	{30, "Brown"},
	{179, "Purple"},
	{190, "Pink"},
	{110, "Tan"}
};

new const ColorMenuSelect[][] =
{
	{0, 0},
	{1, 0},
	{8, 0},
	{11, 0},
	{13, 0},
	{14, 0},
	{15, 0},
	{19, 0},
	{23, 0},
	{24, 0},
	{25, 0},
	{26, 0},
	{27, 0},
	{29, 0},
	{33, 0},
	{34, 0},
	{35, 0},
	{38, 0},
	{39, 0},
	{49, 0},
	{50, 0},
	{52, 0},
	{56, 0},
	{60, 0},
	{63, 0},
	{64, 0},
	{67, 0},
	{71, 0},
	{90, 0},
	{96, 0},
	{109, 0},
	{111, 0},
	{118, 0},
	{122, 0},
	{138, 0},
	{140, 0},
	{148, 0},
	{157, 0},
	{192, 0},
	{193, 0},
	{196, 0},
	{213, 0},
	{250, 0},
	{251, 0},
	{252, 0},
	{253, 0},
	{255, 0},
	{3, 1},
	{17, 1},
	{42, 1},
	{43, 1},
	{45, 1},
	{58, 1},
	{70, 1},
	{82, 1},
	{117, 1},
	{121, 1},
	{124, 1},
	{2, 2},
	{7, 2},
	{10, 2},
	{12, 2},
	{20, 2},
	{28, 2},
	{32, 2},
	{53, 2},
	{54, 2},
	{59, 2},
	{79, 2},
	{87, 2},
	{93, 2},
	{94, 2},
	{95, 2},
	{100, 2},
	{101, 2},
	{103, 2},
	{106, 2},
	{108, 2},
	{109, 2},
	{112, 2},
	{116, 2},
	{125, 2},
	{130, 2},
	{135, 2},
	{139, 2},
	{152, 2},
	{166, 2},
	{198, 2},
	{201, 2},
	{205, 2},
	{208, 2},
	{209, 2},
	{210, 2},
	{223, 2},
	{246, 2},

	{16, 3},
	{28, 3},
	{44, 3},
	{51, 3},
	{83, 3},
	{86, 3},
	{114, 3},
	{137, 3},
	{145, 3},
	{151, 3},
	{153, 3},
	{154, 3},
	{160, 3},
	{186, 3},
	{187, 3},
	{188, 3},
	{189, 3},
	{191, 3},
	{202, 3},
	{215, 3},
	{226, 3},
	{227, 3},
	{229, 3},
	{234, 3},
	{235, 3},
	{241, 3},
	{243, 3},
	{245, 3},
	{6, 4},
	{65, 4},
	{142, 4},
	{194, 4},
	{195, 4},
	{197, 4},
	{221, 4},
	{228, 4},
	{6, 5},
	{158, 5},
	{175, 5},
	{181, 5},
	{182, 5},
	{183, 5},
	{219, 5},
	{222, 5},
	{239, 5},
	{30, 6},
	{31, 6},
	{40, 6},
	{41, 6},
	{58, 6},
	{62, 6},
	{66, 6},
	{74, 6},
	{78, 6},
	{84, 6},
	{88, 6},
	{113, 6},
	{119, 6},
	{123, 6},
	{129, 6},
	{131, 6},
	{149, 6},
	{159, 6},
	{168, 6},
	{173, 6},
	{174, 6},
	{180, 6},
	{212, 6},
	{224, 6},
	{230, 6},
	{238, 6},
	{244, 6},
	{254, 6},
	{147, 7},
	{167, 7},
	{171, 7},
	{179, 7},
	{190, 7},
	{211, 7},
	{232, 7},
	{233, 7},
	{237, 7},
	{5, 8},
	{126, 8},
	{146, 8},
	{176, 8},
	{177, 8},
	{178, 8},
	{46, 9},
	{47, 9},
	{48, 9},
	{55, 9},
	{58, 9},
	{61, 9},
	{68, 9},
	{69, 9},
	{73, 9},
	{76, 9},
	{77, 9},
	{81, 9},
	{89, 9},
	{99, 9},
	{102, 9},
	{104, 9},
	{107, 9},
	{110, 9},
	{120, 9},
	{138, 9},
	{140, 9},
	{141, 9},
	{157, 9},
	{192, 9},
	{193, 9},
	{196, 9},
	{213, 9},
	{250, 9},
	{253, 9}
};

enum upgradeinfo
{
    u_price,
    Float:u_rate,
}

new const VehicleUpgradeLock[][upgradeinfo] =
{
	{4000, 75.0},
	{6000, 50.0},
	{8000, 37.5},
	{10000, 30.0}
};

new const VehicleUpgradeImmob[][upgradeinfo] =
{
	{5000, 150.0},
	{10000, 75.0},
	{15000, 50.0},
	{20000, 37.5}
};

new const VehicleUpgradeAlarm[][upgradeinfo] =
{
	{2000, 150.0},
	{4000, 75.0},
	{5000, 50.0},
	{8000, 37.5}
};

enum E_DEALERSHIP_DATA
{
	c_price,
	Float:c_maxhp,
	Float:c_engine,
	Float:c_battery,
	Float:c_maxfuel,
	Float:c_fuelrate,
	c_scrap
};

new VehicleData[][E_DEALERSHIP_DATA] =
{
	// Value, MAX HP, ENGINE LIFE, BATTERY LIFE, MAX FUEL, Fuel rate, Scap Value
	{180000/ REDUCE_VEHICLE_PRICE, 1120.0, 100.0, 100.0, 22.0, 13.0, 90000},
	{40000/ REDUCE_VEHICLE_PRICE, 900.0, 75.0, 100.0, 15.0, 9.0, 20000},
	{420000/ REDUCE_VEHICLE_PRICE, 910.0, 100.0, 100.0, 19.0, 3.0, 210000},
	{750000/ REDUCE_VEHICLE_PRICE, 2000.0, 100.0, 100.0, 100.0, 4.0, 375000},
	{80000/ REDUCE_VEHICLE_PRICE, 900.0, 75.0, 100.0, 100.0, 15.0, 40000},
	{135000/ REDUCE_VEHICLE_PRICE, 940.0, 100.0, 100.0, 17.0, 8.0, 67500},
	{0, 2000.0, 100.0, 100.0, 100.0, 4.0, 0},
	{340000/ REDUCE_VEHICLE_PRICE, 1800.0, 100.0, 100.0, 100.0, 11.0, 170000},
	{140900/ REDUCE_VEHICLE_PRICE, 2000.0, 100.0, 100.0, 100.0, 3.0, 70450},
	{280000/ REDUCE_VEHICLE_PRICE, 1000.0, 100.0, 100.0, 23.0, 11.0, 140000},
	{35000/ REDUCE_VEHICLE_PRICE, 900.0, 75.0, 100.0, 14.0, 10.0, 17500},
	{605500/ REDUCE_VEHICLE_PRICE, 800.0, 100.0, 100.0, 24.0, 3.0, 302750},
	{65000/ REDUCE_VEHICLE_PRICE, 900.0, 75.0, 100.0, 15.0, 6.0, 32500},
	{110000/ REDUCE_VEHICLE_PRICE, 1400.0, 100.0, 100.0, 32.0, 20.0, 55000},
	{175000/ REDUCE_VEHICLE_PRICE, 1700.0, 100.0, 100.0, 100.0, 17.0, 87500},
	{850000/ REDUCE_VEHICLE_PRICE, 800.0, 100.0, 100.0, 23.0, 4.0, 425000},
	{54500/ REDUCE_VEHICLE_PRICE, 1300.0, 100.0, 100.0, 65.0, 20.0, 27250},
	{1000000/ REDUCE_VEHICLE_PRICE, 1300.0, 100.0, 100.0, 100.0, 0.0, 500000},
	{80000/ REDUCE_VEHICLE_PRICE, 1000.0, 100.0, 100.0, 26.0, 23.0, 40000},
	{50000/ REDUCE_VEHICLE_PRICE, 900.0, 75.0, 100.0, 16.0, 8.0, 25000},
	{45000/ REDUCE_VEHICLE_PRICE, 910.0, 100.0, 100.0, 17.0, 14.0, 22500},
	{100000/ REDUCE_VEHICLE_PRICE, 940.0, 100.0, 100.0, 16.0, 8.0, 50000},
	{60000/ REDUCE_VEHICLE_PRICE, 1200.0, 100.0, 100.0, 25.0, 13.0, 30000},
	{80000/ REDUCE_VEHICLE_PRICE, 1400.0, 100.0, 100.0, 35.0, 26.0, 40000},
	{19000/ REDUCE_VEHICLE_PRICE, 900.0, 100.0, 100.0, 9.0, 15.0, 9500},
	{10000000/ REDUCE_VEHICLE_PRICE, 1700.0, 100.0, 100.0, 100.0, 0.0, 5000000},
	{135000/ REDUCE_VEHICLE_PRICE, 930.0, 100.0, 100.0, 16.0, 8.0, 67500},
	{500000/ REDUCE_VEHICLE_PRICE, 1650.0, 100.0, 100.0, 56.0, 15.0, 250000},
	{275500/ REDUCE_VEHICLE_PRICE, 1800.0, 100.0, 100.0, 55.0, 10.0, 137750},
	{850000/ REDUCE_VEHICLE_PRICE, 800.0, 100.0, 100.0, 23.0, 3.0, 425000},
	{450000/ REDUCE_VEHICLE_PRICE, 1200.0, 100.0, 100.0, 80.0, 0.0, 225000},
	{70000/ REDUCE_VEHICLE_PRICE, 2000.0, 100.0, 100.0, 100.0, 3.0, 35000},
	{50000000/ REDUCE_VEHICLE_PRICE, 5000.0, 100.0, 100.0, 100.0, 3.0, 25000000},
	{7500000/ REDUCE_VEHICLE_PRICE, 2200.0, 100.0, 100.0, 100.0, 7.0, 3750000},
	{225000/ REDUCE_VEHICLE_PRICE, 880.0, 100.0, 100.0, 10.0, 14.0, 112500},
	{115000/ REDUCE_VEHICLE_PRICE, 0.0, 100.0, 100.0, 0.0, 0.0, 57500},
	{40000/ REDUCE_VEHICLE_PRICE, 900.0, 75.0, 100.0, 15.0, 9.0, 20000},
	{75000/ REDUCE_VEHICLE_PRICE, 2000.0, 100.0, 100.0, 100.0, 2.0, 37500},
	{50000/ REDUCE_VEHICLE_PRICE, 910.0, 100.0, 100.0, 17.0, 13.0, 25000},
	{80000/ REDUCE_VEHICLE_PRICE, 930.0, 100.0, 100.0, 17.0, 7.0, 40000},
	{100000/ REDUCE_VEHICLE_PRICE, 1400.0, 100.0, 100.0, 34.0, 12.0, 50000},
	{15000/ REDUCE_VEHICLE_PRICE, 700.0, 100.0, 100.0, 100.0, 0.0, 7500},
	{75000/ REDUCE_VEHICLE_PRICE, 1000.0, 100.0, 100.0, 18.0, 10.0, 37500},
	{200000/ REDUCE_VEHICLE_PRICE, 2000.0, 100.0, 100.0, 100.0, 9.0, 100000},
	{300000/ REDUCE_VEHICLE_PRICE, 1300.0, 100.0, 100.0, 26.0, 6.0, 150000},
	{45000/ REDUCE_VEHICLE_PRICE, 910.0, 100.0, 100.0, 16.0, 8.0, 22500},
	{1000000/ REDUCE_VEHICLE_PRICE, 850.0, 100.0, 100.0, 75.0, 0.0, 500000},
	{12000000/ REDUCE_VEHICLE_PRICE, 850.0, 100.0, 100.0, 46.0, 0.0, 6000000},
	{12999/ REDUCE_VEHICLE_PRICE, 740.0, 50.0, 100.0, 2.0, 49.0, 6499},
	{35000000/ REDUCE_VEHICLE_PRICE, 1200.0, 100.0, 100.0, 7.0, 12.0, 17500000},
	{115000/ REDUCE_VEHICLE_PRICE, 0.0, 100.0, 100.0, 0.0, 0.0, 57500},
	{655500/ REDUCE_VEHICLE_PRICE, 800.0, 100.0, 100.0, 23.0, 3.0, 327750},
	{450000/ REDUCE_VEHICLE_PRICE, 850.0, 100.0, 100.0, 68.0, 0.0, 225000},
	{180000/ REDUCE_VEHICLE_PRICE, 1250.0, 100.0, 100.0, 100.0, 0.0, 90000},
	{299999/ REDUCE_VEHICLE_PRICE, 1250.0, 100.0, 100.0, 100.0, 0.0, 149999},
	{3000000/ REDUCE_VEHICLE_PRICE, 2000.0, 100.0, 100.0, 100.0, 2.0, 1500000},
	{400000/ REDUCE_VEHICLE_PRICE, 1700.0, 100.0, 100.0, 100.0, 14.0, 200000},
	{15000/ REDUCE_VEHICLE_PRICE, 800.0, 100.0, 100.0, 0.0, 0.0, 7500},
	{90000/ REDUCE_VEHICLE_PRICE, 920.0, 100.0, 100.0, 17.0, 12.0, 45000},
	{60000/ REDUCE_VEHICLE_PRICE, 1400.0, 100.0, 100.0, 32.0, 24.0, 30000},
	{3500000/ REDUCE_VEHICLE_PRICE, 850.0, 100.0, 100.0, 100.0, 6.0, 1750000},
	{250000/ REDUCE_VEHICLE_PRICE, 720.0, 50.0, 100.0, 5.0, 45.0, 125000},
	{10000/ REDUCE_VEHICLE_PRICE, 740.0, 50.0, 100.0, 2.0, 49.0, 5000},
	{50000/ REDUCE_VEHICLE_PRICE, 740.0, 50.0, 100.0, 5.0, 40.0, 25000},
	{12000/ REDUCE_VEHICLE_PRICE, 700.0, 100.0, 100.0, 2.0, 25.0, 6000},
	{12000/ REDUCE_VEHICLE_PRICE, 700.0, 100.0, 100.0, 2.0, 25.0, 6000},
	{50000/ REDUCE_VEHICLE_PRICE, 900.0, 75.0, 100.0, 14.0, 8.0, 25000},
	{35000/ REDUCE_VEHICLE_PRICE, 900.0, 75.0, 100.0, 15.0, 8.0, 17500},
	{165000/ REDUCE_VEHICLE_PRICE, 710.0, 50.0, 100.0, 4.0, 45.0, 82500},
	{0, 0.0, 100.0, 100.0, 45.0, 10.0, 0},
	{0, 1650.0, 100.0, 100.0, 26.0, 10.0, 0},
	{100000/ REDUCE_VEHICLE_PRICE, 700.0, 50.0, 100.0, 4.0, 48.0, 50000},
	{150000/ REDUCE_VEHICLE_PRICE, 1250.0, 100.0, 100.0, 100.0, 15.0, 75000},
	{20000/ REDUCE_VEHICLE_PRICE, 750.0, 50.0, 100.0, 13.0, 18.0, 10000},
	{60000/ REDUCE_VEHICLE_PRICE, 910.0, 75.0, 100.0, 16.0, 8.0, 30000},
	{160000/ REDUCE_VEHICLE_PRICE, 900.0, 100.0, 100.0, 17.0, 3.0, 80000},
	{0, 850.0, 100.0, 100.0, 100.0, 6.0, 0},
	{700000/ REDUCE_VEHICLE_PRICE, 830.0, 100.0, 100.0, 17.0, 3.0, 350000},
	{40000/ REDUCE_VEHICLE_PRICE, 1200.0, 100.0, 100.0, 25.0, 25.0, 20000},
	{85000/ REDUCE_VEHICLE_PRICE, 910.0, 75.0, 100.0, 17.0, 14.0, 42500},
	{625000/ REDUCE_VEHICLE_PRICE, 800.0, 100.0, 100.0, 18.0, 9.0, 312500},
	{700, 500.0, 50.0, 100.0, 0.0, 0.0, 350},
	{120000/ REDUCE_VEHICLE_PRICE, 1400.0, 100.0, 100.0, 32.0, 12.0, 60000},
	{85000/ REDUCE_VEHICLE_PRICE, 1100.0, 100.0, 100.0, 43.0, 12.0, 42500},
	{350000/ REDUCE_VEHICLE_PRICE, 750.0, 100.0, 100.0, 100.0, 6.0, 175000},
	{0, 890.0, 100.0, 100.0, 0.0, 0.0, 0},
	{0, 1900.0, 100.0, 100.0, 21.0, 7.0, 0},
	{3500000/ REDUCE_VEHICLE_PRICE, 980.0, 100.0, 100.0, 48.0, 6.0, 1750000},
	{1000000/ REDUCE_VEHICLE_PRICE, 900.0, 100.0, 100.0, 48.0, 6.0, 500000},
	{110000/ REDUCE_VEHICLE_PRICE, 1110.0, 100.0, 100.0, 23.0, 10.0, 55000},
	{255000/ REDUCE_VEHICLE_PRICE, 1430.0, 100.0, 100.0, 28.0, 9.0, 127500},
	{41000/ REDUCE_VEHICLE_PRICE, 900.0, 75.0, 100.0, 15.0, 8.0, 20500},
	{47000/ REDUCE_VEHICLE_PRICE, 900.0, 75.0, 100.0, 15.0, 8.0, 23500},
	{0, 850.0, 100.0, 100.0, 70.0, 11.0, 0},
	{0, 800.0, 100.0, 100.0, 17.0, 3.0, 0},
	{0, 1000.0, 100.0, 100.0, 23.0, 12.0, 0},
	{140000/ REDUCE_VEHICLE_PRICE, 800.0, 100.0, 100.0, 11.0, 4.0, 70000},
	{3650000/ REDUCE_VEHICLE_PRICE, 0.0, 100.0, 100.0, 49.0, 6.0, 1825000},
	{110000/ REDUCE_VEHICLE_PRICE, 1400.0, 100.0, 100.0, 100.0, 6.0, 55000},
	{90000/ REDUCE_VEHICLE_PRICE, 1400.0, 100.0, 100.0, 100.0, 17.0, 45000},
	{140000/ REDUCE_VEHICLE_PRICE, 920.0, 100.0, 100.0, 19.0, 14.0, 70000},
	{0, 700.0, 100.0, 100.0, 0.0, 25.0, 0},
	{0, 800.0, 100.0, 100.0, 17.0, 3.0, 0},
	{0, 800.0, 100.0, 100.0, 17.0, 3.0, 0},
	{0, 850.0, 100.0, 100.0, 15.0, 7.0, 0},
	{110000/ REDUCE_VEHICLE_PRICE, 1110.0, 100.0, 100.0, 15.0, 10.0, 55000},
	{0, 800.0, 100.0, 100.0, 23.0, 3.0, 0},
	{155000/ REDUCE_VEHICLE_PRICE, 850.0, 100.0, 100.0, 20.0, 7.0, 77500},
	{180000/ REDUCE_VEHICLE_PRICE, 1200.0, 100.0, 100.0, 76.0, 17.0, 90000},
	{1000/ REDUCE_VEHICLE_PRICE, 500.0, 50.0, 100.0, 0.0, 0.0, 500},
	{0, 500.0, 50.0, 100.0, 0.0, 0.0, 0},
	{5000000/ REDUCE_VEHICLE_PRICE, 850.0, 100.0, 100.0, 100.0, 4.0, 2500000},
	{0, 850.0, 100.0, 100.0, 97.0, 6.0, 0},
	{0, 820.0, 100.0, 100.0, 73.0, 6.0, 0},
	{800000/ REDUCE_VEHICLE_PRICE, 2000.0, 100.0, 100.0, 100.0, 4.0, 400000},
	{900000/ REDUCE_VEHICLE_PRICE, 2000.0, 100.0, 100.0, 100.0, 3.0, 450000},
	{40000/ REDUCE_VEHICLE_PRICE, 900.0, 100.0, 100.0, 18.0, 9.0, 20000},
	{65000/ REDUCE_VEHICLE_PRICE, 900.0, 75.0, 100.0, 15.0, 9.0, 32500},
	{45000/ REDUCE_VEHICLE_PRICE, 900.0, 75.0, 100.0, 16.0, 8.0, 22500},
	{0, 1200.0, 100.0, 100.0, 100.0, 3.0, 0},
	{0, 1300.0, 100.0, 100.0, 100.0, 4.0, 0},
	{200000/ REDUCE_VEHICLE_PRICE, 710.0, 75.0, 100.0, 5.0, 45.0, 100000},
	{400000/ REDUCE_VEHICLE_PRICE, 700.0, 75.0, 100.0, 5.0, 48.0, 200000},
	{50000/ REDUCE_VEHICLE_PRICE, 0.0, 50.0, 100.0, 7.0, 20.0, 25000},
	{0, 2000.0, 100.0, 100.0, 100.0, 3.0, 0},
	{30000/ REDUCE_VEHICLE_PRICE, 1160.0, 100.0, 100.0, 26.0, 17.0, 15000},
	{55000/ REDUCE_VEHICLE_PRICE, 900.0, 100.0, 100.0, 15.0, 8.0, 27500},
	{45000/ REDUCE_VEHICLE_PRICE, 900.0, 75.0, 100.0, 15.0, 9.0, 22500},
	{500000/ REDUCE_VEHICLE_PRICE, 0.0, 100.0, 100.0, 29.0, 15.0, 250000},
	{45000/ REDUCE_VEHICLE_PRICE, 900.0, 75.0, 100.0, 15.0, 8.0, 22500},
	{0, 850.0, 100.0, 100.0, 0.0, 0.0, 0},
	{43000/ REDUCE_VEHICLE_PRICE, 800.0, 100.0, 100.0, 18.0, 23.0, 21500},
	{25000/ REDUCE_VEHICLE_PRICE, 1900.0, 100.0, 100.0, 25.0, 9.0, 12500},
	{65000/ REDUCE_VEHICLE_PRICE, 830.0, 100.0, 100.0, 17.0, 8.0, 32500},
	{75000/ REDUCE_VEHICLE_PRICE, 925.0, 100.0, 100.0, 16.0, 6.0, 37500},
	{110000/ REDUCE_VEHICLE_PRICE, 940.0, 100.0, 100.0, 23.0, 6.0, 55000},
	{65000/ REDUCE_VEHICLE_PRICE, 880.0, 75.0, 100.0, 14.0, 7.0, 32500},
	{0, 2000.0, 100.0, 100.0, 100.0, 12.0, 0},
	{0, 2000.0, 100.0, 100.0, 100.0, 12.0, 0},
	{0, 800.0, 100.0, 100.0, 15.0, 12.0, 0},
	{51000/ REDUCE_VEHICLE_PRICE, 900.0, 75.0, 100.0, 16.0, 8.0, 25500},
	{1200000/ REDUCE_VEHICLE_PRICE, 800.0, 100.0, 100.0, 24.0, 4.0, 600000},
	{135000/ REDUCE_VEHICLE_PRICE, 900.0, 75.0, 100.0, 15.0, 8.0, 67500},
	{25000/ REDUCE_VEHICLE_PRICE, 1200.0, 100.0, 100.0, 25.0, 13.0, 12500},
	{0, 1800.0, 100.0, 100.0, 25.0, 11.0, 0},
	{85000/ REDUCE_VEHICLE_PRICE, 880.0, 100.0, 100.0, 14.0, 13.0, 42500},
	{46000/ REDUCE_VEHICLE_PRICE, 910.0, 75.0, 100.0, 15.0, 8.0, 23000},
	{38000/ REDUCE_VEHICLE_PRICE, 900.0, 75.0, 100.0, 16.0, 8.0, 19000},
	{0, 1450.0, 100.0, 100.0, 100.0, 2.0, 0},
	{38000/ REDUCE_VEHICLE_PRICE, 900.0, 75.0, 100.0, 14.0, 8.0, 19000},
	{55000/ REDUCE_VEHICLE_PRICE, 900.0, 100.0, 100.0, 15.0, 8.0, 27500},
	{150000/ REDUCE_VEHICLE_PRICE, 950.0, 100.0, 100.0, 19.0, 8.0, 75000},
	{50000/ REDUCE_VEHICLE_PRICE, 1270.0, 100.0, 100.0, 12.0, 20.0, 25000},
	{0, 1500.0, 100.0, 100.0, 100.0, 2.0, 0},
	{110000/ REDUCE_VEHICLE_PRICE, 1280.0, 100.0, 100.0, 26.0, 9.0, 55000},
	{450000/ REDUCE_VEHICLE_PRICE, 820.0, 75.0, 100.0, 15.0, 9.0, 225000},
	{0, 1300.0, 100.0, 100.0, 26.0, 6.0, 0},
	{0, 1300.0, 100.0, 100.0, 26.0, 6.0, 0},
	{330000/ REDUCE_VEHICLE_PRICE, 810.0, 100.0, 100.0, 18.0, 3.0, 165000},
	{200000/ REDUCE_VEHICLE_PRICE, 810.0, 100.0, 100.0, 17.0, 3.0, 100000},
	{785000/ REDUCE_VEHICLE_PRICE, 880.0, 100.0, 100.0, 16.0, 7.0, 392500},
	{110000/ REDUCE_VEHICLE_PRICE, 920.0, 100.0, 100.0, 18.0, 12.0, 55000},
	{220000/ REDUCE_VEHICLE_PRICE, 880.0, 100.0, 100.0, 18.0, 9.0, 110000},
	{0, 1350.0, 100.0, 100.0, 100.0, 4.0, 0},
	{0, 700.0, 100.0, 100.0, 2.0, 0.0, 0},
	{180000/ REDUCE_VEHICLE_PRICE, 810.0, 100.0, 100.0, 13.0, 3.0, 90000},
	{65000/ REDUCE_VEHICLE_PRICE, 900.0, 75.0, 100.0, 15.0, 6.0, 32500},
	{85000/ REDUCE_VEHICLE_PRICE, 905.0, 75.0, 100.0, 15.0, 7.0, 42500},
	{500000/ REDUCE_VEHICLE_PRICE, 850.0, 100.0, 100.0, 8.0, 16.0, 250000},
	{0, 0.0, 100.0, 100.0, 0.0, 12.0, 0},
	{0, 0.0, 100.0, 100.0, 0.0, 0.0, 0},
	{0, 700.0, 100.0, 100.0, 4.0, 22.0, 0},
	{0, 750.0, 100.0, 100.0, 8.0, 18.0, 0},
	{0, 1300.0, 100.0, 100.0, 29.0, 4.0, 0},
	{0, 750.0, 100.0, 100.0, 8.0, 18.0, 0},
	{80000/ REDUCE_VEHICLE_PRICE, 900.0, 75.0, 100.0, 16.0, 6.0, 40000},
	{58000/ REDUCE_VEHICLE_PRICE, 890.0, 75.0, 100.0, 15.0, 6.0, 29000},
	{0, 1500.0, 100.0, 100.0, 100.0, 1.0, 0},
	{500000/ REDUCE_VEHICLE_PRICE, 1800.0, 100.0, 100.0, 100.0, 12.0, 250000},
	{300000/ REDUCE_VEHICLE_PRICE, 1150.0, 100.0, 100.0, 25.0, 10.0, 150000},
	{200000/ REDUCE_VEHICLE_PRICE, 970.0, 100.0, 100.0, 22.0, 7.0, 100000},
	{0, 710.0, 50.0, 100.0, 4.0, 45.0, 0},
	{80000/ REDUCE_VEHICLE_PRICE, 1300.0, 100.0, 100.0, 29.0, 24.0, 40000},
	{0, 750.0, 100.0, 100.0, 8.0, 18.0, 0},
	{0, 0.0, 100.0, 100.0, 0.0, 0.0, 0},
	{60000/ REDUCE_VEHICLE_PRICE, 915.0, 100.0, 100.0, 16.0, 8.0, 30000},
	{50000/ REDUCE_VEHICLE_PRICE, 740.0, 50.0, 100.0, 7.0, 40.0, 25000},
	{250000/ REDUCE_VEHICLE_PRICE, 820.0, 100.0, 100.0, 17.0, 3.0, 125000},
	{80000/ REDUCE_VEHICLE_PRICE, 1200.0, 100.0, 100.0, 29.0, 12.0, 40000},
	{160000/ REDUCE_VEHICLE_PRICE, 850.0, 100.0, 100.0, 14.0, 3.0, 80000},
	{0, 0.0, 100.0, 100.0, 0.0, 0.0, 0},
	{0, 0.0, 100.0, 100.0, 0.0, 0.0, 0},
	{0, 1500.0, 100.0, 100.0, 100.0, 1.0, 0},
	{4000000/ REDUCE_VEHICLE_PRICE, 850.0, 100.0, 100.0, 100.0, 6.0, 2000000},
	{0, 700.0, 100.0, 100.0, 2.0, 50.0, 0},
	{0, 1250.0, 100.0, 100.0, 100.0, 11.0, 0},
	{99999/ REDUCE_VEHICLE_PRICE, 1110.0, 100.0, 100.0, 17.0, 13.0, 50000},
	{99999/ REDUCE_VEHICLE_PRICE, 1110.0, 100.0, 100.0, 17.0, 13.0, 50000},
	{99999/ REDUCE_VEHICLE_PRICE, 1110.0, 100.0, 100.0, 17.0, 13.0, 50000},
	{135000/ REDUCE_VEHICLE_PRICE, 1220.0, 100.0, 100.0, 25.0, 21.0, 67500},
	{38000/ REDUCE_VEHICLE_PRICE, 920.0, 100.0, 100.0, 22.0, 7.0, 19000},
	{750000/ REDUCE_VEHICLE_PRICE, 3500.0, 100.0, 100.0, 100.0, 13.0, 375000},
	{330000/ REDUCE_VEHICLE_PRICE, 820.0, 100.0, 100.0, 20.0, 3.0, 165000},
	{650000/ REDUCE_VEHICLE_PRICE, 950.0, 100.0, 100.0, 19.0, 3.0, 325000},
	{0, 0.0, 75.0, 100.0, 14.0, 8.0, 0},
	{0, 1200.0, 100.0, 100.0, 25.0, 26.0, 0},
	{0, 0.0, 100.0, 100.0, 0.0, 0.0, 0},
	{0, 0.0, 100.0, 100.0, 0.0, 0.0, 0},
	{0, 0.0, 100.0, 100.0, 0.0, 0.0, 0},
	{0, 1650.0, 100.0, 100.0, 100.0, 12.0, 0},
	{0, 0.0, 100.0, 100.0, 0.0, 0.0, 0},
	{0, 0.0, 100.0, 100.0, 0.0, 0.0, 0}
};

Float:GetVehicleDataHealth(modelid)
{
	if(VehicleData[modelid - 400][c_maxhp])
		return VehicleData[modelid - 400][c_maxhp];

	return 1000.0;
}

Float:GetVehicleDataFuel(modelid)
{
	if(VehicleData[modelid - 400][c_maxfuel])
		return VehicleData[modelid - 400][c_maxfuel];

	return 100.0;
}

Float:GetVehicleDataFuelRate(modelid)
{
	if(VehicleData[modelid - 400][c_fuelrate])
		return VehicleData[modelid - 400][c_fuelrate];

	return 15.0;
}

GetVehicleDataArmourCost(modelid)
{
	if(VehicleData[modelid - 400][c_price])
		return floatround(float(VehicleData[modelid - 400][c_price]) / 10000.00, floatround_round);

	return true;
}

enum E_CAR_DATA
{
	carVehicle,
	carID,
	carModel,
	carOwner,
	carOwnerName[MAX_PLAYER_NAME],
	carName[64],
	carUItag[15],
	Float:carPos[4],
	carColor1,
	carColor2,
	carPaintjob,
	carLocked,
	carMods[14],
	Float:carFuel,
	carLock,
	carAlarm,
	carInsurance,
	carXM,
	carDamage[4],
	Float:carHealth,
	Float:carArmour,
	carDestroyed,
	Float:carMileage,
	carImmob,
	Float:carBatteryL,
	Float:carEngineL,
	carPlate[32],
	carComps,
	carXMOn,
	carDupKey,
	carWeapon[MAX_CAR_WEAPONS],
	carAmmo[MAX_CAR_WEAPONS],
	carWeaponLicense[MAX_CAR_WEAPONS],
	carPackageWP[MAX_CAR_WEAPON_PACKAGE],
	carPackageAmmo[MAX_CAR_WEAPON_PACKAGE],
	carRandomFailed
};

new CarData[MAX_PLAYER_VEHICLES][E_CAR_DATA];
new CarPlace[MAX_PLAYER_VEHICLES][MAX_CAR_WEAPONS][cp_e];
new Iterator:sv_playercar<MAX_PLAYER_VEHICLES>;

// Functions

Car_DespawnEx(carid)
{
    if(Iter_Contains(sv_playercar, carid))
	{
	    CoreVehicles[CarData[carid][carVehicle]][vehicleCarID] = -1;

		for(new x = 0; x != MAX_CAR_WEAPONS; ++x)
		{
			if(IsValidDynamicObject(CarPlace[carid][x][cPobj]))
			{
				DestroyDynamicObject(CarPlace[carid][x][cPobj]);
			}
		}

		for(new x = 0; x != MAX_CAR_WEAPON_PACKAGE; ++x)
		{
			CarData[carid][carPackageWP][x] = 0;
			CarData[carid][carPackageAmmo][x] = 0;
		}

		new vehicleid = CarData[carid][carVehicle];

		CoreVehicles[vehicleid][vbreakin] = 0;
		CoreVehicles[vehicleid][vbreaktime] = 0;
		CoreVehicles[vehicleid][vbreakeffect] = 0; 
		
		VehicleLabel[vehicleid][vLabelCount] = 0;
		VehicleLabel[vehicleid][vLabelTime] = 0;
		VehicleLabel[vehicleid][vLabelType] = 0;

		if(IsValidDynamic3DTextLabel(VehicleLabel[vehicleid][vLabel])) DestroyDynamic3DTextLabel(VehicleLabel[vehicleid][vLabel]);				

		DestroyVehicle(CarData[carid][carVehicle]);
		Iter_Remove(sv_vehicles, CarData[carid][carVehicle]);

	    CarData[carid][carID] = 0;
	    CarData[carid][carOwner] = 0;
	    CarData[carid][carVehicle] = 0;
	    CarData[carid][carName][0] = EOS;
		CarData[carid][carUItag][0] = EOS;
		
		ResetVehicleDrugs(vehicleid);

		if(Iter_Contains(sv_activevehicles, vehicleid))
		{
			Iter_Remove(sv_activevehicles, vehicleid);
		}

		for(new x = 0; x != MAX_CAR_WEAPONS; ++x)
		{
			CarData[carid][carWeapon][x] = 0;
			CarData[carid][carAmmo][x] = 0;
		}

		for(new x = 0; x < 100; ++x)
		{
	 		if(!VehicleRequests[x][requestActive]) continue;

	 		if(VehicleRequests[x][requestCar] == carid)
	 		{
	 		    TrashVehicleRequest(x);
	 		    break;
	 		}
		}

	    Iter_Remove(sv_playercar, carid);
	}
}

IsOperatingVehicle(vehicleid)
{
	if(!VehicleLabel[vehicleid][vLabelTime]) return false;

	switch(VehicleLabel[vehicleid][vLabelType])
	{
		case VLT_TYPE_UNREGISTER, VLT_TYPE_REGISTER, VLT_TYPE_UPGRADELOCK, VLT_TYPE_UPGRADEIMMOB, VLT_TYPE_UPGRADEALARM, VLT_TYPE_UPGRADEINSURANCE, VLT_TYPE_ARMOUR, VLT_TYPE_UPGRADEBATTERY, VLT_TYPE_UPGRADEENGINE:
		{
			return true;
		}
	}

	return false;
}

SetVehicleLabel(vehicleid, type, time)
{
    if(!IsValidDynamic3DTextLabel(VehicleLabel[vehicleid][vLabel]))
	{
		switch(type)
		{
		    case VLT_TYPE_TOWING: VehicleLabel[vehicleid][vLabel] = CreateDynamic3DTextLabel("(( ---------- ))\nTOWING VEHICLE", COLOR_GREEN2, 0, 0, 0, 20, INVALID_PLAYER_ID, vehicleid,  0, 0, 0, -1, 100);
		    case VLT_TYPE_PERMITFACTION: VehicleLabel[vehicleid][vLabel] = CreateDynamic3DTextLabel("You are not allowed to enter this vehicle (Faction-vehicle)", COLOR_WHITE, 0, 0, 0, 20, INVALID_PLAYER_ID, vehicleid,  0, 0, 0, -1, 50);
		    case VLT_TYPE_LOCK: VehicleLabel[vehicleid][vLabel] = CreateDynamic3DTextLabel("This vehicle is locked!", 0xFF6347FF, 0, 0, 0, 20, INVALID_PLAYER_ID, vehicleid,  0, 0, 0, -1, 50);
		    case VLT_TYPE_UNREGISTER: VehicleLabel[vehicleid][vLabel] = CreateDynamic3DTextLabel("(( ---------- ))\nREMOVING REGISTRATION", COLOR_GREEN2, 0, 0, 0, 20, INVALID_PLAYER_ID, vehicleid,  0, 0, 0, -1, 50);
			case VLT_TYPE_REGISTER: VehicleLabel[vehicleid][vLabel] = CreateDynamic3DTextLabel("(( ---------- ))\nVEHICLE REGISTRATION", COLOR_GREEN2, 0, 0, 0, 20, INVALID_PLAYER_ID, vehicleid,  0, 0, 0, -1, 50);
			case VLT_TYPE_OPERAFAILED: VehicleLabel[vehicleid][vLabel] = CreateDynamic3DTextLabel("(( OPERATION FAILED ))", 0xFF6347FF, 0, 0, 0, 20, INVALID_PLAYER_ID, vehicleid,  0, 0, 0, -1, 50);
			case VLT_TYPE_UPGRADELOCK: VehicleLabel[vehicleid][vLabel] = CreateDynamic3DTextLabel("(( ---------- ))\nUPGRADING LOCK", COLOR_GREEN2, 0, 0, 0, 20, INVALID_PLAYER_ID, vehicleid,  0, 0, 0, -1, 50);
			case VLT_TYPE_UPGRADEIMMOB: VehicleLabel[vehicleid][vLabel] = CreateDynamic3DTextLabel("(( ---------- ))\nUPGRADING IMMOBILISER", COLOR_GREEN2, 0, 0, 0, 20, INVALID_PLAYER_ID, vehicleid,  0, 0, 0, -1, 50);
			case VLT_TYPE_UPGRADEALARM: VehicleLabel[vehicleid][vLabel] = CreateDynamic3DTextLabel("(( ---------- ))\nUPGRADING ALARM", COLOR_GREEN2, 0, 0, 0, 20, INVALID_PLAYER_ID, vehicleid,  0, 0, 0, -1, 50);
			case VLT_TYPE_UPGRADEINSURANCE: VehicleLabel[vehicleid][vLabel] = CreateDynamic3DTextLabel("(( ---------- ))\nINSURANCE UPGRADE", COLOR_GREEN2, 0, 0, 0, 20, INVALID_PLAYER_ID, vehicleid,  0, 0, 0, -1, 50);
			case VLT_TYPE_ARMOUR: VehicleLabel[vehicleid][vLabel] = CreateDynamic3DTextLabel("(( ---------- ))\nUPGRADING ARMOUR", COLOR_GREEN2, 0, 0, 0, 20, INVALID_PLAYER_ID, vehicleid,  0, 0, 0, -1, 50);
			case VLT_TYPE_OPERAOUTOFRANG: VehicleLabel[vehicleid][vLabel] = CreateDynamic3DTextLabel("(( OPERATION FAILED ))", 0xFF6347FF, 0, 0, 0, 20, INVALID_PLAYER_ID, vehicleid,  0, 0, 0, -1, 50);
            case VLT_TYPE_REFILL: VehicleLabel[vehicleid][vLabel] = CreateDynamic3DTextLabel("(( ---------- ))\nREFUELING", COLOR_GREEN2, 0, 0, 0, 20, INVALID_PLAYER_ID, vehicleid,  0, 0, 0, -1, 100);
			case VLT_TYPE_UPGRADEBATTERY: VehicleLabel[vehicleid][vLabel] = CreateDynamic3DTextLabel("(( ---------- ))\nBATTERY REPLACEMENT", COLOR_GREEN2, 0, 0, 0, 20, INVALID_PLAYER_ID, vehicleid,  0, 0, 0, -1, 100);
            case VLT_TYPE_UPGRADEENGINE: VehicleLabel[vehicleid][vLabel] = CreateDynamic3DTextLabel("(( ---------- ))\nENGINE CHANGE", COLOR_GREEN2, 0, 0, 0, 20, INVALID_PLAYER_ID, vehicleid,  0, 0, 0, -1, 100);
			case VLT_TYPE_BREAKIN:
			{
                new string[4];
                format(string, sizeof(string), "%d", CoreVehicles[vehicleid][vbreakin]);
				VehicleLabel[vehicleid][vLabel] = CreateDynamic3DTextLabel(CoreVehicles[vehicleid][vbreakin] ? (string) : ("Unlocked"), (CoreVehicles[vehicleid][vbreakin]) ? 0xAFAFAFAA : COLOR_GREEN2, -0.9, 0.8, 0, 20, INVALID_PLAYER_ID, vehicleid,  0, 0, 0, -1, 50);
			}
		}

		/*foreach (new i : VehicleOccupant(vehicleid))
		{
			Streamer_Update(i, STREAMER_TYPE_3D_TEXT_LABEL);
		}*/
	}

	if(!Iter_Contains(sv_activevehicles, vehicleid))
	{
		Iter_Add(sv_activevehicles, vehicleid);
	}

	VehicleLabel[vehicleid][vLabelType] = type;
	VehicleLabel[vehicleid][vLabelTime] = time;
	VehicleLabel[vehicleid][vLabelCount] = 0;
}

CancelVehicleBreakin(vehicleid)
{
	if(!VehicleLabel[vehicleid][vLabelTime])
	{
		Iter_Remove(sv_activevehicles, vehicleid);
	}					

	CoreVehicles[vehicleid][vbreakin] = 0;
	CoreVehicles[vehicleid][vbreaktime] = 0;
	CoreVehicles[vehicleid][vbreakeffect] = 0;
}

ResetVehicleLabel(vehicleid)
{
    VehicleLabel[vehicleid][vLabelCount] = 0;
	VehicleLabel[vehicleid][vLabelTime] = 0;
	VehicleLabel[vehicleid][vLabelType] = 0;

	if(IsValidDynamic3DTextLabel(VehicleLabel[vehicleid][vLabel])) DestroyDynamic3DTextLabel(VehicleLabel[vehicleid][vLabel]);
}

CalculateDoorDamage(vehicleid, playerid)
{
	new
		weaponid = GetPlayerWeapon(playerid)
	;

	switch(CoreVehicles[vehicleid][vbreakeffect])
	{
		case LESS_DAMAGE_FIST:
		{
			if(weaponid == 0)
			{
				CoreVehicles[vehicleid][vbreakin] = (CoreVehicles[vehicleid][vbreakin] - 1 <= 0) ? 0 : CoreVehicles[vehicleid][vbreakin] - 1;

				if(PlayerData[playerid][pHealth] > 10.0)
				{
					SetPlayerHealthEx(playerid, PlayerData[playerid][pHealth] - 10.0);
				}
			}
			if(weaponid >= 1 && weaponid <= 9)
			{
				CoreVehicles[vehicleid][vbreakin] = (CoreVehicles[vehicleid][vbreakin] - 5 <= 0) ? 0 : CoreVehicles[vehicleid][vbreakin] - 5;
			}
			if(weaponid >= 22 && weaponid <= 24)
			{
				CoreVehicles[vehicleid][vbreakin] = (CoreVehicles[vehicleid][vbreakin] - 15 <= 0) ? 0 : CoreVehicles[vehicleid][vbreakin] - 15;
			}
			if(weaponid >= 25 && weaponid <= 33)
			{
				CoreVehicles[vehicleid][vbreakin] = (CoreVehicles[vehicleid][vbreakin] - 30 <= 0) ? 0 : CoreVehicles[vehicleid][vbreakin] - 30;
			}
		}
		case BLOCK_FIST:
		{
			if(weaponid >= 1 && weaponid <= 9)
			{
				CoreVehicles[vehicleid][vbreakin] = (CoreVehicles[vehicleid][vbreakin] - 5 <= 0) ? 0 : CoreVehicles[vehicleid][vbreakin] - 5;
			}
			if(weaponid >= 22 && weaponid <= 24)
			{
				CoreVehicles[vehicleid][vbreakin] = (CoreVehicles[vehicleid][vbreakin] - 15 <= 0) ? 0 : CoreVehicles[vehicleid][vbreakin] - 15;
			}
		}
		case LESS_DAMAGE_MELEE:
		{
			if(weaponid >= 1 && weaponid <= 9)
			{
				CoreVehicles[vehicleid][vbreakin] = (CoreVehicles[vehicleid][vbreakin] - 2 <= 0) ? 0 : CoreVehicles[vehicleid][vbreakin] - 2;
			}
			if(weaponid >= 22 && weaponid <= 24)
			{
				CoreVehicles[vehicleid][vbreakin] = (CoreVehicles[vehicleid][vbreakin] - 5 <= 0) ? 0 : CoreVehicles[vehicleid][vbreakin] - 5;
			}
			if(weaponid >= 25 && weaponid <= 33)
			{
				CoreVehicles[vehicleid][vbreakin] = (CoreVehicles[vehicleid][vbreakin] - 20 <= 0) ? 0 : CoreVehicles[vehicleid][vbreakin] - 20;
			}
		}
		case BLOCK_PHYSICAL:
		{
			if(weaponid >= 1 && weaponid <= 9)
			{
				CoreVehicles[vehicleid][vbreakin] = (CoreVehicles[vehicleid][vbreakin] - 1 <= 0) ? 0 : CoreVehicles[vehicleid][vbreakin] - 1;
			}
			if(weaponid >= 22 && weaponid <= 24)
			{
				CoreVehicles[vehicleid][vbreakin] = (CoreVehicles[vehicleid][vbreakin] - 2 <= 0) ? 0 : CoreVehicles[vehicleid][vbreakin] - 2;
			}
			if(weaponid >= 25 && weaponid <= 33)
			{
				CoreVehicles[vehicleid][vbreakin] = (CoreVehicles[vehicleid][vbreakin] - 30 <= 0) ? 0 : CoreVehicles[vehicleid][vbreakin] - 30;
			}
		}
		default:
		{
			if(weaponid == 0)
			{
				CoreVehicles[vehicleid][vbreakin] = (CoreVehicles[vehicleid][vbreakin] - 2 <= 0) ? 0 : CoreVehicles[vehicleid][vbreakin] - 2;
				SetPlayerHealthEx(playerid, PlayerData[playerid][pHealth] - 5.0);
			}
			if(weaponid >= 1 && weaponid <= 9)
			{
				CoreVehicles[vehicleid][vbreakin] = (CoreVehicles[vehicleid][vbreakin] - 5 <= 0) ? 0 : CoreVehicles[vehicleid][vbreakin] - 5;
			}
			if(weaponid >= 22 && weaponid <= 24)
			{
				CoreVehicles[vehicleid][vbreakin] = (CoreVehicles[vehicleid][vbreakin] - 15 <= 0) ? 0 : CoreVehicles[vehicleid][vbreakin] - 15;
			}
			if(weaponid >= 25 && weaponid <= 33)
			{
				CoreVehicles[vehicleid][vbreakin] = (CoreVehicles[vehicleid][vbreakin] - 30 <= 0) ? 0 : CoreVehicles[vehicleid][vbreakin] - 30;
			}
		}
	}
}

CreateScramble(const s[])
{
	new scam[16];

    strcpy(scam, s);

	new tmp[2], num, len = strlen(scam);

	for(new i = 0; scam[i] != EOS; ++i)
	{
	    num = random(len);
		tmp[0] = scam[i];
		tmp[1] = scam[num];
		scam[num] = tmp[0];
		scam[i] = tmp[1];
	}
	return scam;
}

TriggerVehicleAlarm(playerid, vehicleid)
{
	new
		engine,
		lights,
		alarm,
		doors,
		bonnet,
		boot,
		objective
	;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

	new id = Car_GetID(vehicleid);

	if(CarData[id][carAlarm] == 2)
	{
		alarm = 1;

		new other = IsCharacterOnline(CarData[id][carOwner]);

		if(other != -1) SendClientMessage(other, COLOR_YELLOW, "SMS: Your vehicle alarm has been set off, Sender: Vehicle Alarm (Unknown)");
	}
	else if(CarData[id][carAlarm] == 3)
	{
		SendPoliceMessage(COLOR_LIGHTRED, "[Vehicle Alarm]: %s located in %s", ReturnVehicleName(vehicleid), GetPlayerLocation(playerid));

		new other = IsCharacterOnline(CarData[id][carOwner]);

		if(other != -1) SendClientMessage(other, COLOR_YELLOW, "SMS: Your vehicle alarm has been set off, Sender: Vehicle Alarm (Unknown)");
	}
	else if(CarData[id][carAlarm] == 4)
	{
		alarm = 1;
		objective = 1;

		SendPoliceMessage(COLOR_LIGHTRED, "[Vehicle Alarm]: %s located in %s", ReturnVehicleName(vehicleid), GetPlayerLocation(playerid));

		new other = IsCharacterOnline(CarData[id][carOwner]);

		if(other != -1) SendClientMessage(other, COLOR_YELLOW, "SMS: Your vehicle alarm has been set off, Sender: Vehicle Alarm (Unknown)");
	}
	else
	{
		alarm = 1;
	}

	SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

	SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "*[ADMIN] Vehicle Alarm: %s (%d) is breaking into a %s (id: %d)", ReturnName(playerid), playerid, ReturnVehicleName(vehicleid), vehicleid);
}

Car_PrintStats(playerid, carid)
{
	SendClientMessageEx(playerid, COLOR_CYAN, "Life Span: Engine Life[%.2f], Battery Life[%.2f], Miles Driven[%.2f]", CarData[carid][carEngineL], CarData[carid][carBatteryL], CarData[carid][carMileage]);
	SendClientMessageEx(playerid, COLOR_CYAN, "Security: Lock[%d], Alarm[%d], Immob[%d], Insurance[%d]", CarData[carid][carLock], CarData[carid][carAlarm], CarData[carid][carImmob], CarData[carid][carInsurance]);

	if(CarData[carid][carArmour])
	{
		SendClientMessageEx(playerid, COLOR_CYAN, "Misc: Primary Color[{%06x}#%d{F0F8FF}], Secondary Color[{%06x}#%d{F0F8FF}], License Plate[%s], Armour[%.2f]", \
		g_arrSelectColors[CarData[carid][carColor1]] >>> 8, CarData[carid][carColor1], g_arrSelectColors[CarData[carid][carColor2]] >>> 8, CarData[carid][carColor2], CarData[carid][carPlate], CarData[carid][carArmour]);
	}
	else
	{
		SendClientMessageEx(playerid, COLOR_CYAN, "Misc: Primary Color[{%06x}#%d{F0F8FF}], Secondary Color[{%06x}#%d{F0F8FF}], License Plate[%s]", \
		g_arrSelectColors[CarData[carid][carColor1]] >>> 8, CarData[carid][carColor1], g_arrSelectColors[CarData[carid][carColor2]] >>> 8, CarData[carid][carColor2], CarData[carid][carPlate]);
	}
}

Car_SaveID(carid)
{
	new query[1536];

	if(carid != -1)
	{
        CarData[carid][carFuel] = CoreVehicles[CarData[carid][carVehicle]][vehFuel];

		SaveSlotVehicleDamage(carid);

		format(query, sizeof(query), "UPDATE `cars` SET `carModel` = '%d', `carOwner` = '%d', `carName` = '%s', `carUItag` = '%s', `carPosX` = '%.4f', `carPosY` = '%.4f', `carPosZ` = '%.4f', `carPosR` = '%.4f', `carColor1` = '%d', `carColor2` = '%d', `carPaintjob` = '%d', `carLocked` = '%d', `carAlarm` = '%d', `carFuel` = '%f'",
	        CarData[carid][carModel],
	        CarData[carid][carOwner],
	        CarData[carid][carName],
	        CarData[carid][carUItag],
	        CarData[carid][carPos][0],
	        CarData[carid][carPos][1],
	        CarData[carid][carPos][2],
	        CarData[carid][carPos][3],
	        CarData[carid][carColor1],
	        CarData[carid][carColor2],
	        CarData[carid][carPaintjob],
	        CarData[carid][carLocked],
            CarData[carid][carAlarm],
	        CarData[carid][carFuel]
		);

		format(query, sizeof(query), "%s, `carMod1` = '%d', `carMod2` = '%d', `carMod3` = '%d', `carMod4` = '%d', `carMod5` = '%d', `carMod6` = '%d', `carMod7` = '%d', `carMod8` = '%d', `carMod9` = '%d', `carMod10` = '%d', `carMod11` = '%d', `carMod12` = '%d', `carMod13` = '%d', `carMod14` = '%d'",
			query,
			CarData[carid][carMods][0],
			CarData[carid][carMods][1],
			CarData[carid][carMods][2],
			CarData[carid][carMods][3],
			CarData[carid][carMods][4],
			CarData[carid][carMods][5],
			CarData[carid][carMods][6],
			CarData[carid][carMods][7],
			CarData[carid][carMods][8],
			CarData[carid][carMods][9],
			CarData[carid][carMods][10],
			CarData[carid][carMods][11],
			CarData[carid][carMods][12],
			CarData[carid][carMods][13]
		);

		format(query, sizeof(query), "%s, `carWeapon0` = '%d', `carWeapon1` = '%d', `carWeapon2` = '%d', `carWeapon3` = '%d', `carAmmo0` = '%d', `carAmmo1` = '%d', `carAmmo2` = '%d', `carAmmo3` = '%d'",
			query,
			CarData[carid][carWeapon][0],
			CarData[carid][carWeapon][1],
			CarData[carid][carWeapon][2],
			CarData[carid][carWeapon][3],
			CarData[carid][carAmmo][0],
			CarData[carid][carAmmo][1],
			CarData[carid][carAmmo][2],
			CarData[carid][carAmmo][3]
		);

		format(query, sizeof(query), "%s, `carInsurance` = '%d', `carDamage1` = '%d', `carDamage2` = '%d', `carDamage3` = '%d', `carDamage4` = '%d', `carHealth` = '%f', `carArmour` = '%f', `carDestroyed` = '%d', `carLock` = '%d', `carMileage` = '%f', `carImmob` = '%d', `carBatteryL` = '%f', `carEngineL` = '%f', `carPlate` = '%s', `carComps` = '%d', `carDuplicate` = '%d', `carPlacePos` = '%s', `licenseWeapons` = '%s' WHERE `carID` = '%d' LIMIT 1",
			query,
			CarData[carid][carInsurance],
			CarData[carid][carDamage][0],
			CarData[carid][carDamage][1],
			CarData[carid][carDamage][2],
			CarData[carid][carDamage][3],
			CarData[carid][carHealth],
			CarData[carid][carArmour],
			CarData[carid][carDestroyed],
			CarData[carid][carLock],
			CarData[carid][carMileage],
			CarData[carid][carImmob],
			CarData[carid][carBatteryL],
			CarData[carid][carEngineL],
			CarData[carid][carPlate],
			CarData[carid][carComps],
			CarData[carid][carDupKey],
			FormatPlaceItems(carid),
			FormatCarLicenseWeapons(carid),
			CarData[carid][carID]
		);

		return mysql_tquery(dbCon, query);
	}
	
	return false;
}

SaveVehicleDamage(vehicleid)
{
	new slot = -1;

	if((slot = Car_GetID(vehicleid)) != -1)
	{
	    // panels, doors, lights, tires
		GetVehicleDamageStatus(vehicleid, CarData[slot][carDamage][0], CarData[slot][carDamage][1], CarData[slot][carDamage][2], CarData[slot][carDamage][3]);
		GetVehicleHealth(vehicleid, CarData[slot][carHealth]);
	}
}

SaveVehicleDamageID(slot)
{
	if(slot == -1) return true;

	new vehicleid = CarData[slot][carVehicle];

	// panels, doors, lights, tires
	GetVehicleDamageStatus(vehicleid, CarData[slot][carDamage][0], CarData[slot][carDamage][1], CarData[slot][carDamage][2], CarData[slot][carDamage][3]);
	GetVehicleHealth(vehicleid, CarData[slot][carHealth]);
	return true;
}

SaveSlotVehicleDamage(slot)
{
	GetVehicleDamageStatus(CarData[slot][carVehicle], CarData[slot][carDamage][0], CarData[slot][carDamage][1], CarData[slot][carDamage][2], CarData[slot][carDamage][3]);
	GetVehicleHealth(CarData[slot][carVehicle], CarData[slot][carHealth]);
}

PutPlayerSettingVehicle(playerid, model, price)
{
    if(CountVehicleKeys(playerid) >= MaxVehiclesSpawned(playerid))
		return SendServerMessage(playerid, "You already have your max amount of private vehicles spawned.");

	if(PlayerData[playerid][pCash] < price)
		return SendServerMessage(playerid, "You don't have enough money for this vehicle.");

	if(PlayerData[playerid][pDonateRank] < IsDonateCar(model))
		return SendServerMessage(playerid, "This vehicle is for Donators only.");

	if(IsCopCar(model))
	{
		if(GetFactionType(playerid) != 1)
			return SendServerMessage(playerid, "You are not a part of this vehicle faction.");
	}

	if(IsMedicCar(model))
	{
		if(GetFactionType(playerid) != 3)
			return SendServerMessage(playerid, "You are not a part of this vehicle faction.");
	}

	new id = -1;

	if((id = Business_Nearest(playerid)) != -1 && BusinessData[id][bType] == 4)
	{
        new Float:Vx, Float:Vy, Float:Vz, Float:Va, Float:xdist, Float:ydist, Float:zdist, Float:dist;

	    if(VDealerSelectCatalog[playerid] == 13)
	    {
			if(BusinessData[id][bBuyingBoatX] == 0 && BusinessData[id][bBuyingBoatY] == 0 && BusinessData[id][bBuyingBoatZ] == 0)
				return SendClientMessage(playerid, COLOR_LIGHTRED, "Something went wrong, please contact a developer.");

            Vx = BusinessData[id][bBuyingBoatX];
            Vy = BusinessData[id][bBuyingBoatY];
            Vz = BusinessData[id][bBuyingBoatZ];
            Va = BusinessData[id][bBuyingBoatA];

	        dist = 6.5;
			xdist = 0.014912;
			ydist = 3.6;
			zdist = 0.004;
	    }
	    else if(VDealerSelectCatalog[playerid] == 0 || VDealerSelectCatalog[playerid] == 1)
	    {
			if(BusinessData[id][bBuyingAirX] == 0 && BusinessData[id][bBuyingAirY] == 0 && BusinessData[id][bBuyingAirZ] == 0)
				return SendClientMessage(playerid, COLOR_LIGHTRED, "Something went wrong, please contact a developer.");

            Vx = BusinessData[id][bBuyingAirX];
            Vy = BusinessData[id][bBuyingAirY];
            Vz = BusinessData[id][bBuyingAirZ];
            Va = BusinessData[id][bBuyingAirA];

	        dist = 0;
			xdist = 0.003728;
			ydist = 1.8;
			zdist = 0.002;
	    }
	    else
		{
			if(BusinessData[id][bBuyingCarX] == 0 && BusinessData[id][bBuyingCarY] == 0 && BusinessData[id][bBuyingCarZ] == 0)
				return SendClientMessage(playerid, COLOR_LIGHTRED, "Something went wrong, please contact a developer.");

            Vx = BusinessData[id][bBuyingCarX];
            Vy = BusinessData[id][bBuyingCarY];
            Vz = BusinessData[id][bBuyingCarZ];
            Va = BusinessData[id][bBuyingCarA];

			dist = 0;
			xdist = 0.003728;
			ydist = 1.8;
			zdist = 0.002;
		}

     	VDealerColor[playerid][0] = random(255);
       	VDealerColor[playerid][1] = random(255);

		VDealerVehicle[playerid] = CreateVehicle(model, Vx,Vy,Vz,Va, VDealerColor[playerid][0], VDealerColor[playerid][1], -1);

		if(VDealerVehicle[playerid] != INVALID_VEHICLE_ID)
		{
		    VDealerBiz[playerid] = id;
		    VDealerSetting{playerid} = true;
		    PutPlayerInVehicle(playerid, VDealerVehicle[playerid], 0);

		    new Float:X, Float:Y, Float:Z, Float:vX, Float:vY, Float:vZ;

		    TogglePlayerControllable(playerid, 0);

            GetVehicleHood(VDealerVehicle[playerid], X, Y, Z);
			//GetPosInFrontOfVehicle(VDealerVehicle[playerid], X, Y, dist);
			GetVehiclePos(VDealerVehicle[playerid],vX,vY,vZ);

			InterpolateCameraPos(playerid, BusinessData[id][bEntranceX], BusinessData[id][bEntranceY], BusinessData[id][bEntranceZ], X + (X * xdist),Y + ydist, Z + (Z * zdist) + dist, 1500, 1);
			InterpolateCameraLookAt(playerid, BusinessData[id][bEntranceX], BusinessData[id][bEntranceY], BusinessData[id][bEntranceZ], vX,vY,vZ, 1300, 1);

			ResetVehicle(VDealerVehicle[playerid]);
			VDealerLock[playerid] = 0;
			VDealerImmob[playerid] = 0;
			VDealerAlarm[playerid] = 0;
			VDealerXM[playerid] = 0;
			VDealerPrice[playerid]=price;

			ShowPlayerDealercarDialog(playerid);
		}
    }
	return true;
}

ShowPlayerDealercarDialog(playerid)
{
	new model = GetVehicleModel(VDealerVehicle[playerid]), price = VDealerPrice[playerid], string[64], string2[1024];

	format(string, sizeof(string), "%s - %s", g_arrVehicleNames[model - 400], GetDealershipVehiclePrice(playerid));

	format(string2, sizeof(string2), "{FFFF00}Value:\t\t\t{FFFFFF}%s\n{FFFF00}Max Velocity:\t\t{FFFFFF}%.2f\n{FFFF00}Max Health:\t\t{FFFFFF}%.2f\n{FFFF00}Mass:\t\t\t{FFFFFF}%.2f\n\n{FFFF00}Engine Drive:\t\t{FFFFFF}%s\n{FFFF00}Consumption:\t\t{FFFFFF}%s\n{FFFF00}Fuel Capacity:\t\t{FFFFFF}%.2f\n",
	FormatNumber(price), GetVehicleModelInfoAsFloat(model, "TransmissionData_fMaxVelocity"), VehicleData[model - 400][c_maxhp], GetVehicleModelInfoAsFloat(model, "fMass"), GetEngineDrive(model), GetVehicleConsumption(model), GetVehicleDataFuel(model));

	if(VDealerLock[playerid])
	{
	    new id = VDealerLock[playerid]-1;
		format(string2, sizeof(string2), "%s\n{FFFF00}Lock:\t\t{B4B5B7} level %d\t{FFFFFF}%s", string2,
		VDealerLock[playerid] + 1, FormatNumber(floatround(VDealerPrice[playerid] / VehicleUpgradeLock[id][u_rate]) + VehicleUpgradeLock[id][u_price]));

		switch(VDealerLock[playerid])
		{
		    case 1:
			{
		        format(string2, sizeof(string2), "%s\n\t{33AA33}+{FFFFFF}500 second wait time protection against\n\tprying break-in method.\n\t{33AA33}+{FFFFFF}Stronger armor- better defense against\n\tphysical attack breaching. -Fist & melee", string2);
		    }
		    case 2:
			{
		        format(string2, sizeof(string2), "%s\n\t{33AA33}+{FFFFFF}750 second wait time protection against\n\tprying break-in method.\n\t{33AA33}+{FFFFFF}Special armor- better defense x2 against\n\tmelee attack breaching.", string2);
		    }
		    case 3:
			{
		        format(string2, sizeof(string2), "%s\n\t{33AA33}+{FFFFFF}750 second wait time protection against\n\tprying break-in method.\n\t{33AA33}+{FFFFFF}Special armor- better defense x2 against\n\tmelee attack breaching.\n\t{33AA33}+{FFFFFF}Special armor protection blocks physical\n\tattack breaching. -Fist", string2);
		    }
		    case 4:
			{
		        format(string2, sizeof(string2), "%s\n\t{33AA33}+{FFFFFF}1,250 second wait time protection against\n\tprying break-in method.\n\t{33AA33}+{FFFFFF}Special armor protection blocks all types\n\tof physical attack breaching.", string2);
		    }
		}
	}
	if(VDealerAlarm[playerid])
	{
	    new id = VDealerAlarm[playerid]-1;
		format(string2, sizeof(string2), "%s\n{FFFF00}Alarm:\t\t{B4B5B7} level %d\t{FFFFFF}%s", string2,
		VDealerAlarm[playerid], FormatNumber(floatround(VDealerPrice[playerid] / VehicleUpgradeAlarm[id][u_rate]) + VehicleUpgradeAlarm[id][u_price]));

		switch(VDealerAlarm[playerid])
		{
		    case 1:
			{
		        format(string2, sizeof(string2), "%s\n\t{FF6347}+{FFFFFF}Loud Vehicle Alarm", string2);
		    }
		    case 2:
			{
		        format(string2, sizeof(string2), "%s\n\t{FF6347}+{FFFFFF}Loud Vehicle Alarm\n\t{FF6347}+{FFFFFF}Vehicle alerts the owner of a possible breach.", string2);
		    }
		    case 3:
			{
		        format(string2, sizeof(string2), "%s\n\t{FF6347}+{FFFFFF}Loud Vehicle Alarm\n\t{FF6347}+{FFFFFF}Vehicle alerts the owner of a possible breach.\n\t{FF6347}+{FFFFFF}Vehicle alerts the local police department of a\n\tpossible breach.", string2);
		    }
		    case 4:
			{
		        format(string2, sizeof(string2), "%s\n\t{FF6347}+{FFFFFF}Loud Vehicle Alarm\n\t{FF6347}+{FFFFFF}Vehicle alerts the owner of a possible breach.\n\t{FF6347}+{FFFFFF}Vehicle alerts the local police department of a\n\tpossible breach.\n\t{FF6347}+{FFFFFF}Vehicle blip will appear on the law enforcement's\n\tradar", string2);
		    }
		}
	}

	if(VDealerImmob[playerid])
	{
	    new id = VDealerImmob[playerid]-1;
		format(string2, sizeof(string2), "%s\n{FFFF00}Immobiliser:\t{B4B5B7} level %d\t{FFFFFF}%s", string2,
		VDealerImmob[playerid], FormatNumber(floatround(VDealerPrice[playerid] / VehicleUpgradeImmob[id][u_rate]) + VehicleUpgradeImmob[id][u_price]));

		format(string2, sizeof(string2), "%s\n\t{FFFF00}+{FFFFFF}The engine immobiliser will help prevent\n\tyour vehicle from running without an\n\tauthorized key.", string2);
	}

	if(VDealerXM[playerid]) format(string2, sizeof(string2), "%s\n{FFFF00}XM Radio:\t\t{FFFFFF}$7,500", string2);

	Dialog_Show(playerid, Dealercar, DIALOG_STYLE_MSGBOX, string, string2, "Edit", "Checkout");
	return true;
}

Dialog:Dealercar(playerid, response, listitem, inputtext[])
{
    new string[64], model = GetVehicleModel(VDealerVehicle[playerid]);

	if(!response)
	{
		format(string, sizeof(string), "%s - %s", g_arrVehicleNames[model - 400], GetDealershipVehiclePrice(playerid));
	    Dialog_Show(playerid, DealercarConfirm, DIALOG_STYLE_MSGBOX, string, "Are you sure you want to buy this vehicle?", "Purchase", "Cancel");
	}
	else
	{
		format(string, sizeof(string), "%s - %s", g_arrVehicleNames[model - 400], GetDealershipVehiclePrice(playerid));
	    Dialog_Show(playerid, DealerMenu, DIALOG_STYLE_LIST, string, "Alarm\nLock\nImmobiliser\nColors\n%s", "Append", "<<", (VDealerXM[playerid]) ? ("{F7FE2E}XM-Radio Installed") : ("No XM Installed"));
	}
	return true;
}

Dialog:DealerMenu(playerid, response, listitem, inputtext[])
{
	if(response)
	{
	    switch(listitem)
	    {
	        case 0:
	        {
				//format(string2,sizeof(string2),"%sNone\n%sAlarm Level 1 - $5,000\n%sAlarm Level 2 - $7,000\n%sAlarm Level 3 - $10,000\n%sAlarm Level 4 - $12,000");
				Dialog_Show(playerid, CarDealerAlarm, DIALOG_STYLE_LIST, "Alarm", "%sNone\n%sAlarm Level 1 - %s\n%sAlarm Level 2 - %s\n%sAlarm Level 3 - %s\n%sAlarm Level 4 - %s", "Modify", "<<",
				(VDealerAlarm[playerid] == 0) ? ("{F7FE2E}>>{FFFFFF}") : (""),
				(VDealerAlarm[playerid] == 1) ? ("{F7FE2E}>>{FFFFFF}") : (""), FormatNumber(floatround(VDealerPrice[playerid] / VehicleUpgradeAlarm[0][u_rate]) + VehicleUpgradeAlarm[0][u_price]),
				(VDealerAlarm[playerid] == 2) ? ("{F7FE2E}>>{FFFFFF}") : (""), FormatNumber(floatround(VDealerPrice[playerid] / VehicleUpgradeAlarm[1][u_rate]) + VehicleUpgradeAlarm[1][u_price]),
				(VDealerAlarm[playerid] == 3) ? ("{F7FE2E}>>{FFFFFF}") : (""), FormatNumber(floatround(VDealerPrice[playerid] / VehicleUpgradeAlarm[2][u_rate]) + VehicleUpgradeAlarm[2][u_price]),
				(VDealerAlarm[playerid] == 4) ? ("{F7FE2E}>>{FFFFFF}") : (""), FormatNumber(floatround(VDealerPrice[playerid] / VehicleUpgradeAlarm[3][u_rate]) + VehicleUpgradeAlarm[3][u_price]));
	        }
	        case 1:
	        {
				//format(string2,sizeof(string2),"%sLock Level - 1 $0\n%sLock Level 2 - $5,000\n%sLock Level 3 - $7,000\n%sLevel - 4 $10,000\n%sLevel - 5 $12,000");
				Dialog_Show(playerid, CarDealerLock, DIALOG_STYLE_LIST, "Lock", "%sLock Level 1 - $0\n%sLock Level 2 - %s\n%sLock Level 3 - %s\n%sLevel 4 - %s\n%sLevel 5 - %s", "Modify", "<<",
				(VDealerLock[playerid] == 0) ? ("{F7FE2E}>>{FFFFFF}") : (""),
				(VDealerLock[playerid] == 1) ? ("{F7FE2E}>>{FFFFFF}") : (""), FormatNumber(floatround(VDealerPrice[playerid] / VehicleUpgradeLock[0][u_rate]) + VehicleUpgradeLock[0][u_price]),
				(VDealerLock[playerid] == 2) ? ("{F7FE2E}>>{FFFFFF}") : (""), FormatNumber(floatround(VDealerPrice[playerid] / VehicleUpgradeLock[1][u_rate]) + VehicleUpgradeLock[1][u_price]),
				(VDealerLock[playerid] == 3) ? ("{F7FE2E}>>{FFFFFF}") : (""), FormatNumber(floatround(VDealerPrice[playerid] / VehicleUpgradeLock[2][u_rate]) + VehicleUpgradeLock[2][u_price]),
				(VDealerLock[playerid] == 4) ? ("{F7FE2E}>>{FFFFFF}") : (""), FormatNumber(floatround(VDealerPrice[playerid] / VehicleUpgradeLock[3][u_rate]) + VehicleUpgradeLock[3][u_price]));
	        }
 	        case 2:
	        {
 				//format(string2,sizeof(string2),"%sNone\n%sImmobiliser Level 1 - $5,000\n%sImmobiliser Level 2 - $10,000\n%sImmobiliser Level 3 - $15,000\n%sImmobiliser Level 4 - $20,000");
				Dialog_Show(playerid, CarDealerImmob, DIALOG_STYLE_LIST, "Immobiliser", "%sNone\n%sImmobiliser Level 1 - %s\n%sImmobiliser Level 2 - %s\n%sImmobiliser Level 3 - %s\n%sImmobiliser Level 4 - %s", "Modify", "<<",
				(VDealerImmob[playerid] == 0) ? ("{F7FE2E}>>{FFFFFF}") : (""),
				(VDealerImmob[playerid] == 1) ? ("{F7FE2E}>>{FFFFFF}") : (""), FormatNumber(floatround(VDealerPrice[playerid] / VehicleUpgradeImmob[0][u_rate]) + VehicleUpgradeImmob[0][u_price]),
				(VDealerImmob[playerid] == 2) ? ("{F7FE2E}>>{FFFFFF}") : (""), FormatNumber(floatround(VDealerPrice[playerid] / VehicleUpgradeImmob[1][u_rate]) + VehicleUpgradeImmob[1][u_price]),
				(VDealerImmob[playerid] == 3) ? ("{F7FE2E}>>{FFFFFF}") : (""), FormatNumber(floatround(VDealerPrice[playerid] / VehicleUpgradeImmob[2][u_rate]) + VehicleUpgradeImmob[2][u_price]),
				(VDealerImmob[playerid] == 4) ? ("{F7FE2E}>>{FFFFFF}") : (""), FormatNumber(floatround(VDealerPrice[playerid] / VehicleUpgradeImmob[3][u_rate]) + VehicleUpgradeImmob[3][u_price]));
	        }
	        case 3:
	        {
	            ColorSelect[playerid] = -1;
	            ColorSelect2[playerid] = -1;

	            ShowPlayerColorSelection(playerid, 1);
	            ShowPlayerColorSelection2(playerid, 1);
	        }
	        case 4:
	        {
			    new string[64], model = GetVehicleModel(VDealerVehicle[playerid]);
				format(string, sizeof(string), "%s - %s", g_arrVehicleNames[model - 400], GetDealershipVehiclePrice(playerid));

				if(VDealerXM[playerid]) VDealerXM[playerid] = 0;
				else VDealerXM[playerid] = 1;

			    Dialog_Show(playerid, DealerMenu, DIALOG_STYLE_LIST, string, "Alarm\nLock\nImmobiliser\nColors\n%s", "Append", "<<", (VDealerXM[playerid]) ? ("{F7FE2E}XM-Radio Installed") : ("No XM Installed"));
	        }
	    }
	}
	else ShowPlayerDealercarDialog(playerid);

	return true;
}

Dialog:CarDealerLock(playerid, response, listitem, inputtext[])
{
	if(response)
	{
	    VDealerLock[playerid] = listitem;
		Dialog_Show(playerid, CarDealerLock, DIALOG_STYLE_LIST, "Lock", "%sLock Level 1 - $0\n%sLock Level 2 - %s\n%sLock Level 3 - %s\n%sLevel 4 - %s\n%sLevel 5 - %s", "Modify", "<<",
		(VDealerLock[playerid] == 0) ? ("{F7FE2E}>>{FFFFFF}") : (""),
		(VDealerLock[playerid] == 1) ? ("{F7FE2E}>>{FFFFFF}") : (""), FormatNumber(floatround(VDealerPrice[playerid] / VehicleUpgradeLock[0][u_rate]) + VehicleUpgradeLock[0][u_price]),
		(VDealerLock[playerid] == 2) ? ("{F7FE2E}>>{FFFFFF}") : (""), FormatNumber(floatround(VDealerPrice[playerid] / VehicleUpgradeLock[1][u_rate]) + VehicleUpgradeLock[1][u_price]),
		(VDealerLock[playerid] == 3) ? ("{F7FE2E}>>{FFFFFF}") : (""), FormatNumber(floatround(VDealerPrice[playerid] / VehicleUpgradeLock[2][u_rate]) + VehicleUpgradeLock[2][u_price]),
		(VDealerLock[playerid] == 4) ? ("{F7FE2E}>>{FFFFFF}") : (""), FormatNumber(floatround(VDealerPrice[playerid] / VehicleUpgradeLock[3][u_rate]) + VehicleUpgradeLock[3][u_price]));
	}
	else
	{
	    new string[64], model = GetVehicleModel(VDealerVehicle[playerid]);
		format(string, sizeof(string), "%s - %s", g_arrVehicleNames[model - 400], GetDealershipVehiclePrice(playerid));
	    Dialog_Show(playerid, DealerMenu, DIALOG_STYLE_LIST, string, "Alarm\nLock\nImmobiliser\nColors\n%s", "Append", "<<", (VDealerXM[playerid]) ? ("{F7FE2E}XM-Radio Installed") : ("No XM Installed"));
	}
	return true;
}

Dialog:CarDealerImmob(playerid, response, listitem, inputtext[])
{
	if(response)
	{
	    VDealerImmob[playerid] = listitem;
		Dialog_Show(playerid, CarDealerImmob, DIALOG_STYLE_LIST, "Immobiliser", "%sNone\n%sImmobiliser Level 1 - %s\n%sImmobiliser Level 2 - %s\n%sImmobiliser Level 3 - %s\n%sImmobiliser Level 4 - %s", "Modify", "<<",
		(VDealerImmob[playerid] == 0) ? ("{F7FE2E}>>{FFFFFF}") : (""),
		(VDealerImmob[playerid] == 1) ? ("{F7FE2E}>>{FFFFFF}") : (""), FormatNumber(floatround(VDealerPrice[playerid] / VehicleUpgradeImmob[0][u_rate]) + VehicleUpgradeImmob[0][u_price]),
		(VDealerImmob[playerid] == 2) ? ("{F7FE2E}>>{FFFFFF}") : (""), FormatNumber(floatround(VDealerPrice[playerid] / VehicleUpgradeImmob[1][u_rate]) + VehicleUpgradeImmob[1][u_price]),
		(VDealerImmob[playerid] == 3) ? ("{F7FE2E}>>{FFFFFF}") : (""), FormatNumber(floatround(VDealerPrice[playerid] / VehicleUpgradeImmob[2][u_rate]) + VehicleUpgradeImmob[2][u_price]),
		(VDealerImmob[playerid] == 4) ? ("{F7FE2E}>>{FFFFFF}") : (""), FormatNumber(floatround(VDealerPrice[playerid] / VehicleUpgradeImmob[3][u_rate]) + VehicleUpgradeImmob[3][u_price]));
	}
	else
	{
	    new string[64], model = GetVehicleModel(VDealerVehicle[playerid]);
		format(string, sizeof(string), "%s - %s", g_arrVehicleNames[model - 400], GetDealershipVehiclePrice(playerid));
	    Dialog_Show(playerid, DealerMenu, DIALOG_STYLE_LIST, string, "Alarm\nLock\nImmobiliser\nColors\n%s", "Append", "<<", (VDealerXM[playerid]) ? ("{F7FE2E}XM-Radio Installed") : ("No XM Installed"));
	}
}

Dialog:CarDealerAlarm(playerid, response, listitem, inputtext[])
{
	if(response)
	{
	    VDealerAlarm[playerid] = listitem;
		Dialog_Show(playerid, CarDealerAlarm, DIALOG_STYLE_LIST, "Alarm", "%sNone\n%sAlarm Level 1 - %s\n%sAlarm Level 2 - %s\n%sAlarm Level 3 - %s\n%sAlarm Level 4 - %s", "Modify", "<<",
		(VDealerAlarm[playerid] == 0) ? ("{F7FE2E}>>{FFFFFF}") : (""),
		(VDealerAlarm[playerid] == 1) ? ("{F7FE2E}>>{FFFFFF}") : (""), FormatNumber(floatround(VDealerPrice[playerid] / VehicleUpgradeAlarm[0][u_rate]) + VehicleUpgradeAlarm[0][u_price]),
		(VDealerAlarm[playerid] == 2) ? ("{F7FE2E}>>{FFFFFF}") : (""), FormatNumber(floatround(VDealerPrice[playerid] / VehicleUpgradeAlarm[1][u_rate]) + VehicleUpgradeAlarm[1][u_price]),
		(VDealerAlarm[playerid] == 3) ? ("{F7FE2E}>>{FFFFFF}") : (""), FormatNumber(floatround(VDealerPrice[playerid] / VehicleUpgradeAlarm[2][u_rate]) + VehicleUpgradeAlarm[2][u_price]),
		(VDealerAlarm[playerid] == 4) ? ("{F7FE2E}>>{FFFFFF}") : (""), FormatNumber(floatround(VDealerPrice[playerid] / VehicleUpgradeAlarm[3][u_rate]) + VehicleUpgradeAlarm[3][u_price]));
	}
	else
	{
	    new string[64], model = GetVehicleModel(VDealerVehicle[playerid]);
		format(string, sizeof(string), "%s - %s", g_arrVehicleNames[model - 400], GetDealershipVehiclePrice(playerid));
	    Dialog_Show(playerid, DealerMenu, DIALOG_STYLE_LIST, string, "Alarm\nLock\nImmobiliser\nColors\n%s", "Append", "<<", (VDealerXM[playerid]) ? ("{F7FE2E}XM-Radio Installed") : ("No XM Installed"));
	}
	return true;
}

Dialog:DealercarConfirm(playerid, response, listitem, inputtext[])
{
	if(response)
	{
	    new
	        vehicleid = VDealerVehicle[playerid],
			bizid = VDealerBiz[playerid],
			model = GetVehicleModel(vehicleid),
			price = GetDealershipCountPrice(playerid),
			string[256]
		;

		if(price <= 0)
		{
		    ExitSettingVehicle(playerid);
		    SendClientMessage(playerid, COLOR_LIGHTRED, "There was an error while trying to purchase the vehicle, contact an administrator..");
		    return true;
		}

		if(bizid != -1 && BusinessData[bizid][bType] == 4)
		{
			if(PlayerData[playerid][pCash] < price)
			{
				SendClientMessage(playerid, COLOR_LIGHTRED, "You don't have enough money to buy this vehicle.");
				ShowPlayerDealercarDialog(playerid);
				return true;
			}

			if(CountPlayerVehicles(playerid) >= 12)
		 	{
		 		SendClientMessage(playerid, COLOR_LIGHTRED, "You have the maximum number of vehicles owned.");
		 		ExitSettingVehicle(playerid);
		 		return true;
			}

		    if(CountVehicleKeys(playerid) >= MaxVehiclesSpawned(playerid))
		    {
				SendServerMessage(playerid, "You already have your max amount of private vehicles spawned.");
              	ExitSettingVehicle(playerid);
                return true;
			}

			new i = Iter_Free(sv_playercar);

			if(i != -1)
			{
				new
				    Float:pos[4]
				;

				GetVehiclePos(vehicleid, pos[0], pos[1], pos[2]);
				GetVehicleZAngle(vehicleid, pos[3]);

		        CarData[i][carPos][0] = pos[0];
		        CarData[i][carPos][1] = pos[1];
		        CarData[i][carPos][2] = pos[2];
		        CarData[i][carPos][3] = pos[3];

	            CarData[i][carLock] = VDealerLock[playerid];
				CarData[i][carAlarm] = VDealerAlarm[playerid];
				CarData[i][carImmob] = VDealerImmob[playerid];
				CarData[i][carXM] = VDealerXM[playerid];
				CarData[i][carOwner] = PlayerData[playerid][pID];
				CarData[i][carModel] = model;
				CarData[i][carBatteryL] = VehicleData[model - 400][c_battery];
				CarData[i][carEngineL] = VehicleData[model - 400][c_engine];

				CoreVehicles[vehicleid][vehFuel] = GetVehicleDataFuel(model);
                CarData[i][carFuel] = CoreVehicles[vehicleid][vehFuel];
                CarData[i][carHealth] = VehicleData[model - 400][c_maxhp];

                CarData[i][carDupKey] = randomEx(1234567, 9999999);
                CarData[i][carColor1] = VDealerColor[playerid][0];
                CarData[i][carColor2] = VDealerColor[playerid][1];
                CarData[i][carPaintjob] = 3;
                CarData[i][carLocked] = 1;

                for(new m = 0; m < 14; ++m) CarData[i][carMods][m] = 0;

				format(string, sizeof(string), "INSERT INTO `cars` (`carModel`, `carOwner`, `carColor1`, `carColor2`, `carPaintjob`, `carLock`, `carImmob`, `carAlarm`, `carXM`, `carDate`) VALUES (%d, %d, %d, %d, %d, %d, %d, %d, %d, %d)",
		            model,
				    PlayerData[playerid][pID],
				    VDealerColor[playerid][0],
				    VDealerColor[playerid][1],
				    CarData[i][carPaintjob],
					VDealerLock[playerid],
					VDealerImmob[playerid],
					VDealerAlarm[playerid],
					VDealerXM[playerid],
					gettime()
				);

				mysql_tquery(dbCon, string, "OnQueryBuyVehicle", "iddd", playerid, i, model, price);
			}
		}
	}
	else
	{
		ExitSettingVehicle(playerid);
	}
	return true;
}

stock CreatePlayerVehicle(playerid, target, model, color1, color2, lock, immob, alarm, xm)
{
    new carid = Iter_Free(sv_playercar);
    
    if(carid == -1)
        return SendErrorMessage(playerid, "There was an error creating the vehicle, contact a developer.");
        
    new Float:playerPos[4], largeQuery[256];
        
	GetPlayerPos(playerid, playerPos[0], playerPos[1], playerPos[2]);
	GetPlayerFacingAngle(playerid, playerPos[3]);

	CarData[carid][carPos][0] = playerPos[0] + 3;
	CarData[carid][carPos][1] = playerPos[1];
	CarData[carid][carPos][2] = playerPos[2];
	CarData[carid][carPos][3] = playerPos[3];
	CarData[carid][carLock] = lock;
	CarData[carid][carAlarm] = alarm;
	CarData[carid][carImmob] = immob;
	CarData[carid][carXM] = xm;
	CarData[carid][carOwner] = PlayerData[target][pID];
	CarData[carid][carModel] = model;
	CarData[carid][carBatteryL] = VehicleData[model - 400][c_battery];
	CarData[carid][carEngineL] = VehicleData[model - 400][c_engine];
	CarData[carid][carFuel] = GetVehicleDataFuel(model);
	CarData[carid][carHealth] = VehicleData[model - 400][c_maxhp];
	CarData[carid][carDupKey] = randomEx(1234567, 9999999);
	CarData[carid][carColor1] = color1;
	CarData[carid][carColor2] = color2;
	CarData[carid][carPaintjob] = 3;
	CarData[carid][carLocked] = 1;

	for(new m = 0; m < 14; ++m) CarData[carid][carMods][m] = 0;

	mysql_format(dbCon, largeQuery, sizeof(largeQuery), "INSERT INTO `cars` (`carModel`, `carOwner`, `carColor1`, `carColor2`, `carLock`, `carImmob`, `carAlarm`, `carXM`, `carDate`) VALUES (%d, %d, %d, %d, %d, %d, %d, %d, %d)",
		model,
		PlayerData[target][pID],
		color1,
		color2,
		lock,
		immob,
		alarm,
		xm,
		gettime()
	);
	
	return mysql_tquery(dbCon, largeQuery, "OnPlayerVehicleCreate", "iii", playerid, target, carid);
}

forward OnPlayerVehicleCreate(playerid, target, carid);
public OnPlayerVehicleCreate(playerid, target, carid)
{
	new insert_id = cache_insert_id(), str[128];
	
	if(insert_id == -1)
		return SendErrorMessage(playerid, "There was an error creating the vehicle, contact a developer.");

	CarData[carid][carID] = cache_insert_id();

	GiveVehicleKey(target, carid);

	new plate[8];
	format(plate, 8, "%s", RandomVehiclePlate());
	mysql_format(dbCon, str, sizeof(str),"SELECT * FROM `cars` WHERE `carPlate` = '%s'", plate);
	mysql_tquery(dbCon, str, "DuplicatePlates", "iis", target, carid, plate);
	mysql_tquery(dbCon, "SELECT `carPosX`, `carPosY`, `carPosZ` FROM `cars`", "RandomVehiclePark", "d", carid);
	return true;
}

forward OnQueryBuyVehicle(playerid, carid, model, price);
public OnQueryBuyVehicle(playerid, carid, model, price)
{
	new insert_id = cache_insert_id(), str[128];

	if(insert_id == -1)
	{
	    ExitSettingVehicle(playerid);
	    return SendClientMessage(playerid, COLOR_LIGHTRED, "There was an error buying the vehicle, please contact an administrator.");
	}

	CarData[carid][carID] = cache_insert_id();
	GiveVehicleKey(playerid, carid);

	SendClientMessage(playerid, 0xADFF2FFF, "PROCESSING:Rebuilding your /v list...");
	SendClientMessageEx(playerid, COLOR_WHITE, "Welcome to your %s", g_arrVehicleNames[model - 400]);
	SendClientMessageEx(playerid, COLOR_CYAN, "Lock[%d], Alarm[%d], Immob[%d], Insurance[%d]", CarData[carid][carLock], CarData[carid][carAlarm], CarData[carid][carImmob], CarData[carid][carInsurance]);
	SendClientMessageEx(playerid, COLOR_CYAN, "Life Span: Engine Life[%.2f], Battery Life[%.2f], Miles Driven[%.2f]", CarData[carid][carEngineL], CarData[carid][carBatteryL], CarData[carid][carMileage]);

	TakePlayerMoney(playerid, price);
	ExitSettingVehicle(playerid);
	TogglePlayerControllable(playerid, true);
	SetCameraBehindPlayer(playerid);

	new plate[8];
	format(plate, 8, "%s", RandomVehiclePlate());
	mysql_format(dbCon, str, sizeof(str),"SELECT * FROM `cars` WHERE `carPlate` = '%s'", plate);
	mysql_tquery(dbCon, str, "DuplicatePlates", "iis", playerid, carid, plate);
	mysql_tquery(dbCon, "SELECT `carPosX`, `carPosY`, `carPosZ` FROM `cars`", "RandomVehiclePark", "d", carid);
	return true;
}

forward RegisterPlates(playerid, id, plate[]);
public RegisterPlates(playerid, id, plate[])
{
    new str[128];

    if(cache_num_rows())
    {
		new newplate[8];
		format(newplate, 8, "%s", RandomVehiclePlate());

      	mysql_format(dbCon, str,sizeof(str),"SELECT * FROM `cars` WHERE `carPlate` = '%s'", newplate);
		mysql_tquery(dbCon, str, "RegisterPlates", "iis", playerid, id, newplate);
    }
    else
	{
		new Float: vehiclePos[4];

		GetVehiclePos(CarData[id][carVehicle], vehiclePos[0], vehiclePos[1], vehiclePos[2]);
		GetVehicleZAngle(CarData[id][carVehicle], vehiclePos[3]);

		format(CarData[id][carPlate], 32, plate);
        SetVehicleNumberPlate(CarData[id][carVehicle], CarData[id][carPlate]);
        SaveVehicleDamage(CarData[id][carVehicle]);
		SetVehicleToRespawn(CarData[id][carVehicle]);
		SetVehicleDamage(CarData[id][carVehicle]);
		SetVehiclePos(CarData[id][carVehicle], vehiclePos[0], vehiclePos[1], vehiclePos[2]);
		SetVehicleZAngle(CarData[id][carVehicle], vehiclePos[3]);

        if(GetVehicleDriver(CarData[id][carVehicle]) != INVALID_PLAYER_ID) PutPlayerInVehicle(playerid, CarData[id][carVehicle], 0);

        Car_SaveID(id);

		format(str, sizeof(str), "Your new plate has been set~n~~y~%s.", CarData[id][carPlate]);
		ShowPlayerFooter(playerid, str);
	}
    return true;
}

forward DuplicatePlates(playerid, id, plate[]);
public DuplicatePlates(playerid, id, plate[])
{
	new str[128];

    if(cache_num_rows())
    {
		new newplate[8];
		format(newplate, 8, "%s", RandomVehiclePlate());
      	mysql_format(dbCon, str,sizeof(str),"SELECT * FROM `cars` WHERE `carPlate` = '%s'", newplate);
		mysql_tquery(dbCon, str, "DuplicatePlates", "iis", playerid, id, newplate);
    }
    else
	{
		format(CarData[id][carPlate], 32, plate);
		CarData[id][carVehicle] = CreateVehicle(CarData[id][carModel], CarData[id][carPos][0],CarData[id][carPos][1],CarData[id][carPos][2],CarData[id][carPos][3], CarData[id][carColor1], CarData[id][carColor2], -1);
        SetVehicleNumberPlate(CarData[id][carVehicle], CarData[id][carPlate]);
        
		Iter_Add(sv_vehicles, CarData[id][carVehicle]);
		
	  	CoreVehicles[CarData[id][carVehicle]][vehFuel] = CarData[id][carFuel];
	  	CoreVehicles[CarData[id][carVehicle]][vehicleCarID] = id;

		new
			engine,
			lights,
			alarm,
			doors,
			bonnet,
			boot,
			objective;

		GetVehicleParamsEx(CarData[id][carVehicle], engine, lights, alarm, doors, bonnet, boot, objective);
        SetVehicleParamsEx(CarData[id][carVehicle], engine, lights, alarm, CarData[id][carLocked], bonnet, boot, objective);
		SetVehicleHealth(CarData[id][carVehicle], CarData[id][carHealth]);

        Iter_Add(sv_playercar, id);
		PutPlayerInVehicle(playerid, CarData[id][carVehicle], 0);
		
		SendClientMessage(playerid, 0xADFF2FFF, "PROCESSED:List Rebuilt.");

        Car_SaveID(id);

		format(str, sizeof(str), "Your new plate has been set~n~~y~%s.", CarData[id][carPlate]);
		ShowPlayerFooter(playerid, str);
	}
    return true;
}

forward RandomVehiclePark(carid);
public RandomVehiclePark(carid)
{
	new
	    string[256],
		Float:vehDistance[4],
		Float:vehRandom[4],
		bool:checked = false,
		rows = cache_num_rows(),
		rand
	;

	if(CarData[carid][carModel] == 532)
	{
		rand = random(sizeof(gCombineSpawn));

		vehRandom[0] = gCombineSpawn[rand][0];
		vehRandom[1] = gCombineSpawn[rand][1];
		vehRandom[2] = gCombineSpawn[rand][2];
		vehRandom[3] = gCombineSpawn[rand][3];
	}
	else if(IsABoatModel(CarData[carid][carModel]))
	{
		rand = random(sizeof(gBoatSpawn));

		vehRandom[0] = gBoatSpawn[rand][0];
		vehRandom[1] = gBoatSpawn[rand][1];
		vehRandom[2] = gBoatSpawn[rand][2];
		vehRandom[3] = gBoatSpawn[rand][3];
	}
	else
	{
		rand = random(sizeof(gVehicleSpawn));

		vehRandom[0] = gVehicleSpawn[rand][0];
		vehRandom[1] = gVehicleSpawn[rand][1];
		vehRandom[2] = gVehicleSpawn[rand][2];
		vehRandom[3] = gVehicleSpawn[rand][3];
	}

  	if(CarData[carid][carRandomFailed] < 10)
  	{
		for(new i = 0; i < rows; ++i)
		{
			cache_get_value_index_float(i, 0,	vehDistance[0]);
			cache_get_value_index_float(i, 1,	vehDistance[1]);
			cache_get_value_index_float(i, 2,	vehDistance[2]);

			if(TwoPointCompare(4.5, vehRandom[0], vehRandom[1], vehRandom[2], vehDistance[0], vehDistance[1], vehDistance[2]))
			{
				checked = true;
				break;
			}
		}
	}
	else
	{
		if(CarData[carid][carModel] == 532)
		{
		 	for(new x = 0; x < sizeof(gCombineSpawn); ++x)
			{
				vehRandom[0] = gCombineSpawn[rand][0];
				vehRandom[1] = gCombineSpawn[rand][1];
				vehRandom[2] = gCombineSpawn[rand][2];
				vehRandom[3] = gCombineSpawn[rand][3];

				for(new i = 0; i < rows; ++i)
				{
					cache_get_value_index_float(i, 0, vehDistance[0]);
					cache_get_value_index_float(i, 1, vehDistance[1]);
					cache_get_value_index_float(i, 2, vehDistance[2]);

					if(TwoPointCompare(4.5, vehRandom[0], vehRandom[1], vehRandom[2], vehDistance[0], vehDistance[1], vehDistance[2]))
					{
						checked = true;
						break;
					}
				}

				if(!checked) break;
			}

		}
		else if(IsABoatModel(CarData[carid][carModel]))
		{
		 	for(new x = 0; x < sizeof(gBoatSpawn); ++x)
			{
				vehRandom[0] = gBoatSpawn[rand][0];
				vehRandom[1] = gBoatSpawn[rand][1];
				vehRandom[2] = gBoatSpawn[rand][2];
				vehRandom[3] = gBoatSpawn[rand][3];

				for(new i = 0; i < rows; ++i)
				{
					cache_get_value_index_float(i, 0, vehDistance[0]);
					cache_get_value_index_float(i, 1, vehDistance[1]);
					cache_get_value_index_float(i, 2, vehDistance[2]);

					if(TwoPointCompare(4.5, vehRandom[0], vehRandom[1], vehRandom[2], vehDistance[0], vehDistance[1], vehDistance[2]))
					{
						checked = true;
						break;
					}
				}

				if(!checked) break;
			}
		}
		else
		{
		 	for(new x = 0; x < sizeof(gVehicleSpawn); ++x)
			{
				vehRandom[0] = gVehicleSpawn[rand][0];
				vehRandom[1] = gVehicleSpawn[rand][1];
				vehRandom[2] = gVehicleSpawn[rand][2];
				vehRandom[3] = gVehicleSpawn[rand][3];

				for(new i = 0; i < rows; ++i)
				{
					cache_get_value_index_float(i, 0, vehDistance[0]);
					cache_get_value_index_float(i, 1, vehDistance[1]);
					cache_get_value_index_float(i, 2, vehDistance[2]);

					if(TwoPointCompare(4.5, vehRandom[0], vehRandom[1], vehRandom[2], vehDistance[0], vehDistance[1], vehDistance[2]))
					{
						checked = true;
						break;
					}
				}

				if(!checked) break;
			}
		}

		if(checked)
	    {
	        CarData[carid][carRandomFailed] = 0;
			CarData[carid][carPos][0] = vehRandom[0];
			CarData[carid][carPos][1] = vehRandom[1];
			CarData[carid][carPos][2] = vehRandom[2];
			CarData[carid][carPos][3] = vehRandom[3];

			format(string, sizeof(string), "UPDATE `cars` SET `carPosX` = '%.4f', `carPosY` = '%.4f', `carPosZ` = '%.4f', `carPosR` = '%.4f' WHERE `carID` = '%d' LIMIT 1",
		        CarData[carid][carPos][0],
		        CarData[carid][carPos][1],
		        CarData[carid][carPos][2],
		        CarData[carid][carPos][3],
		        CarData[carid][carID]
			);

			return mysql_tquery(dbCon, string);
	    }
	}

	if(!checked)
	{
	    CarData[carid][carRandomFailed] = 0;
		CarData[carid][carPos][0] = vehRandom[0];
		CarData[carid][carPos][1] = vehRandom[1];
		CarData[carid][carPos][2] = vehRandom[2];
		CarData[carid][carPos][3] = vehRandom[3];

		format(string, sizeof(string), "UPDATE `cars` SET `carPosX` = '%.4f', `carPosY` = '%.4f', `carPosZ` = '%.4f', `carPosR` = '%.4f' WHERE `carID` = '%d' LIMIT 1",
	        CarData[carid][carPos][0],
	        CarData[carid][carPos][1],
	        CarData[carid][carPos][2],
	        CarData[carid][carPos][3],
	        CarData[carid][carID]
		);

		return mysql_tquery(dbCon, string);
	}
	else
	{
	    CarData[carid][carRandomFailed]++;

		mysql_tquery(dbCon, "SELECT carPosX, carPosY, carPosZ FROM `cars`", "RandomVehiclePark", "d", carid);
	}
	return true;
}

GetEngineDrive(modelid)
{
	new string[24];

	if(GetVehicleModelInfoAsInt(modelid, "TransmissionData_nDriveType") == 'F')
		format(string, 32, "Front Wheel Drive");
	else if(GetVehicleModelInfoAsInt(modelid, "TransmissionData_nDriveType") == 'R')
		format(string, 32, "Rear Wheel Drive");
	else
		format(string, 24, "Four Wheel Drive");

	return string;
}

GetVehicleConsumption(modelid)
{
	new string[24], Float:consumption = GetVehicleDataFuelRate(modelid);
	format(string, 24, "%d MPG / %d KPL", floatround(consumption * 2.35214583), floatround(consumption));
	return string;
}

GetDealershipVehiclePrice(playerid)
{
	new str[64], price = VDealerPrice[playerid], id;

	if(VDealerLock[playerid])
	{
	    id = VDealerLock[playerid] - 1;
	    price += floatround(VDealerPrice[playerid] / VehicleUpgradeLock[id][u_rate]) + VehicleUpgradeLock[id][u_price];
	}

	if(VDealerImmob[playerid])
	{
	    id = VDealerImmob[playerid] - 1;
	    price += floatround(VDealerPrice[playerid] / VehicleUpgradeImmob[id][u_rate]) + VehicleUpgradeImmob[id][u_price];
	}

	if(VDealerAlarm[playerid])
	{
	    id = VDealerAlarm[playerid] - 1;
	    price += floatround(VDealerPrice[playerid] / VehicleUpgradeAlarm[id][u_rate]) + VehicleUpgradeAlarm[id][u_price];
	}

	if(VDealerXM[playerid]) price += 7500;

    if(PlayerData[playerid][pCash] < price)
	{
        format(str, sizeof(str), "{FF0000}%s", FormatNumber(price));
    }
    else
    {
         format(str, sizeof(str), "{33AA33}%s", FormatNumber(price));
    }

	return str;
}

GetDealershipCountPrice(playerid)
{
	new price = VDealerPrice[playerid], id;

	if(VDealerLock[playerid])
	{
	    id = VDealerLock[playerid] - 1;

	    price += floatround(VDealerPrice[playerid] / VehicleUpgradeLock[id][u_rate]) + VehicleUpgradeLock[id][u_price];
	}

	if(VDealerImmob[playerid])
	{
	    id = VDealerImmob[playerid] - 1;

	    price += floatround(VDealerPrice[playerid] / VehicleUpgradeImmob[id][u_rate]) + VehicleUpgradeImmob[id][u_price];
	}

	if(VDealerAlarm[playerid])
	{
	    id = VDealerAlarm[playerid] - 1;

	    price += floatround(VDealerPrice[playerid] / VehicleUpgradeAlarm[id][u_rate]) + VehicleUpgradeAlarm[id][u_price];
	}

	if(VDealerXM[playerid]) price += 7500;

	return price;
}

RandomVehiclePlate()
{
	const len = 7;

	new plate[len+1];

	for(new i = 0; i < len; ++i)
	{
	    if(i > 0 && i < 4) // letter or number?
	    {
	     	plate[i] = 'A' + random(26);
	    }
	    else // number
	    {
	    	plate[i] = '0' + random(10);
	    }
	}
	return plate;
}

ExitSettingVehicle(playerid)
{
	if(VDealerSetting{playerid})
	{
	    VDealerSetting{playerid} = false;

		if(VDealerVehicle[playerid])
		    DestroyVehicle(VDealerVehicle[playerid]);

        TogglePlayerControllable(playerid, 1);
        VDealerColor[playerid][0] = -1;
        VDealerColor[playerid][1] = -1;
        VDealerBiz[playerid] = -1;

		SetCameraBehindPlayer(playerid);
	}
}

ShowPlayerColorSelection(playerid, page)
{
	new string[64], selecttype, selectstart;

    ColorSelectPage[playerid] = page;

	if(ColorSelect[playerid] >= 0)
	{
        for(new i = 0; i != sizeof(ColorMenuSelect); ++i)
        {
			if(ColorMenuSelect[i][1] == ColorSelect[playerid])
			{
			    if(!selectstart)
			    {
			        selectstart = i + (8 * (page - 1));
			    }
				selecttype++;
			}
		}

		ColorSelectItem[playerid] = selecttype;
		ColorSelectPages[playerid] = floatround(floatdiv(ColorSelectItem[playerid], 8), floatround_ceil);

	}
	else
	{
        selectstart = 8 * (page - 1);

		ColorSelectItem[playerid] = sizeof(ColorMenuInfo);
		ColorSelectPages[playerid] = floatround(floatdiv(ColorSelectItem[playerid], 8), floatround_ceil);
    }

	for(new i = 0 ; i < 8 ; ++i)
	{
		PlayerTextDrawHide(playerid, ColorSelection[playerid][i]);
	}

	PlayerTextDrawHide(playerid, ColorSelectText[playerid]);
	PlayerTextDrawHide(playerid, ColorSelectLeft[playerid]);
	PlayerTextDrawHide(playerid, ColorSelectRight[playerid]);

	new start = (8 * (page-1));

	for(new i = start; i != start + 8 && i < ColorSelectItem[playerid]; ++i)
	{
	    if(ColorSelect[playerid] >= 0)
	    {
			PlayerTextDrawBackgroundColor(playerid, ColorSelection[playerid][i - start], g_arrSelectColors[ColorMenuSelect[selectstart + i - start][0]]);
	    	ColorSelectListener[playerid][i - start] = ColorMenuSelect[selectstart + i - start][0];

	    }
	    else
	    {
			PlayerTextDrawBackgroundColor(playerid, ColorSelection[playerid][i-start], g_arrSelectColors[ColorMenuInfo[selectstart + i - start][0]]);
		    ColorSelectListener[playerid][i - start] = i;

	    }
	    PlayerTextDrawShow(playerid, ColorSelection[playerid][i - start]);
	}

	if(ColorSelect[playerid] >= 0)
	{
		format(string, sizeof(string), "%s (%d/%d)", ColorMenuInfo[ColorSelect[playerid]][1], page, ColorSelectPages[playerid]);
		PlayerTextDrawColor(playerid,ColorSelectText[playerid], g_arrSelectColors[ColorMenuInfo[ColorSelect[playerid]][0]]);
		PlayerTextDrawSetString(playerid, ColorSelectText[playerid], string);
	}
	else
	{
	    PlayerTextDrawColor(playerid,ColorSelectText[playerid], -1);
		PlayerTextDrawSetString(playerid, ColorSelectText[playerid], "Primary Colors");
	}

	PlayerTextDrawShow(playerid, ColorSelectText[playerid]);

	if(page - 1 != 0)
	{
		PlayerTextDrawShow(playerid, ColorSelectLeft[playerid]);
	}
	if(page + 1 <= ColorSelectPages[playerid])
	{
		PlayerTextDrawShow(playerid, ColorSelectRight[playerid]);
	}

	ColorSelectShow{playerid} = true;

	SelectTextDraw(playerid, 0x585858FF);
	return true;
}

ShowPlayerColorSelection2(playerid, page)
{
	new string[64], selecttype, selectstart;

    ColorSelectPage2[playerid] = page;

	if(ColorSelect2[playerid] >= 0)
	{
        for(new i = 0; i != sizeof(ColorMenuSelect); ++i)
        {
			if(ColorMenuSelect[i][1] == ColorSelect2[playerid])
			{
			    if(!selectstart)
			    {
			        selectstart = i + (8 * (page-1));
			    }
				selecttype++;
			}
		}

		ColorSelectItem2[playerid] = selecttype;
		ColorSelectPages2[playerid] = floatround(floatdiv(ColorSelectItem2[playerid], 8), floatround_ceil);

	}
	else
	{
        selectstart = 8 * (page-1);
		ColorSelectItem2[playerid] = sizeof(ColorMenuInfo);
		ColorSelectPages2[playerid] = floatround(floatdiv(ColorSelectItem2[playerid], 8), floatround_ceil);
    }

	for(new i = 0 ; i < 8 ; ++i)
	{
		PlayerTextDrawHide(playerid, ColorSelection2[playerid][i]);
	}

	PlayerTextDrawHide(playerid, ColorSelectText2[playerid]);
	PlayerTextDrawHide(playerid, ColorSelectLeft2[playerid]);
	PlayerTextDrawHide(playerid, ColorSelectRight2[playerid]);

	new start = (8 * (page-1));

	for(new i = start; i != start + 8 && i < ColorSelectItem2[playerid]; ++i)
	{
	    if(ColorSelect2[playerid] >= 0)
	    {
			PlayerTextDrawBackgroundColor(playerid, ColorSelection2[playerid][i-start], g_arrSelectColors[ColorMenuSelect[selectstart+i-start][0]]);
	    	ColorSelectListener2[playerid][i-start] = ColorMenuSelect[selectstart+i-start][0];

	    }
	    else
	    {
			PlayerTextDrawBackgroundColor(playerid, ColorSelection2[playerid][i-start], g_arrSelectColors[ColorMenuInfo[selectstart+i-start][0]]);
		    ColorSelectListener2[playerid][i-start] = i;

	    }
	    PlayerTextDrawShow(playerid, ColorSelection2[playerid][i-start]);
	}

	if(ColorSelect2[playerid] >= 0)
	{
		format(string, sizeof(string), "%s (%d/%d)", ColorMenuInfo[ColorSelect2[playerid]][1], page, ColorSelectPages2[playerid]);
		PlayerTextDrawColor(playerid,ColorSelectText2[playerid], g_arrSelectColors[ColorMenuInfo[ColorSelect2[playerid]][0]]);
		PlayerTextDrawSetString(playerid, ColorSelectText2[playerid], string);
	}
	else
	{
	    PlayerTextDrawColor(playerid,ColorSelectText2[playerid], -1);
		PlayerTextDrawSetString(playerid, ColorSelectText2[playerid], "Secondary Colors");
	}

	PlayerTextDrawShow(playerid, ColorSelectText2[playerid]);

	if(page-1 != 0)
	{
		PlayerTextDrawShow(playerid, ColorSelectLeft2[playerid]);
	}
	if(page+1 <= ColorSelectPages2[playerid])
	{
		PlayerTextDrawShow(playerid, ColorSelectRight2[playerid]);
	}

	ColorSelectShow2{playerid} = true;

	SelectTextDraw(playerid, 0x585858FF);
	return true;
}

ClearColorSelect(playerid)
{
	if(ColorSelectShow{playerid} || ColorSelectShow2{playerid})
	{
		for(new i = 0; i < 8 ; ++i)
		{
			PlayerTextDrawHide(playerid, ColorSelection[playerid][i]);
			PlayerTextDrawHide(playerid, ColorSelection2[playerid][i]);
		}

		PlayerTextDrawHide(playerid, ColorSelectText[playerid]);
		PlayerTextDrawHide(playerid, ColorSelectLeft[playerid]);
		PlayerTextDrawHide(playerid, ColorSelectRight[playerid]);
		PlayerTextDrawHide(playerid, ColorSelectText2[playerid]);
		PlayerTextDrawHide(playerid, ColorSelectLeft2[playerid]);
		PlayerTextDrawHide(playerid, ColorSelectRight2[playerid]);

		ColorSelectPage[playerid] = 1;
		ColorSelectPage2[playerid] = 1;

		ColorSelect[playerid] = -1;
		ColorSelect2[playerid] = -1;

		ColorSelectShow{playerid} = false;
		ColorSelectShow2{playerid} = false;

		if(VDealerSetting{playerid})
		{
		    ShowPlayerDealercarDialog(playerid);
		}
	}
	return true;
}

SetVehicleColor(vehicleid, color1, color2)
{
    new id = Car_GetID(vehicleid);

	if(id != -1)
	{
	    CarData[id][carColor1] = color1;
	    CarData[id][carColor2] = color2;
	}
	return ChangeVehicleColor(vehicleid, color1, color2);
}

PlayerOwnsVehicle(playerid, vehicleid)
{
	new id;

    if((id = Car_GetID(vehicleid)) != -1)
    {
        if(HasVehicleKey(playerid, id))
		{
		    return true;
		}

		return false;
	}

	return false;
}

Car_Nearest(playerid)
{
	new
	    Float:fDistance[2] = {99999.0, 0.0},
	    Float:fX,
	    Float:fY,
	    Float:fZ,
	    iIndex = -1
	;

	foreach (new i : StreamedVehicle[playerid])
	{
	    GetVehiclePos(i, fX, fY, fZ);

	    fDistance[1] = GetPlayerDistanceFromPoint(playerid, fX, fY, fZ);

		if(fDistance[1] < fDistance[0] && fDistance[1] < 6.0)
		{
		    fDistance[0] = fDistance[1];
		    iIndex = i;
		}
	}

	return iIndex;
}

Car_GetID(vehicleid)
{
	if(vehicleid == -1 || vehicleid == INVALID_VEHICLE_ID) return -1;

	//if(!IsValidVehicle(vehicleid)) return -1;

	if(CoreVehicles[vehicleid][vehicleCarID] != -1)
	{
	    return CoreVehicles[vehicleid][vehicleCarID];
	}

	foreach (new i : sv_playercar)
	{
		if(CarData[i][carVehicle] == vehicleid)
		{
			return i;
		}
	}

	return -1;
}

SetSlotVehicleDamage(slot)
{
    SetVehicleDamageStatus(CarData[slot][carVehicle],CarData[slot][carDamage][0],CarData[slot][carDamage][1],CarData[slot][carDamage][2],CarData[slot][carDamage][3]);
	//UpdateVehicleDamageStatus(CarData[slot][carVehicle],CarData[slot][carDamage][0],CarData[slot][carDamage][1],CarData[slot][carDamage][2],CarData[slot][carDamage][3]);
	if(CarData[slot][carHealth] > 249) SetVehicleHealth(CarData[slot][carVehicle],CarData[slot][carHealth]);
	else SetVehicleHealth(CarData[slot][carVehicle],250);
}

SetVehicleDamage(vehicleid)
{
	new slot = -1;

	if((slot = Car_GetID(vehicleid)) != -1)
	{
	    SetVehicleDamageStatus(CarData[slot][carVehicle],CarData[slot][carDamage][0],CarData[slot][carDamage][1],CarData[slot][carDamage][2],CarData[slot][carDamage][3]);
		//UpdateVehicleDamageStatus(CarData[slot][carVehicle],CarData[slot][carDamage][0],CarData[slot][carDamage][1],CarData[slot][carDamage][2],CarData[slot][carDamage][3]);
		if(CarData[slot][carHealth] > 249) SetVehicleHealth(CarData[slot][carVehicle],CarData[slot][carHealth]);
		else SetVehicleHealth(CarData[slot][carVehicle],250);
	}
}

RenderPlayerCarMenu(playerid, page, caramount, const data[][], const header[] = "", dealership = 0)
{
	new count = 0, str[32];

	new Float:sX = 118, Float:sY = 118;
	new Float:nX = 183, Float:nY = 228;
	new Float:pX = 131, Float:pY = 141;

	for(new i = 0; i < 6; ++i)
	{
		if(data[i][0] != 0)
		{
			PCARTextSlot[playerid][i] = CreatePlayerTextDraw(playerid, sX, sY, "_");

			if(!dealership) PlayerTextDrawBackgroundColor(playerid, PCARTextSlot[playerid][i], data[i][3] ? 0x7A936AAA : 0xBDBDBDAA);
			else PlayerTextDrawBackgroundColor(playerid, PCARTextSlot[playerid][i], data[i][3] ? 0x7A936A60 : 0x92698160);

			PlayerTextDrawFont(playerid,PCARTextSlot[playerid][i], 5);
			PlayerTextDrawLetterSize(playerid,PCARTextSlot[playerid][i], 0.710000, 7.500000);
			PlayerTextDrawColor(playerid,PCARTextSlot[playerid][i], -1);
			PlayerTextDrawSetOutline(playerid,PCARTextSlot[playerid][i], 0);
			PlayerTextDrawSetProportional(playerid,PCARTextSlot[playerid][i], 1);
			PlayerTextDrawSetShadow(playerid,PCARTextSlot[playerid][i], 1);
			PlayerTextDrawUseBox(playerid,PCARTextSlot[playerid][i], 1);
			PlayerTextDrawBoxColor(playerid,PCARTextSlot[playerid][i], -491797408);
			PlayerTextDrawTextSize(playerid,PCARTextSlot[playerid][i], 130.000000, 130.000000);
			PlayerTextDrawSetPreviewRot(playerid, PCARTextSlot[playerid][i], -16.000000, 0.000000, -55.000000, 0.850000);
			PlayerTextDrawSetPreviewModel(playerid, PCARTextSlot[playerid][i], data[i][0]);
			PlayerTextDrawSetPreviewVehCol(playerid, PCARTextSlot[playerid][i], data[i][1], data[i][2]);
			PlayerTextDrawSetSelectable(playerid,PCARTextSlot[playerid][i], 1);
			PlayerTextDrawShow(playerid, PCARTextSlot[playerid][i]);

			if(dealership && VDealerSelectCatalog[playerid] == -1)
			{
				for(new x = 0; x != sizeof(VehicleMenuInfo); ++x)
				{
				    if(VehicleMenuInfo[x][0] == data[i][0])
				    {
				        PCARTextName[playerid][i] = CreatePlayerTextDraw(playerid, nX, nY, VehicleMenuInfo[x][1]);
						break;
				    }
				}
			}
			else
			{
			    if(strlen(CarNames[playerid][i]) >= 3 && !PCarType[playerid])
				{
				    if(strlen(CarNames[playerid][i]) > 14) format(CarNames[playerid][i], 64, "%.14s", CarNames[playerid][i]);

					PCARTextName[playerid][i] = CreatePlayerTextDraw(playerid, nX, nY, CarNames[playerid][i]);
				}
				else PCARTextName[playerid][i] = CreatePlayerTextDraw(playerid, nX, nY, ReturnVehicleModelNameEx(data[i][0]));
			}

			PlayerTextDrawAlignment(playerid,PCARTextName[playerid][i], 2);
			PlayerTextDrawBackgroundColor(playerid,PCARTextName[playerid][i], 255);
			PlayerTextDrawFont(playerid,PCARTextName[playerid][i], 3);
			PlayerTextDrawLetterSize(playerid,PCARTextName[playerid][i], 0.460000, 2.000000);
			PlayerTextDrawColor(playerid,PCARTextName[playerid][i], -1);
			PlayerTextDrawSetOutline(playerid,PCARTextName[playerid][i], 1);
			PlayerTextDrawSetProportional(playerid,PCARTextName[playerid][i], 1);
			PlayerTextDrawUseBox(playerid,PCARTextName[playerid][i], 1);
			PlayerTextDrawBoxColor(playerid,PCARTextName[playerid][i], 255);
			PlayerTextDrawTextSize(playerid,PCARTextName[playerid][i], 0.000000, -134.000000);
			PlayerTextDrawSetSelectable(playerid,PCARTextName[playerid][i], 0);
			PlayerTextDrawShow(playerid, PCARTextName[playerid][i]);

			if(dealership && data[i][4])
			{
				format(str, sizeof(str), "%s", FormatNumber(data[i][4]));
				PCARTextPrice[playerid][i] = CreatePlayerTextDraw(playerid,pX, pY, str);
				PlayerTextDrawBackgroundColor(playerid,PCARTextPrice[playerid][i], 255);
				PlayerTextDrawFont(playerid,PCARTextPrice[playerid][i], 1);
				PlayerTextDrawLetterSize(playerid,PCARTextPrice[playerid][i], 0.529999, 2.000000);
				PlayerTextDrawColor(playerid,PCARTextPrice[playerid][i], -1);
				PlayerTextDrawSetOutline(playerid,PCARTextPrice[playerid][i], 0);
				PlayerTextDrawSetProportional(playerid,PCARTextPrice[playerid][i], 1);
				PlayerTextDrawSetShadow(playerid,PCARTextPrice[playerid][i], 1);
				PlayerTextDrawSetSelectable(playerid,PCARTextPrice[playerid][i], 0);
				PlayerTextDrawShow(playerid, PCARTextPrice[playerid][i]);
			}

			if(count == 2)
			{
				sX = 118;
				sY = 248;


				nX = 183;
				nY = 358;

				if(dealership) pX = 131, pY = 262;
			}
			else
			{
				sX += 130;
				nX += 130;

				if(dealership) pX += 130;
			}

			count++;

			if(count > 5)
				break;
		}
	}

	if(!isnull(header))
	{
		PCARTextHeader[playerid] = CreatePlayerTextDraw(playerid, 124.000137, 82.133392, header);
		PlayerTextDrawLetterSize(playerid, PCARTextHeader[playerid], 0.992799, 5.278573);
		PlayerTextDrawTextSize(playerid, PCARTextHeader[playerid], 306.400100, 57.742218);
		PlayerTextDrawAlignment(playerid, PCARTextHeader[playerid], 1);
		PlayerTextDrawColor(playerid, PCARTextHeader[playerid], -1);
		PlayerTextDrawUseBox(playerid, PCARTextHeader[playerid], true);
		PlayerTextDrawBoxColor(playerid, PCARTextHeader[playerid], -255);
		PlayerTextDrawSetShadow(playerid, PCARTextHeader[playerid], 0);
		PlayerTextDrawSetOutline(playerid, PCARTextHeader[playerid], 1);
		PlayerTextDrawBackgroundColor(playerid, PCARTextHeader[playerid], 255);
		PlayerTextDrawFont(playerid, PCARTextHeader[playerid], 0);
		PlayerTextDrawSetProportional(playerid, PCARTextHeader[playerid], 1);
		PlayerTextDrawSetSelectable(playerid, PCARTextHeader[playerid], true);
	    PlayerTextDrawShow(playerid, PCARTextHeader[playerid]);
	}

	PCARTextLeft[playerid] = CreatePlayerTextDraw(playerid,66.000000, 220.000000, "ld_beat:left");
	PlayerTextDrawBackgroundColor(playerid,PCARTextLeft[playerid], 255);
	PlayerTextDrawFont(playerid,PCARTextLeft[playerid], 4);
	PlayerTextDrawLetterSize(playerid,PCARTextLeft[playerid], 0.599999, 0.599999);
	PlayerTextDrawColor(playerid,PCARTextLeft[playerid], (page > 1) ? 0x7A936AAA : -1);
	PlayerTextDrawSetOutline(playerid,PCARTextLeft[playerid], 0);
	PlayerTextDrawSetProportional(playerid,PCARTextLeft[playerid], 1);
	PlayerTextDrawSetShadow(playerid,PCARTextLeft[playerid], 1);
	PlayerTextDrawUseBox(playerid,PCARTextLeft[playerid], 1);
	PlayerTextDrawBoxColor(playerid,PCARTextLeft[playerid], 255);
	PlayerTextDrawTextSize(playerid,PCARTextLeft[playerid], 69.000000, 59.000000);
	PlayerTextDrawSetSelectable(playerid,PCARTextLeft[playerid], (page > 1) ? true : false);
	PlayerTextDrawShow(playerid, PCARTextLeft[playerid]);

	PCARTextRight[playerid] = CreatePlayerTextDraw(playerid,(count < 3) ? 103 + count * 130 : 493, 220.000000, "ld_beat:right");
	PlayerTextDrawBackgroundColor(playerid,PCARTextRight[playerid], 255);
	PlayerTextDrawFont(playerid,PCARTextRight[playerid], 4);
	PlayerTextDrawLetterSize(playerid,PCARTextRight[playerid], 0.599999, 0.599999);
	PlayerTextDrawColor(playerid,PCARTextRight[playerid], (floatround(caramount/(page * 6), floatround_ceil) && caramount % 6 != 0) ? 0x7A936AAA : -1);
	PlayerTextDrawSetOutline(playerid,PCARTextRight[playerid], 0);
	PlayerTextDrawSetProportional(playerid,PCARTextRight[playerid], 1);
	PlayerTextDrawSetShadow(playerid,PCARTextRight[playerid], 1);
	PlayerTextDrawUseBox(playerid,PCARTextRight[playerid], 1);
	PlayerTextDrawBoxColor(playerid,PCARTextRight[playerid], 255);
	PlayerTextDrawTextSize(playerid,PCARTextRight[playerid], 69.000000, 59.000000);
	PlayerTextDrawSetSelectable(playerid,PCARTextRight[playerid], (floatround(caramount/(page * 6), floatround_ceil) && caramount % 6 != 0) ? true : false);
	PlayerTextDrawShow(playerid, PCARTextRight[playerid]);
}

ClosePlayerCarMenu(playerid, force = 0)
{
	if(PCarOpening{playerid})
	{
	    PCarOpening{playerid} = false;

	    PlayerTextDrawDestroy(playerid, PCARTextLeft[playerid]);
	    PlayerTextDrawDestroy(playerid, PCARTextRight[playerid]);

		if(PCarType[playerid] == 0)
		{
			for(new i = 0; i < 6; ++i)
			{
			    if(VehicleCache[playerid][i] != -1)
			    {
			        PlayerTextDrawDestroy(playerid, PCARTextSlot[playerid][i]);
					PlayerTextDrawDestroy(playerid, PCARTextName[playerid][i]);
			    }

			    VehicleCache[playerid][i] = -1;
			}
		}
		else
		{
		    PlayerTextDrawDestroy(playerid, PCARTextHeader[playerid]);

		    for(new i = 0; i < 6; ++i)
		    {
		        if(VDealerData[playerid][i][0])
		        {
			        PlayerTextDrawDestroy(playerid, PCARTextSlot[playerid][i]);
					PlayerTextDrawDestroy(playerid, PCARTextName[playerid][i]);

					if(VDealerData[playerid][i][4])
					{
						PlayerTextDrawDestroy(playerid, PCARTextPrice[playerid][i]);
					}
				}
			}
		}

		if(!force)
		{
		    CancelSelectTextDraw(playerid);

		    PCarPage[playerid] = 1;

		    VDealerSelectCatalog[playerid] = -1;

		    if(PCarType[playerid] == 1)
			{
				for(new i = 0; i < 6; ++i)
				{
					VDealerData[playerid][i][0] = 0;
					VDealerData[playerid][i][1] = -1;
					VDealerData[playerid][i][2] = -1;
					VDealerData[playerid][i][3] = 0;
					VDealerData[playerid][i][4] = 0;
				}
			}

			PCarType[playerid] = 0;
		}
	}
}

ShowPlayerCarMenu(playerid)
{
    ClosePlayerCarMenu(playerid, 1);

    VDealerSelectCatalog[playerid] = -1;

    SelectTextDraw(playerid, 0x83C689AA);

    new checkQuery[200], offset = PCarPage[playerid] - 1;

	format(checkQuery, sizeof(checkQuery), "SELECT `carID`, `carModel`, `carColor1`, `carColor2`, `carPosX`, `carPosY`, `carPosZ`, `carName`, `carUItag` FROM `cars` WHERE `carOwner` = '%d' ORDER BY `carDate` ASC LIMIT 7 OFFSET %i", PlayerData[playerid][pID], offset * 6);
    mysql_tquery(dbCon, checkQuery, "ListPlayerVehicles", "d", playerid);
}

FUNX::ListPlayerVehicles(playerid)
{
    new
		numbveh = cache_num_rows(),
		Float:vehDistance[3],
		strsmall[15]
	;

	new data[6][5], count; // 0 - carModel, 1 - Color1, 2 - Color2, 3 - Green, 4 - Price (if has one)

    for(new i = 0; i < numbveh; ++i)
	{
	    if(count == 6) break;

	    CarNames[playerid][count][0] = EOS;

	    cache_get_value_name_int(i, "carID", VehicleCache[playerid][count]);
	    cache_get_value_name_int(i, "carModel", data[count][0]);

		cache_get_value_name_int(i, "carModel", data[count][0]);
		cache_get_value_name_int(i, "carColor1", data[count][1]);
		cache_get_value_name_int(i, "carColor2", data[count][2]);

		cache_get_value_name_float(i, "carPosX",	vehDistance[0]);
		cache_get_value_name_float(i, "carPosY",	vehDistance[1]);
		cache_get_value_name_float(i, "carPosZ",	vehDistance[2]);

		if(IsPlayerInRangeOfPoint(playerid, 200.0, vehDistance[0], vehDistance[1], vehDistance[2]))
		{
            data[count][3] = 1;
		}

		cache_get_value_name(i, "carName", CarNames[playerid][count], 64);
		cache_get_value_name(i, "carUItag", strsmall, 15);

		if(strlen(strsmall) >= 3) format(CarNames[playerid][count], 64, strsmall);

        count++;
	}

	RenderPlayerCarMenu(playerid, PCarPage[playerid], numbveh, data);

	PCarOpening{playerid} = true;
	PCarType[playerid] = 0;
}

ShowPlayerDealershipMenu(playerid)
{
    ClosePlayerCarMenu(playerid, true);

    SelectTextDraw(playerid, 0x58585860); // 0x58585890

	new str[128], count, numbveh; // 0 - carModel, 1 - Color 1, 2 - Color 2, 3 - Green, 4 - Price if have

	for(new i = 0; i != 6; ++i)
	{
		VDealerData[playerid][i][0] = 0;
		VDealerData[playerid][i][1] = -1;
		VDealerData[playerid][i][2] = -1;
		VDealerData[playerid][i][3] = 0;
		VDealerData[playerid][i][4] = 0;
	}

    if(VDealerSelectCatalog[playerid] == -1)
	{
		numbveh = sizeof(VehicleMenuInfo);

		for(new i = (PCarPage[playerid]-1) * 6; i < numbveh; ++i)
		{
			VDealerData[playerid][count][0] = VehicleMenuInfo[i][0];
			VDealerData[playerid][count][1] = -1;
			VDealerData[playerid][count][2] = -1;
			VDealerData[playerid][count][3] = 0;

			for(new x = 0; x != sizeof(VehicleDealership); ++x)
			{
				if(VehicleDealership[x][1] == i)
				{
				    new price = VehicleData[VehicleDealership[x][0] - 400][c_price];

				    if(PlayerData[playerid][pCash] >= price)
					{
						VDealerData[playerid][count][3] = 1;
						break;
				    }
				}
			}

		  	count++;

			if(count > 5)
		  		break;
		}

		format(str, sizeof(str), "Categories");
	}
	else
	{
	    new nextpage = (PCarPage[playerid]-1) * 6;

		for(new x = 0; x != sizeof(VehicleDealership); ++x)
		{
			if(VehicleDealership[x][1] == VDealerSelectCatalog[playerid])
			{
			    numbveh++;

				if(nextpage)
				{
				    nextpage--;
				    continue;
				}

				if(count < 6)
				{
					VDealerData[playerid][count][0] = VehicleDealership[x][0];
					VDealerData[playerid][count][4] = VehicleData[VehicleDealership[x][0] - 400][c_price];
					VDealerData[playerid][count][1] = -1;
					VDealerData[playerid][count][2] = -1;

				  	VDealerData[playerid][count][3] = (PlayerData[playerid][pCash] >= VDealerData[playerid][count][4]) ? 1:0;

				  	count++;
	     		}
			}
		}

		format(str, sizeof(str), "Categories_->_%s", VehicleMenuInfo[VDealerSelectCatalog[playerid]][1]);
	}

	RenderPlayerCarMenu(playerid, PCarPage[playerid], numbveh, VDealerData[playerid], str, 1);

	PCarOpening{playerid} = true;
	PCarType[playerid] = 1;
	return true;
}

CountPlayerVehicles(playerid)
{
	new checkQuery[128], count;

	mysql_format(dbCon, checkQuery, sizeof(checkQuery), "SELECT NULL FROM `cars` WHERE `carOwner` = %d LIMIT 12", PlayerData[playerid][pID]);
	new Cache:cache = mysql_query(dbCon, checkQuery);

	count = cache_num_rows();

	cache_delete(cache);
	return count;
}

GiveVehicleDupKey(playerid, key)
{
	for(new i = 0; i < 10; ++i)
	{
		if(PlayerData[playerid][pDupKeys][i] == 9999)
		{
			PlayerData[playerid][pDupKeys][i] = key;
			break;
		}
	}
}

RemoveVehicleDupKey(playerid, carid)
{
	for(new i = 0; i < 10; ++i)
	{
		if(PlayerData[playerid][pDupKeys][i] == carid)
		{
			PlayerData[playerid][pDupKeys][i] = 9999;
			break;
		}
	}
}

CountVehicleDupKeys(playerid)
{
	new
	    count = 0
	;

	for(new i = 0; i < 10; ++i)
	{
	    if(PlayerData[playerid][pDupKeys][i] != 9999)
	    {
	        count++;
	    }
	}

	return count;
}

GetVehicleKeyID(playerid, vehicleid)
{
	new carid = Car_GetID(vehicleid);

	if(carid == -1) return -1;

	for(new i = 0; i < MAX_VEHICLE_KEYS; ++i)
	{
		if(PlayerData[playerid][pCarKeys][i] == carid)
		{
			return i;
		}
	}

	return -1;
}

HasVehicleKey(playerid, carid, bool:dup_keys = false)
{
	if(!dup_keys)
	{
		for(new i = 0; i < MAX_VEHICLE_KEYS; ++i)
		{
			if(PlayerData[playerid][pCarKeys][i] == carid)
			{
			    return true;
			}
		}
	}
	else
	{
		for(new i = 0; i < 10; ++i)
		{
		    if(PlayerData[playerid][pDupKeys][i] == CarData[carid][carID])
			{
				return true;
			}

		    if(i < MAX_VEHICLE_KEYS)
		    {
				if(PlayerData[playerid][pCarKeys][i] == carid)
				{
					return true;
				}
			}
		}
	}

	return false;
}

GiveVehicleKey(playerid, key)
{
	for(new i = 0; i < MAX_VEHICLE_KEYS; ++i)
	{
		if(PlayerData[playerid][pCarKeys][i] == 9999)
		{
			PlayerData[playerid][pCarKeys][i] = key;
			break;
		}
	}
}

RemoveVehicleKey(playerid, carid)
{
	for(new i = 0; i < MAX_VEHICLE_KEYS; ++i)
	{
		if(PlayerData[playerid][pCarKeys][i] == carid)
		{
			PlayerData[playerid][pCarKeys][i] = 9999;
			break;
		}
	}
}

CountVehicleKeys(playerid)
{
	new
	    count = 0
	;

	for(new i = 0; i < MAX_VEHICLE_KEYS; ++i)
	{
	    if(PlayerData[playerid][pCarKeys][i] != 9999)
	    {
	        count++;
	    }
	}

	return count;
}

MaxVehiclesSpawned(playerid)
{
	if(PlayerData[playerid][pAdmin])
		return 3;

	if(PlayerData[playerid][pDonateRank] == 3)
		return 3;

	return 1;
}

SpawnPlayerCar(playerid, slot)
{
	if(PCarOpening{playerid})
	{
		new count, cacheID = slot;

		for(new i = 0; i < MAX_VEHICLE_KEYS; ++i)
		{
		    if(PlayerData[playerid][pCarKeys][i] != 9999)
			{
				if(CarData[ PlayerData[playerid][pCarKeys][i] ][carID] == VehicleCache[playerid][cacheID])
					return SendServerMessage(playerid, "This vehicle is already spawned.");

				count++;
			}
		}

        if(count >= MaxVehiclesSpawned(playerid))
			return SendServerMessage(playerid, "You already have your max amount of private vehicles spawned.");

	    if(PCarPage[playerid] != 1) slot = slot + 6;

		new query[128];
		format(query, sizeof(query), "SELECT * FROM `cars` WHERE `carID` = '%d' AND `carOwner` = %d LIMIT 1", VehicleCache[playerid][cacheID], PlayerData[playerid][pID]);
		mysql_tquery(dbCon, query, "OnPlayerVehicleSpawn", "d", playerid);
    }
    return true;
}

FUNX::OnPlayerVehicleSpawn(playerid)
{
	if(PCarOpening{playerid})
	{
		new i = Iter_Free(sv_playercar), str[128];

		if(i != -1)
		{
			cache_get_value_name_int(0, "carID", CarData[i][carID]);
			cache_get_value_name_int(0, "carOwner", CarData[i][carOwner]);
			cache_get_value_name(0, "carName", CarData[i][carName], 64);
			cache_get_value_name(0, "carUItag", CarData[i][carUItag], 15);
			cache_get_value_name_int(0, "carModel", CarData[i][carModel]);
			cache_get_value_name_float(0, "carPosX", CarData[i][carPos][0]);
			cache_get_value_name_float(0, "carPosY", CarData[i][carPos][1]);
			cache_get_value_name_float(0, "carPosZ", CarData[i][carPos][2]);
			cache_get_value_name_float(0, "carPosR", CarData[i][carPos][3]);
			cache_get_value_name_int(0, "carColor1", CarData[i][carColor1]);
			cache_get_value_name_int(0, "carColor2", CarData[i][carColor2]);
			cache_get_value_name_int(0, "carPaintjob", CarData[i][carPaintjob]);
			cache_get_value_name_int(0, "carLock", CarData[i][carLock]);
			cache_get_value_name_int(0, "carAlarm", CarData[i][carAlarm]);
			cache_get_value_name_int(0, "carXM", CarData[i][carXM]);
			cache_get_value_name_int(0, "carInsurance", CarData[i][carInsurance]);
			cache_get_value_name_float(0, "carMileage", CarData[i][carMileage]);
			cache_get_value_name_int(0, "carImmob", CarData[i][carImmob]);
			cache_get_value_name_float(0, "carBatteryL", CarData[i][carBatteryL]);
			cache_get_value_name_float(0, "carEngineL", CarData[i][carEngineL]);
			cache_get_value_name_float(0, "carFuel", CarData[i][carFuel]);
			cache_get_value_name_int(0, "carDamage1", CarData[i][carDamage][0]);
			cache_get_value_name_int(0, "carDamage2", CarData[i][carDamage][1]);
			cache_get_value_name_int(0, "carDamage3", CarData[i][carDamage][2]);
			cache_get_value_name_int(0, "carDamage4", CarData[i][carDamage][3]);
			cache_get_value_name_float(0, "carHealth", CarData[i][carHealth]);
			cache_get_value_name_int(0, "carComps", CarData[i][carComps]);
			cache_get_value_name_int(0, "carDuplicate", CarData[i][carDupKey]);

            cache_get_value_name(0, "carPlate", str);
            format(CarData[i][carPlate], 32, str);

			cache_get_value_name(0, "carPlacePos", str);
            AssignPlaceItems(i, str);

			cache_get_value_name(0, "carPackageWeapons", str);
            AssignVehicleWeapons(i, str);

			/*cache_get_value_name(0, "carTickets", str);
            AssignVehicleTickets(i, str);*/

            cache_get_value_name(0, "licenseWeapons", str);
            AssignCarLicenseWeapons(i, str);

			CarData[i][carVehicle] = CreateVehicle(CarData[i][carModel], CarData[i][carPos][0], CarData[i][carPos][1], CarData[i][carPos][2], CarData[i][carPos][3], CarData[i][carColor1], CarData[i][carColor2], -1);
			ResetVehicle(CarData[i][carVehicle]);

            SetVehicleNumberPlate(CarData[i][carVehicle], CarData[i][carPlate]);

            ChangeVehiclePaintjob(CarData[i][carVehicle], CarData[i][carPaintjob]);
            if(CarData[i][carPaintjob] == 3) ChangeVehicleColor(CarData[i][carVehicle], CarData[i][carColor1], CarData[i][carColor2]);

			for(new x = 0; x != 14; ++x)
			{
				format(str, sizeof(str), "carMod%d", x+1);
			   	cache_get_value_name_int(0, str, CarData[i][carMods][x]);
			   	AddVehicleComponent(CarData[i][carVehicle], CarData[i][carMods][x]);
			}

			for(new x = 0; x != MAX_CAR_WEAPONS; ++x)
			{
				format(str, sizeof(str), "carWeapon%d", x);
			   	cache_get_value_name_int(0, str, CarData[i][carWeapon][x]);

				format(str, sizeof(str), "carAmmo%d", x);
			   	cache_get_value_name_int(0, str, CarData[i][carAmmo][x]);

			   	if(CarData[i][carWeapon][x] != 0)
			   	{
					CarPlace[i][x][cPobj] = CreateDynamicObject(GetGunObjectID(CarData[i][carWeapon][x]), 0, 0, 0, 0, 0, 0);
			   	    AttachDynamicObjectToVehicle(CarPlace[i][x][cPobj], CarData[i][carVehicle], CarPlace[i][x][cPx], CarPlace[i][x][cPy], CarPlace[i][x][cPz], CarPlace[i][x][cPrx], CarPlace[i][x][cPry], CarPlace[i][x][cPrz]);
			   	}
			}

			SendClientMessageEx(playerid, COLOR_GREEN, "%s has been spawned at its parking place:", ReturnVehicleName(CarData[i][carVehicle]));
            SendClientMessageEx(playerid, COLOR_CYAN, "Lock[%d], Alarm[%d], Immob[%d], Insurance[%d]", CarData[i][carLock], CarData[i][carAlarm], CarData[i][carImmob], CarData[i][carInsurance]);
			SendClientMessageEx(playerid, COLOR_CYAN, "Life Span: Engine Life[%.2f], Battery Life[%.2f], Miles Driven[%.2f]", CarData[i][carEngineL], CarData[i][carBatteryL], CarData[i][carMileage]);
			SendClientMessage(playerid, TEAM_CUN_COLOR, "Hint: Follow the red mark to find your vehicle.");

			GiveVehicleKey(playerid, i);

		  	Iter_Add(sv_vehicles, CarData[i][carVehicle]);

		  	Iter_Add(sv_playercar, i);

            CoreVehicles[CarData[i][carVehicle]][vehFuel] = CarData[i][carFuel];
            CoreVehicles[CarData[i][carVehicle]][vehicleCarID] = i;

            SetSlotVehicleDamage(i);

            CarData[i][carLocked] = 1;

            format(CarData[i][carOwnerName], MAX_PLAYER_NAME, "%s", ReturnName(playerid));

			new
				engine,
				lights,
				alarm,
				doors,
				bonnet,
				boot,
				objective;

			GetVehicleParamsEx(CarData[i][carVehicle], engine, lights, alarm, doors, bonnet, boot, objective);
			SetVehicleParamsEx(CarData[i][carVehicle], engine, lights, alarm, CarData[i][carLocked], bonnet, boot, objective);

			SetPlayerCheckpoint(playerid,CarData[i][carPos][0], CarData[i][carPos][1], CarData[i][carPos][2], 4.0);
			gPlayerCheckpointStatus[playerid] = CHECKPOINT_VEH;

			LoadVehicleDrugs(i);
		}

		ClosePlayerCarMenu(playerid);
	}
}

FUNX::OnPlayerVehicleScrap(playerid, carid, scrap_price)
{
	if(!cache_affected_rows())
		return SendServerMessage(playerid, "There was an error while scrapping your vehicle, contact an administrator.");

	Car_DespawnEx(carid);
	RemoveVehicleKey(playerid, carid);

	SendClientMessageEx(playerid, COLOR_GREEN, "You've scrapped your vehicle for %s and will no longer have it.", FormatNumber(scrap_price));
	SendClientMessage(playerid, 0xADFF2FFF, "PROCESSED:List Rebuilt.");

	SendPlayerMoney(playerid, scrap_price);

	mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `characters` SET `Cash` = '%d' WHERE `ID` = '%d' LIMIT 1", PlayerData[playerid][pCash], PlayerData[playerid][pID]);
	mysql_tquery(dbCon, gquery);
	return true;
}