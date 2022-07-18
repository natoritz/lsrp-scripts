/*
																Los Santos Roleplay


	CREDITS: pristine, rwenton, PSH.

*/

#include <a_samp>

#undef MAX_PLAYERS
#define MAX_PLAYERS (200)

#undef MAX_VEHICLES
#define MAX_VEHICLES (400)

#undef MAX_ACTORS
#define MAX_ACTORS (50)

#include <a_mysql>
#include <sscanf2>
#include <streamer>
#include <easyDialog>
#include <CustomSkins>
#include <strlib>
#include <Pawn.Regex>
#include <timestamptodate>
#include <evi>
#include <sort>

#define MAX_COMMANDS 800
#define YSI_NO_HEAP_MALLOC

new DisabledCommands[MAX_COMMANDS];

#include <YSI_Visual/y_commands>
#include <YSI_Data/y_iterate>
#include <YSI_Coding/y_va>
#include <YSI_Coding/y_timers>

#define IS_LOCAL_HOST true

enum
{
	AREA_TYPE_PROPERTY,
	AREA_TYPE_COMPLEX,
	AREA_TYPE_STINGER
};

#include "modules/misc/Macros.pwn"
#include "modules/misc/Config.pwn"
#include "modules/misc/Colors.pwn"
#include "modules/misc/Defines.pwn"
#include "modules/player/Core.pwn"

new const Float:GoFishingPlace[3][3] =
{
	{813.6824,-2248.2407,-0.4488},
	{407.6824,-2318.2407,-0.5752},
	{-25.9471,-1981.9995,-0.6268}
};

new const Float:FlintFarm[5][3] =
{
	{-207.9474,-1327.1185,9.8555},
	{-569.3899,-1302.7570,22.4331},
	{-511.1070,-1376.0288,19.4673},
	{-309.0976,-1539.4039,11.7151},
	{-222.2049,-1520.7129,7.0026}
};

new const Float:BlueFarm[5][3] =
{
	{69.6013,-3.1608,1.8764},
	{-25.4396,-56.4816,4.0989},
	{-148.9333,41.2588,4.0932},
	{-190.1118,138.5946,5.8175},
	{15.3321,-104.6317,1.9983}
};

new const Float:gBoatSpawn[20][4] =
{
	{81.599998, -1699.599975, 0.000000, 88.000000},
	{73.500000, -1647.799804, 0.000000, 73.998001},
	{71.699996, -1658.300048, 0.300000, 89.995002},
	{78.699996, -1677.400024, 0.000000, 109.995002},
	{73.900390, -1667.500000, 0.000000, 109.995002},
	{81.700187, -1689.400390, 0.000000, 87.995002},
	{90.300003, -1743.400024, 0.000000, 111.995002},
	{82.400390, -1709.799804, 0.000000, 93.994003},
	{84.400390, -1721.700195, 0.000000, 93.994003},
	{86.400001, -1733.599975, 0.000000, 95.992996},
	{96.099998, -1753.099975, 0.000000, 111.995002},
	{103.800003, -1764.199951, 0.000000, 123.995002},
	{72.300003, -1632.300048, 0.000000, 85.991996},
	{72.300003, -1622.300048, 0.000000, 85.989997},
	{72.500000, -1611.699951, 0.000000, 85.989997},
	{70.800003, -1579.699951, 0.000000, 91.989997},
	{72.500000, -1601.099609, 0.000000, 85.989997},
	{72.000000, -1591.799804, 0.000000, 85.989997},
	{67.099998, -1569.599975, 0.000000, 93.988998},
	{63.799999, -1559.699951, 0.000000, 109.987998}
};

new const Float:gCombineSpawn[34][4] =
{
	{94.199996, -5.199999, 1.700000, 80.000000},
	{97.599609, 14.299810, 1.700000, 79.997001},
	{95.799812, 4.700200, 1.700000, 79.997001},
	{88.000000, -46.500000, 1.799999, 79.997001},
	{92.299812, -15.200189, 1.799999, 79.997001},
	{90.599609, -25.299800, 1.899999, 79.997001},
	{89.500000, -35.799800, 1.899999, 79.997001},
	{46.299999, -172.699996, 1.799999, 3.996999},
	{14.500000, -172.899993, 1.700000, 0.000000},
	{36.599609, -173.099609, 1.700000, 3.993999},
	{25.899999, -173.699996, 1.700000, 0.000000},
	{-7.800000, -170.199996, 2.299999, 352.000000},
	{2.599610, -171.599609, 1.700000, 351.996002},
	{-17.700000, -168.699996, 3.000000, 351.996002},
	{-27.600000, -167.399993, 3.599999, 351.996002},
	{-48.900001, -164.000000, 4.199999, 350.000000},
	{-38.500000, -165.799804, 4.199999, 349.997009},
	{-132.600006, -136.899993, 4.199999, 349.997009},
	{-156.600006, -132.899993, 4.199999, 349.997009},
	{-144.400390, -134.599609, 4.199999, 349.997009},
	{-168.600006, -130.899993, 4.199999, 349.997009},
	{-181.100006, -129.500000, 4.199999, 349.997009},
	{-192.899993, -127.900001, 4.199999, 349.997009},
	{-229.899993, -123.699996, 4.199999, 349.997009},
	{-205.000000, -127.099609, 4.199999, 349.997009},
	{-217.400390, -125.599609, 4.199999, 349.997009},
	{-83.500000, 180.000000, 4.000000, 160.000000},
	{-93.000000, 184.000000, 4.099999, 159.998992},
	{-111.599998, 192.000000, 5.400000, 165.998992},
	{-102.200202, 188.099609, 4.699999, 159.998992},
	{-121.500000, 195.199996, 6.400000, 165.992004},
	{-141.699996, 200.899993, 8.800000, 169.992004},
	{-131.400390, 198.099609, 7.599999, 165.992004},
	{-151.500000, 202.800003, 10.000000, 169.990997}
};

new const Float:gVehicleSpawn[120][4] =
{
	{1616.900024, -1137.099975, 23.899999, 90.000000},
	{1616.800048, -1132.599975, 23.899999, 90.000000},
	{1616.800048, -1128.199951, 23.899999, 90.000000},
	{1616.699951, -1123.699951, 23.899999, 90.000000},
	{1616.599975, -1119.400024, 23.899999, 90.000000},
	{1630.099975, -1107.500000, 23.899999, 90.000000},
	{1630.099975, -1102.800048, 23.899999, 90.000000},
	{1629.800048, -1098.300048, 23.899999, 90.000000},
	{1629.800048, -1093.900024, 23.899999, 90.000000},
	{1629.699951, -1089.599975, 23.899999, 90.000000},
	{1629.599975, -1085.099975, 23.899999, 90.000000},
	{1657.699951, -1111.599975, 23.899999, 90.000000},
	{1658.000000, -1107.000000, 23.899999, 90.000000},
	{1658.000000, -1102.500000, 23.899999, 90.000000},
	{1657.900024, -1098.099975, 23.899999, 90.000000},
	{1657.800048, -1093.599975, 23.899999, 90.000000},
	{1657.800048, -1089.000000, 23.899999, 90.000000},
	{1658.000000, -1084.500000, 23.899999, 90.000000},
	{1658.099975, -1080.099975, 23.899999, 90.000000},
	{1621.099975, -1107.400024, 23.899999, 270.00000},
	{1621.199951, -1103.099975, 23.899999, 270.00000},
	{1621.300048, -1098.599975, 23.899999, 270.00000},
	{1621.300048, -1094.099975, 23.899999, 270.00000},
	{1621.300048, -1089.699951, 23.899999, 270.00000},
	{1621.300048, -1085.199951, 23.899999, 270.00000},
	{1649.199951, -1111.599975, 23.899999, 270.00000},
	{1649.599975, -1107.000000, 23.899999, 270.00000},
	{1649.699951, -1102.599975, 23.899999, 270.00000},
	{1649.699951, -1098.000000, 23.899999, 270.00000},
	{1649.699951, -1093.699951, 23.899999, 270.00000},
	{1649.700195, -1089.099609, 23.899999, 270.00000},
	{1649.700195, -1084.799804, 23.899999, 270.00000},
	{1649.699951, -1080.300048, 23.899999, 270.00000},
	{1675.599975, -1097.800048, 23.899999, 270.00000},
	{1675.599975, -1102.500000, 23.899999, 270.00000},
	{1675.500000, -1106.900024, 23.899999, 270.00000},
	{1675.400024, -1111.300048, 23.899999, 270.00000},
	{1675.500000, -1115.900024, 23.899999, 270.00000},
	{1675.500000, -1120.199951, 23.899999, 270.00000},
	{1675.500000, -1124.699951, 23.899999, 270.00000},
	{1675.500000, -1129.099975, 23.899999, 270.00000},
	{1666.199951, -1135.400024, 23.899999, 180.00000},
	{1661.599975, -1135.800048, 23.899999, 180.00000},
	{1657.400024, -1135.800048, 23.899999, 180.00000},
	{1652.900024, -1135.800048, 23.899999, 180.00000},
	{1648.400024, -1135.800048, 23.899999, 180.00000},
	{1793.400024, -1060.900024, 24.000000, 180.00000},
	{1788.800048, -1061.099975, 24.000000, 180.00000},
	{1784.500000, -1060.900024, 24.000000, 180.00000},
	{1779.800048, -1061.300048, 24.000000, 180.00000},
	{1775.400024, -1061.199951, 24.000000, 180.00000},
	{1771.000000, -1061.199951, 24.000000, 180.00000},
	{1766.599975, -1061.099975, 24.000000, 180.00000},
	{1761.699951, -1061.300048, 24.000000, 180.00000},
	{1722.699951, -1060.599975, 24.000000, 180.00000},
	{1718.099975, -1060.500000, 24.000000, 180.00000},
	{1714.000000, -1060.500000, 24.000000, 180.00000},
	{1709.000000, -1060.500000, 24.000000, 180.00000},
	{1704.500000, -1060.500000, 24.000000, 180.00000},
	{1700.300048, -1060.599975, 24.000000, 180.00000},
	{1696.000000, -1060.400024, 24.000000, 180.00000},
	{1691.400024, -1060.400024, 24.000000, 180.00000},
	{1680.900024, -1036.000000, 23.899999, 180.00000},
	{1685.400024, -1036.000000, 23.899999, 180.00000},
	{1689.800048, -1035.800048, 23.899999, 180.00000},
	{1694.400024, -1035.900024, 23.899999, 180.00000},
	{1698.699951, -1035.699951, 23.899999, 180.00000},
	{1703.300048, -1035.599975, 23.899999, 180.00000},
	{1707.699951, -1035.599975, 24.000000, 180.00000},
	{1712.300048, -1035.000000, 23.899999, 180.00000},
	{1757.199951, -1037.800048, 24.000000, 180.00000},
	{1761.599975, -1038.199951, 24.000000, 180.00000},
	{1752.900024, -1037.699951, 24.000000, 180.00000},
	{1748.699951, -1038.000000, 24.000000, 180.00000},
	{1744.199951, -1037.900024, 24.000000, 180.00000},
	{1691.400024, -1070.000000, 23.899999, 0.000000},
	{1695.699951, -1069.900024, 23.899999, 0.000000},
	{1704.800048, -1069.699951, 23.899999, 0.000000},
	{1700.200195, -1069.799804, 23.899999, 0.000000},
	{1709.300048, -1069.699951, 23.899999, 0.000000},
	{1718.199951, -1069.500000, 23.899999, 0.000000},
	{1713.700195, -1069.500000, 23.899999, 0.000000},
	{1722.500000, -1069.400024, 23.899999, 0.000000},
	{1681.199951, -1044.300048, 23.899999, 0.000000},
	{1685.699951, -1044.300048, 23.899999, 0.000000},
	{1690.000000, -1044.300048, 23.899999, 0.000000},
	{1694.599975, -1044.000000, 23.899999, 0.000000},
	{1698.900024, -1044.099975, 23.899999, 0.000000},
	{1703.400024, -1044.300048, 23.899999, 0.000000},
	{1708.099975, -1044.300048, 23.899999, 0.000000},
	{1712.699951, -1044.199951, 23.899999, 0.000000},
	{1744.099975, -1046.000000, 23.899999, 0.000000},
	{1748.400024, -1045.900024, 23.899999, 0.000000},
	{1752.800048, -1046.199951, 23.899999, 0.000000},
	{1757.500000, -1046.000000, 23.899999, 0.000000},
	{1761.599975, -1046.000000, 23.899999, 0.000000},
	{1762.099975, -1069.699951, 23.899999, 0.000000},
	{1766.699951, -1069.800048, 23.899999, 0.000000},
	{1771.199951, -1069.800048, 23.899999, 0.000000},
	{1775.300048, -1070.000000, 23.899999, 0.000000},
	{1780.000000, -1070.000000, 23.899999, 0.000000},
	{1784.400024, -1069.900024, 23.899999, 0.000000},
	{1788.800048, -1069.800048, 23.899999, 0.000000},
	{1793.199951, -1069.699951, 23.899999, 0.000000},
	{1658.699951, -1046.400024, 23.899999, 0.000000},
	{1654.199951, -1046.500000, 23.899999, 0.000000},
	{1649.599975, -1046.300048, 23.899999, 0.000000},
	{1644.900024, -1046.400024, 23.899999, 0.000000},
	{1640.400024, -1046.300048, 23.899999, 0.000000},
	{1636.199951, -1046.400024, 23.899999, 0.000000},
	{1631.699951, -1046.400024, 23.899999, 0.000000},
	{1627.099975, -1046.400024, 23.899999, 0.000000},
	{1658.099975, -1038.099975, 23.899999, 180.00000},
	{1653.599975, -1038.300048, 23.899999, 180.00000},
	{1649.000000, -1038.300048, 23.899999, 180.00000},
	{1644.599975, -1038.199951, 23.899999, 180.00000},
	{1640.000000, -1038.300048, 23.899999, 180.00000},
	{1635.599975, -1038.199951, 23.899999, 180.00000},
	{1631.099975, -1038.300048, 23.899999, 180.00000},
	{1626.699951, -1038.300048, 23.899999, 180.00000}
};

new const g_aWeaponSlots[] =
{
	0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 10, 10, 8, 8, 8, 0, 0, 0, 2, 2, 2, 3, 3, 3, 4, 4, 5, 5, 4, 6, 6, 7, 7, 7, 7, 8, 12, 9, 9, 9, 11, 11, 11, 0, 0
};

new const g_aWeaponAttach[] =
{
	-1, -1, -1, 0, 1, 2, -1, -1, 3, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1
};

new const BoneName[][] =
{
	"Spine", "Header", "Left armrest", "Right arm tree",
	"Left hand", "Right hand", "Left thigh", "Right thigh", "Left foot", "Right foot", "Right calf", "Left pantyhose",
	"Left sleeve", "Right sleeve", "The left-fish bone", "Right collarbone", "neck", "Jaw"
};

new const MonthDay[][] =
{
	"January", "February", "March", "April",
	"May", "June", "July", "August", "September", "October",
	"November","December"
};

new const szMonthDay[][] =
{
	"Jan", "Feb", "Mar", "Apr",
	"May", "Jun", "Jul", "Aug", "Sep", "Oct",
	"Nov","Dec"
};

new const ScrambleWord[][] =
{
	"SPIDER", "DROP", "HIRE", "EARTH", "GOLD", "HEART", "FLOWER", "KNIFE",
	"POOL", "BEACH", "HEEL", "APPLE", "ART", "BEAN", "BEHIND", "AWAY",
	"COOKIE", "DANCE", "SALE", "SEXY", "BULLET", "GRAPE", "GROUND", "FLIP", "DIRT",
	"PRIDE", "AROUSE", "SOUP", "CIRCUS", "VERBA", "RENT", "REFUND", "HUMAN", "ANIMAL",
	"SNOOP", "FOUR", "TURKEY", "HOLE", "HUMOR"
};

new const FishNames[5][20] =
{
	"Tuna",
	"Salmon",
	"Swordfish",
	"Murena", //Moray eel
	"Shark"
};

new const OrTeleports[][] =
{
	{"24/7 1"},
	{"24/7 2"},
	{"24/7 3"},
	{"24/7 4"},
	{"24/7 5"},
	{"24/7 6"},
	{"Airport Ticket Desk"},
	{"Airport Baggage Reclaim"},
	{"Shamal"},
	{"Andromada"},
	{"Ammunation 1"},
	{"Ammunation 2"},
	{"Ammunation 3"},
	{"Ammunation 4"},
	{"Ammunation 5"},
	{"Ammunation Booths"},
	{"Ammunation Range"},
	{"Blastin Fools Hallway"},
	{"Budget Inn Motel Room"},
	{"Jefferson Motel"},
	{"Off Track Betting Shop"},
	{"Sex Shop"},
	{"Meat Factory"},
	{"Zero's RC Shop"},
	{"Dillmore Gas Station"},
	{"Caligula's Basement"},
	{"FDC Janitors Room"},
	{"Woozie's Office"},
	{"Binco"},
	{"Didier Sachs"},
	{"Prolaps"},
	{"Suburban"},
	{"Victim"},
	{"ZIP"},
	{"Alhambra"},
	{"Ten Bottles"},
 	{"Lil' Probe Inn"},
 	{"Jay's Dinner"},
 	{"Gant Bridge Dinner"},
	{"Secret Valley Dinner"},
	{"World of Coq"},
	{"Welcome Pump"},
	{"Burger Shot"},
	{"Cluckin' Bell"},
	{"Well Stacked Pizza"},
	{"Jimmy's Sticky Ring"},
	{"Denise Room"},
	{"Katie Room"},
	{"Helena Room"},
	{"Michelle Room"},
	{"Barbara Room"},
	{"Mille Room"},
	{"Sherman Dam"},
	{"Planning Dept."},
	{"Area 51"},
	{"LS Gym"},
	{"SF Gym"},
	{"LV Gym"},
	{"B Dup's House"},
	{"B Dup's Crack Pad"},
	{"CJ's House"},
	{"Madd Dogg's Mansion"},
	{"OG Loc's House"},
	{"Ryder's House"},
	{"Sweet's House"},
	{"Crack Factory"},
	{"Big Spread Ranch"},
	{"Fanny Batters"},
	{"Strip Club"},
	{"Strip Club Private Room"},
	{"Unnamed Brothel"},
	{"Tiger Skin Brothel"},
	{"Pleasure Domes"},
	{"Liberty City Outside"},
	{"Liverty City Inside"},
	{"Gang House"},
	{"Colonel Furhberger's House"},
	{"Crack Den"},
	{"Warehouse 1"},
	{"Warehouse 2"},
	{"Sweet's Garage"},
	{"Lil' Probe Inn Toilet"},
	{"Unused Safe House"},
	{"RC Battlefield"},
	{"Barber 1"},
	{"Barber 2"},
	{"Barber 3"},
	{"Tatoo parlour 1"},
	{"Tatoo parlour 2"},
	{"Tatoo parlour 3"},
	{"LS Police HQ"},
	{"SF Police HQ"},
	{"LV Police HQ"},
	{"Car School"},
	{"8-Track"},
	{"Bloodbowl"},
	{"Dirt Track"},
	{"Kickstart"},
	{"Vice Stadium"},
	{"SF Garage"},
	{"LS Garage"},
	{"SF Bomb Shop"},
	{"Blueberry Warehouse"},
	{"LV Warehouse 1"},
	{"LV Warehouse 2"},
	{"Catigula's Hidden Room"},
	{"Bank"},
	{"Bank - Behind Desk"},
	{"LS Atruim"},
	{"Bike School"}
};

new const g_arrSelectColors[256] =
{
	0x000000FF, 0xF5F5F5FF, 0x2A77A1FF, 0x840410FF, 0x263739FF, 0x86446EFF, 0xD78E10FF, 0x4C75B7FF, 0xBDBEC6FF, 0x5E7072FF,
	0x46597AFF, 0x656A79FF, 0x5D7E8DFF, 0x58595AFF, 0xD6DAD6FF, 0x9CA1A3FF, 0x335F3FFF, 0x730E1AFF, 0x7B0A2AFF, 0x9F9D94FF,
	0x3B4E78FF, 0x732E3EFF, 0x691E3BFF, 0x96918CFF, 0x515459FF, 0x3F3E45FF, 0xA5A9A7FF, 0x635C5AFF, 0x3D4A68FF, 0x979592FF,
	0x421F21FF, 0x5F272BFF, 0x8494ABFF, 0x767B7CFF, 0x646464FF, 0x5A5752FF, 0x252527FF, 0x2D3A35FF, 0x93A396FF, 0x6D7A88FF,
	0x221918FF, 0x6F675FFF, 0x7C1C2AFF, 0x5F0A15FF, 0x193826FF, 0x5D1B20FF, 0x9D9872FF, 0x7A7560FF, 0x989586FF, 0xADB0B0FF,
	0x848988FF, 0x304F45FF, 0x4D6268FF, 0x162248FF, 0x272F4BFF, 0x7D6256FF, 0x9EA4ABFF, 0x9C8D71FF, 0x6D1822FF, 0x4E6881FF,
	0x9C9C98FF, 0x917347FF, 0x661C26FF, 0x949D9FFF, 0xA4A7A5FF, 0x8E8C46FF, 0x341A1EFF, 0x6A7A8CFF, 0xAAAD8EFF, 0xAB988FFF,
	0x851F2EFF, 0x6F8297FF, 0x585853FF, 0x9AA790FF, 0x601A23FF, 0x20202CFF, 0xA4A096FF, 0xAA9D84FF, 0x78222BFF, 0x0E316DFF,
	0x722A3FFF, 0x7B715EFF, 0x741D28FF, 0x1E2E32FF, 0x4D322FFF, 0x7C1B44FF, 0x2E5B20FF, 0x395A83FF, 0x6D2837FF, 0xA7A28FFF,
	0xAFB1B1FF, 0x364155FF, 0x6D6C6EFF, 0x0F6A89FF, 0x204B6BFF, 0x2B3E57FF, 0x9B9F9DFF, 0x6C8495FF, 0x4D8495FF, 0xAE9B7FFF,
	0x406C8FFF, 0x1F253BFF, 0xAB9276FF, 0x134573FF, 0x96816CFF, 0x64686AFF, 0x105082FF, 0xA19983FF, 0x385694FF, 0x525661FF,
	0x7F6956FF, 0x8C929AFF, 0x596E87FF, 0x473532FF, 0x44624FFF, 0x730A27FF, 0x223457FF, 0x640D1BFF, 0xA3ADC6FF, 0x695853FF,
	0x9B8B80FF, 0x620B1CFF, 0x5B5D5EFF, 0x624428FF, 0x731827FF, 0x1B376DFF, 0xEC6AAEFF, 0x000000FF, 0x177517FF, 0x210606FF,
	0x125478FF, 0x452A0DFF, 0x571E1EFF, 0x010701FF, 0x25225AFF, 0x2C89AAFF, 0x8A4DBDFF, 0x35963AFF, 0xB7B7B7FF, 0x464C8DFF,
	0x84888CFF, 0x817867FF, 0x817A26FF, 0x6A506FFF, 0x583E6FFF, 0x8CB972FF, 0x824F78FF, 0x6D276AFF, 0x1E1D13FF, 0x1E1306FF,
	0x1F2518FF, 0x2C4531FF, 0x1E4C99FF, 0x2E5F43FF, 0x1E9948FF, 0x1E9999FF, 0x999976FF, 0x7C8499FF, 0x992E1EFF, 0x2C1E08FF,
	0x142407FF, 0x993E4DFF, 0x1E4C99FF, 0x198181FF, 0x1A292AFF, 0x16616FFF, 0x1B6687FF, 0x6C3F99FF, 0x481A0EFF, 0x7A7399FF,
	0x746D99FF, 0x53387EFF, 0x222407FF, 0x3E190CFF, 0x46210EFF, 0x991E1EFF, 0x8D4C8DFF, 0x805B80FF, 0x7B3E7EFF, 0x3C1737FF,
	0x733517FF, 0x781818FF, 0x83341AFF, 0x8E2F1CFF, 0x7E3E53FF, 0x7C6D7CFF, 0x020C02FF, 0x072407FF, 0x163012FF, 0x16301BFF,
	0x642B4FFF, 0x368452FF, 0x999590FF, 0x818D96FF, 0x99991EFF, 0x7F994CFF, 0x839292FF, 0x788222FF, 0x2B3C99FF, 0x3A3A0BFF,
	0x8A794EFF, 0x0E1F49FF, 0x15371CFF, 0x15273AFF, 0x375775FF, 0x060820FF, 0x071326FF, 0x20394BFF, 0x2C5089FF, 0x15426CFF,
	0x103250FF, 0x241663FF, 0x692015FF, 0x8C8D94FF, 0x516013FF, 0x090F02FF, 0x8C573AFF, 0x52888EFF, 0x995C52FF, 0x99581EFF,
	0x993A63FF, 0x998F4EFF, 0x99311EFF, 0x0D1842FF, 0x521E1EFF, 0x42420DFF, 0x4C991EFF, 0x082A1DFF, 0x96821DFF, 0x197F19FF,
	0x3B141FFF, 0x745217FF, 0x893F8DFF, 0x7E1A6CFF, 0x0B370BFF, 0x27450DFF, 0x071F24FF, 0x784573FF, 0x8A653AFF, 0x732617FF,
	0x319490FF, 0x56941DFF, 0x59163DFF, 0x1B8A2FFF, 0x38160BFF, 0x041804FF, 0x355D8EFF, 0x2E3F5BFF, 0x561A28FF, 0x4E0E27FF,
	0x706C67FF, 0x3B3E42FF, 0x2E2D33FF, 0x7B7E7DFF, 0x4A4442FF, 0x28344EFF
};

// DEALERSHIP MENU
new const VehicleMenuInfo[][] =
{
	{511, "Airplanes"},
	{487, "Helicopters"},
	{481, "Bikes"},
	{480, "Convertibles"},
	{422, "Industrial"},
	{567, "Low_Riders"},
	{500, "Off_Road"},
	{431, "Public_Service"},
	{596, "Public_Server_Law"},
	{407, "Public_Service_Rescue"},
	{421, "Saloons"},
	{451, "Sports_Vehicles"},
	{479, "Station_Wagons"},
	{454, "Boats"},
	{483, "Unique"}
};

new VehicleDealership[][] =
{
	{511, 0},
	{593, 0},

	{417, 1},
	{487, 1},
	{488, 1},

	{462, 2},
	{463, 2},
	{468, 2},
	{471, 2},
	{481, 2},
	{509, 2},
	{521, 2},
	{586, 2},

	{480, 3},
	{533, 3},
	{555, 3},

	{403, 4},
	{408, 4},
	{413, 4},
	{414, 4},
	{422, 4},
	{440, 4},
	{443, 4},
	{455, 4},
	{456, 4},
	{459, 4},
	{478, 4},
	{482, 4},
	{498, 4}, // ... 609
	{499, 4},
	{514, 4},
	{515, 4},
	{543, 4}, // ...605
	{554, 4},
	{578, 4},
	{582, 4},
	{600, 4},

	{412, 5},
	{439, 5},
	{534, 5},
	{535, 5},
	{536, 5},
	{566, 5},
	{567, 5},
	{575, 5},
	{576, 5},

	{400, 6},
	{489, 6},
	{500, 6},
	{579, 6},

	{420, 7},
	{431, 7},
	{437, 7},
	{438, 7},

	{490, 8},
	{497, 8},
	{523, 8},
	{528, 8},
	{596, 8},
	{597, 8},
	{598, 8},
	{599, 8},
	{601, 8},

	{416, 9},

	{401, 10},
	{405, 10},
	{410, 10},
	{419, 10},
	{421, 10},
	{426, 10},
	{436, 10},
	{445, 10},
	{466, 10}, //... 604
	{467, 10},
	{474, 10},
	{491, 10},
	{492, 10},
	{507, 10},
	{516, 10},
	{517, 10},
	{518, 10},
	{526, 10},
	{527, 10},
	{529, 10},
	{540, 10},
	{542, 10},
	{546, 10},
	{547, 10},
	{549, 10},
	{550, 10},
	{551, 10},
	{560, 10},
	{562, 10},
	{580, 10},
	{585, 10},

	{402, 11},
	{415, 11},
	{429, 11},
	{475, 11},
	{477, 11},
	{496, 11},
	{541, 11},
	{558, 11},
	{559, 11},
	{565, 11},
	{587, 11},
	{589, 11},
	{602, 11},
	{603, 11},

	{404, 12},
	{418, 12},
	{458, 12},
	{479, 12},
	{561, 12},

	{446, 13},
	{453, 13},
	{454, 13},
	{472, 13},
	{473, 13},
	{484, 13},

	{409, 14},
	{423, 14},
	{483, 14},
	{508, 14},
	{525, 14},
	{532, 14},
	{545, 14},
	{588, 14}
};

new const g_arrVehicleNames[][] =
{
    "Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel", "Dumper", "Firetruck", "Trashmaster",
    "Stretch", "Manana", "Infernus", "Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam",
    "Esperanto", "Taxi", "Washington", "Bobcat", "Whoopee", "BF Injection", "Hunter", "Premier", "Enforcer",
    "Securicar", "Banshee", "Predator", "Bus", "Rhino", "Barracks", "Hotknife", "Trailer", "Previon", "Coach",
    "Cabbie", "Stallion", "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral", "Squalo", "Seasparrow",
    "Pizzaboy", "Tram", "Trailer", "Turismo", "Speeder", "Reefer", "Tropic", "Flatbed", "Yankee", "Caddy", "Solair",
    "Berkley's RC Van", "Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale", "Oceanic",
    "Sanchez", "Sparrow", "Patriot", "Quad", "Coastguard", "Dinghy", "Hermes", "Sabre", "Rustler", "ZR-350", "Walton",
    "Regina", "Comet", "BMX", "Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick", "News Chopper", "Rancher",
    "FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking", "Blista Compact", "Police Maverick",
    "Boxville", "Benson", "Mesa", "RC Goblin", "Hotring Racer A", "Hotring Racer B", "Bloodring Banger", "Rancher",
    "Super GT", "Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropduster", "Stunt", "Tanker", "Roadtrain",
    "Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra", "FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Tow Truck",
    "Fortune", "Cadrona", "SWAT Truck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer", "Remington", "Slamvan",
    "Blade", "Streak", "Freight", "Vortex", "Vincent", "Bullet", "Clover", "Sadler", "Firetruck", "Hustler", "Intruder",
    "Primo", "Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada", "Yosemite", "Windsor", "Monster", "Monster",
    "Uranus", "Jester", "Sultan", "Stratum", "Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma", "Savanna", "Bandito",
    "Freight Flat", "Streak Carriage", "Kart", "Mower", "Dune", "Sweeper", "Broadway", "Tornado", "AT-400", "DFT-30",
    "Huntley", "Stafford", "BF-400", "News Van", "Tug", "Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club",
    "Freight Box", "Trailer", "Andromada", "Dodo", "RC Cam", "Launch", "LSPD Ford Crown Victoria", "SFPD Cruiser", "LVPD Cruiser",
    "LSPD Chevrolet Tahoe", "Picador", "S.W.A.T", "Alpha", "Phoenix", "Glendale", "Sadler", "Luggage", "Luggage", "Stairs",
    "Boxville", "Tiller", "Utility Trailer"
};

enum Door
{
	DOOR_HOOD,
	DOOR_TRUNK,
	DOOR_DRIVER,
	DOOR_PASSENGER
}

enum DoorState(<<= 1)
{
	IS_OPENED = 1,
	IS_DAMAGED,
	IS_REMOVED
}

new const xmGenres[][] =
{
    "Rock",
	"Other",
	"Rhythm & Blues",
	"Urban",
	"Pop",
	"Oldies",
	"International",
	"Cultural",
	"Electronic",
	"Talk"
};

enum E_SubGenres
{
    xmid,
    subname[25],
}

new const xmSubGenres[][E_SubGenres] =
{
	// Rock
	{0, "Alternative Rock"},
	{0, "Hard Rock"},
	{0, "Classic Rock"},
	{0, "India Rock"},
	{0, "Punk Rock"},
	{0, "Death Metal"},
	{0, "Psychedelic Rock"},
	{0, "Surf"},
	{0, "Rockabilly"},
	{0, "Surf"},
	{0, "Rockabilly"},
	{0, "Heavy Metal"},
	{0, "Gothic Rock"},
	{0, "Doom Metal"},
	// Other
	{1, "legacy-rp"},
	{1, "Mash Ups"},
	{1, "Dance"},
	{1, "Chiptune"},
	{1, "Ambient"},
	{1, "Latin"},
	// Rhythm & Blues
	{2, "Soul"},
	{2, "Jazz"},
	{2, "R&B"},
	{2, "Electro Swig"},
	// Urban
	{3, "Country"},
	{3, "Hip Hop"},
	{3, "Ska"},
	{3, "Rap"},
	{3, "Trap"},
	{3, "Classic Rap"},
	{3, "Reggae"},
	{3, "Reggaeton"},
	// Pop
	{4, "Pop"},
	{4, "Latin"},
	// Oldies
	{5, "80s"},
	{5, "Mixed"},
	{5, "70s"},
	{5, "60s"},
	{5, "90s"},
	// International
	{6, "South Asian"},
	{6, "Russian"},
	{6, "Mexican"},
	{6, "Bosnian"},
	{6, "Macedonian"},
	{6, "French"},
	{6, "Cuban"},
	{6, "Swedish"},
	{6, "Arabic"},
	{6, "Romanian"},
	{6, "Norwegian"},
	{6, "Dutch"},
	{6, "Greek"},
	{6, "Hebrew"},
	{6, "Serbian"},
	{6, "Czech"},
	{6, "Albanian"},
	{6, "Spanish"},
	{6, "Armenian"},
	// Cultural
	{7, "Instruments"},
	// Electronic
	{8, "House"},
	{8, "Dance"},
	{8, "Psychedelic"},
	{8, "Ambient & Chillout"},
	{8, "Drum and Bass & Dubs"},
	{8, "Hard House"},
	{8, "Progressive"},
	{8, "Synthwave"},
	{8, "Dark Alternative"},
	// Talk
	{9, "Scanners"},
	{9, "News"}
};

new vehicleSiren[MAX_VEHICLES] = {INVALID_OBJECT_ID, ...};

enum GATE_INFO
{
	gateID,
	gateModel,
	gateObject,
	gateName[64],
	gateInterior,
	gateVirtualWorld,
	gateFaction,
	gateOpened,
	gateLocked,
	Float:gatePosX,
	Float:gatePosY,
	Float:gatePosZ,
	Float:gatePosRX,
	Float:gatePosRY,
	Float:gatePosRZ,
	Float:gateOpenSpeed,
	Float:gateMoveX,
	Float:gateMoveY,
	Float:gateMoveZ,
	Float:gateMoveRX,
	Float:gateMoveRY,
	Float:gateMoveRZ
}

new Gates[MAX_GATES][GATE_INFO];

enum MOVEABLE_DOORS
{
	doorID,
	doorModel,
	doorObject,
	doorName[64],
	doorInterior,
	doorVirtualWorld,
	doorFaction,
	doorOpened,
	doorLocked,
	Float:doorPosX,
	Float:doorPosY,
	Float:doorPosZ,
	Float:doorPosRX,
	Float:doorPosRY,
	Float:doorPosRZ,
	Float:doorOpenSpeed,
	Float:doorMoveX,
	Float:doorMoveY,
	Float:doorMoveZ,
	Float:doorMoveRX,
	Float:doorMoveRY,
	Float:doorMoveRZ
}

new Doors[MAX_MOVEDOORS][MOVEABLE_DOORS];

enum vehicleL
{
	vLabelType,
	vLabelTime,
	vLabelCount,
	Text3D:vLabel,
}

new VehicleLabel[MAX_VEHICLES][vehicleL];

enum houseinteriorE
{
	aID,
	Float:aPosX,
	Float:aPosY,
	Float:aPosZ,
	aInterior,
	aMapName[32],
	aTeleOn
};

enum boomboxData
{
	bool:boomboxPlaced,
	bool:boomboxOn,
	Float:boomboxPos[3],
	boomboxObject,
	boomboxURL[128 char]
};

enum contactData
{
	contactID,
	contactName[24],
	contactNumber,
};

enum smsData
{
	bool:smsExist,
	smsID,
	smsOwner,
	smsReceive,
	smsText[128],
	smsRead,
	smsArchive,
	smsDate[24],

};

enum cp_e
{
	cPobj,
	//
	Float:cPx,
	Float:cPy,
	Float:cPz,
	Float:cPrx,
	Float:cPry,
	Float:cPrz,
	cPType
};

enum paw_e
{
	awID,
	awWid,
	//
	awHide,
	awBone,
	Float:aPx,
	Float:aPy,
	Float:aPz,
	Float:aPrx,
	Float:aPry,
	Float:aPrz
}

enum chdata
{
	bool:chExists,
	chSec,
	chNumber,
	bool:chRead,
	chType // - Outgoing call to %s (%d), - Incoming call from %s (%d), - Missed call from %s (%d)
};

enum signalData
{
	signalID,
	signalExists,
	Float:signalX,
	Float:signalY,
	Float:signalZ,
	Float:signalRange,
	signalName[64]
	//signalObject
};

enum drugStoreData
{
	storeID,
	storeFaciton,
	storeCapacity,
	storeLastRefill,
	storeLast,
	Float:storeDrugs[2]
};

#define BLOCK_NONE 0
#define LESS_DAMAGE_FIST 1
#define BLOCK_FIST 2
#define LESS_DAMAGE_MELEE 3
#define BLOCK_PHYSICAL 4

enum ecrate
{
    cOn,
	cObject,
	Float:cX,
	Float:cY,
	Float:cZ,
	cID,
	cOwned,
	Text3D:clabel
}

enum systemE
{
	vehicleCounts[3], // 0 - Server, 1 - Player, 2 - Admin
	reportSystem,
	helpmeSystem,
	OOCStatus,
	DiscordStatus
};

enum eadvert
{
    ad_owner,
    ad_id,
    ad_time,
    ad_type,
	ad_text[128],
}

enum e_md
{
	bool:mExist,
	Float:mX,
	Float:mY,
	Float:mZ,
	mInt,
	mWorld,
	mID,

	mObject,
	mTimer,
};

new sgstr[128], gstr[2000], gquery[256], vgstr[128]; // Global strings

new
	AdvertData[MAX_AD_QUEUE][eadvert],
    Teleports[MAX_INTERIORS][houseinteriorE],
    AdminSpawnedVehicles[MAX_ADMIN_VEHICLES],
   	BoomboxData[MAX_PLAYERS][boomboxData],
    WeaponSettings[MAX_PLAYERS][MAX_ATTACH_WEAPON][paw_e],
    MealDrop[MAX_PLAYERS][e_md],
    ContactData[MAX_PLAYERS][40][contactData],
    SmsData[MAX_PLAYERS][MAX_SMS][smsData],
    CallHistory[MAX_PLAYERS][MAX_CALLHISTORY][chdata],
    CrateInfo[MAX_CRATE][ecrate],
    SignalData[MAX_SIGNALTOWER][signalData],
    systemVariables[systemE]
;

new ghour = 0, gminute = 0, gsecond = 0, timeshift = 0, shifthour;

// CARGO SHIP
/*#define NUM_SHIP_ATTACHMENTS 11
#define NUM_SHIP_ROUTE_POINTS 8
#define SPEED_CARGOSHIP  20

new Float:gShipHullOrigin[3] = {2841.49097, -2426.09570, 24.51091}; //2829.95313, -2479.57031, 3.88730};

new gShipAttachmentModelIds[NUM_SHIP_ATTACHMENTS] =
{
	5167, 5156, 5158, 3724, 5154, 5160, 5157, 3724, 5166, 5336, 5155
};

new Float:gShipAttachmentPos[NUM_SHIP_ATTACHMENTS][6] =
{
	{2838.03125, -2371.95313, 5.97090,   0.00000, 0.00000, -90.00000},
	{2837.96118, -2423.90869, 9.54590,   0.00000, 0.00000, -90.00000},
	{2837.77344, -2334.47656, 11.99220,   0.00000, 0.00000, 0.00000},
	{2838.19531, -2407.14063, 28.10849,   0.00000, 0.00000, -90.00000},
	
	{2838.14063, -2447.84375, 14.32000,   0.00000, 0.00000, -90.00000},
	{2829.95313, -2479.57031, 3.88730, 0.000000,   0.000000, -90.000000},
	
	{2838.01318, -2532.64331, 15.69740,   0.00000, 0.00000, -90.00000},
	{2838.19531, -2488.66406, 27.83050,   0.00000, 0.00000, 90.00000},
	{2829.95288, -2479.64819, 3.78360,   0.00000, 0.00000, -90.00000},
	{2829.95313, -2479.57031, 5.26560,   0.00000, 0.00000, 0.00000},
	{2838.02344, -2358.47656, 21.31250,   0.00000, 0.00000, -90.00000}
};

new Float:gShipRoutePoints[NUM_SHIP_ROUTE_POINTS][6] =
{
	//{2829.95313, -2479.57031, 3.88730, 0.000000,   0.000000, -90.000000},
    //{2838.14063, -2447.84375, 3.88730,   0.00000, 0.00000, -90.00000},
    
    {2841.49097, -2426.09570, 24.51091, 0.00000, 0.00000, -90.00000},
	{2829.915283, -2843.347167, 3.88730, 0.000000, 0.000000, -90.000000},
	{3248.907226, -2978.197998, 3.88730, 0.000000, 0.000000, -9.799991},
	{3283.973876, -3070.623535, 3.88730, 0.000000, 0.000000, -9.799991},
	{3356.869140, -2824.702880, 3.88730, 0.000000, 0.000000, 3.400008},
	{3306.186035, -2767.182373, 3.88730, 0.000000, 0.000000, 105.200027},
	{3529.560546, -2100.971435, 3.88730, 0.000000, 0.000000, 168.300140},
	{2994.928222, -2480.779541, 3.88730, 0.000000, 0.000000, -90.000000}
};

new gMainShipObjectId;*/

new gShipDeparture;
new gShipRamp1, gShipRamp2;
new gShipTextLine1;
new gShipTextLine2;
new gShipTextLine3;
//new gShipsAttachments[NUM_SHIP_ATTACHMENTS];
//new gShipCurrentPoint = 1; // current route point the ship is at. We start at route 1
new gShipTime;
new carryCrate[MAX_PLAYERS];

enum A_DATA
{
	aName[64],
	Float:aPos[4],
}

new A_INTERIORS[][A_DATA] =
{
	{"Small Interior (2 floors)", {871.8990,-2749.5200,3298.7673,31.3778}},
	{"Small Interior (3 floors)", {1980.1112,-2085.6201,601.4390,96.0022}},
	{"Big Interior", {619.2120,839.0550,1022.3200,226.6805}}
};

new InProperty[MAX_PLAYERS];
new InApartment[MAX_PLAYERS];
new InBusiness[MAX_PLAYERS];
new InGarage[MAX_PLAYERS];

enum RB_DATA
{
	roadblockID,
	roadblockObject,
	roadblockNote[24],
	roadblockLocation[28],
	roadblockDate[60],
	roadblockArea
};

new RoadBlocks[MAX_PLAYERS][10][RB_DATA];

enum RBDATA
{
	rbName[60],
	rbObjectID
}

new Road_Blocks[][RBDATA] =
{
	{"Traffic Cone", 1238},
	{"Roadblock", 973},
	{"Detour Roadblock", 1425},
	{"Small Barrier", 978},
	{"Medium Barrier", 979},
	{"Large Barrier", 973},
	{"Gate", 3036},
	{"Large Gate", 971},
	{"Road Stop", 19966},
	{"Small Spike Strip", 2899},
	{"Large Spike Strip", 2892},
	{"Police Tape", 19834},
	{"Speed Bump", 19425},
	{"Road Closed Sign", 19972},
	{"Work Zone Sign", 19975},
	{"Ladder (Short)", 1428},
	{"Ladder (Tall)", 1437},
	{"Road Flare (Red)", 18728},
	{"Gurney", 1997}
};

// Graffiti System
new	GraffiObj[MAX_PLAYERS];
new GraffiModel[MAX_PLAYERS];
new GraffitiName[MAX_PLAYERS][128];
new GraffitiFont[MAX_PLAYERS][24];
new SprayAmmount[MAX_PLAYERS];
new SprayIndex[MAX_PLAYERS];
new spraytimer[MAX_PLAYERS];
new SprayAmmountCH[MAX_PLAYERS];
new CurrentHoldingWeapon[MAX_PLAYERS];

// Variables
new
	bool:TaxiDuty[MAX_PLAYERS char],
	TaxiFare[MAX_PLAYERS char],
	bool:TaxiStart[MAX_PLAYERS char],
	TaxiMoney[MAX_PLAYERS],
	TaxiMade[MAX_PLAYERS],
	bool:TazerActive[MAX_PLAYERS char],
	bool:BeanbagActive[MAX_PLAYERS char],
	bool:LessLethalActive[MAX_PLAYERS char],
	bool:IsAFK[ MAX_PLAYERS char],
	bool:deleyAC_Nop[MAX_PLAYERS char],
	death_Pause[MAX_PLAYERS]
;

new FriskApproved[MAX_PLAYERS][MAX_PLAYERS];
new FishCooldown[MAX_PLAYERS];
new AFKTimer[MAX_PLAYERS];
new AFKCount[MAX_PLAYERS];
new grantboombox[MAX_PLAYERS];
new GrantBuild[MAX_PLAYERS];
new PlayerPlaceCar[MAX_PLAYERS];
new PlayerPlaceSlot[MAX_PLAYERS];
new MealHolding[MAX_PLAYERS];
new MealObject[MAX_PLAYERS];
new Firehold[MAX_PLAYERS];
new Firetimer[MAX_PLAYERS];
new FishingPlace[MAX_PLAYERS];
new FishingBoat[MAX_PLAYERS];
new Float:gPlayerCheckpointX[MAX_PLAYERS];
new Float:gPlayerCheckpointY[MAX_PLAYERS];
new Float:gPlayerCheckpointZ[MAX_PLAYERS];
new gPlayerCheckpointStatus[MAX_PLAYERS];
new gPlayerCheckpointValue[MAX_PLAYERS];
new nearProperty_var[MAX_PLAYERS];
new nearApartment_var[MAX_PLAYERS];
new PropertyViewPage[MAX_PLAYERS];
new PropertyViewPageIndexes[30][2];
new TutorialDelay[MAX_PLAYERS];

new
	pToAccept[MAX_PLAYERS],
	vToAccept[MAX_PLAYERS],
	tToAccept[MAX_PLAYERS],
	prToAccept[MAX_PLAYERS],
	serviceComp[MAX_PLAYERS],
	serviced[MAX_PLAYERS],
	serviceTowtruck[MAX_PLAYERS],
	serviceCustomer[MAX_PLAYERS],
	serviceFocus[MAX_PLAYERS],
	RepairTime[MAX_PLAYERS char]
;

// Farmer
new far_start[MAX_PLAYERS];
new far_veh[MAX_PLAYERS];
new far_place[MAX_PLAYERS]; // 0 - Flint County, 1 - Blueberry

// Hotwire
new h_vid[MAX_PLAYERS];
new h_times[MAX_PLAYERS];
new h_wid[MAX_PLAYERS];
new h_word[MAX_PLAYERS][16];
new h_score[MAX_PLAYERS];
new h_failed[MAX_PLAYERS];

// Selfie
new Float:Degree[MAX_PLAYERS];
new Float:SelAngle[MAX_PLAYERS];
const Float: Radius = 1.4; //do not edit this
const Float: Speed  = 1.25; //do not edit this
const Float: Height = 1.0; // do not edit this
new Float:lX[MAX_PLAYERS];
new Float:lY[MAX_PLAYERS];
new Float:lZ[MAX_PLAYERS];
new selfie_timer[MAX_PLAYERS];

new ConvoID[MAX_PLAYERS];
new SafeTime[MAX_PLAYERS];
new MedicBill[MAX_PLAYERS];

// Anims
new AnimCooldown[MAX_PLAYERS];

new cooldowns[MAX_PLAYERS][MAX_COOLDOWNS];
new cooldowns_expire[MAX_PLAYERS][MAX_COOLDOWNS];

new Text:TD_Restaurant[3];
new Text:TD_PhoneCover[9];
new Text:Store_Frame[4];
new Text:ALPR_UI[2];

new bool:MDC_Created[MAX_PLAYERS char];
new bool:UsingMDC[MAX_PLAYERS char];
new bool:ALPR_Hit[MAX_PLAYERS char];
new bool:ALPR_Enabled[MAX_PLAYERS char];

new CachedPages[MAX_PLAYERS][MAX_PLAYERS / 2][2];
new PenalCodePage[MAX_PLAYERS];

//PENAL CODE
#define PENAL_CODE_TILES    9
#define MAX_CRIMES          20
#define MAX_VEHICLE_BOLOS   30

new CallSign[MAX_PLAYERS][24];
new WritingArrest[MAX_PLAYERS];

enum e_MDC_Global_Data
{
	PoliceCalls,
	Arrests,
	Fines,

	MedicCalls,
};

new MDC_Global_Cache[e_MDC_Global_Data];

enum P_CODE_DATA
{
	crime_name[60],
	crime_description[180],
	crime_type,
	jail_time
}

new penal_code[PENAL_CODE_TILES][MAX_CRIMES][P_CODE_DATA];
new FoundCrime[MAX_PLAYERS][21][2];
new ClickedCrime[MAX_PLAYERS][2];
new ChargesSelected[MAX_PLAYERS][5][2];
new bool:ActiveQuery[MAX_PLAYERS char];
new FilterCharges[MAX_PLAYERS][128];
new PenalCodeIndex[MAX_PLAYERS][4];

enum mdc_data
{
	current_page,
	player_name[MAX_PLAYER_NAME],
	player_dbid,
	viewing_charge[23],
	vehicle_plate[MAX_PLAYER_NAME],
	vehicle_dbid,
	vehicle_id,
	property_idx[16],
	current_property,
	faction_type,
	unit_temp_page,
	editing_unit_temp
};

enum
{
	CHARGE_TYPE_NORMAL = 1,
	CHARGE_TYPE_ARREST,
	CHARGE_TYPE_JAIL
}

new e_Player_MDC_Cache[MAX_PLAYERS][mdc_data];

enum
{
	PUNISHMENT_TYPE_NONE = 0,
	PUNISHMENT_TYPE_AJAIL,
	PUNISHMENT_TYPE_JAIL,
	PUNISHMENT_TYPE_PRISON
}

new Text3D:PrisonLabel[MAX_PLAYERS];

enum EMERGENCY_INFO
{
	Caller,
	CallerName[MAX_PLAYER_NAME],
	CallerNumber,
	CallerServices[MAX_PLAYER_NAME],
	CallerLocation[60],
	CallerSituation[128],
	CallerTime[60],
	CallerRawTime,
	bool:CallerStatus,
	callUnit[64],
};

new EmergencyCalls[MAX_PLAYERS][EMERGENCY_INFO];

InsertEmergencyCall(playerid, const services[], const location[], const situation[])
{
 	for(new i = 0; i < MAX_PLAYERS; ++i)
	{
	    if(EmergencyCalls[i][Caller] != INVALID_PLAYER_ID) continue;

	    EmergencyCalls[i][Caller] = playerid;
	    format(EmergencyCalls[i][CallerName], MAX_PLAYER_NAME, ReturnName(playerid, 0));
	    EmergencyCalls[i][CallerNumber] = PlayerData[playerid][pPnumber];
	    format(EmergencyCalls[i][CallerServices], MAX_PLAYER_NAME, services);
	    format(EmergencyCalls[i][CallerLocation], 60, location);
	    format(EmergencyCalls[i][CallerSituation], 128, situation);
	    format(EmergencyCalls[i][CallerTime], 60, ReturnSiteDate());
	    EmergencyCalls[i][CallerStatus] = false;
	    EmergencyCalls[i][CallerRawTime] = gettime();
	    EmergencyCalls[i][callUnit][0] = EOS;
	    break;
	}

	SortDeepArray(EmergencyCalls, CallerRawTime, .order = SORT_DESC);
}

new PlayerCell[MAX_PLAYERS];
new bool:Unpackaging[MAX_PLAYERS char];
new bool:UI_Purchase[MAX_PLAYERS char];
new bool:HudStatus[MAX_PLAYERS char];

// Player TextDraws
new PlayerText:CharSelectionTD[MAX_PLAYERS][13];
new PlayerText:PTD_Restaurant[MAX_PLAYERS][9];
new PlayerText:TD_PhoneCoverModel[MAX_PLAYERS];

// Phone
new PlayerText:TDPhone_Model[MAX_PLAYERS][14];
new PlayerText:TDPhone_TFButton[MAX_PLAYERS];
new PlayerText:TDPhone_TSButton[MAX_PLAYERS];
new PlayerText:TDPhone_BigText[MAX_PLAYERS];
new PlayerText:TDPhone_ScreenText[MAX_PLAYERS];
new PlayerText:TDPhone_Signal[MAX_PLAYERS];
new PlayerText:TDPhone_Picture[MAX_PLAYERS];
new PlayerText:TDPhone_NotifyText[MAX_PLAYERS];
new PlayerText:TDPhone_Choice[MAX_PLAYERS][4];

// Color Selection
new
	PlayerText:ColorSelection[MAX_PLAYERS][8],
	PlayerText:ColorSelection2[MAX_PLAYERS][8],
	PlayerText:ColorSelectText[MAX_PLAYERS],
	PlayerText:ColorSelectLeft[MAX_PLAYERS],
	PlayerText:ColorSelectRight[MAX_PLAYERS],
	PlayerText:ColorSelectText2[MAX_PLAYERS],
	PlayerText:ColorSelectLeft2[MAX_PLAYERS],
	PlayerText:ColorSelectRight2[MAX_PLAYERS]
;

new PlayerText:pPT_Footer[MAX_PLAYERS];

// Business
new PlayerText:Store_Business[MAX_PLAYERS];
new PlayerText:Store_Header[MAX_PLAYERS];
new PlayerText:Store_Info[MAX_PLAYERS];
new PlayerText:Store_Cart[MAX_PLAYERS];
new PlayerText:Store_Items[MAX_PLAYERS][10];
new PlayerText:Store_Mask[MAX_PLAYERS];
new PlayerText:Store_UI[MAX_PLAYERS][20];

new PlayerText:MaskTD[MAX_PLAYERS];
new PlayerText:blindfold[MAX_PLAYERS];
new PlayerText:ALPR_Plate[MAX_PLAYERS];
new PlayerText:LicensesUI[MAX_PLAYERS][10];

new PlayerText:HudTextDraw[MAX_PLAYERS];

// Mobile Data Computer
new
	PlayerText:MDC_UI[MAX_PLAYERS][39],
	PlayerText:MDC_MenuUI[MAX_PLAYERS][6],
	PlayerText:MDC_VehicleUI[MAX_PLAYERS][4],

	PlayerText:MDC_ChargesUI[MAX_PLAYERS][41],
	PlayerText:MDC_LicensesUI[MAX_PLAYERS][37],
	PlayerText:MDC_PenalCodeUI[MAX_PLAYERS][40],
	PlayerText:MDC_PropertiesUI[MAX_PLAYERS][20],

	PlayerText:MDC_Emergency[MAX_PLAYERS][27],
	PlayerText:MDC_RosterUI[MAX_PLAYERS][24],
	PlayerText:MDC_VehicleBOLO[MAX_PLAYERS][11]
;

new
    // Vehicle UI
	PlayerText:PCARTextHeader[MAX_PLAYERS],
	PlayerText:PCARTextSlot[MAX_PLAYERS][6],
	PlayerText:PCARTextName[MAX_PLAYERS][6],
	PlayerText:PCARTextPrice[MAX_PLAYERS][6],
	PlayerText:PCARTextLeft[MAX_PLAYERS],
	PlayerText:PCARTextRight[MAX_PLAYERS],

	// Tuning
	PlayerText:TDTuning_Component[MAX_PLAYERS],
	PlayerText:TDTuning_Dots[MAX_PLAYERS],
	PlayerText:TDTuning_Price[MAX_PLAYERS],
	PlayerText:TDTuning_ComponentName[MAX_PLAYERS],
	PlayerText:TDTuning_YN[MAX_PLAYERS]
;

// Restaurant
new PCoverColor[MAX_PLAYERS];
new PCarPage[MAX_PLAYERS];
new PCarType[MAX_PLAYERS];

new bool:PRestaurantOpening[MAX_PLAYERS];
new bool:PCoverOpening[MAX_PLAYERS];
new bool:PCarOpening[MAX_PLAYERS char];

new
	ColorSelectShow[MAX_PLAYERS char],
    ColorSelectItem[MAX_PLAYERS],
	ColorSelectPage[MAX_PLAYERS],
	ColorSelectPages[MAX_PLAYERS],
	ColorSelect[MAX_PLAYERS] = -1,
	ColorSelectListener[MAX_PLAYERS][8],
	ColorSelectShow2[MAX_PLAYERS char],
    ColorSelectItem2[MAX_PLAYERS],
	ColorSelectPage2[MAX_PLAYERS],
	ColorSelectPages2[MAX_PLAYERS],
	ColorSelect2[MAX_PLAYERS] = -1,
	ColorSelectListener2[MAX_PLAYERS][8]
;

// Dealership
new VDealerSelectCatalog[MAX_PLAYERS];
new VDealerData[MAX_PLAYERS][6][5];
new VDealerSetting[MAX_PLAYERS char];
new VDealerVehicle[MAX_PLAYERS];
new VDealerBiz[MAX_PLAYERS];
new VDealerLock[MAX_PLAYERS];
new VDealerImmob[MAX_PLAYERS];
new VDealerAlarm[MAX_PLAYERS];
new VDealerPrice[MAX_PLAYERS];
new VDealerColor[MAX_PLAYERS][2];
new VDealerXM[MAX_PLAYERS];

new bool:PhoneOpen[MAX_PLAYERS char];

new ph_menuid[MAX_PLAYERS];
new ph_sub_menuid[MAX_PLAYERS];
new ph_selected[MAX_PLAYERS]; // GUI select id   0 - 3
new ph_select_data[MAX_PLAYERS];
new ph_call_string[MAX_PLAYERS][64];
new ph_data[MAX_PLAYERS][4];
new ph_page[MAX_PLAYERS]; // data of rows
new ph_airmode[MAX_PLAYERS];
new ph_silentmode[MAX_PLAYERS];
new bool:ph_speaker[MAX_PLAYERS char];
new ph_TextTone[MAX_PLAYERS];
new ph_CallTone[MAX_PLAYERS];

new LastWeapon[MAX_PLAYERS];

new LicenseOffer[MAX_PLAYERS];
new ViewingLicense[MAX_PLAYERS];

#define MAX_ATM_LIMIT 100
#define ATM_OBJECT 19324

enum ATM_DATA
{
	aID,
	aObject,
	Float:aPos[3],
	Float:aRot[3],
	CreatedBy[MAX_PLAYER_NAME]
}

new ATMS[MAX_ATM_LIMIT][ATM_DATA];
new EditingATM[MAX_PLAYERS];
new DeletingATM[MAX_PLAYERS char];
new BouttaDelete[MAX_PLAYERS];
new calltimer[MAX_PLAYERS];
new smstimer[MAX_PLAYERS];
new Tax = 0;
new TaxValue = 20;
new adTick[MAX_PLAYERS];
new DollaPickup[2];
new FarmerPickup;
new MechanicPickup;
//new Menu:Guide, Menu:GuideJob1, Menu:GuideJob2;
new CarRent[17];
new CarDMV[4];
new RentCarKey[MAX_PLAYERS];
new gLastCar[MAX_PLAYERS];
new gPassengerCar[MAX_PLAYERS];

native WP_Hash(buffer[], len, const str[]);

main()
{
	print("\n----------------------------------    ");
	print(" 	  Legacy Roleplay			   ");
	print("----------------------------------\n    ");

	//CreateGraffitis();
}

HoldingKey(playerid, key)
{
	new keys, ud, lr;
	GetPlayerKeys(playerid, keys, ud, lr);

	if(keys & key == key)
		return true;

	return false;
}

ClearGameTextColor(const string[])
{
	new aaa[256];

    new Regex:r = Regex_New("~.~");

    if(r)
    {
        Regex_Replace(string, r, "+", aaa, MATCH_DEFAULT, sizeof(aaa));

        Regex_Delete(r);
	}

	format(aaa, 256, "%s", str_replaceEx("+", aaa));
	return aaa;
}

enum
{
	DIALOG_DEFAULT,
	DIALOG_CONFIRM_SYS,
	DIALOG_MDC_NAME,
	DIALOG_MDC_PLATE,
	DIALOG_MDC_PLATE_LIST,
	DIALOG_MDC_CALLSIGN,
	DIALOG_FILTER_CHARGES,
	DIALOG_EDIT_BONE,
	DIALOG_DRUG_MENU,
	DIALOG_DRUG_AMOUNT,
	DIALOG_DRUG_TRANSFER,
	DIALOG_REFUND_DRUG,
	DIALOG_REFUND_STORAGE,
	DIALOG_REFUND_AMOUNT,
	TOLLS_DIALOG,
	TOLLS_DIALOG2,
};

new globalWeather = 2;

new CharSelection[MAX_PLAYERS][MAX_CHARACTERS];
new SelectedCharacter[MAX_PLAYERS];

enum scInfo
{
	scExist,
	scFaction,
	Text3D:scID,
	Float:scX,
	Float:scY,
	Float:scZ,
};

new SceneInfo[MAX_SCENES][scInfo];
new TotalPlayerDamages[MAX_PLAYERS];
new LoginAttempts[MAX_PLAYERS];
new DeathTimer[MAX_PLAYERS];
new DeathStamp[MAX_PLAYERS];
new CharacterCache[MAX_PLAYERS][6];
new VehicleCache[MAX_PLAYERS][6];
new BrokenLegTimer[MAX_PLAYERS];
new LastKnockout[MAX_PLAYERS];
new DeathReason[MAX_PLAYERS];
new LastDamageTime[MAX_PLAYERS];
new HelpUpTimer[MAX_PLAYERS];
new Text3D:KnockoutLabel[MAX_PLAYERS];
new HelpupStage[MAX_PLAYERS];
new HelpingPlayer[MAX_PLAYERS];
new SprayingFont[MAX_PLAYERS];
new SprayingType[MAX_PLAYERS];
new ServerTime;
new SelectedItem[MAX_PLAYERS];
new SelectedRadio[MAX_PLAYERS];
new LastSpawn[MAX_PLAYERS];
new LastTeleport[MAX_PLAYERS];
new LastTaserUsage[MAX_PLAYERS];
new ReadingPMs[MAX_PLAYERS][MAX_PLAYERS];
new BlockedPM[MAX_PLAYERS][MAX_PLAYERS];
new BlockedOOC[MAX_PLAYERS][MAX_PLAYERS];
new FactionPermissions[MAX_PLAYERS];
new ConnectStamp[MAX_PLAYERS];

new bool:DeathMode[MAX_PLAYERS char];
new bool:FirstSpawn[MAX_PLAYERS char];
new bool:TackleMode[MAX_PLAYERS char];
new bool:KnockedOut[MAX_PLAYERS char];
new bool:BrokenLeg[MAX_PLAYERS char];
new bool:ForceKnockout[MAX_PLAYERS char];
new bool:TesterColor[MAX_PLAYERS char];
new bool:FactionEars[MAX_PLAYERS char];
new bool:PrivateMessageEars[MAX_PLAYERS char];
new bool:EnableTP[MAX_PLAYERS char];
new bool:TimeTip[MAX_PLAYERS char];
new bool:SwitchingWeapon[MAX_PLAYERS char];
new bool:AdminDuty[MAX_PLAYERS char];
new bool:TesterDuty[MAX_PLAYERS char];
new bool:ShowMain[MAX_PLAYERS char];
new bool:HudShown[MAX_PLAYERS];
new bool:AccountChecked[MAX_PLAYERS char];
new bool:LoggedIn[MAX_PLAYERS char];
new bool:Spawned[MAX_PLAYERS char];
new bool:BeingKicked[MAX_PLAYERS char];
new bool:IsMasked[MAX_PLAYERS char];
new bool:IsTazed[MAX_PLAYERS char];
new bool:IsCuffed[MAX_PLAYERS char];
new bool:IsTied[MAX_PLAYERS char];
new bool:Blindfold[MAX_PLAYERS char];
new bool:EditingWeapon[MAX_PLAYERS char];
new bool:Convo[MAX_PLAYERS char];
new bool:AutoLow[MAX_PLAYERS char];
new bool:EditClothing[MAX_PLAYERS char];
new bool:BuyClothing[MAX_PLAYERS char];
new bool:PassingDrugs[MAX_PLAYERS char];
new bool:LessonStarted[MAX_PLAYERS char];
new bool:ReplacingGraffiti[MAX_PLAYERS char];
new bool:EditingGraffiti[MAX_PLAYERS char];
new bool:HUD_Created[MAX_PLAYERS char];
new bool:FinishedTutorial[MAX_PLAYERS char];
new bool:TagColor[MAX_PLAYERS char];

ReturnName(playerid, underscore = 1)
{
	static
	    name[MAX_PLAYER_NAME + 1]
	;

	GetPlayerName(playerid, name, sizeof(name));

	if(!underscore)
	{
	    if(IsMasked{playerid})
		{
            format(name, sizeof(name), "[Mask %i_%i]", PlayerData[playerid][pMaskID][0], PlayerData[playerid][pMaskID][1]);
        }
        else
		{
        	for(new i = 0, len = strlen(name); i < len; ++i) if(name[i] == '_') name[i] = ' '; // RP
        }
	}

	return name;
}

enum FLY_SPEC_DATA
{
	Float:CamPos[3],
	cObject,
	mdir,
	updownold,
	leftrightold,
	FlySpec,
	lastmove,
	fsobj,
	fspeed
};

new PfSpec[MAX_PLAYERS][FLY_SPEC_DATA];

/*enum TEMP_DATA
{
	tSkin,
	Float:tHealth,
	tInt,
	tVW,
	tVehID,
	tSeatID,
	Float:tmX,
	Float:tmY,
	Float:tmZ
};

new TempInfo[MAX_PLAYERS][TEMP_DATA];*/

new Float:HouseInteriorss[][] =
{
	{45.8963, 1439.5641, 1082.4120},
	{11.03331, 1314.19482, 1088.33093},
	{85.66241, 1280.42249, 1082.82739},
	{155.35648, 1409.17212, 1087.30750},
	{289.94763, 1509.23218, 1079.22510},
	{329.4253, 1512.9688, 1085.8153},
	//{382.01254, 1498.42480, 1080.69409},
	{390.1085, 1505.9377, 1080.0925},
	{366.74869, 1381.78625, 1080.31787},
	{448.67178, 1363.61853, 1083.28748},
	{506.95187, 1366.91003, 1080.07947},
	{755.25836, 1419.45801, 1102.58032},
	//{289.97849, 1289.53406, 1079.25183},
	{294.9620, 1285.4634, 1078.4471},
	{191.4332, 1289.2906, 1082.1399},
	{287.90448, 1249.52588, 1083.25146},
	{244.1906, 1145.7374, 1081.1672},
	{342.67169, 1081.66528, 1082.87891},
	{200.11450, 1119.56934, 1083.97693},
	{277.86502, 1069.62952, 1085.65552},
	{275.53461, 992.44232, 1087.27319},
	{2265.87500, -1122.75220, 1049.62781},
	{2281.78003, -1121.99768, 1049.92285},
	{2374.03271, -1102.76465, 1049.87073},
	{2318.45508, -1230.66187, 1048.40820},
	{2243.98071, -1024.30042, 1048.01758},
	{2260.93286, -1251.45007, 1051.05786},
	{2158.54736, -1220.96997, 1050.11694},
	{2364.22144, -1082.74231, 1048.01733},
	{2364.55444, -1179.42346, 1055.79187},
	{242.5794, 323.0403, 999.5914},
	{269.22012, 322.22049, 998.14349},
	{363.51450, 304.98868, 998.14722},
	{2177.35718, -1069.85181, 1049.47449},
	{2254.38940, -1108.71704, 1049.87268},
	{2293.09204, -1092.09229, 1049.62341}
};

Dialog:HouseInteriorss(playerid, response, listitem, inputtext[])
{
	if(!response) return true;

	SendClientMessageEx(playerid, -1, "Teleported to House Interior %d.", listitem + 1);

	SetPlayerDynamicPos(playerid, HouseInteriorss[listitem][0], HouseInteriorss[listitem][1], HouseInteriorss[listitem][2]);
	return true;
}

new HasCheckpoint[MAX_PLAYERS char];

enum M_INFO
{
	editedBy[MAX_PLAYER_NAME],
	editedDate[128]
};

new MotdINFO[M_INFO];

new MotdTEXT[5][256];

new TollsOpenCount;
//new TollsTaxed;
new TollsPayed;
//new TollsLocked;

forward UnFreezePlayer(playerid);
public UnFreezePlayer(playerid)
{
    TogglePlayerControllable(playerid, true);

    if(PlayerData[playerid][pInjured])
		ApplyAnimation(playerid, "WUZI", "CS_Dead_Guy", 4.1, 0, 1, 1, 1, 0, 1);

	return true;
}

new bool:FinishedDownloadingModels[MAX_PLAYERS char];
new bool:AnimationsPreloaded[MAX_PLAYERS char];
new TempWeapons[MAX_PLAYERS][3][2];
/*new TracingProgress[MAX_PLAYERS];
new TracingTowerData[MAX_PLAYERS][2];
new TraceTimer[MAX_PLAYERS];
new TraceString[MAX_PLAYERS][800];
new bool:Tracing[MAX_PLAYERS char];
new TraceGangzone[MAX_PLAYERS][2];*/
new EntranceArea[MAX_PLAYERS];
new CarNames[MAX_PLAYERS][6][64];
new PlayerSerial[MAX_PLAYERS][50];
new LastSerial[MAX_PLAYERS][50];
new LastLogin[MAX_PLAYERS];
new EquipTimer[MAX_PLAYERS];

new GlobalHour, GlobalMinute;

enum Request_Data
{
	bool:requestActive,
	requestPlayer,
	requestCar,
	requestName[64],
	requestStamp[60]
};

new VehicleRequests[100][Request_Data];

#define MAX_REPORTS 100

enum e_Report_Data
{
	reportBy,
	reportPlayer,
	reportReason[128]
}

new Reports[MAX_REPORTS][e_Report_Data];

#define MAX_FRIENDS 100
#define LOGIN_SOUND 5205

enum FRIEND_DATA
{
	friendID,
	friendName[MAX_PLAYER_NAME]
}
new Friends[MAX_PLAYERS][MAX_FRIENDS][FRIEND_DATA];

new bool:ToggleNames[MAX_PLAYERS char];
new BreakingIn[MAX_PLAYERS];

#define MAX_ADMIN_ACTIONS 10

enum a_Action_Data
{
	actionID,
	actionText[256],
	actionAdmin[MAX_PLAYER_NAME]
};

new AdminActions[MAX_PLAYERS][MAX_ADMIN_ACTIONS][a_Action_Data];

#define ONFOOT_DISTANCE 50.0
#define VEHICLE_DISTANCE 50.0

new Float:s_AirbreakLastCoords[MAX_PLAYERS][3], p_UpdateTick[MAX_PLAYERS];

AB_IsVehicleMoving(vehicleid)
{
	new
	    Float:x,
	    Float:y,
	    Float:z;

	GetVehicleVelocity(vehicleid, x, y, z);

	return (!(floatabs(x) <= 0.001 && floatabs(y) <= 0.001 && floatabs(z) <= 0.005));
}

enum
{
	HACKS_TYPE_AIRBREAK = 0,
	HACKS_TYPE_WEAPON,
	HACKS_TYPE_FLY,
	HACKS_TYPE_SPEED,
	HACKS_TYPE_NOP,
	HACKS_TYPE_TELEPORT,
	HACKS_TYPE_HEALTH
};

new LastCheatDetection[MAX_PLAYERS][10];

enum e_Player_Logs
{
	searchingPlayer,
	searchingSQLID,
	searchingName[MAX_PLAYER_NAME],
	searchingFilter[64],
	searchingOffset
};

new PlayerLogs[MAX_PLAYERS][e_Player_Logs];
new ViewingParticle[MAX_PLAYERS];
new RemovingParticle[MAX_PLAYERS];

enum APB_DATA
{
	bool:Exists,
	Creator[MAX_PLAYER_NAME],
	Department[10],
	Description[128],
	Charges[60],
	Stamp
};

new APB[100][APB_DATA];

enum e_CORPSE_DATA
{
	bool:corpseSpawned,
	corpseActor,
	corpseMinutes,
	corpseName[MAX_PLAYER_NAME]
};

new CORPSES[MAX_PLAYERS][e_CORPSE_DATA];

enum TOLL_INFO
{
	E_tLocked,  // 0 & 1 = Richhman, 2 & 3 = Flint, 4 & 5 = LV, 6 & 7 = BlueBerry right
	E_tOpenTime // 0 & 1 = Richhman, 2 & 3 = Flint, 4 & 5 = LV, 6 & 7 = BlueBerry right
};

new aTolls[MAX_TOLLS][TOLL_INFO];

new L_a_RequestAllowedCop, L_a_Pickup[MAX_TOLLS * 2], L_a_TollObject[MAX_TOLLS * 2]; // 0 & 1 = Richhman, 2 & 3 = Flint, 4 & 5 = LV, 6 & 7 = BlueBerry right

new PlayerStates[10][20] =
{
	"NONE",
	"ON FOOT",
	"FRONT SEAT",
	"PASSENGER",
	"NONE",
	"NONE",
	"NONE",
	"NONE",
	"SPAWNED",
	"SPECTATING"
};

// Toggles
enum e_SETTINGS_DATA
{
	toggleHUD,
	factionChat,
	toggleOOC,
	toggleNews,
	joinAlerts,
	adminAlerts
};

new bool:PlayerFlags[MAX_PLAYERS][e_SETTINGS_DATA];

enum
{
	SPRAY_TYPE_ON = 0,
	SPRAY_TYPE_CLEANING_START,
	SPRAY_TYPE_CLEANING_END
}

#define MAX_MARKERS 4

enum MARKER_DATA
{
	Float:markerPos[3]
}

new Markers[MAX_PLAYERS][MAX_MARKERS][MARKER_DATA];
new WatchRadio[MAX_PLAYERS];
new RequestedToShake[MAX_PLAYERS][3];
new ParticleOffset[MAX_PLAYERS];
new LastAnnotation[MAX_PLAYERS];
new UpdatingMOTD[MAX_PLAYERS];
new UnpackageTimer[MAX_PLAYERS];

// Modules

new Iterator:sv_vehicles<MAX_VEHICLES>;
new Iterator:Movedoors<MAX_MOVEDOORS>;
new Iterator:Gates<MAX_GATES>;
new Iterator:sv_activevehicles<MAX_VEHICLES>;

#include "modules/Zones.pwn"
#include "modules/system/Chat.pwn"
#include "modules/Business.pwn"
#include "modules/Property.pwn"
//#include "modules/Garage.pwn"
#include "modules/system/Particles.pwn"
#include "modules/system/Points.pwn"
#include "modules/vehicle/Server.pwn"
#include "modules/vehicle/Player.pwn"
#include "modules/vehicle/Functions.pwn"
#include "modules/vehicle/Modshop.pwn"
#include "modules/Industry.pwn"
#include "modules/Furniture.pwn"
#include "modules/Drugs.pwn"
#include "modules/Weapons.pwn"
#include "modules/Death.pwn"
#include "modules/Clothing.pwn"
#include "modules/player/Account.pwn"
#include "modules/Faction.pwn"
#include "modules/Graffiti.pwn"
#include "modules/Phone.pwn"
#include "modules/Store.pwn"
#include "modules/MobileDataComputer.pwn"
#include "modules/VehicleParts.pwn"
#include "modules/timers/Server.pwn"
#include "modules/timers/Player.pwn"
#include "modules/timers/Vehicle.pwn"
#include "modules/Anticheat.pwn"
#include "modules/Interface.pwn"
#include "modules/Prison.pwn"
#include "modules/PlayerCommands.pwn"
#include "modules/AdminCommands.pwn"
#include "modules/TesterCommands.pwn"
#include "modules/Animations.pwn"
#include "modules/Queries.pwn"
#include "modules/Textdraws.pwn"
#include "modules/police/Fines.pwn"

public OnGameModeInit()
{
	mysql_log(ERROR);

	SQL_Connect();
    SetupIndustry();

	mysql_tquery(dbCon, "SELECT * FROM `factions` ORDER BY `factionID` ASC", "Faction_Load", "");
	mysql_tquery(dbCon, "SELECT * FROM `factionspawns`", "FactionSpawn_Load", "");
	mysql_tquery(dbCon, "SELECT * FROM `business`", "Bizz_Load", "");
    mysql_tquery(dbCon, "SELECT * FROM `signal_tower`", "Signal_Load", "");
    mysql_tquery(dbCon, "SELECT * FROM `vehicles`", "Vehicle_Load", "");
	mysql_tquery(dbCon, "SELECT * FROM `ateles`", "DynamicTele_Load", "");
	mysql_tquery(dbCon, "SELECT * FROM `industry` ORDER BY `industryid` ASC", "Industry_Load", "");
	mysql_tquery(dbCon, "SELECT * FROM `gates`", "Gates_Load", "");
	mysql_tquery(dbCon, "SELECT * FROM `movedoors`", "Movedoor_Load", "");
	mysql_tquery(dbCon, "SELECT * FROM `apartments`", "Apartment_Load", "");
	mysql_tquery(dbCon, "SELECT * FROM `points`", "Points_Load", "");
	mysql_tquery(dbCon, "SELECT * FROM `atms`", "LoadATMS");
	mysql_tquery(dbCon, "SELECT * FROM `houses`", "House_Load", "");
	mysql_tquery(dbCon, "SELECT * FROM `particles`", "Particle_Load", "");
	mysql_tquery(dbCon, "SELECT * FROM `spraylocations`", "Graffitis_Load");
	mysql_tquery(dbCon, "SELECT * FROM `motd` LIMIT 1", "LoadMOTD");
	mysql_tquery(dbCon, "UPDATE characters SET Online = 0 WHERE Online = 1");
    mysql_tquery(dbCon, "UPDATE accounts SET Online = 0 WHERE Online = 1");

    #include "modules/mapping/Misc.pwn"
    #include "modules/mapping/Main.pwn"

	#include "modules/mapping/prison/Block.pwn"
	#include "modules/mapping/prison/Hallway.pwn"
	#include "modules/mapping/prison/Chapel.pwn"
	#include "modules/mapping/prison/Library.pwn"

    #include "modules/mapping/Properties.pwn"
    #include "modules/mapping/Tolls.pwn"
    #include "modules/mapping/Ship.pwn"
    #include "modules/mapping/Pickups.pwn"

    SendRconCommand("hostname "SERVER_NAME"");
    SendRconCommand("weburl "SERVER_SITE"");
    SendRconCommand("mapname San Andreas");

    SetNameTagDrawDistance(20.0);
	SetGameModeText(SERVER_MODE);
	gettime(ghour, gminute, gsecond);
	FixHour(ghour);
	ghour = shifthour;
	SetWorldTime(ghour);

    AllowInteriorWeapons(1);
	ManualVehicleEngineAndLights();
	DisableInteriorEnterExits();
	EnableStuntBonusForAll(0);
	
	Streamer_TickRate(60);
	Streamer_VisibleItems(STREAMER_TYPE_OBJECT, 1000);

    Command_SetDeniedReturn(true);

	ResetGlobalVariables();

	MDC_Global_Cache[PoliceCalls] = 0;
	MDC_Global_Cache[Arrests] = 0;
	MDC_Global_Cache[Fines] = 0;
	MDC_Global_Cache[MedicCalls] = 0;

	GlobalHour = 00;
	GlobalMinute = 00;

	CreateTextLabels();
	CreateGlobalTextDraws();
	CreateRentalVehicles();
	CreateLicenseVehicles();
	CreatePenalCode();

	CreateDynamicPickup(1314, 23, 1481.0662, -1771.3069, 18.7958, 0, 0); // City Hall

    systemVariables[OOCStatus] = 1;

	ServerTime = gettime();
	return true;
}

public OnGameModeExit()
{
	mysql_close(dbCon);

    /*for(new i = 0; i < NUM_SHIP_ATTACHMENTS; ++i)
	{
	    DestroyObject(gShipsAttachments[i]);
	}

    DestroyObject(gMainShipObjectId);*/
	return true;
}

public OnPlayerConnect(playerid)
{
	FinishedDownloadingModels{playerid} = false;
	AnimationsPreloaded{playerid} = false;

  	RemoveBuilding(playerid);
  	CreateTextdraws(playerid);
	SetPlayerWeather(playerid, globalWeather);

    SetPlayerColor(playerid, COLOR_GRAD2);

	ResetPlayerWeapons(playerid);
	SetPlayerArmedWeapon(playerid, 0);

    ResetStatistics(playerid);

    ConnectStamp[playerid] = gettime();

    GetPlayerIp(playerid, PlayerData[playerid][pIP], 16);
    format(PlayerSerial[playerid], 50, ReturnCI(playerid));

    SQL_LogConnection(playerid);
    SQL_CheckAccount(playerid);
	return true;
}

public OnPlayerDisconnect(playerid, reason)
{
	new str[128], szDisconnectReason[3][10] = {"Timeout", "Leaving", "Kicked"};

	format(str, sizeof(str), "** %s (%s)", ReturnName(playerid), szDisconnectReason[reason]);
	ProxDetector(playerid, 20.0, str);

 	format(str, sizeof str, "*** %s Left the server (%s)", ReturnName(playerid), szDisconnectReason[reason]);
    ProxJoinServer(playerid, str);

	if(reason == 0) PlayerData[playerid][pTimeout] = gettime();

    printf("[session] The session lasted %s.", HowLongAgo(gettime() - ConnectStamp[playerid]));

 	TerminateConnection(playerid, reason);
	return true;
}

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
    if(weaponid < 22 || weaponid > 38)
		return false;

    if(hittype != BULLET_HIT_TYPE_NONE) // Bullet Crashing uses just this hittype
    {
        if( !( -1000.0 <= fX <= 1000.0 ) || !( -1000.0 <= fY <= 1000.0 ) || !( -1000.0 <= fZ <= 1000.0 ) ) // a valid offset, it's impossible that a offset bigger than 1000 is legit (also less than -1000.0 is impossible, not used by this hack, but still, let's check for it, just for the future, who knows what hacks will appear). The object with biggest offset is having ~700-800 radius.
        {
            Kick(playerid);
            return false; // let's desynchronize that bullet, so players won't crash
        }
    }

	if(PlayerData[playerid][pAdmin] == 1337)
	{
	    if(weaponid == 23 && ParticleSettings[playerid][usingParticle] && ParticleSettings[playerid][particleOperation] == PARTICLE_MODE_CREATE)
	    {
	        if(hittype == BULLET_HIT_TYPE_OBJECT)
	            return SendErrorMessage(playerid, "If you're trying to create a particle, don't shoot another object.");

		    if(ParticleSettings[playerid][particleEditID] != -1)
		    	return SendErrorMessage(playerid, "You're currently editing another particle, finish with that first.");

	        new free_slot = -1;

	        for(new i = 0; i < MAX_PARTICLES; ++i)
	        {
	            if(Particles[i][particleSQLID] == -1)
	            {
	                free_slot = i;
	                break;
	            }
	        }

	        if(free_slot == -1) return SendErrorMessage(playerid, "You can't create any more particles as per the currenct limit (%d).", MAX_PARTICLES);

	        Particles[free_slot][particleObject] = CreateDynamicObject(ParticleSettings[playerid][particleObjectID], fX, fY, fZ, 0.00, 0.00, 0.00);

	        if(IsValidDynamicObject(Particles[free_slot][particleObject]))
	        {
	            Particles[free_slot][particleSQLID] = 999;

	            Particles[free_slot][particleModel] = ParticleSettings[playerid][particleObjectID];
	            format(Particles[free_slot][particleCreator], MAX_PLAYER_NAME, ReturnName(playerid));
	            Particles[free_slot][particleStamp] = gettime();

	            Streamer_Update(playerid, STREAMER_TYPE_OBJECT);

				new queryString[256];
	    		mysql_format(dbCon, queryString, sizeof(queryString), "INSERT INTO particles (Creator, Model, PosX, PosY, PosZ, Stamp) VALUES ('%s', %d, %f, %f, %f, %d)", Particles[free_slot][particleCreator], Particles[free_slot][particleModel], fX, fY, fZ, Particles[free_slot][particleStamp]);
	            new Cache:cache = mysql_query(dbCon, queryString);

				Particles[free_slot][particleSQLID] = cache_insert_id();

				cache_delete(cache);

				SendClientMessageEx(playerid, COLOR_YELLOW, "-> Particle successfully created with dbid #%d.", Particles[free_slot][particleSQLID]);

				if(ParticleSettings[playerid][particleEditMode])
				{
				    ParticleSettings[playerid][particleEditID] = free_slot;
				    Particles[free_slot][particleEdit] = true;

				    EditDynamicObject(playerid, Particles[free_slot][particleObject]);
				}
	        }
	        else
	        {
	            Particles[free_slot][particleObject] = INVALID_OBJECT_ID;

	            SendErrorMessage(playerid, "You have specified an invalid object ID, update it using the /particlegun menu.");
	        }
	        return false;
	    }
	}

	if(PlayerData[playerid][pLocal] != 255)
	{
		if(InProperty[playerid] != -1)
		{
			new i = InProperty[playerid];

			if((gettime() - PropertyData[i][hShootingTimer]) >= 180)
			{
				PropertyData[i][hShootingTimer] = gettime();
			
				new street[60];
				Get2DPosZone(PropertyData[i][hEntranceX], PropertyData[i][hEntranceY], street, MAX_ZONE_NAME);

				foreach (new x : Player)
				{
					if(InProperty[x] == i) continue;

					if(IsPlayerInRangeOfPoint(x, 30.0, PropertyData[i][hEntranceX], PropertyData[i][hEntranceY], PropertyData[i][hEntranceZ]))
					{
						SendClientMessageEx(x, COLOR_PURPLE, "* [%d %s] A gun goes off inside and the shot being fired is heard.", PropertyData[i][hID], street);
					}
				}
			}
		}

		if(InApartment[playerid] != -1)
		{
			new i = InApartment[playerid];

			if((gettime() - ComplexData[i][aShootingTimer]) >= 180)
			{
				ComplexData[i][aShootingTimer] = gettime();
			
				new street[60];
				Get2DPosZone(ComplexData[i][aEntranceX], ComplexData[i][aEntranceY], street, MAX_ZONE_NAME);

				foreach (new x : Player)
				{
					if(InApartment[x] == i) continue;

					if(IsPlayerInRangeOfPoint(x, 30.0, ComplexData[i][aEntranceX], ComplexData[i][aEntranceY], ComplexData[i][aEntranceZ]))
					{
						SendClientMessageEx(x, COLOR_PURPLE, "* [%d %s] A gun goes off inside and the shot being fired is heard.", ComplexData[i][aID], street);
					}
				}
			}
		}

		if(InBusiness[playerid] != -1)
		{
			new i = InBusiness[playerid];

			if((gettime() - BusinessData[i][bShootingTimer]) >= 180)
			{
				BusinessData[i][bShootingTimer] = gettime();
			
				foreach (new x : Player)
				{
					if(InBusiness[x] == i) continue;

					if(IsPlayerInRangeOfPoint(x, 30.0, BusinessData[i][bEntranceX], BusinessData[i][bEntranceY], BusinessData[i][bEntranceZ]))
					{
						SendClientMessageEx(x, COLOR_PURPLE, "* [%s] A gun goes off inside and the shot being fired is heard.", ClearGameTextColor(BusinessData[i][bInfo]));
					}
				}
			}
		}
	}

	if(PlayerData[playerid][pFaction] != -1) 
	{
		if((BeanbagActive{playerid} == true && weaponid == 25) || (TazerActive{playerid} == true && weaponid == 23) || (LessLethalActive{playerid} == true && weaponid == 33))
		{
			if(weaponid == 23)
			{
				if(GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK) ApplyAnimation(playerid, "COLT45", "colt45_reload", 4.0, 0, 0, 0, 0, 0, 1);
				else ApplyAnimation(playerid, "COLT45", "colt45_crouchreload", 4.0, 0, 1, 1, 0, 0, 1);
			}
			else if(weaponid == 25)
			{
				if(GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK) ApplyAnimation(playerid, "BUDDY", "buddy_reload", 4.0, 0, 0, 0, 0, 0, 1);
				else ApplyAnimation(playerid, "BUDDY", "buddy_crouchreload", 4.0, 0, 1, 1, 0, 0, 1);
			}

			if(hittype == BULLET_HIT_TYPE_PLAYER)
			{
				if(GetPlayerAnimationIndex(hitid) == 1209) return false;

				if(TazerActive{playerid} && weaponid == 23)
				{
					if((gettime() - LastTaserUsage[playerid]) < 5)
					{
						SendNoticeMessage(playerid, "You must wait 5 seconds until you can tase someone again!");
						return 0;
					}

					if(!IsPlayerNearPlayer(playerid, hitid, 7.0))
					{
						SendNoticeMessage(playerid, "Your taser hit, but was ineffective against the subject.");
						return 0;
					}

					LastTaserUsage[playerid] = gettime();

					SetPlayerDrunkLevel(hitid, 4000);
					TogglePlayerControllable(hitid, 1);

					SendNearbyMessage(hitid, 20.0, COLOR_PURPLE, "* %s falls on the ground after being hit by %s's taser.", ReturnName(hitid, 0), ReturnName(playerid, 0));
					GameTextForPlayer(hitid, "~b~You Are Tasered", 2500, 3);

					SendNoticeMessage(hitid, "You have been tazed. Your character would be paralyzed for a few seconds and then become very dizzy.");

					ClearAnimations(hitid, 1);
					TogglePlayerControllable(hitid, 0);

					IsTazed{hitid} = true;

					SetTimerEx("OnPlayerTasered", 800, false, "i", hitid); //1200
					return false;
				}
				else if(BeanbagActive{playerid} && weaponid == 25)
				{
					if(!IsPlayerNearPlayer(playerid, hitid, 10.0))
					{
						SendClientMessageEx(playerid, COLOR_YELLOW, "-> You aren't close enough to hit %s with your beanbag.", ReturnName(hitid, 0));
						return 0;
					}

					SetPlayerDrunkLevel(hitid, 4000);
					TogglePlayerControllable(hitid, 1);

					SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s was hit by a rubber bullet and falls on the ground", ReturnName(hitid, 0));
					SendClientMessageEx(playerid, COLOR_YELLOW, "HINT: You hit %s with a rubber bullet!", ReturnName(hitid, 0));

					ClearAnimations(hitid, 1);
					TogglePlayerControllable(hitid, 0);

					IsTazed{hitid} = true;

					SetTimerEx("OnPlayerTasered", 800, false, "i", hitid); //1200
					return false;
				}
				else if(LessLethalActive{playerid} && weaponid == 33)
				{
					SetPlayerDrunkLevel(hitid, 4000);
					TogglePlayerControllable(hitid, 1);

					SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s was hit by %s's 40mm Less Lethal Launcher and is jolted back.", ReturnName(hitid, 0), ReturnName(playerid, 0));
					SendClientMessageEx(playerid, COLOR_YELLOW, "HINT: You hit %s with a 40mm Less Lethal Launcher!", ReturnName(hitid, 0));

					ClearAnimations(hitid, 1);
					TogglePlayerControllable(hitid, 0);

					IsTazed{hitid} = true;

					SetTimerEx("OnPlayerTasered", 800, false, "i", hitid); //1200
					return false;
				}
			}
			return false;
		}
	}

	new slot = ReturnWeaponSlot(weaponid), raw_slot = g_aWeaponSlots[weaponid], weapons[2];

	if(!PlayerData[playerid][pWeapon][slot] || PlayerData[playerid][pWeapon][slot] != weaponid)
	{
		if((weaponid > 0 && weaponid < 41) && !deleyAC_Nop{playerid} && !PlayerData[playerid][pInjured] && !IsParticleGun(playerid, weaponid))
		{
			GetPlayerWeaponData(playerid, raw_slot, weapons[0], weapons[1]);

			OnPlayerWeaponHack(playerid, weaponid, weapons[1] - 1, 5);

			RemoveWeaponOnly(playerid, weaponid);
			SetPlayerArmedWeapon(playerid, 0);
		}
		return false;
	}

	PlayerData[playerid][pAmmo][raw_slot]--;
	PlayerData[playerid][pAmmunation][slot]--;

	GetPlayerWeaponData(playerid, raw_slot, weapons[0], weapons[1]);

	if((weaponid == 22 || weaponid == 28 || weaponid == 29 || weaponid == 32) && PlayerData[playerid][pAmmo][raw_slot] != (weapons[1] - 1))
	{
		PlayerData[playerid][pAmmo][raw_slot] = weapons[1] - 1;
		PlayerData[playerid][pAmmunation][slot] = weapons[1] - 1;
	}

	if(!PlayerData[playerid][pAmmunation][slot])
	{
		PlayerData[playerid][pWeapon][slot] = 0;
		PlayerData[playerid][pAmmunation][slot] = 0;

		PlayerData[playerid][pGuns][raw_slot] = 0;
		PlayerData[playerid][pAmmo][raw_slot] = 0;

		cl_DressHoldWeapon(playerid, GetPlayerWeapon(playerid));
	}
	else
	{
		if(weaponid != 38 && weapons[1] != 0 && PlayerData[playerid][pAmmunation][slot] != weapons[1] && !deleyAC_Nop{playerid} && !PlayerData[playerid][pInjured] && !IsParticleGun(playerid, weaponid))
		{
			new bool:hacking = false;

			if(PlayerData[playerid][pAmmunation][slot] > weapons[1])
			{
			    if((PlayerData[playerid][pAmmunation][slot] - weapons[1]) > 3)
				{
					hacking = true;
				}
			}
			else if(weapons[1] > PlayerData[playerid][pAmmunation][slot])
			{
				if((weapons[1] - PlayerData[playerid][pAmmunation][slot]) > 3)
				{
					hacking = true;
				}
			}

			if(hacking)
			{
				OnPlayerAmmoHack(playerid, weaponid, weapons[1], PlayerData[playerid][pAmmunation][slot], 3);

				SetPlayerWeapons(playerid);
				SetPlayerArmedWeapon(playerid, 0);
			}
		}
	}

	if(hittype == BULLET_HIT_TYPE_VEHICLE)
	{
	    CoreVehicles[hitid][vHitStamp] = gettime();
	}
    return true;
}

public OnPlayerGiveDamage(playerid, damagedid, Float: amount, weaponid, bodypart)
{
    if(PlayerData[playerid][pInjured] || LegalWeaponCheck(playerid, weaponid) || IsParticleGun(playerid, weaponid) || weaponid == 41) return false;

  	if(damagedid != INVALID_PLAYER_ID)
	{
		if(AdminDuty{damagedid} || DeathMode{damagedid}) return false;

		if(weaponid > 0)
		{
			if(PlayerData[playerid][pGuns][g_aWeaponSlots[weaponid]] != weaponid) // Hacked Weapons will have no effect
			{
				return false;
			}
		}
		else
		{
			if(TackleMode{playerid})
			{
				if(AdminDuty{damagedid})
				{
					SendNoticeMessage(playerid, "You can't tackle admins on duty.");
					return false;
				}

				TacklePlayer(playerid, damagedid);
				return false;
			}			
		}

		switch(weaponid)
		{
		    case 0:
			{
				//registered gta damage
			}
		    case 25, 27:
			{
				amount = amount + WeaponDamage[weaponid][WepDamage]; //registered gta damage + script damage
			}
		    default:
			{
				amount = WeaponDamage[weaponid][WepDamage]; //script damage
			}
		}

		DeathReason[damagedid] = weaponid;
		LastDamageTime[damagedid] = gettime();

		new Float: health = PlayerData[damagedid][pHealth], Float: armour = PlayerData[damagedid][pArmour], bool: armourhit = false;

		if(!PlayerData[damagedid][pInjured] && !KnockedOut{damagedid} && IsActualGun(weaponid))
		{
			switch(bodypart)
			{
			    case BODY_PART_CHEST, BODY_PART_GROIN: armourhit = true;

				case BODY_PART_LEFT_ARM, BODY_PART_RIGHT_ARM:
				{
				    new chance = random(3);

				    if(chance == 1) armourhit = true;
				}

				case BODY_PART_LEFT_LEG, BODY_PART_RIGHT_LEG:
				{
				    amount = amount / 2;

				    if(random(2))
				    {
						BrokenLeg{damagedid} = true;

						SendClientMessage(damagedid, COLOR_LIGHTRED, "-> You've been hit in the leg, you're gonna struggle with running and jumping.");

						BrokenLegTimer[damagedid] = LastDamageTime[damagedid];
				    }
				}

				case BODY_PART_HEAD:
				{
					if(!PlayerData[damagedid][pSwat])
					{
					    amount += float(floatround(amount / 2, floatround_ceil));
					}
				}
			}

			if(PlayerData[damagedid][pSwat] && bodypart != BODY_PART_HEAD) armourhit = true;
		}

		if(amount < 1) amount = 1;

		if(PlayerData[damagedid][pInjured] && !KnockedOut{damagedid})
		{
			if(DeathTimer[damagedid] <= 117)
			{
				MakePlayerDead(damagedid);
			}
			return true;
		}
		else
		{
			if(armour > 0 && armourhit)
			{
	            if(armour > amount)
				{
					SetPlayerArmourEx(damagedid, armour - amount);
				}
	            else
	            {
	                SetPlayerArmourEx(damagedid, 0.0);
	                
	                health -= (amount - armour);
	            }
			}
			else
			{
				health -= amount;
			}

			CallbackDamages(damagedid, playerid, bodypart, weaponid, amount, armour);

			if(health >= 11 && health <= 30)
			{
				SetPlayerSkillLevel(damagedid, WEAPONSKILL_PISTOL, 200);
				SetPlayerSkillLevel(damagedid, WEAPONSKILL_PISTOL_SILENCED, 500);
				SetPlayerSkillLevel(damagedid, WEAPONSKILL_DESERT_EAGLE, 200);
				SetPlayerSkillLevel(damagedid, WEAPONSKILL_SHOTGUN, 200);
				SetPlayerSkillLevel(damagedid, WEAPONSKILL_SAWNOFF_SHOTGUN, 200);
				SetPlayerSkillLevel(damagedid, WEAPONSKILL_SPAS12_SHOTGUN, 200);
				SetPlayerSkillLevel(damagedid, WEAPONSKILL_MICRO_UZI, 50);
				SetPlayerSkillLevel(damagedid, WEAPONSKILL_MP5, 250);
				SetPlayerSkillLevel(damagedid, WEAPONSKILL_AK47, 200);
				SetPlayerSkillLevel(damagedid, WEAPONSKILL_M4, 200);
				SetPlayerSkillLevel(damagedid, WEAPONSKILL_SNIPERRIFLE, 300);

				SendClientMessage(damagedid, COLOR_LIGHTRED, "-> Low health, shooting skills at medium.");
			}
 			if(health <= 10)
			{
				SetPlayerSkillLevel(damagedid, WEAPONSKILL_PISTOL, 0);
				SetPlayerSkillLevel(damagedid, WEAPONSKILL_PISTOL_SILENCED, 100);
				SetPlayerSkillLevel(damagedid, WEAPONSKILL_DESERT_EAGLE, 100);
				SetPlayerSkillLevel(damagedid, WEAPONSKILL_SHOTGUN, 100);
				SetPlayerSkillLevel(damagedid, WEAPONSKILL_SAWNOFF_SHOTGUN, 100);
				SetPlayerSkillLevel(damagedid, WEAPONSKILL_SPAS12_SHOTGUN, 100);
				SetPlayerSkillLevel(damagedid, WEAPONSKILL_MICRO_UZI, 0);
				SetPlayerSkillLevel(damagedid, WEAPONSKILL_MP5, 100);
				SetPlayerSkillLevel(damagedid, WEAPONSKILL_AK47, 100);
				SetPlayerSkillLevel(damagedid, WEAPONSKILL_M4, 100);
				SetPlayerSkillLevel(damagedid, WEAPONSKILL_SNIPERRIFLE, 100);

				SendClientMessage(damagedid, COLOR_LIGHTRED, "-> Critical low health, shooting skills at minimum.");
			}

			if(health < 1)
			{
	   			DeathTimer[damagedid] = 120;
				PlayerData[damagedid][pInjured] = 1;
				PlayerData[damagedid][pInterior] = GetPlayerInterior(damagedid);
				PlayerData[damagedid][pWorld] = GetPlayerVirtualWorld(damagedid);
				GetPlayerPos(damagedid, PlayerData[damagedid][pPos][0], PlayerData[damagedid][pPos][1], PlayerData[damagedid][pPos][2]);
				GetPlayerFacingAngle(damagedid, PlayerData[damagedid][pPos][3]);

				if(IsVehicleDeath(damagedid))
				{
				    TogglePlayerControllable(damagedid, false);

				    if(GetPlayerState(damagedid) == PLAYER_STATE_DRIVER)
					{
						SetEngineStatus(GetPlayerVehicleID(damagedid), false);
					}

					MakePlayerWounded(damagedid, playerid, true, weaponid);
				}
				else
				{
					MakePlayerWounded(damagedid, playerid, false, weaponid);
				}

				SetPlayerHealthEx(damagedid, 40.0, false);
				SQL_LogPlayerDeath(damagedid, playerid, weaponid);
			}
			else SetPlayerHealthEx(damagedid, health, false);

			return true;
		}
    }

    return true;
}

public OnPlayerTakeDamage(playerid, issuerid, Float: amount, weaponid, bodypart)
{
	if(playerid == INVALID_PLAYER_ID)
	{
		return false;
	}

	if(issuerid != INVALID_PLAYER_ID)
	{
		return false; // Player damage gets handled by OnPlayerGiveDamage
	}

	if(AdminDuty{playerid})
	{
	    SetPlayerHealth(playerid, PlayerData[playerid][pHealth]);
	    return false;
	}

	PlayerData[playerid][pHealth] -= amount;
    return true;
}

SetPlayerHealthEx(playerid, Float:hp, bool:updateskill = true)
{
	if(hp > MAX_SERVER_HEALTH) return true;

	if(updateskill)
	{
		if(hp <= 10) SetPlayerWeaponSkill(playerid, NORMAL_SKILL);
	 	else if(hp >= 11 && hp <= 30) SetPlayerWeaponSkill(playerid, MEDIUM_SKILL);
		else SetPlayerWeaponSkill(playerid, FULL_SKILL);
	}

	PlayerData[playerid][pHealth] = hp;
	return SetPlayerHealth(playerid, hp);
}

SetPlayerArmourEx(playerid, Float:amount)
{
	PlayerData[playerid][pArmour] = amount;
	return SetPlayerArmour(playerid, amount);
}

SetPlayerInteriorEx(playerid, interior)
{
	PlayerData[playerid][pInterior] = interior;
	SetPlayerInterior(playerid, interior);
}

SetPlayerVirtualWorldEx(playerid, world)
{
	PlayerData[playerid][pWorld] = world;
	SetPlayerVirtualWorld(playerid, world);
}

SetPlayerPosEx(playerid, Float:x, Float:y, Float:z, time = 5000)
{
	if(PlayerData[playerid][pFreeze])
	{
	    KillTimer(PlayerData[playerid][pFreezeTimer]);
	    PlayerData[playerid][pFreeze] = 0;

	    TogglePlayerControllable(playerid, true);
	}

	PlayerData[playerid][pFreeze] = 1;

	SetPlayerDynamicPos(playerid, x, y, z); // + 0.5
	TogglePlayerControllable(playerid, false);

	PlayerData[playerid][pFreezeTimer] = SetTimerEx("SetPlayerToUnfreeze", time, false, "dfff", playerid, x, y, z);
	return true;
}

SetVehicleDynamicPos(vehicleid, Float:x, Float:y, Float:z, playerid)
{
    LastTeleport[playerid] = gettime();

    SetVehiclePos(vehicleid, x, y, z);
}

SetPlayerDynamicPos(playerid, Float:x, Float:y, Float:z)
{
	LastTeleport[playerid] = gettime();

    SetPlayerPos(playerid, x, y, z);
}

forward SetPlayerToUnfreeze(playerid, Float:x, Float:y, Float:z);
public SetPlayerToUnfreeze(playerid, Float:x, Float:y, Float:z)
{
	if(!IsPlayerConnected(playerid))
	    return false;

	if(!SQL_IsLogged(playerid) || PlayerData[playerid][pID] == -1 || !Spawned{playerid})
	    return false;

	if(!PlayerData[playerid][pFreeze])
	    return false;

	PlayerData[playerid][pFreeze] = 0;

	if(!PlayerData[playerid][pInjured])
	{
		if(IsPlayerInRangeOfPoint(playerid, 15.0, x, y, z))
		{
			SetPlayerDynamicPos(playerid, x, y, z);
		}
	}

	if(!DeathMode{playerid}) TogglePlayerControllable(playerid, true);
	return true;
}

public e_COMMAND_ERRORS:OnPlayerCommandReceived(playerid, cmdtext[], e_COMMAND_ERRORS:success)
{
	if(success != COMMAND_OK)
	{
	    SendClientMessage(playerid, COLOR_WHITE, "{ADC3E7}Error: {FFFFFF}Sorry, that command does not exist. {ADC3E7}/help{FFFFFF} or {ADC3E7}/helpme{FFFFFF} if you're in need of assistance.");
	    return COMMAND_OK;
	}

    if(PlayerData[playerid][pID] == -1)
	{
		SendUnauthMessage(playerid, "You must be logged in prior to use commands.");
		return COMMAND_DENIED;
	}

	if(PlayerData[playerid][pTutorialStep])
	{
		return COMMAND_DENIED;		
	}

	return COMMAND_OK;
}

public OnPlayerText(playerid, text[])
{
	if(PlayerData[playerid][pID] == -1)
	{
	    SendUnauthMessage(playerid, "You must be logged in prior to use commands.");
	    return false;
	}

	if(PlayerData[playerid][pTutorialStep]) return false;

	new str[128];

	if(Convo{playerid})
	{
		if(BlockedPM[ ConvoID[playerid] ][playerid] && PlayerData[playerid][pAdmin] < 1)
			return SendErrorMessage(playerid, "That player is blocking PMs.");

		SendPrivateMessage(playerid, ConvoID[playerid], text);
	}
	else
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_SPECTATING)
		{
		    SendClientMessage(playerid, COLOR_LIGHTRED, "You can't talk while spectating.");
		    return false;
		}

     	if(PlayerData[playerid][pInjured] || KnockedOut{playerid})
	    {
	        SendClientMessage(playerid, COLOR_GRAD2, "  ..You are unconscious and can't talk");
			return false;
		}

		if(PlayerData[playerid][pCallLine] != INVALID_PLAYER_ID && !PlayerData[playerid][pIncomingCall])
		{
			new target = PlayerData[playerid][pCallLine];

			if(IsPlayerConnected(target))
			{
				if(PlayerData[target][pCallLine] == playerid)
				{
				    if(strlen(text) > 70)
				    {
	                    if(ph_speaker{target})
						{
						    format(str, sizeof(str), "%s says [Loudspeaker] (phone): %.70s", ReturnName(playerid, 0), text);
						    ProxDetector(target, 20.0, str);

						    format(str, sizeof(str), "%s says [Loudspeaker] (phone): ... %s", ReturnName(playerid, 0), text[70]);
						    ProxDetector(target, 20.0, str);
						}

						format(str, sizeof(str), "%s says (phone): %.70s", ReturnName(playerid, 0), text);
	                   	SendClientMessage(target, COLOR_YELLOW, str);

						format(str, sizeof(str), "%s says (phone): ... %s", ReturnName(playerid, 0), text[70]);
	                   	SendClientMessage(target, COLOR_YELLOW, str);
					}
					else
					{
	                    if(ph_speaker{target})
						{
						    format(str, sizeof(str), "%s says [Loudspeaker] (phone): %s", ReturnName(playerid, 0), text);
						    ProxDetector(target, 20.0, str);
						}

						format(str, sizeof(str), "%s says (phone): %s", ReturnName(playerid, 0), text);
	                   	SendClientMessage(target, COLOR_YELLOW, str);
					}
				}
			}

		    if(strlen(text) > 70)
		    {
				format(str, sizeof(str), "%s says (phone): %.70s", ReturnName(playerid, 0), text);
				ProxDetector(playerid, 20.0, str);

				format(str, sizeof(str), "%s says (phone): ... %s", ReturnName(playerid, 0), text[70]);
				ProxDetector(playerid, 20.0, str);
			}
			else
			{
				format(str, sizeof(str), "%s says (phone): %s", ReturnName(playerid, 0), text);
				ProxDetector(playerid, 20.0, str);
			}

			if(PlayerData[playerid][pCallLine] == 911)
			{
				if(!strcmp(text, "Police", true))
				{
					format(str, sizeof(str), "Law Enforcement personnel shall be notified. What is your current location?");
				}
				else if(!strcmp(text, "Fire", true) || !strcmp(text, "Medical", true) || !strcmp(text, "Medic", true))
				{
					format(str, sizeof(str), "Paramedics shall be notified immediately. What is your current location?");
				}
				else if(!strcmp(text, "Both", true))
				{
					format(str, sizeof(str), "Okay, both Law Enforcement Services and Paramedics shall be notified. What is your current location?");
			 	}
			 	else
		 		{
				 	SendClientMessage(playerid, COLOR_YELLOW, "Emergency Dispatch says (phone): Your request was unclear. Which Emergency Services do you require?");
				 	return false;
				}

      			if(strlen(str) > 60)
				{
         			SendClientMessageEx(playerid, COLOR_YELLOW, "Emergency Dispatch say (phone): %.60s", str);
	    			SendClientMessageEx(playerid, COLOR_YELLOW, "Emergency Dispatch say (phone): ... %s", str[60]);
				}
				else SendClientMessageEx(playerid, COLOR_YELLOW, "Emergency Dispatch say (phone): %s", str);

				SetPVarString(playerid, "CallEmergency", text);

				PlayerData[playerid][pCallLine] = 912;
			}
			else if(PlayerData[playerid][pCallLine] == 912)
			{
				if(strlen(text) < 3)
				{
					SendClientMessage(playerid, COLOR_YELLOW, "Emergency Dispatch says (phone): Please describe the location briefly!");
					return false;
				}

				SendClientMessage(playerid, COLOR_YELLOW, "Emergency Dispatch says (phone): Please describe the situation briefly!");

				SetPVarString(playerid, "CallLocation", text);

				PlayerData[playerid][pCallLine] = 913;
			}
			else if(PlayerData[playerid][pCallLine] == 913)
			{
				if(strlen(text) < 3)
				{
					SendClientMessage(playerid, COLOR_YELLOW, "Emergency Dispatch says (phone): Please describe the location briefly!");
					return false;
				}

				SendClientMessage(playerid, COLOR_YELLOW, "Emergency Dispatch says (phone): Thank you for your call, units have been dispatched to your location.");

				new cService[24], cLocation[60], cSituation[128];

				GetPVarString(playerid, "CallEmergency", cService, sizeof(cService)), DeletePVar(playerid, "CallEmergency");
				GetPVarString(playerid, "CallLocation", cLocation, sizeof(cLocation)), DeletePVar(playerid, "CallLocation");
				
				DeletePVar(playerid, "CallEmergency");
				DeletePVar(playerid, "CallLocation");
				
				format(cSituation, sizeof(cSituation), text); //(signal > 1) ? (text) : FormatTextLowSignal(text));

		        PlayerData[playerid][pCellTime] = 0;
				PlayerData[playerid][pCallLine] = INVALID_PLAYER_ID;
				PlayerData[playerid][pIncomingCall] = 0;

				RenderPlayerPhone(playerid, 0, 0);

				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
				
			    if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USECELLPHONE) SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);

                SendPoliceMessage(COLOR_LIGHTBLUE, "|____________Emergency call____________|");
   				SendPoliceMessage(COLOR_LIGHTBLUE, "Caller: %s, Phone: %d, Trace: %s", ReturnName(playerid, 0), PlayerData[playerid][pPnumber], GetPlayerLocation(playerid));
				SendPoliceMessage(COLOR_LIGHTBLUE, "Services required: %s", cService);
        		SendPoliceMessage(COLOR_LIGHTBLUE, "Location: %s", cLocation);

        		if(strlen(cSituation) > 80)
        		{
					SendPoliceMessage(COLOR_LIGHTBLUE, "Situation: %.80s ...", cSituation);
					SendPoliceMessage(COLOR_LIGHTBLUE, "Situation: ... %s", cSituation[80]);
				}
				else SendPoliceMessage(COLOR_LIGHTBLUE, "Situation: %s", cSituation);

				MDC_Global_Cache[PoliceCalls] += 1;

				if(!strcmp(cService, "Both", true) || !strcmp(cService, "Fire", true) || !strcmp(cService, "Medical", true) || !strcmp(cService, "Medic", true))
				{
	                SendMedicMessage(COLOR_MEDIC, "|____________Emergency call____________|");
	   				SendMedicMessage(COLOR_MEDIC, "Caller: %s, Phone: %d, Trace: %s", ReturnName(playerid, 0), PlayerData[playerid][pPnumber], GetPlayerLocation(playerid));
					SendMedicMessage(COLOR_MEDIC, "Services required: %s", cService);
	        		SendMedicMessage(COLOR_MEDIC, "Location: %s", cLocation);

	        		if(strlen(cSituation) > 80)
	        		{
						SendMedicMessage(COLOR_MEDIC, "Situation: %.80s ...", cSituation);
						SendMedicMessage(COLOR_MEDIC, "Situation: ... %s", cSituation[80]);
					}
					else SendMedicMessage(COLOR_MEDIC, "Situation: %s", cSituation);

					MDC_Global_Cache[MedicCalls] += 1;
				}

                InsertEmergencyCall(playerid, cService, cLocation, cSituation);
			}

			if(PlayerData[playerid][pCallLine] == 991)
			{
			    if(strlen(text) < 3)
		     	{
				 	SendClientMessage(playerid, COLOR_LIGHTBLUE, "Police Dispatch says (phone): Sorry we did not understand, what is your current position?");
				 	return false;
				}

				SetPVarString(playerid, "CallEmergencyLoc", text);

				SendClientMessage(playerid, COLOR_YELLOW, "Police Dispatch says (phone): Okay, what's your concern?");
					
				PlayerData[playerid][pCallLine] = 992;
			}
			else if(PlayerData[playerid][pCallLine] == 992)
			{
				SendClientMessage(playerid, COLOR_YELLOW, "Police Dispatch says (phone): Understood, units have been alerted and will get to you as soon as possible.");
				
                SetPVarString(playerid, "CallEmergencySituation", text);
                
		        PlayerData[playerid][pCellTime] = 0;
				PlayerData[playerid][pCallLine] = INVALID_PLAYER_ID;
				PlayerData[playerid][pIncomingCall] = 0;

				RenderPlayerPhone(playerid, 0, 0);

				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
				
			    if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USECELLPHONE) SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);

                GetPVarString(playerid, "CallEmergencyLoc", str, sizeof(str));

                SendPoliceMessage(COLOR_POLICE, "|_________________Non Emergency call_________________|");
   				SendPoliceMessage(COLOR_POLICE, "Caller: [%s], Ph: %d", ReturnName(playerid, 0), PlayerData[playerid][pPnumber]);
        		SendPoliceMessage(COLOR_POLICE, "Location: %s", str);
				SendPoliceMessage(COLOR_POLICE, "Situation: %s", text);
				//SendPoliceMessage(COLOR_POLICE, "* To accept this call, type /rne %d", playerid);

				DeletePVar(playerid, "CallEmergencyLoc");
			}

			if(PlayerData[playerid][pCallLine] == 555)
			{
			    if(strlen(text) < 32)
			    {
			        PlayerData[playerid][pCellTime] = 0;
					PlayerData[playerid][pCallLine] = INVALID_PLAYER_ID;
					PlayerData[playerid][pIncomingCall] = 0;

	              	ph_menuid[playerid] = 0;
	         		ph_sub_menuid[playerid] = 0;
					RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);

					SetPlayerSpecialAction(playerid,SPECIAL_ACTION_STOPUSECELLPHONE);
				    if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USECELLPHONE) SetPlayerSpecialAction(playerid,SPECIAL_ACTION_STOPUSECELLPHONE);

					SendJobMessage(JOB_MECHANIC, COLOR_GREEN, "|____________Mechanic Hotline____________|");
					SendJobMessage(JOB_MECHANIC, COLOR_WHITE, "Caller: %s, Ph: [%d]", ReturnName(playerid, 0), PlayerData[playerid][pPnumber]);

					if(strlen(text) > 80)
					{
					    SendJobMessage(JOB_MECHANIC, COLOR_WHITE, "Situation: %.80s ...", text);
					    SendJobMessage(JOB_MECHANIC, COLOR_WHITE, "... %s", text[80]);
					}
					else SendJobMessage(JOB_MECHANIC, COLOR_WHITE, "Situation: %s", text);

					SendClientMessage(playerid, COLOR_YELLOW, "Mechanic Dispatch says (phone): On-Duty Mechanics have been notified of your request.");
				}
				else SendClientMessage(playerid, COLOR_YELLOW, "Mechanic Dispatch say (phone): Sorry, I don't understand. How can I help you?");
			}

			if(PlayerData[playerid][pCallLine] == 544)
			{
			    if(strlen(text) < 32)
			    {
			        DeletePVar(playerid, "ResponseTaxi");

			        SendClientMessage(playerid, COLOR_WHITE, "** /taxi check ID, to see how much he/she is charging! **");
					SendClientMessage(playerid, COLOR_YELLOW, "Taxi Dispatch says (phone): Got it, we'll send someone as soon as possible.");

			        PlayerData[playerid][pCellTime] = 0;
					PlayerData[playerid][pCallLine] = INVALID_PLAYER_ID;
					PlayerData[playerid][pIncomingCall] = 0;

	              	ph_menuid[playerid] = 0;
	         		ph_sub_menuid[playerid] = 0;
					RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid]);

					SetPlayerSpecialAction(playerid,SPECIAL_ACTION_STOPUSECELLPHONE);
				    if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USECELLPHONE) SetPlayerSpecialAction(playerid,SPECIAL_ACTION_STOPUSECELLPHONE);

					new Float:playerpos[3];
					GetPlayerPos(playerid, playerpos[0], playerpos[1], playerpos[2]);

					SendJobMessage(JOB_TAXI, COLOR_YELLOW, "|____________Taxi Call____________|");
					SendJobMessage(JOB_TAXI, COLOR_YELLOW, "Caller: [%d]", PlayerData[playerid][pPnumber]);
					SendJobMessage(JOB_TAXI, COLOR_YELLOW, "Destination: %s", text);
                    SendJobMessage(JOB_TAXI, COLOR_YELLOW, "** /taxi accept %d to take this call! **",PlayerData[playerid][pPnumber]);

					SetPVarInt(playerid, "NeedTaxi", 1);
					SetPVarString(playerid, "CallTaxiLoc", text);
				}
				else SendClientMessage(playerid, COLOR_LIGHTBLUE, "Taxi Dispatch say (phone): Sorry we do not understand, where do you want to go?");
			}
		}
		else
		{
		    if(!AutoLow{playerid})
		    {
			    if(strlen(text) > 80)
			    {
					format(str, sizeof(str), "%s says: %.80s", ReturnName(playerid, 0), text);
					ProxDetector(playerid, 20.0, str);

					format(str, sizeof(str), "%s says: ... %s", ReturnName(playerid, 0), text[80]);
					ProxDetector(playerid, 20.0, str);
				}
				else
				{
					format(str, sizeof(str), "%s says: %s", ReturnName(playerid, 0), text);
					ProxDetector(playerid, 20.0, str);
				}

				ChatAnimation(playerid, strlen(text));
			}
			else
			{
				LowChatProximity(playerid, text);
			}
		}
    }
	return false;
}

FUNX::StopChatting(playerid)
{
	if(GetPlayerAnimationIndex(playerid) != 0)
	{
		ApplyAnimationEx(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0);
	}

	PlayerData[playerid][pAnimation] = 0;
}

SQL_IsLogged(playerid)
{
	if(IsPlayerConnected(playerid) && LoggedIn{playerid} == true)
	    return true;

	return false;
}

// valstr fix by Slice
Int32(dest[], value, bool:pack = false)
{
    // format can't handle cellmin properly
    static const cellmin_value[] = !"-2147483648";

    if(value == cellmin)
        pack && strpack(dest, cellmin_value, 12) || strunpack(dest, cellmin_value, 12);
    else
        format(dest, 12, "%d", value), pack && strpack(dest, dest, 12);
}

IsPlayerNearPlayer(playerid, targetid, Float:radius)
{
	static
		Float:fX,
		Float:fY,
		Float:fZ;

	if(GetPlayerInterior(playerid) != GetPlayerInterior(targetid) || GetPlayerVirtualWorld(playerid) != GetPlayerVirtualWorld(targetid)) return false;

	GetPlayerPos(targetid, fX, fY, fZ);

	if(IsPlayerInRangeOfPoint(playerid, radius, fX, fY, fZ)) return true;

	return false;
}

PlayerPlaySoundEx(playerid, sound)
{
	new
	    Float:x,
	    Float:y,
	    Float:z;

	GetPlayerPos(playerid, x, y, z);

	foreach (new i : StreamedPlayer[playerid])
	{
		if(IsPlayerInRangeOfPoint(i, 20.0, x, y, z))
		{
     		PlayerPlaySound(i, sound, x, y, z);
		}
	}
	return true;
}

ConvertTime(&cts, &ctm=-1,&cth=-1,&ctd=-1,&ctw=-1,&ctmo=-1,&cty=-1)
{
    #define PLUR(%0,%1,%2) (%0),((%0) == 1)?((#%1)):((#%2))

    #define CTM_cty 31536000
    #define CTM_ctmo 2628000
    #define CTM_ctw 604800
    #define CTM_ctd 86400
    #define CTM_cth 3600
    #define CTM_ctm 60

    #define CT(%0) %0 = cts / CTM_%0; cts %= CTM_%0

    new strii[128];

    if(cty != -1 && (cts/CTM_cty))
    {
        CT(cty); CT(ctmo); CT(ctw); CT(ctd); CT(cth); CT(ctm);
        format(strii, sizeof(strii), "%d %s, %d %s, %d %s, %d %s, %d %s, %d %s, and %d %s",PLUR(cty,"year","years"),PLUR(ctmo,"month","months"),PLUR(ctw,"week","weeks"),PLUR(ctd,"day","days"),PLUR(cth,"hour","hours"),PLUR(ctm,"minute","minutes"),PLUR(cts,"second","seconds"));
        return strii;
    }
    if(ctmo != -1 && (cts/CTM_ctmo))
    {
        cty = 0; CT(ctmo); CT(ctw); CT(ctd); CT(cth); CT(ctm);
        format(strii, sizeof(strii), "%d %s, %d %s, %d %s, %d %s, %d %s, and %d %s",PLUR(ctmo,"month","months"),PLUR(ctw,"week","weeks"),PLUR(ctd,"day","days"),PLUR(cth,"hour","hours"),PLUR(ctm,"minute","minutes"),PLUR(cts,"second","seconds"));
        return strii;
    }
    if(ctw != -1 && (cts/CTM_ctw))
    {
        cty = 0; ctmo = 0; CT(ctw); CT(ctd); CT(cth); CT(ctm);
        format(strii, sizeof(strii), "%d %s, %d %s, %d %s, %d %s, and %d %s",PLUR(ctw,"week","weeks"),PLUR(ctd,"day","days"),PLUR(cth,"hour","hours"),PLUR(ctm,"minute","minutes"),PLUR(cts,"second","seconds"));
        return strii;
    }
    if(ctd != -1 && (cts/CTM_ctd))
    {
        cty = 0; ctmo = 0; ctw = 0; CT(ctd); CT(cth); CT(ctm);
        format(strii, sizeof(strii), "%d %s, %d %s, %d %s, and %d %s",PLUR(ctd,"day","days"),PLUR(cth,"hour","hours"),PLUR(ctm,"minute","minutes"),PLUR(cts,"second","seconds"));
        return strii;
    }
    if(cth != -1 && (cts/CTM_cth))
    {
        cty = 0; ctmo = 0; ctw = 0; ctd = 0; CT(cth); CT(ctm);
        format(strii, sizeof(strii), "%d %s, %d %s, and %d %s",PLUR(cth,"hour","hours"),PLUR(ctm,"minute","minutes"),PLUR(cts,"second","seconds"));
        return strii;
    }
    if(ctm != -1 && (cts/CTM_ctm))
    {
        cty = 0; ctmo = 0; ctw = 0; ctd = 0; cth = 0; CT(ctm);
        format(strii, sizeof(strii), "%d %s, and %d %s",PLUR(ctm,"minute","minutes"),PLUR(cts,"second","seconds"));
        return strii;
    }
    cty = 0; ctmo = 0; ctw = 0; ctd = 0; cth = 0; ctm = 0;
    format(strii, sizeof(strii), "%d %s", PLUR(cts,"second","seconds"));
    return strii;
}

/*IsNumeric(const str[])
{
	for(new i = 0, l = strlen(str); i != l; ++i)
	{
	    if(i == 0 && str[0] == '-')
			continue;

	    else if(str[i] < '0' || str[i] > '9')
			return 0;
	}
	return true;
}

IsPlayerIdle(playerid)
{
	new
	    index = GetPlayerAnimationIndex(playerid)
	;

	return ((index == 1275) || (1181 <= index <= 1192) || (index == 1151));
}*/

AccountName(playerid)
{
	static
	    name[MAX_PLAYER_NAME + 24]
	;

	GetPlayerName(playerid, name, sizeof(name));

	if(ShowMain{playerid})
	{
	    format(name, sizeof(name), "%s (%s)", name, AccountData[playerid][aUsername]);
	}

	return name;
}

ReturnNameEx(playerid)
{
	static
	    name[MAX_PLAYER_NAME + 1]
	;

	GetPlayerName(playerid, name, sizeof(name));

	for(new i = 0, len = strlen(name); i < len; ++i) if(name[i] == '_') name[i] = ' '; // RP

	return name;
}

PlayerName(playerid)
{
	static
	    name[MAX_PLAYER_NAME + 1]
	;

	GetPlayerName(playerid, name, sizeof(name));

	return name;
}

ReturnCharacterName(playerid, formatme[])
{
	static
	    name[MAX_PLAYER_NAME + 1];

	GetPlayerName(playerid, name, sizeof(name));

    for(new i = 0, len = strlen(name); i < len; ++i) if(name[i] == '_') name[i] = ' ';

	return format(formatme, MAX_PLAYER_NAME + 1, name);
}

ReturnIP(playerid)
{
	static
	    ip[16];

	GetPlayerIp(playerid, ip, sizeof(ip));
	return ip;
}

ReturnSiteDate()
{
	static
	    date[36];

	new year, month, day, hour, minute, second;
	getdate(year, month, day);
	gettime(hour, minute, second);

	format(date, sizeof(date), "%d-%02d-%02d %02d:%02d:%02d", year, month, day, hour, minute, second);
	return date;
}

/*ReturnDate()
{
	static
	    date[36];

	getdate(date[2], date[1], date[0]);
	gettime(date[3], date[4], date[5]);

	format(date, sizeof(date), "%d-%02d-%02d, %02d:%02d:%02d", date[2], date[1], date[0], date[3], date[4], date[5]);
	return date;
}*/

HowLongAgo(inputSeconds)
{
	new timeago[128], count = 0;

    new secondsInAMinute = 60;
    new secondsInAnHour  = 60 * secondsInAMinute;
    new secondsInADay    = 24 * secondsInAnHour;

    // extract days
    new days = floatround(inputSeconds / secondsInADay, floatround_floor);

    // extract hours
    new hourSeconds = inputSeconds % secondsInADay;
    new hours = floatround(hourSeconds / secondsInAnHour, floatround_floor);

    // extract minutes
    new minuteSeconds = hourSeconds % secondsInAnHour;
    new minutes = floatround(minuteSeconds / secondsInAMinute, floatround_floor);

    // extract the remaining seconds
    new remainingSeconds = minuteSeconds % secondsInAMinute;
    new seconds = floatround(remainingSeconds, floatround_ceil);

	if(days > 0)
	{
	    format(timeago, sizeof(timeago), "%i day", days);
	    count ++;
	}
	if(hours > 0)
	{
	    if(count != 0) { strcat(timeago, ", "); count = 0; }
	    format(timeago, sizeof(timeago), "%s%i hr", timeago, hours);
	    count ++;
	}
	if(minutes > 0)
	{
	    if(count != 0) { strcat(timeago, ", "); count = 0; }
	    format(timeago, sizeof(timeago), "%s%i min", timeago, minutes);
	    count ++;
	}
	if(seconds > 0)
	{
	    if(count != 0) { strcat(timeago, ", "); count = 0; }
	    format(timeago, sizeof(timeago), "%s%i sec", timeago, seconds);
	}
	return timeago;
}

SecondsToString(totalSeconds)
{
	new temp, hours, minutes, seconds, str[64];

	temp = totalSeconds % 3600;

	hours = (totalSeconds - temp) / 3600;
	minutes = (temp - (temp % 60)) / 60;
	seconds = temp % 60;

	format(str, sizeof(str), "%02d:%02d:%02d", hours, minutes, seconds);
	return str;
}

ReturnDateTime()
{
 	static
	    szDay[64],
		date[6];

	getdate(date[2], date[1], date[0]);
	gettime(date[3], date[4], date[5]);

	format(szDay, sizeof(szDay), "%d%s %s %d, %02d:%02d:%02d", date[0], returnOrdinal(date[0]), MonthDay[date[1] - 1], date[2], date[3], date[4], date[5]);

	return szDay;
}

ReturnPhoneDateTime()
{
 	static
	    szDay[64],
		date[6];

	getdate(date[2], date[1], date[0]);
	gettime(date[3], date[4], date[5]);

	format(szDay, sizeof(szDay), "%s %d %d, %02d:%02d", szMonthDay[date[1] - 1], date[0], date[2], date[3], date[4]);

	return szDay;
}

returnOrdinal(number)
{
	new
	    ordinal[4][3] = { "st", "nd", "rd", "th" }
	;

	number = number < 0 ? -number : number;

	return (((10 < (number % 100) < 14)) ? ordinal[3] : (0 < (number % 10) < 4) ? ordinal[((number % 10) - 1)] : ordinal[3]);
}

KickEx(playerid)
{
	if(BeingKicked{playerid}) return false;

	BeingKicked{playerid} = true;

	return SetTimerEx("KickTimer", 400, false, "d", playerid);
}

forward KickTimer(playerid);
public KickTimer(playerid)
{
	if(BeingKicked{playerid})
		return Kick(playerid);

	return false;
}

/*Log_Write(const path[], const str[], {Float,_}:...)
{
	static
	    args,
	    start,
	    end,
	    File:file,
	    string[1024]
	;

	if((start = strfind(path, "/")) != -1)
	{
	    strmid(string, path, 0, start + 1);

	    if(!fexist(string))
	        return printf("** Warning: Directory \"%s\" doesn't exist.", string);
	}

	#emit LOAD.S.pri 8
	#emit STOR.pri args

	file = fopen(path, io_append);

	if(!file)
	    return 0;

	if(args > 8)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 8); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 1024
		#emit PUSH.C string
		#emit PUSH.C args
		#emit SYSREQ.C format

		fwrite(file, string);
		fwrite(file, "\r\n");
		fclose(file);

		#emit LCTRL 5
		#emit SCTRL 4
		#emit RETN
	}

	fwrite(file, str);
	fwrite(file, "\r\n");
	fclose(file);
	return true;
}*/

randomEx(min, max)
{
    new
		rand = random(max - min) + min
	;

    return rand;
}

FixHour(hour)
{
	hour = timeshift + hour;

	if(hour < 0) hour = hour + 24;
	else if(hour > 23) hour = hour - 24;

	shifthour = hour;
	return true;
}

RemoveFromVehicle(playerid)
{
	if(IsPlayerInAnyVehicle(playerid))
	{
		new
		    Float:fX,
	    	Float:fY,
	    	Float:fZ;

		GetPlayerPos(playerid, fX, fY, fZ);
		SetPlayerDynamicPos(playerid, fX, fY, fZ + 1.5);
	}
	return true;
}

ShowPlayerFooter(playerid, const string[], time = 5000)
{
	if(PlayerData[playerid][pShowFooter])
	{
	    PlayerTextDrawHide(playerid, pPT_Footer[playerid]);
		KillTimer(PlayerData[playerid][pFooterTimer]);
	}

 	PlayerTextDrawSetString(playerid, pPT_Footer[playerid], string);
	PlayerTextDrawShow(playerid, pPT_Footer[playerid]);

	PlayerData[playerid][pShowFooter] = true;

	if(time != -1) PlayerData[playerid][pFooterTimer] = SetTimerEx("HidePlayerFooter", time, false, "d", playerid);
}

ShowMaskTextdraw(playerid)
{
    if(!PlayerFlags[playerid][toggleHUD])
    {
		PlayerTextDrawShow(playerid, MaskTD[playerid]);
	}
	return true;
}

HideMaskTextdraw(playerid)
{
    PlayerTextDrawHide(playerid, MaskTD[playerid]);
	return true;
}

forward HidePlayerFooter(playerid);
public HidePlayerFooter(playerid)
{
	if(!PlayerData[playerid][pShowFooter])
	    return 0;

	PlayerData[playerid][pShowFooter] = false;
	
	return PlayerTextDrawHide(playerid, pPT_Footer[playerid]);
}

RemoveAlpha(color)
{
    return (color & ~0xFF);
}

/*GetPlayerLocationEx(playerid, &Float:fX, &Float:fY, &Float:fZ)
{
    if(PlayerData[playerid][pLocal] != 255)
	{
		new i;

		if(InProperty[playerid] != -1)
		{
   			i = InProperty[playerid];

			fX = PropertyData[i][hEntranceX];
			fY = PropertyData[i][hEntranceY];
			fZ = PropertyData[i][hEntranceZ];
		}
		else if(InApartment[playerid] != -1)
		{
   			i = InApartment[playerid];

			fX = ComplexData[i][aEntranceX];
			fY = ComplexData[i][aEntranceY];
			fZ = ComplexData[i][aEntranceZ];
		}
		else if(InBusiness[playerid] != -1)
		{
			i = InBusiness[playerid];

			fX = BusinessData[i][bEntranceX];
			fY = BusinessData[i][bEntranceY];
			fZ = BusinessData[i][bEntranceZ];
		}
	}
	else GetPlayerPos(playerid, fX, fY, fZ);

	return true;
}*/

GetPlayerLocation(playerid)
{
	new
	    Float:fX,
	    Float:fY,
		Float:fZ,
		string[32]
	;

    if(PlayerData[playerid][pLocal] != 255)
	{
		new i;

		if(InProperty[playerid] != -1)
		{
   			i = InProperty[playerid];

			fX = PropertyData[i][hEntranceX];
			fY = PropertyData[i][hEntranceY];
			fZ = PropertyData[i][hEntranceZ];
		}
		else if(InApartment[playerid] != -1)
		{
   			i = InApartment[playerid];

			fX = ComplexData[i][aEntranceX];
			fY = ComplexData[i][aEntranceY];
			fZ = ComplexData[i][aEntranceZ];
		}
		else if(InBusiness[playerid] != -1)
		{
  			i = InBusiness[playerid];

			fX = BusinessData[i][bEntranceX];
			fY = BusinessData[i][bEntranceY];
			fZ = BusinessData[i][bEntranceZ];
		}
	}
	else GetPlayerPos(playerid, fX, fY, fZ);

	format(string, 32, ReturnLocationPos(fX, fY));
	return string;
}

FormatNumber(number, const prefix[] = "$")
{
	new
		value[32],
		length;

	format(value, sizeof(value), "%d", (number < 0) ? (-number) : (number));

	if((length = strlen(value)) > 3)
	{
		for(new i = length, l = 0; --i >= 0; ++l)
		{
		    if((l > 0) && (l % 3 == 0)) strins(value, ",", i + 1);
		}
	}

	if(prefix[0] != 0)
	    strins(value, prefix, 0);

	if(number < 0)
		strins(value, "-", 0);

	return value;
}

FormatNumberEx(number, const prefix[] = "{33AA33}${FFFF00}")
{
	new
		value[32],
		length;

	format(value, sizeof(value), "%d", (number < 0) ? (-number) : (number));

	if((length = strlen(value)) > 3)
	{
		for(new i = length, l = 0; --i >= 0; ++l)
		{
		    if((l > 0) && (l % 3 == 0)) strins(value, ",", i + 1);
		}
	}

	if(prefix[0] != 0)
	    strins(value, prefix, 0);

	if(number < 0)
		strins(value, "-", 0);

	return value;
}

SetPlayerToFacePlayer(playerid, targetid)
{
	if(!IsPlayerConnected(playerid) || !IsPlayerConnected(targetid)) return false;

	new Float:pX, Float:pY, Float:pZ, Float:X, Float:Y, Float:Z, Float:ang;
	GetPlayerPos(targetid, X, Y, Z);
	GetPlayerPos(playerid, pX, pY, pZ);

	if(Y > pY) ang = (-acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 90.0);
	else if(Y < pY && X < pX) ang = (acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 450.0);
	else if(Y < pY) ang = (acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 90.0);

	if(X > pX) ang = (floatabs(floatabs(ang) + 180.0));
	else ang = (floatabs(ang) - 180.0);

	SetPlayerFacingAngle(playerid, ang);
	return false;
}

/*CheckFallInAir(playerid)
{
    new index = GetPlayerAnimationIndex(playerid);

    return (index == 1130 || index == 1132 || index == 1129 || index == 1133|| index == 1134 || index == 958); //FALL_FALL, FALL_GLIDE, FALL_COLLAPSE, FALL_LAND, FALL_SKYDIVE
}*/

SetCooldown(playerid,type,amount)
{
	cooldowns[playerid][type] = gettime();
	cooldowns_expire[playerid][type] = amount;
}

HasCooldown(playerid,type)
{
	new diff = (gettime() - cooldowns[playerid][type]);

	if(diff >= cooldowns_expire[playerid][type]) return false;

	return true;
}

ResetCooldowns(playerid)
{
	for(new i = 0; i != MAX_COOLDOWNS; ++i)
	{
		cooldowns[playerid][i] = 0;
	}
}

GetCooldownLevel(playerid, type)
{
	new diff = (cooldowns_expire[playerid][type] - (gettime() - cooldowns[playerid][type]));

	return diff;
}

RemoveBuilding(playerid)
{
	//Pershing Square
	RemoveBuildingForPlayer(playerid, 4057, 1479.5547, -1693.1406, 19.5781, 0.25);
	RemoveBuildingForPlayer(playerid, 4210, 1479.5625, -1631.4531, 12.0781, 0.25);
	RemoveBuildingForPlayer(playerid, 713, 1496.8672, -1707.8203, 13.4063, 0.25);
	RemoveBuildingForPlayer(playerid, 1280, 1468.9844, -1713.5078, 13.4531, 0.25);
	RemoveBuildingForPlayer(playerid, 1226, 1505.1797, -1727.6719, 16.4219, 0.25);
	RemoveBuildingForPlayer(playerid, 1280, 1488.7656, -1713.7031, 13.4531, 0.25);
	RemoveBuildingForPlayer(playerid, 1289, 1504.7500, -1711.8828, 13.5938, 0.25);
	RemoveBuildingForPlayer(playerid, 712, 1445.8125, -1650.0234, 22.2578, 0.25);
	RemoveBuildingForPlayer(playerid, 1280, 1468.9844, -1704.6406, 13.4531, 0.25);
	RemoveBuildingForPlayer(playerid, 1280, 1468.9844, -1694.0469, 13.4531, 0.25);
	RemoveBuildingForPlayer(playerid, 4186, 1479.5547, -1693.1406, 19.5781, 0.25);
	RemoveBuildingForPlayer(playerid, 1280, 1468.9844, -1682.7188, 13.4531, 0.25);
	RemoveBuildingForPlayer(playerid, 712, 1449.8516, -1655.9375, 22.2578, 0.25);
	RemoveBuildingForPlayer(playerid, 1280, 1479.6094, -1653.2500, 13.4531, 0.25);
	RemoveBuildingForPlayer(playerid, 1280, 1467.8516, -1646.5938, 13.4531, 0.25);
	RemoveBuildingForPlayer(playerid, 1280, 1472.8984, -1651.5078, 13.4531, 0.25);
	RemoveBuildingForPlayer(playerid, 1280, 1465.9375, -1639.8203, 13.4531, 0.25);
	RemoveBuildingForPlayer(playerid, 1280, 1467.7109, -1632.8906, 13.4531, 0.25);
	RemoveBuildingForPlayer(playerid, 1280, 1472.6641, -1627.8828, 13.4531, 0.25);
	RemoveBuildingForPlayer(playerid, 1280, 1479.4688, -1626.0234, 13.4531, 0.25);
	RemoveBuildingForPlayer(playerid, 3985, 1479.5625, -1631.4531, 12.0781, 0.25);
	RemoveBuildingForPlayer(playerid, 4206, 1479.5547, -1639.6094, 13.6484, 0.25);
	RemoveBuildingForPlayer(playerid, 1280, 1488.7656, -1704.5938, 13.4531, 0.25);
	RemoveBuildingForPlayer(playerid, 1280, 1488.7656, -1693.7344, 13.4531, 0.25);
	RemoveBuildingForPlayer(playerid, 1280, 1488.7656, -1682.6719, 13.4531, 0.25);
	RemoveBuildingForPlayer(playerid, 1280, 1486.4063, -1651.3906, 13.4531, 0.25);
	RemoveBuildingForPlayer(playerid, 1280, 1491.3672, -1646.3828, 13.4531, 0.25);
	RemoveBuildingForPlayer(playerid, 1280, 1493.1328, -1639.4531, 13.4531, 0.25);
	RemoveBuildingForPlayer(playerid, 1280, 1486.1797, -1627.7656, 13.4531, 0.25);
	RemoveBuildingForPlayer(playerid, 1280, 1491.2188, -1632.6797, 13.4531, 0.25);
	RemoveBuildingForPlayer(playerid, 1288, 1504.7500, -1705.4063, 13.5938, 0.25);
	RemoveBuildingForPlayer(playerid, 1287, 1504.7500, -1704.4688, 13.5938, 0.25);
	RemoveBuildingForPlayer(playerid, 1286, 1504.7500, -1695.0547, 13.5938, 0.25);
	RemoveBuildingForPlayer(playerid, 1285, 1504.7500, -1694.0391, 13.5938, 0.25);
	RemoveBuildingForPlayer(playerid, 700, 1463.0625, -1690.6484, 13.7266, 0.25);
	RemoveBuildingForPlayer(playerid, 625, 1457.2734, -1666.2969, 13.6953, 0.25);
	RemoveBuildingForPlayer(playerid, 625, 1458.2578, -1659.2578, 13.6953, 0.25);
	RemoveBuildingForPlayer(playerid, 625, 1457.3516, -1650.5703, 13.6953, 0.25);
	RemoveBuildingForPlayer(playerid, 625, 1454.4219, -1642.4922, 13.6953, 0.25);
	RemoveBuildingForPlayer(playerid, 625, 1449.5938, -1635.0469, 13.6953, 0.25);
	RemoveBuildingForPlayer(playerid, 700, 1494.2109, -1694.4375, 13.7266, 0.25);
	RemoveBuildingForPlayer(playerid, 625, 1504.1641, -1662.0156, 13.6953, 0.25);
	RemoveBuildingForPlayer(playerid, 625, 1504.7188, -1670.9219, 13.6953, 0.25);
	RemoveBuildingForPlayer(playerid, 625, 1505.6953, -1654.8359, 13.6953, 0.25);
	RemoveBuildingForPlayer(playerid, 625, 1508.5156, -1647.8594, 13.6953, 0.25);
	RemoveBuildingForPlayer(playerid, 625, 1513.2734, -1642.4922, 13.6953, 0.25);
	RemoveBuildingForPlayer(playerid, 713, 1457.9375, -1620.6953, 13.4531, 0.25);
	RemoveBuildingForPlayer(playerid, 1231, 1479.6953, -1716.7031, 15.6250, 0.25);
	RemoveBuildingForPlayer(playerid, 700, 1463.0625, -1701.5703, 13.7266, 0.25);
	RemoveBuildingForPlayer(playerid, 1231, 1479.6953, -1702.5313, 15.6250, 0.25);
	RemoveBuildingForPlayer(playerid, 1231, 1479.3828, -1692.3906, 15.6328, 0.25);
	RemoveBuildingForPlayer(playerid, 641, 1458.6172, -1684.1328, 11.1016, 0.25);
	RemoveBuildingForPlayer(playerid, 712, 1471.4063, -1666.1797, 22.2578, 0.25);
	RemoveBuildingForPlayer(playerid, 1231, 1479.3828, -1682.3125, 15.6328, 0.25);
	RemoveBuildingForPlayer(playerid, 712, 1480.6094, -1666.1797, 22.2578, 0.25);
	RemoveBuildingForPlayer(playerid, 712, 1488.2266, -1666.1797, 22.2578, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1503.1875, -1621.1250, 11.8359, 0.25);
	RemoveBuildingForPlayer(playerid, 673, 1501.2813, -1624.5781, 12.3984, 0.25);
	RemoveBuildingForPlayer(playerid, 673, 1498.3594, -1616.9688, 12.3984, 0.25);
	RemoveBuildingForPlayer(playerid, 712, 1508.4453, -1668.7422, 22.2578, 0.25);
	RemoveBuildingForPlayer(playerid, 1231, 1477.9375, -1652.7266, 15.6328, 0.25);
	RemoveBuildingForPlayer(playerid, 1231, 1466.4688, -1637.9609, 15.6328, 0.25);
	RemoveBuildingForPlayer(playerid, 1232, 1465.8906, -1629.9766, 15.5313, 0.25);
	RemoveBuildingForPlayer(playerid, 1232, 1465.8359, -1608.3750, 15.3750, 0.25);
	RemoveBuildingForPlayer(playerid, 1232, 1494.4141, -1629.9766, 15.5313, 0.25);
	RemoveBuildingForPlayer(playerid, 1232, 1494.3594, -1608.3750, 15.3750, 0.25);
	RemoveBuildingForPlayer(playerid, 1258, 1445.0078, -1704.7656, 13.6953, 0.25);
	RemoveBuildingForPlayer(playerid, 1258, 1445.0078, -1692.2344, 13.6953, 0.25);

	//Willowfield Projects
	RemoveBuildingForPlayer(playerid, 5319, 2287.3438, -2024.3828, 12.5391, 0.25);
	RemoveBuildingForPlayer(playerid, 3744, 2331.3828, -2001.6719, 15.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 3744, 2313.0469, -2008.5391, 15.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 1266, 2336.9141, -1987.6328, 21.8281, 0.25);
	RemoveBuildingForPlayer(playerid, 5311, 2287.3438, -2024.3828, 12.5391, 0.25);
	RemoveBuildingForPlayer(playerid, 3574, 2313.0469, -2008.5391, 15.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 3574, 2331.3828, -2001.6719, 15.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 1260, 2336.9141, -1987.6328, 21.8281, 0.25);

	//El Corona (harbour)
	RemoveBuildingForPlayer(playerid, 5137, 2005.2500, -2137.4609, 16.5156, 0.25);
	RemoveBuildingForPlayer(playerid, 5195, 2005.2500, -2137.4609, 16.5156, 0.25);
	RemoveBuildingForPlayer(playerid, 3744, 1992.3047, -2146.4219, 15.1328, 0.25);
	RemoveBuildingForPlayer(playerid, 3574, 1992.2969, -2146.4141, 15.0703, 0.25);
	RemoveBuildingForPlayer(playerid, 1306, 2001.0234, -2119.9844, 19.7500, 0.25);
	RemoveBuildingForPlayer(playerid, 5337, 1995.4375, -2066.1484, 18.5313, 0.25);
	RemoveBuildingForPlayer(playerid, 1306, 2001.0234, -2024.2891, 19.7500, 0.25);

	//
	RemoveBuildingForPlayer(playerid, 6495, 343.1250, -1340.3828, 28.7891, 0.25);
	RemoveBuildingForPlayer(playerid, 1268, 311.9531, -1383.1484, 19.6719, 0.25);
	RemoveBuildingForPlayer(playerid, 1266, 326.2969, -1365.3750, 29.8281, 0.25);
	RemoveBuildingForPlayer(playerid, 1261, 359.0625, -1351.6875, 24.0078, 0.25);
	RemoveBuildingForPlayer(playerid, 1411, 298.0859, -1361.3125, 14.8438, 0.25);
	RemoveBuildingForPlayer(playerid, 1411, 295.8906, -1356.6016, 14.8438, 0.25);
	RemoveBuildingForPlayer(playerid, 1411, 300.2891, -1366.0234, 14.8438, 0.25);
	RemoveBuildingForPlayer(playerid, 1411, 304.6797, -1375.4453, 14.8438, 0.25);
	RemoveBuildingForPlayer(playerid, 1411, 302.4844, -1370.7344, 14.8438, 0.25);
	RemoveBuildingForPlayer(playerid, 1411, 306.8750, -1380.1563, 14.8438, 0.25);
	RemoveBuildingForPlayer(playerid, 1259, 311.9531, -1383.1484, 19.6719, 0.25);
	RemoveBuildingForPlayer(playerid, 1411, 310.6328, -1381.4531, 14.8438, 0.25);
	RemoveBuildingForPlayer(playerid, 1411, 315.3438, -1379.2578, 14.8438, 0.25);
	RemoveBuildingForPlayer(playerid, 1411, 320.0547, -1377.0625, 14.8438, 0.25);
	RemoveBuildingForPlayer(playerid, 1411, 324.7656, -1374.8672, 14.8438, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, 326.9609, -1375.7969, 13.2109, 0.25);
	RemoveBuildingForPlayer(playerid, 1260, 326.2969, -1365.3828, 29.8203, 0.25);
	RemoveBuildingForPlayer(playerid, 6369, 343.1250, -1340.3828, 28.7891, 0.25);
	RemoveBuildingForPlayer(playerid, 1267, 359.0625, -1351.6875, 24.0078, 0.25);

	//El Corona Dead End (Fences)
	RemoveBuildingForPlayer(playerid, 1413, 1658.9141, -2120.2813, 13.6797, 0.25);
	RemoveBuildingForPlayer(playerid, 1412, 1658.8359, -2114.9609, 13.6797, 0.25);
	RemoveBuildingForPlayer(playerid, 1413, 1658.8359, -2109.6875, 13.6797, 0.25);
	RemoveBuildingForPlayer(playerid, 1413, 1658.8359, -2104.4063, 13.6797, 0.25);

	// car mod shop
	RemoveBuildingForPlayer(playerid, 6359, 421.4297, -1307.9922, 24.2656, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 394.1172, -1317.8750, 13.2344, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 395.8594, -1323.7578, 13.0000, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 404.8359, -1303.7266, 13.6719, 0.25);
	RemoveBuildingForPlayer(playerid, 673, 404.9766, -1329.1016, 13.7031, 0.25);
	RemoveBuildingForPlayer(playerid, 6355, 421.4297, -1307.9922, 24.2656, 0.25);
	RemoveBuildingForPlayer(playerid, 6363, 428.1016, -1348.8125, 29.2578, 0.25);

	// Idlewood 03dl
	RemoveBuildingForPlayer(playerid, 5534, 1927.703, -1754.312, 12.460, 0.250);
	RemoveBuildingForPlayer(playerid, 5542, 1884.663, -1613.421, 12.460, 0.250);
	RemoveBuildingForPlayer(playerid, 5544, 1873.741, -1682.475, 34.796, 0.250);
	RemoveBuildingForPlayer(playerid, 1524, 1837.663, -1640.381, 13.756, 0.250);
	RemoveBuildingForPlayer(playerid, 5503, 1927.703, -1754.312, 12.460, 0.250);
	RemoveBuildingForPlayer(playerid, 620, 1855.718, -1741.538, 10.803, 0.250);
	RemoveBuildingForPlayer(playerid, 620, 1879.506, -1741.484, 10.803, 0.250);
	RemoveBuildingForPlayer(playerid, 620, 1908.218, -1741.484, 10.803, 0.250);
	RemoveBuildingForPlayer(playerid, 712, 1929.578, -1736.906, 21.389, 0.250);
	RemoveBuildingForPlayer(playerid, 620, 1931.038, -1726.328, 10.803, 0.250);
	RemoveBuildingForPlayer(playerid, 620, 1832.381, -1694.312, 9.718, 0.250);
	RemoveBuildingForPlayer(playerid, 1537, 1837.437, -1683.968, 12.303, 0.250);
	RemoveBuildingForPlayer(playerid, 1533, 1837.437, -1683.953, 12.303, 0.250);
	RemoveBuildingForPlayer(playerid, 1537, 1837.437, -1686.984, 12.312, 0.250);
	RemoveBuildingForPlayer(playerid, 620, 1832.897, -1670.765, 9.718, 0.250);
	RemoveBuildingForPlayer(playerid, 1533, 1837.437, -1677.921, 12.295, 0.250);
	RemoveBuildingForPlayer(playerid, 1537, 1837.437, -1680.953, 12.295, 0.250);
	RemoveBuildingForPlayer(playerid, 1533, 1837.437, -1680.937, 12.295, 0.250);
	RemoveBuildingForPlayer(playerid, 5408, 1873.741, -1682.475, 34.796, 0.250);
	RemoveBuildingForPlayer(playerid, 620, 1931.038, -1702.288, 10.803, 0.250);
	RemoveBuildingForPlayer(playerid, 712, 1929.578, -1694.459, 21.389, 0.250);
	RemoveBuildingForPlayer(playerid, 620, 1931.038, -1667.031, 10.803, 0.250);
	RemoveBuildingForPlayer(playerid, 620, 1931.038, -1637.897, 10.803, 0.250);
	RemoveBuildingForPlayer(playerid, 620, 1879.506, -1623.100, 10.803, 0.250);
	RemoveBuildingForPlayer(playerid, 620, 1908.218, -1622.984, 10.803, 0.250);
	RemoveBuildingForPlayer(playerid, 712, 1929.578, -1627.625, 21.389, 0.250);
	RemoveBuildingForPlayer(playerid, 1226, 1883.819, -1616.428, 16.389, 0.250);
	RemoveBuildingForPlayer(playerid, 5501, 1884.663, -1613.421, 12.460, 0.250);

	// Cargo Ship
	RemoveBuildingForPlayer(playerid, 5156, 2838.0391, -2423.8828, 10.9609, 0.25);
	RemoveBuildingForPlayer(playerid, 5159, 2838.0313, -2371.9531, 7.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 5160, 2829.9531, -2479.5703, 5.2656, 0.25);
	RemoveBuildingForPlayer(playerid, 5161, 2838.0234, -2358.4766, 21.3125, 0.25);
	RemoveBuildingForPlayer(playerid, 5162, 2838.0391, -2423.8828, 10.9609, 0.25);
	RemoveBuildingForPlayer(playerid, 5163, 2838.0391, -2532.7734, 17.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 5164, 2838.1406, -2447.8438, 15.7266, 0.25);
	RemoveBuildingForPlayer(playerid, 5165, 2838.0313, -2520.1875, 18.4141, 0.25);
	RemoveBuildingForPlayer(playerid, 5166, 2829.9531, -2479.5703, 5.2656, 0.25);
	RemoveBuildingForPlayer(playerid, 5167, 2838.0313, -2371.9531, 7.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 5335, 2829.9531, -2479.5703, 5.2656, 0.25);
	RemoveBuildingForPlayer(playerid, 5336, 2829.9531, -2479.5703, 5.2656, 0.25);
	RemoveBuildingForPlayer(playerid, 5352, 2838.1953, -2488.6641, 29.3125, 0.25);
	RemoveBuildingForPlayer(playerid, 5157, 2838.0391, -2532.7734, 17.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 5154, 2838.1406, -2447.8438, 15.7500, 0.25);
	RemoveBuildingForPlayer(playerid, 3724, 2838.1953, -2488.6641, 29.3125, 0.25);
	RemoveBuildingForPlayer(playerid, 5155, 2838.0234, -2358.4766, 21.3125, 0.25);
	RemoveBuildingForPlayer(playerid, 3724, 2838.1953, -2407.1406, 29.3125, 0.25);
	RemoveBuildingForPlayer(playerid, 5158, 2837.7734, -2334.4766, 11.9922, 0.25);

	// Removals per buildingun perball PDs
	RemoveBuildingForPlayer(playerid, 4054, 1402.5000, -1682.0234, 25.5469, 0.25);
	RemoveBuildingForPlayer(playerid, 4055, 1394.3594, -1620.6641, 32.1484, 0.25);
	RemoveBuildingForPlayer(playerid, 4220, 1370.6406, -1643.4453, 33.1797, 0.25);
	RemoveBuildingForPlayer(playerid, 4005, 1402.5000, -1682.0234, 25.5469, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1379.2422, -1622.4531, 12.8672, 0.25);
	RemoveBuildingForPlayer(playerid, 4006, 1394.3594, -1620.6641, 32.1484, 0.25);

	// Metro Station 03dl
	RemoveBuildingForPlayer(playerid, 6069, 1093.875, -1630.015, 20.328, 0.250);
	RemoveBuildingForPlayer(playerid, 6070, 1093.640, -1619.164, 15.359, 0.250);
	RemoveBuildingForPlayer(playerid, 6071, 1087.984, -1682.328, 19.437, 0.250);
	RemoveBuildingForPlayer(playerid, 6194, 1116.625, -1542.906, 22.468, 0.250);
	RemoveBuildingForPlayer(playerid, 647, 1051.875, -1680.515, 14.460, 0.250);
	RemoveBuildingForPlayer(playerid, 615, 1051.250, -1678.023, 13.289, 0.250);
	RemoveBuildingForPlayer(playerid, 647, 1055.617, -1692.648, 14.460, 0.250);
	RemoveBuildingForPlayer(playerid, 647, 1058.312, -1695.765, 14.687, 0.250);
	RemoveBuildingForPlayer(playerid, 6063, 1087.984, -1682.328, 19.437, 0.250);
	RemoveBuildingForPlayer(playerid, 647, 1097.429, -1699.421, 14.687, 0.250);
	RemoveBuildingForPlayer(playerid, 647, 1101.656, -1699.562, 14.687, 0.250);
	RemoveBuildingForPlayer(playerid, 1297, 1130.539, -1684.320, 15.890, 0.250);
	RemoveBuildingForPlayer(playerid, 792, 1057.429, -1630.281, 19.703, 0.250);
	RemoveBuildingForPlayer(playerid, 792, 1075.632, -1630.281, 19.703, 0.250);
	RemoveBuildingForPlayer(playerid, 620, 1065.460, -1620.789, 19.367, 0.250);
	RemoveBuildingForPlayer(playerid, 620, 1061.531, -1617.523, 19.609, 0.250);
	RemoveBuildingForPlayer(playerid, 792, 1075.632, -1607.960, 19.703, 0.250);
	RemoveBuildingForPlayer(playerid, 792, 1093.273, -1630.281, 19.703, 0.250);
	RemoveBuildingForPlayer(playerid, 6060, 1093.875, -1630.015, 20.328, 0.250);
	RemoveBuildingForPlayer(playerid, 6110, 1093.875, -1630.015, 20.328, 0.250);
	RemoveBuildingForPlayer(playerid, 792, 1112.242, -1630.281, 19.703, 0.250);
	RemoveBuildingForPlayer(playerid, 6061, 1093.640, -1619.164, 15.359, 0.250);
	RemoveBuildingForPlayer(playerid, 3586, 1106.773, -1619.257, 15.937, 0.250);
	RemoveBuildingForPlayer(playerid, 792, 1093.273, -1607.960, 19.703, 0.250);
	RemoveBuildingForPlayer(playerid, 792, 1112.242, -1607.960, 19.703, 0.250);
	RemoveBuildingForPlayer(playerid, 6062, 1137.148, -1631.289, 14.484, 0.250);

	// Idlewood App
	RemoveBuildingForPlayer(playerid, 5536, 1866.328, -1789.781, 20.945, 0.250);
	RemoveBuildingForPlayer(playerid, 5397, 1866.328, -1789.781, 20.945, 0.250);
	RemoveBuildingForPlayer(playerid, 4025, 1777.835, -1773.906, 12.523, 0.250);
	RemoveBuildingForPlayer(playerid, 4215, 1777.554, -1775.039, 36.750, 0.250);
	RemoveBuildingForPlayer(playerid, 4019, 1777.835, -1773.906, 12.523, 0.250);

	// VineWood Station
	RemoveBuildingForPlayer(playerid, 5842, 1292.070, -1122.023, 37.406, 0.250);
	RemoveBuildingForPlayer(playerid, 727, 1319.687, -1112.906, 22.257, 0.250);
	RemoveBuildingForPlayer(playerid, 727, 1327.976, -1124.343, 21.968, 0.250);
	RemoveBuildingForPlayer(playerid, 5738, 1292.070, -1122.023, 37.406, 0.250);

	// Gas Station i Ri
	RemoveBuildingForPlayer(playerid, 17535, 2364.054, -1391.531, 41.351, 0.250);
	RemoveBuildingForPlayer(playerid, 17965, 2322.281, -1355.195, 25.406, 0.250);
	RemoveBuildingForPlayer(playerid, 17966, 2347.921, -1364.289, 27.156, 0.250);
	RemoveBuildingForPlayer(playerid, 1266, 2317.585, -1355.828, 37.218, 0.250);
	RemoveBuildingForPlayer(playerid, 17970, 2364.054, -1391.531, 41.351, 0.250);
	RemoveBuildingForPlayer(playerid, 1308, 2331.445, -1373.531, 23.093, 0.250);
	RemoveBuildingForPlayer(playerid, 17543, 2322.281, -1355.195, 25.406, 0.250);
	RemoveBuildingForPlayer(playerid, 1260, 2317.593, -1355.820, 37.226, 0.250);
	RemoveBuildingForPlayer(playerid, 620, 2336.984, -1350.578, 22.726, 0.250);
	RemoveBuildingForPlayer(playerid, 17542, 2347.921, -1364.289, 27.156, 0.250);
	RemoveBuildingForPlayer(playerid, 955, 2352.179, -1357.156, 23.773, 0.250);

	// Crenshaw Complex
	RemoveBuildingForPlayer(playerid, 3562, 2232.3984, -1464.7969, 25.6484, 0.25);
	RemoveBuildingForPlayer(playerid, 3562, 2247.5313, -1464.7969, 25.5469, 0.25);
	RemoveBuildingForPlayer(playerid, 3562, 2263.7188, -1464.7969, 25.4375, 0.25);
	RemoveBuildingForPlayer(playerid, 3562, 2243.7109, -1401.7813, 25.6406, 0.25);
	RemoveBuildingForPlayer(playerid, 3562, 2230.6094, -1401.7813, 25.6406, 0.25);
	RemoveBuildingForPlayer(playerid, 3562, 2256.6641, -1401.7813, 25.6406, 0.25);
	RemoveBuildingForPlayer(playerid, 3582, 2230.6094, -1401.7813, 25.6406, 0.25);
	RemoveBuildingForPlayer(playerid, 3582, 2243.7109, -1401.7813, 25.6406, 0.25);
	RemoveBuildingForPlayer(playerid, 3582, 2256.6641, -1401.7813, 25.6406, 0.25);
	RemoveBuildingForPlayer(playerid, 645, 2239.5703, -1468.8047, 22.6875, 0.25);
	RemoveBuildingForPlayer(playerid, 3582, 2232.3984, -1464.7969, 25.6484, 0.25);
	RemoveBuildingForPlayer(playerid, 673, 2241.8906, -1458.9297, 22.9609, 0.25);
	RemoveBuildingForPlayer(playerid, 3582, 2247.5313, -1464.7969, 25.5469, 0.25);
	RemoveBuildingForPlayer(playerid, 3582, 2263.7188, -1464.7969, 25.4375, 0.25);
	RemoveBuildingForPlayer(playerid, 3593, 2261.7734, -1441.1016, 23.5000, 0.25);
	RemoveBuildingForPlayer(playerid, 3593, 2265.0781, -1424.4766, 23.5000, 0.25);
	RemoveBuildingForPlayer(playerid, 5682, 2241.4297, -1433.6719, 31.2813, 0.25);

	// Fire House
	RemoveBuildingForPlayer(playerid, 5967, 1259.437, -1246.812, 17.109, 0.250);
	RemoveBuildingForPlayer(playerid, 1388, 1238.3750, -1258.2813, 57.2031, 0.25);
	RemoveBuildingForPlayer(playerid, 1391, 1238.375, -1258.273, 44.664, 0.250);
	RemoveBuildingForPlayer(playerid, 5857, 1259.437, -1246.812, 17.109, 0.250);
	RemoveBuildingForPlayer(playerid, 1294, 1254.689, -1276.160, 17.078, 0.250);

	// Harbour
	RemoveBuildingForPlayer(playerid, 3687, 2135.7422, -2186.4453, 15.6719, 0.25);
	RemoveBuildingForPlayer(playerid, 3687, 2162.8516, -2159.7500, 15.6719, 0.25);
	RemoveBuildingForPlayer(playerid, 3687, 2150.1953, -2172.3594, 15.6719, 0.25);
	RemoveBuildingForPlayer(playerid, 1531, 2173.5938, -2165.1875, 15.3047, 0.25);
	RemoveBuildingForPlayer(playerid, 3622, 2135.7422, -2186.4453, 15.6719, 0.25);
	RemoveBuildingForPlayer(playerid, 3622, 2150.1953, -2172.3594, 15.6719, 0.25);
	RemoveBuildingForPlayer(playerid, 3622, 2162.8516, -2159.7500, 15.6719, 0.25);

	//All Spray Tag
	RemoveBuildingForPlayer(playerid, 1490, 2046.41, -1635.84, 13.5859, 0.25);
	RemoveBuildingForPlayer(playerid, 1490, 2066.43, -1652.48, 14.2812, 0.25);
	RemoveBuildingForPlayer(playerid, 1490, 2102.20, -1648.76, 13.5859, 0.25);
	RemoveBuildingForPlayer(playerid, 1490, 2399.41, -1552.03, 28.7500, 0.25);
	RemoveBuildingForPlayer(playerid, 1490, 2353.54, -1508.21, 24.7500, 0.25);
	RemoveBuildingForPlayer(playerid, 1490, 2394.10, -1468.37, 24.7812, 0.25);

	RemoveBuildingForPlayer(playerid, 1531, 1724.73, -1741.50, 14.1016, 0.25);
	RemoveBuildingForPlayer(playerid, 1531, 1767.21, -1617.54, 15.0391, 0.25);
	RemoveBuildingForPlayer(playerid, 1531, 1799.13, -1708.77, 14.1016, 0.25);
	RemoveBuildingForPlayer(playerid, 1531, 1746.75, -1359.77, 16.2109, 0.25);
	RemoveBuildingForPlayer(playerid, 1531, 1850.01, -1876.84, 14.3594, 0.25);
	RemoveBuildingForPlayer(playerid, 1531, 1889.24, -1982.51, 15.7578, 0.25);
	RemoveBuildingForPlayer(playerid, 1531, 1950.62, -2034.40, 14.0938, 0.25);
	RemoveBuildingForPlayer(playerid, 1531, 1936.88, -2134.91, 14.2188, 0.25);
	RemoveBuildingForPlayer(playerid, 1531, 1808.34, -2092.27, 14.2188, 0.25);
	RemoveBuildingForPlayer(playerid, 1531, 2273.90, -2265.80, 14.5625, 0.25);
	RemoveBuildingForPlayer(playerid, 1531, 2173.59, -2165.19, 15.3047, 0.25);

	RemoveBuildingForPlayer(playerid, 1530, 2281.46, -1118.96, 27.0078, 0.25);
	RemoveBuildingForPlayer(playerid, 1530, 2239.78, -999.75, 59.7578, 0.25);
	RemoveBuildingForPlayer(playerid, 1530, 2122.69, -1060.90, 25.3906, 0.25);
	RemoveBuildingForPlayer(playerid, 1530, 2062.72, -996.46, 48.2656, 0.25);
	RemoveBuildingForPlayer(playerid, 1530, 2076.73, -1071.13, 27.6094, 0.25);
	RemoveBuildingForPlayer(playerid, 1530, 2841.37, -1312.96, 18.8203, 0.25);
	RemoveBuildingForPlayer(playerid, 1530, 2820.34, -1190.98, 25.6719, 0.25);
	RemoveBuildingForPlayer(playerid, 1530, 2766.09, -1197.14, 69.0703, 0.25);
	RemoveBuildingForPlayer(playerid, 1530, 2756.01, -1388.12, 39.4609, 0.25);
	RemoveBuildingForPlayer(playerid, 1530, 2821.23, -1465.09, 16.5391, 0.25);
	RemoveBuildingForPlayer(playerid, 1530, 2767.78, -1621.19, 11.2344, 0.25);
	RemoveBuildingForPlayer(playerid, 1530, 2767.76, -1819.95, 12.2266, 0.25);
	RemoveBuildingForPlayer(playerid, 1530, 2667.89, -1469.13, 31.6797, 0.25);
	RemoveBuildingForPlayer(playerid, 1530, 2612.93, -1390.77, 35.4297, 0.25);
	RemoveBuildingForPlayer(playerid, 1530, 2536.22, -1352.77, 31.0859, 0.25);
	RemoveBuildingForPlayer(playerid, 1530, 2580.95, -1274.09, 46.5938, 0.25);
	RemoveBuildingForPlayer(playerid, 1530, 2603.16, -1197.81, 60.9922, 0.25);
	RemoveBuildingForPlayer(playerid, 1530, 2576.82, -1143.27, 48.2031, 0.25);
	RemoveBuildingForPlayer(playerid, 1530, 2621.51, -1092.20, 69.7969, 0.25);
	RemoveBuildingForPlayer(playerid, 1530, 2797.92, -1097.70, 31.0625, 0.25);
	RemoveBuildingForPlayer(playerid, 1530, 1332.13, -1722.30, 14.1875, 0.25);
	RemoveBuildingForPlayer(playerid, 1530, 1732.73, -963.08, 41.4375, 0.25);
	RemoveBuildingForPlayer(playerid, 1530, 1118.91, -2008.24, 75.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 1530, 2273.20, -2529.12, 8.5156, 0.25);
	RemoveBuildingForPlayer(playerid, 1530, 2704.23, -2144.30, 11.8203, 0.25);

	RemoveBuildingForPlayer(playerid, 1529, 2379.32, -2166.22, 24.9453, 0.25);
	RemoveBuildingForPlayer(playerid, 1529, 810.57, -1797.57, 13.6172, 0.25);
	RemoveBuildingForPlayer(playerid, 1529, 730.45, -1482.01, 2.2500, 0.25);
	RemoveBuildingForPlayer(playerid, 1529, 947.48, -1466.72, 17.2422, 0.25);
	RemoveBuildingForPlayer(playerid, 1529, 399.01, -2066.88, 11.2344, 0.25);
	RemoveBuildingForPlayer(playerid, 1529, 466.98, -1283.02, 16.3203, 0.25);
	RemoveBuildingForPlayer(playerid, 1529, 583.46, -1502.11, 16.0000, 0.25);
	RemoveBuildingForPlayer(playerid, 1529, 944.27, -985.82, 39.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 1529, 1072.91, -1012.80, 35.5156, 0.25);
	RemoveBuildingForPlayer(playerid, 1529, 1206.25, -1162.00, 23.8750, 0.25);
	RemoveBuildingForPlayer(playerid, 1529, 1098.81, -1292.55, 17.1406, 0.25);

	RemoveBuildingForPlayer(playerid, 1528, 2763.00, -2012.11, 14.1328, 0.25);
	RemoveBuildingForPlayer(playerid, 1528, 2794.53, -1906.81, 14.6719, 0.25);
	RemoveBuildingForPlayer(playerid, 1528, 2812.94, -1942.07, 11.0625, 0.25);
	RemoveBuildingForPlayer(playerid, 1528, 2874.50, -1909.38, 8.3906, 0.25);

	RemoveBuildingForPlayer(playerid, 1527, 2182.23, -1467.90, 25.5547, 0.25);
	RemoveBuildingForPlayer(playerid, 1527, 2132.23, -1258.09, 24.0547, 0.25);
	RemoveBuildingForPlayer(playerid, 1527, 2233.95, -1367.62, 24.5312, 0.25);
	RemoveBuildingForPlayer(playerid, 1527, 2224.77, -1193.06, 25.8359, 0.25);
	RemoveBuildingForPlayer(playerid, 1527, 2119.20, -1196.62, 24.6328, 0.25);
	RemoveBuildingForPlayer(playerid, 1527, 2522.46, -1478.74, 24.1641, 0.25);
	RemoveBuildingForPlayer(playerid, 1527, 2322.45, -1254.41, 22.9219, 0.25);
	RemoveBuildingForPlayer(playerid, 1527, 1448.23, -1755.90, 14.5234, 0.25);
	RemoveBuildingForPlayer(playerid, 1527, 1574.71, -2691.88, 13.6016, 0.25);
	RemoveBuildingForPlayer(playerid, 1527, 1071.14, -1863.79, 14.0938, 0.25);
	RemoveBuildingForPlayer(playerid, 1527, 2392.36, -1914.57, 14.7422, 0.25);
	RemoveBuildingForPlayer(playerid, 1527, 2430.33, -1997.91, 14.7422, 0.25);
	RemoveBuildingForPlayer(playerid, 1527, 2587.32, -2063.52, 4.6094, 0.25);

	RemoveBuildingForPlayer(playerid, 1525, 1974.09, -1351.16, 24.5625, 0.25);
	RemoveBuildingForPlayer(playerid, 1525, 2093.76, -1413.45, 24.1172, 0.25);
	RemoveBuildingForPlayer(playerid, 1525, 1969.59, -1289.70, 24.5625, 0.25);
	RemoveBuildingForPlayer(playerid, 1525, 1966.95, -1174.73, 20.0391, 0.25);
	RemoveBuildingForPlayer(playerid, 1525, 1911.87, -1064.40, 25.1875, 0.25);
	RemoveBuildingForPlayer(playerid, 1525, 2462.27, -1541.41, 25.4219, 0.25);
	RemoveBuildingForPlayer(playerid, 1525, 2346.52, -1350.78, 24.2812, 0.25);
	RemoveBuildingForPlayer(playerid, 1525, 2273.02, -1687.43, 14.9688, 0.25);
	RemoveBuildingForPlayer(playerid, 1525, 2422.91, -1682.30, 13.9922, 0.25);
	RemoveBuildingForPlayer(playerid, 1525, 1549.89, -1714.52, 15.1016, 0.25);
	RemoveBuildingForPlayer(playerid, 1525, 1498.63, -1207.35, 24.6797, 0.25);
	RemoveBuildingForPlayer(playerid, 1525, 1519.42, -1010.95, 24.6094, 0.25);
	RemoveBuildingForPlayer(playerid, 1525, 1687.23, -1239.12, 15.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 1525, 1783.97, -2156.54, 14.3125, 0.25);
	RemoveBuildingForPlayer(playerid, 1525, 1624.62, -2296.24, 14.3125, 0.25);
	RemoveBuildingForPlayer(playerid, 1525, 2065.44, -1897.23, 13.6094, 0.25);
	RemoveBuildingForPlayer(playerid, 1525, 2134.33, -2011.20, 10.5156, 0.25);
	RemoveBuildingForPlayer(playerid, 1525, 1271.48, -1662.32, 20.2500, 0.25);

	RemoveBuildingForPlayer(playerid, 1524, 2162.78, -1786.07, 14.1875, 0.25);
	RemoveBuildingForPlayer(playerid, 1524, 2034.40, -1801.67, 14.5469, 0.25);
	RemoveBuildingForPlayer(playerid, 1524, 1910.16, -1779.66, 18.7500, 0.25);
	RemoveBuildingForPlayer(playerid, 1524, 1837.20, -1814.19, 4.3359, 0.25);
	RemoveBuildingForPlayer(playerid, 1524, 1837.66, -1640.38, 13.7578, 0.25);
	RemoveBuildingForPlayer(playerid, 1524, 1959.40, -1577.76, 13.7578, 0.25);
	RemoveBuildingForPlayer(playerid, 1524, 2074.18, -1579.15, 14.0312, 0.25);
	RemoveBuildingForPlayer(playerid, 1524, 2542.95, -1363.24, 31.7656, 0.25);
	RemoveBuildingForPlayer(playerid, 1524, 2704.20, -1966.69, 13.7578, 0.25);
	RemoveBuildingForPlayer(playerid, 1524, 2489.24, -1959.07, 13.7578, 0.25);
	RemoveBuildingForPlayer(playerid, 1524, 1295.18, -1465.22, 10.2812, 0.25);
	RemoveBuildingForPlayer(playerid, 1524, 482.63, -1761.59, 5.9141, 0.25);

	//LSPD Police Academy
	RemoveBuildingForPlayer(playerid, 10396, -2752.1016, -252.2422, 7.9766, 0.25);
	RemoveBuildingForPlayer(playerid, 10397, -2752.1328, -252.2344, 10.0781, 0.25);

    RemoveBuildingForPlayer(playerid, 3474, 978.28906, 2094.9922, 16.74219, 16.442955);

    //PRISON-Exterior
	RemoveBuildingForPlayer(playerid, 3366, 276.6563, 2023.7578, 16.6328, 0.25);
	RemoveBuildingForPlayer(playerid, 3366, 276.6563, 1989.5469, 16.6328, 0.25);
	RemoveBuildingForPlayer(playerid, 3366, 276.6563, 1955.7656, 16.6328, 0.25);
	RemoveBuildingForPlayer(playerid, 16619, 199.3359, 1943.8750, 18.2031, 0.25);
	RemoveBuildingForPlayer(playerid, 3267, 188.2422, 2081.6484, 22.4453, 0.25);
	RemoveBuildingForPlayer(playerid, 3277, 188.2422, 2081.6484, 22.4063, 0.25);
	RemoveBuildingForPlayer(playerid, 16294, 15.1797, 1719.3906, 21.6172, 0.25);
	RemoveBuildingForPlayer(playerid, 3267, 15.6172, 1719.1641, 22.4141, 0.25);
	RemoveBuildingForPlayer(playerid, 3277, 15.6016, 1719.1719, 22.3750, 0.25);
	RemoveBuildingForPlayer(playerid, 3267, 237.6953, 1696.8750, 22.4141, 0.25);
	RemoveBuildingForPlayer(playerid, 3277, 237.6797, 1696.8828, 22.3750, 0.25);
	RemoveBuildingForPlayer(playerid, 16293, 238.0703, 1697.5547, 21.6328, 0.25);
	RemoveBuildingForPlayer(playerid, 16093, 211.6484, 1810.1563, 20.7344, 0.25);
	RemoveBuildingForPlayer(playerid, 16638, 211.7266, 1809.1875, 18.9844, 0.25);
	RemoveBuildingForPlayer(playerid, 3279, 262.0938, 1807.6719, 16.8203, 0.25);
	RemoveBuildingForPlayer(playerid, 1411, 347.1953, 1799.2656, 18.7578, 0.25);
	RemoveBuildingForPlayer(playerid, 1411, 342.9375, 1796.2891, 18.7578, 0.25);
	RemoveBuildingForPlayer(playerid, 16670, 330.7891, 1813.2188, 17.8281, 0.25);
	RemoveBuildingForPlayer(playerid, 3279, 113.3828, 1814.4531, 16.8203, 0.25);
	RemoveBuildingForPlayer(playerid, 3279, 165.9531, 1849.9922, 16.8203, 0.25);
	RemoveBuildingForPlayer(playerid, 1697, 220.3828, 1835.3438, 23.2344, 0.25);
	RemoveBuildingForPlayer(playerid, 1697, 228.7969, 1835.3438, 23.2344, 0.25);
	RemoveBuildingForPlayer(playerid, 1697, 236.9922, 1835.3438, 23.2344, 0.25);
	RemoveBuildingForPlayer(playerid, 16095, 279.1328, 1829.7813, 16.6328, 0.25);
	RemoveBuildingForPlayer(playerid, 16094, 191.1406, 1870.0391, 21.4766, 0.25);
	RemoveBuildingForPlayer(playerid, 3279, 103.8906, 1901.1016, 16.8203, 0.25);
	RemoveBuildingForPlayer(playerid, 16096, 120.5078, 1934.0313, 19.8281, 0.25);
	RemoveBuildingForPlayer(playerid, 3279, 161.9063, 1933.0938, 16.8203, 0.25);
	RemoveBuildingForPlayer(playerid, 16323, 199.3359, 1943.8750, 18.2031, 0.25);
	RemoveBuildingForPlayer(playerid, 16671, 193.9531, 2051.7969, 20.1797, 0.25);
	RemoveBuildingForPlayer(playerid, 3279, 233.4297, 1934.8438, 16.8203, 0.25);
	RemoveBuildingForPlayer(playerid, 3279, 267.0625, 1895.2969, 16.8203, 0.25);
	RemoveBuildingForPlayer(playerid, 3268, 276.6563, 2023.7578, 16.6328, 0.25);
	RemoveBuildingForPlayer(playerid, 3268, 276.6563, 1989.5469, 16.6328, 0.25);
	RemoveBuildingForPlayer(playerid, 3268, 276.6563, 1955.7656, 16.6328, 0.25);
	RemoveBuildingForPlayer(playerid, 3267, 354.4297, 2028.4922, 22.4141, 0.25);
	RemoveBuildingForPlayer(playerid, 3277, 354.4141, 2028.5000, 22.3750, 0.25);
	RemoveBuildingForPlayer(playerid, 16668, 357.9375, 2049.4219, 16.8438, 0.25);
	RemoveBuildingForPlayer(playerid, 16669, 380.2578, 1914.9609, 17.4297, 0.25);

	// - Box
	RemoveBuildingForPlayer(playerid, 3744, 2771.0703, -2372.4453, 15.2188, 0.25);
	RemoveBuildingForPlayer(playerid, 3744, 2789.2109, -2377.6250, 15.2188, 0.25);
	RemoveBuildingForPlayer(playerid, 3744, 2774.7969, -2386.8516, 15.2188, 0.25);
	RemoveBuildingForPlayer(playerid, 3746, 2814.2656, -2356.5703, 25.5156, 0.25);
	RemoveBuildingForPlayer(playerid, 3770, 2795.8281, -2394.2422, 14.1719, 0.25);
	RemoveBuildingForPlayer(playerid, 3574, 2774.7969, -2386.8516, 15.2188, 0.25);
	RemoveBuildingForPlayer(playerid, 3574, 2771.0703, -2372.4453, 15.2188, 0.25);
	RemoveBuildingForPlayer(playerid, 3574, 2789.2109, -2377.6250, 15.2188, 0.25);
	RemoveBuildingForPlayer(playerid, 3626, 2795.8281, -2394.2422, 14.1719, 0.25);
	RemoveBuildingForPlayer(playerid, 3620, 2814.2656, -2356.5703, 25.5156, 0.25);

	//LSPD Units East Los Santos
	RemoveBuildingForPlayer(playerid, 17535, 2364.0547, -1391.5313, 41.3516, 0.25);
	RemoveBuildingForPlayer(playerid, 17965, 2322.2813, -1355.1953, 25.4063, 0.25);
	RemoveBuildingForPlayer(playerid, 1266, 2317.5859, -1355.8281, 37.2188, 0.25);
	RemoveBuildingForPlayer(playerid, 17970, 2364.0547, -1391.5313, 41.3516, 0.25);
	RemoveBuildingForPlayer(playerid, 17543, 2322.2813, -1355.1953, 25.4063, 0.25);
	RemoveBuildingForPlayer(playerid, 1260, 2317.5938, -1355.8203, 37.2266, 0.25);

	//[LSFMD] Parking lot and parking lot.
	RemoveBuildingForPlayer(playerid, 739, 1231.1406, -1341.8516, 12.7344, 0.25);
	RemoveBuildingForPlayer(playerid, 739, 1231.1406, -1328.0938, 12.7344, 0.25);
	RemoveBuildingForPlayer(playerid, 739, 1231.1406, -1356.2109, 12.7344, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1222.6641, -1374.6094, 12.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1222.6641, -1356.5547, 12.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1240.9219, -1374.6094, 12.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1240.9219, -1356.5547, 12.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1222.6641, -1335.0547, 12.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1222.6641, -1317.7422, 12.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1240.9219, -1335.0547, 12.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1240.9219, -1317.7422, 12.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1222.6641, -1300.9219, 12.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1240.9219, -1300.9219, 12.2969, 0.25);

	//LSMALL
	RemoveBuildingForPlayer(playerid, 6130, 1117.5859, -1490.0078, 32.7188, 0.25);
	RemoveBuildingForPlayer(playerid, 6255, 1117.5859, -1490.0078, 32.7188, 0.25);
	RemoveBuildingForPlayer(playerid, 792, 1128.7344, -1518.4922, 15.2109, 0.25);
	RemoveBuildingForPlayer(playerid, 792, 1111.2578, -1512.3594, 15.2109, 0.25);
	RemoveBuildingForPlayer(playerid, 792, 1106.4375, -1501.3750, 15.2109, 0.25);
	RemoveBuildingForPlayer(playerid, 792, 1144.3984, -1512.7891, 15.2109, 0.25);
	RemoveBuildingForPlayer(playerid, 792, 1152.3828, -1502.5391, 15.2109, 0.25);
	RemoveBuildingForPlayer(playerid, 792, 1118.0156, -1467.4688, 15.2109, 0.25);
	RemoveBuildingForPlayer(playerid, 955, 1154.7266, -1460.8906, 15.1563, 0.25);
	RemoveBuildingForPlayer(playerid, 792, 1139.9219, -1467.4688, 15.2109, 0.25);
	RemoveBuildingForPlayer(playerid, 792, 1139.9219, -1456.4375, 15.2109, 0.25);
	RemoveBuildingForPlayer(playerid, 792, 1118.0156, -1456.4375, 15.2109, 0.25);
	RemoveBuildingForPlayer(playerid, 792, 1139.9219, -1445.1016, 15.2109, 0.25);
	RemoveBuildingForPlayer(playerid, 792, 1118.0156, -1445.1016, 15.2109, 0.25);
	RemoveBuildingForPlayer(playerid, 792, 1139.9219, -1434.0703, 15.2109, 0.25);
	RemoveBuildingForPlayer(playerid, 792, 1118.0156, -1434.0703, 15.2109, 0.25);
	RemoveBuildingForPlayer(playerid, 615, 1147.6016, -1416.8750, 13.9531, 0.25);


	// Remove Bank

	RemoveBuildingForPlayer(playerid, 2010, 377.00781, 180.14063, 1007.375, 0.25);
	RemoveBuildingForPlayer(playerid, 2011, 371.07813, 188.92969, 1007.375, 0.25);
	RemoveBuildingForPlayer(playerid, 2001, 373.97656, 176.94531, 1007.375, 0.25);
	RemoveBuildingForPlayer(playerid, 2001, 374.00781, 170.64063, 1007.375, 0.25);
	RemoveBuildingForPlayer(playerid, 2001, 363.46094, 158.6875, 1007.375, 0.25);
	RemoveBuildingForPlayer(playerid, 2001, 359.86719, 158.6875, 1007.375, 0.25);
	RemoveBuildingForPlayer(playerid, 2001, 364.60156, 170.64844, 1007.375, 0.25);
	RemoveBuildingForPlayer(playerid, 2001, 364.66406, 176.97656, 1007.375, 0.25);
	RemoveBuildingForPlayer(playerid, 2190, 360.10156, 171.82031, 1008.1016, 0.25);
	RemoveBuildingForPlayer(playerid, 2190, 360.3125, 174.96094, 1008.1016, 0.25);
	RemoveBuildingForPlayer(playerid, 2163, 353.53906, 175.16406, 1007.375, 0.25);
	RemoveBuildingForPlayer(playerid, 2164, 353.53906, 169.61719, 1007.375, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 354.95313, 168.54688, 1007.3672, 0.25);
	RemoveBuildingForPlayer(playerid, 2190, 357.29688, 168.77344, 1008.2813, 0.25);
	RemoveBuildingForPlayer(playerid, 2190, 357.29688, 166.03906, 1008.2813, 0.25);
	RemoveBuildingForPlayer(playerid, 2190, 357.29688, 162.95313, 1008.2813, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 355.85156, 163.24219, 1007.3672, 0.25);
	RemoveBuildingForPlayer(playerid, 2186, 355.51563, 158.71875, 1007.3359, 0.25);
	RemoveBuildingForPlayer(playerid, 2202, 354.05469, 160.69531, 1007.3359, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 355.85156, 178.86719, 1007.3672, 0.25);
	RemoveBuildingForPlayer(playerid, 2190, 357.29688, 178.45313, 1008.2813, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 355.85156, 182.40625, 1007.3672, 0.25);
	RemoveBuildingForPlayer(playerid, 2190, 357.29688, 182.41406, 1008.2813, 0.25);
	RemoveBuildingForPlayer(playerid, 1806, 355.85156, 186.3125, 1007.3672, 0.25);
	RemoveBuildingForPlayer(playerid, 2190, 357.29688, 186.03125, 1008.2813, 0.25);
	RemoveBuildingForPlayer(playerid, 2169, 354.33594, 189.125, 1007.3828, 0.25);
	RemoveBuildingForPlayer(playerid, 2162, 353.52344, 183.64063, 1007.375, 0.25);
	RemoveBuildingForPlayer(playerid, 2161, 353.59375, 181.83594, 1007.375, 0.25);
	RemoveBuildingForPlayer(playerid, 2163, 353.53906, 179.51563, 1007.375, 0.25);
	RemoveBuildingForPlayer(playerid, 2164, 353.59375, 177.75, 1007.375, 0.25);
	RemoveBuildingForPlayer(playerid, 2167, 353.53906, 173.88281, 1007.375, 0.25);
	RemoveBuildingForPlayer(playerid, 2164, 353.53906, 163.73438, 1007.375, 0.25);
	RemoveBuildingForPlayer(playerid, 2164, 353.53906, 167.84375, 1007.375, 0.25);
	RemoveBuildingForPlayer(playerid, 2164, 353.53906, 166.07031, 1007.375, 0.25);
    RemoveBuildingForPlayer(playerid, 2002, 354.03125, 187.40625, 1007.375, 0.25);

    // Remove the original mall mesh
	RemoveBuildingForPlayer(playerid, 6130, 1117.5859, -1490.0078, 32.7188, 10.0);

	// This is the mall mesh LOD
	RemoveBuildingForPlayer(playerid, 6255, 1117.5859, -1490.0078, 32.7188, 10.0);

	// There are some trees on the outside of the mall which poke through one of the interiors
	RemoveBuildingForPlayer(playerid, 762, 1175.3594, -1420.1875, 19.8828, 0.25);
	RemoveBuildingForPlayer(playerid, 615, 1166.3516, -1417.6953, 13.9531, 0.25);

	//Parking next to the pump. Idlewood
	RemoveBuildingForPlayer(playerid, 712, 1929.5781, -1694.4609, 21.3906, 0.25);

	//Store Row El Corona
	RemoveBuildingForPlayer(playerid, 3625, 1941.9844, -1970.7031, 14.9844, 0.25);

    //Market Place
	RemoveBuildingForPlayer(playerid, 1412, 2305.9375, -1394.1641, 24.1953, 0.25);

	//Bone Country
	RemoveBuildingForPlayer(playerid, 16060, -192.0469, 1147.3906, 17.6953, 0.25);
}

CreateTextLabels()
{
    CreateDynamic3DTextLabel("Use {FE9A2E}/buy{FFFFFF} to buy a phone cover.", COLOR_WHITE, 1086.8405,-1449.5437,22.7434, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1);
	CreateDynamic3DTextLabel("/buy\nTo see a list of available sporting items.", COLOR_WHITE, 1112.4480,-1527.4012,15.7981, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1);
	CreateDynamic3DTextLabel("/buy\nto see a list of available clothing accessories.\n{F2EB35}/clothing to edit clothing.", COLOR_WHITE, 1096.2791,-1439.8060,15.7981, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1);
	CreateDynamic3DTextLabel("/buy\nto buy an advertisement sign.", COLOR_WHITE, 1163.0109,-1470.7698,15.7941, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1);
	CreateDynamic3DTextLabel("/buy\nTo see a list of available music items.", COLOR_WHITE, 1090.9180,-1506.6713,15.7963, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1);
}

CreateRentalVehicles()
{
    CarRent[0]	= 	AddStaticVehicleEx(547, 1560.6539, -2308.6860, 13.2243, 269.4922, 44, 44, 2000, 0); // Rental1
	CarRent[1] 	=	AddStaticVehicleEx(547, 1560.6132, -2312.2026, 13.2313, 270.1551, 1, 1, 2000, 0); // Rental2
	CarRent[2] 	=	AddStaticVehicleEx(492, 1560.6182, -2315.4185, 13.2855, 269.4268, 1, 1, 2000, 0); // Rental3
	CarRent[3] 	=	AddStaticVehicleEx(492, 1560.6764, -2318.8120, 13.2605, 269.8419, 1, 63, 2000, 0); // Rental4
	CarRent[4] 	=	AddStaticVehicleEx(422, 1561.0686, -2321.9712, 13.5576, 271.9287, 0, 0, 2000, 0); // Rental5
	CarRent[5] 	=	AddStaticVehicleEx(422, 1560.9653, -2325.2834, 13.5343, 270.1995, 234, 234, 2000, 0); // Rental6
	CarRent[6] 	=	AddStaticVehicleEx(422, 1560.9603, -2328.6404, 13.5333, 269.2777, 248, 248, 2000, 0); // Rental7
	CarRent[7] 	=	AddStaticVehicleEx(422, 1560.9431, -2331.9175, 13.5347, 270.4479, 186, 186, 2000, 0); // Rental8

	CarRent[8] 	= 	AddStaticVehicleEx(492, 1647.9091, -2314.5737, -2.9627, 269.6167, 0, 0, 2000, 0); // Rental1

	CarRent[9] 	=	AddStaticVehicleEx(492, 1581.7928, -2286.4404, -3.0968, 1.6838,3, 3, 2000, 0); // Rental2
	CarRent[10] = 	AddStaticVehicleEx(422, 1132.6156, -928.0043, 43.1408, 179.2776, 53, 53, 2000, 0); // RentalTemple1
	CarRent[11] = 	AddStaticVehicleEx(422, 1129.2689, -928.0464, 43.1409, 179.4783, 53, 53, 2000, 0); // RentalTemple2
	CarRent[12] = 	AddStaticVehicleEx(547, 1125.9172, -928.2659, 42.8814, 180.5254, 53, 53, 2000, 0); // RentalTemple3
	CarRent[13] = 	AddStaticVehicleEx(547, 1122.4514, -928.3840, 42.8762, 179.7937, 53, 53, 2000, 0); // RentalTemple4
	CarRent[14] =   AddStaticVehicleEx(492, 2431.0891, -1242.5952, 24.1342, 180.1788, 0, 0, 2000, 0); // East Los Santos / Pig Pen
	CarRent[15] =   AddStaticVehicleEx(492, 2427.5713, -1242.5952, 23.9811, 180.1788, 0, 0, 2000, 0); // East Los Santos / Pig Pen

	CarRent[16] =   AddStaticVehicleEx(492, 1667.4218, -2314.7898, -2.9757, 269.9921, 0, 0, 2000, 0); // Airport

	/*CarRent[16] =   AddStaticVehicleEx(492, 1657.2308, -2314.7529, -2.9780, 269.8067, 0, 0, 2000, 0); // Airport
	CarRent[17] =   AddStaticVehicleEx(492, 1667.4218, -2314.7898, -2.9757, 269.9921, 0, 0, 2000, 0); // Airport
	CarRent[18] =   AddStaticVehicleEx(492, 1691.5570, -2314.8240, -2.9748, 270.1819, 0, 0, 2000, 0); // Airport
	CarRent[19] =   AddStaticVehicleEx(492, 1703.7242, -2314.7913, -2.9772, 270.3328, 0, 0, 2000, 0); // Airport*/

    for(new c = 0; c < sizeof(CarRent); ++c)
    {
		ResetVehicle(CarRent[c]);
		SetVehicleNumberPlate(CarRent[c], "{000000}RENTAL");
		SetVehicleHealth(CarRent[c], GetVehicleDataHealth(GetVehicleModel(CarRent[c])));

        Iter_Add(sv_vehicles, CarRent[c]);
        systemVariables[vehicleCounts][0]++;
    }
}

CreateLicenseVehicles()
{
    CarDMV[0] = AddStaticVehicle(405, 1274.8179, -1551.0402, 13.2833, 270.4145, 1, 1); //  Sentinel
	CarDMV[1] = AddStaticVehicle(405, 1274.6558, -1560.1385, 13.2891, 269.5308, 1, 1); //  Sentinel
	CarDMV[2] = AddStaticVehicle(438, 1286.9663, -1529.9735, 13.5456, 270.5405, 1, 1); // cabbie license exam1
	CarDMV[3] = AddStaticVehicle(438, 1272.5927, -1534.6504, 13.5632, 269.5325, 1, 1); // cabbie license exam2

    for(new c = 0; c < sizeof(CarDMV); ++c)
    {
		ResetVehicle(CarDMV[c]);

		SetVehicleNumberPlate(CarDMV[c], "DMV");
		SetVehicleHealth(CarDMV[c], GetVehicleDataHealth(GetVehicleModel(CarDMV[c])));

        Iter_Add(sv_vehicles, CarDMV[c]);
        systemVariables[vehicleCounts][0]++;
    }
}

ApplyAnimationEx(playerid, const animlib[], const animname[], Float:fDelta, loop, lockx, locky, freeze, time, forcesync = 0)
{
	if(PlayerData[playerid][pInjured])
	    return false;

	ApplyAnimation(playerid, animlib, animname, fDelta, loop, lockx, locky, freeze, time, forcesync);
	return true;
}

ResetPlayer(playerid)
{
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	DisablePlayerRaceCheckpoint(playerid);
	DisablePlayerCheckpoint(playerid);
	HidePlayerFooter(playerid);
	GameTextForPlayer(playerid, " ", 1, 3);
}

ResetStatistics(playerid) // Clear player Stats
{
	PlayerData[playerid][pAdmin] = 0;

    //master account data
	AccountData[playerid][aConnectionID] = 0;
	AccountData[playerid][aUserid] = -1;
	AccountData[playerid][aUsername][0] = EOS;
	AccountData[playerid][aEmail][0] = EOS;
	AccountData[playerid][aSecretWord][0] = EOS;
	AccountData[playerid][aCombinedLevel][0] = 0;
	AccountData[playerid][aCombinedLevel][1] = 0;

    DeathStamp[playerid] = 0;
    ViewingParticle[playerid] = -1;
    RemovingParticle[playerid] = -1;
    WatchRadio[playerid] = 0;
    AFKCount[playerid] = 0;
    IsAFK{playerid} = false;
	death_Pause[playerid] = 0;

	PlayerFlags[playerid][toggleHUD] = false;
	PlayerFlags[playerid][factionChat] = false;
	PlayerFlags[playerid][toggleOOC] = false;
	PlayerFlags[playerid][toggleNews] = false;
	PlayerFlags[playerid][joinAlerts] = false;
	PlayerFlags[playerid][adminAlerts] = false;

    ParticleSettings[playerid][usingParticle] = false;
	ParticleSettings[playerid][particleObjectID] = 0;
	ParticleSettings[playerid][particleOperation] = PARTICLE_MODE_CREATE;
	ParticleSettings[playerid][particleEditMode] = 0;
	ParticleSettings[playerid][particleEditID] = -1;

    ConnectStamp[playerid] = 0;

 	PlayerLogs[playerid][searchingPlayer] = INVALID_PLAYER_ID;
	PlayerLogs[playerid][searchingSQLID] = -1;
	PlayerLogs[playerid][searchingName][0] = EOS;
	PlayerLogs[playerid][searchingFilter][0] = EOS;
	PlayerLogs[playerid][searchingOffset] = 0;

    BreakingIn[playerid] = -1;

    FactionPermissions[playerid] = 16;

    DeathReason[playerid] = 0;

    LicenseOffer[playerid] = INVALID_PLAYER_ID;
    ViewingLicense[playerid] = INVALID_PLAYER_ID;

    FinishedTutorial{playerid} = false;
    HUD_Created{playerid} = false;
    HudShown{playerid} = false;
    ForceKnockout{playerid} = false;
    ShowMain{playerid} = true;
 	TesterDuty{playerid} = false;
    AdminDuty{playerid} = false;
    TimeTip{playerid} = false;
    UI_Purchase{playerid} = false;
    FirstSpawn{playerid} = false;
    ALPR_Enabled{playerid} = true;
    ALPR_Hit{playerid} = false;
    EnableTP{playerid} = false;
    FactionEars{playerid} = false;
    PrivateMessageEars{playerid} = false;
    Unpackaging{playerid} = false;
    UsingMDC{playerid} = false;
    MDC_Created{playerid} = false;
    TesterColor{playerid} = false;
    ReplacingGraffiti{playerid} = false;
    EditingGraffiti{playerid} = false;
    HasCheckpoint{playerid} = false;
	KnockedOut{playerid} = false;
	HudStatus{playerid} = false;
	TagColor{playerid} = false;

    if(SwitchingWeapon{playerid})
    {
        KillTimer(EquipTimer[playerid]);

        SwitchingWeapon{playerid} = false;
	}

    PlayerSerial[playerid][0] = EOS;
    LastSerial[playerid][0] = EOS;
    LastLogin[playerid] = 0;

    PlayerCell[playerid] = -1;

    CallSign[playerid][0] = EOS;

    ResetMDCData(playerid);

    ToggleNames{playerid} = false;

    RequestedToShake[playerid][0] = INVALID_PLAYER_ID;
    RequestedToShake[playerid][1] = 0;
    RequestedToShake[playerid][2] = 0;

	for(new i = 0; i < MAX_FRIENDS; ++i)
	{
	    Friends[playerid][i][friendID] = 0;

		if(i < 40) ContactData[playerid][i][contactNumber] = 0;

		if(i < MAX_SMS) SmsData[playerid][i][smsExist] = false;

		if(i < MAX_PLAYER_DRUGS)
		{
			Player_Drugs[playerid][i][dID] = -1;
			Player_Drugs[playerid][i][dType] = -1;
			Player_Drugs[playerid][i][dStorage] = -1;
			Player_Drugs[playerid][i][dAmount] = 0.0;
			Player_Drugs[playerid][i][dStrength] = 0.0;
			Player_Drugs[playerid][i][dStamp] = 0;
		}

		if(i < 3)
		{
			TempWeapons[playerid][i][0] = 0;
			TempWeapons[playerid][i][1] = 0;
		}

		if(i < MAX_CLOTHES)
		{
		    cl_dataslot[playerid][i] = -1;
			ClothingData[playerid][i][cl_object] = 0;
		}

		if(i < MAX_CHARACTERS)
		{
		    CharSelection[playerid][i] = -1;
		}

		if(i < 10)
		{
		    RoadBlocks[playerid][i][roadblockObject] = INVALID_OBJECT_ID;
		}

		if(i < MAX_ATTACH_WEAPON)
		{
			WeaponSettings[playerid][i][awID] = 0;
			WeaponSettings[playerid][i][awHide] = 0;
			WeaponSettings[playerid][i][awBone] = 1;
			WeaponSettings[playerid][i][aPx] = -0.116;
			WeaponSettings[playerid][i][aPy] = 0.189;
			WeaponSettings[playerid][i][aPz] = 0.088;
			WeaponSettings[playerid][i][aPrx] = 0.0;
			WeaponSettings[playerid][i][aPry] = 44.5;
			WeaponSettings[playerid][i][aPrz] = 0.0;
		}

		if(i < 5)
		{
		    ChargesSelected[playerid][i][0] = -1;
		    ChargesSelected[playerid][i][1] = -1;
		}

		if(i < MAX_PLAYERS)
		{
	        FriskApproved[playerid][i] = 0;

            ReadingPMs[playerid][i] = 0;

            BlockedPM[playerid][i] = 0;
            BlockedOOC[playerid][i] = 0;
		}
		
		if(i < MAX_BUSINESS)
		{
            BizzEntrance[playerid][i] = 0;
		}

		if(i < 10)
		{
	    	AdminActions[playerid][i][actionID] = 0;
	    	LastCheatDetection[playerid][i] = 0;
		}

		if(i < 9)
		{
		    PlayerData[playerid][pRadioChan][i] = 0;
		}

		if(i < 6)
		{
			CharacterCache[playerid][i] = -1;
			VehicleCache[playerid][i] = -1;

			VDealerData[playerid][i][0] = 0;
			VDealerData[playerid][i][1] = -1;
			VDealerData[playerid][i][2] = -1;
			VDealerData[playerid][i][3] = 0;
			VDealerData[playerid][i][4] = 0;
		}

		if(i < MAX_MARKERS)
		{
			Markers[playerid][i][markerPos][0] = 0.0;
			Markers[playerid][i][markerPos][1] = 0.0;
			Markers[playerid][i][markerPos][2] = 0.0;
		}

	    if(i < 13)
	    {
			PlayerData[playerid][pGuns][i] = 0;
			PlayerData[playerid][pAmmo][i] = 0;
		}

		if(i < 3)
		{
		    PlayerData[playerid][pWeapon][i] = 0;
		    PlayerData[playerid][pAmmunation][i] = 0;
		}

		if(i < MAX_PLAYER_WEAPON_PACKAGE)
		{
			PlayerData[playerid][pPackageWP][i] = 0;
			PlayerData[playerid][pPackageAmmo][i] = 0;
		}

		if(i < 10)
		{
			PlayerData[playerid][pDupKeys][i] = 9999;
		}

	    if(i < MAX_VEHICLE_KEYS)
		{
			PlayerData[playerid][pCarKeys][i] = 9999;
		}
	}

    WeaponSettings[playerid][0][awWid] = 3;
    WeaponSettings[playerid][1][awWid] = 4;
    WeaponSettings[playerid][2][awWid] = 5;
    WeaponSettings[playerid][3][awWid] = 8;
    WeaponSettings[playerid][4][awWid] = 22;
    WeaponSettings[playerid][5][awWid] = 23;
    WeaponSettings[playerid][6][awWid] = 24;
    WeaponSettings[playerid][7][awWid] = 25;
    WeaponSettings[playerid][8][awWid] = 26;
    WeaponSettings[playerid][9][awWid] = 27;
    WeaponSettings[playerid][10][awWid] = 28;
    WeaponSettings[playerid][11][awWid] = 29;
    WeaponSettings[playerid][12][awWid] = 30;
    WeaponSettings[playerid][13][awWid] = 31;
    WeaponSettings[playerid][14][awWid] = 32;
    WeaponSettings[playerid][15][awWid] = 33;
    WeaponSettings[playerid][16][awWid] = 34;

    EntranceArea[playerid] = -1;

    DeletingATM{playerid} = false;
    BouttaDelete[playerid] = -1;
    EditingATM[playerid] = -1;
    LastWeapon[playerid] = 0;

    SprayingFont[playerid] = 0;
    SprayingType[playerid] = 0;

	PfSpec[playerid][CamPos][0] = 0;
	PfSpec[playerid][CamPos][1] = 0;
	PfSpec[playerid][CamPos][2] = 0;
	PfSpec[playerid][mdir] = 0;
	PfSpec[playerid][updownold] = 0;
	PfSpec[playerid][leftrightold] = 0;
	PfSpec[playerid][FlySpec] = 0;

	/*TracingProgress[playerid] = 0;
 	TracingTowerData[playerid][0] = 0;
 	TracingTowerData[playerid][1] = 0;
	TraceString[playerid][0] = EOS;
	Tracing{playerid} = false;*/

	WritingArrest[playerid] = INVALID_PLAYER_ID;

	PlayerData[playerid][pMainSlot] = 1;

	SaveDamages(playerid);
    ClearDamages(playerid);
    ResetCooldowns(playerid);
    ResetPlayerMoney(playerid);
    CancelSelectTextDraw(playerid);

	AccountChecked{playerid} = false;
	LoggedIn{playerid} = false;
	Spawned{playerid} = false;
	BeingKicked{playerid} = false;
	IsMasked{playerid} = false;
	IsTazed{playerid} = false;
	IsCuffed{playerid} = false;
	IsTied{playerid} = false;
	Blindfold{playerid} = false;
	EditingWeapon{playerid} = false;
	Convo{playerid} = false;
	AutoLow{playerid} = false;
	EditClothing{playerid} = false;
	BuyClothing{playerid} = false;
	PassingDrugs{playerid} = false;
	LessonStarted{playerid} = false;

	HelpingPlayer[playerid] = INVALID_PLAYER_ID;

    BrokenLegTimer[playerid] = 0;
    LastKnockout[playerid] = 0;
    TackleMode{playerid} = false;

	PlayerData[playerid][pSprayPermission] = 0;

	cl_selected[playerid] = -1; cl_index[playerid] = -1;
	cl_buying[playerid] = 0; cl_buyingpslot[playerid] = -1;

    FishingPlace[playerid] = -1;
	TazerActive{playerid} = false;
	BeanbagActive{playerid} = false;
	ConvoID[playerid] = INVALID_PLAYER_ID;
	MedicBill[playerid] = 0;
	gLastCar[playerid] = 0;
	SafeTime[playerid] = 60;
	DeathMode{playerid} = false;
	DeathTimer[playerid] = 120;
    TaxiDuty{playerid} = false;
	TaxiFare{playerid} = 0;
	TaxiStart{playerid} = false;
	TaxiMoney[playerid] = 0;
	TaxiMade[playerid] = 0;

    InProperty[playerid] = -1;
    InApartment[playerid] = -1;
    InBusiness[playerid] = -1;
	InGarage[playerid] = -1;
	GrantBuild[playerid] = -1;

	LoginAttempts[playerid] = 5;

    gPlayerCheckpointValue[playerid] = -1;
    gPlayerCheckpointStatus[playerid] = CHECKPOINT_NONE;

    nearProperty_var[playerid] = -1;
    nearApartment_var[playerid] = -1;

	serviceComp[playerid] = 0;
	serviceTowtruck[playerid] = 0;
	serviceCustomer[playerid] = 0;
	serviceFocus[playerid] = 0;
	serviced[playerid] = 0;
	RepairTime{playerid} = 0;

	PlayerData[playerid][pHUDStyle] = 0;

    RepairTime{playerid} = 0;

    carryCrate[playerid] = -1;

    RentCarKey[playerid] = 0;

    PlayerPlaceCar[playerid] = -1;
    PlayerPlaceSlot[playerid] = -1;

    deleyAC_Nop{playerid} = false;

    selfie_timer[playerid] = 0;

    far_start[playerid] = 0;
	far_place[playerid] = 0;
	far_veh[playerid] = INVALID_VEHICLE_ID;

	h_vid[playerid] = -1; h_times[playerid] = 0; h_wid[playerid] = -1; h_score[playerid] = 0; h_failed[playerid] = 0;
    h_word[playerid][0]='\0';

    PCoverOpening{playerid} = false;
	PCoverColor[playerid] = 0;
	PCarOpening{playerid} = false;
	PCarPage[playerid] = 1;
    PCarType[playerid] = 0;

	VDealerSelectCatalog[playerid] = -1;

	PhoneOpen{playerid} = false;

	ph_menuid[playerid] = 0;
	ph_sub_menuid[playerid] = 0;
	ph_select_data[playerid] = -1;
	ph_selected[playerid] = 0;
	ph_page[playerid] = 0;
	ph_airmode[playerid] = 0;
	ph_silentmode[playerid] = 0;
    ph_CallTone[playerid] = 0;
    ph_TextTone[playerid] = 0;
    ph_speaker{playerid} = false;

    calltimer[playerid] = 0;
    smstimer[playerid] = 0;

    pToAccept[playerid] = INVALID_PLAYER_ID;
	vToAccept[playerid] = 9999;
	prToAccept[playerid] = 0;
	tToAccept[playerid] = 0;

    PRestaurantOpening{playerid} = false;
	MealHolding[playerid] = 0;
	MealObject[playerid] = -1;

    FishCooldown[playerid] = 0;
    adTick[playerid] = 0;

	BoomboxData[playerid][boomboxPlaced] = false;
	BoomboxData[playerid][boomboxOn] = false;
	BoomboxData[playerid][boomboxPos][0] = 0.0;
	BoomboxData[playerid][boomboxPos][1] = 0.0;
	BoomboxData[playerid][boomboxPos][2] = 0.0;

	PlayerData[playerid][pBoombox] = 0;
	PlayerData[playerid][pGasCan] = 0;
	PlayerData[playerid][pCigarettes] = 0;
	PlayerData[playerid][pDrink] = 0;
	PlayerData[playerid][pHasLabel] = 0;
	PlayerData[playerid][pID] = -1;
	PlayerData[playerid][pTutorial] = 0;
	PlayerData[playerid][pTutorialStep] = 0;
    PlayerData[playerid][pModel] = 0;
    PlayerData[playerid][pPhoneModel] = 0;
    PlayerData[playerid][pPnumber] = 0;
	PlayerData[playerid][pContractTime] = 0;
	PlayerData[playerid][pPos] = 0.0;
	PlayerData[playerid][pSHealth] = 50.0;
	PlayerData[playerid][pArmour] = 0.0;
	PlayerData[playerid][pHealth] = 150.0;
    PlayerData[playerid][pInterior] = 0;
    PlayerData[playerid][pWorld] = 0;
    PlayerData[playerid][pInjured] = 0;
    PlayerData[playerid][pTimeout] = 0;
	PlayerData[playerid][pTimeoutType][0] = -1;
	PlayerData[playerid][pTimeoutType][1] = -1;
	PlayerData[playerid][pTimeoutType][2] = -1;
    PlayerData[playerid][pSpawnPoint] = 0;
    PlayerData[playerid][pOnDuty] = 0;
    PlayerData[playerid][pOnDutySkin] = 0;
    PlayerData[playerid][pFavUniform] = 0;
    PlayerData[playerid][pLocal] = 255;
    PlayerData[playerid][pHouseKey] = -1;
	PlayerData[playerid][pComplexKey] = -1;
	PlayerData[playerid][pAdmin] = 0;
    PlayerData[playerid][pJob] = 0;
    PlayerData[playerid][pSideJob] = 0;
    PlayerData[playerid][pJobRank] = 0;
    PlayerData[playerid][pADPoint] = 0;
    PlayerData[playerid][pCareer] = 0;
    PlayerData[playerid][pPlayingSeconds] = 0;
    PlayerData[playerid][pLevel] = 1;
    PlayerData[playerid][pExp] = 0;
    PlayerData[playerid][pExpCounter] = 0;
    PlayerData[playerid][pDonateRank] = 0;
	PlayerData[playerid][pDonateUnix] = 0;
 	PlayerData[playerid][pPayDay] = 0;
	PlayerData[playerid][pPayDayHad] = 0;
	PlayerData[playerid][pPayCheck] = 0;
	PlayerData[playerid][pChequeCash] = 0;
	PlayerData[playerid][pAccount] = 0;
	PlayerData[playerid][pCash] = 0;
	PlayerData[playerid][pSavings] = 0;
	PlayerData[playerid][pSavingsCollect] = 0;
	PlayerData[playerid][pDrugStamp] = 0;
    PlayerData[playerid][pDrugEffects] = -1;
    PlayerData[playerid][pDrugBoost] = 0;
    PlayerData[playerid][pDrugTick] = 0;
    PlayerData[playerid][pDepartment] = 0;
    PlayerData[playerid][pHandCuffs] = 0;
	PlayerData[playerid][pFishes] = 0;
 	PlayerData[playerid][pJailed] = 0;
 	PlayerData[playerid][pSentenceTime] = 0;

    // Checkpoint Mission
    PlayerData[playerid][pCP_Type] = -1;
    PlayerData[playerid][pCP_X] = 0.0;
    PlayerData[playerid][pCP_Y] = 0.0;
    PlayerData[playerid][pCP_Z] = 0.0;

  	PlayerData[playerid][pCellTime] = 0;
	PlayerData[playerid][pCallLine] = INVALID_PLAYER_ID;
	PlayerData[playerid][pCallConnect] = INVALID_PLAYER_ID;
	PlayerData[playerid][pIncomingCall] = 0;
	PlayerData[playerid][pCallNumb] = 0;
	PlayerData[playerid][pFactionOffer] = INVALID_PLAYER_ID;
	PlayerData[playerid][pFactionOffered] = -1;
	PlayerData[playerid][pFaction] = -1;
	PlayerData[playerid][pFactionID] = -1;
	PlayerData[playerid][pFactionRank] = 0;
	PlayerData[playerid][pFactionEdit] = -1;
	PlayerData[playerid][pSwat] = false;
	PlayerData[playerid][pFireman] = false;
	PlayerData[playerid][pSelectedSlot] = -1;
	PlayerData[playerid][pShowFooter] = 0;
	PlayerData[playerid][pFreeze] = 0;
	PlayerData[playerid][pAdminFreeze] = 0;
	PlayerData[playerid][pMuted] = 0;
	PlayerData[playerid][pPCarkey] = 9999;
    PlayerData[playerid][pHasMask] = 0;
    PlayerData[playerid][pMaskID][0] = 0;
    PlayerData[playerid][pMaskID][1] = 0;
    PlayerData[playerid][pFightStyle] = 1;
	PlayerData[playerid][pPrimaryLicense] = 0;
	PlayerData[playerid][pSecondaryLicense] = 0;
	PlayerData[playerid][pSpectating] = INVALID_PLAYER_ID;

	TotalPlayerDamages[playerid] = 0;

	PlayerData[playerid][pReport] = 0;
	PlayerData[playerid][pReportPlayer] = 0;
	PlayerData[playerid][pHelpme] = 0;
	PlayerData[playerid][pHelpmeSeconds] = 0;
	PlayerData[playerid][pReportMessage][0] = EOS;
	PlayerData[playerid][pReportStamp] = 0;
    PlayerData[playerid][pAttribute][0] = EOS;
	PlayerData[playerid][pMask_Name][0] = EOS;

	PlayerData[playerid][pWalk] = 1;
	PlayerData[playerid][pTalk] = 0;
	PlayerData[playerid][pHUDStyle] = 0;
	PlayerData[playerid][pJog] = 1;

	PlayerData[playerid][pLastVehicle] = INVALID_VEHICLE_ID;

	GraffiModel[playerid] = 19482;
	GraffitiName[playerid][0] = EOS;

	format(GraffitiFont[playerid], 24, "Arial");
}

TerminateConnection(playerid, reason)
{
	if(Unpackaging{playerid}) KillTimer(UnpackageTimer[playerid]);

	RemovePrisonLabel(playerid);

	new vehicleid, carid;

	for(new i = 0; i < 100; ++i)
	{
	    if(VehicleRequests[i][requestActive])
		{
			if(VehicleRequests[i][requestPlayer] == playerid)
			{
				TrashVehicleRequest(i);
			}
		}

	    if(i < 10)
	    {
			if(RoadBlocks[playerid][i][roadblockObject] != INVALID_OBJECT_ID)
			{
				DisbandRoadblock(playerid, i);
			}	
	    }

		if(i < MAX_AD_QUEUE)
		{
			if(AdvertData[i][ad_owner] == playerid)
			{
				AdvertData[i][ad_id] = 0;
				AdvertData[i][ad_time] = 0;
				AdvertData[i][ad_owner] = INVALID_PLAYER_ID;

				if(!aTolls[i][E_tOpenTime] && !VehicleLabel[i][vLabelTime]) Iter_Remove(sv_activevehicles, i);
			}
		}		

		if(i < MAX_VEHICLE_KEYS)
		{
			carid = PlayerData[playerid][pCarKeys][i];

			if(carid != 9999)
			{
				if(Iter_Contains(sv_playercar, carid))
				{
					vehicleid = CarData[carid][carVehicle];

					if(CoreVehicles[vehicleid][vOwnerID] != INVALID_PLAYER_ID && CoreVehicles[vehicleid][vOwnerID] == playerid)
					{
						if(VehicleLabel[vehicleid][vLabelTime])
						{
							if(!CoreVehicles[vehicleid][vbreaktime]) Iter_Remove(sv_activevehicles, vehicleid);

							ResetVehicleLabel(vehicleid);

							CoreVehicles[vehicleid][vOwnerID] = INVALID_PLAYER_ID;
							CoreVehicles[vehicleid][vUpgradeID] = 0;
						}
					}
				}	
			}		
		}
	}

    if(PlayerData[playerid][pInTuning]) Tuning_ExitDisplay(playerid, true);

	if(ReplacingGraffiti{playerid})
	{
	    KillTimer(spraytimer[playerid]);
	}

	if(HelpingPlayer[playerid] != INVALID_PLAYER_ID)
	{
	    new userid = HelpingPlayer[playerid];

	    if(!KnockedOut{playerid})
	    {
	        KillTimer(HelpUpTimer[userid]);

	        HelpupStage[userid] = 0;
			
			if(IsValidDynamic3DTextLabel(KnockoutLabel[userid])) DestroyDynamic3DTextLabel(KnockoutLabel[userid]);
	    }
	    else
	    {
	        KillTimer(HelpUpTimer[playerid]);

	        HelpupStage[playerid] = 0;

			if(IsValidDynamic3DTextLabel(KnockoutLabel[playerid])) DestroyDynamic3DTextLabel(KnockoutLabel[playerid]);
	    }

	    HelpingPlayer[userid] = INVALID_PLAYER_ID;
	    HelpingPlayer[playerid] = INVALID_PLAYER_ID;
	}	

	if(TaxiMoney[playerid] > 0 && IsPlayerInAnyVehicle(playerid))
	{
    	gPassengerCar[playerid] = GetPlayerVehicleID(playerid);

		ChargePerson(playerid);
	}

	if(BoomboxData[playerid][boomboxPlaced])
	{
		Boombox_Destroy(playerid);

		foreach (new i : Player)
		{
			if(grantboombox[i] == playerid)
			{
				grantboombox[i] = INVALID_PLAYER_ID;
			}
		}
	}

	if(BreakingIn[playerid] != -1)
	{
		new breakingcar = BreakingIn[playerid];

		CancelVehicleBreakin(breakingcar);

		if(IsValidVehicle(breakingcar))
		{
			new
				engine,
				lights,
				alarm,
				doors,
				bonnet,
				boot,
				objective;

			GetVehicleParamsEx(breakingcar, engine, lights, alarm, doors, bonnet, boot, objective);
			SetVehicleParamsEx(breakingcar, engine, lights, 0, doors, bonnet, boot, 0);	
		}
	}

	if(AdminDuty{playerid}) SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmCmd: %s is now off admin duty. (disconnected)", AccountName(playerid));

	if(TesterDuty{playerid}) SendTesterAlert(TEAM_TESTER_COLOR, "[TESTER] {FFBB00}%s is now off tester duty! (disconnected)", AccountName(playerid));

	if(PlayerData[playerid][pShowFooter]) KillTimer(PlayerData[playerid][pFooterTimer]);

	if(PlayerData[playerid][pFreeze]) KillTimer(PlayerData[playerid][pFreezeTimer]);

	foreach (new i : Player)
	{
		if(PlayerData[i][pFactionOffer] == playerid)
		{
		    PlayerData[i][pFactionOffer] = INVALID_PLAYER_ID;
		    PlayerData[i][pFactionOffered] = -1;
		}

		if(PlayerData[i][pSpectating] == playerid)
		{
			PlayerData[i][pSpectating] = INVALID_PLAYER_ID;

			TogglePlayerSpectating(i, false);
			SetCameraBehindPlayer(i);

			SetPlayerDynamicPos(i, PlayerData[i][pPos][0], PlayerData[i][pPos][1], PlayerData[i][pPos][2]);
			SetPlayerInterior(i, PlayerData[i][pInterior]);
			SetPlayerVirtualWorld(i, PlayerData[i][pWorld]);

			SetPlayerWeapons(i);

			SendClientMessage(i, COLOR_GREY, "Player lost connection to the server.");
		}

		if(pToAccept[i] == playerid)
		{
		    pToAccept[i] = INVALID_PLAYER_ID;
			vToAccept[i] = 9999;
			prToAccept[i] = 0;
			tToAccept[i] = 0;
		}
	}

    ExitSettingVehicle(playerid);

	new callerid = PlayerData[playerid][pCallConnect];

	if(callerid != INVALID_PLAYER_ID)
	{
		SendClientMessage(callerid, COLOR_GRAD2, "[ ! ] They hung up (disconnected)");

		RenderPlayerPhone(callerid, 0, 0);

		if(GetPlayerSpecialAction(callerid) == SPECIAL_ACTION_USECELLPHONE) SetPlayerSpecialAction(callerid, SPECIAL_ACTION_STOPUSECELLPHONE);

	   	PlayerData[callerid][pCallConnect] = INVALID_PLAYER_ID;
	   	PlayerData[playerid][pCallConnect] = INVALID_PLAYER_ID;
	}

	if(AccountData[playerid][aUserid] > 0)
	{
	    new query[80];
		format(query, sizeof(query), "UPDATE `accounts` SET `Online` = '0' WHERE `ID` = '%d' LIMIT 1", AccountData[playerid][aUserid]);
		mysql_tquery(dbCon, query);
	}

	if(SQL_IsLogged(playerid))
	{
	    new const DisconnectReasons[3][10] = {"timeout", "quit", "kick"};

	    SQL_LogAction(playerid, "Left the server (%s) [P:%d, PL:%f]", DisconnectReasons[reason], GetPlayerPing(playerid), NetStats_PacketLossPercent(playerid));
		SQL_SaveCharacter(playerid);
		SQL_RunDisconnect(playerid);
	}

	ResetStatistics(playerid);
	return true;
}

SQL_RunDisconnect(playerid)
{
	if(AccountData[playerid][aConnectionID])
	{
		new query[180];
		mysql_format(dbCon, query, sizeof(query), "UPDATE `logs_connection` SET `char_name` = '%e', `disconnected` = NOW() WHERE `id` = '%d' LIMIT 1", ReturnName(playerid), AccountData[playerid][aConnectionID]);
		mysql_pquery(dbCon, query);
	}
}

SQL_SaveCharacter(playerid, bool:quit = true)
{
	if(!SQL_IsLogged(playerid) || PlayerData[playerid][pID] == -1) return false;

	new
	    query[1400 + MAX_PLAYER_NAME],
	    knockout,
	    adminduty,
	    testerduty,
	    hudtoggled
	;

	PlayerData[playerid][pInterior] = GetPlayerInterior(playerid);
	PlayerData[playerid][pWorld] = GetPlayerVirtualWorld(playerid);

	GetPlayerPos(playerid, PlayerData[playerid][pPos][0], PlayerData[playerid][pPos][1], PlayerData[playerid][pPos][2]);
	GetPlayerFacingAngle(playerid, PlayerData[playerid][pPos][3]);
	GetPlayerArmour(playerid, PlayerData[playerid][pArmour]);

	if(PlayerData[playerid][pOnDuty])
	{
	    PlayerData[playerid][pOnDutySkin] = GetPlayerSkin(playerid);

		if(quit)
		{
        	RestorePlayerWeapons(playerid, false);
		}
		else
		{
			ResetPlayerWeapons(playerid);
			RestorePlayerWeapons(playerid);
		}

		if(!PlayerData[playerid][pTimeout]) PlayerData[playerid][pArmour] = 0;
	}

	if(ParticleSettings[playerid][usingParticle])
	{
        RestorePlayerWeapons(playerid, false);
	}

	if(KnockedOut{playerid})
	{
		knockout = 1;
	}

	if(PlayerData[playerid][pTimeout])
	{
	    if(AdminDuty{playerid})
	    {
			PlayerData[playerid][pHealth] = GetPVarFloat(playerid, "HealthCache");

			DeletePVar(playerid, "HealthCache");

			adminduty = 1;
	    }

	    if(TesterDuty{playerid}) testerduty = 1;
	}
	else
	{
	    if(PlayerData[playerid][pHasMask])
	    {
	        PlayerData[playerid][pHasMask] = 0;
		}
	}

	if(PlayerFlags[playerid][toggleHUD]) hudtoggled = 1;

	format(query, sizeof(query), "UPDATE `characters` SET `OnDuty` = '%d', `OnDutySkin` = '%d', `PosX` = '%.4f', `PosY` = '%.4f', `PosZ` = '%.4f', `PosA` = '%.4f', `Interior` = '%d', `World` = '%d', `Local` = '%d', `Gun1` = '%d', `Ammo1` = '%d', `Gun2` = '%d', `Ammo2` = '%d', `Gun3` = '%d', `Ammo3` = '%d'",
		PlayerData[playerid][pOnDuty],
		PlayerData[playerid][pOnDutySkin],
		PlayerData[playerid][pPos][0],
		PlayerData[playerid][pPos][1],
		PlayerData[playerid][pPos][2],
		PlayerData[playerid][pPos][3],
		PlayerData[playerid][pInterior],
		PlayerData[playerid][pWorld],
		PlayerData[playerid][pLocal],
		PlayerData[playerid][pWeapon][0],
		PlayerData[playerid][pAmmunation][0],
		PlayerData[playerid][pWeapon][1],
		PlayerData[playerid][pAmmunation][1],
		PlayerData[playerid][pWeapon][2],
		PlayerData[playerid][pAmmunation][2]
	);

	format(query, sizeof(query), "%s, `Tutorial` = '%d', `Model` = '%d', `PhoneNumbr` = '%d', `PhoneModel` = '%d', `SpawnPoint` = '%d', `FactionSpawn` = '%d', `Level` = '%d', `Exp` = '%d', `ExpCounter` = '%d', `PayDay` = '%d', `PayDayHad` = '%d', `PayCheck` = '%d', `ChequeCash` = '%d', `Injured` = '%d', `playerTimeout` = '%d', `MedicBill` = '%d', `Armour` = '%f', `Health` = '%f' WHERE `ID` = '%d'",
		query,
		PlayerData[playerid][pTutorial],
		PlayerData[playerid][pModel],
		PlayerData[playerid][pPnumber],
		PlayerData[playerid][pPhoneModel],
		PlayerData[playerid][pSpawnPoint],
		PlayerData[playerid][pFactionSpawn],
		PlayerData[playerid][pLevel],
		PlayerData[playerid][pExp],
		PlayerData[playerid][pExpCounter],
		PlayerData[playerid][pPayDay],
		PlayerData[playerid][pPayDayHad],
		PlayerData[playerid][pPayCheck],
		PlayerData[playerid][pChequeCash],
		PlayerData[playerid][pInjured],
		PlayerData[playerid][pTimeout],
		MedicBill[playerid],
 		PlayerData[playerid][pArmour],
		PlayerData[playerid][pHealth],
		PlayerData[playerid][pID]
	);

	mysql_pquery(dbCon, query);

	//printf("QUERY LENGTH WAS %d", strlen(query));

	// execute query

	format(query, sizeof(query), "UPDATE `characters` SET `BankAccount` = '%d', `Cash` = '%d', `Savings` = '%d', `DonateRank` = '%d', `SpawnHealth` = '%f', `PhoneSilent` = '%d', `PhoneAir` = '%d', `PhoneRingtone` = '%d', `PhoneTextRingtone` = '%d', `Faction` = '%d', `FactionRank` = '%d', `ContractTime` = '%d', `Jailed` = %d, `SentenceTime` = %d, `CarLic` = %d",
		PlayerData[playerid][pAccount],
		PlayerData[playerid][pCash],
		PlayerData[playerid][pSavings],
		PlayerData[playerid][pDonateRank],
		PlayerData[playerid][pSHealth],
		ph_silentmode[playerid],
		ph_airmode[playerid],
		ph_CallTone[playerid],
		ph_TextTone[playerid],
		PlayerData[playerid][pFactionID],
		PlayerData[playerid][pFactionRank],
 		PlayerData[playerid][pContractTime],
 		PlayerData[playerid][pJailed],
		PlayerData[playerid][pSentenceTime],
		PlayerData[playerid][pCarLic]
	);

	format(query, sizeof(query), "%s, `Radio` = '%d', `RadioChannel` = '%d', `RadioSlot` = '%d', `playerJob` = '%d', `playerSideJob` = '%d', `playerJobRank` = '%d', `playerCareer` = '%d', `playerHouseKey` = '%d', `playerComplexKey` = '%d', `PlayerBusinessKey` = '%d', `PlayerCarkey` = '%d', `Checkpoint_Type` = '%d', `Checkpoint_X` = '%f', `Checkpoint_Y` = '%f', `Checkpoint_Z` = '%f', `Fishes` = '%d', `SavingsCollect` = '%d', `Online` = '0', `PlayingSeconds` = '%d', `ADPoint` = '%d', `WepLic` = '%d'",
	    query,
	    PlayerData[playerid][pRadio],
	    PlayerData[playerid][pRChannel],
	    PlayerData[playerid][pRSlot],
	    PlayerData[playerid][pJob],
	    PlayerData[playerid][pSideJob],
	    PlayerData[playerid][pJobRank],
	    PlayerData[playerid][pCareer],
	    PlayerData[playerid][pHouseKey],
		PlayerData[playerid][pComplexKey],
	    PlayerData[playerid][pPbiskey],
	    PlayerData[playerid][pPCarkey],
	  	PlayerData[playerid][pCP_Type],
	    PlayerData[playerid][pCP_X],
	    PlayerData[playerid][pCP_Y],
	    PlayerData[playerid][pCP_Z],
	    PlayerData[playerid][pFishes],
	    PlayerData[playerid][pSavingsCollect],
	    PlayerData[playerid][pPlayingSeconds],
	    PlayerData[playerid][pADPoint],
	    PlayerData[playerid][pWepLic]
	);

	format(query, sizeof(query), "%s, `PrimaryLicense` = '%d', `SecondaryLicense` = '%d', `CCWLicense` = '%d', `HudToggle` = '%d', `LoginToggle` = '%d', `LoginSound` = '%d', `LoginNotify` = '%d', `SprayBanned` = '%d', `Cigarettes` = '%d', `Drinks` = '%d', `GasCan` = '%d', `TotalDamages` = '%d', `LastBlow` = '%d', `Knockout` = '%d', `DrugStamp` = '%d', `AdminDuty` = '%d', `TesterDuty` = '%d', `Masked` = '%d', `MaskID` = '%d', `MaskIDEx` = '%d', `timeoutProp` = '%d', `timeoutApp` = '%d', `timeoutBizz` = '%d' WHERE `ID` = '%d'",
	    query,
	 	PlayerData[playerid][pPrimaryLicense],
		PlayerData[playerid][pSecondaryLicense],
		PlayerData[playerid][pCCWLic],
		hudtoggled,
		PlayerData[playerid][pLoginToggle],
		PlayerData[playerid][pLoginSound],
		PlayerData[playerid][pLoginNotify],
		PlayerData[playerid][pSprayBanned],
		PlayerData[playerid][pCigarettes],
		PlayerData[playerid][pDrink],
		PlayerData[playerid][pGasCan],
		TotalPlayerDamages[playerid],
		DeathReason[playerid],
		knockout,
		PlayerData[playerid][pDrugStamp],
		adminduty,
		testerduty,
		PlayerData[playerid][pHasMask],
		PlayerData[playerid][pMaskID][0],
		PlayerData[playerid][pMaskID][1],
		InProperty[playerid] == -1 ? -1 : PropertyData[ InProperty[playerid] ][hID],
		InApartment[playerid] == -1 ? -1 : ComplexData[ InApartment[playerid] ][aID],
		InBusiness[playerid] == -1 ? -1 : BusinessData[ InBusiness[playerid] ][bID],
		PlayerData[playerid][pID]
	);

	mysql_pquery(dbCon, query);

	//printf("QUERY LENGTH WAS %d", strlen(query));

	for(new x = 0; x < MAX_SMS; ++x)
	{
		if(SmsData[playerid][x][smsExist])
		{
			format(query, sizeof(query), "UPDATE `phone_sms` SET `Archive` = '%d', `ReadSMS` = '%d' WHERE `id` = '%d' LIMIT 1", SmsData[playerid][x][smsArchive], SmsData[playerid][x][smsRead], SmsData[playerid][x][smsID]);
			mysql_pquery(dbCon, query);
		}
	}

	for(new id = 0; id < MAX_CLOTHES; ++id)
	{
	    if(ClothingData[playerid][id][cl_object])
	    {
		 	mysql_format(dbCon, query, sizeof(query), "UPDATE clothing SET object = '%d', bone = '%d', slot = '%d', equip = '%d', name = '%e' WHERE id = '%d' AND owner = '%d' LIMIT 1",
			    ClothingData[playerid][id][cl_object],
			    ClothingData[playerid][id][cl_bone],
			    ClothingData[playerid][id][cl_slot],
				ClothingData[playerid][id][cl_equip],
				ClothingData[playerid][id][cl_name],
				ClothingData[playerid][id][cl_sid],
				PlayerData[playerid][pID]
			);

			mysql_pquery(dbCon, query);
		}
	}
	return true;
}

AddPlayerCallHistory(playerid, number, type)
{
	for(new i = MAX_CALLHISTORY - 1; i >= 0; i--)
	{
	    if(!CallHistory[playerid][i][chExists])
	    {
	        CallHistory[playerid][i][chExists] = true;
	        CallHistory[playerid][i][chSec] = gettime();
	        CallHistory[playerid][i][chType] = type;
	        CallHistory[playerid][i][chNumber] = number;
	        CallHistory[playerid][i][chRead] = false;
	    	break;
	    }
	}
}

public OnPlayerRequestClass(playerid, classid)
{
	if(IsPlayerNPC(playerid))
	    return true;

	if(BeingKicked{playerid})
	    return true;

	if(!AccountChecked{playerid})
	    return true;

	if(!SQL_IsLogged(playerid))
	{
	    TogglePlayerSpectating(playerid, true);
		SetPlayerColor(playerid, COLOR_GRAD2);
		AccountCheck(playerid);
		RemovePlayerClothing(playerid);
	}
	else 
	{
		SetSpawnInfo(playerid, NO_TEAM, PlayerData[playerid][pModel], PlayerData[playerid][pPos][0], PlayerData[playerid][pPos][1], PlayerData[playerid][pPos][2], PlayerData[playerid][pPos][3], 0, 0, 0, 0, 0, 0);
		Spawned{playerid} = false;
		SpawnPlayer(playerid);					
	}

	return true;
}

public OnPlayerRequestDownload(playerid, type, crc)
{
    if(!IsPlayerConnected(playerid)) return false;

    new fullurl[256 + 1], dlfilename[64 + 1], foundfilename = 0;

    if(type == DOWNLOAD_REQUEST_TEXTURE_FILE)
    {
        foundfilename = FindTextureFileNameFromCRC(crc, dlfilename, 64);
    }
    else if(type == DOWNLOAD_REQUEST_MODEL_FILE)
    {
        foundfilename = FindModelFileNameFromCRC(crc, dlfilename, 64);
    }

    if(foundfilename)
    {
        format(fullurl, 256, "%s/%s", modelsURL, dlfilename);
        RedirectDownload(playerid, fullurl);
    }

    return false;
}

RandomLoginScreen(playerid)
{
	switch(random(6))
	{
	    case 0:
	    {
		 	SetPlayerDynamicPos(playerid, 1838.6837,-1704.9426,13.9999); // Alhambra
			InterpolateCameraPos(playerid, 1400.400878, -1737.014526, 92.646148, 1771.815063, -1741.581420, 70.703231, 9000);
			InterpolateCameraLookAt(playerid, 1405.239013, -1736.679199, 91.429573, 1775.731933, -1739.247680, 68.650878, 9000);
	    }
	    case 1:
	    {
		 	SetPlayerDynamicPos(playerid, 2255.8870,-1457.9824,18.5294); // Glen Park
			InterpolateCameraPos(playerid, 2067.357421, -1914.845458, 77.126457, 2162.559814, -1563.017700, 63.680793, 7000);
			InterpolateCameraLookAt(playerid, 2068.106201, -1909.954223, 76.408630, 2162.281738, -1558.047241, 63.214595, 7000);
	    }
	    case 2:
	    {
		 	SetPlayerDynamicPos(playerid, 1838.6837,-1704.9426,13.9999); // Idlewood
			InterpolateCameraPos(playerid, 1840.053344, -1733.400756, 60.931621, 1963.133422, -1763.364624, 77.835762, 7000);
			InterpolateCameraLookAt(playerid, 1844.712890, -1733.955444, 59.204956, 1967.605834, -1763.862426, 75.656295, 7000);
	    }
	    case 3:
	    {
		 	SetPlayerDynamicPos(playerid, 1377.2443,-776.1080,92.0957); // Mulholand
			InterpolateCameraPos(playerid, 1406.090942, -890.649230, 95.371109, 1543.376586, -897.526977, 104.968841, 7000);
			InterpolateCameraLookAt(playerid, 1406.484863, -885.718322, 94.642463, 1546.230346, -901.473266, 103.836219, 7000);
	    }
	    case 4:
	    {
		 	SetPlayerDynamicPos(playerid, 1483.5927,-1781.5214,13.5469); // Pershing Square
			InterpolateCameraPos(playerid, 1766.647705, -1799.999511, 83.710655, 1555.844116, -1599.263793, 101.893363, 9000);
			InterpolateCameraLookAt(playerid, 1762.219238, -1797.717407, 83.286163, 1552.842041, -1601.462524, 98.553779, 9000);
	    }
	    case 5:
	    {
		 	SetPlayerDynamicPos(playerid, 1377.2443,-776.1080,92.0957); // Vinewood
			InterpolateCameraPos(playerid, 1109.423706, -956.851989, 89.084526, 1323.938842, -903.115905, 113.600677, 9000);
			InterpolateCameraLookAt(playerid, 1104.463378, -957.352600, 88.703643, 1327.557739, -899.820861, 112.577796, 9000);
	    }
	}
}

FUNX::AccountCheck(playerid)
{
    RandomLoginScreen(playerid);

	SQL_CheckBanAccount(playerid);
}

SetPlayerWeaponSkill(playerid, skill)
{
	switch(skill)
	{
	    case NORMAL_SKILL:
		{
			SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL, 0);
			SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL_SILENCED, 100);
			SetPlayerSkillLevel(playerid, WEAPONSKILL_DESERT_EAGLE, 100);
			SetPlayerSkillLevel(playerid, WEAPONSKILL_SHOTGUN, 100);
			SetPlayerSkillLevel(playerid, WEAPONSKILL_SAWNOFF_SHOTGUN, 100);
			SetPlayerSkillLevel(playerid, WEAPONSKILL_SPAS12_SHOTGUN, 100);
			SetPlayerSkillLevel(playerid, WEAPONSKILL_MICRO_UZI, 0);
			SetPlayerSkillLevel(playerid, WEAPONSKILL_MP5, 100);
			SetPlayerSkillLevel(playerid, WEAPONSKILL_AK47, 100);
			SetPlayerSkillLevel(playerid, WEAPONSKILL_M4, 100);
			SetPlayerSkillLevel(playerid, WEAPONSKILL_SNIPERRIFLE, 100);
	    }
	    case MEDIUM_SKILL:
		{
			SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL, 200);
			SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL_SILENCED, 500);
			SetPlayerSkillLevel(playerid, WEAPONSKILL_DESERT_EAGLE, 200);
			SetPlayerSkillLevel(playerid, WEAPONSKILL_SHOTGUN, 200);
			SetPlayerSkillLevel(playerid, WEAPONSKILL_SAWNOFF_SHOTGUN, 200);
			SetPlayerSkillLevel(playerid, WEAPONSKILL_SPAS12_SHOTGUN, 200);
			SetPlayerSkillLevel(playerid, WEAPONSKILL_MICRO_UZI, 50);
			SetPlayerSkillLevel(playerid, WEAPONSKILL_MP5, 250);
			SetPlayerSkillLevel(playerid, WEAPONSKILL_AK47, 200);
			SetPlayerSkillLevel(playerid, WEAPONSKILL_M4, 200);
			SetPlayerSkillLevel(playerid, WEAPONSKILL_SNIPERRIFLE, 300);
	    }
	    case FULL_SKILL:
		{
			SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL, 998);
			SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL_SILENCED, 999);
			SetPlayerSkillLevel(playerid, WEAPONSKILL_DESERT_EAGLE, 999);
			SetPlayerSkillLevel(playerid, WEAPONSKILL_SHOTGUN, 999);
			SetPlayerSkillLevel(playerid, WEAPONSKILL_SAWNOFF_SHOTGUN, 999);
			SetPlayerSkillLevel(playerid, WEAPONSKILL_SPAS12_SHOTGUN, 999);
			SetPlayerSkillLevel(playerid, WEAPONSKILL_MICRO_UZI, 50);
			SetPlayerSkillLevel(playerid, WEAPONSKILL_MP5, 999);
			SetPlayerSkillLevel(playerid, WEAPONSKILL_AK47, 999);
			SetPlayerSkillLevel(playerid, WEAPONSKILL_M4, 999);
			SetPlayerSkillLevel(playerid, WEAPONSKILL_SNIPERRIFLE, 999);
	    }
	}
}

public OnPlayerSpawn(playerid)
{
	if(!LoggedIn{playerid} || PlayerData[playerid][pID] == -1) return false;

    if(!Spawned{playerid})
	{
        Spawned{playerid} = true;

        LastSpawn[playerid] = gettime();

		if(PlayerData[playerid][pOnDutySkin] > 0 && PlayerData[playerid][pOnDuty])
		{
			SetPlayerSkin(playerid, PlayerData[playerid][pOnDutySkin]);
		}
		else if(!PlayerData[playerid][pOnDuty])
		{
			SetPlayerSkin(playerid, PlayerData[playerid][pModel]);
		}

		ResetPlayerWeapons(playerid);
		SetPlayerTeam(playerid, 1);
		SetPlayerWeather(playerid, globalWeather);
		SetPlayerSpawn(playerid);

		if(FinishedTutorial{playerid})
		{
		    FinishedTutorial{playerid} = false;
		}

	    if(!PlayerData[playerid][pJailed]) cl_DressPlayer(playerid);

		if(!AnimationsPreloaded{playerid})
		{
			AnimationsPreloaded{playerid} = true;

			PreloadAnimations(playerid);
		}
    }
	return true;
}

SetPlayerSpawn(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerData[playerid][pJailed])
		{
			SetPlayerToTeamColor(playerid);

			switch(PlayerData[playerid][pJailed])
			{
				case PUNISHMENT_TYPE_AJAIL:
				{
					SetPlayerPosEx(playerid, 2689.2698, 2689.3066, 22.9472);
					SetPlayerInteriorEx(playerid, 0);
					SetPlayerVirtualWorldEx(playerid, playerid + 200);
				}
				case PUNISHMENT_TYPE_JAIL:
				{
					PutPlayerInJail(playerid, random(sizeof(JailSpawns)));
				}
				case PUNISHMENT_TYPE_PRISON:
				{
					PutPlayerInPrison(playerid, PlayerCell[playerid] == -1 ? random(sizeof(PrisonSpawns)) : PlayerCell[playerid]);
				}
			}

			if(!DeathMode{playerid} && PlayerData[playerid][pInjured])
			{
				SetPlayerPosEx(playerid, PlayerData[playerid][pPos][0], PlayerData[playerid][pPos][1], PlayerData[playerid][pPos][2]);
				SetPlayerFacingAngle(playerid, PlayerData[playerid][pPos][3]);

				MakePlayerWounded(playerid, INVALID_PLAYER_ID, false, DeathReason[playerid]);
			}
		}
		else if(PlayerData[playerid][pTimeout] || PlayerData[playerid][pInjured])
		{
		    SetPlayerToTeamColor(playerid);

			if(PlayerData[playerid][pTimeoutType][0] != -1 || PlayerData[playerid][pTimeoutType][1] != -1 || PlayerData[playerid][pTimeoutType][2] != -1)
			{
				if(PlayerData[playerid][pTimeoutType][0] != -1) // Property Crash
				{
					foreach (new i : Property)
					{
						if(PlayerData[playerid][pTimeoutType][0] == PropertyData[i][hID])
						{
							PlayerData[playerid][pPos][0] = PropertyData[i][hEntranceX];
							PlayerData[playerid][pPos][1] = PropertyData[i][hEntranceY];
							PlayerData[playerid][pPos][2] = PropertyData[i][hEntranceZ];
							break;
						}
					}
				}
				else if(PlayerData[playerid][pTimeoutType][1] != -1) // Apartment Crash 
				{
					foreach (new i : Complex)
					{
						if(PlayerData[playerid][pTimeoutType][1] == ComplexData[i][aID])
						{
							PlayerData[playerid][pPos][0] = ComplexData[i][aEntranceX];
							PlayerData[playerid][pPos][1] = ComplexData[i][aEntranceY];
							PlayerData[playerid][pPos][2] = ComplexData[i][aEntranceZ];
							break;
						}
					}
				}
				else // Bizz Crash
				{
					foreach (new i : Business)
					{
						if(PlayerData[playerid][pTimeoutType][2] == BusinessData[i][bID])
						{
							PlayerData[playerid][pPos][0] = BusinessData[i][bEntranceX];
							PlayerData[playerid][pPos][1] = BusinessData[i][bEntranceY];
							PlayerData[playerid][pPos][2] = BusinessData[i][bEntranceZ];
							break;
						}
					}
				}

				if(PlayerData[playerid][pInjured]) SetPlayerDynamicPos(playerid, PlayerData[playerid][pPos][0], PlayerData[playerid][pPos][1], PlayerData[playerid][pPos][2]);
				else SetPlayerPosEx(playerid, PlayerData[playerid][pPos][0], PlayerData[playerid][pPos][1], PlayerData[playerid][pPos][2] + 0.5);
				
				SetPlayerInteriorEx(playerid, 0);
				SetPlayerVirtualWorldEx(playerid, 0);

				PlayerData[playerid][pTimeoutType][0] = -1;
				PlayerData[playerid][pTimeoutType][1] = -1;
				PlayerData[playerid][pTimeoutType][2] = -1;
			}
			else
			{
				if(PlayerData[playerid][pInjured]) SetPlayerDynamicPos(playerid, PlayerData[playerid][pPos][0], PlayerData[playerid][pPos][1], PlayerData[playerid][pPos][2]);
				else SetPlayerPosEx(playerid, PlayerData[playerid][pPos][0], PlayerData[playerid][pPos][1], PlayerData[playerid][pPos][2] + 0.5);

				SetPlayerFacingAngle(playerid, PlayerData[playerid][pPos][3]);
				SetPlayerInterior(playerid, PlayerData[playerid][pInterior]);
				SetPlayerVirtualWorld(playerid, PlayerData[playerid][pWorld]);
			}

			SetCameraBehindPlayer(playerid);

			if(PlayerData[playerid][pTimeout])
			{
				if(PlayerData[playerid][pOnDuty])
				{
				    SavePlayerWeapons(playerid);

					for(new i = 0; i < 13; ++i)
					{
				    	PlayerData[playerid][pGuns][i] = 0;
				    	PlayerData[playerid][pAmmo][i] = 0;

				    	if(i < 3)
				    	{
				    	    PlayerData[playerid][pWeapon][i] = 0;
				    	    PlayerData[playerid][pAmmunation][i] = 0;
				    	}
					}

					SetPlayerSkin(playerid, PlayerData[playerid][pOnDutySkin]);
					PlayerData[playerid][pOnDutySkin] = 0;

					switch(GetFactionType(playerid))
					{
					    case FACTION_POLICE, FACTION_SHERIFF, FACTION_CORRECTIONAL:
					    {
							PlayerData[playerid][pHandCuffs] = 2;

                            GivePlayerValidWeapon(playerid, 24, 150, 0, false);
					        GivePlayerValidWeapon(playerid, 3, 1, 0, false);

                            SendPoliceMessage(COLOR_POLICE, "** HQ: %s %s is now back on duty (crashed)! **", Faction_GetRank(playerid), ReturnName(playerid, 0));
					    }
					    case FACTION_MEDIC:
						{
							SendMedicMessage(COLOR_POLICE, "** HQ: %s %s is now back on duty (crashed)! **", Faction_GetRank(playerid), ReturnName(playerid, 0));
						}
					}
				}
				else
				{
					if(!PlayerData[playerid][pInjured]) SetPlayerWeapons(playerid);
				}

				SetPlayerHealthEx(playerid, PlayerData[playerid][pHealth]);
				SetPlayerArmourEx(playerid, PlayerData[playerid][pArmour]);

				GameTextForPlayer(playerid, "~r~crashed.~w~returning to last position", 8000, 1);
				PlayerData[playerid][pTimeout] = 0;
			}

			SyncPrisonInterior(playerid);

			if(!DeathMode{playerid} && PlayerData[playerid][pInjured]) MakePlayerWounded(playerid);
		}
		else
		{
		    switch(PlayerData[playerid][pSpawnPoint])
		    {
				case 0: // Airport
				{
					AirportSpawn(playerid);
				}
				case 1: // Faction Spawn
				{
				    SetPlayerToTeamColor(playerid);

				    new faction = PlayerData[playerid][pFaction];

				    if(faction == -1)
				    {
                        AirportSpawn(playerid);
					}
					else
					{
					    new idx = -1;

					    for(new i = 0; i < 5; ++i)
					    {
					        if(FactionSpawns[faction][i][spawnID] == 0)
								continue;

					        if(FactionSpawns[faction][i][spawnID] == PlayerData[playerid][pFactionSpawn])
					        {
					            idx = i;
					            break;
					        }
					    }

					    if(idx == -1)
					    {
                            AirportSpawn(playerid);
					    }
					    else
					    {
						    SetPlayerPosEx(playerid, FactionSpawns[faction][idx][factionSpawn][0], FactionSpawns[faction][idx][factionSpawn][1], FactionSpawns[faction][idx][factionSpawn][2] + 0.5);
						    SetPlayerFacingAngle(playerid, FactionSpawns[faction][idx][factionSpawn][3]);

						    if(FactionSpawns[faction][idx][spawnApartment] != -1)
							{
							    new id = FactionSpawns[faction][idx][spawnApartment];

							    if(Iter_Contains(Complex, id))
							    {
									SetPlayerInteriorEx(playerid, ComplexData[id][aInterior]);
									SetPlayerVirtualWorldEx(playerid, ComplexData[id][aWorld]);

									InApartment[playerid] = id;

									PlayerData[playerid][pLocal] = id + LOCAL_APARTMENT;
								}
								else
								{
                                    AirportSpawn(playerid);
								}
							}
							else
							{
							    SetPlayerInteriorEx(playerid, FactionSpawns[faction][idx][spawnInt]);
							    SetPlayerVirtualWorldEx(playerid, FactionSpawns[faction][idx][spawnWorld]);
							}

							SyncPrisonInterior(playerid);
						}
					}
				}
				case 2: // House
				{
				    new house = PlayerData[playerid][pHouseKey];

                    SetPlayerToTeamColor(playerid);

				    if(house == -1 || !Iter_Contains(Property, house) || !PropertyData[house][hOwned])
				    {
				        PlayerData[playerid][pHouseKey] = -1;

                        AirportSpawn(playerid);

						SendServerMessage(playerid, "You do not own a home or you do not have a home key.");
				    }
				    else
				    {
				        new bool:can_spawn = true, rent;

				        if(PropertyData[house][hOwnerSQLID] == PlayerData[playerid][pID]) // If you're the owner
				        {
				            rent = floatround((float(PlayerData[playerid][pAccount]) / float(100)) / float(110)) * CountPlayerOwnHouse(playerid);

				            if(PlayerData[playerid][pAccount] < rent)
				            {
				                SendNoticeMessage(playerid, "You don't have enough money in the bank to pay the house fees...");

				                can_spawn = false;

				                AirportSpawn(playerid, false);
							}
							else
							{
					            if(!FirstSpawn{playerid} && PropertyData[house][hRentable])
					            {
						            SendClientMessage(playerid, COLOR_LIGHTRED, "The house rent is:");
						            SendClientMessageEx(playerid, COLOR_WHITE, "$%d", PropertyData[house][hRentprice]);
								}
							}
				        }
				        else
				        {
							if(!FirstSpawn{playerid})
							{
							    rent = PropertyData[house][hRentprice];

								if(PlayerData[playerid][pAccount] < rent)
								{
								    PlayerData[playerid][pHouseKey] = -1;

									SendClientMessage(playerid, COLOR_WHITE, "You have been evicted");
									SendClientMessage(playerid, COLOR_WHITE, "Rent paid: $0. (Out of your bank)");
	 								SendNoticeMessage(playerid, "You don't have enough money in the bank to pay the house fees...");

	 								can_spawn = false;
								}
								else
								{
								    PlayerData[playerid][pAccount] -= rent;

						            SendClientMessage(playerid, COLOR_LIGHTRED, "The house rent is:");
						            SendClientMessageEx(playerid, COLOR_WHITE, "$%d", PropertyData[house][hRentprice]);

						            PropertyData[house][hCash] += rent;
								}
							}

							if(!can_spawn) AirportSpawn(playerid);
						}

						if(can_spawn)
						{
							SetPlayerPosEx(playerid, PropertyData[house][hExitX], PropertyData[house][hExitY], PropertyData[house][hExitZ] + 0.5);
							SetPlayerFacingAngle(playerid, 0);
							SetPlayerInteriorEx(playerid, PropertyData[house][hInterior]);
							SetPlayerVirtualWorldEx(playerid, PropertyData[house][hWorld]);

							InProperty[playerid] = house;

							PlayerData[playerid][pLocal] = house + LOCAL_HOUSE;
						}
				    }
				}
				case 3: // Complex
				{
					new house = PlayerData[playerid][pComplexKey];

					SetPlayerToTeamColor(playerid);

				    if(house == -1 || !Iter_Contains(Complex, house) || !ComplexData[house][aOwned])
				    {
				        PlayerData[playerid][pComplexKey] = -1;

                        AirportSpawn(playerid);

						SendServerMessage(playerid, "You do not own a home or you do not have a home key.");
				    }
				    else
				    {
				        new bool:can_spawn = true, rent;

				        if(ComplexData[house][aOwnerSQLID] == PlayerData[playerid][pID]) // If you're the owner
				        {
				            if(PlayerData[playerid][pAccount] < rent)
				            {
				                SendNoticeMessage(playerid, "You don't have enough money in the bank to pay the house fees...");

				                can_spawn = false;

				                AirportSpawn(playerid, false);
							}
							else
							{
					            if(!FirstSpawn{playerid} && ComplexData[house][aRentable])
					            {
						            SendClientMessage(playerid, COLOR_LIGHTRED, "The house rent is:");
						            SendClientMessageEx(playerid, COLOR_WHITE, "$%d", ComplexData[house][aRentprice]);
								}
							}
				        }
				        else
				        {
							if(!FirstSpawn{playerid})
							{
							    rent = ComplexData[house][aRentprice];

								if(PlayerData[playerid][pAccount] < rent)
								{
								    PlayerData[playerid][pComplexKey] = -1;

									SendClientMessage(playerid, COLOR_WHITE, "You have been evicted");
									SendClientMessage(playerid, COLOR_WHITE, "Rent paid: $0. (Out of your bank)");
	 								SendNoticeMessage(playerid, "You don't have enough money in the bank to pay the house fees...");

	 								can_spawn = false;
								}
								else
								{
								    PlayerData[playerid][pAccount] -= rent;

						            SendClientMessage(playerid, COLOR_LIGHTRED, "The house rent is:");
						            SendClientMessageEx(playerid, COLOR_WHITE, "$%d", ComplexData[house][aRentprice]);
								}
							}

							if(!can_spawn) AirportSpawn(playerid);
						}

						if(can_spawn)
						{
							SetPlayerPosEx(playerid, ComplexData[house][aExitX], ComplexData[house][aExitY], ComplexData[house][aExitZ]);
							SetPlayerInteriorEx(playerid, ComplexData[house][aInterior]);
							SetPlayerVirtualWorldEx(playerid, ComplexData[house][aWorld]);

							InApartment[playerid] = house;

							PlayerData[playerid][pLocal] = house + LOCAL_APARTMENT;
						}
				    }				
				}
				default:
				{
                    AirportSpawn(playerid);

					SendServerMessage(playerid, "Your spawn point is incorrect, please change the spawn point on UCP legacy-rp.net.");
				}
		    }

            SetCameraBehindPlayer(playerid);
      		SetPlayerWeapons(playerid);
      		SetPlayerHealthEx(playerid, PlayerData[playerid][pHealth]);
      		SetPlayerArmourEx(playerid, PlayerData[playerid][pArmour]);
		}
	}

	if(!FirstSpawn{playerid})
	{
	    FirstSpawn{playerid} = true;

	    if(!FinishedTutorial{playerid}) showServerMOTD(playerid);
	}
	return true;
}

AirportSpawn(playerid, bool:save = true)
{
	SetPlayerToTeamColor(playerid);

	if(PlayerData[playerid][pFreeze])
	{
	    KillTimer(PlayerData[playerid][pFreezeTimer]);
	    PlayerData[playerid][pFreeze] = 0;
	}

	TogglePlayerControllable(playerid, true);

	SetPlayerDynamicPos(playerid, 1643.0010, -2331.7056, -2.6797);
	SetPlayerFacingAngle(playerid, 359.8919);
	SetPlayerInteriorEx(playerid, 0);
	SetPlayerVirtualWorldEx(playerid, 0);

	if(save) PlayerData[playerid][pSpawnPoint] = 0;

	DesyncPlayerInterior(playerid);
}

RefreshMaskStatus(playerid, togglefor)
{
	if(IsMasked{playerid})
	{
		ShowPlayerNameTagForPlayer(togglefor, playerid, false);
	}
	else
	{
		ShowPlayerNameTagForPlayer(togglefor, playerid, true);
	}

	if(AdminDuty{togglefor}) ShowPlayerNameTagForPlayer(togglefor, playerid, true);
}

GetPlayerMaskID(const maskid[])
{
	if(strlen(maskid))
	{
	   	foreach (new i : Player)
		{
		    if(!IsMasked{i}) continue;

			if(!strcmp(PlayerData[i][pMask_Name], maskid, true))
			{
				return i;
			}
		}
	}

	return INVALID_PLAYER_ID;
}

ReturnPlayingHours(playerid)
{
	return floatround(PlayerData[playerid][pPlayingSeconds] / 3600, floatround_floor);
}

ShowStatistics(playerid, targetid)
{
	new factionText[32], rankText[32], factionid = PlayerData[targetid][pFaction];

	if(factionid != -1)
	{
	    factionid = FactionData[factionid][factionID];

		format(factionText, 32, "%s", Faction_GetName(targetid)), format(rankText, 32, "%s", Faction_GetRank(targetid));
	}
	else factionid = 0, factionText = "Civilian", rankText = "No Rank";

	new houses[64], hcount, keys[64], kcount;

	for(new i = 0; i < MAX_VEHICLE_KEYS; ++i)
	{
		if(PlayerData[targetid][pCarKeys][i] != 9999)
		{
			if(!kcount)
				format(keys, sizeof(keys), "%d", CarData[ PlayerData[targetid][pCarKeys][i] ][carVehicle]);
			else
				format(keys, sizeof(keys), "%s|%d", keys, CarData[ PlayerData[targetid][pCarKeys][i] ][carVehicle]);

			kcount++;
		}
	}

	if(!kcount) format(keys, 64, "None");

	new string[180], primary_weapon[30], secondary_weapon[30], ammo[2];

	if(PlayerData[targetid][pWeapon][1])
	{
	    format(primary_weapon, 30, ReturnWeaponName(PlayerData[targetid][pWeapon][1]));

	    ammo[0] = PlayerData[targetid][pAmmunation][1];

	    if(PlayerData[targetid][pWeapon][2])
	    {
	        format(secondary_weapon, 30, ReturnWeaponName(PlayerData[targetid][pWeapon][2]));

	        ammo[1] = PlayerData[targetid][pAmmunation][2];
	    }
	}
	else
	{
	    if(PlayerData[targetid][pWeapon][2])
	    {
	        format(primary_weapon, 30, ReturnWeaponName(PlayerData[targetid][pWeapon][2]));

	        ammo[0] = PlayerData[targetid][pAmmunation][2];
	    }
	}

	new playerName[MAX_PLAYER_NAME], currentTime[64];
	GetPlayerName(targetid, playerName, MAX_PLAYER_NAME);

	format(currentTime, 64, ReturnDateTime());

	format(string, sizeof(string),"|____________________%s [%s]____________________|", playerName, currentTime);
	SendClientMessage(playerid, COLOR_GREEN, string);

	format(string, sizeof(string), "| Character | Faction:[%d][%s] Rank:[%s] Job:[%s] Ph:[%d]", factionid, factionText, rankText, ReturnJobName(targetid, PlayerData[targetid][pJob]), PlayerData[targetid][pPnumber]);
	SendClientMessage(playerid, COLOR_STAT1, string);

	SendClientMessage(playerid, COLOR_STAT2, "| Character | Company:[0][Null] Rank:[Unknown]");

	format(string, sizeof(string), "| Inventory | CarParts:[0] Radio:[%s] Melee:[%s]", (PlayerData[targetid][pRadio]) ? ("Yes") : ("No"), ReturnWeaponName(PlayerData[targetid][pWeapon][0]));
	SendClientMessage(playerid, COLOR_STAT1, string);

	format(string, sizeof(string), "| Weapons | Primary weapon:[%s] Ammo:[%d] Secondary weapon:[%s] Ammo:[%d]", (strlen(primary_weapon)) ? primary_weapon : ("None"), ammo[0], (strlen(secondary_weapon)) ? secondary_weapon : ("None"), ammo[1]);
	SendClientMessage(playerid, COLOR_STAT2, string);

	format(string, sizeof(string), "| Level | Level:[%d] Experience:[%d/%d] DonatorLevel:[%s]", PlayerData[targetid][pLevel], PlayerData[targetid][pExp], ((PlayerData[targetid][pLevel]) * 4 + 4), ReturnDonateRank(PlayerData[targetid][pDonateRank]));
	SendClientMessage(playerid, COLOR_STAT1, string);

	format(string, sizeof(string), "| Skill | Health:[%.1f/150.0] Time played:[%d hours]", PlayerData[targetid][pHealth], floatround(PlayerData[targetid][pPlayingSeconds] / 3600, floatround_floor));
	SendClientMessage(playerid, COLOR_STAT2, string);

	format(string, sizeof(string), "| Money | Cash:[%s] Bank:[%s] Savings:[%s] PayCheck:[%s]", FormatNumber(PlayerData[targetid][pCash]), FormatNumber(PlayerData[targetid][pAccount]), FormatNumber(PlayerData[targetid][pSavingsCollect]), FormatNumber(PlayerData[targetid][pPayCheck]));
	SendClientMessage(playerid, COLOR_STAT1, string);

	format(string, sizeof(string), "| Other | VehicleKey(s):[%s] SideJob:[%s] RentingCar:[%d]", keys, ReturnJobName(playerid, PlayerData[targetid][pSideJob]), RentCarKey[targetid]);
	SendClientMessage(playerid, COLOR_STAT2, string);

	format(string, sizeof(string), "| Work | Own Businesses:[%s] Hired Businesses:[None]", PlayerData[playerid][pPbiskey] == -1 ? "None" : ClearGameTextColor(BusinessData[ PlayerData[playerid][pPbiskey] ][bInfo]));
	SendClientMessage(playerid, COLOR_STAT2, string);

	if(AdminDuty{playerid})
	{
		format(string, sizeof(string), "| For Admin | BusinessKey:[%d] Interior:[%d] World:[%d] Local:[%d]", PlayerData[targetid][pPbiskey], PlayerData[targetid][pInterior], PlayerData[targetid][pWorld], PlayerData[targetid][pLocal]);
		SendClientMessage(playerid, COLOR_STAT1, string);

		foreach (new i : Property)
		{
		    if(!PropertyData[i][hOwned]) continue;

			if(PropertyData[i][hOwnerSQLID] == PlayerData[targetid][pID])
			{
				if(!hcount)
					format(houses, sizeof(houses), "%d", i);
				else
					format(houses, sizeof(houses), "%s, %d", houses, i);

				hcount++;
			}
		}

		format(string, sizeof(string), " Houses owned: %s", houses);
		SendClientMessage(playerid, COLOR_STAT2, string);
	}

	format(string, sizeof(string), "|____________________%s [%s]____________________|", playerName, currentTime);
	SendClientMessage(playerid, COLOR_GREEN, string);
	return true;
}

SetPlayerToTeamColor(playerid)
{
  	SetPlayerColor(playerid, DEFAULT_COLOR);

  	if(AdminDuty{playerid})
	{
		SetPlayerColor(playerid, TEAM_ADMIN_COLOR);
		return true;
	}
	if(TaxiDuty{playerid})
	{
		SetPlayerColor(playerid, TAXI_DUTY);
		return true;
	}
  	if(TesterColor{playerid})
	{
		SetPlayerColor(playerid, TEAM_TESTER_COLOR);
		return true;
	}
	if(PlayerData[playerid][pOnDuty])
	{
		if(!TagColor{playerid})
		{
			SetFactionColor(playerid);
		}
		return true;
	}

	return true;
}

CountPlayerOwnHouse(playerid)
{
    new count;

	foreach (new i : Property)
	{
	    if(PropertyData[i][hOwned])
		{
			if(PropertyData[i][hOwnerSQLID] == PlayerData[playerid][pID])
			{
				count++;
			}
		}
	}

	return count;
}

OwnBusiness(playerid)
{
	if(PlayerData[playerid][pPbiskey] != -1 && !strcmp(BusinessData[PlayerData[playerid][pPbiskey]][bOwner], ReturnName(playerid)))
		return true;

	return false;
}

IsTester(playerid)
{
	if(PlayerData[playerid][pAdmin] == -1)
	    return true;
	else
	    return false;
}

public OnPlayerDeath(playerid, killerid, reason)
{
    Spawned{playerid} = false;

	if(PlayerData[playerid][pTutorialStep])
	{
	    PlayerData[playerid][pHealth] = 150.0;

		SendClientMessage(playerid, COLOR_LIGHTRED, "Looks like you died in our video guide. This may be because of 3rd party mods you have installed.");
		SendClientMessage(playerid, COLOR_LIGHTRED, "We recommend removing mods thay may cause this for the duration of the video guide.");
		return true;
	}

    if(killerid == INVALID_PLAYER_ID && reason >= 49)
	{
	    if((gettime() - LastSpawn[playerid]) < 15)
		{
		    PlayerData[playerid][pHealth] = 150.0;

			SendClientMessage(playerid, COLOR_LIGHTRED, "Died at spawn.[Just logged in]");
		}
		else
		{
		    if(reason == 54) //suicide
		    {
				PlayerData[playerid][pInjured] = 1;
				PlayerData[playerid][pInterior] = GetPlayerInterior(playerid);
				PlayerData[playerid][pWorld] = GetPlayerVirtualWorld(playerid);
				GetPlayerPos(playerid, PlayerData[playerid][pPos][0], PlayerData[playerid][pPos][1], PlayerData[playerid][pPos][2]);
				GetPlayerFacingAngle(playerid, PlayerData[playerid][pPos][3]);
				DeathTimer[playerid] = 120;
		    }
		    else
			{
				PlayerData[playerid][pHealth] = 150.0;
				SetPlayerDynamicPos(playerid, 2615.9104, 2660.3994, 10.8203);
			}
		}

		SendAdminAlert(COLOR_LIGHTRED, JUNIOR_ADMINS, "[DEATH] %s died (%s).", ReturnName(playerid), ReturnDeathReason(reason));
		SQL_LogPlayerDeath(playerid, INVALID_PLAYER_ID, reason);
	}

	if(killerid != INVALID_PLAYER_ID)
	{
		SendAdminAlert(COLOR_LIGHTRED, LEAD_ADMINS, "AdmWarn: %s was killed by %s but not processed script-wise. Contact a developer.", ReturnName(playerid), ReturnName(killerid));
	}
	return true;
}

public OnVehicleSpawn(vehicleid)
{
    if(!VehicleLabel[vehicleid][vLabelTime])
	{
		if(CoreVehicles[vehicleid][vehicleCarID] != -1)
		{
			ResetVehicle(vehicleid, true);
		}
		else
		{
		    ResetVehicle(vehicleid);
		}
	}
    else
	{
		SetVehicleDamage(vehicleid);
	}
	return true;
}

public OnVehicleDeath(vehicleid, killerid)
{
	new id = -1;

	if((id = Car_GetID(vehicleid)) != -1)
	{
		if(CarData[id][carOwner] == PlayerData[killerid][pID])
		{
			CarData[id][carDestroyed]++;

			CarData[id][carEngineL] -= float(10 + random(5));
			CarData[id][carBatteryL] -= float(10);

            if(strlen(CarData[id][carName]) > 0)
				SendClientMessageEx(killerid, COLOR_LIGHTRED, "Your %s (( %s )) has been destroyed.", CarData[id][carName], ReturnVehicleModelName(CarData[id][carModel]));
			else
			    SendClientMessageEx(killerid, COLOR_LIGHTRED, "Your %s has been destroyed.", ReturnVehicleModelName(CarData[id][carModel]));

			SendClientMessageEx(killerid, COLOR_LIGHTRED, "LIFESPAN: Engine Health reduced to {FFFFFF}%.2f{FF6347}. Battery Health reduced to {FFFFFF}%.2f{FF6347}.", CarData[id][carEngineL], CarData[id][carBatteryL]);

			GetVehicleDamageStatus(vehicleid, CarData[id][carDamage][0], CarData[id][carDamage][1], CarData[id][carDamage][2], CarData[id][carDamage][3]);
			GetVehicleHealth(vehicleid, CarData[id][carHealth]);

            CarData[id][carArmour] = 0;

            printf("Vehicle %s (DBID: %d) owned by %s (DBID: %d) has been destroyed by %s.", g_arrVehicleNames[CarData[id][carModel] - 400], CarData[id][carID], CarData[id][carOwnerName], CarData[id][carOwner], ReturnName(killerid));

			if(CarData[id][carInsurance] > 0)
			{
                CarData[id][carHealth] = VehicleData[CarData[id][carModel] - 400][c_maxhp];
			}

			if(CarData[id][carInsurance] > 1)
			{
                CarData[id][carDamage][0] = 0;
                CarData[id][carDamage][1] = 0;
                CarData[id][carDamage][2] = 0;
                CarData[id][carDamage][3] = 0;
			}

			if(CarData[id][carInsurance] < 3)
			{
			    CarData[id][carXM] = 0;

				for(new x = 0; x < 14; ++x) CarData[id][carMods][x] = 0;
			}
			else
			{
				for(new i = 0; i < 14; ++i)
				{
					CarData[id][carMods][i] = GetVehicleComponentInSlot(vehicleid, i);
				}
			}

			for(new x = 0; x != MAX_CAR_WEAPONS; ++x)
			{
                CarData[id][carWeapon][x] = 0;
				CarData[id][carAmmo][x] = 0;
			}

			Car_SaveID(id);
			Car_DespawnEx(id);

			RemoveVehicleKey(killerid, id);
			
			PlayerPlaySound(killerid, 1058, 0.0, 0.0, 0.0);
		}
		else
		{
			new other =- 1;

			if((other = IsCharacterOnline(CarData[id][carOwner])) != -1)
			{
				CarData[id][carDestroyed]++;

				CarData[id][carEngineL] -= float(10 + random(5));
				CarData[id][carBatteryL] -= float(10);

	            if(strlen(CarData[id][carName]) > 0)
					SendClientMessageEx(other, COLOR_LIGHTRED, "Your %s (( %s )) has been destroyed.", CarData[id][carName], ReturnVehicleModelName(CarData[id][carModel]));
				else
				    SendClientMessageEx(other, COLOR_LIGHTRED, "Your %s has been destroyed.", ReturnVehicleModelName(CarData[id][carModel]));

				SendClientMessageEx(other, COLOR_LIGHTRED, "LIFESPAN: Engine Health reduced to {FFFFFF}%.2f{FF6347}. Battery Health reduced to {FFFFFF}%.2f{FF6347}.", CarData[id][carEngineL], CarData[id][carBatteryL]);

				GetVehicleDamageStatus(vehicleid, CarData[id][carDamage][0], CarData[id][carDamage][1], CarData[id][carDamage][2], CarData[id][carDamage][3]);
				GetVehicleHealth(vehicleid, CarData[id][carHealth]);

				if(CarData[id][carInsurance] > 0)
				{
	                CarData[id][carHealth] = VehicleData[CarData[id][carModel] - 400][c_maxhp];
				}

				if(CarData[id][carInsurance] > 1)
				{
	                CarData[id][carDamage][0] = 0;
	                CarData[id][carDamage][1] = 0;
	                CarData[id][carDamage][2] = 0;
	                CarData[id][carDamage][3] = 0;
				}

				if(CarData[id][carInsurance] < 3)
				{
				    CarData[id][carXM] = 0;

					for(new x = 0; x < 14; ++x) CarData[id][carMods][x] = 0;
				}
				else
				{
					for(new i = 0; i < 14; ++i)
					{
						CarData[id][carMods][i] = GetVehicleComponentInSlot(vehicleid, i);
					}
				}

				for(new x = 0; x != MAX_CAR_WEAPONS; ++x)
				{
                    CarData[id][carWeapon][x] = 0;
					CarData[id][carAmmo][x] = 0;
				}

				printf("Vehicle %s (DBID: %d) owned by %s (DBID: %d) has been destroyed by %s.", g_arrVehicleNames[CarData[id][carModel] - 400], CarData[id][carID], CarData[id][carOwnerName], CarData[id][carOwner], ReturnName(killerid));

				Car_SaveID(id);
				Car_DespawnEx(id);

				RemoveVehicleKey(killerid, id);
				
				PlayerPlaySound(other, 1058, 0.0, 0.0, 0.0);
			}
		}
	}
	return true;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	if(PlayerData[playerid][pInjured] || (!ispassenger && GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_CUFFED) || GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_CARRY)
	{
		ClearAnimations(playerid);

		if(PlayerData[playerid][pInjured])
	 	{
	 	    TogglePlayerControllable(playerid, false);

	    	ApplyAnimation(playerid, "WUZI", "CS_Dead_Guy", 4.1, 0, 1, 1, 1, 0, 1);

		    SendServerMessage(playerid, "Attempts to enter vehicles while being in death mode is bannable. Frozen you now.");

	        if(!DeathMode{playerid})
			{
				SetTimerEx("UnFreezePlayer", 5000, false, "i", playerid);
			}
		}
	    return false;
	}

	if(RepairTime{playerid} || serviced[playerid])
	{
		serviceComp[playerid] = 0;
		serviceTowtruck[playerid] = 0;
		serviceCustomer[playerid] = 0;
		serviceFocus[playerid] = 0;
		serviced[playerid] = 0;
		RepairTime{playerid} = 0;

		RemoveWeapon(playerid, 41);

		if(IsPlayerAttachedObjectSlotUsed(playerid, 9)) RemovePlayerAttachedObject(playerid, 9);

		HidePlayerFooter(playerid);
	}

	if(CoreVehicles[vehicleid][vehicleCarID] == -1 && !IsAdminSpawned(vehicleid))
	{
		foreach (new i : sv_servercar)
		{
			if(vehicleVariables[i][vVehicleScriptID] != vehicleid || vehicleVariables[i][vVehicleFaction] == -1) continue;

			if(vehicleVariables[i][vVehicleFaction] != PlayerData[playerid][pFaction])
			{
				if(PlayerData[playerid][pAdmin] >= 1 && AdminDuty{playerid})
				{
					SendClientMessageEx(playerid, COLOR_GREY, "VEHICLE INFO: %s (model %d, ID %d) is owned by faction %s (%d)", g_arrVehicleNames[GetVehicleModel(vehicleVariables[i][vVehicleScriptID]) - 400], GetVehicleModel(vehicleVariables[i][vVehicleScriptID]), vehicleVariables[i][vVehicleScriptID], FactionData[vehicleVariables[i][vVehicleFaction]][factionName], vehicleVariables[i][vVehicleFaction]);
					return true;
				}
				else
				{
					if(GetLockStatus(vehicleid) || !ispassenger)
					{
						SetVehicleLabel(vehicleid, VLT_TYPE_PERMITFACTION, 5);
						ClearAnimations(playerid, 1);
						GetPlayerPos(playerid, PlayerData[playerid][pPos][0], PlayerData[playerid][pPos][1], PlayerData[playerid][pPos][2]);
						SetPlayerDynamicPos(playerid, PlayerData[playerid][pPos][0], PlayerData[playerid][pPos][1], PlayerData[playerid][pPos][2]);
					}
					return true;
				}
			}
		}
	}
	return true;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
    gPassengerCar[playerid] = vehicleid;

	if(CoreVehicles[vehicleid][vradioOn])
	{
		StopAudioStreamForPlayer(playerid);
	}

	if(RepairTime{playerid} && serviced[playerid])
	{
		if(!IsPlayerAttachedObjectSlotUsed(playerid, 9)) SetPlayerAttachedObject(playerid, 9, 18693,5,-0.081999,0.239,-1.152,-18.0001,2.1,12.2,0.173998,0.18,0.560998);

		serviceFocus[playerid] = 0;

		ShowPlayerFooter(playerid, "~h~~p~START SPRAYING THE VEHICLE.", -1);

		GivePlayerWeaponEx(playerid, 41, 9999);
	}

    if(GetPVarInt(playerid, "InDriveTest"))
	{
	    LessonStarted{playerid} = false;

		DeletePVar(playerid, "LessonSeconds");
		DeletePVar(playerid, "InDriveTest");

		SendClientMessage(playerid, COLOR_GREEN, "You have left the vehicle, test failed.");

		DisablePlayerCheckpoint(playerid);
		gPlayerCheckpointStatus[playerid] = CHECKPOINT_NONE;
		gPlayerCheckpointValue[playerid] = -1;
		SetVehicleToRespawn(vehicleid);
	}
	return true;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
    new dbid = -1, carid = -1;

	if(newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER)
	{
	    new vehicleid = GetPlayerVehicleID(playerid);

		PlayerData[playerid][pLastVehicle] = vehicleid;

		if(PlayerData[playerid][pInjured])
		{
			if(!death_Pause[playerid] && GetVehicleModel(vehicleid) != 416 && newstate != PLAYER_STATE_DRIVER)
			{
				RemoveFromVehicle(playerid);
			}
		}

		if(Boombox_Nearest(playerid) != INVALID_PLAYER_ID)
		{
		    StopAudioStreamForPlayer(playerid);
		}

		if(CoreVehicles[vehicleid][vradioOn])
		{
			PlayAudioStreamForPlayer(playerid, CoreVehicles[vehicleid][vradioURL]);
		}

		if(newstate == PLAYER_STATE_DRIVER)
		{
			foreach (new i : sv_servercar)
			{
			    if(vehicleVariables[i][vVehicleScriptID] != vehicleid || vehicleVariables[i][vVehicleFaction] == -1) continue;

			    dbid = vehicleVariables[i][vVehicleID];

				if(vehicleVariables[i][vVehicleFaction] != PlayerData[playerid][pFaction])
				{
					if(!AdminDuty{playerid})
					{
						RemoveFromVehicle(playerid);
						return true;
					}
				}
			}

       		SetPlayerArmedWeapon(playerid, 0);

			cl_DressHoldWeapon(playerid);
		}
		else
		{
		    if(CurrentHoldingWeapon[playerid] == 24)
		    {
		        SetPlayerArmedWeapon(playerid, 0);
		    }
		}

		if(dbid == -1)
		{
			carid = Car_GetID(vehicleid);

			if(carid != -1) dbid = CarData[carid][carID];
		}
	}

	if(oldstate == PLAYER_STATE_DRIVER || oldstate == PLAYER_STATE_PASSENGER)
	{
		new id = -1, str[128];

		if((id = Boombox_Nearest(playerid)) != INVALID_PLAYER_ID && BoomboxData[id][boomboxOn])
		{
			strunpack(str, BoomboxData[id][boomboxURL]);

			StopAudioStreamForPlayer(playerid);
			PlayAudioStreamForPlayer(playerid, str, BoomboxData[id][boomboxPos][0], BoomboxData[id][boomboxPos][1], BoomboxData[id][boomboxPos][2], 30.0, 1);
		}

		if(PlayerData[playerid][pInjured])
		{
			if(death_Pause[playerid]) death_Pause[playerid] = 0;

			TogglePlayerControllable(playerid, DeathMode{playerid} ? false : true);			
		}
	}

	if(oldstate == PLAYER_STATE_DRIVER)
	{
		if(h_vid[playerid] != -1)
		{
		    ShowPlayerFooter(playerid, "~r~You've left the vehicle.~n~~w~Hotwiring process ended.");

			h_vid[playerid] = -1; h_times[playerid] = 0; h_wid[playerid] = -1; h_score[playerid] = 0; h_failed[playerid] = 0;
			h_word[playerid][0]='\0';

			format(sgstr, sizeof(sgstr), "* %s stops hotwiring the vehicle.", ReturnName(playerid, 0));
			SetPlayerChatBubble(playerid, sgstr, COLOR_PURPLE, 20.0, 6000);			
		}
	}

	if(newstate == PLAYER_STATE_PASSENGER)
	{
	    new vehicleid = GetPlayerVehicleID(playerid);

        if(GetLockStatus(vehicleid))
		{
			SetVehicleLabel(vehicleid, VLT_TYPE_LOCK, 5);
			RemovePlayerFromVehicle(playerid);
		}
	}

	if(newstate == PLAYER_STATE_DRIVER)
	{
	    new str[128], vehicleid, oldcar = gLastCar[playerid], model;
	    
		vehicleid = GetPlayerVehicleID(playerid);
		model = GetVehicleModel(vehicleid);

		if(!CoreVehicles[vehicleid][vHasEngine]) SetEngineStatus(vehicleid, true);

		if(PlayerData[playerid][pCarLic] == 0)
		{
			SendClientMessage(playerid, COLOR_LIGHTRED, "You don't have a driving license! Pass a driving test to get one.");
		}
		
		if(IsVehicleDMV(vehicleid))
		{
	 		if(model == 405)
				SendClientMessage(playerid, COLOR_WHITE, "License exam: Try to pass license exam /licenseexam, if you succeed license costs $5000");
			else if(model == 438)
				SendClientMessage(playerid, COLOR_WHITE, "Taxi exam: Try to pass taxi exam /licenseexam, if you succeed it costs $5000");
		}

		if(!HasDonatorRank(playerid, 1) && (model == 481 || model == 510)) // BMX Permission
		{
			SendServerMessage(playerid, "You don't have BMX permission. See our premium packages at legacy-rp.net");
			RemovePlayerFromVehicle(playerid);
		}

		if(CoreVehicles[vehicleid][vHasEngine])
		{
			if(!GetEngineStatus(vehicleid))
			{
				SendClientMessage(playerid, COLOR_GREEN, "The engine is off. (/engine)");
			}
		}

		if(carid != -1)
		{
			if(CarData[carid][carOwner] == PlayerData[playerid][pID])
			{
				format(str, sizeof(str), "Welcome to your %s.", ReturnVehicleName(vehicleid));
				SendClientMessage(playerid, COLOR_WHITE, str);
			}
		}

		if(IsVehicleRental(vehicleid) && !IsVehicleRented(vehicleid))
		{
			SendClientMessageEx(playerid, COLOR_WHITE, "Vehicle Rental Service: Rent the %s for %s. (/rentvehicle)", g_arrVehicleNames[model - 400], FormatNumber(GetVehicleRentalPrice(model)));
			SendClientMessage(playerid, COLOR_GREEN, "Rent a vehicle and you will be able to /lock it.");
		}

		if(oldcar != 0)
		{
			if(Car_GetID(oldcar) == -1)
			{
				if(oldcar != vehicleid)
				{
			 		new
					    engine,
					    lights,
					    alarm,
					    doors,
					    bonnet,
					    boot,
					    objective;

					GetVehicleParamsEx(oldcar, engine, lights, alarm, doors, bonnet, boot, objective);
					SetVehicleParamsEx(oldcar, engine, lights, alarm, 0, bonnet, boot, objective);
				}
			}
		}

        gLastCar[playerid] = vehicleid;

	   	if(IsTrucker(vehicleid))
	 	{
		 	new trailerid = GetVehicleTrailer(vehicleid);

			if(GetVehicleCargoLoad((!trailerid) ? vehicleid : trailerid) != -1 && !IsVehicleCargoSkill(model, PlayerData[playerid][pJobRank]))
			{
				RemovePlayerFromVehicle(playerid);
			}
		}
	}

	if(newstate == PLAYER_STATE_ONFOOT)
	{
		if(TaxiMoney[playerid] > 0)
		{
			ChargePerson(playerid);
		}

		if(oldstate == PLAYER_STATE_DRIVER || oldstate == PLAYER_STATE_PASSENGER)
		{
		    cl_DressHoldWeapon(playerid, GetPlayerWeapon(playerid));

			new vehicleid = PlayerData[playerid][pLastVehicle];

			if(PlayerData[playerid][pID] != -1 && vehicleid != INVALID_VEHICLE_ID)
			{
				if(oldstate == PLAYER_STATE_DRIVER)
				{
					CoreVehicles[vehicleid][vLastDriverInCar] = PlayerData[playerid][pID];

					if(CoreVehicles[vehicleid][vehicleCarID] != -1)
					{
						if(IsOperatingVehicle(vehicleid))
						{
							if(!CoreVehicles[vehicleid][vbreaktime]) Iter_Remove(sv_activevehicles, vehicleid);

							ResetVehicleLabel(vehicleid);

							CoreVehicles[vehicleid][vOwnerID] = INVALID_PLAYER_ID;
							CoreVehicles[vehicleid][vUpgradeID] = 0;	

							SetVehicleLabel(vehicleid, VLT_TYPE_OPERAFAILED, 5);		
						}
					}						
				}
				else
				{
					CoreVehicles[vehicleid][vLastPlayerInCar] = PlayerData[playerid][pID];
				}
			}			
		}
	}

	foreach (new x : Player)
	{
		if(PlayerData[x][pAdmin] && PlayerData[x][pSpectating] == playerid)
		{
			if(newstate == PLAYER_STATE_DRIVER && oldstate == PLAYER_STATE_ONFOOT || newstate == PLAYER_STATE_PASSENGER && oldstate == PLAYER_STATE_ONFOOT)
			{
				PlayerSpectateVehicle(x, GetPlayerVehicleID(playerid));
			}
			else
			{
				PlayerSpectatePlayer(x, playerid);
			}
		}
	}

	if((newstate != 0 && (newstate < 4 || newstate > 7)) && (oldstate != 0 && (oldstate < 4 || oldstate > 7)))
	{
	    if(newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER)
	        SQL_LogAction(playerid, "%s to %s (VID %d, DB %d)", PlayerStates[oldstate], PlayerStates[newstate], GetPlayerVehicleID(playerid), dbid);
		else
			SQL_LogAction(playerid, "%s to %s", PlayerStates[oldstate], PlayerStates[newstate]);
	}
	return true;
}

public OnPlayerEnterCheckpoint(playerid)
{
	if(GetPlayerVisibleDynamicCP(playerid)) return 1;

	if(HasCheckpoint{playerid})
	{
	    DisablePlayerCheckpoint(playerid);
	    HasCheckpoint{playerid} = false;
	    SendNoticeMessage(playerid, "You have arrived at your destination.");
	}

	//new string[128];

	switch(gPlayerCheckpointStatus[playerid])
	{
	    case CHECKPOINT_NEWSPAPER:
		{
			DisablePlayerCheckpoint(playerid);
			gPlayerCheckpointStatus[playerid] = CHECKPOINT_NONE;
	    }
		case CHECKPOINT_VEH:
		{
			DisablePlayerCheckpoint(playerid);
			gPlayerCheckpointStatus[playerid] = CHECKPOINT_NONE;
			GameTextForPlayer(playerid, "~p~You have found it", 4000, 3);
			PlayerPlaySound(playerid, 1138, 0.0, 0.0, 0.0);
		}
		case CHECKPOINT_UNLOADFISHING:
		{
		    if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return true;

			gPlayerCheckpointX[playerid] = 0.0;
			gPlayerCheckpointY[playerid] = 0.0;
			gPlayerCheckpointZ[playerid] = 0.0;

			DisablePlayerCheckpoint(playerid);
			gPlayerCheckpointStatus[playerid] = CHECKPOINT_NONE;
			GameTextForPlayer(playerid, "~p~You have found it", 4000, 3);
		}
		case CHECKPOINT_GOFISHING:
		{
		    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
			{
				if(gPlayerCheckpointValue[playerid] != 3) // If player did /gofishing on-a-boat, but he's on-foot.
				{
					SetPlayerCheckpoint(playerid, gPlayerCheckpointX[playerid], gPlayerCheckpointY[playerid], gPlayerCheckpointZ[playerid], 30.0);
					return true;					
				}
			}
			else
			{
				if(gPlayerCheckpointValue[playerid] == 3) // If player did /gofishing on-foot, but he's on-a-boat.
				{
					SetPlayerCheckpoint(playerid, 383.6021, -2061.7881, 7.6140, 30.0);
					return true;
				}
			} 

			FishingPlace[playerid] = gPlayerCheckpointValue[playerid];

			SendClientMessage(playerid, COLOR_WHITE, "Start fishing here (/fish), when you are done /stopfishing and /unloadfish");

			gPlayerCheckpointX[playerid] = 0.0;
			gPlayerCheckpointY[playerid] = 0.0;
			gPlayerCheckpointZ[playerid] = 0.0;

			DisablePlayerCheckpoint(playerid);
			gPlayerCheckpointStatus[playerid] = CHECKPOINT_NONE;
            gPlayerCheckpointValue[playerid] = -1;
		}
		case CHECKPOINT_CAREXAM:
		{
		 	new vehicleid = GetPlayerVehicleID(playerid);

			if(IsVehicleDMV(vehicleid) && GetPVarInt(playerid, "InDriveTest") == 1 && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
			{
				PlayerPlaySound(playerid, 1138, 0.0, 0.0, 0.0);

				if(gPlayerCheckpointValue[playerid] == 1)
				{
				    GameTextForPlayer(playerid, "~w~75", 1200, 3);

					LessonStarted{playerid} = true;

					DisablePlayerCheckpoint(playerid);

                    SendClientMessage(playerid, COLOR_GREEN, "Go through red markers. Remember to drive on the right side of the road.");

					SetPlayerCheckpointEx(playerid, 1142.9375,-1569.5576,12.9785, 4.0, CHECKPOINT_CAREXAM, 2);
				}
				else if(gPlayerCheckpointValue[playerid] == 2)
				{
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpointEx(playerid, 1040.8793,-1569.6158,13.0935, 4.0, CHECKPOINT_CAREXAM, 3);
				}
				else if(gPlayerCheckpointValue[playerid] == 3)
				{
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpointEx(playerid, 1048.6573,-1492.2428,13.0935, 4.0, CHECKPOINT_CAREXAM, 4);
				}
				else if(gPlayerCheckpointValue[playerid] == 4)
				{
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpointEx(playerid, 930.3591,-1486.9060,13.0795, 4.0, CHECKPOINT_CAREXAM, 5);
				}
				else if(gPlayerCheckpointValue[playerid] == 5)
				{
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpointEx(playerid, 915.2392,-1524.6128,13.0875, 4.0, CHECKPOINT_CAREXAM, 6);
				}
				else if(gPlayerCheckpointValue[playerid] == 6)
				{
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpointEx(playerid, 915.0828,-1574.5353,13.0882, 4.0, CHECKPOINT_CAREXAM, 7);
				}
				else if(gPlayerCheckpointValue[playerid] == 7)
				{
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpointEx(playerid, 907.6953,-1769.6998,13.0873, 4.0, CHECKPOINT_CAREXAM, 8);
				}
				else if(gPlayerCheckpointValue[playerid] == 8)
				{
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpointEx(playerid, 813.3115,-1764.1138,13.1047, 4.0, CHECKPOINT_CAREXAM, 9);
				}
				else if(gPlayerCheckpointValue[playerid] == 9)
				{
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpointEx(playerid, 813.3115,-1764.1138,13.1047, 4.0, CHECKPOINT_CAREXAM, 10);
				}
				else if(gPlayerCheckpointValue[playerid] == 10)
				{
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpointEx(playerid, 876.8595,-1580.0282,13.0877, 4.0, CHECKPOINT_CAREXAM, 11);
				}
				else if(gPlayerCheckpointValue[playerid] == 11)
				{
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpointEx(playerid, 1012.6880,-1574.8156,13.0875, 4.0, CHECKPOINT_CAREXAM, 12);
				}
				else if(gPlayerCheckpointValue[playerid] == 12)
				{
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpointEx(playerid, 1249.2765,-1574.5369,13.0878, 4.0, CHECKPOINT_CAREXAM, 13);
				}
				else if(gPlayerCheckpointValue[playerid] == 13)
				{
					DisablePlayerCheckpoint(playerid);
					gPlayerCheckpointStatus[playerid] = CHECKPOINT_NONE;
		            gPlayerCheckpointValue[playerid] = -1;

					if(GetPVarInt(playerid, "LessonSeconds") <= 10)
					{
						if(GetPVarInt(playerid, "InDriveTest") == 1)
						{
							LessonStarted{playerid} = false;

							DeletePVar(playerid, "LessonSeconds");
							DeletePVar(playerid, "InDriveTest");

						    if(PlayerData[playerid][pCash] >= 5000)
						    {
								PlayerData[playerid][pCarLic] = 1;

								TakePlayerMoney(playerid, 5000);

	    						GameTextForPlayer(playerid, "~w~Congratulations! here is your license!", 5000, 1);
							}
							else SendClientMessage(playerid, COLOR_LIGHTRED, "You couldnt afford the license costs!");
						}
					}
					else
					{
						SendClientMessage(playerid, COLOR_GREEN, "Driving too fast is not acceptable.");

                        LessonStarted{playerid} = false;

						DeletePVar(playerid, "LessonSeconds");
						DeletePVar(playerid, "InDriveTest");
					}

					SetVehicleToRespawn(vehicleid);
				}
			}
			else if(IsVehicleDMV(vehicleid) && GetPVarInt(playerid, "InDriveTest") == 2 && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
			{
				PlayerPlaySound(playerid, 1138, 0.0, 0.0, 0.0);

				if(gPlayerCheckpointValue[playerid] == 1)
				{
				    GameTextForPlayer(playerid, "~w~75", 1200, 3);

				    LessonStarted{playerid} = true;

					DisablePlayerCheckpoint(playerid);

                    SendClientMessage(playerid, COLOR_GREEN, "Please remember to drive the right lane of the road.");

					SetPlayerCheckpointEx(playerid, 1288.9124,-1573.6912,13.3828, 4.0, CHECKPOINT_CAREXAM, 2); // Go 2

					SendClientMessage(playerid, COLOR_WHITE, "Welcome to the Taxi Exam! Please pay attention to the upcoming");
					SendClientMessage(playerid, COLOR_WHITE, "messages.");
				}
				else if(gPlayerCheckpointValue[playerid] == 2) // 2
				{
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpointEx(playerid, 1359.0680,-1419.6614,13.3828, 4.0, CHECKPOINT_CAREXAM, 3); // Go 3

					SendClientMessage(playerid, COLOR_WHITE, "There are a handfull of routes throughout this exercise you will");
					SendClientMessage(playerid, COLOR_WHITE, "have to complete in order to get the taxi job.");
				}
				else if(gPlayerCheckpointValue[playerid] == 3)
				{
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpointEx(playerid, 1333.9957,-1398.6868,13.3542, 4.0, CHECKPOINT_CAREXAM, 4);

                    SendClientMessage(playerid, COLOR_WHITE, "The goals throughout this route are to drive your pickups from point");
                    SendClientMessage(playerid, COLOR_WHITE, "A to point B. It is your chance to learn your ways around Los Santos!");
				}
				else if(gPlayerCheckpointValue[playerid] == 4)
				{
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpointEx(playerid, 1211.2808,-1322.8888,13.5589, 4.0, CHECKPOINT_CAREXAM, 5);

					SendClientMessage(playerid, COLOR_YELLOW, "|_________Taxi Call_________|");
					SendClientMessage(playerid, COLOR_YELLOW, "Caller: Taxi_Instructor Ph: 90210");
					SendClientMessage(playerid, COLOR_YELLOW, "Location: In front of the All Saints!");
					SendClientMessage(playerid, COLOR_LIGHTRED, "HINT: Drive carefully and calmly throughout the routes!");
				}
				else if(gPlayerCheckpointValue[playerid] == 5)
				{
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpointEx(playerid, 1072.5366,-1278.2339,13.3828, 4.0, CHECKPOINT_CAREXAM, 6);
					SendClientMessage(playerid, COLOR_WHITE, "Passenger: Take me to the movie studio please.");
				}
				else if(gPlayerCheckpointValue[playerid] == 6)
				{
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpointEx(playerid, 952.7286,-1218.6337,16.7341, 4.0, CHECKPOINT_CAREXAM, 7);
				}
				else if(gPlayerCheckpointValue[playerid] == 7)
				{
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpointEx(playerid, 937.3082,-1281.0801,14.9837, 4.0, CHECKPOINT_CAREXAM, 8);
                    SendClientMessage(playerid, COLOR_WHITE, "Thanks for the lift!");
				}
				else if(gPlayerCheckpointValue[playerid] == 8)
				{
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpointEx(playerid, 1132.1293,-1411.0457,13.6248, 4.0, CHECKPOINT_CAREXAM, 9);

                    SetPVarInt(playerid, "LessonSeconds", GetPVarInt(playerid, "LessonSeconds") + 50);
					SendClientMessage(playerid, COLOR_YELLOW, "|_________Taxi Call_________|");
					SendClientMessage(playerid, COLOR_YELLOW, "Caller: Taxi_Instructor Ph: 90210");
					SendClientMessage(playerid, COLOR_YELLOW, "Location: At the mall.");
				}
				else if(gPlayerCheckpointValue[playerid] == 9)
				{
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpointEx(playerid, 1193.5734,-1561.8549,13.3828, 4.0, CHECKPOINT_CAREXAM, 10);

					SendClientMessage(playerid, 0xF8E0ECFF, "Passenger: To market please.");
				}
				else if(gPlayerCheckpointValue[playerid] == 10)
				{
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpointEx(playerid, 1206.1475,-1717.4045,13.5469, 4.0, CHECKPOINT_CAREXAM, 11);
				}
				else if(gPlayerCheckpointValue[playerid] == 11)
				{
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpointEx(playerid, 1534.5322,-1657.3186,13.3828, 4.0, CHECKPOINT_CAREXAM, 12);

                    SendClientMessage(playerid, 0xF8E0ECFF, "Passenger: Thank you for submitting.!");
                    SetPVarInt(playerid, "LessonSeconds", GetPVarInt(playerid, "LessonSeconds") + 100);
					SendClientMessage(playerid, COLOR_YELLOW, "|_________Taxi Call_________|");
					SendClientMessage(playerid, COLOR_YELLOW, "Caller: Taxi_Instructor Ph: 90210");
					SendClientMessage(playerid, COLOR_YELLOW, "Location: At the police department! In a rush!");
				}
				else if(gPlayerCheckpointValue[playerid] == 12)
				{
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpointEx(playerid, 1437.5542,-1553.3374,13.5469, 4.0, CHECKPOINT_CAREXAM, 13);
					SendClientMessage(playerid, COLOR_STAT2, "Passenger: I need a ride down to the skatepark, quickly.");
				}
				else if(gPlayerCheckpointValue[playerid] == 13)
				{
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpointEx(playerid, 1457.3812,-1314.1404,13.3828, 4.0, CHECKPOINT_CAREXAM, 14);
				}
				else if(gPlayerCheckpointValue[playerid] == 14)
				{
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpointEx(playerid, 1703.0131,-1304.3083,13.4166, 4.0, CHECKPOINT_CAREXAM, 15);
					SendClientMessage(playerid, COLOR_STAT2, "Passenger: Oh no I left something!");
     				SendClientMessage(playerid, COLOR_LIGHTRED, "[Passenger is upset- time deducted]");
					SetPVarInt(playerid, "LessonSeconds", GetPVarInt(playerid, "LessonSeconds") - 10);
				}
				else if(gPlayerCheckpointValue[playerid] == 15)
				{
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpointEx(playerid, 1655.6829,-1456.3467,13.3837, 4.0, CHECKPOINT_CAREXAM, 16);

					SendClientMessage(playerid, COLOR_STAT2, "Passenger: Take me back to the police department!");
				}
				else if(gPlayerCheckpointValue[playerid] == 16)
				{
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpointEx(playerid, 1524.3076,-1663.1096,13.5469, 4.0, CHECKPOINT_CAREXAM, 17);

                    SetPVarInt(playerid, "LessonSeconds", GetPVarInt(playerid, "LessonSeconds") + 5);
					SendClientMessage(playerid, COLOR_LIGHTRED, "[You've exceeded expectations.]((Time increased))");
				}
				else if(gPlayerCheckpointValue[playerid] == 17)
				{
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpointEx(playerid, 1827.0012,-1680.2316,13.5469, 4.0, CHECKPOINT_CAREXAM, 18);

                    SetPVarInt(playerid, "LessonSeconds", GetPVarInt(playerid, "LessonSeconds") + 100);

					SendClientMessage(playerid, COLOR_YELLOW, "|_________Taxi Call_________|");
					SendClientMessage(playerid, COLOR_YELLOW, "Caller: Taxi_Instructor Ph: 90210");
					SendClientMessage(playerid, COLOR_YELLOW, "Location: At Alhambra");
				}
				else if(gPlayerCheckpointValue[playerid] == 18)
				{
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpointEx(playerid, 1968.9856,-1622.3890,15.9688, 4.0, CHECKPOINT_CAREXAM, 19);

                    SendClientMessage(playerid, COLOR_WHITE, "Passenger: Idlewood Pizza Stack");
				}
				else if(gPlayerCheckpointValue[playerid] == 19)
				{
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpointEx(playerid, 2079.0129,-1658.8647,13.3906, 4.0, CHECKPOINT_CAREXAM, 20);

					SendClientMessage(playerid, COLOR_WHITE, "Passenger: I'm getting really hungry...");
     				SendClientMessage(playerid, COLOR_LIGHTRED, "[Passenger is upset- time deducted]");
					SetPVarInt(playerid, "LessonSeconds", GetPVarInt(playerid, "LessonSeconds") - 15);
				}
				else if(gPlayerCheckpointValue[playerid] == 20)
				{
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpointEx(playerid, 2115.4177,-1778.2894,13.3903, 4.0, CHECKPOINT_CAREXAM, 21);

                    SetPVarInt(playerid, "LessonSeconds", GetPVarInt(playerid, "LessonSeconds") + 5);
					SendClientMessage(playerid, COLOR_LIGHTRED, "[You've exceeded expectations.]((Time increased))");
				}
				else if(gPlayerCheckpointValue[playerid] == 21)
				{
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpointEx(playerid, 2648.0222,-1676.4285,10.8086, 4.0, CHECKPOINT_CAREXAM, 22);

					SendClientMessage(playerid, COLOR_WHITE, "Passenger: Thank God we made it!");
                    SetPVarInt(playerid, "LessonSeconds", GetPVarInt(playerid, "LessonSeconds") + 50);
					SendClientMessage(playerid, COLOR_YELLOW, "|_________Taxi Call_________|");
					SendClientMessage(playerid, COLOR_YELLOW, "Caller: Taxi_Instructor Ph: 90210");
					SendClientMessage(playerid, COLOR_YELLOW, "Location: At the stadium. My friend and I need a pickup!");
				}
				else if(gPlayerCheckpointValue[playerid] == 22)
				{
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpointEx(playerid, 2645.4697,-1234.8927,49.8451, 4.0, CHECKPOINT_CAREXAM, 23);

					SendClientMessage(playerid, 0xF8E0ECFF, "Passenger: I need a ride home, my ex-friend is a bitch and can get her own ride!");
				}
				else if(gPlayerCheckpointValue[playerid] == 23)
				{
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpointEx(playerid, 2607.1348,-1037.3793,69.6366, 4.0, CHECKPOINT_CAREXAM, 24);

					SendClientMessage(playerid, 0xF8E0ECFF, "Passenger: Making me pissed just thinking of her!");
     				SendClientMessage(playerid, COLOR_LIGHTRED, "[Passenger is upset- time deducted]");
					SetPVarInt(playerid, "LessonSeconds", GetPVarInt(playerid, "LessonSeconds") - 40);
				}
				else if(gPlayerCheckpointValue[playerid] == 24)
				{
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpointEx(playerid, 2501.7471,-972.1787,82.2425, 4.0, CHECKPOINT_CAREXAM, 25);
				}
				else if(gPlayerCheckpointValue[playerid] == 25)
				{
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpointEx(playerid, 2647.6921,-1672.7454,10.7948, 4.0, CHECKPOINT_CAREXAM, 26);

					SendClientMessage(playerid, 0xF8E0ECFF, "Passenger: Could you please go pick her up. I'm worried...");
					SetPVarInt(playerid, "LessonSeconds", GetPVarInt(playerid, "LessonSeconds") + 200);
				}
				else if(gPlayerCheckpointValue[playerid] == 26)
				{
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpointEx(playerid, 2229.6445,-1729.9596,13.3828, 4.0, CHECKPOINT_CAREXAM, 27);
					SendClientMessage(playerid, 0xF8E0ECFF, "Passenger 2: To the mall please.");
				}
				else if(gPlayerCheckpointValue[playerid] == 27)
				{
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpointEx(playerid, 1962.4601,-1749.5858,13.3828, 4.0, CHECKPOINT_CAREXAM, 28);
				}
				else if(gPlayerCheckpointValue[playerid] == 28)
				{
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpointEx(playerid, 1936.6576,-1772.4995,13.3828, 4.0, CHECKPOINT_CAREXAM, 29);
				}
				else if(gPlayerCheckpointValue[playerid] == 29)
				{
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpointEx(playerid, 1762.6610,-1729.7421,13.3828, 4.0, CHECKPOINT_CAREXAM, 30);

                    SendClientMessage(playerid, 0xF8E0ECFF, "Passenger 2: If you don't mind could you swing around Alhambra?");
				}
				else if(gPlayerCheckpointValue[playerid] == 30)
				{
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpointEx(playerid, 1762.2166,-1606.8145,13.3797, 4.0, CHECKPOINT_CAREXAM, 31);
				}
				else if(gPlayerCheckpointValue[playerid] == 31)
				{
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpointEx(playerid, 1816.7012,-1682.6655,13.3828, 4.0, CHECKPOINT_CAREXAM, 32);
				}
				else if(gPlayerCheckpointValue[playerid] == 32)
				{
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpointEx(playerid, 1279.2948,-1398.0652,13.0750, 4.0, CHECKPOINT_CAREXAM, 33);
					SendClientMessage(playerid, COLOR_STAT2, "Passenger 2: *sighs* Just take me to the mall please");
     				SendClientMessage(playerid, COLOR_LIGHTRED, "[Passenger is upset- time deducted]");
					SetPVarInt(playerid, "LessonSeconds", GetPVarInt(playerid, "LessonSeconds") - 10);
				}
				else if(gPlayerCheckpointValue[playerid] == 33)
				{
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpointEx(playerid, 1120.0308,-1390.4103,13.4627, 4.0, CHECKPOINT_CAREXAM, 34);
                    SetPVarInt(playerid, "LessonSeconds", GetPVarInt(playerid, "LessonSeconds") + 10);
					SendClientMessage(playerid, COLOR_LIGHTRED, "[You've exceeded expectations.]((Time increased))");
				}
				else if(gPlayerCheckpointValue[playerid] == 34)
				{
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpointEx(playerid, 642.6805,-1355.8063,13.5621, 4.0, CHECKPOINT_CAREXAM, 35);
					SendClientMessage(playerid, COLOR_STAT2, "Passenger 2: Thanks!");
					SendClientMessage(playerid, COLOR_YELLOW, "|_________Taxi Call_________|");
					SendClientMessage(playerid, COLOR_YELLOW, "Caller: Taxi_Instructor Ph: 90210");
					SendClientMessage(playerid, COLOR_YELLOW, "Location: At the movie studio");

					SetPVarInt(playerid, "LessonSeconds", GetPVarInt(playerid, "LessonSeconds") + 145);
				}
				else if(gPlayerCheckpointValue[playerid] == 35)
				{
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpointEx(playerid, 1375.0747,-2287.1389,13.3530, 4.0, CHECKPOINT_CAREXAM, 36);
					SendClientMessage(playerid, COLOR_STAT2, "Passenger: Airport! Quickly before the plane leaves!");
     				SendClientMessage(playerid, COLOR_LIGHTRED, "[Passenger is upset- time deducted]");
					SetPVarInt(playerid, "LessonSeconds", GetPVarInt(playerid, "LessonSeconds") - 15);
				}
				else if(gPlayerCheckpointValue[playerid] == 36)
				{
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpointEx(playerid, 1540.4331,-2287.9326,13.3828, 4.0, CHECKPOINT_CAREXAM, 37);
                    SetPVarInt(playerid, "LessonSeconds", GetPVarInt(playerid, "LessonSeconds") + 5);
					SendClientMessage(playerid, COLOR_LIGHTRED, "[You've exceeded expectations.]((Time increased))");
				}
				else if(gPlayerCheckpointValue[playerid] == 37)
				{
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpointEx(playerid, 1683.5861,-2248.6130,-2.6732, 4.0, CHECKPOINT_CAREXAM, 38);
				}
				else if(gPlayerCheckpointValue[playerid] == 38)
				{
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpointEx(playerid, 1680.6915,-2324.1389,-2.8516, 4.0, CHECKPOINT_CAREXAM, 39);

					SendClientMessage(playerid, COLOR_STAT2, "Passenger:  Thank youuuu!");

					SendClientMessage(playerid, COLOR_YELLOW, "|_________Taxi Call_________|");
					SendClientMessage(playerid, COLOR_YELLOW, "Caller: Taxi_Instructor Ph: 90210");
					SendClientMessage(playerid, COLOR_YELLOW, "Location: At the airport!");

					SetPVarInt(playerid, "LessonSeconds", GetPVarInt(playerid, "LessonSeconds") + 100);
				}
				else if(gPlayerCheckpointValue[playerid] == 39)
				{
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpointEx(playerid, 1556.8877,-2284.6323,13.3828, 4.0, CHECKPOINT_CAREXAM, 40);

					SendClientMessage(playerid, COLOR_STAT2, "Passenger: To the driving school please...");
				}
				else if(gPlayerCheckpointValue[playerid] == 40)
				{
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpointEx(playerid, 1383.1172,-2285.7288,13.3110, 4.0, CHECKPOINT_CAREXAM, 41);
				}
				else if(gPlayerCheckpointValue[playerid] == 41)
				{
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpointEx(playerid, 1837.4260,-1558.3635,13.3704, 4.0, CHECKPOINT_CAREXAM, 42);
				}
				else if(gPlayerCheckpointValue[playerid] == 42)
				{
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpointEx(playerid, 1441.3636,-1590.0765,13.3828, 4.0, CHECKPOINT_CAREXAM, 43);
				}
				else if(gPlayerCheckpointValue[playerid] == 43)
				{
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpointEx(playerid, 1280.8734,-1567.3806,13.3828, 4.0, CHECKPOINT_CAREXAM, 44);
				}
				else if(gPlayerCheckpointValue[playerid] == 44)
				{
					DisablePlayerCheckpoint(playerid);
					gPlayerCheckpointStatus[playerid] = CHECKPOINT_NONE;
		            gPlayerCheckpointValue[playerid] = -1;

					if(GetPVarInt(playerid, "InDriveTest") == 2)
					{
						SendClientMessage(playerid, COLOR_STAT2, "Passenger: Thankyou!");

						if(PlayerData[playerid][pJob] == JOB_NONE)
						{
						    PlayerData[playerid][pJob] = JOB_TAXI;

							if(PlayerData[playerid][pSideJob] == JOB_NONE) SendClientMessage(playerid, COLOR_GRAD6, "/jobswitch to make it a sidejob.");
						}
						else
						{
							if(PlayerData[playerid][pSideJob] == JOB_NONE)
							{
							    PlayerData[playerid][pSideJob] = JOB_TAXI;
							}
							else
							{
                                SendClientMessage(playerid, COLOR_LIGHTRED, "You have to leave the job first (/leavejob or /leavesidejob)");
							}
						}

    					GameTextForPlayer(playerid, "~w~Congratulations! you are now a taxi driver!", 5000, 1);

			    		TakePlayerMoney(playerid, 5000);

			    		LessonStarted{playerid} = false;

						DeletePVar(playerid, "LessonSeconds");
						DeletePVar(playerid, "InDriveTest");
					}

					SetVehicleToRespawn(vehicleid);
				}
			}
			else
			{
			    SetPlayerCheckpoint(playerid, gPlayerCheckpointX[playerid], gPlayerCheckpointY[playerid], gPlayerCheckpointZ[playerid], 4.0);
			}
		}
		case CHECKPOINT_COMP:
		{
			DisablePlayerCheckpoint(playerid);
			gPlayerCheckpointStatus[playerid] = CHECKPOINT_NONE;
		}
		case CHECKPOINT_FARMER: // Harvest
		{
		    new vehicleid = GetPlayerVehicleID(playerid);

			if(far_start[playerid] && far_veh[playerid] == vehicleid)
			{
                if(far_place[playerid])
                {
				    if(gPlayerCheckpointValue[playerid] != -1 && IsPlayerInRangeOfPoint(playerid, 5.0, BlueFarm[gPlayerCheckpointValue[playerid]][0],BlueFarm[gPlayerCheckpointValue[playerid]][1],BlueFarm[gPlayerCheckpointValue[playerid]][2])) {

						PlayerPlaySoundEx(playerid, 17803);
						SetPlayerCheckpointEx(playerid, -53.5525,70.3079,4.0933, 5.0, CHECKPOINT_FARMER2);
					}
                }
                else
                {
				    if(gPlayerCheckpointValue[playerid] != -1 && IsPlayerInRangeOfPoint(playerid, 5.0, FlintFarm[gPlayerCheckpointValue[playerid]][0],FlintFarm[gPlayerCheckpointValue[playerid]][1],FlintFarm[gPlayerCheckpointValue[playerid]][2])) {

						PlayerPlaySoundEx(playerid, 17803);
						SetPlayerCheckpointEx(playerid, -377.8374,-1433.8853,25.7266, 5.0, CHECKPOINT_FARMER2);
					}
				}
			}
		}
		case CHECKPOINT_FARMER2: // Harvest
		{
			new vehicleid = GetPlayerVehicleID(playerid);

			if(far_start[playerid] && far_veh[playerid] == vehicleid)
			{
	            new randmoney = 100 + random(50);

	            format(sgstr, sizeof(sgstr), "~w~you got some wheat and sold it for~n~~y~%d$", randmoney);
	            GameTextForPlayer(playerid, sgstr, 5000, 1);

	            PlayerData[playerid][pPayCheck] += randmoney;

	            PlayerPlaySoundEx(playerid, 17803);

				//Next Harvesting

				if(PlayerData[playerid][pLevel] > 3)
				{
					gPlayerCheckpointX[playerid] = 0.0;
					gPlayerCheckpointY[playerid] = 0.0;
					gPlayerCheckpointZ[playerid] = 0.0;

					DisablePlayerCheckpoint(playerid);
					gPlayerCheckpointStatus[playerid] = CHECKPOINT_NONE;

					far_start[playerid] = 0;
					far_veh[playerid] = INVALID_VEHICLE_ID;
				}
				else StartHarvesting(playerid);
			}
		}
	}
	return true;
}

public OnPlayerLeaveDynamicArea(playerid, areaid)
{
	if(nearProperty_var[playerid] != -1)
	{
	    if(areaid == PropertyData[ nearProperty_var[playerid] ][hDynamicArea])
	    {
	        nearProperty_var[playerid] = -1;
	    }
	}

	if(nearApartment_var[playerid] != -1)
	{
	    if(areaid == ComplexData[ nearApartment_var[playerid] ][aDynamicArea])
	    {
	        nearApartment_var[playerid] = -1;
	    }
	}
	return true;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	switch(gPlayerCheckpointStatus[playerid])
	{
	    case CHECKPOINT_HOUSE:
		{
	        DisablePlayerCheckpoint(playerid);
	        gPlayerCheckpointStatus[playerid] = CHECKPOINT_NONE;
	        gPlayerCheckpointValue[playerid] = -1;
	        nearProperty_var[playerid] = -1;
		}
		case CHECKPOINT_APARTMENT:
		{
	        DisablePlayerCheckpoint(playerid);
	        gPlayerCheckpointStatus[playerid] = CHECKPOINT_NONE;
	        gPlayerCheckpointValue[playerid] = -1;
	        nearApartment_var[playerid] = -1;
		}
	}
	return true;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
    if(GetPlayerVisibleDynamicCP(playerid)) return 1;

	switch(PlayerData[playerid][pCP_Type])
	{
	    case RCHECKPOINT_TRUCKER:
		{
		    PlayerData[playerid][pCP_Type] = -1;
		    PlayerData[playerid][pCP_X] = 0.0;
		    PlayerData[playerid][pCP_Y] = 0.0;
		    PlayerData[playerid][pCP_Z] = 0.0;

			DisablePlayerRaceCheckpoint(playerid);
	    }
	    case RCHECKPOINT_TRUCKERJOB:
		{
		    PlayerData[playerid][pCP_Type] = -1;
		    PlayerData[playerid][pCP_X] = 0.0;
		    PlayerData[playerid][pCP_Y] = 0.0;
		    PlayerData[playerid][pCP_Z] = 0.0;

			DisablePlayerRaceCheckpoint(playerid);

			SendClientMessage(playerid, -1, " ");
	    }
	}
	return true;
}

/*public OnPlayerSelectedMenuRow(playerid, row)
{
    new Menu:Current = GetPlayerMenu(playerid);

	if(Current == Guide)
	{
	    switch(row)
	    {
	        case 0:
	        {
	            HideMenuForPlayer(Guide, playerid);
	            ShowMenuForPlayer(GuideJob1, playerid);
	            return 1;
			}
			case 1:
			{
			    SendClientMessage(playerid, COLOR_GREEN,"___________How to call taxi:___________");
				SendClientMessage(playerid, COLOR_WHITE,"/call 544");
				SendClientMessage(playerid, COLOR_GREEN,"______________________");

				//SendClientMessage(playerid, COLOR_WHITE,"To stand up /stopanim");
			}
			case 2:
			{
			    SendClientMessage(playerid, COLOR_GREEN,"___________Bus routes:___________");
				SendClientMessage(playerid, COLOR_WHITE,"BLACK ROUTE: LS Airport -> License Office -> Alhambra -> LS Bank -> Motel");
                SendClientMessage(playerid, COLOR_WHITE,"RED ROUTE: Food Mart -> Marina -> Rodeo -> Vinewood -> Hospital");
                SendClientMessage(playerid, COLOR_WHITE,"GREEN ROUTE: Vinewood 24/7 -> Dillimore -> Blueberry -> Montgomery -> Palomino Creek");
                SendClientMessage(playerid, COLOR_WHITE,"YELLOW ROUTE: Restaurant -> Market st. -> Bank -> Glen Park -> East LS -> Red Pen -> Grove st. -> LS Gym");
				SendClientMessage(playerid, COLOR_GREEN,"______________________");

				//SendClientMessage(playerid, COLOR_WHITE,"To stand up /stopanim");
			}
			case 3:
			{
			    SendClientMessage(playerid, COLOR_GREEN,"___________Where to live:___________");
				SendClientMessage(playerid, COLOR_WHITE,"- Pay to rent a room in the hotel.");
                SendClientMessage(playerid, COLOR_WHITE,"- Room for rent in the house behind.");
                SendClientMessage(playerid, COLOR_WHITE,"- Or live at LS Airport Motel");
				SendClientMessage(playerid, COLOR_GREEN,"______________________");

				//SendClientMessage(playerid, COLOR_WHITE,"To stand up /stopanim");
			}
			case 4:
			{
			    SendClientMessage(playerid, COLOR_GREEN,"___________Medic help:___________");
				SendClientMessage(playerid, COLOR_WHITE,"/call 911");
				SendClientMessage(playerid, COLOR_GREEN,"______________________");

				//SendClientMessage(playerid, COLOR_WHITE,"To stand up /stopanim");
			}
			case 5:
			{
			    SendClientMessage(playerid, COLOR_GREEN,"___________Police help:___________");
				SendClientMessage(playerid, COLOR_WHITE,"/call 911");
				SendClientMessage(playerid, COLOR_GREEN,"______________________");

				//SendClientMessage(playerid, COLOR_WHITE,"To stand up /stopanim");
			}
			case 6:
			{
			    SendClientMessage(playerid, COLOR_GREEN,"_____Legacy Roleplay Server Forums:_____");
				SendClientMessage(playerid, COLOR_WHITE,"(Read the rules and instructions there.)");
                SendClientMessage(playerid, COLOR_WHITE,"forum.legacy-rp.net");
				SendClientMessage(playerid, COLOR_GREEN,"______________________");

				//SendClientMessage(playerid, COLOR_WHITE,"To stand up /stopanim");
			}
		}
        SendClientMessage(playerid, COLOR_WHITE,"To stand up /stopanim");

	  	TogglePlayerControllable(playerid, 0);
  		ShowMenuForPlayer(Guide, playerid);
	}

	if(Current == GuideJob1)
	{
	    switch(row)
	    {
	        case 0:
	        {
	            HideMenuForPlayer(GuideJob1, playerid);
	            ShowMenuForPlayer(GuideJob2, playerid);
	            return 1;
			}
	        case 2: // Farmer
	        {
			    SendClientMessage(playerid, COLOR_GREEN,"___________Farmer:___________");
				SendClientMessage(playerid, COLOR_WHITE,"The farmer harvested the farm produce.");
                SendClientMessage(playerid, COLOR_WHITE,"/harvest");
                SendClientMessage(playerid, COLOR_YELLOW,"> The location of this occupation is marked on the map.");
				SendClientMessage(playerid, COLOR_GREEN,"______________________");
				SetPlayerCheckpoint(playerid, -382.5893,-1426.3422,26.2217, 3.5);
				gPlayerCheckpointStatus[playerid] = CHECKPOINT_NEWSPAPER;

			}
		}
        SendClientMessage(playerid, COLOR_WHITE,"To stand up /stopanim");

	  	TogglePlayerControllable(playerid, 0);
  		ShowMenuForPlayer(GuideJob1, playerid);
	}

	if(Current == GuideJob2)
	{
	    switch(row)
	    {
	        case 0:
	        {
	            HideMenuForPlayer(GuideJob2, playerid);
	            ShowMenuForPlayer(Guide, playerid);
	            return 1;
			}

	        case 2: // Car mechanic
	        {
		    	SendClientMessage(playerid, COLOR_GREEN,"___________Mechanic:___________");
				SendClientMessage(playerid, COLOR_WHITE,"Repair and paint the car using");
				SendClientMessage(playerid, COLOR_WHITE,"auto parts and trailers");
                SendClientMessage(playerid, COLOR_WHITE,"/paintcar /repaircar /carparts /refillcar");
                SendClientMessage(playerid, COLOR_YELLOW,"> The location of this occupation is marked on the map.");
				SendClientMessage(playerid, COLOR_GREEN,"______________________");
				SetPlayerCheckpoint(playerid, 88.4620,-165.0116,2.5938, 3.5);
				gPlayerCheckpointStatus[playerid] = CHECKPOINT_NEWSPAPER;
	            return 1;
			}
	        case 3: // Trucker
	        {
		    	SendClientMessage(playerid, COLOR_GREEN,"___________Trucker:___________");
				SendClientMessage(playerid, COLOR_WHITE,"Los Santos Trucks; The economy in the city.");
				SendClientMessage(playerid, COLOR_WHITE,"be ready for driving! (/truckerjob)");
                SendClientMessage(playerid, COLOR_YELLOW,"> The location of this occupation is marked on the map.");
				SendClientMessage(playerid, COLOR_GREEN,"______________________");
				SetPlayerCheckpoint(playerid, -78.0338,-1136.1221,1.0781, 3.5);
				gPlayerCheckpointStatus[playerid] = CHECKPOINT_NEWSPAPER;
	            return 1;
			}

		}

	  	TogglePlayerControllable(playerid, 0);
  		ShowMenuForPlayer(GuideJob1, playerid);
	}

	return true;
}*/

public OnPlayerExitedMenu(playerid)
{
	TogglePlayerControllable(playerid, true);
	return true;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	foreach (new x : Player)
	{
		if(PlayerData[x][pAdmin] && PlayerData[x][pSpectating] == playerid)
		{
			SetPlayerInterior(x, GetPlayerInterior(playerid));
			SetPlayerVirtualWorld(x, GetPlayerVirtualWorld(playerid));
		}
	}
	return true;
}

UpdateWeaponSettings(playerid, slot)
{
    new largeQuery[512];
    
    if(!WeaponSettings[playerid][slot][awID])
	{
		mysql_format(dbCon, largeQuery, sizeof(largeQuery), "INSERT INTO `weapon` (weaponid, x, y, z, rx, ry, rz, bone, hide, owner) VALUES(%d, %f, %f, %f, %f, %f, %f, %d, %d, %d)", WeaponSettings[playerid][slot][awWid],
		WeaponSettings[playerid][slot][aPx], WeaponSettings[playerid][slot][aPy], WeaponSettings[playerid][slot][aPz],
		WeaponSettings[playerid][slot][aPrx], WeaponSettings[playerid][slot][aPry], WeaponSettings[playerid][slot][aPrz],
		WeaponSettings[playerid][slot][awBone], WeaponSettings[playerid][slot][awHide], PlayerData[playerid][pID]);
		mysql_tquery(dbCon, largeQuery, "OnWeaponSettingsInsert", "dd", playerid, slot);
	}
	else
	{
	    mysql_format(dbCon, largeQuery, sizeof(largeQuery), "UPDATE weapon SET x = '%f', y = '%f', z = '%f', rx = '%f', ry = '%f', rz = '%f', bone = '%d', hide = '%d' WHERE id = '%d' LIMIT 1",
		WeaponSettings[playerid][slot][aPx], WeaponSettings[playerid][slot][aPy], WeaponSettings[playerid][slot][aPz],
		WeaponSettings[playerid][slot][aPrx], WeaponSettings[playerid][slot][aPry], WeaponSettings[playerid][slot][aPrz],
		WeaponSettings[playerid][slot][awBone], WeaponSettings[playerid][slot][awHide], WeaponSettings[playerid][slot][awID]);
		mysql_tquery(dbCon, largeQuery);
	}
	return true;
}

public OnPlayerEditAttachedObject(playerid, response, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ)
{
	if(EditingWeapon{playerid})
	{
		if(response)
		{
			new i = GetPVarInt(playerid, "AttachSlot");

			WeaponSettings[playerid][i][awBone] = boneid;
			WeaponSettings[playerid][i][aPx] = fOffsetX;
			WeaponSettings[playerid][i][aPy] = fOffsetY;
			WeaponSettings[playerid][i][aPz] = fOffsetZ;
			WeaponSettings[playerid][i][aPrx] = fRotX;
			WeaponSettings[playerid][i][aPry] = fRotY;
			WeaponSettings[playerid][i][aPrz] = fRotZ;

			UpdateWeaponSettings(playerid, i);

			cl_DressHoldWeapon(playerid, GetPlayerWeapon(playerid));

		    SendClientMessage(playerid, COLOR_YELLOW, "Updated weapon.");
		}
		else SendClientMessage(playerid, COLOR_LIGHTRED, "Aborted.");

		EditingWeapon{playerid} = false;
        RemovePlayerAttachedObject(playerid, 9);

        DeletePVar(playerid, "AttachSlot");
	}

	if(EditClothing{playerid})
	{
		if(response)
		{
		    new str[400];

		    mysql_format(dbCon, str, sizeof(str), "UPDATE clothing SET x = '%f', y = '%f', z = '%f', rx = '%f', ry = '%f', rz = '%f', scalex = '%f', scaley = '%f', scalez = '%f' WHERE id = '%d' AND owner = '%d' LIMIT 1",
			    fOffsetX,
			    fOffsetY,
			    fOffsetZ,
				fRotX,
				fRotY,
				fRotZ,
				fScaleX,
				fScaleY,
				fScaleZ,
				ClothingData[playerid][cl_selected[playerid]][cl_sid],
				PlayerData[playerid][pID]
			);

			mysql_tquery(dbCon, str);

			ClothingData[playerid][cl_selected[playerid]][cl_x] = fOffsetX;
			ClothingData[playerid][cl_selected[playerid]][cl_y] = fOffsetY;
			ClothingData[playerid][cl_selected[playerid]][cl_z] = fOffsetZ;
			ClothingData[playerid][cl_selected[playerid]][cl_rx] = fRotX;
			ClothingData[playerid][cl_selected[playerid]][cl_ry] = fRotY;
			ClothingData[playerid][cl_selected[playerid]][cl_rz] = fRotZ;
			ClothingData[playerid][cl_selected[playerid]][cl_scalex] = fScaleX;
			ClothingData[playerid][cl_selected[playerid]][cl_scaley] = fScaleY;
			ClothingData[playerid][cl_selected[playerid]][cl_scalez] = fScaleZ;

		}

		ClearAnimations(playerid);
		RemovePlayerClothing(playerid);
		cl_DressPlayer(playerid);

		EditClothing{playerid} = false;
	}

	if(BuyClothing{playerid})
	{
		if(response)
		{
		    new str[500], money, name[32];

			switch(cl_buying[playerid])
			{
			    case BUYSPORTS:
				{
					for(new i = 0; i != sizeof(cl_SportsData); ++i)
					{
						if(cl_SportsData[i][e_model] == modelid)
						{
							format(name, 32, "%s", cl_SportsData[i][e_name]);

							money = cl_SportsData[i][e_price];
						}
					}
				}
                case BUYZIP:
				{
					for(new i = 0; i != sizeof(cl_ZipData); ++i)
					{
						if(cl_ZipData[i][e_model] == modelid)
						{
							format(name, 32, "%s", cl_ZipData[i][e_name]), money = cl_ZipData[i][e_price];
						}
					}
				}
                case BUYMUSIC:
				{
					for(new i = 0; i != sizeof(cl_MusicData); ++i)
					{
						if(cl_MusicData[i][e_model] == modelid)
						{
							format(name, 32, "%s", cl_MusicData[i][e_name]), money = cl_MusicData[i][e_price];
						}
					}
				}
			}

            if(PlayerData[playerid][pCash] >= money)
            {
				new id = -1;

				if((id = AddPlayerClothing(playerid, modelid, fOffsetX, fOffsetY, fOffsetZ, fRotX, fRotY, fRotZ, boneid, index, fScaleX, fScaleY, fScaleZ, name)) != -1)
				{
					format(str,sizeof(str),"INSERT INTO `clothing` (`object`, `x`, `y`, `z`, `rx`, `ry`, `rz`, `bone`, `slot`, `owner`, `equip`, `scalex`, `scaley`, `scalez`, `name`) VALUES ('%d', '%f', '%f', '%f', '%f', '%f', '%f', '%d', '%d', '%d', '0', '%f', '%f', '%f', '%s')",
			            modelid,
					    fOffsetX,
					    fOffsetY,
					    fOffsetZ,
						fRotX,
						fRotY,
						fRotZ,
						boneid,
						index,
						PlayerData[playerid][pID],
						fScaleX,
						fScaleY,
						fScaleZ,
						name
					);

					mysql_tquery(dbCon, str, "OnQueryBuyClothing", "dd", playerid, id);

	                TakePlayerMoney(playerid, money);

                    SendClientMessage(playerid, COLOR_WHITE, "HINT: Use {FFFF00}SPACE{FFFFFF} to look around. Press {FFFF00}ESC{FFFFFF} to go back to the menu.");
	             	ShowPlayerFooter(playerid, "~g~Enjoy your new item!~n~~w~Use ~y~/clothing ~w~to edit your clothing items.", 10000);
				}
				else return SendClientMessage(playerid, COLOR_LIGHTRED, "You can't buy more clothing items.");
            }
			else SendClientMessage(playerid, COLOR_LIGHTRED, "You don't have enough money to pay for it.");
		}

		RemovePlayerClothing(playerid);
        cl_ResetDressPlayer(playerid);

		cl_buying[playerid] = 0; cl_buyingpslot[playerid] = -1;
		ClearAnimations(playerid);
		BuyClothing{playerid} = false;
	}
	return true;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(PlayerData[playerid][pInTuning])
 	{
  		new
	  		string[128],
	  		vehID = CoreVehicles[GetPlayerVehicleID(playerid)][vehicleCarID],
	  		categoryTuning = PlayerData[playerid][pTuningCategoryID]
		;

		if(newkeys & KEY_LOOK_RIGHT || newkeys & KEY_LOOK_LEFT)
		{
			PlayerData[playerid][pTuningCategoryID] = (newkeys & KEY_LOOK_RIGHT) ? categoryTuning + 1 : categoryTuning - 1;

			if(PlayerData[playerid][pTuningCategoryID] > 10) PlayerData[playerid][pTuningCategoryID] = 10;
			if(PlayerData[playerid][pTuningCategoryID] < 0) PlayerData[playerid][pTuningCategoryID] = 0;

			categoryTuning = PlayerData[playerid][pTuningCategoryID];

			if(categoryTuning != 0 && categoryTuning != 10)
			{
	  			format(string, sizeof(string), "~y~%s~w~ (~<~) %s (~>~)~y~ %s", TuningCategories[categoryTuning - 1], TuningCategories[categoryTuning], TuningCategories[categoryTuning + 1]);
	     		PlayerTextDrawSetString(playerid, TDTuning_Component[playerid], string);
				PlayerTextDrawShow(playerid, TDTuning_Component[playerid]);
			}
	        else
	        {
				format(string, sizeof(string), (!categoryTuning) ? ("%s (~>~)~y~ %s") : ("~y~%s~w~ (~>~) %s"), TuningCategories[(newkeys & KEY_LOOK_RIGHT) ? categoryTuning - 1 : categoryTuning], TuningCategories[(newkeys & KEY_LOOK_RIGHT) ? categoryTuning : categoryTuning + 1]);
				PlayerTextDrawSetString(playerid, TDTuning_Component[playerid], string);
				PlayerTextDrawShow(playerid, TDTuning_Component[playerid]);
			}

			Tuning_SetDisplay(playerid);
		}
		else if(newkeys & KEY_FIRE || newkeys & KEY_HANDBRAKE)
		{
		    new validCount = GetVehicleComponentCount(categoryTuning, CarData[vehID][carModel]), tuningCount = PlayerData[playerid][pTuningCount];

		    if(tuningCount && (newkeys & KEY_FIRE && tuningCount != validCount) || (newkeys & KEY_HANDBRAKE && tuningCount != 0 && tuningCount != 1) && validCount)
		    {
			    PlayerData[playerid][pTuningCount] = (newkeys & KEY_FIRE) ? tuningCount + 1 : tuningCount - 1;
                Tuning_SetDisplay(playerid, PlayerData[playerid][pTuningCount]);
			}
			else return 1;
		}
		else if(newkeys & KEY_YES)
		{
			if(!PlayerData[playerid][pTuningCount])
				return SendServerMessage(playerid, "You have not selected any car parts.");

		    new componentPrice = (categoryTuning == 10) ? 2500 : GetComponentPrice(PlayerData[playerid][pTuningComponent]);

			if(componentPrice > PlayerData[playerid][pCash])
				return SendServerMessage(playerid, "You don't have enough money.");

		 	TakePlayerMoney(playerid, componentPrice);

			if(categoryTuning == 10)
			{
   				ChangeVehiclePaintjob(CarData[vehID][carVehicle], PlayerData[playerid][pTuningComponent]);
	            CarData[vehID][carPaintjob] = PlayerData[playerid][pTuningComponent];
	            Car_SaveID(vehID);
			}
			else Tuning_AddComponent(vehID, PlayerData[playerid][pTuningComponent]);

			PlayerPlaySound(playerid, 1134, 0, 0, 0);
			
			Streamer_Update(playerid, STREAMER_TYPE_OBJECT);
		}
		else if(newkeys & KEY_NO) Tuning_ExitDisplay(playerid);
	}

	if(BreakingIn[playerid] != -1)
	{
	    new vehicleid = BreakingIn[playerid];

	    if(!CoreVehicles[vehicleid][vbreakin])
	    {
	        BreakingIn[playerid] = -1;
	        return true;
		}

		if(CoreVehicles[vehicleid][vbreakin] && Released(KEY_FIRE) && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT && !CoreVehicles[vehicleid][vbreakdelay])
		{
	    	if(IsPlayerNearDriverDoor(playerid, vehicleid) || IsABoatModel(GetVehicleModel(vehicleid)))
			{
	            new id = Car_GetID(vehicleid);

	            if(CarData[id][carLock] == 5) return 1;

			 	if(IsValidDynamic3DTextLabel(VehicleLabel[vehicleid][vLabel])) DestroyDynamic3DTextLabel(VehicleLabel[vehicleid][vLabel]);

                if(CarData[id][carLock] == 1) CoreVehicles[vehicleid][vbreakdelay] = 1;
				else if(CarData[id][carLock] == 2) CoreVehicles[vehicleid][vbreakdelay] = 1;
				else if(CarData[id][carLock] == 3) CoreVehicles[vehicleid][vbreakdelay] = 2;
				else if(CarData[id][carLock] == 4) CoreVehicles[vehicleid][vbreakdelay] = 3;
				else CoreVehicles[vehicleid][vbreakdelay] = 1;

		       	CalculateDoorDamage(vehicleid, playerid);

		       	CoreVehicles[vehicleid][vbreaktime] = 20;

				SetVehicleLabel(vehicleid, VLT_TYPE_BREAKIN, 3);

				if(CoreVehicles[vehicleid][vbreakin] <= 0)
				{
					CancelVehicleBreakin(vehicleid);

				    BreakingIn[playerid] = -1;

					new
						engine,
						lights,
						alarm,
						doors,
						bonnet,
						boot,
						objective;

					GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
					SetVehicleParamsEx(vehicleid, engine, lights, 0, 0, bonnet, boot, 0);

					CarData[id][carLocked] = false;
				}
			}
		}
	}

	/*if(newkeys & KEY_CTRL_BACK) // doesn't work
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
		    if(GetPlayerCameraMode(playerid) == 55)
			{
	            RemovePlayerDriveby(playerid);
	            return true;
			}
		}
	}*/

	if(Pressed(KEY_WALK))
	{
	    if(PlayerData[playerid][pFreeze] == 1)
	    {
	        KillTimer(PlayerData[playerid][pFreezeTimer]);

	        TogglePlayerControllable(playerid, true);
	        PlayerData[playerid][pFreeze] = 0;
		}

		/*if(PlayerData[playerid][pSpectating] != INVALID_PLAYER_ID && PlayerData[playerid][pAdmin] >= 1)
		{
			PlayerData[playerid][pSpectating] = INVALID_PLAYER_ID;

		    TogglePlayerSpectating(playerid, false);
			SetCameraBehindPlayer(playerid);

		    SetPlayerDynamicPos(playerid, PlayerData[playerid][pPos][0], PlayerData[playerid][pPos][1], PlayerData[playerid][pPos][2]);
		    SetPlayerInterior(playerid, PlayerData[playerid][pInterior]);
		    SetPlayerVirtualWorld(playerid, PlayerData[playerid][pWorld]);

			SetPlayerWeapons(playerid);
			return true;
		}*/		
	}

	if(PfSpec[playerid][FlySpec] == 1)
	{
		if((newkeys & KEY_JUMP) && !(oldkeys & KEY_JUMP))
		{
			PfSpec[playerid][fspeed] = 150;
		}
		if((newkeys & KEY_SPRINT) && !(oldkeys & KEY_SPRINT))
		{
			PfSpec[playerid][fspeed] = 10;
		}
		if(!(newkeys & KEY_JUMP) && (oldkeys & KEY_JUMP))
		{
			PfSpec[playerid][fspeed] = 50;
		}
		if(!(newkeys & KEY_SPRINT) && (oldkeys & KEY_SPRINT))
		{
			PfSpec[playerid][fspeed] = 50;
		}
	}

	if(Pressed(KEY_JUMP))
	{
	    if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_CUFFED)
		{
			ApplyAnimation(playerid, "GYMNASIUM", "gym_jog_falloff", 4.1, 0, 1, 1, 0, 0, 1);
		}
	}

	if(BrokenLeg{playerid})
	{
	    if(!PlayerData[playerid][pInjured] && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	    {
			if(newkeys & KEY_JUMP && !(oldkeys & KEY_JUMP))
			{
				ApplyAnimation(playerid, "GYMNASIUM", "gym_jog_falloff", 4.1, 0, 1, 1, 0, 0, 1);
				ApplyAnimation(playerid, "GYMNASIUM", "gym_jog_falloff", 4.1, 0, 1, 1, 0, 0, 1);
			}

			if(newkeys & KEY_SPRINT && !(oldkeys & KEY_SPRINT))
			{
				ApplyAnimation(playerid, "ped", "FALL_collapse", 4.1, 0, 1, 1, 0, 0, 1);
				ApplyAnimation(playerid, "ped", "FALL_collapse", 4.1, 0, 1, 1, 0, 0, 1);
			}
		}
	}	

	if(Pressed(KEY_FIRE))
	{
		new weaponid = GetPlayerWeapon(playerid);

	    if(weaponid == 0)
		{
			if(TackleMode{playerid})
			{
				if(GetPlayerAnimationIndex(playerid) != 1120 && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
				{
					SetTimerEx("FallAnimation", 600, false, "i", playerid);
					return true;
				}
			}
		}

	    if(weaponid == 41)
	    {
			if(!ReplacingGraffiti{playerid})
			{
				new spray_id = -1, bool:can_spray = true;

				for(new i = 0; i < MAX_SPRAY_LOCATIONS; ++i)
				{
					if(Spray_Data[i][graffSQLID] != -1)
					{
						if(IsPlayerInRangeOfPoint(playerid, 3.0, Spray_Data[i][Xpos], Spray_Data[i][Ypos], Spray_Data[i][Zpos]))
						{
							spray_id = i;
							break;
						}
					}
				}

				if(spray_id != -1)
				{
					foreach (new i : StreamedPlayer[playerid])
					{
						if(i == playerid || !ReplacingGraffiti{i}) continue;

						if(GetPVarInt(i, "SprayID") == spray_id)
						{
							can_spray = false;
							break;
						}
					}

					if(can_spray)
					{
						if(!SprayingType[playerid])
						{
							SprayAmmountCH[playerid] = strlen(ReturnCleanName(GraffitiName[playerid]));
						}
						else 
						{
							SprayAmmountCH[playerid] = strlen(ReturnCleanName(Spray_Data[spray_id][graffName]));
						}

						if(strlen(SprayAmmountCH[playerid]) > 0)
						{
							ReplacingGraffiti{playerid} = true;
							SetPVarInt(playerid, "SprayID", spray_id);
							SprayAmmount[playerid] = -1;
							spraytimer[playerid] = SetTimerEx("SprayTimer", 1000, true, "ii", playerid, spray_id);
						}
					}
				}
			}
		}
	}

	if(Released(KEY_FIRE))
	{
	    if(ReplacingGraffiti{playerid})
	    {
		    GameTextForPlayer(playerid, "~r~Spray canceled", 5000, 5);

            if(SprayAmmount[playerid] != SprayAmmountCH[playerid])
            {
                new id = GetPVarInt(playerid, "SprayID");

                GetPVarString(playerid, "GraffitiName", Spray_Data[id][graffName], 256);
            }

			ResetSprayVariables(playerid);
		}
	}

	if(Pressed(KEY_YES))
	{
	    if(PlayerData[playerid][pFreeze] == 1)
	    {
	        KillTimer(PlayerData[playerid][pFreezeTimer]);

	        TogglePlayerControllable(playerid, true);
	        PlayerData[playerid][pFreeze] = 0;
		}

	    if(LicenseOffer[playerid] != INVALID_PLAYER_ID)
		{
		    ShowLicensesUI(LicenseOffer[playerid], playerid);

		    SendClientMessage(playerid, 0xADC3E7FF, "[ ! ] You are now viewing a license. Press Y to close, or N to print to chat.");

		    LicenseOffer[playerid] = INVALID_PLAYER_ID;
		}
		else
		{
			if(ViewingLicense[playerid] != INVALID_PLAYER_ID)
			{
			    ViewingLicense[playerid] = INVALID_PLAYER_ID;

			    for(new i = 0; i < 10; ++i)
				{
					PlayerTextDrawHide(playerid, LicensesUI[playerid][i]);
				}
			}
		}

		if(tToAccept[playerid] != OFFER_TYPE_NONE)
		{
			new str[128];

			format(str, sizeof(str), "~n~~n~~n~~y~%s ~g~has accepted your offer!", ReturnName(playerid, 0));
			GameTextForPlayer(pToAccept[playerid], str, 3000, 5);

			format(str, sizeof(str), "~n~~n~~n~~g~You have accepted ~y~%s's~g~ offer!", ReturnName(pToAccept[playerid], 0));
			GameTextForPlayer(playerid, str, 3000, 5);

		    switch(tToAccept[playerid])
			{
		        case OFFER_TYPE_VSELL:
				{
					if(PlayerData[playerid][pCash] >= prToAccept[playerid])
					{
					    new userid = pToAccept[playerid], carid = vToAccept[playerid];

					    if(Iter_Contains(sv_playercar, carid) && IsPlayerInAnyVehicle(userid) && GetPlayerVehicleID(userid) == CarData[carid][carVehicle] && !IsDonateCar(CarData[carid][carModel]))
					    {
							if(CountPlayerVehicles(playerid) < 12 && CountVehicleKeys(playerid) < MaxVehiclesSpawned(playerid))
							{
						        SendNearbyMessage(playerid, 20.0, COLOR_GREEN, "(( %s accepts %s's offer to buy the vehicle for $%d. ))", ReturnName(playerid, 0), ReturnName(pToAccept[playerid], 0), prToAccept[playerid]);

								SendClientMessage(playerid, 0xADFF2FFF, "PROCESSING:Rebuilding your /v list...");

								TakePlayerMoney(playerid, prToAccept[playerid]);
								SendPlayerMoney(userid, prToAccept[playerid]);

								CarData[carid][carOwner] = PlayerData[playerid][pID];

								RemoveVehicleKey(userid, carid);
								GiveVehicleKey(playerid, carid);

								SendClientMessage(playerid, 0xADFF2FFF, "PROCESSED:List Rebuilt.");

								mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `characters` SET `Cash` = '%d' WHERE `ID` = '%d' LIMIT 1", PlayerData[playerid][pCash], PlayerData[playerid][pID]);
								mysql_tquery(dbCon, gquery);

								mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `characters` SET `Cash` = '%d' WHERE `ID` = '%d' LIMIT 1", PlayerData[userid][pCash], PlayerData[userid][pID]);
								mysql_tquery(dbCon, gquery);

								Car_SaveID(carid);
							}
						    else
						    {
						        SendClientMessage(userid, COLOR_LIGHTRED, "Something went wrong while trying to sell the vehicle.");
						        SendClientMessage(playerid, COLOR_LIGHTRED, "Something went wrong while trying to sell the vehicle.");
						    }
					    }
					    else
					    {
					        SendClientMessage(userid, COLOR_LIGHTRED, "Something went wrong while trying to sell the vehicle.");
					        SendClientMessage(playerid, COLOR_LIGHTRED, "Something went wrong while trying to sell the vehicle.");
					    }
					}
					else
					{
						SendClientMessage(playerid, COLOR_LIGHTRED, "You don't have enough money.");
						SendClientMessage(pToAccept[playerid], COLOR_LIGHTRED, "Vehicle couldn't be sold to the player because he doesn't have the cash required.");
					}

					pToAccept[playerid] = INVALID_PLAYER_ID;
					vToAccept[playerid] = 9999;
					prToAccept[playerid] = 0;
					tToAccept[playerid] = 0;
          		}
		        case OFFER_TYPE_SERVICE:
				{
		      		ShowPlayerFooter(pToAccept[playerid], "~h~~p~PULL OUT YOUR SPRAYCAN.", -1);
		      		
			     	RepairTime{pToAccept[playerid]} = serviceComp[pToAccept[playerid]];
			     	
		            pToAccept[playerid] = INVALID_PLAYER_ID;
					tToAccept[playerid] = 0;
		        }
		        case OFFER_TYPE_RENT:
		        {
		            new userid = pToAccept[playerid], house = InProperty[userid];
		            
					if(house != -1)
					{
					    if(Iter_Contains(Property, house))
					    {
						    if(Property_IsOwner(userid, house))
						    {
								PlayerData[playerid][pHouseKey] = house;
								PlayerData[playerid][pSpawnPoint] = 2;

								new
								    playerStreet[MAX_ZONE_NAME],
								    apartment = PropertyData[house][hComplexID]
								;

								if(apartment == -1)
								{
									GetStreet(PropertyData[house][hEntranceX], PropertyData[house][hEntranceY], playerStreet, MAX_ZONE_NAME);
								}
								else
								{
								    GetStreet(ComplexData[apartment][aEntranceX], ComplexData[apartment][aEntranceY], playerStreet, MAX_ZONE_NAME);
								}

								SendNoticeMessage(userid, "%s accepted your offer to rent at %d %s.", ReturnName(playerid, 0), PropertyData[house][hID], playerStreet);

								mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `characters` SET`SpawnPoint` = '2', `playerHouseKey` = '%d' WHERE `ID` = '%d' LIMIT 1", PlayerData[playerid][pCash], house, PlayerData[playerid][pID]);
								mysql_pquery(dbCon, gquery);
						    }
						}
					}
					
		            pToAccept[playerid] = INVALID_PLAYER_ID;
					tToAccept[playerid] = 0;
		        }
			}

   			HidePlayerFooter(playerid);
		}
		else
		{
		    if(!IsPlayerInAnyVehicle(playerid) && (Holding(KEY_HANDBRAKE) || Pressed(KEY_HANDBRAKE)))
		    {
				new targetplayer = GetPlayerTargetPlayer(playerid);

			    if(targetplayer != INVALID_PLAYER_ID)
			    {
			        format(sgstr, sizeof(sgstr), "%s%s%s", ReturnName(targetplayer, 0), strlen(PlayerData[targetplayer][pAttribute]) ? (" | ") : (""), PlayerData[targetplayer][pAttribute]);
					SetPlayerChatBubble(targetplayer, sgstr, COLOR_PURPLE, 20.0, 6000);
			    }
			    else
				{
			        SendClientMessage(playerid, COLOR_LIGHTRED, "-> No targets found. Protip: Make sure the green arrow is present over their head before pressing Y.");
			    }
			}
		}
	}

	if(Pressed(KEY_NO))
	{
	    if(LicenseOffer[playerid] != INVALID_PLAYER_ID)
		{
		    PrintLicenses(LicenseOffer[playerid], playerid);

		    LicenseOffer[playerid] = INVALID_PLAYER_ID;
		}
		else if(ViewingLicense[playerid] != INVALID_PLAYER_ID)
		{
		    PrintLicenses(ViewingLicense[playerid], playerid);
		}

		if(tToAccept[playerid] != OFFER_TYPE_NONE)
		{
		    new str[128];
		    format(str, sizeof(str), "~n~~n~~n~~y~%s ~r~has denied your offer!", ReturnName(playerid, 0));
		    GameTextForPlayer(pToAccept[playerid], str, 3000, 5);

		    format(str, sizeof(str), "~n~~n~~n~~r~You have denied ~y~%s~r~ offer!", ReturnName(pToAccept[playerid], 0));
		    GameTextForPlayer(playerid, str, 3000, 5);

			switch(tToAccept[playerid])
			{
		  		case OFFER_TYPE_VSELL:
				{
		  			vToAccept[playerid] = 9999; prToAccept[playerid] = 0;
				}
		  		case OFFER_TYPE_SERVICE:
			 	{
					serviceComp[pToAccept[playerid]] = 0;
					serviceTowtruck[pToAccept[playerid]] = 0;
					serviceCustomer[pToAccept[playerid]] = 0;
					serviceFocus[pToAccept[playerid]] = 0;
					serviced[pToAccept[playerid]] = 0;
				}
			}

 	 		tToAccept[playerid] = 0;
 	 		pToAccept[playerid] = INVALID_PLAYER_ID;
 	 		
		   	HidePlayerFooter(playerid);
		}
	}

	if((newkeys & KEY_LOOK_BEHIND || newkeys & KEY_SUBMISSION))
	{
		if((GetPVarInt(playerid, "JustBoughtFurniture") || GetPVarInt(playerid, "EditingFurniture")))
		{
			new houseid = InProperty[playerid];

			if(houseid != -1)
			{
				new furnitureslot = GetPVarInt(playerid, "ChosenFurnitureSlot");
				new objectid = HouseFurniture[houseid][furnitureslot][fObject];

				new Float:px, Float:py, Float:pz;
				GetPlayerPos(playerid, px, py, pz);
				GetXYInFrontOfPlayer(playerid, px, py, 1.5);

				if(IsValidDynamicObject(objectid))
				{
					SetDynamicObjectPos(objectid, px, py, pz);
					SetDynamicObjectRot(objectid, 0, 0, 0);
				}
			}

			houseid = InBusiness[playerid];

			if(houseid != -1)
			{
				new furnitureslot = GetPVarInt(playerid, "ChosenFurnitureSlot");
				new objectid = BizFurniture[houseid][furnitureslot][fObject];

				new Float:px, Float:py, Float:pz;
				GetPlayerPos(playerid, px, py, pz);
				GetXYInFrontOfPlayer(playerid, px, py, 1.5);

				if(IsValidDynamicObject(objectid))
				{
					SetDynamicObjectPos(objectid, px, py, pz);
					SetDynamicObjectRot(objectid, 0, 0, 0);
				}
			}
		}
    }

	if(PlayerData[playerid][pTutorialStep])
	{
		if((gettime() - TutorialDelay[playerid]) > 2)
		{
			if(Released(KEY_SPRINT)) // Forward
			{
				PlayerData[playerid][pTutorialStep]++;

				ClearChatBox(playerid);

				RefreshTutorial(playerid);
			}
			else if(Released(KEY_JUMP)) // Backward
			{
				if(PlayerData[playerid][pTutorialStep] == 1)
				{
					PlayerPlaySound(playerid, 1055, 0.0, 0.0, 0.0);
					return true;
				}

				PlayerData[playerid][pTutorialStep]--;

				ClearChatBox(playerid);

				RefreshTutorial(playerid);
			}
		}
    }
	return true;
}

RefreshTutorial(playerid)
{
    if(PlayerData[playerid][pTutorialStep])
    {
		TutorialDelay[playerid] = gettime();

    	switch(PlayerData[playerid][pTutorialStep])
        {
            case 1:
            {
			 	SendClientMessage(playerid, COLOR_WHITE, ">> Welcome to Legacy Roleplay!");
				SendClientMessage(playerid, COLOR_GRAD2, "This video tutorial will guide you for your first steps on Legacy-RP.");
				SendClientMessage(playerid, COLOR_GRAD2, "The tutorial will go through on its own.");
				SendClientMessage(playerid, COLOR_GRAD2, "We highly recommend you to take your time reading the text in the chat box.");

                InterpolateCameraPos(playerid, 1669.1499,-2328.8406,-3.5769, 1541.1512,-2287.1345,91.9661, 1500, CAMERA_MOVE);
                InterpolateCameraLookAt(playerid, 1654.4652,-2333.6084,-2.6797, 1623.3582,-2288.0413,77.9914, 1500, CAMERA_MOVE);
            }
            case 2:
            {
				SendClientMessage(playerid, COLOR_WHITE, ">> First time in Los Santos.");
			    SendClientMessage(playerid, COLOR_GRAD2, " Welcome to the city of Los Santos, the largest city within the state of San Andreas. ");
			    SendClientMessage(playerid, COLOR_GRAD2, " You're currently living at the Airport Motel, Untill you find yourself a better place.");
			    SendClientMessage(playerid, COLOR_GRAD2, " You might want to start with reading today's newspaper, where you can find yourself some helpful information.");
				SendClientMessage(playerid, COLOR_GRAD2, " The newspaper dispenser is located right next to	the Airport Motel, your current spawn point. ");
				SendClientMessage(playerid, COLOR_GRAD2, " Go to the 'i' marker and type /newspaper to read.");

            	InterpolateCameraPos(playerid, 1541.1512,-2287.1345,91.9661, 1669.1499,-2328.8406,-3.5769, 1500, CAMERA_MOVE);
           		InterpolateCameraLookAt(playerid, 1623.3582,-2288.0413,77.9914, 1654.4652,-2333.6084,-2.6797, 1500, CAMERA_MOVE);
            }
            case 3:
            {
			    SendClientMessage(playerid, COLOR_WHITE, ">> Transportation");
			    SendClientMessage(playerid, COLOR_GRAD2, "In order to move around the city, you will have to get yourself a ride.");
			    SendClientMessage(playerid, COLOR_GRAD2, "You can either wait for a bus, call a taxi or rent a vehicle for a certain amount of money");
			    SendClientMessage(playerid, COLOR_GRAD2, "/service taxi for a taxi service, /service bus for a bus service. Rentable cars can be found around the city.");
			    GameTextForPlayer(playerid, "~p~/service ~w~ to call ~n~ ~y~ Los Santos Public ~n~ ~y~ Transportation Services", 3200, 3);

                InterpolateCameraPos(playerid, 1669.1499,-2328.8406,-3.5769, 1807.2902,-1939.7085,67.2748, 1500, CAMERA_MOVE);
                InterpolateCameraLookAt(playerid, 1654.4652,-2333.6084,-2.6797, 1773.8251,-1902.2825,13.5502, 1500, CAMERA_MOVE);
            }
            case 4:
            {
				SendClientMessage(playerid, COLOR_WHITE, ">> Live on your own.");
				SendClientMessage(playerid, COLOR_GRAD2, "When you feel like it's time to move out of the Airport Motel to your own place you should start looking for a new house or another motel.");
				SendClientMessage(playerid, COLOR_GRAD2, "There are plenty of houses around Los Santos that can be either purchased or rented by anyone in exchange for some money.");
				SendClientMessage(playerid, COLOR_GRAD2, "There are also a few hotels and motels around the city where you can rent a room for a certain amount of money.");
				GameTextForPlayer(playerid, "~y~ Idlewood Motel ~n~ ~p~/rent /rentroom", 3200, 3);

                InterpolateCameraPos(playerid, 1807.2902,-1939.7085,67.2748, 2119.4541,-1751.1744,21.5524, 1500, CAMERA_MOVE);
                InterpolateCameraLookAt(playerid, 1773.8251,-1902.2825,13.5502, 2155.6519,-1776.4888,18.5486, 1500, CAMERA_MOVE);
            }
            case 5:
            {
			    SendClientMessage(playerid, COLOR_WHITE, ">> Keep a healthy lifestyle.");
			    SendClientMessage(playerid, COLOR_GRAD2, "Always try to keep yourlife style healthy and eat in time. You will start loosing HP constantly when you character becomes hungry.");
			    SendClientMessage(playerid, COLOR_GRAD2, "Usage of drugs will possibly lower your HP, increase your hunger level, and even get you sick or killed.");
			    SendClientMessage(playerid, COLOR_GRAD2, "There are many resturants around the city, where you can eat, increase your HP and lower your hunger level.");
			    GameTextForPlayer(playerid, "~y~ Willowfield Cluckin' bell ~n~ ~p~ /eat", 3900, 3);

                InterpolateCameraPos(playerid, 2119.4541,-1751.1744,21.5524, 2413.5383, -1885.4564, 23.2313, 1500, CAMERA_MOVE);
                InterpolateCameraLookAt(playerid, 2155.6519,-1776.4888,18.5486, 2412.8733, -1886.1985, 23.0213, 1500, CAMERA_MOVE);
            }
            case 6:
            {
			    SendClientMessage(playerid, COLOR_WHITE, ">> Communicate and meet new people.");
			    SendClientMessage(playerid, COLOR_GRAD2, "Los Santos'society is quite big. There are many kinds of people around with different hobbies and interests.");
			    SendClientMessage(playerid, COLOR_GRAD2, "You can meet new people around the most populer places in the city. It can either be a club, pub, resturant or anywhere else.");
			    SendClientMessage(playerid, COLOR_GRAD2, "One of the most popular places, which serves for a meeting place as well as shopping, is the mall");
				SendClientMessage(playerid, COLOR_GRAD2, "The mall is one of the various hot spots in Los Santos where you can communicate and interact with random people.");
			    SendClientMessage(playerid, COLOR_GRAD2, "There are plenty of shops in the mall, such as clothes, tools, electronics, Musical instruments and even more.");
			    SendClientMessage(playerid, COLOR_GRAD2, "You can buy saveable items that can improve your roleplay atmosphere and your character's look.");
			    GameTextForPlayer(playerid, "~w~ Los Santos Mall", 3900, 3);

            	/*InterpolateCameraPos(playerid, 2413.5383, -1885.4564, 23.2313, 1129.1364,-1359.0806,60.4063, 3000, CAMERA_MOVE);
                InterpolateCameraLookAt(playerid, 2412.8733, -1886.1985, 23.0213, 1129.1011,-1488.4135,22.7614, 3000, CAMERA_MOVE);*/
            }
            case 7:
            {
			    SendClientMessage(playerid, COLOR_WHITE, ">> Obtain your own properties");
			    SendClientMessage(playerid, COLOR_GRAD2, "You can obtain your own properites around the city by publishing advertismets, talking to people or visting shops.");
				SendClientMessage(playerid, COLOR_GRAD2, "Properties can be given to you in exchange of some money, or without a payment at all. It is all up to the way you roleplay it.");
				SendClientMessage(playerid, COLOR_GRAD2, "You can purchase new houses and vehicles from dealership or other players around the server");
				SendClientMessage(playerid, COLOR_GRAD2, "You can also steam properties from other players in your own roleplay ways and techniques.");
			 	SendClientMessage(playerid, COLOR_GRAD2, "However, stealing may not always be the clean way to do things, and someone might be looking for you afterwards.");
			 	GameTextForPlayer(playerid, "~w~ Advertisement Office", 3900, 3);

            	InterpolateCameraPos(playerid, 1129.1364,-1359.0806,60.4063, 1697.8542,-1308.5330,60.4948, 1500, CAMERA_MOVE);
                InterpolateCameraLookAt(playerid, 1129.1011,-1488.4135,22.7614, 1736.1309,-1267.8335,13.5431, 1500, CAMERA_MOVE);
            }
            case 8:
            {
			    SendClientMessage(playerid, COLOR_WHITE, ">> Increase you income");
			    SendClientMessage(playerid, COLOR_GRAD2, "Before purchasing anything, you will need money. There are many different ways to earn money around Los Santos.");
				SendClientMessage(playerid, COLOR_GRAD2, "You can either publish an advertisment, ask people for it on your own way or check the newspaper.");
				SendClientMessage(playerid, COLOR_GRAD2, "You can also earn money on your unique way. It's all up to your creativity");
				GameTextForPlayer(playerid, "~w~ Pizza Job", 3900, 3);

                InterpolateCameraPos(playerid, 1697.8542,-1308.5330,60.4948, 2091.2349, -1767.2347, 33.5644, 1500, CAMERA_MOVE);
                InterpolateCameraLookAt(playerid, 1736.1309,-1267.8335,13.5431, 2091.8325, -1768.0430, 32.9144, 1500, CAMERA_MOVE);
            }
            case 9:
            {
			    SendClientMessage(playerid, COLOR_WHITE, ">> Public Services:");
			    SendClientMessage(playerid, COLOR_GRAD2, "Los Santos public services will always be there for you when you require their services.");
				SendClientMessage(playerid, COLOR_GRAD2, "There are two law enforcement agencies which are the {8D8DFF}Los Santos Police Department {BFC0C2}and {8D8DFF}San Andreas Sheriff's Department");
				SendClientMessage(playerid, COLOR_GRAD2, "The {FF8282}Los Santos Fire Department {BFC0C2}is in charge of Los Santos medicine. They provide both hospital and EMT services.");
				SendClientMessage(playerid, COLOR_GRAD2, "If you ever require any of the listed agencies service, do not hesitate to dail 911 amd call them.");
			    GameTextForPlayer(playerid, "~w~ All Sanints General Hospital", 3900, 3);

                InterpolateCameraPos(playerid, 2091.2349, -1767.2347, 33.5644, 1206.9229, -1377.9990, 47.1973, 1500, CAMERA_MOVE);
                InterpolateCameraLookAt(playerid, 2091.8325, -1768.0430, 32.9144, 1206.2468, -1377.2543, 46.7572, 1500, CAMERA_MOVE);
            }
            case 10:
            {
			    SendClientMessage(playerid, COLOR_WHITE, ">> Server Rules");
			    SendClientMessage(playerid, COLOR_GRAD2, "Always remember to follow all the rules, respect everyone and listen to administrators instructions");
				SendClientMessage(playerid, COLOR_GRAD2, "This is a Roleplay server. Always remember to follow all roleplay rules (PG, MG, DM, unrealistic roleplay etc.) and roleplay all the times.");
				SendClientMessage(playerid, COLOR_GRAD2, "As the time goes by you will learn more about roleplay and more about the server, If you need help");

            	InterpolateCameraPos(playerid, 1206.9229, -1377.9990, 47.1973, 1474.6232,-1723.1591,42.9895, 1500, CAMERA_MOVE);
                InterpolateCameraLookAt(playerid, 1206.2468, -1377.2543, 46.7572, 1480.6512,-1771.0350,31.6094, 1500, CAMERA_MOVE);
            }
            case 11:
            {
 				SendClientMessage(playerid, COLOR_WHITE, ">> Conclusion:");
				SendClientMessage(playerid, COLOR_GRAD3, "Always keep in mind that you must obey all server rules, respect or honor all players, and listen to advice from the server administrators.");
            }
			case 12:
			{
			    FinishedTutorial{playerid} = true;

				PlayerData[playerid][pTutorialStep] = 0;

				PlayerData[playerid][pPos][0] = 1643.0010;
				PlayerData[playerid][pPos][1] = -2331.7056;
				PlayerData[playerid][pPos][2] = -2.6797;
				PlayerData[playerid][pPos][3] = 359.8919;
				PlayerData[playerid][pTutorial] = 1;
				PlayerData[playerid][pSHealth] = 50.0;
				PlayerData[playerid][pHealth] = 150.0;

				if(!PlayerData[playerid][pPnumber]) PlayerData[playerid][pPnumber] = 100000 + random(99999);

				SetSpawnInfo(playerid, NO_TEAM, PlayerData[playerid][pModel], PlayerData[playerid][pPos][0], PlayerData[playerid][pPos][1], PlayerData[playerid][pPos][2], PlayerData[playerid][pPos][3], 0, 0, 0, 0, 0, 0);

				TogglePlayerSpectating(playerid, false);
				TogglePlayerControllable(playerid, false);

				SendClientMessageEx(playerid, COLOR_LIGHTRED, "Welcome to Legacy Roleplay, %s.", ReturnName(playerid, 0));
			}
        }
    }
}

public OnPlayerUpdate(playerid)
{
	if(PlayerData[playerid][pID] == -1 || !Spawned{playerid}) return true;

	new playerState = GetPlayerState(playerid);

	if(playerState != PLAYER_STATE_DRIVER && playerState != PLAYER_STATE_PASSENGER)
	{
		new weaponid = GetPlayerWeapon(playerid);

		if(CurrentHoldingWeapon[playerid] != weaponid)
		{
			CurrentHoldingWeapon[playerid] = weaponid;

			cl_DressHoldWeapon(playerid, weaponid);
		}
	}

	AFKTimer[playerid] = 3;

	/*if(PfSpec[playerid][FlySpec] == 1)
	{
		// Get the player's currently held keys
		new keys, updown, leftright;
		GetPlayerKeys(playerid, keys, updown, leftright);

		if(PfSpec[playerid][mdir] && (GetTickCount() - PfSpec[playerid][lastmove] > 100))
		{
			MoveCamera(playerid);
		}

		if(PfSpec[playerid][updownold] != updown || PfSpec[playerid][leftrightold] != leftright)
		{
			if((PfSpec[playerid][updownold] != 0 || PfSpec[playerid][leftrightold] != 0) && updown == 0 && leftright == 0)
			{
				StopPlayerObject(playerid, PfSpec[playerid][fsobj]);
				PfSpec[playerid][mdir] = 0;
			}
			else
			{
				PfSpec[playerid][mdir] = GetMoveDirectionFromKeys(updown, leftright);
				MoveCamera(playerid);
			}
		}

		PfSpec[playerid][updownold] = updown;
		PfSpec[playerid][leftrightold] = leftright;
		return false;
	}*/
	
	AFKTimer[playerid] = 3;
	return true;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	if(IsPlayerNPC(playerid)) return true;

	RefreshMaskStatus(playerid, forplayerid);

	if(PlayerData[playerid][pInjured])
	{
		if(KnockedOut{playerid})
		{
			format(sgstr, sizeof(sgstr), "(( Has been hit %d times and knocked out, /helpup %d to help them up. ))", TotalPlayerDamages[playerid], playerid);
			SetPlayerChatBubble(playerid, sgstr, 0xFF6347FF, 20.0, 300 * 1000);			
		}
		else
		{
			if(DeathMode{playerid})
			{
				SetPlayerChatBubble(playerid, "(( THIS PLAYER IS DEAD. ))", 0xFF6347FF, 10.0, 300 * 1000);
			}
			else
			{
				format(sgstr, sizeof(sgstr), "(( Has been injured %d times, /damages %d for more information. ))", TotalPlayerDamages[playerid], playerid);
				SetPlayerChatBubble(playerid, sgstr, 0xFF6347FF, 30.0, 300 * 1000);
			}
		}
	}
	else
	{
		if((gettime() - LastAnnotation[playerid]) >= 7)
		{
		    SetPlayerChatBubble(playerid, " ", COLOR_WHITE, 10.0, 200);
		}
	}
	return true;
}

MoneyFormat(integer)
{
	new value[20], string[20];

	valstr(value, integer);

	new charcount;

	for(new i = strlen(value); i >= 0; i --)
	{
		format(string, sizeof(string), "%c%s", value[i], string);

		if(charcount == 3)
		{
			if(i != 0)
				format(string, sizeof(string), ",%s", string);
			charcount = 0;
		}

		charcount ++;
	}

	return string;
}

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	if(UI_Purchase{playerid})
	{
	    if(clickedid == Store_Frame[1])
	    {
	        CancelSelectTextDraw(playerid);
			ShowShopList(playerid, false);
			return true;
	    }
	    if(clickedid == Store_Frame[2])
	    {
	        new
	            price = GetPVarInt(playerid, "PriceCount")
			;

	        if(!price)
				return ShowStoreInformation(playerid, "Error", "~r~Your cart is empty.");

	        if(PlayerData[playerid][pCash] < price)
				return ShowStoreInformation(playerid, "Error", "~r~You can't afford this.");

			new count, lastitem;

			for(new i = 0; i < 10; ++i)
			{
			    if(PlayerData[playerid][ItemCache][i] != -1)
			    {
			        new cache = PlayerData[playerid][ItemCache][i];

	                OnPlayerPurchaseItem(playerid, cache);

		            PlayerTextDrawBackgroundColor(playerid, Store_Items[playerid][cache], -572662273);
			        PlayerTextDrawShow(playerid, Store_Items[playerid][cache]);
	                PlayerData[playerid][ItemCache][i] = -1;

	                count++, lastitem = cache;
				}
			}

			if(!count) return ShowStoreInformation(playerid, "Error", "~r~Your cart is empty.");

			TakePlayerMoney(playerid, price);

			new
				str[256]
			;

			format(str, sizeof(str), "~r~-$%d", price);
			GameTextForPlayer(playerid, str, 5000, 1);

			format(str, sizeof(str), "%s~n~~g~Items purchased successfully.", GetBusinessItemInfo(lastitem));
			ShowStoreInformation(playerid, "Info", str);

			PlayerTextDrawSetString(playerid, Store_Cart[playerid], "Cart: ~g~$0");

            SetPVarInt(playerid, "PriceCount", 0);
            return true;
	    }
	    if(clickedid == Store_Frame[3])
	    {
			new count;

			for(new i = 0; i < 10; ++i)
			{
			    if(PlayerData[playerid][ItemCache][i] != -1)
			    {
			        new cache = PlayerData[playerid][ItemCache][i];

		            PlayerTextDrawBackgroundColor(playerid, Store_Items[playerid][cache], -572662273);
			        PlayerTextDrawShow(playerid, Store_Items[playerid][cache]);
	                PlayerData[playerid][ItemCache][i] = -1;

	                count++;
				}
			}

			if(!count) return ShowStoreInformation(playerid, "Error", "~r~Your cart is already empty.");

			ShowStoreInformation(playerid, "Info", "~g~Your cart was successfully emptied.");
			PlayerTextDrawSetString(playerid, Store_Cart[playerid], "Cart: ~g~$0");

			SetPVarInt(playerid, "PriceCount", 0);
			return true;
	    }
	}

	if(PRestaurantOpening {playerid})
	{
		if(clickedid == TD_Restaurant[2])
		{
			for(new i = 0; i != sizeof(TD_Restaurant); ++i)
				TextDrawHideForPlayer(playerid, TD_Restaurant[i]);

	        for(new i = 0; i != 9; ++i)
				PlayerTextDrawHide(playerid, PTD_Restaurant[playerid][i]);

	        CancelSelectTextDraw(playerid);

	        PRestaurantOpening{playerid} = false;
	        return true;
		}
	}

	if(PCoverOpening{playerid})
	{
	    if(clickedid == TD_PhoneCover[1]) // Black
	    {
			PCoverColor[playerid] = 0;
	        PlayerTextDrawSetPreviewModel(playerid, TD_PhoneCoverModel[playerid], 18868);
	        PlayerTextDrawShow(playerid, TD_PhoneCoverModel[playerid]);
	    }
 	    else if(clickedid == TD_PhoneCover[2]) // Red color
	    {
			PCoverColor[playerid] = 1;
	        PlayerTextDrawSetPreviewModel(playerid, TD_PhoneCoverModel[playerid], 18870);
	        PlayerTextDrawShow(playerid, TD_PhoneCoverModel[playerid]);
	    }
 	    else if(clickedid == TD_PhoneCover[3]) // Yellow
	    {
			PCoverColor[playerid] = 2;
	        PlayerTextDrawSetPreviewModel(playerid, TD_PhoneCoverModel[playerid], 18873);
	        PlayerTextDrawShow(playerid, TD_PhoneCoverModel[playerid]);
	    }
 	    else if(clickedid == TD_PhoneCover[4]) // Blue color
	    {
			PCoverColor[playerid] = 3;
	        PlayerTextDrawSetPreviewModel(playerid, TD_PhoneCoverModel[playerid], 18872);
	        PlayerTextDrawShow(playerid, TD_PhoneCoverModel[playerid]);
	    }
 	    else if(clickedid == TD_PhoneCover[5]) // Green Watercolor
	    {
			PCoverColor[playerid] = 4;
	        PlayerTextDrawSetPreviewModel(playerid, TD_PhoneCoverModel[playerid], 18871);
	        PlayerTextDrawShow(playerid, TD_PhoneCoverModel[playerid]);
	    }
 	    else if(clickedid == TD_PhoneCover[6]) // Orange
	    {
			PCoverColor[playerid] = 5;
	        PlayerTextDrawSetPreviewModel(playerid, TD_PhoneCoverModel[playerid], 18865);
	        PlayerTextDrawShow(playerid, TD_PhoneCoverModel[playerid]);
	    }
 	    else if(clickedid == TD_PhoneCover[7]) // Pink
	    {
			PCoverColor[playerid] = 6;
	        PlayerTextDrawSetPreviewModel(playerid, TD_PhoneCoverModel[playerid], 18869);
	        PlayerTextDrawShow(playerid, TD_PhoneCoverModel[playerid]);
	    }
 	    else if(clickedid == TD_PhoneCover[8]) // Purchase
	    {
			if(PlayerData[playerid][pCash] >= 500)
			{
			    PlayerData[playerid][pPhoneModel] = PCoverColor[playerid];

				TakePlayerMoney(playerid, 500);

				SendClientMessage(playerid, COLOR_WHITE, "You bought a new phone case.");

				if(PhoneOpen{playerid}) ShowPlayerPhone(playerid);


			    for(new i = 0; i != sizeof(TD_PhoneCover); ++i)
					TextDrawHideForPlayer(playerid, TD_PhoneCover[i]);

	            PlayerTextDrawHide(playerid, TD_PhoneCoverModel[playerid]);

				PCoverOpening{playerid} = false;
				CancelSelectTextDraw(playerid);

			}
			else SendClientMessage(playerid, COLOR_GRAD1, "   You have not enough money ($500) !");
	    }
	}

  	if(clickedid == Text:INVALID_TEXT_DRAW)
	{
	    if(PhoneOpen{playerid})
	    {
	        SendClientMessage(playerid, COLOR_WHITE, "[ ! ] Use '/pc' to bring the cursor back or '/phone' to hide the phone.");
	    }

        if(UsingMDC{playerid} && !Dialog_Opened(playerid))
		{
		    if(MDC_Created{playerid} && !ActiveQuery{playerid})
		    {
				TogglePlayerMDC(playerid, false, true);
			}
		}

		if(PCoverOpening{playerid})
		{
		    for(new i = 0; i != sizeof(TD_PhoneCover); ++i)
				TextDrawHideForPlayer(playerid, TD_PhoneCover[i]);

            PlayerTextDrawHide(playerid, TD_PhoneCoverModel[playerid]);

			PCoverOpening{playerid} = false;
		}

		if(PCarOpening{playerid})
		{
			ClosePlayerCarMenu(playerid);
		}

		if(ColorSelectShow{playerid} || ColorSelectShow2{playerid})
		{
			ClearColorSelect(playerid);
		}

		if(PRestaurantOpening{playerid})
		{
			for(new i = 0; i != sizeof(TD_Restaurant); ++i)
				TextDrawHideForPlayer(playerid, TD_Restaurant[i]);

	        for(new i = 0; i != 9; ++i)
				PlayerTextDrawHide(playerid, PTD_Restaurant[playerid][i]);

	        CancelSelectTextDraw(playerid);

            PRestaurantOpening{playerid} = false;
        }

        if(UI_Purchase{playerid} && !Dialog_Opened(playerid))
        {
            ShowShopList(playerid, false);
        }
	}
	return true;
}

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
	//Character Selection
	if(PlayerData[playerid][pID] == -1)
	{
		for(new i = 0; i < 6; ++i)
		{
		    if(playertextid == CharSelectionTD[playerid][i])
			{
				if(CharacterCache[playerid][i] == -1) return KickEx(playerid);

	            CancelSelectTextDraw(playerid);

				for(new t = 0; t < 13; ++t)
				{
				    PlayerTextDrawDestroy(playerid, CharSelectionTD[playerid][t]);
				}

				SelectedCharacter[playerid] = i;

				foreach (new x : Player)
				{
				    if(playerid == x) continue;

				    if(AccountData[playerid][aUserid] == AccountData[x][aUserid])
				    {
				        SendErrorMessage(playerid, "Login unsuccessful (character already logged in?)");
				        return true;
					}
				}

				new query[180];
				mysql_format(dbCon, query, sizeof(query), "SELECT * FROM `characters` WHERE `ID` = '%d' LIMIT 1", CharacterCache[playerid][i]);
    			mysql_tquery(dbCon, query, "OnQueryFinished", "dd", playerid, THREAD_LOAD_CHARACTER);
				return true;
			}
		}
	}

	//Store Buy
	if(UI_Purchase{playerid})
	{
	    for(new x = 0; x < 10; ++x)
	    {
	        if(playertextid == Store_Items[playerid][x])
	        {
	            new str[256], bool:additem = true;

				for(new i = 0; i < 10; ++i)
				{
				    if(PlayerData[playerid][ItemCache][i] == x)
				    {
				        additem = false;

                        if(x == 9)
						{
							SetPVarInt(playerid, "PriceCount", GetPVarInt(playerid, "PriceCount") - ReturnRadioPrice(SelectedRadio[playerid]));

							SelectedRadio[playerid] = -1;
						}
				        else SetPVarInt(playerid, "PriceCount", GetPVarInt(playerid, "PriceCount") - ReturnItemPrice(PlayerData[playerid][ItemCache][i]));

				        PlayerData[playerid][ItemCache][i] = -1;

						format(str, sizeof(str), "%s~n~~n~~r~%s was removed to your cart", GetBusinessItemDescription(x), GetBusinessItemName(x));
      					PlayerTextDrawSetString(playerid, Store_Info[playerid], str);

				        PlayerTextDrawBackgroundColor(playerid, Store_Items[playerid][x], -572662273);
				        PlayerTextDrawShow(playerid, Store_Items[playerid][x]);
						break;
					}
				}

				if(additem)
				{
				    if(SelectedItem[playerid] != x)
				    {
				        if(SelectedItem[playerid] != -1)
				        {
						    PlayerTextDrawBackgroundColor(playerid, Store_Items[playerid][SelectedItem[playerid]], -572662273);
						    PlayerTextDrawShow(playerid, Store_Items[playerid][SelectedItem[playerid]]);
				        }

				        format(str, sizeof(str), "%s~n~~n~~g~Click again to get the item to your cart", GetBusinessItemDescription(x));

						if(x >= 2 && x <= 5)
						{
                            if(HasOtherWeaponsInCart(playerid))
							{
				                strcat(str, "~n~~r~Only 1 of your purchased weapons saves");
							}
						}

				        ShowStoreInformation(playerid, GetBusinessItemName(x), str);

						PlayerTextDrawBackgroundColor(playerid, Store_Items[playerid][x], 0xC6E5D2FF);
						PlayerTextDrawShow(playerid, Store_Items[playerid][x]);

						SelectedItem[playerid] = x;
				    }
				    else
				    {
			            if(x == 9) //Radio
			            {
			                CancelSelectTextDraw(playerid);

							format(str, sizeof(str), "Type\tSlots\tPrice\nStandard\t2\t%s\nAdvanced\t5\t%s\nSuper\t8\t%s",
								FormatNumber(ReturnRadioPrice(0)),
								FormatNumber(ReturnRadioPrice(1)),
								FormatNumber(ReturnRadioPrice(2))
							);

							Dialog_Show(playerid, BusinessBuy_Radio, DIALOG_STYLE_TABLIST_HEADERS, "Select a radio", str, "Select", "Cancel");
			            }
			            else
			            {
			                switch(x)
			                {
			                    case 2, 3, 4:
			                    {
			                        if(PlayerData[playerid][pLevel] < 2)
			                        {
				                    	format(str, sizeof(str), "%s~n~~n~~r~You must be level two.", GetBusinessItemDescription(x));
				                        return ShowStoreInformation(playerid, GetBusinessItemName(x), str);
									}
			                    }
			                    case 6:
			                    {
			                        if(PlayerData[playerid][pHasMask])
			                        {
			                            format(str, sizeof(str), "%s~n~~n~~r~You already have a mask.", GetBusinessItemDescription(x));
			                            return ShowStoreInformation(playerid, GetBusinessItemName(x), str);
			                        }
			                    }
			                    case 7:
			                    {
			                        if(PlayerData[playerid][pDrink] > 0)
			                        {
			                            format(str, sizeof(str), "%s~n~~n~~r~You already have a drink.", GetBusinessItemDescription(x));
			                            return ShowStoreInformation(playerid, GetBusinessItemName(x), str);
			                        }
			                    }
			                }

						    new index_id = PlayerCache_GetFree(playerid);

				            if(index_id != -1) AddItemToCart(playerid, x, index_id);
						}
					}
				}
				else
				{
					format(str, sizeof(str), "Cart: ~g~$%s", MoneyFormat(GetPVarInt(playerid, "PriceCount")));
					PlayerTextDrawSetString(playerid, Store_Cart[playerid], str);
				}
	        }
	    }
	}

	//mdc functions
	if(UsingMDC{playerid})
	{
	    new last_page = GetPVarInt(playerid, "LastPage_ID");

		for(new i = 0; i < 24; ++i)
		{
		    if(i < 6)
		    {
			    if(playertextid == MDC_MenuUI[playerid][i])
			    {
			        if(!MDC_Created{playerid} || ActiveQuery{playerid})
			            return SendErrorMessage(playerid, "Not so fast mister fast fingers, you're clicking too fast!");

					if(last_page != -1) //recolor the last page
					{
					    PlayerTextDrawColor(playerid, MDC_MenuUI[playerid][last_page], 858993663);
					    PlayerTextDrawBoxColor(playerid, MDC_MenuUI[playerid][last_page], -1431655681);
					    PlayerTextDrawShow(playerid, MDC_MenuUI[playerid][last_page]);
				    }

				    //current page [ .. ]
				    PlayerTextDrawColor(playerid, MDC_MenuUI[playerid][i], -1431655681);
	                PlayerTextDrawBoxColor(playerid, MDC_MenuUI[playerid][i], 858993663); //858993663
	                PlayerTextDrawShow(playerid, MDC_MenuUI[playerid][i]);

			        UpdatePlayerMDC(playerid, i, last_page);
			        SetPVarInt(playerid, "LastPage_ID", i);
			        return true;
			    }
			}

			if(e_Player_MDC_Cache[playerid][current_page] == 2)
			{
			    if(playertextid == MDC_ChargesUI[playerid][i])
					return MDC_ChangeProfilePage(playerid, 3, e_Player_MDC_Cache[playerid][current_page], e_Player_MDC_Cache[playerid][viewing_charge][i - 1]);
			}

		    if(i < 21)
		    {
		        if(e_Player_MDC_Cache[playerid][current_page] == 5)
		        {
			    	if(playertextid == MDC_PenalCodeUI[playerid][i])
			    	{
			    	    if(i == 20)
			    	    {
			    	        return ShowPenalCodeUI(playerid, true, true);
			    	    }
			    	    else if(i == 0 && PenalCodePage[playerid] != 0)
			    	    {
			    	        return ShowPenalCodeUI(playerid, false, true, true);
			    	    }
			    	    else
			    	    {
				    	    if(FoundCrime[playerid][i][0] != -1)
				    	    {
				    	        return MDCSelectCharge(playerid, i);
				    	    }
						}

						return true;
			    	}
				}
			}
		}

		if(last_page == 3)
		{
		    if(playertextid == MDC_RosterUI[playerid][1])
				return ShowPlayerDialog(playerid, DIALOG_MDC_CALLSIGN, DIALOG_STYLE_INPUT, "Specify your callsign", "Write your desired callsign below.", "Join", "Nooo!");
		}

		if(playertextid == MDC_UI[playerid][19])
		{
		    PlayerTextDrawColor(playerid, MDC_UI[playerid][19], -1431655681);
		    PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][19], 858993663);

		    PlayerTextDrawColor(playerid, MDC_UI[playerid][20], 858993663);
		    PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][20], -1431655681);

		    PlayerTextDrawShow(playerid, MDC_UI[playerid][19]);
		    PlayerTextDrawShow(playerid, MDC_UI[playerid][20]);

		    return SetPVarInt(playerid, "Query_Mode", 0);
		}

		if(playertextid == MDC_UI[playerid][20])
		{
		    PlayerTextDrawColor(playerid, MDC_UI[playerid][19], 858993663);
		    PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][19], -1431655681);

		    PlayerTextDrawColor(playerid, MDC_UI[playerid][20], -1431655681);
		    PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][20], 858993663);

		    PlayerTextDrawShow(playerid, MDC_UI[playerid][19]);
		    PlayerTextDrawShow(playerid, MDC_UI[playerid][20]);

		    return SetPVarInt(playerid, "Query_Mode", 1);
		}

		if(playertextid == MDC_UI[playerid][18])
		{
		    if(!GetPVarInt(playerid, "Query_Mode"))
				return ShowPlayerDialog(playerid, DIALOG_MDC_NAME, DIALOG_STYLE_INPUT, "Insert data", "Who are you looking for?", "Search", "Close");
		    else
				return ShowPlayerDialog(playerid, DIALOG_MDC_PLATE, DIALOG_STYLE_INPUT, "Insert data", "What plate are you looking for?\n\nFor plate, enter the plate number.\nFor vehicle ID, enter 'id:IDHERE', e.g. 'id:420'", "Search", "Close");
		}

		if(e_Player_MDC_Cache[playerid][current_page] == 5)
		{
			if(playertextid == MDC_PenalCodeUI[playerid][21])
				return ShowPlayerDialog(playerid, DIALOG_FILTER_CHARGES, DIALOG_STYLE_INPUT, "Filter charges", "Insert part of the charge, or leave empty to clear the filter", "Search", "Cancel");

			if(playertextid == MDC_PenalCodeUI[playerid][22])
			{
				PlayerTextDrawColor(playerid, MDC_PenalCodeUI[playerid][21], -1431655681);
				PlayerTextDrawSetString(playerid, MDC_PenalCodeUI[playerid][21], "filter charges ...");
				PlayerTextDrawShow(playerid, MDC_PenalCodeUI[playerid][21]);

			    FilterCharges[playerid][0] = EOS;
			    return ShowPenalCodeUI(playerid, false, true);
			}

			if(playertextid == MDC_PenalCodeUI[playerid][25])
			{
			    if(ClickedCrime[playerid][0] != -1)
					return MDCAddCharge(playerid, ClickedCrime[playerid][0], ClickedCrime[playerid][1]);

				return true;
			}

			if(playertextid == MDC_PenalCodeUI[playerid][32])
				return MDCClearCharges(playerid);

			if(playertextid == MDC_PenalCodeUI[playerid][33])
				return MDCProccessCharges(playerid);
		}

		if(playertextid == MDC_UI[playerid][22])
		{
			if(!MDC_Created{playerid} || ActiveQuery{playerid})
				return SendErrorMessage(playerid, "Not so fast mister fast fingers, you're clicking too fast!");

			if(GetPVarInt(playerid, "MDC_ViewingProfile"))
				return MDC_GatherInformation(playerid, e_Player_MDC_Cache[playerid][player_dbid], 1);

			if(GetPVarInt(playerid, "MDC_ViewingVehicle"))
				return MDC_GatherInformation(playerid, e_Player_MDC_Cache[playerid][vehicle_dbid], 2);
		}

        if(e_Player_MDC_Cache[playerid][current_page] == 4)
        {
			if(playertextid == MDC_LicensesUI[playerid][6]) //Revoke Driver License
			{
			    new str[64 + MAX_PLAYER_NAME];

			    format(str, sizeof(str), "Are you sure you want to revoke %s's driving license?",  e_Player_MDC_Cache[playerid][player_name]);

			    return Dialog_Show(playerid, RevokeDriverLicense, DIALOG_STYLE_MSGBOX, "Confirmation", str, "Yes, revoke", "No!");
			}
			else if(playertextid == MDC_LicensesUI[playerid][7]) //Warn Driver License
			{
			    new str[64 + MAX_PLAYER_NAME];

			    format(str, sizeof(str), "Are you sure you want to write a warning on %s's driving license?",  e_Player_MDC_Cache[playerid][player_name]);

			    return Dialog_Show(playerid, IssueLicenseWarning, DIALOG_STYLE_MSGBOX, "Confirmation", str, "Yes", "No!");
			}
			else if(playertextid == MDC_LicensesUI[playerid][8]) //Suspend Driver License
			{
			    new str[64 + MAX_PLAYER_NAME];

			    format(str, sizeof(str), "How many hours should %s's license be suspended for?",  e_Player_MDC_Cache[playerid][player_name]);

			    return Dialog_Show(playerid, IssueLicenseSuspension, DIALOG_STYLE_INPUT, "Suspension", str, "Suspend", "Cancel");
			}
			else if(playertextid == MDC_LicensesUI[playerid][15]) //Revoke Weapon License
			{
			    new str[64 + MAX_PLAYER_NAME];

			    format(str, sizeof(str), "Are you sure you want to revoke %s's weapon license?",  e_Player_MDC_Cache[playerid][player_name]);

			    return Dialog_Show(playerid, RevokeWeaponLicense, DIALOG_STYLE_MSGBOX, "Confirmation", str, "Yes, revoke", "No!");
			}
		}

		if(playertextid == MDC_UI[playerid][28])
			return MDC_ChangeProfilePage(playerid, 4, 1); //licenses

		if(playertextid == MDC_UI[playerid][29])
			return MDC_ChangeProfilePage(playerid, 5, 1); //add charges

		if(playertextid == MDC_UI[playerid][30]) //write arrest record
		{
			foreach (new i : Player)
			{
				if(!strcmp(ReturnName(i), e_Player_MDC_Cache[playerid][player_name]))
				{
				    WriteArrestRecord(playerid, i);
				    break;
				}
			}
		}

		if(playertextid == MDC_UI[playerid][31] || playertextid == MDC_UI[playerid][32])
			return MDC_ChangeProfilePage(playerid, 2, 1); //criminal record

		if(playertextid == MDC_UI[playerid][33])
			return MDC_ChangeProfilePage(playerid, 6, 1); //properties

		if(playertextid == MDC_UI[playerid][38]) //back button
		{
			if(!e_Player_MDC_Cache[playerid][unit_temp_page])
			{
			    switch(e_Player_MDC_Cache[playerid][current_page])
			    {
			        case 2, 4, 5, 6:
			        {
						MDC_ChangeProfilePage(playerid, 1, e_Player_MDC_Cache[playerid][current_page]);
					}
			        case 3:
			        {
						MDC_ChangeProfilePage(playerid, 2, e_Player_MDC_Cache[playerid][current_page]);

						DeletePVar(playerid, "ViewingCharge");
					}
			    }
			}
			else
			{
                switch(e_Player_MDC_Cache[playerid][unit_temp_page])
                {
                    case 1:
                    {
						UpdatePlayerMDC(playerid, 3, 3);
                    }
                }
			}
		}

		if(e_Player_MDC_Cache[playerid][current_page] == 4)
		{
			for(new i = 3; i < 19; ++i)
			{
			    if(playertextid == MDC_PropertiesUI[playerid][i])
					return SelectProperty(playerid, i - 3);
			}
		}

		if(last_page == 2)
		{
			if(playertextid == MDC_Emergency[playerid][25])
				return ShowEmergencyCalls(playerid, CachedPages[playerid][ PenalCodePage[playerid] - 1 ][0], PenalCodePage[playerid] - 1, true);

			if(playertextid == MDC_Emergency[playerid][26])
				return ShowEmergencyCalls(playerid, CachedPages[playerid][ PenalCodePage[playerid] ][1], PenalCodePage[playerid] + 1, true);
		}

		if(last_page == 5)
		{
			if(playertextid == MDC_VehicleBOLO[playerid][0])
				return Dialog_Show(playerid, CreateBolo, DIALOG_STYLE_INPUT, "Submit Vehicle Alert", "\t\t{8D8DFF}LOS SANTOS POLICE DEPARTMENT\n\t\t\t{FF6347}SUBMIT A VEHICLE ALERT\n\n{FFFFFF}What's the vehicle's model and color? (( SA-MP native preferred over custom. ))\nFor example: Bobcat, black in color.", "Submit", "Exit");
		}

		if(playertextid == MDC_UI[playerid][4])
		{
		    if(!MDC_Created{playerid} || ActiveQuery{playerid}) return true;

		    CancelSelectTextDraw(playerid);
		    return TogglePlayerMDC(playerid, false, true);
		}

		if(playertextid == MDC_UI[playerid][5])
		{
		    if(!MDC_Created{playerid} || ActiveQuery{playerid}) return true;

		    CancelSelectTextDraw(playerid);
		    return TogglePlayerMDC(playerid, false);
		}
	}
	//end of mdc functions

	//Car List
	if(PCarOpening{playerid})
	{
	    if(PCarType[playerid] == 0)
		{
			if(playertextid == PCARTextLeft[playerid])
			{
			    if(PCarPage[playerid] == 2)
			    {
			        PCarPage[playerid] --;

					ShowPlayerCarMenu(playerid);
			    }
			}
			else if(playertextid == PCARTextRight[playerid])
			{
			    if(PCarPage[playerid] == 1)
			    {
			        PCarPage[playerid] ++;

					ShowPlayerCarMenu(playerid);
			    }
			}
			else
			{
				for(new i = 0; i != 6; ++i)
				{
					if(playertextid == PCARTextSlot[playerid][i])
					{
						SpawnPlayerCar(playerid, i);
						break;
					}
				}
			}
		}
	    else if(PCarType[playerid] == 1)
		{
			if(playertextid == PCARTextLeft[playerid])
			{
			    if(PCarPage[playerid] > 1)
			    {
			        PCarPage[playerid] --;

					ShowPlayerDealershipMenu(playerid);
			    }
			}
			else if(playertextid == PCARTextRight[playerid])
			{
			    new caramount;

			    if(VDealerSelectCatalog[playerid] == -1)
				{
					caramount = sizeof(VehicleMenuInfo);
				}
			    else
				{
					for(new x = 0; x != sizeof(VehicleDealership); ++x)
					{
						if(VehicleDealership[x][1] == VDealerSelectCatalog[playerid])
						{
							caramount++;
						}
					}
				}

			    if(floatround(caramount/(PCarPage[playerid] * 6), floatround_ceil) && caramount % 6 != 0)
			    {
			        PCarPage[playerid]++;
					ShowPlayerDealershipMenu(playerid);
			    }
			}
			else if(playertextid == PCARTextHeader[playerid])
			{
			    if(VDealerSelectCatalog[playerid] != -1)
			    {
				    VDealerSelectCatalog[playerid] = -1;
				    PCarPage[playerid] = 1;

				    ShowPlayerDealershipMenu(playerid);
			    }
			    else ClosePlayerCarMenu(playerid);
			}
			else
			{
				for(new i = 0; i != 6; ++i)
				{
					if(playertextid == PCARTextSlot[playerid][i])
					{
					    if(VDealerSelectCatalog[playerid] == -1)
					    {
							VDealerSelectCatalog[playerid] = (PCarPage[playerid] * 6) - (6 - i);
							PCarPage[playerid] = 1;
		                    ShowPlayerDealershipMenu(playerid);
	                    }
	                    else
	                    {
							PutPlayerSettingVehicle(playerid, VDealerData[playerid][i][0], VDealerData[playerid][i][4]);
                            ClosePlayerCarMenu(playerid);
	                    }
						break;
					}
				}
			}
		}
	}

	//Phone
	if(PhoneOpen{playerid})
    {
        if(ph_menuid[playerid] == 6)
        {
	 		if(ph_sub_menuid[playerid] == 1 && playertextid == TDPhone_Model[playerid][4]) // PHONE ON
			{
	            RenderPlayerPhone(playerid, 6, 2);

				SetTimerEx("PhoneTurnOn", 4000, false, "d", playerid);
			}
        }
        else
        {
	    	if(playertextid == TDPhone_Model[playerid][7]) // First
	    	{
	    	    OnPhoneEvent(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], PH_LBUTTON);
	    	}
	    	else if(playertextid == TDPhone_Model[playerid][13]) // Second
	    	{
	    	    OnPhoneEvent(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], PH_RBUTTON);
	    	}
	    	else if(playertextid == TDPhone_Model[playerid][8]) // Up
	    	{
	    		OnPhoneEvent(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], PH_UP);
	    	}
	    	else if(playertextid == TDPhone_Model[playerid][9]) // Down
	    	{
	    	    OnPhoneEvent(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], PH_DOWN);
	    	}
			else if(playertextid == TDPhone_Model[playerid][3]) // INBOX
			{
				RenderPlayerPhone(playerid, 2, 3);
			}
			else if(playertextid == TDPhone_Model[playerid][12]) // SELFIE
			{
				if(ph_menuid[playerid]== 0 && ph_sub_menuid[playerid] == 2)
					PhoneSelfie_Stop(playerid);
				else
					OnPhoneClick_Selfie(playerid);
			}
			else if(playertextid == TDPhone_Model[playerid][4]) // PHONE OFF
			{
				if(ph_menuid[playerid] != 6)
					Dialog_Show(playerid, AskTurnOff, DIALOG_STYLE_MSGBOX, "Are you sure?", "Are you sure you want to turn your phone OFF?", "Yes", "No");
			}
			else if(playertextid == TDPhone_NotifyText[playerid])
			{
			    new missed_msg = CountMissedCall(playerid);

			    if(missed_msg)
			    {
                    RenderPlayerPhone(playerid, 3, 3);
			    }
			    else
			    {
		      		RenderPlayerPhone(playerid, 2, 3);
			    }
			}
			else
			{
		        for(new i = 0; i != 4; ++i)
				{
					if(playertextid == TDPhone_Choice[playerid][i])
			    	{
						if(ph_selected[playerid] == i)
						{
							OnPhoneEvent(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], PH_CLICKOPEN);
						    return true;
						}

						ph_selected[playerid] = i;

		    			if((ph_menuid[playerid] == 1 && ph_sub_menuid[playerid] == 1) || (ph_menuid[playerid] == 2 && (ph_sub_menuid[playerid] == 1 || ph_sub_menuid[playerid] == 3 || ph_sub_menuid[playerid] == 4)) || (ph_menuid[playerid] == 3 && (ph_sub_menuid[playerid] == 1 || ph_sub_menuid[playerid] == 3)))
							ph_select_data[playerid] = ph_data[playerid][ph_selected[playerid]] - 1;

						RenderPlayerPhone(playerid, ph_menuid[playerid], ph_sub_menuid[playerid], ph_selected[playerid]);
			    	}
		    	}
	    	}
    	}
    }

	//Restaurant
	if(playertextid == PTD_Restaurant[playerid][0])
	{
	    if(InBusiness[playerid] != -1)
	    {
			if(BusinessData[InBusiness[playerid]][bLocked] == 1)
				return GameTextForPlayer(playerid, "~r~Closed", 5000, 1);

			if(BusinessData[InBusiness[playerid]][bProducts] == 0)
				return GameTextForPlayer(playerid, "~r~Out Of Stock", 5000, 1);

            if(PlayerData[playerid][pCash] < BusinessData[InBusiness[playerid]][bItems][0])
				return GameTextForPlayer(playerid, "~r~You can't afford it", 5000, 1);

			switch(BusinessData[InBusiness[playerid]][bsubType])
			{
				case 1: // Pizza
				{
				    if(PlayerData[playerid][pHealth] < 100)
				    {
					    if(PlayerData[playerid][pHealth] + 30 <= 100)
					    {
					    	SetPlayerHealthEx(playerid,(PlayerData[playerid][pHealth] + 30));
					    }
					    else SetPlayerHealthEx(playerid, 100);
				    }

				    SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s orders a meal.", ReturnName(playerid, 0));
				    SendClientMessageEx(playerid, COLOR_WHITE, "Ordered {FF6347}Cluckin' Little Meal{FFFFFF} for {FF6347}%s{FFFFFF}..", FormatNumber(BusinessData[InBusiness[playerid]][bItems][0]));

					MealHolding[playerid] = 2218;
				}
				case 2: // Donut
				{
				    if(PlayerData[playerid][pHealth] < 100)
				    {
					    if(PlayerData[playerid][pHealth] + 30 <= 100)
					    {
					    	SetPlayerHealthEx(playerid,(PlayerData[playerid][pHealth] + 30));
					    }
					    else SetPlayerHealthEx(playerid, 100);
				    }

				    SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s orders a meal.", ReturnName(playerid, 0));
				    SendClientMessageEx(playerid, COLOR_WHITE, "Ordered {FF6347}Rusty's D-Luxe{FFFFFF} for {FF6347}%s{FFFFFF}..", FormatNumber(BusinessData[InBusiness[playerid]][bItems][0]));

                    MealHolding[playerid] = 2221;
				}
				case 3: // Burger
				{
				    if(PlayerData[playerid][pHealth] < 100)
				    {
					    if(PlayerData[playerid][pHealth] + 30 <= 100)
					    {
					    	SetPlayerHealthEx(playerid,(PlayerData[playerid][pHealth] + 30));
					    }
					    else SetPlayerHealthEx(playerid, 100);
				    }

				    SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s orders a meal.", ReturnName(playerid, 0));
				    SendClientMessageEx(playerid, COLOR_WHITE, "Ordered {FF6347}Moo Kids Meal{FFFFFF} for {FF6347}%s{FFFFFF}..", FormatNumber(BusinessData[InBusiness[playerid]][bItems][0]));

                    MealHolding[playerid] = 2213;
				}
				case 4: // Cluckin
				{
				    if(PlayerData[playerid][pHealth] < 100)
				    {
					    if(PlayerData[playerid][pHealth] + 30 <= 100)
					    {
					    	SetPlayerHealthEx(playerid,(PlayerData[playerid][pHealth] + 30));
					    }
					    else SetPlayerHealthEx(playerid, 100);
				    }

				    SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s orders a meal.", ReturnName(playerid, 0));
				    SendClientMessageEx(playerid, COLOR_WHITE, "Ordered {FF6347}Cluckin' Little Meal{FFFFFF} for {FF6347}%s{FFFFFF}..", FormatNumber(BusinessData[InBusiness[playerid]][bItems][0]));

                    MealHolding[playerid] = 2215;
				}
			}

			TakePlayerMoney(playerid, BusinessData[InBusiness[playerid]][bItems][0]);

            BusinessData[InBusiness[playerid]][bProducts]--;
			BusinessData[InBusiness[playerid]][bTill] += floatround(BusinessData[InBusiness[playerid]][bItems][0] * 0.7);

			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
			SetPlayerMealHold(playerid, MealHolding[playerid]);

			SendClientMessage(playerid, COLOR_WHITE, "You can{FF6347} /meal place{FFFFFF} it on a table or {FF6347}/meal throw{FFFFFF} it away.");

			for(new i = 0; i != sizeof(TD_Restaurant); ++i)
				TextDrawHideForPlayer(playerid, TD_Restaurant[i]);

	        for(new i = 0; i != 9; ++i)
				PlayerTextDrawHide(playerid, PTD_Restaurant[playerid][i]);

	        CancelSelectTextDraw(playerid);

			Business_Save(InBusiness[playerid]);
	    }
	}
	else if(playertextid == PTD_Restaurant[playerid][1])
	{
	    if(InBusiness[playerid] != -1)
	    {
			if(BusinessData[InBusiness[playerid]][bLocked] == 1)
				return GameTextForPlayer(playerid, "~r~Closed", 5000, 1);

			if(BusinessData[InBusiness[playerid]][bProducts] == 0)
				return GameTextForPlayer(playerid, "~r~Out Of Stock", 5000, 1);

            if(PlayerData[playerid][pCash] < BusinessData[InBusiness[playerid]][bItems][1])
				return GameTextForPlayer(playerid, "~r~You can't afford it", 5000, 1);

			switch(BusinessData[InBusiness[playerid]][bsubType])
			{
				case 1: // Pizza
				{
				    if(PlayerData[playerid][pHealth] < 100)
				    {
					    if(PlayerData[playerid][pHealth] + 60 <= 100)
					    {
					    	SetPlayerHealthEx(playerid,(PlayerData[playerid][pHealth] + 60));
					    }
					    else SetPlayerHealthEx(playerid, 100);
				    }

				    SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s orders a meal.", ReturnName(playerid, 0));
				    SendClientMessageEx(playerid, COLOR_WHITE, "Ordered {FF6347}Double D-Luxe{FFFFFF} for {FF6347}%s{FFFFFF}.", FormatNumber(BusinessData[InBusiness[playerid]][bItems][1]));

                    MealHolding[playerid] = 2219;
				}
				case 2: // Donut
				{
				    if(PlayerData[playerid][pHealth] < 100)
				    {
					    if(PlayerData[playerid][pHealth] + 60 <= 100)
					    {
					    	SetPlayerHealthEx(playerid,(PlayerData[playerid][pHealth] + 60));
					    }
					    else SetPlayerHealthEx(playerid, 100);
				    }

				    SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s orders a meal.", ReturnName(playerid, 0));
				    SendClientMessageEx(playerid, COLOR_WHITE, "Ordered {FF6347}Rusty's Double Barrel{FFFFFF} for {FF6347}%s{FFFFFF}.", FormatNumber(BusinessData[InBusiness[playerid]][bItems][1]));

                    MealHolding[playerid] = 2223;
				}
 				case 3: // Burger
				{
				    if(PlayerData[playerid][pHealth] < 100)
				    {
					    if(PlayerData[playerid][pHealth] + 60 <= 100)
					    {
					    	SetPlayerHealthEx(playerid,(PlayerData[playerid][pHealth] + 60));
					    }
					    else SetPlayerHealthEx(playerid, 100);
				    }

				    SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s orders a meal.", ReturnName(playerid, 0));
				    SendClientMessageEx(playerid, COLOR_WHITE, "Ordered {FF6347}Beef Tower{FFFFFF} for {FF6347}%s{FFFFFF}.", FormatNumber(BusinessData[InBusiness[playerid]][bItems][1]));

                    MealHolding[playerid] = 2214;
				}
 				case 4: // Cluckin
				{
				    if(PlayerData[playerid][pHealth] < 100)
				    {
					    if(PlayerData[playerid][pHealth] + 60 <= 100)
					    {
					    	SetPlayerHealthEx(playerid,(PlayerData[playerid][pHealth] + 60));
					    }
					    else SetPlayerHealthEx(playerid, 100);
				    }

				    SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s orders a meal.", ReturnName(playerid, 0));
				    SendClientMessageEx(playerid, COLOR_WHITE, "Ordered {FF6347}Cluckin' Big Meal{FFFFFF} for {FF6347}%s{FFFFFF}.", FormatNumber(BusinessData[InBusiness[playerid]][bItems][1]));

                    MealHolding[playerid] = 2216;
				}
			}

			TakePlayerMoney(playerid, BusinessData[InBusiness[playerid]][bItems][1]);

			BusinessData[InBusiness[playerid]][bProducts]--;
			BusinessData[InBusiness[playerid]][bTill] += floatround(BusinessData[InBusiness[playerid]][bItems][1]*0.7);

			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
			SetPlayerMealHold(playerid, MealHolding[playerid]);

			SendClientMessage(playerid, COLOR_WHITE, "You can{FF6347} /meal place{FFFFFF} it on a table or /meal throw{FFFFFF} it to remove");

			for(new i = 0; i != sizeof(TD_Restaurant); ++i)
				TextDrawHideForPlayer(playerid, TD_Restaurant[i]);

	        for(new i = 0; i != 9; ++i)
				PlayerTextDrawHide(playerid, PTD_Restaurant[playerid][i]);

	        CancelSelectTextDraw(playerid);

			Business_Save(InBusiness[playerid]);
	    }
	}
	else if(playertextid == PTD_Restaurant[playerid][2])
	{
	    if(InBusiness[playerid] != -1)
	    {
			if(BusinessData[InBusiness[playerid]][bLocked] == 1)
				return GameTextForPlayer(playerid, "~r~Closed", 5000, 1);

			if(BusinessData[InBusiness[playerid]][bProducts] == 0)
				return GameTextForPlayer(playerid, "~r~Out Of Stock", 5000, 1);

            if(PlayerData[playerid][pCash] < BusinessData[InBusiness[playerid]][bItems][2])
				return GameTextForPlayer(playerid, "~r~You can't afford it", 5000, 1);

			switch(BusinessData[InBusiness[playerid]][bsubType])
			{
				case 1: // Pizza
				{
				    if(PlayerData[playerid][pHealth] < 100)
				    {
					    SetPlayerHealthEx(playerid, 100);
				    }

				    SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s orders a meal.", ReturnName(playerid, 0));
				    SendClientMessageEx(playerid, COLOR_WHITE, "Ordered {FF6347}Full Rack{FFFFFF} for {FF6347}%s{FFFFFF}.", FormatNumber(BusinessData[InBusiness[playerid]][bItems][2]));

                    MealHolding[playerid] = 2220;
				}
				case 2: // Donut
				{
				    if(PlayerData[playerid][pHealth] < 100)
				    {
					    SetPlayerHealthEx(playerid, 100);
				    }

				    SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s orders a meal.", ReturnName(playerid, 0));
				    SendClientMessageEx(playerid, COLOR_WHITE, "Ordered {FF6347}Rusty's Huge Double{FFFFFF} for {FF6347}%s{FFFFFF}.", FormatNumber(BusinessData[InBusiness[playerid]][bItems][2]));

                    MealHolding[playerid] = 2222;
				}
 				case 3: // Burger
				{
				    if(PlayerData[playerid][pHealth] < 100)
				    {
					    SetPlayerHealthEx(playerid, 100);
				    }

				    SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s orders a meal.", ReturnName(playerid, 0));
				    SendClientMessageEx(playerid, COLOR_WHITE, "Ordered {FF6347}Meat Stack{FFFFFF} for {FF6347}%s{FFFFFF}.", FormatNumber(BusinessData[InBusiness[playerid]][bItems][2]));
                    MealHolding[playerid]=2212;
				}
 				case 4: // Cluckin
				{
				    if(PlayerData[playerid][pHealth] < 100)
				    {
					    SetPlayerHealthEx(playerid, 100);
				    }

				    SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s orders a meal.", ReturnName(playerid, 0));
				    SendClientMessageEx(playerid, COLOR_WHITE, "Ordered {FF6347}Cluckin' Huge Meal{FFFFFF} for {FF6347}%s{FFFFFF}.", FormatNumber(BusinessData[InBusiness[playerid]][bItems][2]));

                    MealHolding[playerid] = 2217;
				}
			}

			TakePlayerMoney(playerid, BusinessData[InBusiness[playerid]][bItems][2]);

			BusinessData[InBusiness[playerid]][bProducts]--;
			BusinessData[InBusiness[playerid]][bTill] += floatround(BusinessData[InBusiness[playerid]][bItems][2]*0.7);

			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
			SetPlayerMealHold(playerid, MealHolding[playerid]);

			SendClientMessage(playerid, COLOR_WHITE, "You can{FF6347} /meal place{FFFFFF} it on a table or {FF6347}/meal throw{FFFFFF} it away.");

			for(new i = 0; i != sizeof(TD_Restaurant); ++i)
				TextDrawHideForPlayer(playerid, TD_Restaurant[i]);

	        for(new i = 0; i != 9; ++i)
				PlayerTextDrawHide(playerid, PTD_Restaurant[playerid][i]);

	        CancelSelectTextDraw(playerid);

			Business_Save(InBusiness[playerid]);
	    }
	}
	else if(playertextid == PTD_Restaurant[playerid][3])
	{
	    if(InBusiness[playerid] != -1)
	    {
			if(BusinessData[InBusiness[playerid]][bLocked] == 1)
				return GameTextForPlayer(playerid, "~r~Closed", 5000, 1);

			if(BusinessData[InBusiness[playerid]][bProducts] == 0)
				return GameTextForPlayer(playerid, "~r~Out Of Stock", 5000, 1);

            if(PlayerData[playerid][pCash] < BusinessData[InBusiness[playerid]][bItems][3])
				return GameTextForPlayer(playerid, "~r~You can't afford it", 5000, 1);

			switch(BusinessData[InBusiness[playerid]][bsubType])
			{
				case 1: // Pizza
				{
				    if(PlayerData[playerid][pHealth] < 100)
				    {
					    SetPlayerHealthEx(playerid, 100);
				    }

				    SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s orders a meal.", ReturnName(playerid, 0));
				    SendClientMessageEx(playerid, COLOR_WHITE, "Ordered {FF6347}Salad Meal{FFFFFF} for {FF6347}%s{FFFFFF}.", FormatNumber(BusinessData[InBusiness[playerid]][bItems][3]));

					MealHolding[playerid] = 2355;
				}
				case 3: // Burger
				{
				    if(PlayerData[playerid][pHealth] < 100)
				    {
					    SetPlayerHealthEx(playerid, 100);
				    }

				    SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s orders a meal.", ReturnName(playerid, 0));
				    SendClientMessageEx(playerid, COLOR_WHITE, "Ordered {FF6347}Salad Meal{FFFFFF} for {FF6347}%s{FFFFFF}.", FormatNumber(BusinessData[InBusiness[playerid]][bItems][3]));

                    MealHolding[playerid] = 2354;
				}
				case 4: // Cluckin
				{
				    if(PlayerData[playerid][pHealth] < 100)
				    {
					    SetPlayerHealthEx(playerid, 100);
				    }

				    SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s orders a meal.", ReturnName(playerid, 0));
				    SendClientMessageEx(playerid, COLOR_WHITE, "Ordered {FF6347}Salad Meal{FFFFFF} for {FF6347}%s{FFFFFF}.", FormatNumber(BusinessData[InBusiness[playerid]][bItems][3]));

                    MealHolding[playerid] = 2353;
				}
			}

			TakePlayerMoney(playerid, BusinessData[InBusiness[playerid]][bItems][3]);

			BusinessData[InBusiness[playerid]][bProducts]--;
			BusinessData[InBusiness[playerid]][bTill] += floatround(BusinessData[InBusiness[playerid]][bItems][3]*0.7);

			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
			SetPlayerMealHold(playerid, MealHolding[playerid]);
			SendClientMessage(playerid, COLOR_WHITE, "You can{FF6347} /meal place{FFFFFF} it on a table or {FF6347}/meal throw{FFFFFF} it away.");

			for(new i = 0; i != sizeof(TD_Restaurant); ++i)
				TextDrawHideForPlayer(playerid, TD_Restaurant[i]);

	        for(new i = 0; i != 9; ++i)
				PlayerTextDrawHide(playerid, PTD_Restaurant[playerid][i]);

	        CancelSelectTextDraw(playerid);

			Business_Save(InBusiness[playerid]);
	    }
	}

	//Interface
	if(ColorSelectShow{playerid})
	{
		if(playertextid == PlayerText:INVALID_TEXT_DRAW)
		{
			ClearColorSelect(playerid);
		}
		else if(playertextid == ColorSelectText[playerid])
		{
			ColorSelect[playerid] = -1;
			ShowPlayerColorSelection(playerid, 1);
			return true;
		}
		else if(playertextid == ColorSelectLeft[playerid])
		{
			if(ColorSelectPage[playerid] < 2)
				return 0;
			else
				ShowPlayerColorSelection(playerid, ColorSelectPage[playerid] - 1);
		}

		else if(playertextid == ColorSelectRight[playerid])
		{
			if(ColorSelectPage[playerid] == ColorSelectPages[playerid])
				return 0;
			else
				ShowPlayerColorSelection(playerid, ColorSelectPage[playerid] + 1);
		}

		for(new i = 0; i < 8; ++i)
		{
			if(playertextid == ColorSelection[playerid][i])
			{
				if(ColorSelect[playerid] == -1)
				{
					ColorSelect[playerid] = ColorSelectListener[playerid][i];
					ShowPlayerColorSelection(playerid, 1);
				}
				else
				{
					VDealerColor[playerid][0] = ColorSelectListener[playerid][i];
					SetVehicleColor(VDealerVehicle[playerid], VDealerColor[playerid][0], VDealerColor[playerid][1]);
				}
				break;
			}
		}
	}

	if(ColorSelectShow2{playerid})
	{
		if(playertextid == PlayerText:INVALID_TEXT_DRAW)
		{
			ClearColorSelect(playerid);
		}
		else if(playertextid == ColorSelectText2[playerid])
		{
			ColorSelect2[playerid] = -1;
			ShowPlayerColorSelection2(playerid, 1);
			return true;
		}
		else if(playertextid == ColorSelectLeft2[playerid])
		{
			if(ColorSelectPage2[playerid] < 2)
				return 0;
			else
				ShowPlayerColorSelection2(playerid, ColorSelectPage2[playerid] - 1);
		}
		else if(playertextid == ColorSelectRight2[playerid])
		{
			if(ColorSelectPage2[playerid] == ColorSelectPages2[playerid])
				return 0;
			else
				ShowPlayerColorSelection2(playerid, ColorSelectPage2[playerid] + 1);
		}

		for(new i = 0; i < 8; ++i)
		{
			if(playertextid == ColorSelection2[playerid][i])
			{
				if(ColorSelect2[playerid] == -1)
				{
					ColorSelect2[playerid] = ColorSelectListener2[playerid][i];
					ShowPlayerColorSelection2(playerid, 1);
				}
				else
				{
					VDealerColor[playerid][1] = ColorSelectListener2[playerid][i];
					SetVehicleColor(VDealerVehicle[playerid], VDealerColor[playerid][0], VDealerColor[playerid][1]);
				}
				break;
			}
		}
	}
    return true;
}

public OnPlayerShootDynamicObject(playerid, weaponid, objectid, Float:x, Float:y, Float:z)
{
    if(!IsValidDynamicObject(objectid)) return true;

    if(weaponid == 23 && ParticleSettings[playerid][usingParticle] && ParticleSettings[playerid][particleOperation] != PARTICLE_MODE_CREATE)
    {
        new particleid = -1;

		for(new i = 0; i < MAX_PARTICLES; ++i)
		{
			if(Particles[i][particleObject] == objectid)
			{
				particleid = i;
				break;
			}
		}

		if(particleid != -1)
		{
	        if(ParticleSettings[playerid][particleEditID] != -1)
	        	return SendErrorMessage(playerid, "You're already editing another particle.");

		    foreach (new i : Player)
		    {
		        if((Particles[particleid][particleEdit] && ParticleSettings[i][particleEditID] == particleid) || RemovingParticle[i] == particleid)
		        {
					return SendErrorMessage(playerid, "This particle is currently being edited by someone else.");
		        }
		    }

	        switch(ParticleSettings[playerid][particleOperation])
	        {
	            case PARTICLE_MODE_REMOVE:
	            {
					RemovingParticle[playerid] = particleid;

					ConfirmDialog(playerid, "Confirmation", "Are you sure you want to delete this particle?", "OnPlayerRemoveParticle");
	            }
	            case PARTICLE_MODE_EDIT:
	            {
				    ParticleSettings[playerid][particleEditID] = particleid;
				    Particles[particleid][particleEdit] = true;

				    EditDynamicObject(playerid, Particles[particleid][particleObject]);

				    SendClientMessageEx(playerid, COLOR_YELLOW, "-> You're now editing particle dbid #%d.", Particles[particleid][particleSQLID]);
	            }
	        }
		}

		return false;
	}
    return true;
}

forward OnPlayerTasered(playerid);
public OnPlayerTasered(playerid)
{
	SetPlayerDrunkLevel(playerid, 1000);
	TogglePlayerControllable(playerid, true);

	ApplyAnimation(playerid, "PED", "KO_skid_front", 4.1, false, true, true, true, false, true);

	SetTimerEx("SetUnTazed", 7000, false, "i", playerid);
	return true;
}

PlaySound(playerid, soundid)
{
	new Float:x,Float:y,Float:z;
	GetPlayerPos(playerid, x, y, z);
	PlayerPlaySound(playerid, soundid, x, y, z);
}

ATM_Nearest(playerid, Float:radius = 2.5)
{
	for(new i = 0; i < MAX_ATM_LIMIT; ++i)
	{
	    if(ATMS[i][aID] == -1) continue;

	    if(IsPlayerInRangeOfPoint(playerid, radius, ATMS[i][aPos][0], ATMS[i][aPos][1], ATMS[i][aPos][2]))
	    {
			return i;
	    }
	}

	return -1;
}

ResetVehicle(vehicleid, bool:personal_car = false)
{
	if(1 <= vehicleid <= MAX_VEHICLES)
	{
	    if(!personal_car)
	    {
	    	CoreVehicles[vehicleid][vehicleCarID] = -1;
		}

		CoreVehicles[vehicleid][vLastPlayerInCar] = -1;
		CoreVehicles[vehicleid][vLastDriverInCar] = -1;

	    CoreVehicles[vehicleid][startup_delay_sender] = INVALID_PLAYER_ID;
	    CoreVehicles[vehicleid][startup_delay] = 0;
	    CoreVehicles[vehicleid][startup_delay_random] = 0;
	    CoreVehicles[vehicleid][vehCrash] = 0;

	    CoreVehicles[vehicleid][vehicleBadlyDamage] = 0;

		CoreVehicles[vehicleid][vOwnerID] = INVALID_PLAYER_ID;
		CoreVehicles[vehicleid][vUpgradeID] = 0;
		CoreVehicles[vehicleid][vHitStamp] = 0;

		CoreVehicles[vehicleid][vbreakin] = 0;
		CoreVehicles[vehicleid][vbreaktime] = 0;
		CoreVehicles[vehicleid][vbreakdelay] = 0;
		CoreVehicles[vehicleid][vbreakeffect] = 0;			

		ResetVehicleLabel(vehicleid);	

		if(Iter_Contains(sv_activevehicles, vehicleid))
		{
			Iter_Remove(sv_activevehicles, vehicleid);
		}	

        for(new i = 0; i < MAX_TRUCKER_ITEMS; ++i)
		{
			CoreVehicles[vehicleid][vehicleCrate][i] = 0;
		}

      	for(new i = 0; i < 6; ++i)
		{
      	    if(i < 4) CoreVehicles[vehicleid][vehDamage][i] = 0;

 			if(IsValidDynamicObject(CoreVehicles[vehicleid][vehicleObj][i])) DestroyDynamicObject(CoreVehicles[vehicleid][vehicleObj][i]);
		}

		if(IsValidDynamicObject(CoreVehicles[vehicleid][vSiren])) DestroyDynamicObject(CoreVehicles[vehicleid][vSiren]);
		if(IsValidDynamicObject(CoreVehicles[vehicleid][vSiren2])) DestroyDynamicObject(CoreVehicles[vehicleid][vSiren2]);

		/*if(CoreVehicles[vehicleid][vehSign])
		{
			Delete3DTextLabel(CoreVehicles[vehicleid][vehSignText]);
			CoreVehicles[vehicleid][vehSign] = 0;
 		}*/

		CoreVehicles[vehicleid][vehicleIsCargoLoad] = 0;
		CoreVehicles[vehicleid][vehicleCargoTime] = 0;
		CoreVehicles[vehicleid][vehicleCargoStorage] = 0;
		CoreVehicles[vehicleid][vehicleCargoPlayer] = INVALID_PLAYER_ID;
		CoreVehicles[vehicleid][vehicleCargoAction] = 0;

        CoreVehicles[vehicleid][vehicleEngineStamp] = 0;
		CoreVehicles[vehicleid][vehicleEngineStatus] = false;

	 	if(IsValidDynamicObject(vehicleSiren[vehicleid]))
		{
		    DestroyDynamicObject(vehicleSiren[vehicleid]);
		    vehicleSiren[vehicleid] = INVALID_OBJECT_ID;
		}

		new bool:global_vehicle = false; //, id = -1;

		foreach (new i : sv_servercar)
		{
			if(vehicleVariables[i][vVehicleScriptID] == vehicleid)
			{
			    if(vehicleVariables[i][vVehicleFaction] == -1)
			    {
                	global_vehicle = true;

                	//id = i;
				}
                break;
			}
		}

		if(!global_vehicle)
		{
			CoreVehicles[vehicleid][vehFuel] = GetVehicleDataFuel(GetVehicleModel(vehicleid));
			SetVehicleHealth(vehicleid, GetVehicleDataHealth(GetVehicleModel(vehicleid)));
		}
		else
		{
			CoreVehicles[vehicleid][vehFuel] = GetVehicleDataFuel(GetVehicleModel(vehicleid)) / 2.0;
			SetVehicleHealth(vehicleid, GetVehicleDataHealth(GetVehicleModel(vehicleid)));
		}

		for(new d; d < MAX_DRUG_SLOT; ++d)
		{
			Vehicle_Drugs[vehicleid][d][drug_id] = -1;
			Vehicle_Drugs[vehicleid][d][drug_type] = -1;
			Vehicle_Drugs[vehicleid][d][drug_storage] = -1;
			Vehicle_Drugs[vehicleid][d][drug_amount] = 0.0;
			Vehicle_Drugs[vehicleid][d][drug_strength] = 0.0;
			Vehicle_Drugs[vehicleid][d][drug_stamp] = 0;
		}

		CoreVehicles[vehicleid][vHasEngine] = IsEngineVehicle(vehicleid);
	}
	return true;
}

forward PlayerPlayMusic(playerid);
public PlayerPlayMusic(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		SetTimerEx("StopMusic", 5000, false, "d", playerid);

		PlayerPlaySound(playerid, 1068, 0.0, 0.0, 0.0);
	}
}

forward StopMusic(playerid);
public StopMusic(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		PlayerPlaySound(playerid, 1069, 0.0, 0.0, 0.0);
	}
}

// Functions

Signal_Create(playerid, const name[])
{
	new
	    Float:x,
	    Float:y,
	    Float:z,
	    Float:angle;

    if(GetPlayerPos(playerid, x, y, z) && GetPlayerFacingAngle(playerid, angle))
	{
		for(new i = 0; i != MAX_SIGNALTOWER; ++i)
		{
	    	if(!SignalData[i][signalExists])
		    {
    	        SignalData[i][signalExists] = true;

    	        SignalData[i][signalX] = x;
    	        SignalData[i][signalY] = y;
    	        SignalData[i][signalZ] = z;
    	        SignalData[i][signalRange] = 500.00;
    	        format(SignalData[i][signalName], 64, name);
                //SignalData[i][signalObject] = CreateDynamicObject(13758, SignalData[i][signalX], SignalData[i][signalY], SignalData[i][signalZ], 0.00, 0.00, 0.00);

				mysql_tquery(dbCon, "INSERT INTO `signal_tower` (`t_range`) VALUES(500)", "OnSignalCreated", "d", i);
				return i;
			}
		}
	}
	return -1;
}

Signal_Delete(signalid)
{
	if(signalid != -1 && SignalData[signalid][signalExists])
	{
	    new
	        string[64];

		format(string, sizeof(string), "DELETE FROM `signal_tower` WHERE `id` = '%d' LIMIT 1", SignalData[signalid][signalID]);
		mysql_tquery(dbCon, string);

        /*if(IsValidDynamicObject(SignalData[signalid][signalObject]))
		    DestroyDynamicObject(SignalData[signalid][signalObject]);*/

	    SignalData[signalid][signalExists] = false;
	    SignalData[signalid][signalID] = 0;
	}
	return true;
}

Signal_Save(signalid)
{
	new
	    query[256];

	format(query, sizeof(query), "UPDATE `signal_tower` SET `t_posX` = '%.4f', `t_posY` = '%.4f', `t_posZ` = '%.4f', `t_range` = '%.4f' , `t_name` = '%s' WHERE `id` = '%d' LIMIT 1",
	    SignalData[signalid][signalX],
	    SignalData[signalid][signalY],
	    SignalData[signalid][signalZ],
	    SignalData[signalid][signalRange],
	    SignalData[signalid][signalName],
	    SignalData[signalid][signalID]
	);
	return mysql_tquery(dbCon, query);
}

GetClosestSignal(playerid)
{
	new
	    Float:fDistance[2] = {99999.0, 0.0},
	    iIndex = -1
	;

	for(new i = 0; i < sizeof(SignalData); ++i)
	{
		if(SignalData[i][signalExists])
		{
		    if(PlayerData[playerid][pLocal] != 255)
			{
				if(PlayerData[playerid][pLocal] == 101) fDistance[1] = GetDistance(1554.4711,-1675.6097,16.1953, SignalData[i][signalX], SignalData[i][signalY], SignalData[i][signalZ]);
				else if(PlayerData[playerid][pLocal] == 102) fDistance[1] = GetDistance(1481.0662,-1771.3069,18.7958, SignalData[i][signalX], SignalData[i][signalY], SignalData[i][signalZ]);
				else if(PlayerData[playerid][pLocal] == 103) fDistance[1] = GetDistance(1173.1841,-1323.3143,15.3952, SignalData[i][signalX], SignalData[i][signalY], SignalData[i][signalZ]);
				else if(PlayerData[playerid][pLocal] == 103) fDistance[1] = GetDistance(533.4344,-1812.9364,6.5781, SignalData[i][signalX], SignalData[i][signalY], SignalData[i][signalZ]);
				else
				{
		 		    /*for(new x = 0; x != MAX_BUSINESS; ++x) if(PlayerData[playerid][pLocal]-LOCAL_BIZZ == x && GetPlayerInterior(playerid) == BusinessData[x][bInterior]) {
						fDistance[1] = GetDistance(BusinessData[x][bEntranceX],BusinessData[x][bEntranceY],BusinessData[x][bEntranceZ], SignalData[i][signalX], SignalData[i][signalY], SignalData[i][signalZ]);
					}*/

					new x;

					if(InBusiness[playerid] != -1)
					{
		   				x = InBusiness[playerid];

						fDistance[1] = GetDistance(BusinessData[x][bEntranceX],BusinessData[x][bEntranceY],BusinessData[x][bEntranceZ], SignalData[i][signalX], SignalData[i][signalY], SignalData[i][signalZ]);
					}
					else if(InProperty[playerid] != -1)
					{
					    x = InProperty[playerid];

						fDistance[1] = GetDistance(PropertyData[x][hEntranceX],PropertyData[x][hEntranceY],PropertyData[x][hEntranceZ], SignalData[i][signalX], SignalData[i][signalY], SignalData[i][signalZ]);
					}
					else if(InApartment[playerid] != -1)
					{
					    x = InApartment[playerid];

						fDistance[1] = GetDistance(ComplexData[x][aEntranceX],ComplexData[x][aEntranceY],ComplexData[x][aEntranceZ], SignalData[i][signalX], SignalData[i][signalY], SignalData[i][signalZ]);
					}
				}
			}
			else fDistance[1] = GetPlayerDistanceFromPoint(playerid, SignalData[i][signalX], SignalData[i][signalY], SignalData[i][signalZ]);

			if(fDistance[1] < fDistance[0] && SignalData[i][signalRange] >= fDistance[1])
			{
			    fDistance[0] = fDistance[1];
			    iIndex = i;
			}
		}
	}
	return iIndex;
}

GetInitials(const string[])
{
	new
	    ret[32],
		index = 0;

	for(new i = 0, l = strlen(string); i != l; ++i)
	{
	    if(('A' <= string[i] <= 'Z') && (i == 0 || string[i - 1] == ' '))
			ret[index++] = string[i];
	}
	return ret;
}

GetDistance(Float:x1, Float:y1, Float:z1, Float:x2, Float:y2, Float:z2)
{
	return floatround(floatsqroot(((x1 - x2) * (x1 - x2)) + ((y1 - y2) * (y1 - y2)) + ((z1 - z2) * (z1 - z2))));
}

Business_Save(bizid)
{
	new
	    query[1024];

	format(query, sizeof(query), "UPDATE `business` SET `biz_owned` = '%d',`biz_owner` = '%s', `biz_info` = '%s', `biz_items` = '%s', `biz_type` = '%d', `biz_subtype` = '%d', `biz_enX` = '%.4f', `biz_enY` = '%.4f', `biz_enZ` = '%.4f', `biz_etX` = '%.4f', `biz_etY` = '%.4f', `biz_etZ` = '%.4f', `biz_level` = '%d', `biz_price` = '%d', `biz_encost` = '%d', `biz_till` = '%d', `biz_locked` = '%d', `biz_interior` = '%d', `biz_world` = '%d', `biz_prod` = '%d', `biz_maxprod` = '%d', `biz_priceprod` = '%d'",
        BusinessData[bizid][bOwned],
        BusinessData[bizid][bOwner],
        SQL_ReturnEscaped(BusinessData[bizid][bInfo]),
        Business_FormatItems(bizid),
        BusinessData[bizid][bType],
        BusinessData[bizid][bsubType],
		BusinessData[bizid][bEntranceX],
		BusinessData[bizid][bEntranceY],
		BusinessData[bizid][bEntranceZ],
		BusinessData[bizid][bExitX],
		BusinessData[bizid][bExitY],
		BusinessData[bizid][bExitZ],
		BusinessData[bizid][bLevelNeeded],
		BusinessData[bizid][bBuyPrice],
		BusinessData[bizid][bEntranceCost],
		BusinessData[bizid][bTill],
		BusinessData[bizid][bLocked],
		BusinessData[bizid][bInterior],
		BusinessData[bizid][bWorld],
		BusinessData[bizid][bProducts],
		BusinessData[bizid][bMaxProducts],
		BusinessData[bizid][bPriceProd]
	);

	format(query, sizeof(query), "%s, `biz_carX` = '%.4f', `biz_carY` = '%.4f', `biz_carZ` = '%.4f', `biz_carA` = '%.4f', `biz_boatX` = '%.4f', `biz_boatY` = '%.4f', `biz_boatZ` = '%.4f', `biz_boatA` = '%.4f', `biz_airX` = '%.4f', `biz_airY` = '%.4f', `biz_airZ` = '%.4f', `biz_airA` = '%.4f'",
        query,
		BusinessData[bizid][bBuyingCarX],
		BusinessData[bizid][bBuyingCarY],
		BusinessData[bizid][bBuyingCarZ],
		BusinessData[bizid][bBuyingCarA],
		BusinessData[bizid][bBuyingBoatX],
		BusinessData[bizid][bBuyingBoatY],
		BusinessData[bizid][bBuyingBoatZ],
		BusinessData[bizid][bBuyingBoatA],
		BusinessData[bizid][bBuyingAirX],
		BusinessData[bizid][bBuyingAirY],
		BusinessData[bizid][bBuyingAirZ],
		BusinessData[bizid][bBuyingAirA]
	);

	format(query, sizeof(query), "%s WHERE `biz_id` = '%d'",
		query,
		BusinessData[bizid][bID]
	);

	return mysql_tquery(dbCon, query);
}

forward OnSignalCreated(signalid);
public OnSignalCreated(signalid)
{
	if(signalid == -1 || !SignalData[signalid][signalExists])
	    return 0;

	SignalData[signalid][signalID] = cache_insert_id();

	Signal_Save(signalid);
	return true;
}

public OnPlayerPickUpDynamicPickup(playerid, pickupid)
{
	/*if(pickupid == NewsPickup)
	{
		GameTextForPlayer(playerid, "~w~/newspaper to read newspaper about possible jobs in the city~n~", 8000, 4);
		return true;
	}*/

	if(pickupid == FarmerPickup)
	{
		GameTextForPlayer(playerid, "~w~Type /farmerjob to be ~n~a farmer", 5000, 3);
		return true;
	}
	
	if(pickupid == MechanicPickup)
	{
		GameTextForPlayer(playerid, "~w~You can become a~n~Mechanic here~n~/mechanicjob", 5000, 3);
		return true;
	}

	new str[256];

    foreach (new i : Business)
	{
		if(BusinessData[i][bPickup] == pickupid)
		{
			if(PlayerData[playerid][pJob] == JOB_TRUCKER && GetProductCargo(BusinessData[i][bType]) != -1)
			{
				if(BusinessData[i][bPriceProd] && GetBusinessCargoCanBuy(i))
				{
			  		SendClientMessage(playerid, COLOR_WHITE, "This business is{A4D247} looking for cargo{FFFFFF} to buy now.");
					SendClientMessageEx(playerid, COLOR_GRAD1, "(Wanted: {FFFFFF}%d {B4B5B7}crates of {FFFFFF} %s {B4B5B7}, paying {FFFFFF}%s {B4B5B7}per each one.)", GetBusinessCargoCanBuy(i), GetBusinessCargoDesc(GetProductCargo(BusinessData[i][bType])), FormatNumber(BusinessData[i][bPriceProd]));
				}
				else
				{
					SendClientMessage(playerid, COLOR_WHITE, "This business is {DB5A2B}not buying any cargo{FFFFFF} now.");
					SendClientMessage(playerid, COLOR_GRAD1, "(It's either full or the business owner doesn't want to buy any cargo.)");
				}
			}

			if(BusinessData[i][bOwned] == 1)
			{
				format(str, sizeof(str), "%s~w~~n~Entrance Fee : ~g~$%d ~n~~p~To use /enter", BusinessData[i][bInfo], BusinessData[i][bEntranceCost]);
			}
			else format(str, sizeof(str), "%s~w~~n~This Business is for sale~n~Cost: ~g~$%d ~w~Level : %d ~n~~p~ To buy /buybiz", BusinessData[i][bInfo], BusinessData[i][bBuyPrice], BusinessData[i][bLevelNeeded]);

			GameTextForPlayer(playerid, str, 5000, 3);
			break;
		}
	}

	for(new i = 0; i != 2; ++i)
	{
		if(DollaPickup[i] == pickupid)
		{
			if(PlayerData[playerid][pPayCheck] > 0)
			{
	        	format(str, sizeof(str), "~w~You have just received~n~Your Paycheck: ~g~$%d", PlayerData[playerid][pPayCheck]);
	          	GameTextForPlayer(playerid, str, 5000, 4);

				SendPlayerMoney(playerid, PlayerData[playerid][pPayCheck]);

				PlayerData[playerid][pPayCheck] = 0;

	          	PlayerPlaySound(playerid, 1150, 0.0, 0.0, 0.0);
			}
		}
	}

    if(pickupid == L_a_Pickup[0] || pickupid == L_a_Pickup[1] || pickupid == L_a_Pickup[2] || pickupid == L_a_Pickup[3] || pickupid == L_a_Pickup[4] || pickupid == L_a_Pickup[5] || pickupid == L_a_Pickup[6] || pickupid == L_a_Pickup[7] || pickupid == L_a_Pickup[8] || pickupid == L_a_Pickup[9])
	{
		if(IsPolice(playerid) && PlayerData[playerid][pOnDuty])
		{
			SendClientMessage(playerid, COLOR_WHITE, "Toll guard says: Hello officer, would you like to pass?");
			SendClientMessage(playerid, COLOR_DARKGOLDENROD, "Use \"/opentoll\" to open the toll.");
			return true;
		}

		SendClientMessageEx(playerid, COLOR_WHITE, "Toll guard says: Hello, the toll is %d dollars please.", TollCost);
		SendClientMessage(playerid, COLOR_DARKGOLDENROD, "Use \"/opentoll\" to pay the guard.");
	}
	return true;
}

// Dialog

Dialog:ShowOnly(playerid, response, listitem, inputtext[])
{
	playerid = INVALID_PLAYER_ID;
	response = 0;
	listitem = 0;
	inputtext[0] = '\0';
}

Dialog:WithdrawSavings(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		SendClientMessage(playerid, COLOR_WHITE, "You closed your savings account.");

		SendPlayerMoney(playerid, PlayerData[playerid][pSavingsCollect]);

		PlayerData[playerid][pSavings] = 0;
		PlayerData[playerid][pSavingsCollect] = 0;
	}
	return true;
}

Dialog:ReportConfirm(playerid, response, listitem, inputtext[])
{
	if(!response)
	{
	    PlayerData[playerid][pReportPlayer] = INVALID_PLAYER_ID;
	    PlayerData[playerid][pReportMessage][0] = EOS;
	    return true;
	}

	SendServerMessage(playerid, "Your report was sent to all administrators online.");

	PlayerData[playerid][pReport] = 1;
	PlayerData[playerid][pReportStamp] = gettime();

	new target = PlayerData[playerid][pReportPlayer];

	if(target != INVALID_PLAYER_ID && IsPlayerConnected(target))
	{
		if(strlen(PlayerData[playerid][pReportMessage]) > 50)
		{
			SendAdminAlert(COLOR_LIGHTRED, JUNIOR_ADMINS, "[Report: %d] {FF9900}%s (%d) reported %s (%d):  %.50s", playerid, ReturnName(playerid), playerid, ReturnName(target), target, PlayerData[playerid][pReportMessage]);
			SendAdminAlert(COLOR_LIGHTRED, JUNIOR_ADMINS, "{FF9900}%s", PlayerData[playerid][pReportMessage][50]);
		}
		else SendAdminAlert(COLOR_LIGHTRED, JUNIOR_ADMINS, "[Report: %d] {FF9900}%s (%d) reported %s (%d):  %s", playerid, ReturnName(playerid), playerid, ReturnName(target), target, PlayerData[playerid][pReportMessage]);
	}
	else
	{
		if(strlen(PlayerData[playerid][pReportMessage]) > 65)
		{
			SendAdminAlert(COLOR_LIGHTRED, JUNIOR_ADMINS, "[Report: %d] {FF9900}%s (%d) reported: %.65s", playerid, ReturnName(playerid), playerid, PlayerData[playerid][pReportMessage]);
			SendAdminAlert(COLOR_LIGHTRED, JUNIOR_ADMINS, "{FF9900}%s", PlayerData[playerid][pReportMessage][65]);
		}
		else SendAdminAlert(COLOR_LIGHTRED, JUNIOR_ADMINS, "[Report: %d] {FF9900}%s (%d) reported: %s", playerid, ReturnName(playerid), playerid, PlayerData[playerid][pReportMessage]);
	}

	return true;
}

Dialog:CreateCharacter(playerid, response, listitem, inputtext[])
{
	if(!response)
	    return Kick(playerid);

	if(isnull(inputtext) || !IsValidRoleplayName(inputtext))
	{
	    SendErrorMessage(playerid, "You need to use a roleplay name.");
	    return Dialog_Show(playerid, CreateCharacter, DIALOG_STYLE_INPUT, "Character Creation", "Since you have no characters created, you're eligible to create one in-game.\n\nYou can create one right now by typing the name you wish to use down below\n\n{FF0000}**Be sure to type a realistic name or you'll get banned without any questions**", "Create", "Exit");
	}

	SQL_CreateCharacter(playerid, inputtext);
	return true;
}

Dialog:LoginScreen(playerid, response, listitem, inputtext[])
{
	if(!response)
	    return Kick(playerid);

	if(isnull(inputtext))
	    return Dialog_Show(playerid, LoginScreen, DIALOG_STYLE_PASSWORD, "Welcome to Legacy Roleplay", "Hello,\n\nPlease enter your password below to access character selection.\n\nIf you are not currently registered with Legacy-RP, you can create\n\nyour account at legacy-rp.net.", "Submit", "Exit");

	SQL_AttemptLogin(playerid, inputtext);
	return true;
}

Dialog:AddSecretWord(playerid, response, listitem, inputtext[])
{
	if(!response)
	    return Kick(playerid);

	if(isnull(inputtext) || strlen(inputtext) > 24)
	{
		Dialog_Show(playerid, AddSecretWord, DIALOG_STYLE_PASSWORD,
			"Welcome to Legacy Roleplay",
			"{FFFFFF}SECURITY PRECAUTION:\n\nWe have introduced a SECRET CONFIRMATION CODE, this is basically a secret word that you will be presented with if any connection conditions changes.\n\n\
			You have not yet filled this out, so please take your time and fill in a secret word you {FF0000}will have to remember.\n\n{FFFFFF}IT IS ADVICED THAT THIS IS NOT YOUR PASSWORD!",
			"Enter", "Cancel"
		);
		return true;
	}

	format(AccountData[playerid][aSecretWord], 24, trim(inputtext));

	mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `accounts` SET `SecretWord` = '%e' WHERE `ID` = '%d' LIMIT 1", AccountData[playerid][aSecretWord], AccountData[playerid][aUserid]);
	mysql_pquery(dbCon, gquery);

	SQL_LoadCharacters(playerid);
	return true;
}

Dialog:SecretWord(playerid, response, listitem, inputtext[])
{
	if(!response)
	    return Kick(playerid);

	if(isnull(inputtext))
	    return Dialog_Show(playerid, SecretWord, DIALOG_STYLE_PASSWORD, "Welcome to Legacy Roleplay", "{FF0000}POSSIBLE SECURITY BREACH\n\n{FFFFFF}The server has flagged you as possibly not being this account's owner, please write the secret word of this account in the box below to confirm it is yours.", "Enter", "Cancel");

	SQL_SecretLogin(playerid, inputtext);
	return true;
}

AssignDynamicAreaValue(areaid, type, item)
{
	new tmpData[2];
	tmpData[0] = type;
	tmpData[1] = item;

	Streamer_SetArrayData(STREAMER_TYPE_AREA, areaid, E_STREAMER_EXTRA_ID, tmpData, sizeof(tmpData));				
}

public OnPlayerEnterDynamicArea(playerid, areaid)
{
	new tmpData[2];
	Streamer_GetArrayData(STREAMER_TYPE_AREA, areaid, E_STREAMER_EXTRA_ID, tmpData, sizeof(tmpData));

	switch(tmpData[0])
	{
		case AREA_TYPE_STINGER:
		{
			if(IsPlayerInAnyVehicle(playerid))
			{
				new vehicleid = GetPlayerVehicleID(playerid);

				if(IsStingerVehicle(vehicleid))
				{
					new panels, doors, lights, tires;
					GetVehicleDamageStatus(vehicleid, panels, doors, lights, tires);

					if((!IsABike(vehicleid) && tires != 15) || (IsABike(vehicleid) && tires != 3))
					{
						if(IsABike(vehicleid)) tires = encode_tires_bike(1, 1);
						else tires = encode_tires(1, 1, 1, 1);

						UpdateVehicleDamageStatus(vehicleid, panels, doors, lights, tires);
					}
				}
			}
			return true;
		}
		case AREA_TYPE_PROPERTY:
		{
			if(Iter_Contains(Property, tmpData[1]) && PropertyData[ tmpData[1] ][hDynamicArea] == areaid)
			{
				nearProperty_var[playerid] = tmpData[1];

				if(PropertyData[ tmpData[1] ][hOwned] == 1)
				{
					if(PropertyData[ tmpData[1] ][hOwnerSQLID] == PlayerData[playerid][pID])
					{
						SendClientMessage(playerid, COLOR_GREEN, "Welcome to your house's porch!");
						SendClientMessage(playerid, COLOR_WHITE, "Available commands: /enter, /ds(hout), /ddo, /myhouse");
						return true;
					}
					else
					{
						if(PropertyData[ tmpData[1] ][hRentable] == 1)
						{
							SendClientMessage(playerid, COLOR_WHITE, "Want to rent here? /rentroom");
							SendClientMessageEx(playerid, COLOR_WHITE, "Price: $%d", PropertyData[ tmpData[1] ][hRentprice]);
						}

						SendClientMessageEx(playerid, COLOR_GREEN, "%d %s, San Andreas", PropertyData[ tmpData[1] ][hID], ReturnDynamicAddress(PropertyData[ tmpData[1] ][hEntranceX], PropertyData[ tmpData[1] ][hEntranceY]));
						SendClientMessage(playerid, COLOR_WHITE, "Available commands: /enter, /ds(hout), ddo, /knock");
						return true;
					}
				}
				else
				{
					SendClientMessage(playerid, COLOR_GREEN, "Would you like to buy this?");
					SendClientMessageEx(playerid, COLOR_GREEN, "Price: $%d", PropertyData[ tmpData[1] ][hPrice]);
					SendClientMessage(playerid, COLOR_WHITE, "Available commands: /enter, /ds(hout), /ddo, /knock");
					SendClientMessage(playerid, COLOR_WHITE, "/buyhouse");
					return true;
				}
			}
		}
		case AREA_TYPE_COMPLEX:
		{
			if(Iter_Contains(Complex, tmpData[1]) && ComplexData[ tmpData[1] ][aDynamicArea] == areaid)
			{	
				nearApartment_var[playerid] = tmpData[1];

				if(ComplexData[ tmpData[1] ][aOwned] == 1)
				{
					if(ComplexData[ tmpData[1] ][aRentable] == 1)
					{
						SendClientMessage(playerid, COLOR_WHITE, "Want to rent here? /rentroom");
						SendClientMessageEx(playerid, COLOR_WHITE, "Price: $%d", ComplexData[ tmpData[1] ][aRentprice]);
					}

					SendClientMessageEx(playerid, COLOR_GREEN, "Apartment Complex: %d %s, San Andreas", ComplexData[ tmpData[1] ][aID], ReturnDynamicAddress(ComplexData[ tmpData[1] ][aEntranceX], ComplexData[ tmpData[1] ][aEntranceY]));
					SendClientMessage(playerid, COLOR_WHITE, "Available commands: /enter, /ds(hout), /ddo, /knock");
					return true;
				}
				else
				{
					SendClientMessage(playerid, COLOR_GREEN, "Would you like to buy this?");
					SendClientMessageEx(playerid, COLOR_GREEN, "Price: $%d", ComplexData[ tmpData[1] ][aPrice]);
					SendClientMessage(playerid, COLOR_WHITE, "Available commands: /enter, /ds(hout), /ddo, /knock");
					SendClientMessage(playerid, COLOR_WHITE, "/buyhouse");
					return true;
				}
			}
		}
	}	
	return true;
}

FormatCarLicenseWeapons(carid)
{
	new wstr[256], tmp[32];

	for(new a = 0; a != MAX_CAR_WEAPONS; ++a)
	{
		if(!a) format(tmp, sizeof(tmp), "%d", CarData[carid][carWeaponLicense][a]);
		else format(tmp, sizeof(tmp), "|%d", CarData[carid][carWeaponLicense][a]);

		strins(wstr, tmp, strlen(wstr));
	}
	return wstr;
}

AssignCarLicenseWeapons(carid, const str[])
{
	new wtmp[MAX_CAR_WEAPONS][32];

	explode(wtmp, str, "|");

	for(new z = 0; z != MAX_CAR_WEAPONS; ++z)
	{
		CarData[carid][carWeaponLicense][z] = strval(wtmp[z]);
	}
}

FormatPlaceItems(carid)
{
	new wstr[256];
	new tmp[255];

	for(new a = 0; a != MAX_CAR_WEAPONS; ++a)
	{
		if(!a) format(tmp,sizeof(tmp),"%f,%f,%f,%f,%f,%f,%d",CarPlace[carid][a][cPx],CarPlace[carid][a][cPy],CarPlace[carid][a][cPz],CarPlace[carid][a][cPrx],CarPlace[carid][a][cPry],CarPlace[carid][a][cPrz],CarPlace[carid][a][cPType]);
		else format(tmp,sizeof(tmp),"|%f,%f,%f,%f,%f,%f,%d",CarPlace[carid][a][cPx],CarPlace[carid][a][cPy],CarPlace[carid][a][cPz],CarPlace[carid][a][cPrx],CarPlace[carid][a][cPry],CarPlace[carid][a][cPrz],CarPlace[carid][a][cPType]);
		strins(wstr,tmp,strlen(wstr));
	}

	return wstr;
}

AssignPlaceItems(carid, const str[])
{
	new wtmp[MAX_CAR_WEAPONS][255];
	explode(wtmp,str,"|");
	for(new z = 0; z != MAX_CAR_WEAPONS; ++z)
	{
		new wtmp2[7][64];
		explode(wtmp2,wtmp[z],",");
		CarPlace[carid][z][cPx] = floatstr(wtmp2[0]);
		CarPlace[carid][z][cPy] = floatstr(wtmp2[1]);
		CarPlace[carid][z][cPz] = floatstr(wtmp2[2]);
		CarPlace[carid][z][cPrx] = floatstr(wtmp2[3]);
		CarPlace[carid][z][cPry] = floatstr(wtmp2[4]);
		CarPlace[carid][z][cPrz] = floatstr(wtmp2[5]);
		CarPlace[carid][z][cPType] = strval(wtmp2[6]);
	}
}

AddHouseToFile(houseid, price, const houseinfo[], Float:x, Float:y, Float:z, Float:exitx, Float:exity, Float:exitz, complex, world)
{
	gstr[0] = EOS;

	mysql_format(dbCon, gstr, sizeof(gstr), "INSERT INTO `houses` (posx, posy, posz, exitx, exity, exitz, checkx, checky, checkz, world, info, price, owned, owner, cash, rentprice, rentable, locked, radio, complex, scriptid) VALUES(%f, %f, %f, %f, %f, %f, %f, %f, %f, %d, '%e', %d, %d, '%e', %d, %d, %d, %d, %d, %d, %d)",
	x, y, z, exitx, exity, exitz, exitx, exity, exitz, world, houseinfo, price, 0, "The State", 0, 0, 0, 1, 0, complex, houseid);
	mysql_tquery(dbCon, gstr, "OnHouseInsert", "d", houseid);
	return true;
}

AddApartmentToFile(houseid, const houseinfo[], faction, pickup, Float:x, Float:y, Float:z, world)
{
	gstr[0] = EOS;

	mysql_format(dbCon, gstr, sizeof(gstr), "INSERT INTO `apartments` (ePosX, ePosY, ePosZ, world, name, faction, pickup) VALUES(%f, %f, %f, %d, '%e', %d, %d)", x, y, z, world, houseinfo, faction, pickup);
	mysql_tquery(dbCon, gstr, "OnApartmentInsert", "d", houseid);
	return true;
}

AddBizToFile(bizid, price, type, const owner[], const info[], Float:x, Float:y, Float:z)
{
	gstr[0] = EOS;

	mysql_format(dbCon, gstr, sizeof(gstr), "INSERT INTO `business` (biz_enX, biz_enY, biz_enZ, biz_info, biz_owner, biz_owned, biz_locked, biz_price, biz_till, biz_world, biz_type) VALUES(%f, %f, %f, '%e', '%e', %d, %d, %d, %d, %d, %d)",x, y, z, info, owner, 0, 1, price, 0, bizid, type);
	mysql_tquery(dbCon, gstr, "OnBizInsert", "d", bizid);
	return true;
}

AddTeleToFile(teleid, const mapname[], interior, Float:LX, Float:LY, Float:LZ)
{
	mysql_format(dbCon, gquery, sizeof(gquery), "INSERT INTO `ateles` (mapname, posx, posy, posz, interior) VALUES('%e', %f, %f, %f, %d)", mapname, LX, LY, LZ, interior);
	mysql_tquery(dbCon, gquery, "OnTeleportInsert", "d", teleid);
	return true;
}

AddGateToFile(id, modelid, faction, interior, virworld, Float:x, Float:y, Float:z, const name[])
{
    new clean_name[64];
    mysql_escape_string(name,clean_name);
	format(gquery, sizeof(gquery), "INSERT INTO `gates` (model, faction, posx, posy, posz, posrx, posry, posrz, interior, virworld, name) VALUES(%d, %d, %f, %f, %f, 0.0, 0.0, 0.0, %d, %d, '%s')",modelid,faction,x,y,z,interior,virworld,clean_name);
	mysql_tquery(dbCon, gquery, "OnGateInsert", "d", id);
	return true;
}

AddMoveDoorToFile(id, modelid, faction, interior, virworld, Float:x, Float:y, Float:z, const name[])
{
    new clean_name[64];
    mysql_escape_string(name,clean_name);
	format(gquery, sizeof(gquery), "INSERT INTO `movedoors` (model, faction, posx, posy, posz, posrx, posry, posrz, interior, virworld, name) VALUES(%d, %d, %f, %f, %f, 0.0, 0.0, 0.0, %d, %d, '%s')",modelid,faction,x,y,z,interior,virworld,clean_name);
	mysql_tquery(dbCon, gquery, "OnMoveDoorInsert", "d", id);
	return true;
}

//

SaveEditedGate(id, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	format(gquery, sizeof(gquery), "UPDATE `gates` SET `posx` = %f, `posy` = %f, `posz` = %f, `posrx` = %f, `posry` = %f, `posrz` = %f WHERE `id` = %d",x,y,z,rx,ry,rz,Gates[id][gateID]);
	mysql_tquery(dbCon, gquery, "OnEditedGate", "d", id);
	return true;
}

SaveEditedGateMove(id, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	format(gquery, sizeof(gquery), "UPDATE `gates` SET `movex` = %f, `movey` = %f, `movez` = %f, `moverx` = %f, `movery` = %f, `moverz` = %f WHERE `id` = %d",x,y,z,rx,ry,rz,Gates[id][gateID]);
	mysql_tquery(dbCon, gquery, "OnEditedGate", "d", id);
	return true;
}

SaveEditedMoveDoor(id, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	format(gquery, sizeof(gquery), "UPDATE `movedoors` SET `posx` = %f, `posy` = %f, `posz` = %f, `posrx` = %f, `posry` = %f, `posrz` = %f WHERE `id` = %d",x,y,z,rx,ry,rz,Doors[id][doorID]);
	mysql_tquery(dbCon, gquery, "OnEditedMoveDoor", "d", id);
	return true;
}

SaveEditedMoveDoorMove(id, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	format(gquery, sizeof(gquery), "UPDATE `movedoors` SET `movex` = %f, `movey` = %f, `movez` = %f, `moverx` = %f, `movery` = %f, `moverz` = %f WHERE `id` = %d",x,y,z,rx,ry,rz,Doors[id][doorID]);
	mysql_tquery(dbCon, gquery, "OnEditedMoveDoor", "d", id);
	return true;
}

forward OnGateRemove(objectid);
public OnGateRemove(objectid)
{
	DestroyDynamicObject(Gates[objectid][gateObject]);
	Gates[objectid][gatePosX] = 0.0;
	Gates[objectid][gatePosY] = 0.0;
	Gates[objectid][gatePosZ] = 0.0;
	Gates[objectid][gatePosRX] = 0.0;
	Gates[objectid][gatePosRY] = 0.0;
	Gates[objectid][gatePosRZ] = 0.0;
	Gates[objectid][gateInterior] = 0;
	Gates[objectid][gateFaction] = -1;
	Gates[objectid][gateOpened] = 0;
	Gates[objectid][gateLocked] = 0;
	Gates[objectid][gateVirtualWorld] = 0;
	return true;
}

forward OnMoveDoorRemove(objectid);
public OnMoveDoorRemove(objectid)
{
	DestroyDynamicObject(Doors[objectid][doorObject]);
	Doors[objectid][doorPosX] = 0.0;
	Doors[objectid][doorPosY] = 0.0;
	Doors[objectid][doorPosZ] = 0.0;
	Doors[objectid][doorPosRX] = 0.0;
	Doors[objectid][doorPosRY] = 0.0;
	Doors[objectid][doorPosRZ] = 0.0;
	Doors[objectid][doorInterior] = 0;
	Doors[objectid][doorFaction] = -1;
	Doors[objectid][doorOpened] = 0;
	Doors[objectid][doorLocked] = 0;
	Doors[objectid][doorVirtualWorld] = 0;
	return true;
}

forward OnGateInsert(id);
public OnGateInsert(id)
{
	Gates[id][gateID] = cache_insert_id();
	return true;
}

forward OnMoveDoorInsert(id);
public OnMoveDoorInsert(id)
{
	Doors[id][doorID] = cache_insert_id();
	return true;
}

forward OnEditedGate(objectid);
public OnEditedGate(objectid)
{
	new Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz;
	GetDynamicObjectPos(Gates[objectid][gateObject], x, y, z);
	GetDynamicObjectRot(Gates[objectid][gateObject], rx, ry, rz);

	Gates[objectid][gatePosX] = x;
	Gates[objectid][gatePosY] = y;
	Gates[objectid][gatePosZ] = z;
	Gates[objectid][gatePosRX] = rx;
	Gates[objectid][gatePosRY] = ry;
	Gates[objectid][gatePosRZ] = rz;
	return true;
}

forward OnEditedMoveDoor(objectid);
public OnEditedMoveDoor(objectid)
{
	new Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz;
	GetDynamicObjectPos(Doors[objectid][doorObject], x, y, z);
	GetDynamicObjectRot(Doors[objectid][doorObject], rx, ry, rz);

	Doors[objectid][doorPosX] = x;
	Doors[objectid][doorPosY] = y;
	Doors[objectid][doorPosZ] = z;
	Doors[objectid][doorPosRX] = rx;
	Doors[objectid][doorPosRY] = ry;
	Doors[objectid][doorPosRZ] = rz;
	return true;
}

/*GetClosestComplexID(playerid)
{
	if(InApartment[playerid] != -1) return InApartment[playerid];

	foreach (new i : Property)
	{
		if(IsPlayerInRangeOfPoint(playerid, 3.0, ComplexData[i][aEntranceX], ComplexData[i][aEntranceY], ComplexData[i][aEntranceZ]))
		{
			return i;
		}
	}
	return -1;
}*/

forward OnWeaponSettingsInsert(playerid, slot);
public OnWeaponSettingsInsert(playerid, slot)
{
	WeaponSettings[playerid][slot][awID] = cache_insert_id();
	return true;
}

forward OnHouseInsert(HouseID);
public OnHouseInsert(HouseID)
{
	PropertyData[HouseID][hID] = cache_insert_id();
	return true;
}

forward OnApartmentInsert(AppartmentID);
public OnApartmentInsert(AppartmentID)
{
	ComplexData[AppartmentID][aID] = cache_insert_id();
	return true;
}

forward OnPointInsert(Point);
public OnPointInsert(Point)
{
	EntranceData[Point][pointID] = cache_insert_id();
	return true;
}

forward OnBizInsert(BizzID);
public OnBizInsert(BizzID)
{
	BusinessData[BizzID][bID] = cache_insert_id();
	Iter_Add(Business, BizzID);
	return true;
}

forward OnBizRemove(bizid);
public OnBizRemove(bizid)
{
	BusinessData[bizid][bEntranceX] = 0.0000;
	BusinessData[bizid][bEntranceY] = 0.0000;
	BusinessData[bizid][bEntranceZ] = 0.0000;
	BusinessData[bizid][bExitX] = 0.0000;
	BusinessData[bizid][bExitY] = 0.0000;
	BusinessData[bizid][bExitZ] = 0.0000;
	BusinessData[bizid][bLevelNeeded] = 0;
	BusinessData[bizid][bBuyPrice] = 0;
	BusinessData[bizid][bInterior] = 0;
	BusinessData[bizid][bWorld] = 0;
	BusinessData[bizid][bTill] = 0;
	BusinessData[bizid][bOwned] = 0;
	BusinessData[bizid][bType] = 0;
	BusinessData[bizid][bsubType] = 0;
	BusinessData[bizid][bEntranceCost] = 0;
	BusinessData[bizid][bLocked] = 1;
	BusinessData[bizid][bProducts] = 0;

	BusinessData[bizid][bBuyingCarX] = 0.0;
	BusinessData[bizid][bBuyingCarY] = 0.0;
	BusinessData[bizid][bBuyingCarZ] = 0.0;
	BusinessData[bizid][bBuyingCarA] = 0.0;
	BusinessData[bizid][bBuyingBoatX] = 0.0;
	BusinessData[bizid][bBuyingBoatY] = 0.0;
	BusinessData[bizid][bBuyingBoatZ] = 0.0;
	BusinessData[bizid][bBuyingBoatA] = 0.0;
	BusinessData[bizid][bBuyingAirX] = 0.0;
	BusinessData[bizid][bBuyingAirY] = 0.0;
	BusinessData[bizid][bBuyingAirZ] = 0.0;
	BusinessData[bizid][bBuyingAirA] = 0.0;

	format(BusinessData[bizid][bOwner], 24, "The State");
	format(BusinessData[bizid][bInfo], 256, "Business");
	return true;
}

forward OnAdminSellBusiness(bizid);
public OnAdminSellBusiness(bizid)
{
	BusinessData[bizid][bTill] = 0;
	BusinessData[bizid][bOwned] = 0;
	BusinessData[bizid][bEntranceCost] = 0;
	BusinessData[bizid][bLocked] = 1;

	format(BusinessData[bizid][bOwner], 24, "The State");
	return true;
}

StopBoomBox(playerid)
{
	if(BoomboxData[playerid][boomboxOn])
	{
        BoomboxData[playerid][boomboxOn]=false;

		foreach (new i : Player)
		{
			if(Boombox_Nearest(i) == playerid)
			{
				StopAudioStreamForPlayer(i);
				SendClientMessage(i, COLOR_LIGHTRED, "The radio is turned off.");
			}

		}
	}
}

public OnPlayerEditDynamicObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	if(ParticleSettings[playerid][particleEditID] != -1)
	{
	    new particleid = ParticleSettings[playerid][particleEditID];

	    switch(response)
	    {
	        case EDIT_RESPONSE_FINAL:
	        {
	            Particles[particleid][particlePos][0] = x;
	            Particles[particleid][particlePos][1] = y;
	            Particles[particleid][particlePos][2] = z;
	            Particles[particleid][particlePos][3] = rx;
	            Particles[particleid][particlePos][4] = ry;
	            Particles[particleid][particlePos][5] = rz;

	            DestroyDynamicObject(Particles[particleid][particleObject]);
       			Particles[particleid][particleObject] = CreateDynamicObject(Particles[particleid][particleModel], x, y, z, rx, ry, rz);

       			Streamer_Update(playerid, STREAMER_TYPE_OBJECT);

				new queryString[256];
	    		mysql_format(dbCon, queryString, sizeof(queryString), "UPDATE `particles` SET `PosX` = '%f', `PosY` = '%f', `PosZ` = '%f', `RotX` = '%f', `RotY` = '%f', `RotZ` = '%f' WHERE `ID` = '%d' LIMIT 1", x, y, z, rx, ry, rz, Particles[particleid][particleSQLID]);
		   		mysql_pquery(dbCon, queryString);

		   		SendClientMessageEx(playerid, COLOR_YELLOW, "-> You have successfully adjusted the position of particle dbid #%d.", Particles[particleid][particleSQLID]);

	            Particles[particleid][particleEdit] = false;
				ParticleSettings[playerid][particleEditID] = -1;
	        }
	        case EDIT_RESPONSE_CANCEL:
	        {
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

	            SendClientMessageEx(playerid, COLOR_YELLOW, "-> You're no longer editing particle dbid #%d.", Particles[particleid][particleSQLID]);

	            Particles[particleid][particleEdit] = false;
				ParticleSettings[playerid][particleEditID] = -1;
	        }
	    }
	}

	if(PlayerPlaceSlot[playerid] != -1 && PlayerPlaceCar[playerid] != -1)
	{
	    new slot = PlayerPlaceSlot[playerid];
	    new i = PlayerPlaceCar[playerid];

		new Float:finalx, Float:finaly, Float:finalz, Float:finalrz;

		GetVehicleAttachCroods(CarData[i][carVehicle], x, y, z, rz, finalx, finaly, finalz, finalrz);

		CarPlace[i][slot][cPx] = finalx;
		CarPlace[i][slot][cPy] = finaly;
		CarPlace[i][slot][cPz] = finalz;
		CarPlace[i][slot][cPrx] = rx;
		CarPlace[i][slot][cPry] = ry;
		CarPlace[i][slot][cPrz] = finalrz;

		new Float:vehicleSize[3];
	    GetVehicleModelInfo(CarData[i][carModel], VEHICLE_MODEL_INFO_SIZE, vehicleSize[0], vehicleSize[1], vehicleSize[2]);

		if((finalx > vehicleSize[0]/2) || (0 > finalx && finalx < -(vehicleSize[0]/2)) || finaly > vehicleSize[1]/2 || (0 > finaly && finaly < -(vehicleSize[1]/2))  || finalz > vehicleSize[2]/2 || (0 > finalz && finalz < -(vehicleSize[2]/4)))
		{
		    SendServerMessage(playerid, "The object is out of bounds. Move back to the vehicle.");
		}

		if(response == EDIT_RESPONSE_FINAL || response == EDIT_RESPONSE_CANCEL)
		{
            if(IsPlayerInAnyVehicle(playerid))
			{
				new
					Float:fX,
					Float:fY,
					Float:fZ,
					Float:vA;

				GetVehicleInside(CarData[i][carVehicle], fX, fY, fZ);
				GetVehicleZAngle(CarData[i][carVehicle], vA);

				if(!TwoPointCompare(1.0, fX, fY, fZ, x, y, z) || (finalx > vehicleSize[0]/2) || (0 > finalx && finalx < -(vehicleSize[0]/2)) || finaly > vehicleSize[1]/2 || (0 > finaly && finaly < -(vehicleSize[1]/2))  || finalz > vehicleSize[2]/2 || (0 > finalz && finalz < -(vehicleSize[2]/4)))
				{
					GetVehicleBootInside(CarData[i][carVehicle], fX, fY, fZ);
					GetVehicleZAngle(CarData[i][carVehicle], vA);

					if(!TwoPointCompare(1.0, fX, fY, fZ, x, y, z) || (finalx > vehicleSize[0]/2) || (0 > finalx && finalx < -(vehicleSize[0]/2)) || finaly > vehicleSize[1]/2 || (0 > finaly && finaly < -(vehicleSize[1]/2))  || finalz > vehicleSize[2]/2 || (0 > finalz && finalz < -(vehicleSize[2]/4)))
					{
						GetVehicleAttachCroods(CarData[i][carVehicle], fX, fY, fZ, vA + 135, finalx, finaly, finalz, finalrz);

						CarPlace[i][slot][cPx] = finalx;
						CarPlace[i][slot][cPy] = finaly;
						CarPlace[i][slot][cPz] = finalz;
						CarPlace[i][slot][cPrx] = -100.0;
						CarPlace[i][slot][cPry] = -45.0;
						CarPlace[i][slot][cPrz] = finalrz;
						CarPlace[i][slot][cPType] = 1;

						SendClientMessage(playerid, COLOR_LIGHTRED, "SERVER:Object is out of bounds. Moved to center position.");
					}
				}
			}
			else
			{
				new
					Float:fX,
					Float:fY,
					Float:fZ,
					Float:vA;

				GetVehicleBootInside(CarData[i][carVehicle], fX, fY, fZ);
				GetVehicleZAngle(CarData[i][carVehicle], vA);

				if(!TwoPointCompare(1.0, fX, fY, fZ, x, y, z) || (finalx > vehicleSize[0]/2) || (0 > finalx && finalx < -(vehicleSize[0]/2)) || finaly > vehicleSize[1]/2 || (0 > finaly && finaly < -(vehicleSize[1]/2))  || finalz > vehicleSize[2]/2 || (0 > finalz && finalz < -(vehicleSize[2]/4)))
				{
					GetVehicleAttachCroods(CarData[i][carVehicle], fX, fY, fZ + 0.1, vA + 135, finalx, finaly, finalz, finalrz);

					CarPlace[i][slot][cPx] = finalx;
					CarPlace[i][slot][cPy] = finaly;
					CarPlace[i][slot][cPz] = finalz;
					CarPlace[i][slot][cPrx] = 90.0;
					CarPlace[i][slot][cPry] = 270.0;
					CarPlace[i][slot][cPrz] = finalrz;
					CarPlace[i][slot][cPType] = 0;

					SendClientMessage(playerid, COLOR_LIGHTRED, "SERVER:Object is out of bounds. Moved to center position.");
				}
			}

            AttachDynamicObjectToVehicle(CarPlace[i][slot][cPobj], CarData[i][carVehicle], CarPlace[i][slot][cPx], CarPlace[i][slot][cPy], CarPlace[i][slot][cPz], CarPlace[i][slot][cPrx], CarPlace[i][slot][cPry], CarPlace[i][slot][cPrz]);

			PlayerPlaceSlot[playerid] = -1;
			PlayerPlaceCar[playerid] = -1;
		}
		return true;
	}

	if(EditingATM[playerid] != -1)
	{
	    if(response == EDIT_RESPONSE_FINAL)
	    {
		    new ATM = EditingATM[playerid];

			ATMS[ATM][aPos][0] = x;
			ATMS[ATM][aPos][1] = y;
			ATMS[ATM][aPos][2] = z;
			ATMS[ATM][aRot][0] = rx;
			ATMS[ATM][aRot][1] = ry;
			ATMS[ATM][aRot][2] = rz;

		    DestroyDynamicObject(ATMS[ATM][aObject]);
		    ATMS[ATM][aObject] = CreateDynamicObject(ATM_OBJECT, ATMS[ATM][aPos][0], ATMS[ATM][aPos][1], ATMS[ATM][aPos][2], ATMS[ATM][aRot][0], ATMS[ATM][aRot][1], ATMS[ATM][aRot][2]);

			format(gquery, sizeof(gquery),"UPDATE `atms` SET `posX` = '%f', `posY` = '%f', `posZ` = '%f', `rotX` = '%f', `rotY` = '%f', `rotZ` = '%f' WHERE `ID` = '%d' LIMIT 1", x, y, z, rx, ry, rz, ATMS[ATM][aID]);
			mysql_tquery(dbCon, gquery);

			EditingATM[playerid] = -1;

			SendNoticeMessage(playerid, "You have successfully adjusted the position of ATM [%d].", ATM);
		}
		else if(response == EDIT_RESPONSE_CANCEL)
		{
		    new ATM = EditingATM[playerid];

		    DestroyDynamicObject(ATMS[ATM][aObject]);
		    ATMS[ATM][aObject] = CreateDynamicObject(ATM_OBJECT, ATMS[ATM][aPos][0], ATMS[ATM][aPos][1], ATMS[ATM][aPos][2], ATMS[ATM][aRot][0], ATMS[ATM][aRot][1], ATMS[ATM][aRot][2]);

		    EditingATM[playerid] = -1;

	    	SendNoticeMessage(playerid, "Action canceled.");
		}
		return true;
	}

	new Float:oldX, Float:oldY, Float:oldZ, Float:oldRotX, Float:oldRotY, Float:oldRotZ;

	GetDynamicObjectPos(objectid, oldX, oldY, oldZ);
	GetDynamicObjectRot(objectid, oldRotX, oldRotY, oldRotZ);

	if(EditingGraffiti{playerid})
	{
	    new graffid = GetPVarInt(playerid, "EditingGraffti");

		if(objectid == Spray_Data[graffid][graffObject])
		{
			if(response == EDIT_RESPONSE_FINAL)
			{
				Spray_Data[graffid][Xpos] = x;
				Spray_Data[graffid][Ypos] = y;
				Spray_Data[graffid][Zpos] = z;

				Spray_Data[graffid][XYpos] = rx;
				Spray_Data[graffid][YYpos] = ry;
				Spray_Data[graffid][ZYpos] = rz;

				if(IsValidDynamicObject(Spray_Data[graffid][graffObject])) DestroyDynamicObject(Spray_Data[graffid][graffObject]);

				CreateGraffitiObject(graffid);

				SendClientMessage(playerid, COLOR_YELLOW, "-> You've successfully adjusted the graffiti.");

				DeletePVar(playerid, "EditingGraffti");
				EditingGraffiti{playerid} = false;

				SaveGraffiti(graffid);
				return true;
			}
			else if(response == EDIT_RESPONSE_CANCEL)
			{
				SetDynamicObjectPos(objectid, oldX, oldY, oldZ);
				SetDynamicObjectRot(objectid, oldRotX, oldRotY, oldRotZ);

				SendClientMessage(playerid, COLOR_YELLOW, "-> You're no longer editing the graffiti.");

				DeletePVar(playerid, "EditingGraffti");
				EditingGraffiti{playerid} = false;
				return true;
			}
			return true;
		}
	}

	new str[128];

	if(GetPVarInt(playerid, "GraffitiCreating") == 1) 
	{
	    if(response == EDIT_RESPONSE_FINAL) 
		{
            DestroyDynamicObject(GraffiObj[playerid]);
			CreateSprayLocation(playerid, x, y, z, rx, ry, rz, GraffiModel[playerid]);
			DeletePVar(playerid, "GraffitiCreating");
		}
		else if(response == EDIT_RESPONSE_CANCEL)
		{
			SetDynamicObjectPos(objectid, oldX, oldY, oldZ);
			SetDynamicObjectRot(objectid, oldRotX, oldRotY, oldRotZ);
			DeletePVar(playerid, "GraffitiCreating");
		}
	}

	if(IsValidDynamicObject(objectid) && MealObject[playerid] != -1)
	{
		if(response == EDIT_RESPONSE_FINAL)
		{
            MealDrop[MealObject[playerid]][mX] = x;
            MealDrop[MealObject[playerid]][mY] = y;
            MealDrop[MealObject[playerid]][mZ] = z;
		}
		else if(response == EDIT_RESPONSE_CANCEL)
		{
		    MealHolding[playerid] = MealDrop[MealObject[playerid]][mID];
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
			SetPlayerMealHold(playerid, MealHolding[playerid]);

			MealDestroy(MealObject[playerid]);
		    MealObject[playerid] = -1;
		}
		return true;
	}

	if(GetPVarInt(playerid, "EditingMoveDoor") == 1)
	{
	    new i = GetPVarInt(playerid, "ObjectEditing");
	
		if(Iter_Contains(Movedoors, i))
		{
			if(response == EDIT_RESPONSE_FINAL)
			{
	      		Doors[i][doorPosX] = x;
	      		Doors[i][doorPosY] = y;
	      		Doors[i][doorPosZ] = z;
	      		Doors[i][doorPosRX] = rx;
	      		Doors[i][doorPosRY] = ry;
	      		Doors[i][doorPosRZ] = rz;

				SetDynamicObjectPos(objectid, x, y, z);
				SetDynamicObjectRot(objectid, rx, ry, rz);

				SendClientMessageEx(playerid, COLOR_YELLOW, "-> Moving door %d's default position adjusted to: %f, %f, %f", x, y, z);
				
				SaveEditedMoveDoor(i, x, y, z, rx, ry, rz);
				
				DeletePVar(playerid, "EditingMoveDoor");
				DeletePVar(playerid, "ObjectEditing");
			}
			else if(response == EDIT_RESPONSE_CANCEL)
			{
				SetDynamicObjectPos(objectid, oldX, oldY, oldZ);
				SetDynamicObjectRot(objectid, oldRotX, oldRotY, oldRotZ);

				SendClientMessage(playerid, COLOR_YELLOW, "-> You're no longer editing the moving door.");
				
				DeletePVar(playerid, "EditingMoveDoor");
				DeletePVar(playerid, "ObjectEditing");
			}
		}
		return true;
	}

	if(GetPVarInt(playerid, "EditingMoveDoorMove") == 1)
	{
	    new i = GetPVarInt(playerid, "ObjectEditing");
	
	    if(Iter_Contains(Movedoors, i))
	    {
			if(response == EDIT_RESPONSE_FINAL)
			{
	      		Doors[i][doorMoveX] = x;
	      		Doors[i][doorMoveY] = y;
	      		Doors[i][doorMoveZ] = z;
	      		Doors[i][doorMoveRX] = rx;
	      		Doors[i][doorMoveRY] = ry;
	      		Doors[i][doorMoveRZ] = rz;
	      		
				SetDynamicObjectPos(objectid, oldX, oldY, oldZ);
				SetDynamicObjectRot(objectid, oldRotX, oldRotY, oldRotZ);
				
				SendClientMessageEx(playerid, COLOR_YELLOW, "-> Moving door %d's moving position adjusted to: %f, %f, %f", x, y, z);
				
				SaveEditedMoveDoorMove(i, x, y, z, rx, ry, rz);

				DeletePVar(playerid, "EditingMoveDoorMove");
				DeletePVar(playerid, "ObjectEditing");
			}
			else if(response == EDIT_RESPONSE_CANCEL)
			{
				SetDynamicObjectPos(objectid, oldX, oldY, oldZ);
				SetDynamicObjectRot(objectid, oldRotX, oldRotY, oldRotZ);

				SendClientMessage(playerid, COLOR_YELLOW, "-> You're no longer editing the moving door.");

				DeletePVar(playerid, "EditingMoveDoorMove");
				DeletePVar(playerid, "ObjectEditing");
			}
		}
		return true;
	}

	if(GetPVarInt(playerid, "EditingGate") == 1)
	{
	    new i = GetPVarInt(playerid, "ObjectEditing");

	    if(objectid == Gates[i][gateObject] && Iter_Contains(Gates, i))
		{
			if(response == EDIT_RESPONSE_FINAL)
			{
	      		Gates[i][gatePosX] = x;
	      		Gates[i][gatePosY] = y;
	      		Gates[i][gatePosZ] = z;
	      		Gates[i][gatePosRX] = rx;
	      		Gates[i][gatePosRY] = ry;
	      		Gates[i][gatePosRZ] = rz;

				SetDynamicObjectPos(objectid, x, y, z);
				SetDynamicObjectRot(objectid, rx, ry, rz);

				SendClientMessageEx(playerid, COLOR_YELLOW, "-> You've successfully set Gate %d's default position to: %f, %f, %f", i, x, y, z);
				
				SaveEditedGate(i, x, y, z, rx, ry, rz);

				DeletePVar(playerid, "EditingGate");
				DeletePVar(playerid, "ObjectEditing");
			}
			else if(response == EDIT_RESPONSE_CANCEL)
			{
				SetDynamicObjectPos(objectid, oldX, oldY, oldZ);
				SetDynamicObjectRot(objectid, oldRotX, oldRotY, oldRotZ);

				SendClientMessageEx(playerid, COLOR_YELLOW, "-> You're no longer adjusting Gate %d's default position.", i);

				DeletePVar(playerid, "EditingGate");
				DeletePVar(playerid, "ObjectEditing");
			}

			return true;
		}
	}

	if(GetPVarInt(playerid, "EditingGateMove") == 1)
	{
	    new i = GetPVarInt(playerid, "ObjectEditing");

	    if(objectid == Gates[i][gateObject] && Iter_Contains(Gates, i))
		{
			if(response == EDIT_RESPONSE_FINAL)
			{
	      		Gates[i][gateMoveX] = x;
	      		Gates[i][gateMoveY] = y;
	      		Gates[i][gateMoveZ] = z;

	      		Gates[i][gateMoveRX] = rx;
	      		Gates[i][gateMoveRY] = ry;
	      		Gates[i][gateMoveRZ] = rz;

				SetDynamicObjectPos(objectid, oldX, oldY, oldZ);
				SetDynamicObjectRot(objectid, oldRotX, oldRotY, oldRotZ);

				SendClientMessageEx(playerid, COLOR_YELLOW, "-> You've successfully set Gate %d's moving position to: %f, %f, %f", i, x, y, z);
				
				SaveEditedGateMove(i, x, y, z, rx, ry, rz);

				DeletePVar(playerid, "EditingGateMove");
				DeletePVar(playerid, "ObjectEditing");
			}
			else if(response == EDIT_RESPONSE_CANCEL)
			{
				SetDynamicObjectPos(objectid, oldX, oldY, oldZ);
				SetDynamicObjectRot(objectid, oldRotX, oldRotY, oldRotZ);

				SendClientMessageEx(playerid, COLOR_YELLOW, "-> You're no longer adjusting Gate %d's moving position.", i);

				DeletePVar(playerid, "EditingGateMove");
				DeletePVar(playerid, "ObjectEditing");
			}
			return true;
		}
	}

	if(IsValidDynamicObject(objectid) && GetPVarInt(playerid, "EditingFurniture") == 1)
	{
		if(response == EDIT_RESPONSE_FINAL)
		{
			SetDynamicObjectPos(objectid, x, y, z);
			SetDynamicObjectRot(objectid, rx, ry, rz);

			OnPlayerEditedFurniture(playerid, GetPVarInt(playerid, "ChosenFurnitureSlot"), x, y, z, rx, ry, rz);

			DeletePVar(playerid, "EditingFurniture");
			ShowPlayerCurrentFurniture(playerid, GetPVarInt(playerid, "FurniturePages"));
		}
		else if(response == EDIT_RESPONSE_CANCEL)
		{
			SetDynamicObjectPos(objectid, oldX, oldY, oldZ);
			SetDynamicObjectRot(objectid, oldRotX, oldRotY, oldRotZ);

			DeletePVar(playerid, "EditingFurniture");
			ShowPlayerCurrentFurniture(playerid, GetPVarInt(playerid, "FurniturePages"));
		}
		return true;
	}

	if(IsValidDynamicObject(objectid) && GetPVarInt(playerid, "JustBoughtFurniture") == 1)
	{
		if(response == EDIT_RESPONSE_FINAL)
		{
			SetDynamicObjectPos(objectid, x, y, z);
			SetDynamicObjectRot(objectid, rx, ry, rz);

			OnPlayerEditedFurniture(playerid, GetPVarInt(playerid, "ChosenFurnitureSlot"), x, y, z, rx, ry, rz);

			DeletePVar(playerid, "JustBoughtFurniture");
			ShowPlayerCurrentFurniture(playerid, GetPVarInt(playerid, "FurniturePages"));
		}
		if(response == EDIT_RESPONSE_CANCEL)
		{
		    new furnitureslot = GetPVarInt(playerid, "ChosenFurnitureSlot"), houseid = InProperty[playerid];

			if(houseid != -1)
			{
				SendPlayerMoney(playerid, HouseFurniture[houseid][furnitureslot][fMarketPrice]);

				DestroyDynamicObject(HouseFurniture[houseid][furnitureslot][fObject]);

				OnPlayerSellHouseFurniture(playerid, houseid, furnitureslot);
				DeletePVar(playerid, "JustBoughtFurniture");
			}

			houseid = InBusiness[playerid];

			if(houseid != -1)
			{
			    SendPlayerMoney(playerid, BizFurniture[houseid][furnitureslot][fMarketPrice]);

				DestroyDynamicObject(BizFurniture[houseid][furnitureslot][fObject]);

				OnPlayerSellBizFurniture(playerid, houseid, furnitureslot);
				DeletePVar(playerid, "JustBoughtFurniture");
			}

			Dialog_Show(playerid, FurnitureDialog, DIALOG_STYLE_LIST, "Furniture Main Menu:", "Buy Furniture\nCurrent Furniture\nInformation", "Select", "<<");
		}

		DeletePVar(playerid, "FurnitureModelBuying");
		DeletePVar(playerid, "FurniturePriceBuying");
		DeletePVar(playerid, "FurnitureNameBuying");
		return true;
	}

	if(IsValidDynamicObject(objectid) && GetPVarInt(playerid, "BoomboxAdjust") == 1)
	{
		if(response == EDIT_RESPONSE_FINAL)
		{
		    DeletePVar(playerid, "BoomboxAdjust");

		    foreach (new i : Player)
			{
				if(playerid != i && BoomboxData[i][boomboxPlaced] && GetDistance(BoomboxData[i][boomboxPos][0], BoomboxData[i][boomboxPos][1], BoomboxData[i][boomboxPos][2], BoomboxData[i][boomboxPos][0], BoomboxData[i][boomboxPos][1], BoomboxData[i][boomboxPos][2]) <= 30.0)
				{
					SetDynamicObjectPos(objectid, oldX, oldY, oldZ);
					SetDynamicObjectRot(objectid, oldRotX, oldRotY, oldRotZ);

					SendClientMessage(playerid, COLOR_LIGHTRED, "You can't place a boombox here.");
			        return true;
				}
			}

			SetDynamicObjectPos(objectid, x, y, z);
			SetDynamicObjectRot(objectid, rx, ry, rz);

			BoomboxData[playerid][boomboxPos][0] = x;
			BoomboxData[playerid][boomboxPos][1] = y;
			BoomboxData[playerid][boomboxPos][2] = z;

			if(BoomboxData[playerid][boomboxOn])
			{
				foreach (new i : Player)
				{
					if(Boombox_Nearest(i) == playerid)
					{
						strunpack(str, BoomboxData[playerid][boomboxURL]);
						StopAudioStreamForPlayer(i);
						PlayAudioStreamForPlayer(i, str, BoomboxData[playerid][boomboxPos][0], BoomboxData[playerid][boomboxPos][1], BoomboxData[playerid][boomboxPos][2], 30.0, 1);
					}
				}
			}

		}
		if(response == EDIT_RESPONSE_CANCEL)
		{
			SetDynamicObjectPos(objectid, oldX, oldY, oldZ);
			SetDynamicObjectRot(objectid, oldRotX, oldRotY, oldRotZ);
			DeletePVar(playerid, "BoomboxAdjust");
		}
		return true;
	}

	if(IsValidDynamicObject(objectid) && GetPVarInt(playerid, "EditingRB"))
	{
	    new idx = GetPVarInt(playerid, "EditingRB") - 1, rb = RoadBlocks[playerid][idx][roadblockID];

		switch(response)
		{
			case EDIT_RESPONSE_FINAL:
			{
				SetDynamicObjectPos(objectid, x, y, z);
				SetDynamicObjectRot(objectid, rx, ry, rz);

				if(IsStingerObject(Road_Blocks[rb][rbObjectID])) 
				{
					RoadBlocks[playerid][idx][roadblockArea] = CreateDynamicRectangle(x - 2, y - 6, x + 2, y + 6);
					AssignDynamicAreaValue(RoadBlocks[playerid][idx][roadblockArea], AREA_TYPE_STINGER, playerid);
				}

				SendNoticeMessage(playerid, "%s deployed.", Road_Blocks[rb][rbName]);

				DeletePVar(playerid, "EditingRB");	
				return true;				
			}
			case EDIT_RESPONSE_CANCEL:
			{
				SetDynamicObjectPos(objectid, oldX, oldY, oldZ);
				SetDynamicObjectRot(objectid, oldRotX, oldRotY, oldRotZ);

				if(IsStingerObject(Road_Blocks[rb][rbObjectID])) 
				{
					RoadBlocks[playerid][idx][roadblockArea] = CreateDynamicRectangle(oldX - 2, oldY - 6, oldX + 2, oldY + 6);
					AssignDynamicAreaValue(RoadBlocks[playerid][idx][roadblockArea], AREA_TYPE_STINGER, playerid);
				}	

				SendNoticeMessage(playerid, "%s deployed.", Road_Blocks[rb][rbName]);

				DeletePVar(playerid, "EditingRB");		
				return true;							
			}
		}
		return true;
	}

	return true;
}

stock IsStingerObject(model)
{
	if(model == 2899 || model == 2892) return true;

	return false;
}

forward OnHouseRemove(houseid);
public OnHouseRemove(houseid)
{
	PropertyData[houseid][hEntranceX] = 0.0000;
	PropertyData[houseid][hEntranceY] = 0.0000;
	PropertyData[houseid][hEntranceZ] = 0.0000;
	PropertyData[houseid][hExitX] = 0.0000;
	PropertyData[houseid][hExitY] = 0.0000;
	PropertyData[houseid][hExitZ] = 0.0000;
	PropertyData[houseid][hCheckPosX] = 0.0000;
	PropertyData[houseid][hCheckPosY] = 0.0000;
	PropertyData[houseid][hCheckPosZ] = 0.0000;
	PropertyData[houseid][hLevelbuy] = 0;
	PropertyData[houseid][hPrice] = 0;
	PropertyData[houseid][hOwned] = 0;
	PropertyData[houseid][hLocked] = 0;
	PropertyData[houseid][hRentprice] = 0;
	PropertyData[houseid][hRentable] = 0;
	PropertyData[houseid][hInterior] = 0;
	PropertyData[houseid][hWorld] = 0;
	PropertyData[houseid][hCash] = 0;
	PropertyData[houseid][hRadio] = 0;
	PropertyData[houseid][hOwnerSQLID] = -1;
	format(PropertyData[houseid][hOwner], 256, "The State");
	PropertyData[houseid][hLabel] = Text3D:INVALID_3DTEXT_ID;
	Iter_Remove(Property, houseid);
	return true;
}

forward OnAdminSellHouse(houseid);
public OnAdminSellHouse(houseid)
{
	foreach (new i : Player)
	{
		if(PlayerData[i][pHouseKey] == houseid)
		{
			SendClientMessage(i, COLOR_LIGHTRED, "The house you were renting at was sold.");

			PlayerData[i][pHouseKey] = -1;
		}
	}

    PropertyData[houseid][hOwnerSQLID] = -1;
	PropertyData[houseid][hOwned] = 0;
	PropertyData[houseid][hLocked] = 1;
	PropertyData[houseid][hRentprice] = 0;
	PropertyData[houseid][hRentable] = 0;

	format(PropertyData[houseid][hOwner], MAX_PLAYER_NAME, "The State");

	Property_Refresh(houseid);
	return true;
}

forward OnHouseMoved(houseid, Float:x, Float:y, Float:z);
public OnHouseMoved(houseid, Float:x, Float:y, Float:z)
{
	PropertyData[houseid][hEntranceX] = x;
	PropertyData[houseid][hEntranceY] = y;
	PropertyData[houseid][hEntranceZ] = z;

	if(IsValidDynamic3DTextLabel(Text3D:PropertyData[houseid][hLabel])) DestroyDynamic3DTextLabel(Text3D:PropertyData[houseid][hLabel]);

	Property_Refresh(houseid);
	return true;
}

forward OnApartmentMoved(houseid, Float:x, Float:y, Float:z);
public OnApartmentMoved(houseid, Float:x, Float:y, Float:z)
{
	ComplexData[houseid][aExitX] = x;
	ComplexData[houseid][aExitY] = y;
	ComplexData[houseid][aExitZ] = z;
	return true;
}

forward OnHouseExitMoved(houseid, Float:x, Float:y, Float:z);
public OnHouseExitMoved(houseid, Float:x, Float:y, Float:z)
{
	PropertyData[houseid][hExitX] = x;
	PropertyData[houseid][hExitY] = y;
	PropertyData[houseid][hExitZ] = z;
	return true;
}

forward OnTeleportRemove(teleid);
public OnTeleportRemove(teleid)
{
	Teleports[teleid][aPosX] = 0.0000;
	Teleports[teleid][aPosY] = 0.0000;
	Teleports[teleid][aPosZ] = 0.0000;
	Teleports[teleid][aTeleOn] = 0;
	return true;
}

forward ShowTenantsAmount(playerid, house);
public ShowTenantsAmount(playerid, house)
{
	new rows, tenantname[128];

	cache_get_row_count(rows);

	if(!rows)
		return SendClientMessage(playerid, COLOR_GRAD1, "Nobody is renting at your house.");

	SendClientMessage(playerid, COLOR_GREEN, "__________House tenants__________");

	for(new i = 0; i != rows; ++i)
	{
		cache_get_value_index(i, 0, tenantname);

		SendClientMessageEx(playerid, COLOR_STAT1, "%d. %s", i, tenantname);
	}

	SendClientMessageEx(playerid, COLOR_GREEN, "Total: %d. Possible income: $%d.", rows, PropertyData[house][hRentprice] * rows);

	SendClientMessage(playerid, COLOR_GREEN, "_______________________________________");
	return true;
}

forward OnPlayerSellHouse(house);
public OnPlayerSellHouse(house)
{
	foreach (new i : Player)
	{
		if(PlayerData[i][pHouseKey] == house)
		{
			SendClientMessage(i, COLOR_GRAD1, "The house you rented was sold.");

			PlayerData[i][pHouseKey] = -1;
		}
	}
	return true;
}

forward OnPlayerEvictTenant(playerid, house);
public OnPlayerEvictTenant(playerid, house)
{
	foreach (new i : Player)
	{
		if(i == playerid) continue;

		if(PlayerData[i][pHouseKey] == house)
		{
			PlayerData[i][pHouseKey] = -1;
			SendClientMessage(i, COLOR_YELLOW, "You were driven out of the house by the owner.");
		}
	}
	return true;
}

Dialog:AdminTeles(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		TeleportPlayerToPoint(playerid, strval(inputtext));
	}
	return true;
}

TeleportPlayerToPoint(playerid, id)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		SetVehicleDynamicPos(GetPlayerVehicleID(playerid), Teleports[id][aPosX], Teleports[id][aPosY], Teleports[id][aPosZ], playerid);
	}
	else SetPlayerPosEx(playerid, Teleports[id][aPosX], Teleports[id][aPosY], Teleports[id][aPosZ]);

	SetPlayerInterior(playerid, Teleports[id][aInterior]);

    DesyncPlayerInterior(playerid);

	SendClientMessageEx(playerid, COLOR_GREY, "You have been teleported to %s (dbid #%d).", Teleports[id][aMapName], Teleports[id][aID]);

	foreach (new i : Player)
	{
	    if(PlayerData[i][pAdmin] >= 4)
	    {
        	SendClientMessageEx(i, COLOR_YELLOW, "AdmWarn(3): %s has teleported to %s (dbid #%d).", ReturnName(playerid), Teleports[id][aMapName], Teleports[id][aID]);
		}
	}
}

DesyncPlayerInterior(playerid)
{
    InProperty[playerid] = -1;
    InApartment[playerid] = -1;
    InBusiness[playerid] = -1;
	InGarage[playerid] = -1;

	PlayerData[playerid][pInterior] = 0;
	PlayerData[playerid][pWorld] = 0;
	PlayerData[playerid][pLocal] = 255;
}

Dialog:AdminBusinesses(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		SetPlayerPosEx(playerid, BusinessData[listitem][bEntranceX], BusinessData[listitem][bEntranceY], BusinessData[listitem][bEntranceZ]);
	}
	return true;
}

Dialog:Teles(playerid, response, listitem, inputtext[])
{
	if(!response) return 1;

	switch(listitem)
		{
		    case 0:
		    {
		        SetPlayerDynamicPos(playerid, -25.884498,-185.868988,1003.546875);
		        SetPlayerInterior(playerid, 17);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}24/7 1");
			    return 1;
		    }
		    case 1:
		    {
		        SetPlayerDynamicPos(playerid, 6.091179,-29.271898,1003.549438);
		        SetPlayerInterior(playerid, 10);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}24/7 2");
			    return 1;
		    }
		    case 2:
		    {
		        SetPlayerDynamicPos(playerid, -30.946699,-89.609596,1003.546875);
		        SetPlayerInterior(playerid, 18);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}24/7 3");
			    return 1;
		    }
		    case 3:
		    {
		        SetPlayerDynamicPos(playerid, -25.132598,-139.066986,1003.546875);
		        SetPlayerInterior(playerid, 16);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}24/7 4");
			    return 1;
		    }
		    case 4:
		    {
		        SetPlayerDynamicPos(playerid, -27.312299,-29.277599,1003.557250);
		        SetPlayerInterior(playerid, 4);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}24/7 5");
			    return 1;
		    }
		    case 5:
		    {
		        SetPlayerDynamicPos(playerid, -26.691598,-55.714897,1003.546875);
		        SetPlayerInterior(playerid, 6);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}24/7 6");
			    return 1;
		    }
		    case 6:
		    {
		        SetPlayerDynamicPos(playerid, -1827.147338,7.207417,1061.143554);
		        SetPlayerInterior(playerid, 14);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}Airoport Ticket Desk");
			    return 1;
		    }
		    case 7:
		    {
		        SetPlayerDynamicPos(playerid, -1861.936889,54.908092,1061.143554);
		        SetPlayerInterior(playerid, 14);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}Airoport Baggage Reclaim");
			    return 1;
		    }
		    case 8:
		    {
		        SetPlayerDynamicPos(playerid, 1.808619,32.384357,1199.593750);
		        SetPlayerInterior(playerid, 1);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}Shamal");
			    return 1;
		    }
		    case 9:
		    {
		        SetPlayerDynamicPos(playerid, 315.745086,984.969299,1958.919067);
		        SetPlayerInterior(playerid, 9);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}Andromada");
			    return 1;
		    }
		    case 10:
		    {
		        SetPlayerDynamicPos(playerid, 286.148986,-40.644397,1001.515625);
		        SetPlayerInterior(playerid, 1);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}Ammunation 1");
			    return 1;
		    }
		    case 11:
		    {
		        SetPlayerDynamicPos(playerid, 286.800994,-82.547599,1001.515625);
		        SetPlayerInterior(playerid, 4);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}Ammunation 2");
			    return 1;
		    }
		    case 12:
		    {
		        SetPlayerDynamicPos(playerid, 296.919982,-108.071998,1001.515625);
		        SetPlayerInterior(playerid, 6);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}Ammunation 3");
			    return 1;
		    }
		    case 13:
		    {
		        SetPlayerDynamicPos(playerid, 314.820983,-141.431991,999.601562);
		        SetPlayerInterior(playerid, 7);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}Ammunation 4");
			    return 1;
		    }
		    case 14:
		    {
		        SetPlayerDynamicPos(playerid, 316.524993,-167.706985,999.593750);
		        SetPlayerInterior(playerid, 6);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}Ammunation 5");
			    return 1;
		    }
		    case 15:
		    {
		        SetPlayerDynamicPos(playerid, 302.292877,-143.139099,1004.062500);
		        SetPlayerInterior(playerid, 7);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}Ammunation Booths");
			    return 1;
		    }
		    case 16:
		    {
		        SetPlayerDynamicPos(playerid, 298.507934,-141.647048,1004.054748);
		        SetPlayerInterior(playerid, 7);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}Ammunation Range");
			    return 1;
		    }
		    case 17:
		    {
		        SetPlayerDynamicPos(playerid, 1038.531372,0.111030,1001.284484);
		        SetPlayerInterior(playerid, 3);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}Blastin Fools Hallway");
			    return 1;
		    }
		    case 18:
		    {
		        SetPlayerDynamicPos(playerid, 444.646911,508.239044,1001.419494);
		        SetPlayerInterior(playerid, 12);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}Budget Inn Motel Room");
			    return 1;
		    }
		    case 19:
		    {
		        SetPlayerDynamicPos(playerid, 2215.454833,-1147.475585,1025.796875);
		        SetPlayerInterior(playerid, 14);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}Jefferson Motel");
			    return 1;
		    }
		    case 20:
		    {
		        SetPlayerDynamicPos(playerid, 833.269775,10.588416,1004.179687);
		        SetPlayerInterior(playerid, 3);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}Off Track Betting Shop");
			    return 1;
		    }
		    case 21:
		    {
		        SetPlayerDynamicPos(playerid, -103.559165,-24.225606,1000.718750);
		        SetPlayerInterior(playerid, 3);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}Sex Shop");
			    return 1;
		    }
		    case 22:
		    {
		        SetPlayerDynamicPos(playerid, 963.418762,2108.292480,1011.030273);
		        SetPlayerInterior(playerid, 1);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}Meat Factory");
			    return 1;
		    }
		    case 23:
		    {
		        SetPlayerDynamicPos(playerid, -2240.468505,137.060440,1035.414062);
		        SetPlayerInterior(playerid, 6);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}Zero's RC Shop");
			    return 1;
		    }
		    case 24:
		    {
		        SetPlayerDynamicPos(playerid, 663.836242,-575.605407,16.343263);
		        SetPlayerInterior(playerid, 0);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {0099FF}Dillmore Gas Station");
			    return 1;
		    }
		    case 25:
		    {
		        SetPlayerDynamicPos(playerid, 2169.461181,1618.798339,999.976562);
		        SetPlayerInterior(playerid, 1);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}Catigula's Basement");
			    return 1;
		    }
			case 26:
		    {
		        SetPlayerDynamicPos(playerid, 1889.953369,1017.438293,31.882812);
		        SetPlayerInterior(playerid, 10);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}FDC Janitors Room");
			    return 1;
		    }
		    case 27:
		    {
		        SetPlayerDynamicPos(playerid, -2159.122802,641.517517,1052.381713);
		        SetPlayerInterior(playerid, 1);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}Woozie's Office");
			    return 1;
		    }
		    case 28:
		    {
		        SetPlayerDynamicPos(playerid, 207.737991,-109.019996,1005.132812);
		        SetPlayerInterior(playerid, 15);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}Binco");
			    return 1;
		    }
		    case 29:
		    {
		        SetPlayerDynamicPos(playerid, 204.332992,-166.694992,1000.523437);
		        SetPlayerInterior(playerid, 14);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}Didier Sachs");
			    return 1;
		    }
		    case 30:
		    {
		        SetPlayerDynamicPos(playerid, 207.054992,-138.804992,1003.507812);
		        SetPlayerInterior(playerid, 3);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}Prolaps");
			    return 1;
		    }
		    case 31:
		    {
		        SetPlayerDynamicPos(playerid, 203.777999,-48.492397,1001.804687);
		        SetPlayerInterior(playerid, 1);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}Suburban");
			    return 1;
		    }
		    case 32:
		    {
		        SetPlayerDynamicPos(playerid, 226.293991,-7.431529,1002.210937);
		        SetPlayerInterior(playerid, 5);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}Victim");
			    return 1;
		    }
		    case 33:
		    {
		        SetPlayerDynamicPos(playerid, 161.391006,-93.159156,1001.804687);
		        SetPlayerInterior(playerid, 18);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}ZIP");
			    return 1;
		    }
		    case 34:
		    {
		        SetPlayerDynamicPos(playerid, 493.390991,-22.722799,1000.679687);
		        SetPlayerInterior(playerid, 17);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}Alhambra");
			    return 1;
		    }
		    case 35:
		    {
		        SetPlayerDynamicPos(playerid, 501.980987,-69.150199,998.757812);
		        SetPlayerInterior(playerid, 11);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}Ten Green Bottles");
			    return 1;
		    }
		    case 36:
		    {
		        SetPlayerDynamicPos(playerid, -227.027999,1401.229980,27.765625);
		        SetPlayerInterior(playerid, 18);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}Lil' Probe Inn");
			    return 1;
		    }
		    case 37:
		    {
		        SetPlayerDynamicPos(playerid, 457.304748,-88.428497,999.554687);
		        SetPlayerInterior(playerid, 4);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}Jay's Dinner");
			    return 1;
		    }
		    case 38:
		    {
		        SetPlayerDynamicPos(playerid, 454.973937,-110.104995,1000.077209);
		        SetPlayerInterior(playerid, 5);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}Gant Bridge Dinner");
			    return 1;
		    }
		    case 39:
		    {
		        SetPlayerDynamicPos(playerid, 435.271331,-80.958938,999.554687);
		        SetPlayerInterior(playerid, 6);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}Secret Valley Dinner");
			    return 1;
		    }
		    case 40:
		    {
		        SetPlayerDynamicPos(playerid, 452.489990,-18.179698,1001.132812);
		        SetPlayerInterior(playerid, 1);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}World of Coq");
			    return 1;
		    }
		    case 41:
		    {
		        SetPlayerDynamicPos(playerid, 681.557861,-455.680053,-25.609874);
		        SetPlayerInterior(playerid, 1);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}Welcome Pump");
			    return 1;
		    }
		    case 42:
		    {
		        SetPlayerDynamicPos(playerid, 375.962463,-65.816848,1001.507812);
		        SetPlayerInterior(playerid, 10);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}Burger Shot");
			    return 1;
		    }
		    case 43:
		    {
		        SetPlayerDynamicPos(playerid, 369.579528,-4.487294,1001.858886);
		        SetPlayerInterior(playerid, 9);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}Cluckin' Bell");
			    return 1;
		    }
		    case 44:
		    {
		        SetPlayerDynamicPos(playerid, 373.825653,-117.270904,1001.499511);
		        SetPlayerInterior(playerid, 5);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}Well Stacked Pizza");
			    return 1;
		    }
		    case 45:
		    {
		        SetPlayerDynamicPos(playerid, 381.169189,-188.803024,1000.632812);
		        SetPlayerInterior(playerid, 17);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}Jimmy's Sticky Ring");
			    return 1;
		    }
		    case 46:
		    {
		        SetPlayerDynamicPos(playerid, 244.411987,305.032989,999.148437);
		        SetPlayerInterior(playerid, 1);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}Denise Room");
			    return 1;
		    }
		    case 47:
		    {
		        SetPlayerDynamicPos(playerid, 271.884979,306.631988,999.148437);
		        SetPlayerInterior(playerid, 2);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}Katie Room");
			    return 1;
		    }
		    case 48:
		    {
		        SetPlayerDynamicPos(playerid, 291.282989,310.031982,999.148437);
		        SetPlayerInterior(playerid, 3);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}Helena Room");
			    return 1;
		    }
		    case 49:
		    {
		        SetPlayerDynamicPos(playerid, 302.180999,300.722991,999.148437);
		        SetPlayerInterior(playerid, 4);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}Michelle Room");
			    return 1;
		    }
		    case 50:
		    {
		        SetPlayerDynamicPos(playerid, 322.197998,302.497985,999.148437);
		        SetPlayerInterior(playerid, 5);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}Barbara Room");
			    return 1;
		    }
		    case 51:
		    {
		        SetPlayerDynamicPos(playerid, 346.870025,309.259033,999.155700);
		        SetPlayerInterior(playerid, 6);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}Millie Room");
			    return 1;
		    }
		    case 52:
		    {
		        SetPlayerDynamicPos(playerid, -959.564392,1848.576782,9.000000);
		        SetPlayerInterior(playerid, 17);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}Sherman Dam");
			    return 1;
		    }
		    case 53:
		    {
		        SetPlayerDynamicPos(playerid, 384.808624,173.804992,1008.382812);
		        SetPlayerInterior(playerid, 3);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}Planning Dept.");
			    return 1;
		    }
		    case 54:
		    {
		        SetPlayerDynamicPos(playerid, 223.431976,1872.400268,13.734375);
		        SetPlayerInterior(playerid, 0);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}Area 51");
			    return 1;
		    }
		    case 55:
		    {
		        SetPlayerDynamicPos(playerid, 772.111999,-3.898649,1000.728820);
		        SetPlayerInterior(playerid, 5);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}LS Gym");
			    return 1;
		    }
		    case 56:
		    {
		        SetPlayerDynamicPos(playerid, 774.213989,-48.924297,1000.585937);
		        SetPlayerInterior(playerid, 6);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}SF Gym");
			    return 1;
		    }
		    case 57:
		    {
		        SetPlayerDynamicPos(playerid, 773.579956,-77.096694,1000.655029);
		        SetPlayerInterior(playerid, 7);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}LV Gym");
			    return 1;
		    }
		    case 58:
		    {
		        SetPlayerDynamicPos(playerid, 1527.229980,-11.574499,1002.097106);
		        SetPlayerInterior(playerid, 3);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}B Dup's House");
			    return 1;
		    }
		    case 59:
		    {
		        SetPlayerDynamicPos(playerid, 1523.509887,-47.821197,1002.130981);
		        SetPlayerInterior(playerid, 2);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}B Dup's Crack Pad");
			    return 1;
		    }
		    case 60:
		    {
		        SetPlayerDynamicPos(playerid, 2496.049804,-1695.238159,1014.742187);
		        SetPlayerInterior(playerid, 3);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}CJ's House");
			    return 1;
		    }
		    case 61:
		    {
		        SetPlayerDynamicPos(playerid, 1267.663208,-781.323242,1091.906250);
		        SetPlayerInterior(playerid, 5);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}Madd Dogg's Mansion");
			    return 1;
		    }
		    case 62:
		    {
		        SetPlayerDynamicPos(playerid, 513.882507,-11.269994,1001.565307);
		        SetPlayerInterior(playerid, 3);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}OG Loc's House");
			    return 1;
		    }
		    case 63:
		    {
		        SetPlayerDynamicPos(playerid, 2454.717041,-1700.871582,1013.515197);
		        SetPlayerInterior(playerid, 2);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}Ryder's House");
			    return 1;
		    }
		    case 64:
		    {
		        SetPlayerDynamicPos(playerid, 2527.654052,-1679.388305,1015.498596);
		        SetPlayerInterior(playerid, 1);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}Sweet's House");
			    return 1;
		    }
		    case 65:
		    {
		        SetPlayerDynamicPos(playerid, 2543.462646,-1308.379882,1026.728393);
		        SetPlayerInterior(playerid, 2);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}Crack Factory");
			    return 1;
		    }
		    case 66:
		    {
		        SetPlayerDynamicPos(playerid, 1212.019897,-28.663099,1000.953125);
		        SetPlayerInterior(playerid, 3);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}Big Spread Ranch");
			    return 1;
		    }
		    case 67:
		    {
		        SetPlayerDynamicPos(playerid, 761.412963,1440.191650,1102.703125);
		        SetPlayerInterior(playerid, 6);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}Fanny Batters");
			    return 1;
		    }
		    case 68:
		    {
		        SetPlayerDynamicPos(playerid, 1204.809936,-11.586799,1000.921875);
		        SetPlayerInterior(playerid, 2);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {0099FF}Strip Club");
			    return 1;
		    }
		    case 69:
		    {
		        SetPlayerDynamicPos(playerid, 1204.809936,13.897239,1000.921875);
		        SetPlayerInterior(playerid, 2);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {0099FF}Strip Club Private Room");
			    return 1;
		    }
		    case 70:
		    {
		        SetPlayerDynamicPos(playerid, 942.171997,-16.542755,1000.929687);
		        SetPlayerInterior(playerid, 3);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {0099FF}Unnamed Brothel");
			    return 1;
		    }
		    case 71:
		    {
		        SetPlayerDynamicPos(playerid, 964.106994,-53.205497,1001.124572);
		        SetPlayerInterior(playerid, 3);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {0099FF}Tiger Skin Brothel");
			    return 1;
		    }
		    case 72:
		    {
		        SetPlayerDynamicPos(playerid, -2640.762939,1406.682006,906.460937);
		        SetPlayerInterior(playerid, 3);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {0099FF}Pleasure Domes");
			    return 1;
		    }
		    case 73:
		    {
		        SetPlayerDynamicPos(playerid, -729.276000,503.086944,1371.971801);
		        SetPlayerInterior(playerid, 1);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {0099FF}Liberty City Outside");
			    return 1;
		    }
		    case 74:
		    {
		        SetPlayerDynamicPos(playerid, -794.806396,497.738037,1376.195312);
		        SetPlayerInterior(playerid, 1);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {0099FF}Liberty City Inside");
			    return 1;
		    }
		    case 75:
		    {
		        SetPlayerDynamicPos(playerid, 	2350.339843,-1181.649902,1027.976562);
		        SetPlayerInterior(playerid, 5);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {0099FF}Gang House");
			    return 1;
		    }
		    case 76:
		    {
		        SetPlayerDynamicPos(playerid, 2807.619873,-1171.899902,1025.570312);
		        SetPlayerInterior(playerid, 8);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {0099FF}Colonel Furhberger's House");
			    return 1;
		    }
		    case 77:
		    {
		        SetPlayerDynamicPos(playerid, 18.564971,1118.209960,1083.882812);
		        SetPlayerInterior(playerid, 5);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {0099FF}Crack Den");
			    return 1;
		    }
		    case 78:
		    {
		        SetPlayerDynamicPos(playerid, 1412.639892,-1.787510,1000.924377);
		        SetPlayerInterior(playerid, 1);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {0099FF}Warehouse 1");
			    return 1;
		    }
		    case 79:
		    {
		        SetPlayerDynamicPos(playerid, 1302.519897,-1.787510,1001.028259);
		        SetPlayerInterior(playerid, 18);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {0099FF}Warehouse 2");
			    return 1;
		    }
		    case 80:
		    {
		        SetPlayerDynamicPos(playerid, 2522.000000,-1673.383911,14.866223);
		        SetPlayerInterior(playerid, 0);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {0099FF}Sweet's Garage");
			    return 1;
		    }
		    case 81:
		    {
		        SetPlayerDynamicPos(playerid, -221.059051,1408.984008,27.773437);
		        SetPlayerInterior(playerid, 18);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {0099FF}Lil' Probe Inn Toilet");
			    return 1;
		    }
		    case 82:
		    {
		        SetPlayerDynamicPos(playerid, 2324.419921,-1145.568359,1050.710083);
		        SetPlayerInterior(playerid, 12);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {0099FF}Unused Safe House");
			    return 1;
		    }
		    case 83:
		    {
		        SetPlayerDynamicPos(playerid, -975.975708,1060.983032,1345.671875);
		        SetPlayerInterior(playerid, 10);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {0099FF}RC Battlefield");
			    return 1;
		    }
		    case 84:
		    {
		        SetPlayerDynamicPos(playerid, 411.625976,-21.433298,1001.804687);
		        SetPlayerInterior(playerid, 2);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {0099FF}Barber 1");
			    return 1;
		    }
		    case 85:
		    {
		        SetPlayerDynamicPos(playerid, 418.652984,-82.639793,1001.804687);
		        SetPlayerInterior(playerid, 3);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {0099FF}Barber 2");
			    return 1;
		    }
		    case 86:
		    {
		        SetPlayerDynamicPos(playerid, 412.021972,-52.649898,1001.898437);
		        SetPlayerInterior(playerid, 12);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {0099FF}Barber 3");
			    return 1;
		    }
		    case 87:
		    {
		        SetPlayerDynamicPos(playerid, -204.439987,-26.453998,1002.273437);
		        SetPlayerInterior(playerid, 16);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {0099FF}Tatoo Parlour 1");
			    return 1;
		    }
		    case 88:
		    {
		        SetPlayerDynamicPos(playerid, -204.439987,-8.469599,1002.273437);
		        SetPlayerInterior(playerid, 17);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {0099FF}Tatoo Parlour 2");
			    return 1;
		    }
		    case 89:
		    {
		        SetPlayerDynamicPos(playerid, -204.439987,-43.652496,1002.273437);
		        SetPlayerInterior(playerid, 3);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {0099FF}Tatoo Parlour 3");
			    return 1;
		    }
		    case 90:
		    {
		        SetPlayerDynamicPos(playerid, 246.783996,63.900199,1003.640625);
		        SetPlayerInterior(playerid, 6);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {0099FF}LS Police HQ");
			    return 1;
		    }
		    case 91:
		    {
		        SetPlayerDynamicPos(playerid, 246.375991,109.245994,1003.218750);
		        SetPlayerInterior(playerid, 10);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {0099FF}SF police HQ");
			    return 1;
		    }
		    case 92:
		    {
		        SetPlayerDynamicPos(playerid, 288.745971,169.350997,1007.171875);
		        SetPlayerInterior(playerid, 3);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {0099FF}LV police HQ");
			    return 1;
		    }
		    case 93:
		    {
		        SetPlayerDynamicPos(playerid, -2029.798339,-106.675910,1035.171875);
		        SetPlayerInterior(playerid, 3);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {0099FF}Car School");
			    return 1;
		    }
		    case 94:
		    {
		        SetPlayerDynamicPos(playerid, -1398.065307,-217.028900,1051.115844);
		        SetPlayerInterior(playerid, 7);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {0099FF}8-Track");
			    return 1;
		    }
		    case 95:
		    {
		        SetPlayerDynamicPos(playerid, -1398.103515,937.631164,1036.479125);
		        SetPlayerInterior(playerid, 15);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {0099FF}Bloodbowl");
			    return 1;
		    }
		    case 96:
		    {
		        SetPlayerDynamicPos(playerid, -1444.645507,-664.526000,1053.572998);
		        SetPlayerInterior(playerid, 4);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {0099FF}Dirt Track");
			    return 1;
		    }
		    case 97:
		    {
		        SetPlayerDynamicPos(playerid, -1465.268676,1557.868286,1052.531250);
		        SetPlayerInterior(playerid, 14);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {0099FF}Kickstart");
			    return 1;
		    }
		    case 98:
		    {
		        SetPlayerDynamicPos(playerid, -1401.829956,107.051300,1032.273437);
		        SetPlayerInterior(playerid, 1);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {0099FF}Vice Stadium");
			    return 1;
		    }
		    case 99:
		    {
		        SetPlayerDynamicPos(playerid, -1790.378295,1436.949829,7.187500);
		        SetPlayerInterior(playerid, 0);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {0099FF}SF Garage");
			    return 1;
		    }
		    case 100:
		    {
		        SetPlayerDynamicPos(playerid, 1643.839843,-1514.819580,13.566620);
		        SetPlayerInterior(playerid, 0);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {0099FF}LS Garage");
			    return 1;
		    }
		    case 101:
		    {
		        SetPlayerDynamicPos(playerid, -1685.636474,1035.476196,45.210937);
		        SetPlayerInterior(playerid, 0);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}SF Bomb Shop");
			    return 1;
		    }
		    case 102:
		    {
		        SetPlayerDynamicPos(playerid, 76.632553,-301.156829,1.578125);
		        SetPlayerInterior(playerid, 0);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}Blueberry Warehouse");
			    return 1;
		    }
		    case 103:
		    {
		        SetPlayerDynamicPos(playerid, 1059.895996,2081.685791,10.820312);
		        SetPlayerInterior(playerid, 0);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}LV Warehouse 1");
			    return 1;
		    }
		    case 104:
		    {
		        SetPlayerDynamicPos(playerid, 1059.180175,2148.938720,10.820312);
		        SetPlayerInterior(playerid, 0);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}LV Warehouse 2");
			    return 1;
		    }
		    case 105:
		    {
		        SetPlayerDynamicPos(playerid, 2131.507812,1600.818481,1008.359375);
		        SetPlayerInterior(playerid, 1);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}Catigula's Hidden Room");
			    return 1;
		    }
		    case 106:
		    {
		        SetPlayerDynamicPos(playerid, 2315.952880,-1.618174,26.742187);
		        SetPlayerInterior(playerid, 0);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}Bank");
			    return 1;
		    }
		    case 107:
		    {
		        SetPlayerDynamicPos(playerid, 2319.714843,-14.838361,26.749565);
		        SetPlayerInterior(playerid, 0);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}Bank - Behind Desk");
			    return 1;
		    }
		    case 108:
		    {
		        SetPlayerDynamicPos(playerid, 1710.433715,-1669.379272,20.225049);
		        SetPlayerInterior(playerid, 18);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}LS Atruim");
			    return 1;
		    }
		    case 109:
		    {
		        SetPlayerDynamicPos(playerid, 1494.325195,1304.942871,1093.289062);
		        SetPlayerInterior(playerid, 3);
		        SendClientMessage(playerid, COLOR_WHITE, "You have been successfully teleported to {FF9900}Bike School");
			    return 1;
		    }
		}
    return 1;
}

Dialog:HandleEditFurniture(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new houseid = InProperty[playerid], furnitureslot = strval(inputtext);

		SetPVarInt(playerid, "ChosenFurnitureSlot", furnitureslot);

		if(houseid != -1)
		{
			if(!HouseFurniture[houseid][furnitureslot][fOn])
				return SendClientMessage(playerid, COLOR_GRAD1, "This furniture is not available.");

			SetPVarInt(playerid, "EditingFurniture", 1);

			EditDynamicObject(playerid, HouseFurniture[houseid][furnitureslot][fObject]);
			return true;
		}

		houseid = InBusiness[playerid];

		if(houseid != -1)
		{
			if(!BizFurniture[houseid][furnitureslot][fOn])
				return SendClientMessage(playerid, COLOR_GRAD1, "This furniture is not available.");

			SetPVarInt(playerid, "EditingFurniture", 1);

			EditDynamicObject(playerid, BizFurniture[houseid][furnitureslot][fObject]);
			return true;
		}
	}
	return true;
}

// TOOLS
HexToInt(const string[])
{
    if(string[0] == 0)
    {
        return 0;
    }

    new i, cur = 1, res = 0;

    for (i = strlen(string); i > 0; i--)
    {
        if(string[i-1] < 58)
        {
            res = res + cur * (string[i - 1] - 48);
        }
        else
        {
            res = res + cur * (string[i-1] - 65 + 10);
            cur = cur * 16;
        }
    }

    return res;
}

FUNX::OnPlayerPurchaseProperty(playerid, response)
{
	new houseid = GetPVarInt(playerid, "PropertyID");

	DeletePVar(playerid, "PropertyID");

	if(response)
	{
	    if(PropertyData[houseid][hOwned])
	        return SendClientMessage(playerid, COLOR_GRAD1, "Somebody else owns this property.");
	
		if(CountPlayerOwnHouse(playerid) >= MAX_BUYHOUSES)
			return SendClientMessage(playerid, COLOR_GRAD1, "You have the highest number of houses available, /sellhouse to sell your property.");

		if(PlayerData[playerid][pLevel] < PropertyData[houseid][hLevelbuy])
			return SendClientMessage(playerid, COLOR_GRAD1, "You cannot purchase this property.");

		if(PlayerData[playerid][pCash] < PropertyData[houseid][hPrice])
			return SendClientMessage(playerid, COLOR_GRAD1, "You cannot purchase this property.");

        TakePlayerMoney(playerid, PropertyData[houseid][hPrice]);

        PropertyData[houseid][hOwnerSQLID] = PlayerData[playerid][pID];
		PropertyData[houseid][hOwned] = 1;
		PropertyData[houseid][hLocked] = 1;
		PropertyData[houseid][hRentable] = 0;
		PropertyData[houseid][hRentprice] = 0;
		PropertyData[houseid][hCash] = 0;

		format(PropertyData[houseid][hOwner], MAX_PLAYER_NAME, ReturnName(playerid));

		PlayerData[playerid][pHouseKey] = houseid;
		PlayerData[playerid][pSpawnPoint] = 2;

		SendClientMessage(playerid, COLOR_GREEN, "Congratulations, on your new purchase.");

		GameTextForPlayer(playerid, "~w~Welcome Home~n~You can enter at any time typing~n~/enter at this checkpoint", 3000, 5);

		Property_Refresh(houseid);

		format(gquery, sizeof(gquery), "UPDATE `characters` SET `Cash` = '%d', `SpawnPoint` = '2', `playerHouseKey` = '%d' WHERE `ID` = '%d' LIMIT 1", PlayerData[playerid][pCash], houseid, PlayerData[playerid][pID]);
		mysql_pquery(dbCon, gquery);

		Property_Save(houseid);
	}
    return true;
}

public OnPlayerSelectDynamicObject(playerid, objectid, modelid, Float:x, Float:y, Float:z)
{
	if(IsValidDynamicObject(objectid) && modelid == ATM_OBJECT)
	{
	    CancelEdit(playerid);

	    new ATM = -1;

		for(new i = 0; i < MAX_ATM_LIMIT; ++i)
		{
		    if(ATMS[i][aObject] == objectid)
		    {
		        ATM = i;
		        break;
		    }
		}

		if(ATM != -1)
		{
		    foreach (new i : Player)
		    {
		        if(i == playerid)
					continue;

		        if(EditingATM[i] == ATM)
					return SendErrorMessage(playerid, "Somebody else is currently editing this ATM.");
		    }

		    if(DeletingATM{playerid})
		    {
		        DeletingATM{playerid} = false;

		        BouttaDelete[playerid] = ATM;

				Dialog_Show(playerid, DIALOG_ATM_DELETE, DIALOG_STYLE_MSGBOX, "Confirmation", "Are you sure you want to delete ATM [%d]?", "Yes", "No", ATM);
			}
			else
			{
			    EditDynamicObject(playerid, ATMS[ATM][aObject]);
			    EditingATM[playerid] = ATM;

			    SendNoticeMessage(playerid, "You are now adjusting the position of ATM [%d].", ATM);
			}
		}
		else SendErrorMessage(playerid, "That's not an ATM or it can't be edited.");
	}

	if(IsValidDynamicObject(objectid) && GetPVarInt(playerid, "SelectingFurniture") == 1)
	{
		if(GetPVarInt(playerid, "EditingFurniture") == 1)
			return SendClientMessage(playerid, COLOR_LIGHTRED, "You're currently editing furniture.");

		new houseid = InProperty[playerid];

		if(houseid != -1)
		{
			for(new i = 0; i != MAX_FURNITURE; ++i)
			{
				if(HouseFurniture[houseid][i][fOn])
				{
					if(HouseFurniture[houseid][i][fObject] == objectid)
					{
						SetPVarInt(playerid, "ChosenFurnitureSlot", i);

						Dialog_Show(playerid, FurnitureEditMenu, DIALOG_STYLE_LIST, "Object Editing:", "{FFFFFF}Information\nPosition\n{FF6347}Edit Materials{FFFFFF}\nSell\nRename\nDuplicate", "Select", "<<");
						break;
					}
				}
			}
		}

		houseid = InBusiness[playerid];

		if(houseid != -1)
		{
			for(new i = 0; i != MAX_FURNITURE; ++i)
			{
				if(BizFurniture[houseid][i][fOn])
				{
					if(BizFurniture[houseid][i][fObject] == objectid)
					{
						SetPVarInt(playerid, "ChosenFurnitureSlot", i);

						Dialog_Show(playerid, FurnitureEditMenu, DIALOG_STYLE_LIST, "Object Editing:", "{FFFFFF}Information\nPosition\n{FF6347}Edit Materials{FFFFFF}\nSell\nRename\nDuplicate", "Select", "<<");
						break;
					}
				}
			}
		}

		DeletePVar(playerid, "SelectingFurniture");

		CancelEdit(playerid);
	}
	return true;
}

GetXYInFrontOfPlayer(playerid, &Float:x, &Float:y, Float:distance)
{
	// Created by Y_Less

	new Float:a;

	GetPlayerPos(playerid, x, y, a);

	if(GetPlayerVehicleID(playerid))
	{
	    GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
	}
	else GetPlayerFacingAngle(playerid, a);

	x += (distance * floatsin(-a, degrees));
	y += (distance * floatcos(-a, degrees));
}

forward ShowAmount(playerid, text[]);
public ShowAmount(playerid, text[])
{
	new rows, count = 0;
	cache_get_row_count(rows);

	if(rows)
	{
		while(count < rows) count++;
	}

	format(sgstr, sizeof(sgstr), "%s the total number: %d", text, count);
	SendClientMessage(playerid, COLOR_GRAD2, sgstr);
	return true;
}

forward Float:GetPosInFrontOfVehicle(vehicleid, &Float:x, &Float:y, Float:distance);
public Float:GetPosInFrontOfVehicle(vehicleid, &Float:x, &Float:y, Float:distance)
{
	new Float:a;
	GetVehiclePos(vehicleid, x, y, a);
 	GetVehicleZAngle(vehicleid, a);
	x += (distance * floatsin(-a, degrees));
	y += (distance * floatcos(-a, degrees));
	return a;
}

stock GetUnixTime()
{
	new Year, Month, Day,Hour,Minute,Second;
	getdate(Year, Month, Day);
	gettime(Hour,Minute,Second);
	return mktime(Hour,Minute,Second,Day,Month,Year);
}

stock mktime(hour,minute,second,day,month,year)
{
	new timestamp2;

	timestamp2 = second + (minute * 60) + (hour * 3600);

	new days_of_month[12];

	if( ((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0) ) {
		days_of_month = {                         // Schaltjahr
			31,29,31,30,31,30,31,31,30,31,30,31
		};
	}
	else {
		days_of_month = {                         // keins
			31,28,31,30,31,30,31,31,30,31,30,31
		};
	}
	new days_this_year = 0;
	days_this_year = day;
	if(month > 1) {                               // No January Calculation, because its always the 0 past months
		for(new i=0; i != month-1; ++i) {
			days_this_year += days_of_month[i];
		}
	}
	timestamp2 += days_this_year * 86400;

	for(new j=1970;j!=year;++j) {
		timestamp2 += 31536000;
// Schaltjahr + 1 Tag
		if( ((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0) )  timestamp2 += 86400;
	}

	return timestamp2;
}

Toll_CloseToll(TollID)
{
	if(TollID == RichmanToll)
	{
		SetDynamicObjectRot(L_a_TollObject[0], 0.000000, -90.000000, 23.81982421875);
		SetDynamicObjectRot(L_a_TollObject[1], 0.000000, -90.000000, 214.37744140625);
	}
	else if(TollID == FlintToll)
	{
		SetDynamicObjectRot(L_a_TollObject[2], 0.000000, -90.000000, 270.67565917969);
		SetDynamicObjectRot(L_a_TollObject[3], 0.000000, -90.000000, 87.337799072266);
	}
	else if(TollID == LVToll)
	{
		SetDynamicObjectRot(L_a_TollObject[4], 0.000000, -90.000000, 348.10229492188);
		SetDynamicObjectRot(L_a_TollObject[5], 0.000000, -90.000000, 169.43664550781);
	}
	else if(TollID == BlueberryTollR)
	{
		SetDynamicObjectRot(L_a_TollObject[6], 0.00000, -90.00000, 35.00000);
		SetDynamicObjectRot(L_a_TollObject[7], 0.00000, -90.00000, 215.92000);
	}
	else if(TollID == BlueberryTollL)
	{
		SetDynamicObjectRot(L_a_TollObject[8], 0.00000, -90.00000, -14.94000);
		SetDynamicObjectRot(L_a_TollObject[9], 0.00000, -90.00000, -195.00000);
	}

	TollsOpenCount --;
	return true;
}

Toll_OpenToll(TollID)
{
	if(TollID == RichmanToll)
	{
		aTolls[RichmanToll][E_tOpenTime] = 7;
		
		SetDynamicObjectRot(L_a_TollObject[0], 0.000000, 0.000000, 23.81982421875);
		SetDynamicObjectRot(L_a_TollObject[1], 0.000000, 0.000000, 214.37744140625);
	}
	else if(TollID == FlintToll)
	{
		aTolls[FlintToll][E_tOpenTime] = 7;
		
		SetDynamicObjectRot(L_a_TollObject[2], 0.000000, 0.000000, 270.67565917969);
		SetDynamicObjectRot(L_a_TollObject[3], 0.000000, 0.000000, 87.337799072266);
	}
	else if(TollID == LVToll)
	{
		aTolls[LVToll][E_tOpenTime] = 7;
		
		SetDynamicObjectRot(L_a_TollObject[4], 0.000000, 0.000000, 348.10229492188);
		SetDynamicObjectRot(L_a_TollObject[5], 0.000000, 0.000000, 169.43664550781);
	}
	else if(TollID == BlueberryTollR)
	{
		aTolls[BlueberryTollR][E_tOpenTime] = 7;
		
		SetDynamicObjectRot(L_a_TollObject[6], 0.000000, 0.000000, 35.00000);
		SetDynamicObjectRot(L_a_TollObject[7], 0.000000, 0.000000, 215.92000);
	}
	else if(TollID == BlueberryTollL)
	{
		aTolls[BlueberryTollL][E_tOpenTime] = 7;
		
		SetDynamicObjectRot(L_a_TollObject[8], 0.000000, 0.000000, -14.94000);
		SetDynamicObjectRot(L_a_TollObject[9], 0.000000, 0.000000, -195.00000);
	}

	Iter_Add(sv_activevehicles, TollID);

	TollsOpenCount ++;
}

stock Toll_TimePassedCops(playerid) // Cops have to wait for <TollDelayCop> seconds between every /toll (Global)
{
	new L_i_tick = GetUnixTime();

	if(L_a_RequestAllowedCop > L_i_tick && L_a_RequestAllowedCop != 0)
	{
		SendClientMessageEx(playerid, COLOR_LIGHTRED, "You will have to wait at least %d seconds between each toll payment.", TollDelayCop);
		return false;
	}

	L_a_RequestAllowedCop = (L_i_tick + TollDelayCop);
	return true;
}

stock ReturnTollStatus(id)
{
	new status[20];

	if(aTolls[id][E_tLocked] == 1)
	{
	    format(status, 20, "{F17986}Locked");
	}
	else
	{
	    format(status, 20, "{DDFF3F}Unlocked");
	}

	return status;
}

stock ShowAllTolls(playerid)
{
	gstr[0] = EOS;

	strcat(gstr, "Booth Name\tStatus\tEmergency\n");
	format(sgstr, sizeof(sgstr), "Hampton Barns\t{AFAFAF}Closed\t%s\n", ReturnTollStatus(BlueberryTollR));
	strcat(gstr, sgstr);
	format(sgstr, sizeof(sgstr), "Panopticon\t{AFAFAF}Closed\t%s\n", ReturnTollStatus(BlueberryTollL));
	strcat(gstr, sgstr);
	format(sgstr, sizeof(sgstr), "LSLV Highway\t{AFAFAF}Closed\t%s\n", ReturnTollStatus(LVToll));
	strcat(gstr, sgstr);
	format(sgstr, sizeof(sgstr), "Flint Range\t{AFAFAF}Closed\t%s\n", ReturnTollStatus(FlintToll));
	strcat(gstr, sgstr);
	format(sgstr, sizeof(sgstr), "Rodeo Bank\t{AFAFAF}Closed\t%s\n", ReturnTollStatus(RichmanToll));
	strcat(gstr, sgstr);

	strcat(gstr, "{AFAFAF}Lock all booths\n");
	strcat(gstr, "{AFAFAF}Unlock all booths");

	ShowPlayerDialog(playerid, TOLLS_DIALOG2, DIALOG_STYLE_TABLIST_HEADERS, "{FFFFFF}Toolbooth Management", gstr, "Select", "Back");
}

GetVehicleCargoLoad(vehicleid)
{
	for(new i = 0; i < MAX_TRUCKER_ITEMS; ++i)
	{
		if(CoreVehicles[vehicleid][vehicleCrate][i])
		{
			return i;
		}
	}

	return -1;
}

IsVehicleCargoSkill(modelid, skill)
{
	switch(modelid)
	{
	    case 600, 605, 543, 422, 478, 554: return true;
	    case 413, 459, 482: if(skill > 0) return true;
	    case 440, 498: if(skill > 1) return true;
	    case 499, 414, 578, 443, 428: if(skill > 2) return true;
	    case 456, 455: if(skill > 3) return true;
	    case 403: if(skill > 4) return true;
	}

	return false;
}

IsAtBlackMarket(playerid)
{
	if(IsPlayerInRangeOfPoint(playerid, 6, 2520.3499,-1486.5232,23.9993))
		return true;
	else if(IsPlayerInRangeOfPoint(playerid, 6, 2457.5876,-1953.9668,13.4013))
		return true;

	return false;
}

IsAdminSpawned(vehicleid)
{
	if(CoreVehicles[vehicleid][vehicleCarID] != -1) return false;

	for(new i = 0; i != MAX_ADMIN_VEHICLES; ++i)
	{
		if(AdminSpawnedVehicles[i] == vehicleid)
		{
		    return true;
		}
	}

	return false;
}

IsABicycle(vehicleid)
{
	switch(GetVehicleModel(vehicleid))
	{
		case 481, 509, 510:
			return true;
	}

	return false;
}

IsABike(vehicleid)
{
	switch(GetVehicleModel(vehicleid))
	{
		case 448, 461..463, 468, 471, 521, 522, 581, 586:
			return true;
	}

	return false;
}

IsATaxi(vehicle)
{
	new model = GetVehicleModel(vehicle);

	return (model == 420 || model == 438);
}

IsDonateCar(model)
{
	switch(model)
	{
	    case 481, 509:
	    {
	        return 1;
	    }
 	    case 477, 471:
	    {
	        return 2;
	    }
 	    case 429, 541, 521, 468:
	    {
	        return 3;
	    }
	}
	return false;
}

IsCopCar(model)
{
	switch(model)
	{
	    case 490, 497, 523, 528, 596, 597, 598, 599, 601:
			return true;
	}

	return false;
}

IsMedicCar(model)
{
	switch(model)
	{
	    case 416:
			return true;
	}

	return false;
}

RemovePlayerDriveby(playerid)
{
	new vehicleid = GetPlayerVehicleID(playerid), seat = GetPlayerVehicleSeat(playerid), weaponid = GetPlayerWeapon(playerid);

    RemoveFromVehicle(playerid);
    PutPlayerInVehicle(playerid, vehicleid, seat);
    SetPlayerArmedWeapon(playerid, weaponid);
    SetCameraBehindPlayer(playerid);
	return true;
}

CanAdvertise(playerid)
{
	new id = Business_Nearest(playerid, 5.0);

	if(id == -1) return -1;

	if(BusinessData[id][bType] != 11) return -1;

	return id;
}

CheckFightingStyle(playerid)
{
	new styleid = FIGHT_STYLE_NORMAL;

	switch(PlayerData[playerid][pFightStyle])
	{
		case 0: styleid = FIGHT_STYLE_NORMAL;
		case 1: styleid = FIGHT_STYLE_GRABKICK;
		case 2: styleid = FIGHT_STYLE_BOXING;
		case 3: styleid = FIGHT_STYLE_KUNGFU;
		default: styleid = FIGHT_STYLE_NORMAL;
	}

	return SetPlayerFightingStyle(playerid, styleid);
}

CountAdvert()
{
    new
		count = 0
	;

	for(new i = 0; i != MAX_AD_QUEUE; ++i)
	{
		if(AdvertData[i][ad_id])
		{
			count++;
		}
	}

	return count;
}

CountPlayerAdvert(playerid)
{
    new
		count = 0
	;

	for(new i = 0; i != MAX_AD_QUEUE; ++i)
	{
		if(AdvertData[i][ad_id] && AdvertData[i][ad_owner] == playerid)
		{
			count++;
		}
	}

	return count;
}

SetPlayerRaceCheckpointEx(playerid, cptype, missiontype, Float:X, Float:Y, Float:Z)
{
	switch(missiontype)
	{
	    case RCHECKPOINT_TRUCKER: SendClientMessage(playerid, COLOR_WHITE, "Navigation! (If no check is used /updatemission)");
	    case RCHECKPOINT_TRUCKERJOB: SendClientMessage(playerid, COLOR_WHITE, "Follow the check to the trucking office (If no check is used /updatemission)");
	}

	// Checkpoint Mission
    PlayerData[playerid][pCP_Type] = missiontype;
    PlayerData[playerid][pCP_X] = X;
    PlayerData[playerid][pCP_Y] = Y;
    PlayerData[playerid][pCP_Z] = Z;

	SetPlayerRaceCheckpoint(playerid, cptype, X, Y, Z, 0.0, 0.0, 0.0, 3.5);
	return true;
}

SetPlayerCheckpointEx(playerid, Float:x, Float:y, Float:z, Float:distance, status, value = -1)
{
	gPlayerCheckpointX[playerid] = x;
	gPlayerCheckpointY[playerid] = y;
	gPlayerCheckpointZ[playerid] = z;

 	gPlayerCheckpointValue[playerid] = value;
    gPlayerCheckpointStatus[playerid] = status;

    SetPlayerCheckpoint(playerid, x, y, z, distance);
	return true;
}

IsJobSide(jobid)
{
	if(jobid == JOB_NONE || jobid == JOB_MECHANIC)
		return true;

	return false;
}

ReturnJobName(playerid, jobid)
{
	new name[32];

	switch(jobid)
	{
	    case JOB_NONE: format(name, 32, "None");
	    case JOB_FARMER: format(name, 32, "Farmer");
	    case JOB_TRUCKER:
		{
			switch(PlayerData[playerid][pJobRank])
			{
			    case 0: format(name, 32, "Courier Trainee");
			    case 1: format(name, 32, "Courier");
			    case 2: format(name, 32, "Professional Courier");
			    case 3: format(name, 32, "Trucker Trainee");
			    case 4: format(name, 32, "Trucker");
			    case 5: format(name, 32, "Professional Trucker");
			}
	    }
	    case JOB_MECHANIC: format(name, 32, "Car Mechanic");
	    case JOB_TAXI: format(name, 32, "Taxi Driver");
	    case JOB_WPDEALER: format(name, 32, "Weapon Dealer");
	    case JOB_SUPPLIER: format(name, 32, "Weapon Supplier");

	    default: format(name, 32, "Unemployed");
	}

	return name;
}

public OnDynamicObjectMoved(objectid)
{
	if(objectid == gShipRamp1)
	{
		UpdateShipStorage();
	}
	return true;
}

forward ShipArrival();
public ShipArrival()
{
	gShipDeparture = false;

	MoveDynamicObject(gShipRamp1, 2810.9445, -2387.2998, 12.6255, 0.01, -20.4000, 0.0000, -90.3000);
	MoveDynamicObject(gShipRamp2, 2810.6875, -2436.9775, 12.6250, 0.01, -20.4000, 0.0000, -90.3000);

	gShipTime = gettime();

	new gShipHour, gShipMinute, gShipSecond;

	TimestampToTime(gShipTime + 2440, gShipHour, gShipMinute, gShipSecond);

	format(sgstr, sizeof(sgstr), "Departure: %02d:%02d:%02d", gShipHour, gShipMinute, gShipSecond);
	SetDynamicObjectMaterialText(gShipTextLine2, 0, sgstr, OBJECT_MATERIAL_SIZE_256x256, "Arial", 16, 1, 0xFFFFFFFF, 0, 1);

	TimestampToTime(gShipTime + 2740, gShipHour, gShipMinute, gShipSecond);

	format(sgstr, sizeof(sgstr), "Next arrival: %02d:%02d:%02d", gShipHour, gShipMinute, gShipSecond);
	SetDynamicObjectMaterialText(gShipTextLine3, 0, sgstr, OBJECT_MATERIAL_SIZE_256x256, "Arial", 16, 1, 0xFFFFFFFF, 0, 1);
	return true;
}

RampsClosed()
{
    gShipDeparture = true;

	foreach (new i : Player)
	{
	    if(IsPlayerInRangeOfPoint(i, 100.0, 2809.9849,-2391.3201,13.6282) || IsPlayerInRangeOfPoint(i, 30.0, 2810.5256,-2440.7012,13.6328))
	    {
	        SendClientMessage(i, COLOR_GRAD1, "___________________________________________________________________________________");
			SendClientMessage(i, COLOR_LIGHTRED, "Attention! Ship departs in 40 seconds! Ramps to be closed in 20 seconds!");
            SendClientMessage(i, COLOR_WHITE, "If you decide to go and stay on the ship, DO NOT JUMP while it's moving as it may kill you.");
            SendClientMessage(i, COLOR_WHITE, "DO NOT SIT IN A VEHICLE WHILE YOU'RE ON A MOVING SHIP!");
            SendClientMessage(i, COLOR_GRAD1, "___________________________________________________________________________________");

            GameTextForPlayer(i, "~r~attention!~n~~w~ship departs~n~in 40 seconds!", 5000, 1);
		}
	}

	SetTimer("RampsClosing", 20000, false);
}

forward RampsClosing();
public RampsClosing()
{
	foreach (new i : Player)
	{
	    if(IsPlayerInRangeOfPoint(i, 100.0, 2809.9849,-2391.3201,13.6282) || IsPlayerInRangeOfPoint(i, 30.0, 2810.5256,-2440.7012,13.6328))
	    {
	        SendClientMessage(i, COLOR_GRAD1, "___________________________________________________________________________________");
			SendClientMessage(i, COLOR_LIGHTRED, "Attention! Ship departs in 20 seconds! Ramps are closing!");
            SendClientMessage(i, COLOR_WHITE, "If you decide to go and stay on the ship, DO NOT JUMP while it's moving as it may kill you.");
            SendClientMessage(i, COLOR_WHITE, "DO NOT SIT IN A VEHICLE WHILE YOU'RE ON A MOVING SHIP!");
            SendClientMessage(i, COLOR_GRAD1, "___________________________________________________________________________________");
            GameTextForPlayer(i, "~r~attention!~n~~w~ship departs~n~in 20 seconds!", 5000, 1);
		}
	}

	MoveDynamicObject(gShipRamp1, 2810.9445, -2387.2998, 12.6255-0.1, 0.01, 49.6999, 0.0000, -90.3000);
	MoveDynamicObject(gShipRamp2, 2810.6875, -2436.9775, 12.6250-0.1, 0.01, 49.6999, 0.0000, -90.3000);
}

FUNX::OnAccountUnbanned(playerid, account[])
{
	if(cache_affected_rows())
	{
		SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(1): %s unbanned %s.", ReturnName(playerid), account);
	}
	else
	{
	    SendServerMessage(playerid, "No bans found on %s.", account);
	}
	return true;
}

FUNX::OnIPAddressUnbanned(playerid, address[])
{
	if(cache_affected_rows())
	{
		SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn(1): %s unbanned IP %s.", ReturnName(playerid), address);
	}
	else
	{
	    SendServerMessage(playerid, "No bans found on %s.", address);
	}
	return true;
}

/*IsAnIP(str[])
{
	if(!str[0] || str[0] == '\1')
		return 0;

	for(new i = 0, l = strlen(str); i != l; ++i)
	{
	    if((str[i] < '0' || str[i] > '9') && str[i] != '.')
	        return 0;

	    if(0 < ((i == 0) ? (strval(str)) : (strval(str[i + 1]))) > 255)
	        return 0;
	}
	return true;
}*/

ReturnDonateRank(rank)
{
	new drank[20];

	switch(rank)
	{
		case 1:
			drank = "Bronze User";
		case 2:
			drank = "Silver User";
		case 3:
			drank = "Gold User";
		default:
			drank = "None";
	}

	return drank;
}

initiateTutorial(playerid)
{
    ClearChatBox(playerid);
    
	PlayerData[playerid][pTutorialStep] = 1;

	SendClientMessage(playerid, COLOR_WHITE, ">> Welcome to Legacy Roleplay!");
	SendClientMessage(playerid, COLOR_GRAD2, "This video tutorial will guide you for your first steps on Legacy-RP.");
	SendClientMessage(playerid, COLOR_GRAD2, "The tutorial will go through on its own.");
	SendClientMessage(playerid, COLOR_GRAD2, "We highly recommend you to take your time reading the text in the chat box.");	

	SetPlayerCameraPos(playerid, 1541.1512, -2287.1345, 91.9661);
	SetPlayerCameraLookAt(playerid, 1623.3582, -2288.0413, 77.9914);
	return true;
}

GetIDByName(const playername[])
{
    foreach (new i : Player)
	{
		if(SQL_IsLogged(i))
		{
			new pName[MAX_PLAYER_NAME];
			GetPlayerName(i, pName, sizeof(pName));

			if(strcmp(pName, playername, true, strlen(playername)) == 0)
			{
				return i;
			}
		}
	}
	return INVALID_PLAYER_ID;
}

SetBusinessInterior(playerid, bizid, int)
{
	if(int == 0)
	{
		BusinessData[bizid][bExitX] = 0.0;
		BusinessData[bizid][bExitY] = 0.0;
		BusinessData[bizid][bExitZ] = 0.0;
		BusinessData[bizid][bInterior] = 0;

		format(sgstr, sizeof(sgstr), "Business ID: %d - Description: None", bizid);
	}
	else if(int == 1)
	{
		BusinessData[bizid][bExitX] = -794.806030;
		BusinessData[bizid][bExitY] = 491.686004;
		BusinessData[bizid][bExitZ] = 1376.194946;
		BusinessData[bizid][bInterior] = 1;

		format(sgstr, sizeof(sgstr), "Business ID: %d - Description: Marcos Bistro", bizid);
	}
	else if(int == 2)
	{
		BusinessData[bizid][bExitX] = 1212.019897;
		BusinessData[bizid][bExitY] = -28.663099;
		BusinessData[bizid][bExitZ] = 1001.089966;
		BusinessData[bizid][bInterior] = 3;

		format(sgstr, sizeof(sgstr), "Business ID: %d - Description: Big Spread Ranch Strip Club", bizid);
	}
	else if(int == 3)
	{
		BusinessData[bizid][bExitX] = 366.923980;
		BusinessData[bizid][bExitY] = -72.929359;
		BusinessData[bizid][bExitZ] = 1001.507812;
		BusinessData[bizid][bInterior] = 10;

		format(sgstr, sizeof(sgstr), "Business ID: %d - Description: Burger Shot", bizid);
	}
	else if(int == 4)
	{
		BusinessData[bizid][bExitX] = 365.672974;
		BusinessData[bizid][bExitY] = -10.713200;
		BusinessData[bizid][bExitZ] = 1001.869995;
		BusinessData[bizid][bInterior] = 9;

		format(sgstr, sizeof(sgstr), "Business ID: %d - Description: Cluckin Bell", bizid);
	}
	else if(int == 5)
	{
		BusinessData[bizid][bExitX] = 372.351990;
		BusinessData[bizid][bExitY] = -131.650986;
		BusinessData[bizid][bExitZ] = 1001.449951;
		BusinessData[bizid][bInterior] = 5;

		format(sgstr, sizeof(sgstr), "Business ID: %d - Description: Well Stacked Pizza", bizid);
	}
	else if(int == 6)
	{
		BusinessData[bizid][bExitX] = 377.098999;
		BusinessData[bizid][bExitY] = -192.439987;
		BusinessData[bizid][bExitZ] = 1000.643982;
		BusinessData[bizid][bInterior] = 17;

		format(sgstr, sizeof(sgstr), "Business ID: %d - Description: Rusty Brown Dohnuts", bizid);
	}
	else if(int == 7)
	{
		BusinessData[bizid][bExitX] = 460.099976;
		BusinessData[bizid][bExitY] = -88.428497;
		BusinessData[bizid][bExitZ] = 999.621948;
		BusinessData[bizid][bInterior] = 4;

		format(sgstr, sizeof(sgstr), "Business ID: %d - Description: Jays Diner", bizid);
	}
	else if(int == 8)
	{
		BusinessData[bizid][bExitX] = 681.474976;
		BusinessData[bizid][bExitY] = -451.150970;
		BusinessData[bizid][bExitZ] = -25.616798;
		BusinessData[bizid][bInterior] = 1;

		format(sgstr, sizeof(sgstr), "Business ID: %d - Description: Pump Truck Stop Diner", bizid);
	}
	else if(int == 9)
	{
		BusinessData[bizid][bExitX] = 476.068328;
		BusinessData[bizid][bExitY] = -14.893922;
		BusinessData[bizid][bExitZ] = 1003.695312;
		BusinessData[bizid][bInterior] = 17;

		format(sgstr, sizeof(sgstr), "Business ID: %d - Description: Alhambra", bizid);
	}
	else if(int == 10)
	{
		BusinessData[bizid][bExitX] = 501.980988;
		BusinessData[bizid][bExitY] = -69.150200;
		BusinessData[bizid][bExitZ] = 998.834961;
		BusinessData[bizid][bInterior] = 11;

		format(sgstr, sizeof(sgstr), "Business ID: %d - Description: Mistys", bizid);

	}
	else if(int == 11)
	{
		BusinessData[bizid][bExitX] = -227.028000;
		BusinessData[bizid][bExitY] = 1401.229980;
		BusinessData[bizid][bExitZ] = 27.769798;
		BusinessData[bizid][bInterior] = 18;

		format(sgstr, sizeof(sgstr), "Business ID: %d - Description: Lil' Probe Inn", bizid);
	}
	else if(int == 12)
	{
		BusinessData[bizid][bExitX] = 204.332993;
		BusinessData[bizid][bExitY] = -166.694992;
		BusinessData[bizid][bExitZ] = 1000.578979;
		BusinessData[bizid][bInterior] = 14;

		format(sgstr, sizeof(sgstr), "Business ID: %d - Description: EXcLusive", bizid);
	}
	else if(int == 13)
	{
		BusinessData[bizid][bExitX] = 207.737991;
		BusinessData[bizid][bExitY] = -109.019997;
		BusinessData[bizid][bExitZ] = 1005.269958;
		BusinessData[bizid][bInterior] = 15;

		format(sgstr, sizeof(sgstr), "Business ID: %d - Description: Binco", bizid);
	}
	else if(int == 14)
	{
		BusinessData[bizid][bExitX] = 207.054993;
		BusinessData[bizid][bExitY] = -138.804993;
		BusinessData[bizid][bExitZ] = 1003.519958;
		BusinessData[bizid][bInterior] = 3;

		format(sgstr, sizeof(sgstr), "Business ID: %d - Description: ProLaps", bizid);
	}
	else if(int == 15)
	{
		BusinessData[bizid][bExitX] = 203.778000;
		BusinessData[bizid][bExitY] = -48.492397;
		BusinessData[bizid][bExitZ] = 1001.799988;
		BusinessData[bizid][bInterior] = 1;

		format(sgstr, sizeof(sgstr), "Business ID: %d - Description: SubUrban", bizid);
	}
	else if(int == 16)
	{
		BusinessData[bizid][bExitX] = 226.293991;
		BusinessData[bizid][bExitY] = -7.431530;
		BusinessData[bizid][bExitZ] = 1002.259949;
		BusinessData[bizid][bInterior] = 5;

		format(sgstr, sizeof(sgstr), "Business ID: %d - Description: Victim", bizid);
	}
	else if(int == 17)
	{
		BusinessData[bizid][bExitX] = 161.391006;
		BusinessData[bizid][bExitY] = -93.159156;
		BusinessData[bizid][bExitZ] = 1001.804687;
		BusinessData[bizid][bInterior] = 18;

		format(sgstr, sizeof(sgstr), "Business ID: %d - Description: Zip", bizid);
	}
	else if(int == 18)
	{
		BusinessData[bizid][bExitX] = 1133.069946;
		BusinessData[bizid][bExitY] = -9.573059;
		BusinessData[bizid][bExitZ] = 1000.750000;
		BusinessData[bizid][bInterior] = 12;

		format(sgstr, sizeof(sgstr), "Business ID: %d - Description: Small Casino in Redsands West", bizid);
	}
	else if(int == 19)
	{
		BusinessData[bizid][bExitX] = 833.818970;
		BusinessData[bizid][bExitY] = 7.418000;
		BusinessData[bizid][bExitZ] = 1004.179993;
		BusinessData[bizid][bInterior] = 3;

		format(sgstr, sizeof(sgstr), "Business ID: %d - Description: Off Track Betting", bizid);
	}
	else if(int == 20)
	{
		BusinessData[bizid][bExitX] = -100.325996;
		BusinessData[bizid][bExitY] = -22.816500;
		BusinessData[bizid][bExitZ] = 1000.741943;
		BusinessData[bizid][bInterior] = 3;

		format(sgstr, sizeof(sgstr), "Business ID: %d - Description: Sex Shop", bizid);
	}
	else if(int == 21)
	{
		BusinessData[bizid][bExitX] = -2239.569824;
		BusinessData[bizid][bExitY] = 130.020996;
		BusinessData[bizid][bExitZ] = 1035.419922;
		BusinessData[bizid][bInterior] = 6;

		format(sgstr, sizeof(sgstr), "Business ID: %d - Description: Zero's RC Shop", bizid);
	}
	else if(int == 22)
	{
		BusinessData[bizid][bExitX] = 286.148987;
		BusinessData[bizid][bExitY] = -40.644398;
		BusinessData[bizid][bExitZ] = 1001.569946;
		BusinessData[bizid][bInterior] = 1;

		format(sgstr, sizeof(sgstr), "Business ID: %d - Description: Ammunation 1", bizid);
	}
	else if(int == 23)
	{
		BusinessData[bizid][bExitX] = 286.800995;
		BusinessData[bizid][bExitY] = -82.547600;
		BusinessData[bizid][bExitZ] = 1001.539978;
		BusinessData[bizid][bInterior] = 4;

		format(sgstr, sizeof(sgstr), "Business ID: %d - Description: Ammunation 2", bizid);
	}
	else if(int == 24)
	{
		BusinessData[bizid][bExitX] = 296.919983;
		BusinessData[bizid][bExitY] = -108.071999;
		BusinessData[bizid][bExitZ] = 1001.569946;
		BusinessData[bizid][bInterior] = 6;

		format(sgstr, sizeof(sgstr), "Business ID: %d - Description: Ammunation 3", bizid);
	}
	else if(int == 25)
	{
		BusinessData[bizid][bExitX] = 316.524994;
		BusinessData[bizid][bExitY] = -167.706985;
		BusinessData[bizid][bExitZ] = 999.661987;
		BusinessData[bizid][bInterior] = 6;

		format(sgstr, sizeof(sgstr), "Business ID: %d - Description: Ammunation 4", bizid);
	}
	else if(int == 26)
	{
		BusinessData[bizid][bExitX] = -2637.449951;
		BusinessData[bizid][bExitY] = 1404.629883;
		BusinessData[bizid][bExitZ] = 906.457947;
		BusinessData[bizid][bInterior] = 3;

		format(sgstr, sizeof(sgstr), "Business ID: %d - Description: Jizzys", bizid);
	}
	else if(int == 27)
	{
		BusinessData[bizid][bExitX] = -25.884499;
		BusinessData[bizid][bExitY] = -185.868988;
		BusinessData[bizid][bExitZ] = 1003.549988;
		BusinessData[bizid][bInterior] = 17;

		format(sgstr, sizeof(sgstr), "Business ID: %d - Description: 24-7 1", bizid);
	}
	else if(int == 28)
	{
		BusinessData[bizid][bExitX] = 6.091180;
		BusinessData[bizid][bExitY] = -29.271898;
		BusinessData[bizid][bExitZ] = 1003.549988;
		BusinessData[bizid][bInterior] = 10;

		format(sgstr, sizeof(sgstr), "Business ID: %d - Description: 24-7 2", bizid);
	}
	else if(int == 29)
	{
		BusinessData[bizid][bExitX] = -30.946699;
		BusinessData[bizid][bExitY] = -89.609596;
		BusinessData[bizid][bExitZ] = 1003.549988;
		BusinessData[bizid][bInterior] = 18;

		format(sgstr, sizeof(sgstr), "Business ID: %d - Description: 24-7 3", bizid);
	}
	else if(int == 30)
	{
		BusinessData[bizid][bExitX] = -25.132599;
		BusinessData[bizid][bExitY] = -139.066986;
		BusinessData[bizid][bExitZ] = 1003.549988;
		BusinessData[bizid][bInterior] = 16;

		format(sgstr, sizeof(sgstr), "Business ID: %d - Description: 24-7 4", bizid);
	}
	else if(int == 31)
	{
		BusinessData[bizid][bExitX] = -27.312300;
		BusinessData[bizid][bExitY] = -29.277599;
		BusinessData[bizid][bExitZ] = 1003.549988;
		BusinessData[bizid][bInterior] = 4;

		format(sgstr, sizeof(sgstr), "Business ID: %d - Description: 24-7 5", bizid);
	}
	else if(int == 32)
	{
		BusinessData[bizid][bExitX] = -26.691599;
		BusinessData[bizid][bExitY] = -55.714897;
		BusinessData[bizid][bExitZ] = 1003.549988;
		BusinessData[bizid][bInterior] = 6;

		format(sgstr, sizeof(sgstr), "Business ID: %d - Description: 24-7 6", bizid);
  	}
	else if(int == 33)
	{
		BusinessData[bizid][bExitX] = 1494.430053;
		BusinessData[bizid][bExitY] = 1305.63004;
		BusinessData[bizid][bExitZ] = 1093.290039;
		BusinessData[bizid][bInterior] = 3;

		format(sgstr, sizeof(sgstr), "Business ID: %d - Description: Advertising/Phone Network", bizid);
  	}
	else if(int == 34)
	{
		BusinessData[bizid][bExitX] = 965.1851;
		BusinessData[bizid][bExitY] = -53.2832;
		BusinessData[bizid][bExitZ] = 1001.1246;
		BusinessData[bizid][bInterior] = 3;

		format(sgstr, sizeof(sgstr), "Business ID: %d - Description: Bothel", bizid);
	}
	else if(int == 35)
	{
		BusinessData[bizid][bExitX] = 2018.0131;
		BusinessData[bizid][bExitY] = 1017.8541;
		BusinessData[bizid][bExitZ] = 996.8750;
		BusinessData[bizid][bInterior] = 10;

		format(sgstr, sizeof(sgstr), "Business ID: %d - Description: Four Dragons Casino", bizid);
	}
	else if(int == 36)
	{
		BusinessData[bizid][bExitX] = 617.5380;
		BusinessData[bizid][bExitY] = -1.9900;
		BusinessData[bizid][bExitZ] = 1000.6829;
		BusinessData[bizid][bInterior] = 1;

		format(sgstr, sizeof(sgstr), "Business ID: %d - Description: Bikers Garage", bizid);
	}
	else if(int == 37)
	{
		BusinessData[bizid][bExitX] = 772.112000;
		BusinessData[bizid][bExitY] = -3.898650;
		BusinessData[bizid][bExitZ] = 1000.687988;
		BusinessData[bizid][bInterior] = 5;

		format(sgstr, sizeof(sgstr), "Business ID: %d - Description: Ganton Gym", bizid);
	}
	else if(int == 38) // Tattoo 1
	{
		BusinessData[bizid][bExitX] = -204.439987;
		BusinessData[bizid][bExitY] = -8.469599;
		BusinessData[bizid][bExitZ] = 1002.273437;
		BusinessData[bizid][bInterior] = 17;

		format(sgstr, sizeof(sgstr), "Business ID: %d - Description: Tattoo 1", bizid);
	}
	else if(int == 39) // Tattoo 2
	{
		BusinessData[bizid][bExitX] = -204.439987;
		BusinessData[bizid][bExitY] = -43.652496;
		BusinessData[bizid][bExitZ] = 1002.273437;
		BusinessData[bizid][bInterior] = 3;

		format(sgstr, sizeof(sgstr), "Business ID: %d - Description: Tattoo 2", bizid);
	}
	else if(int == 40) // Tattoo 3
	{
		BusinessData[bizid][bExitX] = -204.439987;
		BusinessData[bizid][bExitY] = -26.453998;
		BusinessData[bizid][bExitZ] = 1002.273437;
		BusinessData[bizid][bInterior] = 12;

		format(sgstr, sizeof(sgstr), "Business ID: %d - Description: Tattoo 3", bizid);
	}
	else if(int == 41)
	{
		BusinessData[bizid][bExitX] = 318.564972;
		BusinessData[bizid][bExitY] = 1118.209961;
		BusinessData[bizid][bExitZ] = 1083.979980;
		BusinessData[bizid][bInterior] = 5;

		format(sgstr, sizeof(sgstr), "Business ID: %d - Description: Crack Den", bizid);
	}
	else if(int == 42)
	{
		BusinessData[bizid][bExitX] = -2240.468505;
		BusinessData[bizid][bExitY] = 137.060440;
		BusinessData[bizid][bExitZ] = 1035.414062;
		BusinessData[bizid][bInterior] = 6;

		format(sgstr, sizeof(sgstr), "Business ID: %d - Description: Zero RC shop", bizid);
	}
	else if(int == 43)
	{
		BusinessData[bizid][bExitX] = 245.2307;
		BusinessData[bizid][bExitY] = 304.7632;
		BusinessData[bizid][bExitZ] = 999.1484;
		BusinessData[bizid][bInterior] = 0;

		format(sgstr, sizeof(sgstr), "Business ID: %d - Description: Record Studio", bizid);
	}
	else if(int == 44)
	{
		BusinessData[bizid][bExitX] = 1506.24609375;
		BusinessData[bizid][bExitY] = -1815.40039062;
		BusinessData[bizid][bExitZ] = -43.72590637;
		BusinessData[bizid][bInterior] = 0;

		format(sgstr, sizeof(sgstr), "Business ID: %d - Description: LS Court Room", bizid);
	}
	else if(int == 45)
	{
		BusinessData[bizid][bExitX] = 963.418762;
		BusinessData[bizid][bExitY] = 2108.292480;
		BusinessData[bizid][bExitZ] = 1011.030273;
		BusinessData[bizid][bInterior] = 1;
		format(sgstr, sizeof(sgstr), "Business ID: %d - Description: Meat Factory", bizid);
	}
	else if(int == 46)
	{
		BusinessData[bizid][bExitX] = -2154.34155;
		BusinessData[bizid][bExitY] = 618.79169;
		BusinessData[bizid][bExitZ] = 1055.45166;
		BusinessData[bizid][bInterior] = 1;

		format(sgstr, sizeof(sgstr), "Business ID: %d - Description: Betting Place", bizid);
	}
	else if(int == 47)
	{
		BusinessData[bizid][bExitX] = 418.6547;
		BusinessData[bizid][bExitY] = -83.6987;
		BusinessData[bizid][bExitZ] = 1001.8047;
		BusinessData[bizid][bInterior] = 3;

		format(sgstr, sizeof(sgstr), "Business ID: %d - Description: Barber Shop", bizid);
	}
	else if(int == 48)
	{
		BusinessData[bizid][bExitX] = -2640.762939;
		BusinessData[bizid][bExitY] = 1406.682006;
		BusinessData[bizid][bExitZ] = 906.460937;
		BusinessData[bizid][bInterior] = 3;

		format(sgstr, sizeof(sgstr), "Business ID: %d - Description: Pleasure Domes", bizid);
	}

	Business_Save(bizid);

	SendClientMessage(playerid, COLOR_GRAD2, sgstr);
	return true;
}

/*CreateGuideMenus()
{
	Guide = CreateMenu("Los Santos Newspaper", 1, 50.0, 180.0, 300.0, 300.0);
	SetMenuColumnHeader(Guide, 0, "Citizen info");
	AddMenuItem(Guide, 0, "Next page");
	AddMenuItem(Guide, 0, "How to call taxi");
	AddMenuItem(Guide, 0, "Bus routes");
	AddMenuItem(Guide, 0, "Where to live");
	AddMenuItem(Guide, 0, "Medic help");
	AddMenuItem(Guide, 0, "Police help");
	AddMenuItem(Guide, 0, "OOC: Forum link");

	GuideJob1 = CreateMenu("Los Santos Newspaper", 1, 50.0, 180.0, 300.0, 300.0);
	SetMenuColumnHeader(GuideJob1, 0, "Employment and legal jobs");
	AddMenuItem(GuideJob1, 0, "Next page");
	AddMenuItem(GuideJob1, 0, "Detective");
	AddMenuItem(GuideJob1, 0, "Farmer");
	AddMenuItem(GuideJob1, 0, "Lawyer");
	AddMenuItem(GuideJob1, 0, "Pizza deliver");
	AddMenuItem(GuideJob1, 0, "Hot Dog Man");
	AddMenuItem(GuideJob1, 0, "IceCream Man");
	AddMenuItem(GuideJob1, 0, "Trashman");

	GuideJob2 = CreateMenu("Los Santos Newspaper", 1, 50.0, 180.0, 300.0, 300.0);
	SetMenuColumnHeader(GuideJob2, 0, "Employment and legal jobs");
	AddMenuItem(GuideJob2, 0, "Next page");
	AddMenuItem(GuideJob2, 0, "Courier");
	AddMenuItem(GuideJob2, 0, "Car mechanic");
	AddMenuItem(GuideJob2, 0, "Trucker");
	AddMenuItem(GuideJob2, 0, "Bartender");
	AddMenuItem(GuideJob2, 0, "Boxing career");
}*/

forward SetUnTazed(playerid);
public SetUnTazed(playerid)
{
	if(!IsTazed{playerid}) return true;

    ApplyAnimationEx(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0);

    IsTazed{playerid} = false;

	TogglePlayerControllable(playerid, true);
	return true;
}

public OnUnoccupiedVehicleUpdate(vehicleid, playerid, passenger_seat, Float:new_x, Float:new_y, Float:new_z, Float:vel_x, Float:vel_y, Float:vel_z)
{
    return true;
}

IsCharacterOnline(character) //Returns user ID
{
	foreach (new i : Player)
	{
		if(PlayerData[i][pID] == character)
		{
	    	return i;
	 	}
	}
	return -1;
}

IsPlayerFacingVehicle(playerid, vehicleid)
{
    if(!IsPlayerConnected(playerid)) return 0;

	new Float:pX, Float:pY, Float:pZ, Float:X, Float:Y, Float:Z, Float:ang;

	GetVehiclePos(vehicleid, X, Y, Z);
	GetPlayerPos(playerid, pX, pY, pZ);

	if( Y > pY ) ang = (-acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 90.0);
	else if( Y < pY && X < pX ) ang = (acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 450.0);
	else if( Y < pY ) ang = (acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 90.0);

	if(X > pX) ang = (floatabs(floatabs(ang) + 180.0));
	else ang = (floatabs(ang) - 180.0);

	new Float:sec_ang;
	GetPlayerFacingAngle(playerid, sec_ang);

	if(ang - sec_ang < -130 || ang - sec_ang > 130) return 0;
	else return 1;
}

forward ResprayTimer(playerid, vehicleid);
public ResprayTimer(playerid, vehicleid)
{
	if(GetPlayerWeapon(playerid) == 41 && Car_Nearest(playerid) == vehicleid && Firehold[playerid] == 1)
	{
		if(IsPlayerFacingVehicle(playerid, vehicleid))
		{
			Firetimer[playerid] = SetTimerEx("ResprayTimer", 1000, false, "ii", playerid, vehicleid);
		}
	}
	return true;
}

SetPlayerThrowMeal(playerid)
{
	if(MealHolding[playerid] != 0 && IsPlayerAttachedObjectSlotUsed(playerid, 9))
	{
	    MealHolding[playerid] = 0;
	    RemovePlayerAttachedObject(playerid, 9);
	    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	    return 1;
	}
	return 0;
}

IsHoldingMeal(playerid)
{
	if(MealHolding[playerid] != 0 && IsPlayerAttachedObjectSlotUsed(playerid, 9))
	{
	    return 1;
	}
	return 0;
}


GetPlayerNearMeal(playerid)
{
	if(MealObject[playerid] != -1 && IsPlayerInRangeOfPoint(playerid, 2.5, MealDrop[MealObject[playerid]][mX],MealDrop[MealObject[playerid]][mY],MealDrop[MealObject[playerid]][mZ]))
	{
		return true;
	}
	/*for(new i = 0; i != sizeof(MealDrop); ++i)
  	{
	    if(IsPlayerInRangeOfPoint(playerid, 2.5, MealDrop[i][mX],MealDrop[i][mY],MealDrop[i][mZ]))
	    {
			return i;
	    }
    }*/
    return false;
}

forward MealDestroy(mid);
public MealDestroy(mid)
{
	if(MealDrop[mid][mExist])
	{
		MealDrop[mid][mExist]=false;
      	MealDrop[mid][mX] = 0.0;
       	MealDrop[mid][mY] = 0.0;
       	MealDrop[mid][mZ] = 0.0;
     	MealDrop[mid][mID] = 0;
     	MealDrop[mid][mInt] = 0;
     	MealDrop[mid][mWorld] = 0;

	   	if(IsValidDynamicObject(MealDrop[mid][mObject])) DestroyDynamicObject(MealDrop[mid][mObject]);
		if(MealDrop[mid][mTimer]) KillTimer(MealDrop[mid][mTimer]);

		foreach (new i : Player)
		{
			if(MealObject[i] == mid)
			{
			    MealObject[i] = -1;
			    break;
			}
		}

     	return mid;
	}
  	return -1;
}

MealPlace(objectid, Float:x,Float:y,Float:z,Float:rx,Float:ry,Float:rz, int, world)
{
	for(new i = 0; i != sizeof(MealDrop); ++i)
  	{
  	    if(!MealDrop[i][mExist])
  	    {
            MealDrop[i][mExist] = true;
            MealDrop[i][mX] = x;
            MealDrop[i][mY] = y;
            MealDrop[i][mZ] = z;
            MealDrop[i][mID] = objectid;
            MealDrop[i][mInt] = int;
            MealDrop[i][mWorld] = world;
			MealDrop[i][mObject] = CreateDynamicObject(objectid,x,y,z,rx,ry,rz,world, int);
            MealDrop[i][mTimer] = SetTimerEx("MealDestroy", 600000, false, "d", i);
	        return i;
  	    }
  	}
  	return -1;
}

SetPlayerMealHold(playerid, mealobject)
{
	if(mealobject >= 2221 && mealobject <= 2223)
		SetPlayerAttachedObject(playerid, 9, mealobject, 5,0.165000,0.100999,0.139999,-78.300018,-11.500016,20.599998,1.000000,1.000000,1.000000);
	else
		SetPlayerAttachedObject(playerid, 9, mealobject, 5,0.212000,0.046999,0.371000,-106.700012,15.100011,2.399998,1.000000,1.000000,1.000000);
}

GetVehicleAttachCroods(vehicleid, Float:oPosX, Float:oPosY, Float:oPosZ, Float:oPosRZ, &Float:AttachX, &Float:AttachY, &Float:AttachZ, &Float:AttachRZ)
{
	new Float:Pos[3], Float:vPosX, Float:vPosY, Float:vPosZ, Float:vPosA;

	GetVehiclePos(vehicleid, vPosX, vPosY, vPosZ);
	GetVehicleZAngle(vehicleid, vPosA);

	Pos[0] = oPosX-vPosX;
	Pos[1] = oPosY-vPosY;
	Pos[2] = oPosZ-vPosZ;
	AttachRZ = oPosRZ-vPosA;

	AttachZ = Pos[2];
	AttachX = Pos[0]*floatcos(vPosA, degrees)+Pos[1]*floatsin(vPosA, degrees);
	AttachY = -Pos[0]*floatsin(vPosA, degrees)+Pos[1]*floatcos(vPosA, degrees);
	return true;
}

// XM Radio

ShowBoomBoxStations(playerid)
{
	new string[256];

	for(new i = 0; i != sizeof(xmGenres); ++i)
	{
		format(string, sizeof(string), "%s%s\n", string, xmGenres[i]);
	}

	format(string, sizeof(string), "%s{FFFF00}OFF - To turn off\n", string);
	Dialog_Show(playerid, xmGenresDialog, DIALOG_STYLE_LIST, "Genres:", string, "Select", "<<");
	return true;
}

/*StartMusicInVehicle(vehicle, url[])
{
	if(CoreVehicles[vehicle][vradioOn])
	{
		foreach(Player, i)
		{
			if(GetPlayerVehicleID(i) == vehicle)
			{
				StopAudioStreamForPlayer(i);
				PlayAudioStreamForPlayer(i, url);

                SendClientMessageEx(i, COLOR_DARKGREEN, "%s has tuned the radio to %s", ReturnName(playerid, 0), CoreVehicles[vehicle][vradioStation]);
				SendClientMessageEx(i, COLOR_LIGHTRED, "Radio changed to station %s", CoreVehicles[vehicle][vradioStation]);
			}
		}
	}
	return true;
}*/

StopCarBoomBox(carid)
{
	if(CoreVehicles[carid][vradioOn])
	{
		CoreVehicles[carid][vradioOn] = false;

		foreach (new i : Player)
		{
			if(GetPlayerVehicleID(i) == carid)
			{
				StopAudioStreamForPlayer(i);
                SendClientMessage(i, COLOR_LIGHTRED, "The radio is turned off.");
			}
		}
	}
	return true;
}

Dialog:xmGenresDialog(playerid, response, listitem, inputtext[])
{
	if(response)
	{
    	if(!strcmp(inputtext, "OFF - To turn off", true))
	 	{
	 	    new id = -1;

	 	    if(IsPlayerInAnyVehicle(playerid))
		 	{
			 	StopCarBoomBox(GetPlayerVehicleID(playerid));
			}
	 	    else if((id = Boombox_Nearest(playerid)) != INVALID_PLAYER_ID)
	 	    {
	 	        StopBoomBox(id);
	 	    }
		 	else
			{
				if(InProperty[playerid] != -1)
				{
				    StopHouseBoomBox(InProperty[playerid]);
				}

				if(InBusiness[playerid] != -1)
				{
				    StopBizzBoomBox(InBusiness[playerid]);
				}				
			}

	 	    return 1;
	   	}

	    new category = listitem;

		SetPVarInt(playerid, "GenresSelected", category);

		new string[256];

		for(new i = 0; i != sizeof(xmSubGenres); ++i)
		{
		    if(xmSubGenres[i][xmid] == category)
			{
				format(string, sizeof(string), "%s%s\n", string, xmSubGenres[i][subname]);
			}
		}

		format(string, sizeof(string), "%s{FFFF00}OFF - To turn off\n", string);
		Dialog_Show(playerid, xmSubGenresDialog, DIALOG_STYLE_LIST, "SubGenres:", string, "Select", "<<");
	}
	return true;
}

Dialog:xmSubGenresDialog(playerid, response, listitem, inputtext[])
{
	if(response)
	{
    	if(!strcmp(inputtext, "OFF - To turn off", true))
	 	{
	 	    new id = -1;

	 	    if(IsPlayerInAnyVehicle(playerid))
		 	{
			 	StopCarBoomBox(GetPlayerVehicleID(playerid));
			}
	 	    else if((id = Boombox_Nearest(playerid)) != INVALID_PLAYER_ID)
	 	    {
	 	        StopBoomBox(id);
	 	    }
		 	else
			{
				if(InProperty[playerid] != -1)
				{
				    StopHouseBoomBox(InProperty[playerid]);
				}

				if(InBusiness[playerid] != -1)
				{
				    StopBizzBoomBox(InBusiness[playerid]);
				}				
			}
	 	    return 1;
	   	}

		new category = GetPVarInt(playerid, "GenresSelected"), count;

		for(new i = 0; i != sizeof(xmSubGenres); ++i)
		{
		    if(xmSubGenres[i][xmid] == category)
			{
				if(listitem == count)
				{
					SetPVarInt(playerid, "SubGenresIndex", i);
					break;
				}
				count++;
			}
		}

		SetPVarInt(playerid, "SubGenresSelected", listitem);

	    new xmstation, query[128];
		mysql_format(dbCon, query, sizeof(query), "SELECT `id`, `station_name` FROM `radio_station` WHERE `genres_id` = %d AND `subgenres_id` = %d", category, listitem);
		new Cache:cache = mysql_query(dbCon, query);

		xmstation = cache_num_rows();

		gstr[0] = EOS;

		if(xmstation)
		{
		    new id, name[32];

			for(new i = 0; i < xmstation; ++i)
			{
			    cache_get_value_name_int(i, "id", id);
				cache_get_value_name(i, "station_name", name);

			    format(gstr, sizeof(gstr), "%sID:%d - %s\n", gstr, id, name);
			}
		}

		cache_delete(cache);

		format(gstr, sizeof(gstr), "%s{FFFF00}OFF - To turn off\n", gstr);
		Dialog_Show(playerid, xmSetStationDialog, DIALOG_STYLE_LIST, "Stations:", gstr, "Select", "<<");
	}
	else
	{
		ShowBoomBoxStations(playerid);
		DeletePVar(playerid, "GenresSelected");
	}
	return true;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch (dialogid)
	{
		case DIALOG_CONFIRM_SYS:
		{
			ConfirmDialog_Response(playerid, response);
			return true;
		}

	    //mdc
		case DIALOG_MDC_NAME:
		{
			if(response)
			{
				if(strlen(inputtext) < 3 || strlen(inputtext) > MAX_PLAYER_NAME)
					return ShowPlayerDialog(playerid, DIALOG_MDC_NAME, DIALOG_STYLE_INPUT, "Insert data", "Who are you looking for?", "Search", "Close");

				for(new i = 0; i < strlen(inputtext); ++i)
				{
					if(inputtext[i] == ' ')
					{
						inputtext[i] = '_';
					}
				}

                format(e_Player_MDC_Cache[playerid][player_name], 32, "%s", inputtext);

				PlayerTextDrawSetString(playerid, MDC_UI[playerid][21], inputtext);
				PlayerTextDrawShow(playerid, MDC_UI[playerid][21]);

				for(new i = 0; i < 41; ++i)
				{
				    if(i > 22 && i < 39)
				    {
				        PlayerTextDrawHide(playerid, MDC_UI[playerid][i]);
				    }

                    if(e_Player_MDC_Cache[playerid][current_page] == 4)
                    {
					    if(i < 41)
					    {
					        PlayerTextDrawDestroy(playerid, MDC_ChargesUI[playerid][i]);
					    }
					}

                    if(e_Player_MDC_Cache[playerid][current_page] == 4)
                    {
					    if(i < 37)
					    {
							PlayerTextDrawDestroy(playerid, MDC_LicensesUI[playerid][i]);
					    }
					}

					if(e_Player_MDC_Cache[playerid][current_page] == 5)
					{
					    if(i < 40)
					    {
					        PlayerTextDrawDestroy(playerid, MDC_PenalCodeUI[playerid][i]);
					    }
					}

					if(e_Player_MDC_Cache[playerid][current_page] == 6)
					{
					    if(i < 20)
					    {
					        PlayerTextDrawDestroy(playerid, MDC_PropertiesUI[playerid][i]);
					    }
					}

				    if(i < 4)
				    {
				        PlayerTextDrawHide(playerid, MDC_VehicleUI[playerid][i]);
				    }
				}

				DeletePVar(playerid, "MDC_ViewingVehicle");

                MDC_OnRecordSearch(playerid);
				return true;
			}
			else return true;
		}
		case DIALOG_MDC_PLATE:
		{
			if(response)
			{
				new
			 		vehicleid = INVALID_VEHICLE_ID;

			 	if(GetPVarInt(playerid, "MDC_ViewingVehicle"))
			 	{
				    for(new i = 0; i < sizeof(MDC_VehicleUI[]); ++i)
						PlayerTextDrawHide(playerid, MDC_VehicleUI[playerid][i]);

					e_Player_MDC_Cache[playerid][vehicle_dbid] = -1;

					DeletePVar(playerid, "MDC_ViewingVehicle");
				}

				if(GetPVarInt(playerid, "MDC_ViewingProfile"))
				{
					for(new i = 23; i < sizeof(MDC_UI[]); ++i)
						PlayerTextDrawHide(playerid, MDC_UI[playerid][i]);

					e_Player_MDC_Cache[playerid][current_page] = 0;

					DeletePVar(playerid, "MDC_ViewingProfile");
				}

				if(strfind(inputtext, "id:", false) != -1)
				{
			 		new type[16], str[64];
					strmid(type, inputtext, 3, strlen(inputtext));
					vehicleid = strval(type);

					format(str, sizeof(str), "id:%d", vehicleid);
					PlayerTextDrawSetString(playerid, MDC_UI[playerid][21], str);
					PlayerTextDrawShow(playerid, MDC_UI[playerid][21]);

					new carid = Car_GetID(vehicleid);

					if(!IsValidVehicle(vehicleid) || carid == -1)
						return PlayerTextDrawShow(playerid, MDC_VehicleUI[playerid][3]);

					//return ShowPlayerDialog(playerid, DIALOG_MDC_PLATE, DIALOG_STYLE_INPUT, "Insert data", "What plate are you looking for?\n\nFor plate, enter the plate number.\nFor vehicle ID, enter 'id:IDHERE', e.g. 'id:420'", "Search", "Close");

					PlayerTextDrawHide(playerid, MDC_VehicleUI[playerid][3]);

					e_Player_MDC_Cache[playerid][vehicle_id] = vehicleid;
					e_Player_MDC_Cache[playerid][vehicle_dbid] = CarData[carid][carID];

					return MDC_GatherInformation(playerid, e_Player_MDC_Cache[playerid][vehicle_dbid], 2);
				}
				else
				{
					if(strlen(inputtext) < 3)
						return ShowPlayerDialog(playerid, DIALOG_MDC_PLATE, DIALOG_STYLE_INPUT, "Insert data", "What plate are you looking for?\n\nFor plate, enter the plate number.\nFor vehicle ID, enter 'id:IDHERE', e.g. 'id:420'", "Search", "Close");

                    format(e_Player_MDC_Cache[playerid][vehicle_plate], MAX_PLAYER_NAME, "%s", inputtext);

 					PlayerTextDrawSetString(playerid, MDC_UI[playerid][21], inputtext);
					PlayerTextDrawShow(playerid, MDC_UI[playerid][21]);
					PlayerTextDrawHide(playerid, MDC_VehicleUI[playerid][3]);

					return MDC_GatherInformation(playerid, -1, 3);
				}
			}
			else return true;
		}
		case DIALOG_MDC_CALLSIGN:
		{
		    if(response)
			{
				//cmd_callsign(playerid, inputtext);

				return UpdatePlayerMDC(playerid, 3, -1);
			}
		}
		case DIALOG_FILTER_CHARGES:
		{
		    if(!response) return true;

		    if(!strlen(inputtext))
			{
				PlayerTextDrawColor(playerid, MDC_PenalCodeUI[playerid][21], -1431655681);
				PlayerTextDrawSetString(playerid, MDC_PenalCodeUI[playerid][21], "filter charges ...");
				PlayerTextDrawShow(playerid, MDC_PenalCodeUI[playerid][21]);

			    FilterCharges[playerid][0] = EOS;
				return ShowPenalCodeUI(playerid, false, true);
			}

			PlayerTextDrawColor(playerid, MDC_PenalCodeUI[playerid][21], COLOR_BLACK);
			PlayerTextDrawSetString(playerid, MDC_PenalCodeUI[playerid][21], inputtext);
			PlayerTextDrawShow(playerid, MDC_PenalCodeUI[playerid][21]);

			format(FilterCharges[playerid], 128, inputtext);

		    MDCFilterCharges(playerid, inputtext);
		    return true;
		}
	}
	return false;
}

Dialog:xmSetStationDialog(playerid, response, listitem, inputtext[])
{
	if(response)
	{
    	if(!strcmp(inputtext, "OFF - To turn off", true))
	 	{
	 	    new id = -1;

	 	    if(IsPlayerInAnyVehicle(playerid)) StopCarBoomBox(GetPlayerVehicleID(playerid));
	 	    else if((id = Boombox_Nearest(playerid)) != INVALID_PLAYER_ID)
	 	    {
	 	        StopBoomBox(id);
	 	    }
		 	else
			 {
				if(InProperty[playerid] != -1)
				{
				    StopHouseBoomBox(InProperty[playerid]);
				}

				if(InBusiness[playerid] != -1)
				{
				    StopBizzBoomBox(InBusiness[playerid]);
				}				
			}
	 	    return 1;
	   	}

	    new genres = GetPVarInt(playerid, "GenresSelected"), subgenres = GetPVarInt(playerid, "SubGenresSelected");

	    new xmstation, query[128], count;
		mysql_format(dbCon, query, sizeof(query), "SELECT * FROM `radio_station` WHERE `genres_id` = %d AND `subgenres_id` = %d", genres, subgenres);
		new Cache:cache = mysql_query(dbCon, query);

		xmstation = cache_num_rows();

		gstr[0] = EOS;

		if(xmstation)
		{
		    new id, name[32], url[256];

			for(new i = 0; i < xmstation; ++i)
			{
			    cache_get_value_name_int(i, "id", id);
				cache_get_value_name(i, "station_name", name);
				cache_get_value_name(i, "station_url", url);

			    if(count == listitem)
			    {
			        new boomboxid = -1;

			        if(IsPlayerInAnyVehicle(playerid))
			        {
			            new vehicleid = GetPlayerVehicleID(playerid);

				        CoreVehicles[vehicleid][vradioOn] = true;

				        format(CoreVehicles[vehicleid][vradioURL], 256, "%s", url);

						foreach (new x : Player)
						{
							if(GetPlayerVehicleID(x) == vehicleid)
							{
								StopAudioStreamForPlayer(x);
								PlayAudioStreamForPlayer(x, url);

								SendClientMessageEx(x, COLOR_LIGHTRED, "Radio changed to station %s", name);
							}
						}

						format(query, sizeof(query), "%s has tuned the radio to %s", ReturnName(playerid, 0), name);
					 	SetPlayerChatBubble(playerid, query, COLOR_DARKGREEN, 20.0, 6000);

					}
					else if((boomboxid = Boombox_Nearest(playerid)) != INVALID_PLAYER_ID)
					{
						if(grantboombox[playerid] == boomboxid || boomboxid == playerid)
						{
	                        BoomboxData[boomboxid][boomboxOn]=true;
							strpack(BoomboxData[boomboxid][boomboxURL], url, 128 char);

							SendNearbyMessage(playerid, 30.0, COLOR_DARKGREEN, "%s has tuned the radio to %s", ReturnName(playerid, 0), name);

	                        foreach (new x : Player)
							{
								if(Boombox_Nearest(x) == boomboxid)
								{
									StopAudioStreamForPlayer(x);
									PlayAudioStreamForPlayer(x, url, BoomboxData[boomboxid][boomboxPos][0], BoomboxData[boomboxid][boomboxPos][1], BoomboxData[boomboxid][boomboxPos][2], 30, 1);
									SendClientMessageEx(x, COLOR_LIGHTRED, "Radio changed to station %s", name);
								}
							}

							format(query, sizeof(query), "%s has tuned the radio to %s", ReturnName(playerid, 0), name);
							SetPlayerChatBubble(playerid, query, COLOR_DARKGREEN, 20.0, 6000);
						}
						else SendClientMessage(playerid, COLOR_LIGHTRED, "You do not receive a allowed to change the channel Boombox");
					}
			        else
			        {
			            new house = InProperty[playerid];

						if(house != -1)
						{
					        PropertyData[house][hradioOn] = true;
					        format(PropertyData[house][hradioURL], 256, "%s", url);

					        SendNearbyMessage(playerid, 30.0, COLOR_DARKGREEN, "%s has tuned the radio to %s", ReturnName(playerid, 0), name);

                            foreach (new x : Player)
							{
								if(InProperty[x] == house)
								{
									StopAudioStreamForPlayer(x);
									PlayAudioStreamForPlayer(x, url);
									SendClientMessageEx(x, COLOR_LIGHTRED, "Radio changed to station %s", name);
								}
							}

							format(query, sizeof(query), "%s has tuned the radio to %s", ReturnName(playerid, 0), name);
						 	SetPlayerChatBubble(playerid, query, COLOR_DARKGREEN, 20.0, 6000);
						}

						house = InBusiness[playerid];

						if(house != -1)
						{
					        BusinessData[house][bradioOn] = true;
					        format(BusinessData[house][bradioURL], 256, "%s", url);

					        SendNearbyMessage(playerid, 30.0, COLOR_DARKGREEN, "%s has tuned the radio to %s", ReturnName(playerid, 0), name);

                            foreach (new x : Player)
							{
								if(InBusiness[x] == house)
								{
									StopAudioStreamForPlayer(x);
									PlayAudioStreamForPlayer(x, url);
									SendClientMessageEx(x, COLOR_LIGHTRED, "Radio changed to station %s", name);
								}
							}

							format(query, sizeof(query), "%s has tuned the radio to %s", ReturnName(playerid, 0), name);
						 	SetPlayerChatBubble(playerid, query, COLOR_DARKGREEN, 20.0, 6000);
						}
			        }
			    }

			    format(gstr, sizeof(gstr), "%sID:%d - %s\n", gstr, id, name);

			    count++;
			}
		}

		cache_delete(cache);

		format(gstr, sizeof(gstr), "%s{FFFF00}OFF - To turn off\n", gstr);
		Dialog_Show(playerid, xmSetStationDialog, DIALOG_STYLE_LIST, "Stations:", gstr, "Select", "<<");
	}
	else
	{
	    new category = GetPVarInt(playerid, "GenresSelected"), string[256];

		for(new i = 0; i != sizeof(xmSubGenres); ++i)
		{
		    if(xmSubGenres[i][xmid] == category)
			{
				format(string, sizeof(string), "%s%s\n", string, xmSubGenres[i][subname]);
			}
		}

		format(string, sizeof(string), "%s{FFFF00}OFF - To turn off\n", string);
		Dialog_Show(playerid, xmSubGenresDialog, DIALOG_STYLE_LIST, "SubGenres:", string, "Select", "<<");
	}
	return true;
}

Boombox_Place(playerid)
{
	new
	    Float:angle;

	GetPlayerFacingAngle(playerid, angle);
	strpack(BoomboxData[playerid][boomboxURL], "", 128 char);
	GetPlayerPos(playerid, BoomboxData[playerid][boomboxPos][0], BoomboxData[playerid][boomboxPos][1], BoomboxData[playerid][boomboxPos][2]);
	BoomboxData[playerid][boomboxPlaced] = true;
    BoomboxData[playerid][boomboxObject] = CreateDynamicObject(2226, BoomboxData[playerid][boomboxPos][0], BoomboxData[playerid][boomboxPos][1], BoomboxData[playerid][boomboxPos][2] - 0.9, 0.0, 0.0, angle, 0, 0);
	return true;
}

Boombox_Nearest(playerid, Float:dist = 30.0)
{
	foreach (new i : Player)
	{
		if(BoomboxData[i][boomboxPlaced] && GetPlayerInterior(playerid) == 0 && GetPlayerVirtualWorld(playerid) == 0 && IsPlayerInRangeOfPoint(playerid, dist, BoomboxData[i][boomboxPos][0], BoomboxData[i][boomboxPos][1], BoomboxData[i][boomboxPos][2]))
		{
     		return i;
		}
	}
	return INVALID_PLAYER_ID;
}

Boombox_Destroy(playerid)
{
	if(BoomboxData[playerid][boomboxPlaced])
	{
		if(IsValidDynamicObject(BoomboxData[playerid][boomboxObject]))
		    DestroyDynamicObject(BoomboxData[playerid][boomboxObject]);

		foreach (new i : Player)
		{
			if(Boombox_Nearest(i) == playerid)
			{
		    	StopAudioStreamForPlayer(i);
			}
		}

        BoomboxData[playerid][boomboxPlaced] = false;
        BoomboxData[playerid][boomboxOn] = false;
	}
	return true;
}

new CachedIDS[MAX_PLAYERS][MAX_PLAYERS][2];

Dialog:Roadblock(playerid, response, listitem)
{
	if(!response) return true;

	if(response)
	{
	    switch(listitem)
	    {
	        case 0:
	        {
	            new string[256];

				for(new i = 0; i < sizeof(Road_Blocks); ++i)
				{
				    format(string, sizeof(string), "%s%s\n", string, Road_Blocks[i][rbName]);
				}

				Dialog_Show(playerid, Roadblock_Deply, DIALOG_STYLE_LIST, "Roadblock > Deploy", string, "Pick", "Back");
			}
			case 1: ViewActiveRoadblocks(playerid);
		}
	}
	return true;
}

ViewActiveRoadblocks(playerid)
{
	new count = 0;

	gstr[0] = EOS;

	foreach (new i : Player)
	{
		if(GetFactionType(i) != FACTION_POLICE && GetFactionType(i) != FACTION_SHERIFF) continue;

		for(new rb = 0; rb < 10; ++rb)
		{
			if(RoadBlocks[i][rb][roadblockObject] == INVALID_OBJECT_ID) continue;

			if(isnull(RoadBlocks[i][rb][roadblockNote]))
				format(gstr, sizeof(gstr), "%s{FFFFFF}%s {AFAFAF}[%s - N/A - %s]\n", gstr, Road_Blocks[ RoadBlocks[i][rb][roadblockID] ][rbName], ReturnName(i), RoadBlocks[i][rb][roadblockLocation]);
			else
				format(gstr, sizeof(gstr), "%s{FFFFFF}%s {AFAFAF}[%s - %s - %s]\n", gstr, Road_Blocks[ RoadBlocks[i][rb][roadblockID] ][rbName], ReturnName(i), RoadBlocks[i][rb][roadblockNote], RoadBlocks[i][rb][roadblockLocation]);

			CachedIDS[playerid][count][0] = i;
			CachedIDS[playerid][count][1] = rb;

			count++;
		}
	}

	if(!count) return SendClientMessage(playerid, COLOR_LIGHTRED, "No active roadblocks.");

	Dialog_Show(playerid, Roadblock_List, DIALOG_STYLE_LIST, "Roadblock > List", gstr, "Disband", "Back");
	return true;
}

Dialog:Roadblock_Deply(playerid, response, listitem)
{
	//if(!response) return cmd_roadblock(playerid, "");

	if(response)
	{
	    SetPVarInt(playerid, "RoadblockID", listitem);

	    new string[256];
	    format(string, sizeof(string), "{A9C4E4}You are about to deploy a {7e98b6}%s{A9C4E4}.\n{FFFFFF}Would you like to add a comment, like, the street or incident? (Optional)", Road_Blocks[listitem][rbName]);
        Dialog_Show(playerid, Roadblock_Deploy_Comment, DIALOG_STYLE_INPUT, "Enter a comment or leave blank to deploy:", string, "Deploy", "<< Back");
	}
	return true;
}

Dialog:Roadblock_Deploy_Comment(playerid, response, listitem, inputtext[])
{
	if(!response)
	{
        DeletePVar(playerid, "RoadblockID");

		//return cmd_roadblock(playerid, "");
	}

	if(response)
	{
	    new id = GetPVarInt(playerid, "RoadblockID");

	    DeletePVar(playerid, "RoadblockID");

        DeployRoadblock(playerid, id, inputtext);
	}
	return true;
}

DisbandRoadblockDialog(playerid, userid, rb, listitem = -1)
{
	new str[256];

	format(str, sizeof(str), "{8D8DFF}%s (%s) {FFFFFF}deployed this {8D8DFF}%s {FFFFFF}at {8D8DFF}%s{FFFFFF}.\n\nAre you sure you want to disband it?", ReturnName(userid), Faction_GetAbbreviation(userid), Road_Blocks[ RoadBlocks[userid][rb][roadblockID] ][rbName], RoadBlocks[userid][rb][roadblockDate]);

	if(listitem == -1)
	{
	    CachedIDS[playerid][0][0] = userid;
	    CachedIDS[playerid][0][1] = rb;

		listitem = 0;
	}

	SetPVarInt(playerid, "RoadblockID", listitem);

	Dialog_Show(playerid, Roadblock_Disband, DIALOG_STYLE_MSGBOX, "Confirmation - Disband roadblock", str, "Yes", "No");
}

Dialog:Roadblock_List(playerid, response, listitem)
{
	//if(!response) return cmd_roadblock(playerid, "");

	if(response)
	{
        new
			userid = CachedIDS[playerid][listitem][0],
        	rb = CachedIDS[playerid][listitem][1]
        ;

        DisbandRoadblockDialog(playerid, userid, rb, listitem);
	}
	return true;
}

Dialog:Roadblock_Disband(playerid, response, listitem)
{
	if(!response)
	{
        DeletePVar(playerid, "RoadblockID");

		//return cmd_roadblock(playerid, "");
	}

	if(response)
	{
        new
			id = GetPVarInt(playerid, "RoadblockID"),
			userid = CachedIDS[playerid][id][0],
        	rb = CachedIDS[playerid][id][1]
        ;

        DeletePVar(playerid, "RoadblockID");

	    DisbandRoadblock(userid, rb);
	    ViewActiveRoadblocks(playerid);
	}
	return true;
}

DisbandRoadblock(playerid, id)
{
	if(IsValidDynamicArea(RoadBlocks[playerid][id][roadblockArea])) DestroyDynamicArea(RoadBlocks[playerid][id][roadblockArea]);
	DestroyDynamicObject(RoadBlocks[playerid][id][roadblockObject]);
	RoadBlocks[playerid][id][roadblockObject] = INVALID_OBJECT_ID;
	RoadBlocks[playerid][id][roadblockNote][0] = EOS;
	RoadBlocks[playerid][id][roadblockLocation][0] = EOS;
	RoadBlocks[playerid][id][roadblockDate][0] = EOS;
}

DeployRoadblock(playerid, rb, const note[])
{
	new idx = -1;

    for(new i = 0; i < 10; ++i)
    {
		if(RoadBlocks[playerid][i][roadblockObject] == INVALID_OBJECT_ID)
		{
		    idx = i;
		    break;
		}
    }

    if(idx == -1) return SendClientMessage(playerid, COLOR_LIGHTRED, "Roadblock limit exceeded.");

  	new Float:x, Float:y, Float:z, Float:angle, date[6];

	getdate(date[2], date[1], date[0]);
	gettime(date[3], date[4], date[5]);

	GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, angle);

    RoadBlocks[playerid][idx][roadblockID] = rb;
    format(RoadBlocks[playerid][idx][roadblockNote], 24, note);
    Get2DZone(x, y, RoadBlocks[playerid][idx][roadblockLocation], MAX_ZONE_NAME);
    format(RoadBlocks[playerid][idx][roadblockDate], 60, "%d-%d-%d %02d:%02d", date[0], date[1], date[2], date[3], date[4]);
	RoadBlocks[playerid][idx][roadblockObject] = CreateDynamicObject(Road_Blocks[rb][rbObjectID], x, y + 2, z, 0.0, 0.0, angle + 180);
	EditDynamicObject(playerid, RoadBlocks[playerid][idx][roadblockObject]);
	SetPVarInt(playerid, "EditingRB", idx + 1);

	SendNoticeMessage(playerid, "Soft-deployed a{FF6347} %s{FFFFFF}. This is only visible to you until you adjust it.", Road_Blocks[ RoadBlocks[playerid][idx][roadblockID] ][rbName]);
	return true;
}

/*CountVehicleTickets(owner[])
{
	new name[MAX_PLAYER_NAME + 1];
	format(name, MAX_PLAYER_NAME, "%s", owner);
	for(new i = 0, len = strlen(name); i < len; ++i) if(name[i] == '_') name[i] = ' ';

	new checkQuery[128], count;

	mysql_format(dbCon, checkQuery, sizeof(checkQuery), "SELECT * FROM `fines` WHERE `addressee` = '%s' AND `type` = 1", name);
	new Cache:cache = mysql_query(dbCon, checkQuery);

	count = cache_num_rows();

	cache_delete(cache);
	return count;
}

CountPlayerTickets(playerid)
{
	new checkQuery[128], count;

	mysql_format(dbCon, checkQuery, sizeof(checkQuery), "SELECT * FROM `fines` WHERE `addressee` = '%s' AND `type` = 0", ReturnNameEx(playerid));
	new Cache:cache = mysql_query(dbCon, checkQuery);

	count = cache_num_rows();

	cache_delete(cache);
	return count;
}

CountTickets(playerid)
{
	new checkQuery[128], count;

	mysql_format(dbCon, checkQuery, sizeof(checkQuery), "SELECT * FROM `fines` WHERE `addressee` = '%s'", ReturnNameEx(playerid));
	new Cache:cache = mysql_query(dbCon, checkQuery);

	count = cache_num_rows();

	cache_delete(cache);
	return count;
}

CountTicketsByName(owner[])
{
	new name[MAX_PLAYER_NAME + 1];
	format(name, MAX_PLAYER_NAME, "%s", owner);
	for(new i = 0, len = strlen(name); i < len; ++i) if(name[i] == '_') name[i] = ' ';

	new checkQuery[128], count;

	mysql_format(dbCon, checkQuery, sizeof(checkQuery), "SELECT * FROM `fines` WHERE `addressee` = '%s'", name);
	new Cache:cache = mysql_query(dbCon, checkQuery);

	count = cache_num_rows();

	cache_delete(cache);
	return count;
}

FindVehicleByPlate(plate[])
{
	foreach (new i : sv_playercar) if(!strcmp(plate, CarData[i][carPlate], true)) return i;
	return -1;
}

AddCriminalRecord(playerid, szCharge[], iOfficer)
{
	if(strlen(szCharge) < 5)
	{
		SendClientMessage(iOfficer, COLOR_LIGHTRED, "You must enter more than 5 characters.");
		return 0;
	}
	else
	{
		format(gquery, sizeof(gquery), "INSERT INTO `criminal_record` (userid, charge, date, officer) VALUES(%d, '%s', '%s', %d)", PlayerData[playerid][pID], szCharge, ReturnDate(), PlayerData[iOfficer][pID]);
		mysql_pquery(dbCon, gquery);
		return true;
	}
}*/

WriteArrestRecord(playerid, userid, playerc = INVALID_PLAYER_ID)
{
	if(playerc != INVALID_PLAYER_ID)
	{
	    WritingArrest[playerc] = INVALID_PLAYER_ID;
	    ShowPlayerDialog(playerc, -1, DIALOG_STYLE_MSGBOX, " ", " ", " ", " ");
	}

	SetPVarString(playerid, "ArrestRecord", "");
	WritingArrest[playerid] = userid;

	SendClientMessageEx(playerid, COLOR_WHITE, "{FF0000}WARNING!{FFFFFF} You are now writing the ARREST RECORD of %s. Ensure to be THOROUGH AND DETAILED.", ReturnName(userid));
	SendClientMessage(playerid, COLOR_WHITE, "Who ordered the arrest: Was this arrest ordered or detailed by another officer, or yourself?");
	SendClientMessage(playerid, COLOR_WHITE, "Narrative: Detailing the events that led to an arrest. Eg, you were on patrol in East LS and saw the suspect assault a v");
	SendClientMessage(playerid, COLOR_WHITE, "ictim.");
	SendClientMessage(playerid, COLOR_WHITE, "Evidence: List the evidence used for the arrest. This includes dashcam or officer testimony. Use asteriks (*) for footag");
	SendClientMessage(playerid, COLOR_WHITE, "e e.g. *CCTV shows the male brandish a blade.*");
	SendClientMessage(playerid, COLOR_WHITE, "List of officers involved: List the names or badge numbers of each officer involved in the arrest e.g. John Random, Bill");
	SendClientMessage(playerid, COLOR_WHITE, "Johns.");
	SendClientMessage(playerid, COLOR_WHITE, "{FF0000}IMPORTANT! IMPORTANT!{FFFFFF} Be as detailed as possible. When you are finished, type \"{33AA33}done{FFFFFF}\" on");
	SendClientMessage(playerid, COLOR_WHITE, "a new line without the quotation. You can use as many lines as you need (be reasonable.)");

	Dialog_Show(playerid, Arrest_Record, DIALOG_STYLE_INPUT, "Arrest Record", "Your arrest record will appear here once you start writing.", "Send", "Abort");
	return true;
}

Dialog:Arrest_Record(playerid, response, listitem, inputtext[])
{
	if(!response || strcmp("abort", inputtext, true) == 0)
	{
		DeletePVar(playerid, "ArrestRecord");
	    WritingArrest[playerid] = INVALID_PLAYER_ID;
	    return true;
	}

	new userid = WritingArrest[playerid];

	if(!IsPlayerConnected(userid))
	{
		SendClientMessage(playerid, COLOR_LIGHTRED, "Seems that player disconnected midway your writing...");
		SendClientMessage(playerid, COLOR_LIGHTRED, "Your arrest record was saved if they return.");
		return true;
	}

	new astring[2000 + 350];

	if(strcmp("done", inputtext, true) == 0)
	{
		GetPVarString(playerid, "ArrestRecord", astring, sizeof(astring));
	 	format(astring, sizeof(astring), string_replace("\n", " ", astring));
		DeletePVar(playerid, "ArrestRecord");

		SetPVarString(userid, "ArrestRecord", astring);

		WritingArrest[playerid] = INVALID_PLAYER_ID;

		SendClientMessageEx(playerid, COLOR_WHITE, " -> Finished writing arrest record of %s", ReturnName(userid, 0));
		return true;
	}

	GetPVarString(playerid, "ArrestRecord", astring, sizeof(astring));

	if(strlen(inputtext) < 2)
	{
	    SendClientMessage(playerid, COLOR_LIGHTRED, "You can produce more than two characters on each line.");
		return Dialog_Show(playerid, Arrest_Record, DIALOG_STYLE_INPUT, "Arrest Record", astring, "Send", "Abort");
	}

	if((strlen(astring) + strlen(inputtext)) > 2000)
	{
		SendClientMessage(playerid, COLOR_LIGHTRED, "Warning: {FFFFFF}Text is too long");
		return Dialog_Show(playerid, Arrest_Record, DIALOG_STYLE_INPUT, "Arrest Record", astring, "Send", "Abort");
	}

	format(astring, sizeof(astring), "%s\n%s", astring, inputtext);
	SetPVarString(playerid, "ArrestRecord", astring);
	format(astring, sizeof(astring), "{FFFFFF}ArrestRecord of %s.\nWrite {FF0000}abort{FFFFFF} to abort writing, {33AA33}done{FFFFFF} once you are finished.\n\n%s", ReturnName(userid, 0), astring);

	Dialog_Show(playerid, Arrest_Record, DIALOG_STYLE_INPUT, "Arrest Record", astring, "Send", "Abort");
	return true;
}

/*PlaceVehicleFine(carid, copid, price, reason[])
{
	new query[512], clean_reason[64], name[MAX_PLAYER_NAME + 1];

	//new exp = gettime() + 259200;

	mysql_escape_string(reason, clean_reason);

	format(name, MAX_PLAYER_NAME, "%s", CarData[carid][carOwnerName]);

	for(new i = 0, len = strlen(name); i < len; ++i)
	{
		if(name[i] == '_')
		{
			name[i] = ' ';
		}
	}

	format(query, sizeof(query), "INSERT INTO `fines` (`cop`, `addressee`, `agency`, `price`, `reason`, `type`) VALUES ('%s', '%s', '%s', '%d', '%s', '%d')", ReturnNameEx(copid), name, Faction_GetName(copid), price, clean_reason, CarData[carid][carID]);
	mysql_pquery(dbCon, query);
	return true;
}*/

/*ViewVehicleFine(playerid, targetid)
{
	format(gquery, sizeof(gquery), "SELECT * FROM `fines` WHERE `addressee` = '%s' AND `type` != 0", ReturnNameEx(targetid));
	mysql_tquery(dbCon, gquery, "ShowVehicleFines", "dd", playerid, targetid);
	return true;
}*/

FUNX::ShowVehicleFines(playerid, targetid)
{
	if(cache_num_rows())
	{
		new
			rows,
			fineid,
			fineprice,
			finereason[64],
			menu[10]
		;

		cache_get_row_count(rows);

		for(new i = 0; i < rows; ++i)
		{
			cache_get_value_index_int(i, 0, fineid);
			cache_get_value_index_int(i, 5, fineprice);
			cache_get_value_index(i, 6, finereason);

			format(gstr, sizeof(gstr), "%s{FFFFFF}Fine #%03d [{7E98B6}$%d{FFFFFF}] Reason '%s'\n", gstr, fineid, fineprice, finereason);
			Dialog_Show(playerid, VehicleFines, DIALOG_STYLE_MSGBOX, "Fine List", gstr, "Details","Close");

			format(menu, 10, "menu%d", i);
			SetPVarInt(playerid, menu, fineid);

			SetPVarInt(playerid, "PlayerFinesID", targetid);
		}
		return true;
	}
	else
	{
	    Dialog_Show(playerid, VehicleFines, DIALOG_STYLE_MSGBOX, "Clean", "No fines found", "Close", "");
	}
	return true;
}

/*Dialog:VehicleFines(playerid, response, listitem, inputtext[])
{
	if(response)
	{
	    new menu[10], str[512], targetid = GetPVarInt(playerid, "PlayerFinesID");
	    format(menu, 10, "menu%d", listitem);
	    new rows = GetPVarInt(playerid, menu);

		format(gquery, sizeof(gquery), "SELECT * FROM `fines` WHERE `addressee` = '%s' AND `id` = %d AND `type` != 0", ReturnNameEx(targetid), rows);
		mysql_query(dbCon, gquery);

		if(cache_num_rows())
		{
			new
				fineid,
				fineagency[64],
				fineaddressee[24],
				fineissuer[24],
				fineprice,
				finedate[64],
				finereason[64];

			cache_get_value_index_int(0, 0, fineid);
			cache_get_value_index(0, 1, fineissuer);
			cache_get_value_index(0, 2, fineaddressee);
			cache_get_value_index(0, 3, fineagency);
			cache_get_value_index(0, 4, finedate);
			cache_get_value_index_int(0, 5, fineprice);
			cache_get_value_index(0, 6, finereason);

			if(targetid == playerid)
			{
			    SetPVarInt(playerid, "PlayerFinesChooseID", fineid);
			    SetPVarInt(playerid, "PlayerFinesPrice", fineprice);
			    format(str, sizeof(str), "Agencies:\t%s\nRecipients:\t\t%s\nCard issuer:\t%s\n\nNumber:\t\t$%d\nCause:\t\t%s\nDate:\t\t%s\n\nYou have 72 Hours for paying the fine" ,fineagency, fineaddressee, fineissuer, fineprice, finereason, finedate);
				Dialog_Show(playerid,PayFines,DIALOG_STYLE_MSGBOX,"Fine Details",str,"Pay","Close");
			}
			else
			{
				format(str, sizeof(str), "Agencies:\t%s\nRecipients:\t\t%s\nCard issuer:\t%s\n\nNumber:\t\t$%d\nCause:\t\t%s\nDate:\t\t%s" ,fineagency, fineaddressee, fineissuer, fineprice, finereason, finedate);
				Dialog_Show(playerid,ShowOnly,DIALOG_STYLE_MSGBOX,"Fine Details",str,"Close","");
			}
			return true;
		}
	}
	return true;
}

Dialog:PlayerFines(playerid, response, listitem, inputtext[])
{
	if(response)
	{
	    new menu[10], str[512], targetid = GetPVarInt(playerid, "PlayerFinesID");
	    format(menu, 10, "menu%d", listitem);
	    new rows = GetPVarInt(playerid, menu);

		format(gquery, sizeof(gquery), "SELECT * FROM `fines` WHERE `addressee` = '%s' AND `id` = %d AND `type` = 0", ReturnNameEx(targetid), rows);
		mysql_query(dbCon, gquery);

		if(cache_num_rows())
		{
			new
				fineid,
				fineagency[64],
				fineaddressee[24],
				fineissuer[24],
				fineprice,
				finedate[64],
				finereason[64];

			cache_get_value_index_int(0, 0, fineid);
			cache_get_value_index(0, 1, fineissuer);
			cache_get_value_index(0, 2, fineaddressee);
			cache_get_value_index(0, 3, fineagency);
			cache_get_value_index(0, 4, finedate);
			cache_get_value_index_int(0, 5, fineprice);
			cache_get_value_index(0, 6, finereason);

			if(targetid == playerid)
			{
			    SetPVarInt(playerid, "PlayerFinesChooseID", fineid);
			    SetPVarInt(playerid, "PlayerFinesPrice", fineprice);
			    format(str, sizeof(str), "Agencies:\t%s\nRecipients:\t\t%s\nCard issuer:\t%s\n\nNumber:\t\t$%d\nCause:\t\t%s\nDate:\t\t%s\n\nYou have 72 Hours for paying the fine" ,fineagency, fineaddressee, fineissuer, fineprice, finereason, finedate);
				Dialog_Show(playerid,PayFines,DIALOG_STYLE_MSGBOX,"Fine Details",str,"Pay","Close");
			}
			else
			{
				format(str, sizeof(str), "Agencies:\t%s\nRecipients:\t\t%s\nCard issuer:\t%s\n\nNumber:\t\t$%d\nCause:\t\t%s\nDate:\t\t%s" ,fineagency, fineaddressee, fineissuer, fineprice, finereason, finedate);
				Dialog_Show(playerid,ShowOnly,DIALOG_STYLE_MSGBOX,"Fine Details",str,"Close","");
			}
			return true;
		}
	}
	return true;
}*/

Dialog:PayFines(playerid, response, listitem, inputtext[])
{
    if(response)
	{
		if(PlayerData[playerid][pLocal] != 102)
			return SendClientMessage(playerid, COLOR_YELLOW, "You are not at Los Santos HQ");

        new fineid = GetPVarInt(playerid, "PlayerFinesChooseID");
        new price = GetPVarInt(playerid, "PlayerFinesPrice");

		if(PlayerData[playerid][pCash] < price)
			return SendClientMessage(playerid,COLOR_GREY,"You do not have enough money to pay this fine.!");

	    TakePlayerMoney(playerid, price);

	    SendClientMessageEx(playerid, COLOR_PURPLE, "[ ! ] You paid a fine #%d in the price: $%d", fineid, price);

		format(gquery, sizeof(gquery), "DELETE FROM `fines` WHERE `id` = %d", fineid);
	    mysql_pquery(dbCon, gquery);
    }

	DeletePVar(playerid, "PlayerFinesChooseID");
	DeletePVar(playerid, "PlayerFinesPrice");
	return true;
}

ChargePerson(playerid)
{
	new str[128];

	format(str, sizeof(str), "~g~$%d", TaxiMoney[playerid]);
	GameTextForPlayer(playerid, str, 1000, 6);

	new driver = GetVehicleDriver(gPassengerCar[playerid]);

	if(PlayerData[playerid][pCash] < TaxiMoney[playerid])
	{
		if(driver != INVALID_PLAYER_ID)
		{
			SendClientMessageEx(driver, COLOR_WHITE, "%s did not have enough money to pay the fare.", ReturnName(playerid, 0));

			TaxiMade[driver] -= TaxiMoney[playerid];
		}

		TaxiMoney[playerid] = 0;
	}
	else
	{
		TakePlayerMoney(playerid, TaxiMoney[playerid]);

		if(driver != INVALID_PLAYER_ID)
		{
			SendPlayerMoney(driver, TaxiMoney[playerid]);

			TaxiMade[driver] -= TaxiMoney[playerid];
		}

		TaxiMoney[playerid] = 0;
	}
}

SendPlayerMoney(playerid, amount)
{
    PlayerData[playerid][pCash] += amount;

    ResetPlayerMoney(playerid);
    GivePlayerMoney(playerid, PlayerData[playerid][pCash]);
}

TakePlayerMoney(playerid, amount)
{
    PlayerData[playerid][pCash] -= amount;

    ResetPlayerMoney(playerid);
    GivePlayerMoney(playerid, PlayerData[playerid][pCash]);
}

GetHouseItem(houseid, itemid)
{
	for(new z = 0; z != MAX_HOUSE_ITEMS; ++z)
	{
		if(PropertyData[houseid][hItems][z] == itemid)
			return 1;
	}

	return 0;
}

ShowPacketloss(playerid, forplayerid)
{
	if(playerid == forplayerid)
		return SendClientMessageEx(forplayerid, COLOR_WHITE, "Your ping is {FFFF00}%d {FFFFFF}and your packetloss is {FFFF00}%f", GetPlayerPing(playerid), NetStats_PacketLossPercent(playerid));

	SendClientMessageEx(forplayerid, COLOR_WHITE, "%s's ping is {FFFF00}%d {FFFFFF}and their packetloss is {FFFF00}%f", ReturnName(playerid), GetPlayerPing(playerid), NetStats_PacketLossPercent(playerid));
	return true;
}

ResetGlobalVariables()
{
	for(new i = 0; i < 200; ++i)
	{
		if(i < MAX_PARTICLES)
		{
			Particles[i][particleSQLID] = -1;
			Particles[i][particleCreator][0] = EOS;
			Particles[i][particleObject] = INVALID_OBJECT_ID;
			Particles[i][particleModel] = 0;
			Particles[i][particlePos][0] = 0.0;
			Particles[i][particlePos][1] = 0.0;
			Particles[i][particlePos][2] = 0.0;
			Particles[i][particlePos][3] = 0.0;
			Particles[i][particlePos][4] = 0.0;
			Particles[i][particlePos][5] = 0.0;
			Particles[i][particleStamp] = 0;
			Particles[i][particleEdit] = false;
		}

	    if(i < 100)
	    {
	        APB[i][Exists] = false;
	        APB[i][Stamp] = 1930177671;
	        APB[i][Creator][0] = EOS;
	        APB[i][Department][0] = EOS;
	        APB[i][Description][0] = EOS;
	        APB[i][Charges][0] = EOS;
	    }

	    if(i < MAX_PLAYERS)
	    {
	        CORPSES[i][corpseSpawned] = false;
	        CORPSES[i][corpseActor] = INVALID_PLAYER_ID;
	        CORPSES[i][corpseMinutes] = 0;
	        CORPSES[i][corpseName][0] = EOS;

	        EmergencyCalls[i][Caller] = INVALID_PLAYER_ID;
	    }

	    if(i < 100)
	    {
		    VehicleRequests[i][requestActive] = false;
			VehicleRequests[i][requestPlayer] = INVALID_PLAYER_ID;
			VehicleRequests[i][requestCar] = INVALID_VEHICLE_ID;
		    VehicleRequests[i][requestName][0] = EOS;
		    VehicleRequests[i][requestStamp][0] = EOS;
	    }

	    if(i < MAX_REPORTS)
	    {
	        Reports[i][reportBy] = INVALID_PLAYER_ID;
	        Reports[i][reportPlayer] = INVALID_PLAYER_ID;
			Reports[i][reportReason][0] = EOS;
	    }

	    if(i < MAX_ATM_LIMIT) ATMS[i][aID] = -1;

	    if(i < MAX_DROP_ITEMS) DroppedWeapons[i][DropExists] = false;

		if(i < MAX_AD_QUEUE)
		{
			AdvertData[i][ad_id] = 0;
			AdvertData[i][ad_time] = 0;
			AdvertData[i][ad_owner] = INVALID_PLAYER_ID;			
		}
	}

	for(new i = 0; i < MAX_SPRAY_LOCATIONS; ++i)
	{
		Spray_Data[i][graffSQLID] = -1;
		Spray_Data[i][graffCreator][0] = EOS;
		Spray_Data[i][graffName][0] = EOS;
		Spray_Data[i][graffModel] = -1;
		Spray_Data[i][graffDefault] = -1;
		Spray_Data[i][graffFont][0] = EOS;
	}	
}

CMD:enablecmd(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 1337)
        return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	if(isnull(params))
		return SendSyntaxMessage(playerid, "/enablecmd [Command Name e.g 'givegun']");

	new command = Command_GetID(params);	

	if(command == -1)
		return SendErrorMessage(playerid, "Command '%s' is invalid.", params);

	if(DisabledCommands[command] == 0)	
		return SendErrorMessage(playerid, "Command '%s' is already enabled, use /disablecmd.", params);

	DisabledCommands[command] = 0;

	SendClientMessageEx(playerid, COLOR_LIGHTRED, "Command /%s is now enabled. (/disablecmd to disable it)", params);	
	return true;
}

CMD:disablecmd(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 1337)
        return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	if(isnull(params))
		return SendSyntaxMessage(playerid, "/disablecmd [Command Name e.g 'givegun']");

	new command = Command_GetID(params);	

	if(command == -1)
		return SendErrorMessage(playerid, "Command '%s' is invalid.", params);

	if(DisabledCommands[command] == 1)	
		return SendErrorMessage(playerid, "Command '%s' is already disabled, use /enablecmd.", params);

	DisabledCommands[command] = 1;

	SendClientMessageEx(playerid, COLOR_LIGHTRED, "Command /%s is now disabled. (/enablecmd to enable it again)", params);	
	return true;
}

showServerMOTD(playerid) return SendPlayerMOTD(playerid);

Dialog:MotdUpdate(playerid, response, listitem, inputtext[])
{
	if(!response) return true;

	listitem = UpdatingMOTD[playerid];

	if(isnull(inputtext)) MotdTEXT[listitem][0] = EOS;
	else format(MotdTEXT[listitem], 256, "%s", inputtext);

	format(MotdINFO[editedBy], MAX_PLAYER_NAME, "%s", AccountData[playerid][aUsername]);
	format(MotdINFO[editedDate], 128, "%s", ReturnSiteDate());

	format(gquery, sizeof(gquery), "UPDATE motd SET Line%i = '%s', EditedBy = '%s', EditedDate = '%s'", listitem + 1, inputtext, MotdINFO[editedBy], MotdINFO[editedDate]);
	mysql_tquery(dbCon, gquery);

	SendServerMessage(playerid, "Motd has been updated.");

	SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn: %s updated the server MOTD.", ReturnName(playerid));
	return true;
}

Dialog:MotdList(playerid, response, listitem, inputtext[])
{
	if(!response) return true;

	UpdatingMOTD[playerid] = listitem;

	if(isnull(MotdTEXT[listitem]) || !strlen(MotdTEXT[listitem]))
		return Dialog_Show(playerid, MotdUpdate, DIALOG_STYLE_INPUT, "Update Motd", "- This line is empty -", "Update", "Cancel");

	format(sgstr, sizeof(sgstr), "{FFFFFF}Line %d: [%s]\n\n{FFFFFF}Leave empty to remove.", listitem + 1, MotdTEXT[listitem]);
	Dialog_Show(playerid, MotdUpdate, DIALOG_STYLE_INPUT, "Update Motd", sgstr, "Update", "Cancel");
	return true;
}

SendPlayerMOTD(playerid)
{
    SendClientMessage(playerid, 0xa7cdffFF, "====={7db5ff}====={529cfd}====={2081ff}====={ffffff}[ {046ffa}MOTD{ffffff} ]{2081ff}====={529cfd}====={7db5ff}====={a7cdff}=====");

	for(new i = 0; i < 5; ++i)
	{
		if(!isnull(MotdTEXT[i]) && strlen(MotdTEXT[i]) > 0)
		{
		    SendClientMessageEx(playerid, -1, "%s", MotdTEXT[i]);
		}
	}

	SendClientMessage(playerid, 0xa7cdffFF, "====={7db5ff}====={529cfd}====={2081ff}====={ffffff}[ {046ffa}MOTD{ffffff} ]{2081ff}====={529cfd}====={7db5ff}====={a7cdff}=====");

	SendClientMessageEx(playerid, COLOR_GREY, "Last edited by %s on %s", MotdINFO[editedBy], MotdINFO[editedDate]);
	return true;
}

ReturnAccountDBID(username[])
{
	new checkQuery[128], dbid;

	mysql_format(dbCon, checkQuery, sizeof(checkQuery), "SELECT `ID` FROM `accounts` WHERE `Username` = '%e' LIMIT 1", username);
	new Cache:cache = mysql_query(dbCon, checkQuery);

	if(!cache_num_rows())
	{
		cache_delete(cache);
		return -1;
	}

	cache_get_value_name_int(0, "ID", dbid);
	cache_delete(cache);
	return dbid;
}

ReturnDBIDName(dbid)
{
	new query[120], returnString[MAX_PLAYER_NAME];

	mysql_format(dbCon, query, sizeof(query), "SELECT `char_name` FROM `characters` WHERE `ID` = '%i' LIMIT 1", dbid);
	new Cache:cache = mysql_query(dbCon, query);

	if(!cache_num_rows())
		returnString = "None";

	else
		cache_get_value_name(0, "char_name", returnString, MAX_PLAYER_NAME);

	cache_delete(cache);
	return returnString;
}

ReturnDBIDFromName(name[])
{
	new checkQuery[128], dbid;

	mysql_format(dbCon, checkQuery, sizeof(checkQuery), "SELECT `ID` FROM `characters` WHERE `char_name` = '%e' LIMIT 1", name);
	new Cache:cache = mysql_query(dbCon, checkQuery);

	if(!cache_num_rows())
	{
		cache_delete(cache);
		return 0;
	}

	cache_get_value_name_int(0, "ID", dbid);
	cache_delete(cache);
	return dbid;
}

ReturnNameLetter(playerid)
{
	new
		playersName[MAX_PLAYER_NAME]
	;

	GetPlayerName(playerid, playersName, sizeof(playersName));

	format(playersName, sizeof(playersName), "%c. %s", playersName[0], playersName[strfind(playersName, "_") + 1]);
	return playersName;
}

ReturnFormatName(playerid)
{
    new playersName[MAX_PLAYER_NAME];
    GetPlayerName(playerid, playersName, sizeof(playersName));

	for(new i = 0, j = strlen(playersName); i < j; ++i)
	{
		if(playersName[i] == '_')
		{
			playersName[i] = ' ';
		}
	}
	return playersName;
}

FormatName(string[])
{
    new playersName[MAX_PLAYER_NAME];
    format(playersName, MAX_PLAYER_NAME, "%s", string);

	for(new i = 0, j = strlen(playersName); i < j; ++i)
	{
		if(playersName[i] == '_')
		{
			playersName[i] = ' ';
		}
	}
	return playersName;
}

UnFormatName(string[])
{
    new playersName[MAX_PLAYER_NAME];
    format(playersName, MAX_PLAYER_NAME, "%s", string);

	for(new i = 0, j = strlen(playersName); i < j; ++i)
	{
		if(playersName[i] == ' ')
		{
			playersName[i] = '_';
		}
	}
	return playersName;
}

NeedAnS(const unit[], value)
{
	new result[20];
	format(result, sizeof(result), unit);
	if(value > 1) strcat(result, "s");
	return result;
}

/*CMD:flag(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 1)
		return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	new
		userid,
		note[256]
	;

	if(sscanf(params, "us[256]", userid, note))
	    return SendSyntaxMessage(playerid, "/flag [playerid/PartOfName] [note]");

	if(!IsPlayerConnected(userid))
		return SendErrorMessage(playerid, "The player you specified isn't connected.");

	if(!SQL_IsLogged(userid))
		return SendErrorMessage(playerid, "The player you specified isn't logged in.");

	if(!strlen(note) || strlen(note) > 256)
	    return SendErrorMessage(playerid, "Text is too short or too long.");

    new largeQuery[512];

	mysql_format(dbCon, largeQuery, sizeof(largeQuery), "INSERT INTO `flags` (Text, userid, master_name, char_name, admin_name) VALUES ('%e', %d, '%e', '%e', '%e')", note, PlayerData[userid][pID], AccountData[userid][aUsername], ReturnName(userid), ReturnName(playerid));
    mysql_tquery(dbCon, largeQuery, "OnAdminActionAdded", "dds", playerid, userid, note);

	if(strlen(note) > 80)
	{
		SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmCmd: %s added an OnAdminAction note on %s: %.80s", ReturnName(playerid), ReturnName(userid), note);
		SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmCmd: %s", note[80]);
	}
	else SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmCmd: %s added an OnAdminAction note on %s: %s", ReturnName(playerid), ReturnName(userid), note);

	return true;
}

FUNX::OnAdminActionAdded(playerid, userid, text[])
{
	for(new i = 0; i < 10; ++i)
	{
	    if(!AdminActions[userid][i][actionID])
	    {
	        AdminActions[userid][i][actionID] = cache_insert_id();
	        format(AdminActions[userid][i][actionText], 256, text);
	        format(AdminActions[userid][i][actionAdmin], MAX_PLAYER_NAME, ReturnName(playerid));
	        return true;
	    }
	}

	for(new i = 0; i < 9; ++i)
	{
	    AdminActions[userid][i][actionID] = AdminActions[userid][i + 1][actionID];
	    format(AdminActions[userid][i][actionText], 256, AdminActions[userid][i + 1][actionText]);
	    format(AdminActions[userid][i][actionAdmin], MAX_PLAYER_NAME, AdminActions[userid][i + 1][actionAdmin]);
	}

	AdminActions[userid][9][actionID] = cache_insert_id();
	format(AdminActions[userid][9][actionText], 256, text);
	format(AdminActions[userid][9][actionAdmin], MAX_PLAYER_NAME, ReturnName(playerid));

	//printf(" failed OnAdminActionAdded(%d, %d, %s)", playerid, userid, text);
	return true;
}

new ANOTES[MAX_PLAYERS][11];

CMD:viewnotes(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 1)
		return SendUnauthMessage(playerid, "You're not authorized to use this command.");

	new
		userid
	;

	if(sscanf(params, "u", userid))
	    return SendSyntaxMessage(playerid, "/viewnotes [playerid/PartOfName]");

	if(!IsPlayerConnected(userid))
		return SendErrorMessage(playerid, "The player you specified isn't connected.");

	if(!SQL_IsLogged(userid))
		return SendErrorMessage(playerid, "The player you specified isn't logged in.");

	new body[1000], count = 0;

	for(new i = 0; i < 10; ++i)
	{
	    if(!AdminActions[userid][i][actionID]) continue;

	    format(body, sizeof(body), "%s%s\n", body, AdminActions[userid][i][actionText]);

	    ANOTES[playerid][count] = i;

	    count++;
	}

	if(!count) return SendErrorMessage(playerid, "Nothing to show.");

	ANOTES[playerid][10] = userid;

	Dialog_Show(playerid, AdminActions, DIALOG_STYLE_LIST, "Admin Action", body, "Delete", "Cancel");

	return true;
}

Dialog:AdminActions(playerid, response, listitem, inputtext[])
{
	if(!response) return true;
	if(response)
	{
		new
		    id = ANOTES[playerid][listitem],
		    userid = ANOTES[playerid][10]
		;

		SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmCmd: %s deleted %s's OnAdminAction %d.", ReturnName(playerid), ReturnName(userid), AdminActions[userid][id][actionID]);

		format(largeQuery, sizeof(largeQuery), "DELETE FROM `flags` WHERE `ID` = '%d'", AdminActions[userid][id][actionID]);
	    mysql_pquery(dbCon, largeQuery);

	    AdminActions[userid][id][actionID] = 0;
	}
	return true;
}*/

// Fly spec
/*StartFlyEditor(playerid)
{
	new Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X, Y, Z);

	if(IsPlayerInAnyVehicle(playerid)) RemovePlayerFromVehicle(playerid);

	PfSpec[playerid][FlySpec] = 1;
	PfSpec[playerid][fsobj] = CreatePlayerObject(playerid, 19300, X, Y, Z, 0.0, 0.0, 0.0);
	PfSpec[playerid][fspeed] = 50;

	TempInfo[playerid][tSkin] = GetPlayerSkin(playerid);
	TempInfo[playerid][tHealth] = PlayerData[playerid][pHealth];
	TempInfo[playerid][tInt] = GetPlayerInterior(playerid);
	TempInfo[playerid][tVW] = GetPlayerVirtualWorld(playerid);

	SendClientMessage(playerid, COLOR_WHITE, "You have entered Fly Spectate mode");
	SendClientMessage(playerid, COLOR_WHITE, "Use {FF6347}~k~~GO_FORWARD~ ~k~~GO_BACK~ ~k~~GO_LEFT~ ~k~~GO_RIGHT~{FFFFFF} to move the camera.");
	SendClientMessage(playerid, COLOR_WHITE, "Press {FF6347}~k~~PED_JUMPING~{FFFFFF} to speed up and {FF6347}~k~~PED_SPRINT~{FFFFFF} to slow down.");
	SendClientMessage(playerid, COLOR_WHITE, "To exit the spectate mode, type {FF6347}/fly{FFFFFF} again.");

	TogglePlayerSpectating(playerid, true);
	AttachCameraToPlayerObject(playerid, PfSpec[playerid][fsobj]);
	return true;
}

EndFlyEditor(playerid)
{
	PfSpec[playerid][FlySpec] = 0;
	GetPlayerCameraPos(playerid, PfSpec[playerid][CamPos][0], PfSpec[playerid][CamPos][1], PfSpec[playerid][CamPos][2]);
	TogglePlayerSpectating(playerid, false);
	DestroyPlayerObject(playerid, PfSpec[playerid][fsobj]);
	SetPlayerSkin(playerid,TempInfo[playerid][tSkin]);
	SetPlayerInterior(playerid,TempInfo[playerid][tInt]);
	SetPlayerVirtualWorld(playerid,TempInfo[playerid][tVW]);
	SetPlayerDynamicPos(playerid, PfSpec[playerid][CamPos][0], PfSpec[playerid][CamPos][1], PfSpec[playerid][CamPos][2]);
	SetPlayerHealthEx(playerid,TempInfo[playerid][tHealth]);
	ResetPlayerWeapons(playerid);
	SetPlayerWeapons(playerid);
	//SetTimerEx("UnFreezePlayer", 200, 0, "d", playerid);
	PfSpec[playerid][CamPos][0] = 0;
	PfSpec[playerid][CamPos][1] = 0;
	PfSpec[playerid][CamPos][2] = 0;
	PfSpec[playerid][mdir] = 0;
	PfSpec[playerid][updownold] = 0;
	PfSpec[playerid][leftrightold] = 0;
	ClearTempInfo(playerid);
	return true;
}

ClearTempInfo(playerid)
{
	TempInfo[playerid][tSkin] = 0;
	TempInfo[playerid][tHealth] = 0;
	TempInfo[playerid][tInt] = 0;
	TempInfo[playerid][tVW] = 0;
	TempInfo[playerid][tmX] = 0.0;
	TempInfo[playerid][tmY] = 0.0;
	TempInfo[playerid][tmZ] = 0.0;
	return true;
}

GetMoveDirectionFromKeys(updown, leftright)
{
	new direction = 0;
	if(leftright < 0)
	{
		if(updown < 0) direction = 7;//ForwardLest
		else if(updown > 0) direction = 5;//BackLeft
		else direction = 3;//Left
	}
	else if(leftright > 0)
	{
		if(updown < 0) direction = 8;//ForwardRight
		else if(updown > 0) direction = 6;//BackRight
		else direction = 4;//Right
	}
	else if(updown < 0) direction = 1;//Forward
	else if(updown > 0) direction = 2;//Back

	return direction;
}

MoveCamera(playerid)
{
	new Float:fvector[3], Float:pCPos[3];
	GetPlayerCameraPos(playerid, pCPos[0], pCPos[1], pCPos[2]);
	GetPlayerCameraFrontVector(playerid, fvector[0], fvector[1], fvector[2]);
	new Float:X, Float:Y, Float:Z;
	GetNextCameraPosition(PfSpec[playerid][mdir], pCPos, fvector, X, Y, Z);
	MovePlayerObject(playerid, PfSpec[playerid][fsobj], X, Y, Z, PfSpec[playerid][fspeed]);
	PfSpec[playerid][lastmove] = GetTickCount();
	return true;
}

GetNextCameraPosition(move_mode, const Float:pCPos[3], const Float:fvector[3], &Float:X, &Float:Y, &Float:Z)
{
	#define OFFSET_X (fvector[0] * 6000.0)
	#define OFFSET_Y (fvector[1] * 6000.0)
	#define OFFSET_Z (fvector[2] * 6000.0)

	switch(move_mode)
	{
		case 1: //Forward
		{
			X = pCPos[0] + OFFSET_X;
			Y = pCPos[1] + OFFSET_Y;
			Z = pCPos[2] + OFFSET_Z;
		}
		case 2: //Back
		{
			X = pCPos[0] - OFFSET_X;
			Y = pCPos[1] - OFFSET_Y;
			Z = pCPos[2] - OFFSET_Z;
		}
		case 3: //Left
		{
			X = pCPos[0] - OFFSET_Y;
			Y = pCPos[1] + OFFSET_X;
			Z = pCPos[2];
		}
		case 4: //Right
		{
			X = pCPos[0] + OFFSET_Y;
			Y = pCPos[1] - OFFSET_X;
			Z = pCPos[2];
		}
		case 5: //BackLeft
		{
			X = pCPos[0] + (-OFFSET_X - OFFSET_Y);
			Y = pCPos[1] + (-OFFSET_Y + OFFSET_X);
			Z = pCPos[2] - OFFSET_Z;
		}
		case 6: //BackRight
		{
			X = pCPos[0] + (-OFFSET_X + OFFSET_Y);
			Y = pCPos[1] + (-OFFSET_Y - OFFSET_X);
			Z = pCPos[2] - OFFSET_Z;
		}
		case 7: //ForwardLeft
		{
			X = pCPos[0] + (OFFSET_X - OFFSET_Y);
			Y = pCPos[1] + (OFFSET_Y + OFFSET_X);
			Z = pCPos[2] + OFFSET_Z;
		}
		case 8: //ForwardRight
		{
			X = pCPos[0] + (OFFSET_X + OFFSET_Y);
			Y = pCPos[1] + (OFFSET_Y - OFFSET_X);
			Z = pCPos[2] + OFFSET_Z;
		}
	}
}*/

Dialog:DIALOG_ATM_DELETE(playerid, response, listitem, inputtext[])
{
	if(!response)
	{
	    BouttaDelete[playerid] = -1;
	    return true;
	}
	if(response)
	{
		new ATM = BouttaDelete[playerid];

		new query[256];
		format(query,sizeof(query), "DELETE FROM `atms` WHERE `ID` = '%d' LIMIT 1", ATMS[ATM][aID]);
		mysql_tquery(dbCon, query);

		ATMS[ATM][aID] = -1;
		DestroyDynamicObject(ATMS[ATM][aObject]);

		SendNoticeMessage(playerid, "You have successfully deleted ATM [%d].", ATM);

		SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn: %s deleted an ATM [ID: %d].", PlayerName(playerid), ATM);
	}
	return true;
}

FUNX::OnCreateATM(playerid, ATM, Float:X, Float:Y, Float:Z)
{
    ATMS[ATM][aID] = cache_insert_id();

	ATMS[ATM][aObject] = CreateDynamicObject(ATM_OBJECT, X, Y + 2, Z, 0.00000, 0.00000, 0.00000);
	EditDynamicObject(playerid, ATMS[ATM][aObject]);

	EditingATM[playerid] = ATM;

	SendNoticeMessage(playerid, "ATM [%d] has been successfully created (DBID: %d).", ATM, ATMS[ATM][aID]);

	SendAdminAlert(COLOR_YELLOW, JUNIOR_ADMINS, "AdmWarn: %s created a new ATM [ID: %d].", PlayerName(playerid), ATM);
	return true;
}

FindFreeATM()
{
	for(new i = 0; i < MAX_ATM_LIMIT; ++i)
	{
	    if(ATMS[i][aID] == -1)
	    {
	        return i;
	    }
	}

	return -1;
}

CMD:samaps(playerid, params[])
{
	Dialog_Show(playerid, SA_MAPS, DIALOG_STYLE_LIST, "SAMaps - Main Menu", "Find Street\nFind Property\nFind Nearest Gas Station\nFind Nearest 24/7\nFind Nearest Bar/Club\nFind Nearest Fast Food\nAll Businesses\nPoints of Interest", "Next", "Exit");
	return true;
}

Dialog:SA_MAPS(playerid, response, listitem, inputtext[])
{
	if(!response) return true;
	
	if(response)
	{
	    switch(listitem)
	    {
	        case 0:
	        {
	            Dialog_Show(playerid, FindStreet, DIALOG_STYLE_INPUT, "SA Maps - Find Street", "Enter the name of the street you're trying to locate.", "Go", "Back");
	        }
	        case 1:
	        {
	            Dialog_Show(playerid, FindProperty, DIALOG_STYLE_INPUT, "SA Maps - Find Property", "Enter the number of the property you're trying to locate.", "Go", "Back");
	        }
	        case 2: // Nearest Gas Station
	        {
			    new Float:Dist = 9999.0, Float:NewDist, bizzi = -1;

				foreach (new bizzid : Business)
				{
				    if(BusinessData[bizzid][bType] != 1) continue;

				    NewDist = GetPlayerDistanceFromPoint(playerid, BusinessData[bizzid][bEntranceX], BusinessData[bizzid][bEntranceY], BusinessData[bizzid][bEntranceZ]);

					if(NewDist < Dist)
					{
					    Dist = NewDist;

	                    bizzi = bizzid;
					}
				}

				if(bizzi == -1) return SendErrorMessage(playerid, "No bizz found.");

				SetPath(playerid, BusinessData[bizzi][bEntranceX], BusinessData[bizzi][bEntranceY], BusinessData[bizzi][bEntranceZ], ClearGameTextColor(BusinessData[bizzi][bInfo]));
	        }
	        case 3: // Nearest 24/7
	        {
			    new Float:Dist = 9999.0, Float:NewDist, bizzi = -1;

				foreach (new bizzid : Business)
				{
				    if(BusinessData[bizzid][bType] != 3) continue;

				    NewDist = GetPlayerDistanceFromPoint(playerid, BusinessData[bizzid][bEntranceX], BusinessData[bizzid][bEntranceY], BusinessData[bizzid][bEntranceZ]);

					if(NewDist < Dist)
					{
					    Dist = NewDist;

	                    bizzi = bizzid;
					}
				}

				if(bizzi == -1) return SendErrorMessage(playerid, "No bizz found.");

				SetPath(playerid, BusinessData[bizzi][bEntranceX], BusinessData[bizzi][bEntranceY], BusinessData[bizzi][bEntranceZ], ClearGameTextColor(BusinessData[bizzi][bInfo]));
	        }
	        case 4: // Nearest Bar/Club
	        {
			    new Float:Dist = 9999.0, Float:NewDist, bizzi = -1;

				foreach (new bizzid : Business)
				{
				    if(BusinessData[bizzid][bType] != 8) continue;

				    NewDist = GetPlayerDistanceFromPoint(playerid, BusinessData[bizzid][bEntranceX], BusinessData[bizzid][bEntranceY], BusinessData[bizzid][bEntranceZ]);

					if(NewDist < Dist)
					{
					    Dist = NewDist;

	                    bizzi = bizzid;
					}
				}

				if(bizzi == -1) return SendErrorMessage(playerid, "No bizz found.");

				SetPath(playerid, BusinessData[bizzi][bEntranceX], BusinessData[bizzi][bEntranceY], BusinessData[bizzi][bEntranceZ], ClearGameTextColor(BusinessData[bizzi][bInfo]));
	        }
	        case 5: // Nearest Fast Food
	        {
			    new Float:Dist = 9999.0, Float:NewDist, bizzi = -1;

				foreach (new bizzid : Business)
				{
				    if(BusinessData[bizzid][bType] != 9) continue;

				    NewDist = GetPlayerDistanceFromPoint(playerid, BusinessData[bizzid][bEntranceX], BusinessData[bizzid][bEntranceY], BusinessData[bizzid][bEntranceZ]);

					if(NewDist < Dist)
					{
					    Dist = NewDist;

	                    bizzi = bizzid;
					}
				}

				if(bizzi == -1) return SendErrorMessage(playerid, "No bizz found.");

				SetPath(playerid, BusinessData[bizzi][bEntranceX], BusinessData[bizzi][bEntranceY], BusinessData[bizzi][bEntranceZ], ClearGameTextColor(BusinessData[bizzi][bInfo]));
	        }
	        case 6: // All Businesses
	        {
	        
	        }
			case 7: // Points of Interest
			{
				gstr[0] = EOS;

				for(new i = 0; i < sizeof(PointsOfInterest); ++i)
				{
				    format(gstr, sizeof(gstr), "%s\n%s", gstr, PointsOfInterest[i][poiName]);
				}
				
				Dialog_Show(playerid, POIS, DIALOG_STYLE_LIST, "Points of Interest", gstr, "Go", "Back");
			}
	    }
	}
	return true;
}

Dialog:POIS(playerid, response, listitem, inputtext[])
{
	if(!response) return true;
	
	if(listitem < 0 || listitem >= sizeof(PointsOfInterest)) return false;
	
	SetPath(playerid, PointsOfInterest[listitem][pointArea][0], PointsOfInterest[listitem][pointArea][1], PointsOfInterest[listitem][pointArea][2], PointsOfInterest[listitem][poiName]);
	return true;
}

Dialog:FindProperty(playerid, response, listitem, inputtext[])
{
	if(!response) return true;

	if(!IsNumeric(inputtext))
		return Dialog_Show(playerid, FindProperty, DIALOG_STYLE_INPUT, "SA Maps - Find Property", "Enter the number of the property you're trying to locate.", "Go", "Back");

	foreach (new houseid : Property)
	{
		if(PropertyData[houseid][hID] == strval(inputtext))
		{
			new string[256];
			format(string, 256, "%d %s", strval(inputtext), ReturnLocationPos(PropertyData[houseid][hEntranceX], PropertyData[houseid][hEntranceY]));
			SetPath(playerid, PropertyData[houseid][hEntranceX], PropertyData[houseid][hEntranceY], PropertyData[houseid][hEntranceZ], string);
			return true;
		}
	}

	Dialog_Show(playerid, FindProperty, DIALOG_STYLE_INPUT, "SA Maps - Find Property", "Enter the number of the property you're trying to locate.\n{FF0000}Error: No property found.", "Go", "Back");
	return true;
}


SetPath(playerid, Float:X, Float:Y, Float:Z, msg[])
{
	HasCheckpoint{playerid} = true;
	SetPlayerCheckpoint(playerid, X, Y, Z, 4.0);

	SendNoticeMessage(playerid, "%s has been marked on your map.", msg);
	return true;
}

FUNX::WT()
{
	new rand = random(10); /* This random value allows the possibilty of 15 weather changing IDS from 1 - 15 */

	//new string[256];    /* This string is the text in the message that displays to all the players */

	switch(rand)  /* This random swtich generates the next weather that the server will have */
	{
		/*case 0:format(string, sizeof(string), "[Weather Report] - SUNNY SKIES - MODERATE WIND - CHANCE OF SHOWERS");
		case 1:format(string, sizeof(string), "[Weather Report] - SUNNY SKIES - LIGHT WIND - FOGGY START TO THE MORNING");
		case 2:format(string, sizeof(string), "[Weather Report] - SUNNY SKIES - NO WIND - NO OTHER ALERTS");
		case 3:format(string, sizeof(string), "[Weather Report] - SUNNY SKIES - EXTREME WINDS - FINE SPELLS");
		case 4:format(string, sizeof(string), "[Weather Report] - SUNNY SKIES - HEAVY WINDS - NO OTHER ALERTS");
		case 5:format(string, sizeof(string), "[Weather Report] - SUNNY SKIES - NO WIND - CHANCE OF LATE NIGHT FOG");
		case 7:format(string, sizeof(string), "[Weather Report] - SUNNY SKIES - LIGHT WIND - NO OTHER ALERTS");
		case 8:format(string, sizeof(string), "[Weather Report] - WETNESS - FULL GAZES - NO OTHER ALERTS");
		case 9:format(string, sizeof(string), "[Weather Report] - HEAVY FOG - STRONG WINDS - FINE SPELLS DEVELOPING IN THE EVENING");*/
	}

	/*SendClientMessageToAll(-1, string); */

	SetWeather(rand); /* This command allows the weather in-game to switch to a new randomized ID */
	return true;
}

public OnPlayerFinishedDownloading(playerid, virtualworld)
{
    FinishedDownloadingModels{playerid} = true;
    return true;
}

HasDonatorRank(playerid, level)
{
	if(ReturnDonatorRank(playerid) >= level)
		return true;

	return false;
}

ReturnDonatorRank(playerid)
{
	if(PlayerData[playerid][pAdmin] == -1)
		return 1;

	if(PlayerData[playerid][pAdmin] == 1)
		return 2;

	if(PlayerData[playerid][pAdmin] >= 2)
		return 3;

	return PlayerData[playerid][pDonateRank];
}

ReturnCI(iPlayerID)
{
    new
        szSerial[41]; // 40 + \0

    gpci(iPlayerID, szSerial, sizeof(szSerial));
    return szSerial;
}

ConfirmDialog(playerid, const caption[], const info[], const callback[], {Float,_}:...)
{
	new n = numargs(), 		// number of arguments, static + optional
		szParamHash[256];	// variable where the passed arguments will be stored
	for(new arg = 4; arg < n; ++arg){	// loop all additional arguments
		format(szParamHash, sizeof(szParamHash), "%s%d|", szParamHash, getarg(arg)); // store them in szParamHash
	}
	SetPVarInt(playerid, "confDialogArgs", n -4);			// store the amount of additional arguments
	SetPVarString(playerid, "confDialCallback", callback);	// store the callback that needs to be called after response
	SetPVarString(playerid, "confDialog_arg", szParamHash);	// store the additional arguments

	ShowPlayerDialog(playerid, DIALOG_CONFIRM_SYS, DIALOG_STYLE_MSGBOX, caption, info, "Yes", "No"); // display the dialog message itself

	return;
} // Credits to Mmartin (SA-MP forums)

ConfirmDialog_Response(playerid, response)
{
	new szCallback[33],		// variable to fetch our callback to
		szParamHash[64], 	// variable to check raw compressed argument string
		n,					// variable to fetch the amount of additional arguments
		szForm[12];			// variable to generate the CallLocalFunction() "format" argument

	n = GetPVarInt(playerid, "confDialogArgs");	// Fetch the amount of additional arguments
	GetPVarString(playerid, "confDialCallback", szCallback, sizeof(szCallback));	// fetch the callback
	GetPVarString(playerid, "confDialog_arg", szParamHash, sizeof(szParamHash));	// fetch the raw compressed additional arguments

	new hashDecoded[12];	// variable to store extracted additional arguments from the ConfirmDialog() generated string

	sscanf(szParamHash, "p<|>A<d>(0)[12]", hashDecoded);	// extraction of the additional arguments

	new args, 	// amount of cells passed to CallLocalFunction
		addr, 	// pointer address variable for later use
		i;		// i

	format(szForm, sizeof(szForm), "dd");	// static parameters for the callback, "playerid" and "response"

	#emit ADDR.pri hashDecoded	// get pointer address of the extracted additional arguments
	#emit STOR.S.pri addr		// store the pointer address in variable 'addr'
	if(n){	// if there's any additional arguments
		for(i = addr + ((n-1) * 4); i >= addr; i-=4){ // loops all additional arguments by their addresses
			format(szForm, sizeof(szForm), "%sd", szForm); // adds an aditional specifier to the "format" parameter of CallLocalFunction
			#emit load.s.pri i	// load the argument at the current address
			#emit push.pri		// push it to the CallLocalFunction argument list
			args+=4;			// increase used cell number by 4
		}
	}


	args+=16;	// preserve 4 more arguments for CallLocalFunction (16 cause 4 args by 4 cells (4*4))

	#emit ADDR.pri response				// fetch "response" pointer address to the primary buffer
	#emit push.pri						// push it to the argument list

	#emit ADDR.pri playerid				// fetch "playerid" pointer address to the primary buffer
	#emit push.pri						// push it to the argument list

	#emit push.adr szForm				// push the szForm ("format") to the argument list by its referenced address
	#emit push.adr szCallback			// push the szCallback (custom callback) to the argument list by its referenced address
	#emit push.s args					// push the amount of arguments
	#emit sysreq.c CallLocalFunction	// call the function

	// Clear used data
	#emit LCTRL 4
	#emit LOAD.S.ALT args
	#emit ADD.C 4
	#emit ADD
	#emit SCTRL 4

	// Clear used PVars
	DeletePVar(playerid, "confDialCallback");
	DeletePVar(playerid, "confDialog_arg");
	DeletePVar(playerid, "confDialogArgs");

	return;
} // Credits to Mmartin (SA-MP forums)

/*strtolower(text[])
{
	new newstr[256];
	format(newstr, 256, text);

	for(new c = 0, length = strlen(newstr); c < length; ++c)
	{
		newstr[c] = tolower(newstr[c]);
	}

	return newstr;
}*/

string_replace(const search[], const replace[], const source[])
{
	new newnick[256];
	new newlen;
	for(new i; i < strlen(source); ++i)
	{
		if(strlen(search) > 1 && i != (strlen(source) - 1))
		{
			new matched = 1;
			new start = i;

			for(new s=0; s < strlen(search) && matched == 1; ++s)
			{
				if(source[i] != search[s] && s == 0)
				{
					newnick[newlen] = source[i];
					matched = 0;
				}
				else
				{
					if(source[i] == search[s])
					{
						i++;
					}
					else
					{
						matched = 0;
					}
				}
			}
			if(matched == 0)
			{
				while (start <= i)
				{
					newnick[newlen] = source[start];
					newlen++;
					start++;
				}
			}
			else
			{
				for(new r; r < strlen(replace); ++r)
				{
					newnick[newlen] = replace[r];
					newlen++;
				}
				i = (start + (strlen(search) - 1));
			}
		}
		else
		{
			if(strlen(search) == 1 && source[i] == search[0])
			{
				for(new r; r < strlen(replace); ++r)
				{
					newnick[newlen] = replace[r];
					newlen++;
				}
			}
			else
			{
				newnick[newlen] = source[i];
				newlen++;
			}
		}
	}
	newnick[newlen] = EOS;
	return newnick;
}

/*FUNX::DCC_OnChannelMessage(DCC_Channel:channel, const author[], const message[])
{
	new channel_name[32];
	DCC_GetChannelName(channel, channel_name);

	new str[145];
	format(str, sizeof str, "[Discord/%s] %s: %s", channel_name, author, message);
	SendClientMessageToAll(-1, str);
	return 1;
}

public DCC_OnMessageCreate(DCC_Message:message)
{
	if(systemVariables[DiscordStatus])
	    return true;

    new DCC_Channel:channel;

    DCC_GetMessageChannel(message, channel);

    if(channel != botCommandChannel)
        return true;

    new string[256];
    DCC_GetMessageContent(message, string);

    if(!strcmp(string, "&players", true))
	{
	    DCC_SendChannelMessage(botCommandChannel, "Players online:");

		foreach (new i : Player)
		{
		    format(sgstr, sizeof(sgstr), "(ID %i) %s | Level: %i", i, ReturnName(i), PlayerData[i][pLevel]);

            DCC_SendChannelMessage(botCommandChannel, sgstr);
		}

		return true;
    }
    else if(!strcmp(string, "&admins", true))
	{
	    DCC_SendChannelMessage(botCommandChannel, "Admins online:");

		foreach (new i : Player)
		{
		    if(PlayerData[i][pAdmin] >= 1)
		    {
		        format(sgstr, sizeof(sgstr), "(Level: %d) %s (ID: %d) Adminduty: %s", PlayerData[i][pAdmin], AccountName(i), i, AdminDuty{i} ? ("Yes") : ("No"));

            	DCC_SendChannelMessage(botCommandChannel, sgstr);
			}
		}

		return true;
    }
	return true;
}

public DCC_OnMessageCreate(DCC_Message:message)
{
    new DCC_Channel:channel;

    DCC_GetMessageChannel(message, channel);

    // This if condition checks that if the channel is not the command channel then it will do nothing and return 1 //
    if(channel != commandChannel)
        return 1;

    // But before that we need to save who actually sent the message //
    new DCC_User:author;
    DCC_GetMessageAuthor(message, author);

    // We need to check if the author is a bot or not //

    new bool:isBot;
    DCC_IsUserBot(author, isBot);

    // If the author is a bot then nothing will happen //
    if(isBot){
        return 1;
    }

    // Now we will fetch if the author has the required role or not! //
    new bool:hasRole;
    DCC_HasGuildMemberRole(guildName, author, adminRole, hasRole);

    // If the author does not have the role then don't do anything //
    if(!hasRole){
        DCC_SendChannelMessage(commandChannel, "You do not have the role required");
        return 1;
    }

    // Now to actually make a command after all the checks are done //
    new str[256];
    new command[32], params[128];

    DCC_GetMessageContent(message, str); // Storing the entire message of the author in the variable str //

    // Now seperating the command and the params //

    sscanf(str, "s[32]s[128]", command, params);

    // Now we will check the command //

    if(!strcmp(command, "&chat", true))
	{
        new playerID, _message[128];

        sscanf(params, "us[128]", playerID, _message); // Seperating the playerID and the message //

        if(!IsPlayerConnected(playerID))
            return DCC_SendChannelMessage(channel, "The player is not online!");

        SendClientMessage(playerID, -1, _message);
    }

    // DONE !!! //

    return 1;
}

VehicleBoloMatch(playerid, plate[])
{
	if(ALPR_Hit{playerid}) return true;

    TextDrawShowForPlayer(playerid, ALPR_UI[0]);
	TextDrawShowForPlayer(playerid, ALPR_UI[1]);

	PlayerTextDrawSetString(playerid, ALPR_Plate[playerid], plate);
	PlayerTextDrawShow(playerid, ALPR_Plate[playerid]);

	ALPR_Hit{playerid} = true;

	SetTimerEx("HideALPR", 8000, false, "d", playerid);
	return true;
}*/

FUNX::HideALPR(playerid)
{
    if(!ALPR_Hit{playerid}) return true;

    TextDrawHideForPlayer(playerid, ALPR_UI[0]);
	TextDrawHideForPlayer(playerid, ALPR_UI[1]);

	PlayerTextDrawHide(playerid, ALPR_Plate[playerid]);

	ALPR_Hit{playerid} = false;
	return true;
}
