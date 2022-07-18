// Defines

#define MAX_FURNITURE (300)
#define MAX_FURNITURE_PERPAGE (40)

// Variables

enum E_FURNITURE_DATA
{
	fID,
	fModel,
	fObject,
	fName[46],
	fMarketPrice,
	Float:fPosX,
	Float:fPosY,
	Float:fPosZ,
	Float:fPosRX,
	Float:fPosRY,
	Float:fPosRZ,
	fLocked,
	bool:fOpened,
	fOn
};

new const fCategory[][] =
{
    "Appliances",
	"Comfort",
	"Decorations",
	"Entertainment",
	"Lighting",
	"Plumbing",
	"Storage",
	"Surfaces",
	"Miscellaneous",
	"Special"
};

enum subCatalogE
{
    catid,
    subname[20],
}

new const fSubCategory[][subCatalogE] =
{
	{0, "Refrigerators"},
	{0, "Stoves"},
	{0, "Trash Cans"},
	{0, "Small Appliances"},
	{0, "Dumpsters"},
	{1, "Beds"},
	{1, "Chairs"},
	{1, "Arm Chairs"},
	{1, "Couches"},
	{1, "Stools"},
	{2, "Curtains"},
	{2, "Flags"},
	{2, "Rugs"},
	{2, "Statues"},
	{2, "Towels"},
	{2, "Paintings"},
	{2, "Plants"},
	{2, "Posters"},
	{3, "Sporting Equipment"},
	{3, "Televistions"},
	{3, "Gaming Machines"},
	{3, "Media Players"},
	{3, "Stereos"},
	{3, "Speakers"},
	{4, "Lamps"},
	{4, "Sconces"},
	{4, "Ceiling Lights"},
	{4, "Neon Lights"},
	{5, "Toilets"},
	{5, "Sinks"},
	{5, "Showers"},
	{5, "Bath Tubs"},
	{6, "Safe"},
	{6, "Book Shelves"},
	{6, "Dressers"},
	{6, "Filing Cabinets"},
	{6, "Pantries"},
	{7, "Dining Tables"},
	{7, "Coffee Tables"},
	{7, "Counters"},
	{7, "Display Cabinets"},
	{7, "Display Shelves"},
	{7, "TV Stands"},
	{8, "Clothes"},
	{8, "Consumables"},
	{8, "Doors"},
	{8, "Mess"},
	{8, "Miscellaneous"},
	{8, "Pillars"},
	{8, "Security"},
	{8, "Office"},
	{8, "Toys"},
	{9, "Animals"},
	{9, "Gambling"},
	{9, "Gang Tags"},
	{9, "Party"},
	{9, "Effects"},
	{9, "Walls"},
	{9, "Walls (Doorway)"},
	{9, "Walls (Open Window)"},
	{9, "Walls (Thin)"},
	{9, "Walls (Wide)"},
	{9, "Glass"},
	{9, "Stairs"}
};

new HouseFurniture[MAX_PROPERTIES][MAX_FURNITURE][E_FURNITURE_DATA];
new BizFurniture[MAX_BUSINESS][MAX_FURNITURE][E_FURNITURE_DATA];

enum E_FURNITURE_ITEMS_DATA
{
    furnitureCatalog,
    furnitureSubCatalog,
    furnitureModel,
    furnitureName[46],
    furniturePrice,
}

new const FurnitureItems[][E_FURNITURE_ITEMS_DATA] =
{
	{0,0, 1780, "Freezer", 5500},
	{0,0, 2127, "LoveSet Red Refrigerator",7820},
	{0,0, 2131, "Creamy Metal Refrigerator",7820},
	{0,0, 2147, "Old Town Refrigerator",7820},
	{0,1, 2017, "Maggie's Co. Stove",2400},
	{0,1, 2135, "Sterling Co. Stove",3000},
	{0,1, 2144, "Old Town Stove",2100},
	{0,1, 2294, "LoveSet Stove",4500},
	{0,1, 2340, "Creamy Metal Stove",4500},
	{0,2, 1235, "Transparent Sides Trash Can", 50},
	{0,2, 1300, "Stone Trash Can", 140},
	{0,2, 1328, "Aluminum Lid Trash Can", 15},
	{0,2, 1329, "Ghetto Trash Can", 10},
	{0,2, 1330, "Trash Bag Covered Trash Can", 12},
	{0,2, 1337, "Tall Rolling Trash Can", 70},
	{0,2, 1339, "Light Blue Rolling Trash Can", 70},
	{0,2, 1347, "Street Trash Can", 40},
	{0,2, 1359, "Metal Plate Trash Can", 60},
	{0,2, 1371, "Hippo Trash Can", 200},
	{0,2, 1574, "White Trash Can", 501},
	{0,2, 2770, "Cluck n Bell Trash Can", 80},
	{0,3, 2149, "Microwave", 100},
	{0,3, 2426, "Toaster Oven", 150},
	{0,4, 1331, "Recycle Dumpster", 1400},
	{0,4, 1332, "Glass Recycle Dumpster", 1400},
	{0,4, 1333, "Orange Dumpster", 1200},
	{0,4, 1334, "Blue Dumpster", 1200},
	{0,4, 1335, "Clothes Recycle Dumpster", 1400},
	{0,4, 1336, "Blue Compact Dumpster", 1200},
	{0,4, 1372, "Regular Street Dumpster", 2000},
	{0,4, 3035, "Black Compact Dumpster", 1200},
	{0,4, 1415, "Packed Regular Street Dumpster", 2000},
	{1,0, 1700, "Pink Queen Bed", 5750},
	{1,0, 1701, "Royal Brown Queen Bed", 6100},
	{1,0, 1745, "Green & White Backboard Queen Bed", 6200},
	{1,0, 1793, "Stack of Mattresses", 2850},
	{1,0, 1794, "Brown Wooden Queen Bed", 6450},
	{1,0, 1795, "Basic Beach Bed", 6500},
	{1,0, 1796, "Brown Wooden Quilted Bed", 4200},
	{1,0, 1797, "Basic Bed & Stylish Legs", 5000},
	{1,0, 1798, "Basic Beach Single Bed", 7050},
	{1,0, 1799, "Brown Quilted Yellow Queen Bed", 5640},
	{1,0, 1800, "Metal Prison Bed", 1520},
	{1,0, 1801, "White Wooden Queen Bed", 7000},
	{1,0, 1802, "Floral Quilt Wooden Queen Bed", 7200},
	{1,0, 1803, "Floral Quilt Wooden Queen Bed (Overhead)", 7300},
	{1,0, 1812, "Shiny Metal Prison Bed", 1800},
	{1,0, 2299, "Brown Quilted Queen Bed", 5640},
	{1,0, 2302, "Cabin Bed", 3900},
	{1,0, 2603, "White Police Cell Bed", 1800},
	{1,0, 14866, "Tropical Sand Queen Bed", 9150},
	{1,0, 14446, "King Size Zebra Styled Bed", 10200},
	{1,1, 1663, "Swivel Chair", 400},
	{1,1, 1671, "Arms Rest Swivel Chair", 410},
	{1,1, 1720, "Wooden Chair", 500},
	{1,1, 1721, "Metallic Chair", 500},
	{1,1, 1739, "Dining Chair", 500},
	{1,1, 11685, "Brown Thick Silk Armchair", 1080},
	{1,1, 2356, "Office Chair", 700},
	{1,1, 19996, "Fold Chair", 200},
	{1,1, 19994, "Oval Wooden Chair", 1090},
	{1,1, 2079, "Green Wooden Dining Chair", 1100},
	{1,1, 2120, "Black Wooden Dining Chair", 1150},
	{1,1, 2121, "Foldable Red Chair", 400},
	{1,1, 2122, "White Dining Chair", 800},
	{1,1, 2123, "White Dining Chair Wooden Legs", 900},
	{1,1, 2124, "Light Brown Wooden Dining Chair", 850},
	{1,1, 19994, "Dark Color Wooden Chair Metallic Legs", 1400},
	{1,1, 1806, "Navy Wheeled Office Chair", 725},
	{1,1, 2636, "Pizza Chair", 1150},
	{1,1, 2724, "Black Metallic Strip Chair", 1350},
	{1,1, 2777, "Black Metallic Strip Chair", 1325},
	{1,1, 2788, "Red & Green Metallic Burger Chair", 1350},
	{1,2, 1724, "Black Silk Arm Chair", 3000},
	{1,2, 1705, "Brown Silk Arm Chair", 3000},
	{1,2, 1707, "Chevy Arm Chair", 3500},
	{1,2, 1708, "Blue Business Arm Chair", 3800},
	{1,2, 1711, "Basic Arm Chair", 2000},
	{1,2, 1727, "Black Leather Arm Chair", 4000},
	{1,2, 1729, "Egg Shaped Basic Arm Chair", 1800},
	{1,2, 1735, "Flowered Style Country Arm Chair", 1750},
	{1,2, 1755, "Cold Autumn Styled Arm Chair", 1700},
	{1,2, 1758, "Autumn Styled Arm Chair", 1500},
	{1,2, 1759, "Basic Flower Styled Arm Chair", 1450},
	{1,2, 1762, "Basic Wooden Arm Chair", 2000},
	{1,2, 1765, "Basic Polyester Tiled Arm Chair", 1850},
	{1,2, 1767, "Basic Indian Styled Arm Chair", 1800},
	{1,2, 1769, "Blue Cotton Arm Chair", 1450},
	{1,2, 2096, "Rocking Chair", 2010},
	{1,2, 11682, "Brown Thick Silk Armchair", 3550},
	{1,3, 1702, "Brown Silk Couch", 5000},
	{1,3, 1703, "Black Silk Couch", 5000},
	{1,3, 1706, "Purple Cotton Couch", 4750},
	{1,3, 1710, "Long x2 Basic Couch", 4600},
	{1,3, 1712, "Long Basic Couch", 4250},
	{1,3, 1713, "Blue Business Couch", 5850},
	{1,3, 1756, "Basic Indian Styled Couch", 3800},
	{1,3, 1757, "Autumn Styled Couch", 3600},
	{1,3, 1760, "Cold Autumn Styled Couch", 3500},
	{1,3, 1761, "Basic Wooden Couch", 4050},
	{1,3, 1763, "Basic Flower Styled Couch", 3500},
	{1,3, 1764, "Basic Polyester Tiled Couch", 3950},
	{1,3, 1768, "Blue Cotton Couch", 3650},
	{1,3, 2290, "Thick Silk Couch", 6650},
	{1,3, 11689, "Booth", 6000},
	{1,4, 1716, "Metal Stool", 650},
	{1,4, 1805, "Short Red Cotton Stool", 525},
	{1,4, 2293, "Thick Silk Foot Stool", 1000},
	{1,4, 2350, "Red Cotton Stool", 425},
	{1,4, 2723, "Retro Metal Stool", 700},
	{2,0, 2558, "Green Curtains", 750},
	{2,0, 2561, "Wide Green Curtains", 900},
	{2,1, 2048, "Confederate Flag", 500},
	{2,1, 2614, "USA Flags", 500},
	{2,1, 11245, "USA Flags", 750},
	{2,1, 2914, "Green Flag", 300},
	{2,2, 2631, "Red Mat", 350},
	{2,2, 2632, "Turquoise Mat", 350},
	{2,2, 1828, "Tiger Rug", 3000},
	{2,2, 2815, "Runway Rug", 510},
	{2,2, 2817, "Bubbles Rug", 300},
	{2,2, 2818, "Red & Orange Tile Bath Rug", 320},
	{2,2, 2833, "Royal Tan Rug", 550},
	{2,2, 2834, "Plain Tan Rug", 500},
	{2,2, 2835, "Ovan Tan Rug", 430},
	{2,2, 2836, "Royal Diamond Rug", 600},
	{2,2, 2841, "Oval Water Tile Rug", 372},
	{2,2, 2842, "Pink Diamond Rug", 323},
	{2,2, 2847, "Sand Styled Rug", 300},
	{2,3, 3471, "Ancient Chinese Lion Statue", 10050},
	{2,3, 3935, "Headless Armless Woman Statue", 8000},
	{2,3, 14467, "Big Smoke Statue", 18000},
	{2,3, 14608, "Huge Buddha Statue", 50000},
	{2,3, 3528, "Dragon Head Statue", 25000},
	{2,3, 2743, "Crying Man Statue", 15000},
	{2,3, 1736, "Moose Head", 5000},
	{2,4, 1640, "Green Striped Towel", 250},
	{2,4, 1641, "Blue R* Towel", 200},
	{2,4, 1642, "White Sprinkled Red Towel", 300},
	{2,4, 1643, "Wayland Towel", 245},
	{2,5, 2289, "City Painting", 2250},
	{2,5, 2287, "Boats Painting", 1500},
	{2,5, 2286, "Ship Painting", 1000},
	{2,5, 2285, "Abstract Painting", 900},
	{2,5, 2284, "Building Painting", 1500},
	{2,5, 2274, "Abstract Painting", 2300},
	{2,5, 2282, "Landscape Painting", 1300},
	{2,5, 2281, "Landscape Painting", 1300},
	{2,5, 2280, "Landscape Painting", 1500},
	{2,5, 2279, "Landscape Painting", 1400},
	{2,5, 2278, "Boat Painting", 950},
	{2,5, 2277, "Cat Painting", 1000},
	{2,5, 2276, "Bridge Painting", 1200},
	{2,5, 2275, "Fruits Painting", 1000},
	{2,5, 2274, "Flowers Painting", 1500},
	{2,5, 2273, "Flowers Painting", 1250},
	{2,5, 2272, "Landscape Painting", 800},
	{2,5, 2271, "Abstract Painting", 750},
	{2,5, 2270, "Leaves Painting", 1250},
	{2,5, 2269, "Landscape Painting", 1100},
	{2,5, 2268, "Cat Painting", 1000},
	{2,5, 2267, "Ship Painting", 1000},
	{2,5, 2266, "City Painting", 850},
	{2,5, 2265, "Landscape Painting", 1400},
	{2,5, 2264, "Beach Painting", 1350},
	{2,5, 2263, "City Painting", 1500},
	{2,5, 2262, "City Painting", 1450},
	{2,5, 2261, "Bridge Painting", 1500},
	{2,5, 2260, "Boat Painting", 1000},
	{2,5, 2259, "Landscape Painting", 800},
	{2,5, 2258, "Landscape Painting", 2000},
	{2,5, 2257, "Abstract Painting", 1200},
	{2,5, 2256, "Landscape Painting	", 2250},
	{2,5, 2255, "Candy Suxx Painting", 4500},
	{2,6, 859, "Plant Top", 350}, //Decorations => Plants
	{2,6, 860, "Bushy Plant Top", 375},
	{2,6, 861, "Tall Plant Top", 345},
	{2,6, 862, "Tall Orange Plant Top", 400},
	{2,6, 863, "Cactus Top", 700},
	{2,6, 638, "Planted Bush", 2500},
	{2,6, 640, "Long Planted Bush", 3000},
	{2,6, 948, "Dry Plant Pot", 800},
	{2,6, 949, "Normal Plant Pot", 100},
	{2,6, 950, "Big Dry Plants Pot", 1200},
	{2,6, 2001, "Long Plants Pots", 1350},
	{2,6, 2010, "Long Plants Pot 2", 1400},
	{2,6, 2011, "Long Plants Pot 3", 1500},
	{2,6, 2194, "Short Plants Pot", 700},
	{2,6, 2195, "Short Plants Pot 2", 900},
	{2,6, 2203, "Empty Pot", 200},
	{2,6, 2240, "Weeds In Red Pot", 1350},
	{2,6, 2241, "Rusty Pottery Plant", 1200},
	{2,6, 2242, "Empty Red Pot", 350},
	{2,6, 2244, "Plants With Big Wooden Pot", 1500},
	{2,6, 2243, "Red Flowers With Wide Modern Pot", 1400},
	{2,6, 2246, "Empty White Vase", 2000},
	{2,6, 2247, "Oriental Plants In Glass Vase", 1650},
	{2,6, 2248, "Empty Tall Red Vase", 1000},
	{2,6, 2249, "Oriental Flowers In Glass Vase", 1500},
	{2,6, 2250, "Spring Flowers In Glass Vase", 1200},
	{2,6, 2251, "Oriental Flowers In blue Designer Glass", 1600},
	{2,6, 2252, "Small Bowl Plant", 1000},
	{2,6, 2253, "Red Flowers In Wooden Cube", 1500},
	{2,6, 2345, "Vines", 700},
	{2,6, 3802, "Hanging Red Flowers", 2250},
	{2,6, 3806, "Wall Mounted Flowers", 2500},
	{2,6, 3810, "Hanging Flowers", 2250},
	{2,6, 3811, "Wall Mounted Flowers With Dandelion", 3000},
	{2,6, 861, "Dark Exotic Plants", 2400},
	{2,6, 2195, "Potted Shrub", 1200},
	{2,7, 2049, "Shooting Target", 140},  //Decorations => Posters
	{2,7, 2050, "Shooting Targets", 140},
	{2,7, 2051, "Inverted Shooting Target", 140},
	{2,7, 2691, "Base 5 Poster", 140},
	{2,7, 2695, "Thin Bare 5 Poster", 70},
	{2,7, 2696, "Thin Bare 5 Dog Poster", 70},
	{2,7, 2692, "Wheelchairster cutout Poster", 200},
	{2,7, 2693, "Nino Cutout Poster", 200},
	{2,7, 19328, "Filthy Chicks Poster", 140},
	{2,7, 2646, "Candy Suxx Set Poster", 140},
	{3,0, 1985, "Punching Bag", 5000}, // Entertainment => Sporting Equipment
	{3,0, 2627, "Treadmill", 13000},
	{3,0, 2628, "Weight Lifting Bench", 7500},
	{3,0, 2629, "Weight Lifting Bench", 7500},
	{3,0, 2916, "One Dumbbell", 2500},
	{3,0, 2915, "Two Dumbells", 5000},
	{3,0, 2630, "Exercise Bike", 10000},
	{3,0, 2964, "Blue Pool Table", 15000},
	{3,0, 14651, "Green Pool Table", 15000},
	{3,0, 338, "Pool Cue", 700},
	{3,0, 3003, "Pool: Cue Ball", 1500},
	{3,0, 3106, "Pool: 8 Ball", 1000},
	{3,0, 3105, "Pool: Red Solid Ball", 700},
	{3,0, 3104, "Pool: Green Solid Ball", 700},
	{3,0, 3103, "Pool: Orange Solid Ball", 700},
	{3,0, 3101, "Pool: Red Solid Ball", 700},
	{3,0, 3100, "Pool: Blue Solid Ball", 700},
	{3,0, 3002, "Pool: Yellow Solid Ball", 700},
	{3,0, 2997, "Pool: Maroon Stripe Ball", 700},
	{3,0, 3000, "Pool: Green Stripe Ball", 700},
	{3,0, 2999, "Pool: Orange Stripe Ball", 700},
	{3,0, 2997, "Pool: Red Stripe Ball", 700},
	{3,0, 2996, "Pool: Blue Stripe Ball", 700},
	{3,0, 2995, "Pool: Yellow Stripe Ball	", 700},
	{3,0, 946, "Hanging Basketball Goal", 3000},
	{3,0, 3065, "Basketball", 1100},
	{3,1, 2316, "Small Black Television", 3800}, // Entertainment => Televisions
	{3,1, 2320, "Wooden Television", 4550},
	{3,1, 2317, "Rusty Television", 4000},
	{3,1, 2322, "Dark Wooden Television", 4500},
	{3,1, 1429, "Wooden White Television", 4550},
	{3,1, 1791, "Tall Black Television", 5000},
	{3,1, 2595, "Television On Top Of DVD", 3600},
	{3,1, 14532, "Rolling Television Stand", 4000},
	{3,1, 2596, "Mounted Black Television", 4300},
	{3,1, 1751, "White Metal Television", 4700},
	{3,1, 2648, "Tall Black Television", 5000},
	{3,1, 1781, "Slim Tall Black Television", 5300},
	{3,1, 1752, "Medium Black Television", 4200},
	{3,1, 2224, "Orange Sphere Television", 5000},
	{3,1, 1792, "Slim Grey Television", 5200},
	{3,1, 19787, "Large Wide Television", 5500},
	{3,2, 1515, "Triple Play Poker Machine", 20000}, // Entertainment => Gaming Machines
	{3,2, 2778, "Bee Be Gone Arcade Machine", 17500},
	{3,2, 2779, "Duality Arcade Machine", 17500},
	{3,2, 2028, "Xbox 360 Console	2028", 10000},
	{3,3, 1782, "HI-DE DVD Player", 3240}, // Entertainment => Media Players
	{3,3, 1783, "DVR620 DVD Player", 3500},
	{3,3, 1785, "Sunny DVD Player", 4400},
	{3,3, 1787, "BD655 Blu-Ray Player", 4300},
	{3,3, 1788, "BD670 Blu-Ray Player", 4500},
	{3,4, 2100, "Stereo System & Speakers", 2025}, // Entertainment => Stereos
	{3,4, 2101, "Stereo System", 2500},
	{3,4, 2102, "Retro Boombox", 2800},
	{3,4, 2103, "White Boombox ", 3000},
	{3,4, 2104, "Stereo System Stand", 3400},
	{3,4, 2226, "Boombox", 3500},
	{3,5, 2229, "Metal Plate Speaker", 13000}, // Entertainment => Speakers
	{3,5, 2230, "Wooden Speaker", 12000},
	{3,5, 2231, "Wooden Speaker Amplifier", 7000},
	{3,5, 2232, "Metal Plate Speaker Amplifier", 9000},
	{3,5, 2233, "Futuristic Speaker", 13000},
	//Lamps
	{4,0, 2238, "Lava Lamp", 900},
	{4,0, 2196, "Work Lamp", 800},
	{4,0, 2026, "White Lamp", 860},
	{4,0, 2726, "Red Lamp", 860},
	{4,0, 3534, "Red Lamp Style 2", 860},
	//Sconces
	{4,1, 1731, "Gray Sconce", 1500},
	{4,1, 3785, "Bulkhead Light", 1600},
	//Ceilinglights
	{4,2, 2075, "Long Bulb Ceiling Light", 2500},
	{4,2, 2073, "Brown Threaded Ceiling Light", 3200},
	{4,2, 2074, "Hanging Light Bulb", 200},
	{4,2, 2075, "Romantic Red Ceiling Light", 3500},
	{4,2, 2076, "Hanging Bowl Ceiling Light", 3000},
	{4,2, 16779, "Wooden Ceiling Fan", 3300},
	//Neonlights
	{4,3, 18647, "Red Neon Light", 3200},
	{4,3, 18648, "Blue Neon Light", 3200},
	{4,3, 18649, "Green Neon Light", 3200},
	{4,3, 18650, "Yellow Neon Light", 3200},
	{4,3, 18651, "Pink Neon Light", 3200},
	{4,3, 18652, "White Neon Light", 3200},
	//Toilets
	{5,0, 2514, "Plain Toilet", 3750},
	{5,0, 2521, "White Metal Toilet	", 5000},
	{5,0, 2525, "Sauna Toilet", 5000},
	{5,0, 2528, "Black Wooden Toilet", 5500},
	//Sinks
	{5,1, 2013, "Maggie's Co. Sink", 3850},
	{5,1, 2130, "LoveSet Sink", 4900},
	{5,1, 2132, "Creamy Metal Sink", 4600},
	{5,1, 2136, "Sterlin Co. Metal Sink", 3000},
	{5,1, 2150, "Old Town Sink Pt.2", 500},
	{5,1, 2518, "Wooden Snow White Sink", 3850},
	{5,1, 2523, "Bathroom Sink With Pad", 2550},
	{5,1, 2524, "Sauna Bathroom Sink", 2200},
	{5,1, 2739, "Bare Bathroom Sink", 1700},
	//Showers
	{5,2, 2517, "Silver Glass Shower", 8000},
	{5,2, 2520, "Dark Metal Shower	", 7550},
	{5,2, 2527, "Sauna Shower	", 7000},
	//Bathtubs
	{5,3, 2097, "Sprunk Bath Tub", 8000},
	{5,3, 2516, "Sparkly White Bath Tub", 7500},
	{5,3, 2519, "White Bath Tub", 7900},
	{5,3, 2522, "Dark Wooden Bath Tub", 8200},
	{5,3, 2526, "Sauna Wooden Bath Tub", 8500},
	//Safe
	{6,0, 2332, "Sealed Safe", 10000},
	//Bookshelves
	{6,1, 1742, "Half Empty Book Shelf", 3000},
	{6,1, 14455, "Large Green Book Shelves", 3000},
	{6,1, 2608, "Three Wooden Level Book Shelf", 2500},
	//Dressers
	{6,2, 2330, "Standard Wooden Dresser", 3250},
	{6,2, 2323, "Light Wooden Dresser Bottom Opening Legs", 3500},
	{6,2, 2088, "Long Light Wooden Dresser Legs", 4300},
	//Filling Cabinets
	{6,3, 2000, "Metal Filing Cabinet", 1500},
	{6,3, 2007, "Double Filing Cabinet", 3000},
	{6,3, 2163, "Wall Mounted Filing Cabinet", 900},
	{6,3, 2200, "Tall Wall Mounted Filing Cabinet", 1200},
	{6,3, 2197, "Brown Metal Filing CabinetAME", 1500},
	{6,3, 2167, "Big Oak Filing Cabinet", 3000},
	//Pantries
	{6,4, 2128, "LoveSet Pantry", 3000},
	{6,4, 2140, "Sterlin Co. Pantry", 2000},
	{6,4, 2141, "Creamy Metal Pantry", 2500},
	{6,4, 2145, "Old Town Pantry", 2500},
	{6,4, 2153, "Wooden Snow White Pantry", 2000},
	{6,4, 2158, "Mahogany Green Wood Pantry", 2000},
	//Diningtables
	{7,0, 2357, "Long Wooden Table", 2500},
	{7,0, 2118, "Marble Top Table", 3000},
	{7,0, 2117, "Pine Wood Table", 3000},
	{7,0, 2115, "Oak Wood Table", 4700},
	{7,0, 2110, "Basic Wood Table", 1500},
	{7,0, 15037, "Table With TV", 4000},
	//Coffeetables
	{7,1, 1813, "Basic Oak Coffee Table", 5750},
	{7,1, 1814, "Fancy Oak Coffee Table/Drawers", 5500},
	{7,1, 1815, "Oval Coffee Table", 3750},
	{7,1, 1817, "Fancy Oak Coffee Table	", 5500},
	{7,1, 1818, "Square Oak Coffee Table", 5750},
	{7,1, 1819, "Fancy Circle Coffee Table", 4500},
	{7,1, 1820, "Basic Circle Coffee Table", 3750},
	{7,1, 1822, "Mahogany Oval Coffee Table", 3750},
	{7,1, 1823, "Mahogany Square Coffee Table", 4500},
	{7,1, 2126, "Ebony Wood Basic Coffee Table", 3750},
	//Counters
	{7,2, 2014, "Maggie's Co. Counter Top", 950},
	{7,2, 2015, "Maggie's Co. Counter Right Handle", 1000},
	{7,2, 2016, "Maggie's Co. Counter Left Handle", 2000},
	{7,2, 2019, "Maggie's Co. Blank Counter Top", 4000},
	{7,2, 2022, "Maggie's Co. Corner Counter Top", 4000},
	{7,2, 2129, "LoveSet Counter Top", 2000},
	{7,2, 2133, "Creamy Metal Counter Top", 2000},
	{7,2, 2137, "Sterlin Co. Cabinet Top", 3500},
	{7,2, 2138, "Sterlin Co. Counter Top", 3500},
	{7,2, 2139, "Sterlin Co. Counter", 3500},
	{7,2, 2142, "Old Town Counter", 2000},
	{7,2, 2151, "Wooden Snow White Counter Top", 3250},
	{7,2, 2152, "Wooden Snow White Cabinete Counter", 2750},
	{7,2, 2153, "Wooden Snow White Counter", 3000},
	{7,2, 2156, "Mahogany Green Wood Counter", 2000},
	{7,2, 2159, "Mahogany Green Wood Cabinet Counter", 3000},
	{7,2, 2414, "Laguna Wooden Counter", 2200},
	{7,2, 2424, "Light Blue IceBox Counter", 2100},
	{7,2, 2423, "Light Blue IceBox Corner Counter	", 2100},
	{7,2, 2435, "November Wood Counter", 2100},
	{7,2, 2434, "November Wood Corner Counter", 2100},
	{7,2, 2439, "Dark Marble Diamond Counter", 4000},
	{7,2, 2440, "Dark Marble Diamond Corner Counter", 4000},
	{7,2, 2441, "Marble Zinc Top Counter", 4200},
	{7,2, 2442, "Marble Zinc Top Corner Counter", 6000},
	{7,2, 2445, "Marble Zinc Top Counter (Regular)", 2500},
	{7,2, 2444, "Marble Zinc Top Counter (Half Design)", 2500},
	{7,2, 2446, "Parlor Red Counter", 2000},
	{7,2, 2450, "Parlor Red Corner Counter", 2000},
	{7,2, 2455, "Parlor Red Checkered Counter", 2000},
	{7,2, 2454, "Parlor Red Checkered Corner Counter", 2000},
	//Displaycabinets
	{7,3, 2046, "Basic Wooden Display Cabinet", 1450},
	{7,3, 2078, "Fancy Dark Wooden Display Cabinet", 2150},
	{7,3, 2385, "Glass Front Wooden Display Cabinet", 1750},
	{7,3, 2458, "Delicate Glass Wooden Display Cabinet", 1750},
	{7,3, 2459, "Long Delicate Glass Wooden Display Cabinet", 1750},
	{7,3, 2460, "Mini Delicate Glass Wooden Display Cabinet", 1750},
	{7,3, 2461, "Cubed Delicate Glass Wooden Display Cabinet", 1750},
	//Displayshelves
	{7,4, 2063, "Industrial Display Shelf", 2450},
	{7,4, 2210, "Black Metal Glass Display Shelf", 2750},
	{7,4, 2211, "Wooden Glass Display Shelf", 2750},
	{7,4, 2403, "Very Large Wooden Display Shelf", 16750},
	{7,4, 2462, "Wall Mounted Thin Wooden Display Shelf", 2750},
	{7,4, 2463, "Wall Mounted Thin Wooden Display Shelf", 3000},
	{7,4, 2708, "Wooden Display Shelf With Bar", 3200},
	{7,4, 2367, "Modern White Counter Display Shelf", 3500},
	{7,4, 2368, "Wooden Counter Display Shelf", 3500},
	{7,4, 2376, "Wooden & Glass Table Display Shelf", 3000},
	{7,4, 2447, "Tall Parlor Red Display Shelf", 2300},
	{7,4, 2448, "Wide Parlor Red Display Shelf", 2500},
	{7,4, 2449, "Tall & Wide Parlor Red Display Shelf", 3700},
	{7,4, 2457, "Parlor Red Checkered Display Shelf", 4500},
	//Tvstands
	{7,5, 2306, "Three Level Wooden TV Stand", 1500},
	{7,5, 2321, "Small Two Level TV Stand", 1700},
	{7,5, 2319, "Antique Oak TV Stand", 1350},
	{7,5, 2314, "Light Wooden Small TV Stand", 1950},
	{7,5, 2315, "Small Wooden TV Stand", 1700},
	{7,5, 2313, "Light Wooden TV Stand With VCR", 2500},
	{7,5, 2236, "Dark Mahogany TV Stand", 2900},
	//Miscellaneous
	//Clothes
	{8,0, 2374, "Blue Plaid Shirts Rail", 200},
	{8,0, 2377, "Black Levis Jeans Rail", 400},
	{8,0, 2378, "Black Levis Jeans Rail", 400},
	{8,0, 2381, "Row of Sweat Pants", 560},
	{8,0, 2382, "Row of Levis Jeans	", 1000},
	{8,0, 2383, "Yellow Shirts Rail", 200},
	{8,0, 2384, "Stack of Khaki Pants", 300},
	{8,0, 2389, "Red And White Sports Jacket Rail", 680},
	{8,0, 2390, "Green Sweat Pants Rail", 240},
	{8,0, 2391, "Khaki Pants Rail", 300},
	{8,0, 2392, "Row of Khakis & Levis Jeans", 950},
	{8,0, 2394, "Row of Shirts", 850},
	{8,0, 2396, "Black and Red Blazers Rail ", 1200},
	{8,0, 2397, "Grey Jeans Rail", 340},
	{8,0, 2398, "Blue Sweat Pants Rail", 240},
	{8,0, 2399, "Grey Sweatshirt Rail", 240},
	{8,0, 2401, "Red Sweat Pants Rail", 240},
	//Consumables
	{8,1, 1950, "Beer Bottle", 50},
	{8,1, 2958, "Beer Bottle", 50},
	{8,1, 1486, "Beer Bottle", 50},
	{8,1, 1543, "Beer Bottle", 50},
	{8,1, 1544, "Beer Bottle", 50},
	{8,1, 1520, "Scotch Bottle", 100},
	{8,1, 1644, "Wine Bottle", 150},
	{8,1, 1669, "Wine Bottle", 150},
	//Doors
	{8,2, 3109, "White Basic Door", 4000},
	{8,2, 19857, "Wooden Door With Small Window", 5500},
	{8,2, 3093, "Gate Door", 3000},
	{8,2, 2947, "Heavy Blue Door", 5750},
	{8,2, 2955, "White Basic Room Door", 4000},
	{8,2, 2946, "Golden Door", 5750},
	{8,2, 2930, "Small Cell Gate", 3000},
	{8,2, 977, "Old Office Door", 4000},
	{8,2, 1491, "Swinging Dark Wooden Door", 5000},
	{8,2, 1492, "White Wooden Door", 4500},
	{8,2, 1493, "Red Shop Door", 3500},
	{8,2, 1494, "Blue Wooden Door", 4500},
	{8,2, 1495, "Blue Wired Door", 3500},
	{8,2, 1496, "Metal Love Shop Door", 4500},
	{8,2, 1497, "Metal Door", 5000},
	{8,2, 1498, "Dirty White Door", 2600},
	{8,2, 1499, "Dirty Metal Door", 4700},
	{8,2, 1500, "Metal Screen Door", 4700},
	{8,2, 1501, "Wooden Screen Door", 4700},
	{8,2, 1502, "Swinging Wooden Door", 5000},
	{8,2, 1504, "Red Door", 4000},
	{8,2, 1505, "Blue Door", 4000},
	{8,2, 1506, "White Door", 4000},
	{8,2, 1507, "Yellow Door", 4000},
	{8,2, 1522, "Shop Door With Stickers", 3500},
	{8,2, 1532, "Shop Door With Stickers 2", 3500},
	{8,2, 1533, "Metal Shop Door", 4000},
	{8,2, 1523, "Swinging Metal Door With Window", 4500},
	{8,2, 1535, "Basic White Door", 4000},
	{8,2, 1569, "Modern Black Door", 4000},
	{8,2, 1559, "Modern Black Door Golden Frame", 5000},
	//Mess
	{8,3, 2670, "Random Mess", 5},
	{8,3, 2671, "Random Mess", 5},
	{8,3, 2673, "Random Mess", 5},
	{8,3, 2674, "Random Mess", 5},
	{8,3, 2867, "Random Mess", 5},
	{8,3, 2672, "Burger Shot Mess", 8},
	{8,3, 2675, "Burger Shot Mess", 8},
	{8,3, 2677, "Burger Shot Mess", 8},
	{8,3, 2840, "Burger Shot Mess", 8},
	{8,3, 2676, "Newspapers & Burger Shot Mess", 13},
	{8,3, 2850, "Dishes", 20},
	{8,3, 2843, "Messy Clothes", 50},
	{8,3, 2844, "Messy Clothes", 50},
	{8,3, 2845, "Messy Clothes", 50},
	{8,3, 2846, "Messy Clothes", 50},
	{8,3, 2851, "Dishes", 20},
	{8,3, 2821, "Cereal Box & Cans", 10},
	{8,3, 2822, "Blue Dishes", 30},
	{8,3, 2829, "Colorful Dishes", 30},
	{8,3, 2830, "Dishes", 30},
	{8,3, 2831, "Dishes & Colorful Cups", 30},
	{8,3, 2832, "Colorful Dishes", 40},
	{8,3, 2837, "Cluck N Bell Mess", 8},
	{8,3, 2838, "Pizza Stack Mess", 10},
	{8,3, 2839, "Chinese Food Mess", 7},
	{8,3, 2848, "Dishes With Pizza", 12},
	{8,3, 2850, "Dishes With Pizzaz", 13},
	{8,3, 2849, "Colorful Dishes", 30},
	{8,3, 2851, "Dishes", 20},
	{8,3, 2856, "Crushed Milk", 5},
	{8,3, 2857, "Pizza Box Mess", 6},
	{8,3, 2861, "Empty Cookie Boxes", 2},
	{8,3, 2866, "Empty Cookie Boxes & Cans", 4},
	//Miscellaneous
	{8,4, 2680, "Padlock", 700},
	{8,4, 1665, "Ashtray", 700},
	{8,4, 14774, "Electric Fly Killer", 2000},
	{8,4, 2961, "Fire Alarm Button", 900},
	{8,4, 2962, "Fire Alarm Button (Sign)", 700},
	{8,4, 2616, "Whiteboard", 3500},
	{8,4, 2611, "Blue Pinboard", 700},
	{8,4, 2612, "Blue Pinboard	", 700},
	{8,4, 2615, "Articles", 100},
	{8,4, 2896, "Casket", 10000},
	{8,4, 2404, "R* Surfboard", 2000},
	{8,4, 2405, "Red & Blue Surfboard", 2000},
	{8,4, 2406, "Vice City Surfboard", 2000},
	{8,4, 2410, "Wooden Surfboard", 2000},
	//Pillars
	{8,5, 3494, "Stone Pillar", 5300},
	{8,5, 3498, "Tall Wooden Pillar", 5200},
	{8,5, 3499, "Fat Tall Wooden Pillar", 5300},
	{8,5, 3524, "Pillar Skull Head", 5240},
	{8,5, 3533, "Red Dragon Pillar", 5150},
	{8,5, 3529, "Brick Construction Pillar", 5500},
	{8,5, 3503, "Metal Pole", 1850},
	//Security
	{8,6, 1622, "Security Camera", 3000},
	{8,6, 1616, "Security Camera", 3000},
	{8,6, 1886, "Security Camera", 3000},
	//Office
	{8,7, 1808, "Ja Water Dispenser", 150},
	{8,7, 1998, "Office Desk & Equipment", 1300},
	{8,7, 1999, "Office Light Wooden Desk & Computer", 1000},
	{8,7, 2002, "Water Dispenser", 150},
	{8,7, 2008, "Office White Top Desk & Equipment", 1200},
	{8,7, 2009, "White Office Desk & Computer", 1250},
	{8,7, 2161, "Office Shelf & Files", 80},
	{8,7, 2162, "Wide Office Shelf & Files", 160},
	{8,7, 2164, "Wide and Tall Office Shelf & Files", 300},
	{8,7, 2165, "Oak Office Desk & Equipment", 4500},
	{8,7, 2166, "Oak Office Desk & Files", 3800},
	{8,7, 2169, "White Office Desk With Wood Top", 2200},
	{8,7, 2171, "Wood Top Desk With Backboard", 2400},
	{8,7, 2172, "Blue Office Desk & Equipment", 5600},
	{8,7, 2173, "Oak Office Desk", 5000},
	{8,7, 2174, "Wood Top Desk With Backboard & Equipment", 2800},
	{8,7, 2175, "Wood Top Desk Corner", 1900},
	{8,7, 2180, "Wide Wooden Desk", 2500},
	{8,7, 2181, "Office Desk With Backboard & Computer", 2500},
	{8,7, 2308, "Office Desk & Files", 2200},
	{8,7, 2183, "Four Divided Wooden Desks", 8500},
	{8,7, 2184, "Diagonal Wooden Desk", 2000},
	{8,7, 2185, "Open Wooden Desk & Computer", 1000},
	{8,7, 2186, "Office Printer", 4000},
	{8,7, 2187, "Blue Cubicle Divider", 1000},
	{8,7, 2190, "Computer", 760},
	//Toys
	{8,8, 2511, "Toy Red Plane", 10},
	{8,8, 2471, "Three Train Toy Boxes", 20},
	{8,8, 2472, "Four Toy Red Planes", 40},
	{8,8, 2473, "Two Toy Red Planes", 20},
	{8,8, 2474, "Four Train Toys", 30},
	{8,8, 2477, "Three Hotwheels Stacked Boxes", 25},
	{8,8, 2480, "Four Hotwheels Stacked Boxes", 30},
	{8,8, 2481, "Hotwheels Box", 5},
	{8,8, 2483, "Train Model Box", 15},
	{8,8, 2484, "R* Boat Model", 25},
	{8,8, 2485, "Wooden Car Toy", 45},
	{8,8, 2487, "Tropical Diamond Kite", 30},
	{8,8, 2488, "Manhunt Toy Box Sets", 20},
	{8,8, 2490, "Vice City Toy Box Sets", 20},
	{8,8, 2497, "Pink Winged Box Kite", 35},
	{8,8, 2498, "Blue Winged Box Kite", 35},
	{8,8, 2499, "R* Diamond Kite", 30},
	{8,8, 2512, "Paper Wooden Plane", 30},
	//Special
	//Animals
	{9,0, 1599, "Bright Yellow Flouder", 300},
	{9,0, 1600, "Exotic Blue Flounder", 350},
	{9,0, 1604, "School of Blue Flounders", 600},
	{9,0, 1602, "Bright Jellyfish", 500},
	{9,0, 1603, "Jellyfish", 500},
	{9,0, 1604, "Blue Flounder", 300},
	{9,0, 1605, "School of Yellow Flounders", 600},
	{9,0, 1606, "School of Exotic Blue Flounders", 650},
	{9,0, 1607, "Dolphin", 5000},
	{9,0, 1608, "Shark", 5000},
	{9,0, 1609, "Turtle", 5000},
	{9,0, 19315, "Deer", 4500},
	{9,0, 19079, "Parrot", 1500},
	//Gambling
	{9,1, 1838, "Slot Machine", 10000},
	{9,1, 1831, "Slot Machine", 10000},
	{9,1, 1832, "Slot Machine", 10000},
	{9,1, 1833, "Slot Machine", 10000},
	{9,1, 1834, "Slot Machine", 10000},
	{9,1, 1835, "Slot Machine", 10000},
	{9,1, 1838, "Slot Machine", 10000},
	{9,1, 1978, "Roulette Table", 10000},
	{9,1, 1929, "Roulette Wheel", 10000},
	{9,1, 2188, "Blackjack Table", 10000},
	{9,1, 19474, "Poker Table 2", 10000},
	//Gangtags
	{9,2, 18659, "Grove St. 4 Life", 3000},
	{9,2, 1528, "Seville B.L.V.D Families", 3000},
	{9,2, 1531, "Varrio Los Aztecas", 3000},
	{9,2, 1525, "Kilo", 3000},
	{9,2, 1526, "San Fiero Rifa", 3000},
	{9,2, 18664, "Temple Drive Ballas", 3000},
	{9,2, 1530, "Los Santos Vagos", 3000},
	{9,2, 18666, "Front Yard Balas", 3000},
	{9,2, 1527, "Rollin Heights Ballas", 3000},
	//faction}
	{9,3, 19128, "Dance Floor", 15550},
	{9,3, 19129, "Large Dance Floor", 25000},
	{9,3, 19159, "Disco Ball", 6300},
	{9,3, 18656, "Club Lights ", 20000},
	{9,3, 19122, "Blue Bollard Light", 3000},
	{9,3, 19123, "Green Bollard Light", 3000},
	{9,3, 19126, "Light Blue Bollard Light", 3000},
	{9,3, 19127, "Purple Bollard Light", 3000},
	{9,3, 19124, "Red Bollard Light", 3000},
	{9,3, 19121, "White Bollard Light", 3000},
	{9,3, 19125, "Yellow Bollard Light", 3000},
	//Effect
	{9,4, 18864, "Snow Machine", 13500},
	{9,4, 18715, "Smoke Machine", 13500},
	{9,4, 19150, "Club Lights 1", 13500},
	{9,4, 19152, "Club Lights 2", 13500},
	//Walls
	{9,5, 19353, "Ice Cream Parlor Wall", 3000},
	{9,5, 19354, "Leather Diamond Wall", 3000},
	{9,5, 19355, "Cement Think Brick Wall", 3500},
	{9,5, 19356, "Wooden Wall", 3200},
	{9,5, 19357, "Cement Wall", 3500},
	{9,5, 19358, "Grey & Black Cotton Wall", 3200},
	{9,5, 19359, "Plain Tan Wall", 3300},
	{9,5, 19360, "Tough Light Wood Wall", 3300},
	{9,5, 19361, "Tan & Red Wall", 3300},
	{9,5, 19362, "Road Textured Wall", 3200},
	{9,5, 19363, "Plain Dark Pastel Pink Wall", 3400},
	{9,5, 19364, "Cement Brick Wall", 3500},
	{9,5, 19365, "Plain Light Blue Wall", 3300},
	{9,5, 19366, "Thick Wood Wall", 3400},
	{9,5, 19367, "Light Blue Spring Themed Wall", 3400},
	{9,5, 19368, "Light Pink Spring Themed Wall", 3400},
	{9,5, 19369, "Light Yellow Spring Themed Wall", 3300},
	{9,5, 19370, "Bright Wooden Wall", 3400},
	{9,5, 19371, "Plain Cement Wall", 3300},
	{9,5, 19372, "Sand Wall", 3400},
	{9,5, 19373, "Grass Wall", 3300},
	{9,5, 19375, "Wavey Wooden Wall", 3400},
	{9,5, 19376, "Red Wooden Wall", 3300},
	{9,5, 19377, "Carpet Textured Wall", 3400},
	{9,5, 19378, "Dark Wooden Wall", 3400},
	{9,5, 19379, "Basic Light Wood Wall", 3400},
	{9,5, 19380, "Dark Sand Wall", 3400},
	{9,5, 19381, "Dark Grass Wall", 3300},
	//Wallsdoorway
	{9,6, 19383, "Ice Cream Parlor Wall (Doorway)", 3000},
	{9,6, 19384, "Leather Diamond Wall (Doorway)", 3000},
	{9,6, 19391, "Cement Think Brick Wall (Doorway)", 3000},
	{9,6, 19386, "Wooden Wall (Doorway)", 3000},
	{9,6, 19387, "Cement Wall (Doorway)	", 3000},
	{9,6, 19388, "Grey & Black Cotton Wall (Doorway)", 3000},
	{9,6, 19389, "Plain Tan Wall (Doorway)", 3000},
	{9,6, 19390, "Tan & Red Wall (Doorway)", 3000},
	{9,6, 19385, "Road Textured Wall (Doorway)", 3000},
	{9,6, 19392, "Plain Dark Pastel Pink Wall (Doorway)", 3000},
	{9,6, 19393, "Cement Brick Wall (Doorway)", 3000},
	{9,6, 19394, "Plain Light Blue Wall (Doorway)", 3000},
	{9,6, 19395, "Light Blue Spring Themed Wall (Doorway)", 3000},
	{9,6, 19396, "Light Pink Spring Themed Wall (Doorway)", 3000},
	{9,6, 19397, "Light Yellow Spring Themed Wall (Doorway)", 3000},
	{9,6, 19398, "Plain Cement Wall (Doorway)", 3000},
	//Wallsopenwindow
	{9,7, 19399, "Ice Cream Parlor Wall (Open Window)", 3000},
	{9,7, 19400, "Leather Diamond Wall (Open Window)", 3000},
	{9,7, 19401, "Cement Think Brick Wall (Open Window)", 3300},
	{9,7, 19402, "Wooden Wall (Open Window)", 3000},
	{9,7, 19403, "Cement Wall (Open Window)", 3200},
	{9,7, 19404, "Grey & Black Cotton Wall (Open Window)", 3200},
	{9,7, 19405, "Plain Tan Wall (Open Window)", 3300},
	{9,7, 19407, "Tan & Red Wall (Open Window)", 3200},
	{9,7, 19408, "Road Textured Wall (Open Window)", 3300},
	{9,7, 19409, "Plain Dark Pastel Pink Wall (Open Window)", 3300},
	{9,7, 19410, "Cement Brick Wall (Open Window)", 3200},
	{9,7, 19411, "Plain Light Blue Wall (Open Window)", 3300},
	{9,7, 19412, "Thick Wooden Wall (Open Window)", 3300},
	{9,7, 19413, "Light Blue Spring Themed Wall (Open Window)", 3300},
	{9,7, 19414, "Light Pink Spring Themed Wall (Open Window)", 3200},
	{9,7, 19415, "Light Yellow Spring Themed Wall (Open Window)", 3300},
	{9,7, 19416, "Basic Light Wood Wall (Open Window)", 3300},
	{9,7, 19417, "Plain Cement Wall (Open Window)", 3200},
	//Wallsthin
	{9,8, 19426, "Ice Cream Parlor Wall (Thin)", 2000},
	{9,8, 19427, "Leather Diamond Wall (Thin)", 2000},
	{9,8, 19428, "Cement Think Brick Wall (Thin)", 2000},
	{9,8, 19429, "Wooden Wall (Thin)", 2000},
	{9,8, 19430, "Cement Wall (Thin)", 2000},
	{9,8, 19431, "Grey & Black Cotton Wall (Thin)", 2000},
	{9,8, 19432, "Plain Tan Wall (Thin)", 2000},
	{9,8, 19433, "Tan & Red Wall (Thin)", 2200},
	{9,8, 19435, "Road Textured Wall (Thin)", 2200},
	{9,8, 19436, "Plain Dark Pastel Pink Wall (Thin)", 2200},
	{9,8, 19437, "Cement Brick Wall (Thin)", 2200},
	{9,8, 19438, "Plain Light Blue Wall (Thin)", 2200},
	{9,8, 19439, "Thick Wooden Wall (Thin)", 2300},
	{9,8, 19440, "Light Blue Spring Themed Wall (Thin)", 2300},
	{9,8, 19441, "Light Pink Spring Themed Wall (Thin)", 2300},
	{9,8, 19442, "Light Yellow Spring Themed Wall (Thin)", 2400},
	{9,8, 19443, "Basic Light Wood Wall (Thin)", 2400},
	{9,8, 19444, "Plain Cement Wall (Thin)", 2500},
	//Wallswide
	{9,9, 19445, "Ice Cream Parlor Wall (Wide)", 6200},
	{9,9, 19446, "Leather Diamond Wall (Wide)", 6200},
	{9,9, 19447, "Cement Think Brick Wall (Wide)", 6500},
	{9,9, 19448, "Wooden Wall (Wide)", 6200},
	{9,9, 19449, "Cement Wall (Wide)", 6500},
	{9,9, 19450, "Grey & Black Cotton Wall (Wide)", 6300},
	{9,9, 19451, "Plain Tan Wall (Wide)", 6300},
	{9,9, 19452, "Red Wooden Wall (Wide)", 6300},
	{9,9, 19453, "Tan & Red Wall (Wide) ", 6300},
	{9,9, 19454, "Carpet Textured Wall (Wide)	", 6300},
	{9,9, 19455, "Plain Dark Pastel Pink Wall (Wide)", 6300},
	{9,9, 19456, "Cement Brick Wall (Wide)", 6500},
	{9,9, 19457, "Plain Light Blue Wall (Wide)", 6300},
	{9,9, 19458, "Thick Wooden Wall (Wide)", 6300},
	{9,9, 19459, "Light Blue Spring Themed Wall (Wide)", 6300},
	{9,9, 19460, "Light Pink Spring Themed Wall (Wide)", 6300},
	{9,9, 19461, "Light Yellow Spring Themed Wall (Wide)", 6300},
	{9,9, 19462, "Basic Light Wood Wall (Wide)", 6300},
	{9,9, 19463, "Plain Cement Wall (Wide)", 6300},
	//Glass
	{9,10, 19466, "Regular Glass", 3000},
	{9,10, 1651, "Glass", 3000},
	{9,10, 1649, "Long Glass", 6000},
	{9,10, 1651, "Tall Glass", 4000},
	{9,10, 19325, "Unbreakable Glass", 7000},
	//Stairs
	{9,11, 3399, "Stairs 1", 1000},
	{9,11, 14411, "Stairs 2", 1000},
	{9,11, 14874, "Stairs 3", 1000}
};

enum E_MATERIAL_DATA
{
    mModel,
    mtxd[32],
    mtexture[32],
    mName[35],
};

new const MaterialData[][E_MATERIAL_DATA] =
{
	{4242,"seabed","des_dirt1", "Sand"},
	{3942, "bistro", "mp_snow", "Snow"},
	{3942, "bistro", "ahoodfence2", "Flagstone"},
	{3908, "libertyfar", "Grass_128HV", "Grass"},
	{3903, "libertyhi", "Grass", "Grass 2"},
	{3953, "rczero_track", "waterclear256", "Clear water"},
	{3933, "weemap", "rocktb128", "Grey rocks"},
	{4242, "seabed", "des_dirt1", "Dirty sand"},
	{4242, "seabed", "sw_sand", "Dirty sand 2"},
	{16008, "des_n", "des_ripplsand", "Dunes on the desert (Sahara)"},
	{13734, "hillcliff_lahills", "cobbles_kb_256", "Flagstone 2 (LS lighthouse)"},
	{16503, "desert", "des_redrock1", "Red rocks (from desert)"},
	{16407, "des_airfieldhus", "btdeck256", "Wood floor 2 (brighter)"},
	{16102, "des_cen", "sm_conc_hatch", "Yellow stripes (on the floor)"},
	{16021, "des_geyser", "shingles1", "Roof with dark grey colour"},
	{16016, "des_n", "ranchwall1", "Wall with rocks (looks nice)"},
	{16571, "des_se1", "des_crackeddirt1", "Cracked ground"},
	{18752, "Volcano","rocktb128", "Grey rocks"},
	{18752, "Volcano","lavalake", "Lava"},
	{18752, "Volcano","redgravel", "Ground under the lava"},
	{16503, "desert","des_redrock1", "Red rocks (from desert)"},
	{16407, "des_airfieldhus","btdeck256", "Wood floor 2 (brighter)"},
	{16102, "des_cen","sm_conc_hatch", "Yellow stripes (on the floor)"},
	{16021, "des_geyser","shingles1", "Roof with dark grey colour"},
	{16016, "des_n","ranchwall1", "Wall with rocks (looks nice)"},
	{16571, "des_se1","des_crackeddirt1", "Cracked ground"},
	{19128, "dancefloors","dancefloor1", "Dance Floor"},
	{2068, "cj_ammo_net","CJ_cammonet", "Camo Net"},
	{18646, "matcolours","white", "White"},
	{18646, "matcolours","red", "Red"},
	{18646, "matcolours", "blue", "Blue"},
	{18646, "matcolours","orange", "Orange"},
	{18646, "matcolours","green", "Green"},
	{964, "cj_crate_will","CJ_FLIGHT_CASE", "Metal Plate"},
	{967, "cj_barr_set_1","Stop2_64", "Stop Sign"},
	{7981, "vgsairport02","chevronYB_64", "Black and Yellow stripes"},
	{7981, "vgsairport02","redwhite_stripe", "Red and White stripes"},
	{7980, "vegasairprtland","gridchev_64HV", "Black and Yellow mesh"},
	{7980, "vegasairprtland","chevron64HVa", "Yellow and White stripes"},
	{6866, "vgncnstrct1","Circus_gls_05", "Red Rectangles"},
	{1281, "benches","trafficcone", "Red and White stripes"},
	{6295, "lawland2","lightglass", "Large Mesh Glass"},
	{6295, "lawland2","boardwalk2_la", "Wood Planks"},
	{12938, "sw_apartments","sw_policeline", "Police Line"},
	{16004, "des_teepee","des_wigwam", "Wigwam Motel - Wall"},
	{16004, "des_teepee","des_wigwamdoor", "Wigwam Motel - Door"},
	{16004, "des_teepee","des_dustconc", "Concrete with Dust"},
	{16005, "des_stownmain2","sanruf", "Grey Roof"},
	{16005, "des_stownmain2","des_redslats", "Red Wooden Planks"},
	{16005, "des_stownmain2","duskyred_64", "Light Purple Color"},
	{16005, "des_stownmain2","des_ghotwood1", "Old Wooden Planks"},
	{16005, "des_stownmain2","ws_green_wall1", "Wall 1 (Green)"},
	{16005, "des_stownmain2","alleydoor3", "Door 1 (Blue)"},
	{16005, "des_stownmain2","newall4-4", "Wall 2 (Normal)"},
	{16005, "vdes_stownmain2","crencouwall1", "Wall 3 (Normal)"},
	{16005, "des_stownmain2", "black32", "Black Color"},
	{5016, "ground3_las", "ws_bigstones", "Cynder Blocks"},
	{5016, "ground3_las", "mural01_LA", "Jesus Saves"},
	{5033, "union_las", "lasunion98", "White Wall w/ windows"},
	{5033, "union_las", "ws_carparkwall2", "Yello+Grey Diagonal Stripes"},
	{14526, "sweetsmain", "ab_kitchunit2", "White panel"},
	{14526, "sweetsmain", "GB_Pan01", "Restaurant wall"},
	{14444, "carter_block_2", "cd_wall1", "Black nightclub wall"},
	{14593, "papaerchaseoffice", "ab_hosWallUpr", "White wall"},
	{15046, "svcunthoose", "sl_gallerywall1", "White tile wall/floor"},
	{14383, "burg_1", "hospital_wall2", "Hospital wall"},
	{15058, "svvgmid", "ah_wpaper3", "Flower wallpaper"},
	{14533, "pleas_dome", "ab_velvor", "Black nightclub floor"},
	{14526, "sweetsmain", "ab_tile1", "Floor tiles"},
	{4011, "lanblokb", "sl_rotnbrik", "Red brick"},
	{12931, "sw_brewery", "sw_brewbrick01", "Grey brick"},
	{12951, "ce_bankalley2", "sw_brick04", "White brick"},
	{18282, "cw_truckstopcs_t", "cw2_logwall", "Log wall"},
	{16475, "des_stownmots1", "des_redslats", "Red planks"},
	{4014, "civic01_lan", "parking1plain", "Plain grey concrete"},
	{10945, "skyscrap_sfse", "ws_carparkwall1", "Grey wall with stripe"},
	{10086, "slapart01sfe", "sl_hirisergrnconc", "Green wall"},
	{7417, "vgnbball", "vgngewall1_256", "Grey ceiling"},
	{8136, "vgsbikeschool", "ws_carparknew2", "Black carpet"},
	{14672, "genintintsex", "la_carp3", "White carpet"},
	{14847, "mp_policesf", "mp_cop_carpet", "Blue carpet"},
	{14707, "labig3int2", "HS2_3Wall9", "Red Carpet"},
	{16475, "des_stownmots1", "des_motelwall3", "Sand wall"},
	{14771, "int_brothelint3", "GB_nastybar12", "Wooden floor"},
	{14777, "int_casinoint3", "GB_midbar05", "Wooden floor pattern"},
	{14709, "lamidint2", "mp_apt1_roomfloor", "Red wooden floor"},
	{14789, "ab_sfgymmain", "gym_floor6", "Dark wooden floor"},
	{14709, "lamidint2", "mp_apt1_bathfloor1", "Bathroom tiles"},
	{14847, "mp_policesf", "mp_cop_marble", "Marble wall"},
	{18023, "genintintfastc", "CJ_PIZZA_WALL", "Pizza restaurant wall"},
	{14708, "labig1int2", "GB_restaursmll32", "Red wall with panel"},
	{14709, "lamidint2", "mp_apt1_woodpanel", "White wall with panel"},
	{18029, "genintintsmallrest", "GB_restaursmll05", "Stone wall"},
	{14417, "dr_gsnew", "mp_gs_libwall", "Dark brown wall with panel"},
	{14789, "ab_sfgymmain", "ab_wood02", "Dark grey wood wall"},
	{14847, "mp_policesf", "mp_cop_ceiling", "White marble"},
	{14417, "dr_gsnew", "mp_cloth_subwall", "Light blue wall"},
	{14444, "carter_block_2", "mp_carter_smoothwall", "Dirty white wall"},
	{14444, "carter_block_2", "mp_carter_ceiling", "Dirty dark grey wall"},
	{15031, "lasmallsave", "ab_marble_checks", "Checkered floor"},
	{10826, "subpen1_sfse", "ws_sub_pen_conc3", "Dirty green wall"},
	{18030, "gap", "mp_furn_floor", "Light wood floor"},
	{4014, "civic01_lan", "sl_laglasswall2", "Window/Blue tiles"},
	{18018, "genintintbarb", "GB_midbar07", "Green wall with panels"},
	{15042, "svsfsm", "GB_rapposter01", "Base5 Gangster poster"},
	{15042, "svsfsm", "GB_rapposter03", "Base5 Gangster poster2"},
	{14803, "bdupsnew", "Bdup2_wallpaperC", "Orange wall"},
	{1823, "cj_tables", "CJ_WOOD6", "Wooden material"},
	{1775, "cj_commercial", "cj_sheetmetal2", "Metal"},
	{1726, "mrk_couches2", "kb_sofa5_256", "Sofa material"}, // new materials start under this
	{16150, "ufo_bar", "dinerfloor01_128", "Kitchen Floor 1"},
	{3961, "lee_kitch", "dinerfloor01_128", "Kitchen Floor 2"},
	{16150, "ufo_bar", "sa_wood08_128", "Wood Floor Clean"},
	{13724, "docg01_lahills", "concpanel_la", "Tiles Floor"},
	{10973, "mall_sfse", "mallfloor3", "Tiles Mall Floor"},
	{4568, "skyscrap2_lan2", "sl_marblewall2", "Blue Marble"},
	{18646, "matcolours","white", "White"},
	{18646, "matcolours","red", "Red"},
	{18646, "matcolours", "blue", "Blue"},
	{18646, "matcolours","orange", "Orange"},
	{18646, "matcolours","green", "Green"},
	{4242,"seabed","des_dirt1", "Sand"},
	{3942, "bistro", "mp_snow", "Snow"},
	{16424, "des_s", "desertstones256", "Soil - Stone"},
	{3942, "bistro", "ahoodfence2", "Flagstone"},
	{3908, "libertyfar", "Grass_128HV", "Grass"},
	{3903, "libertyhi", "Grass", "Grass (2)"},
	{10368, "cathedral_sfs", "ws_football_lines2", "Grass - Dark/Light"},
	{4014, "civic01_lan", "sl_LAbedingsoil", "Soil"},
	{9507, "boxybld2_sfw", "sfn_grass1", "Dry grass"},
	{3953, "rczero_track", "waterclear256", "Clear water"},
	{3933, "weemap", "rocktb128", "Grey rocks"},
	{4242, "seabed", "des_dirt1", "Dirty sand"},
	{4242, "seabed", "sw_sand", "Dirty sand 2"},
	{4011, "lanblokb", "sl_rotnbrik", "(R) - Red Brick"},
	{4014, "civic01_lan", "airportwall_256128", "Dark Grey Brick Wall"},
	{4079, "civic04_lan", "twintWall1_LAn", "LS Prison Wall"},
	{4079, "civic04_lan", "twintWall2_LAn", "Lightbrown Brick Wall"},
	{4603, "laland1_lan2", "gm_labuld2_a", "Dark Grey Brick Wall (2)"},
	{4682, "dtbuil1_lan2", "sl_lavicdtwall1", "(R) - Dark Grey Brick Wall (3)"},
	{4718, "buildblk555", "gm_labuld5_b", "Light Grey Brick Wall"},
	{6199, "law_beach2", "lawshopwall3", "Red Brick Wall with lists"},
	{6199, "law_beach2", "lawshopwall2", "Blue Brick Wall with lists"},
	{6199, "law_beach2", "lawshopwall1", "Green concrete wall with lists"},
	{4600, "theatrelan2", "sl_whitewash1", "White Brick Wall"},
	{12951, "ce_bankalley2", "sw_brick04", "(R) - White Brick Wall (2)"},
	{12963, "sw_apartflatx", "sw_brewbrick01", "(R) - Grey Brick Wall (4)"},
	{12862, "sw_block03", "sw_wall03", "Brown stone wall with top list"},
	{12931, "sw_brewery", "sw_wallbrick_07", "(R) - Lightred Brick Wall"},
	{12941, "sw_ware01", "ws_sandstone2", "Sandstone, big bricks"},
	{3313, "sw_poorhouse", "sw_wallbrick_06", "Brown stone wall"},
	{3823, "boxhses_sfsx", "ws_blocks_red_1", "Light brown block wall"},
	{3823, "boxhses_sfsx", "ws_blocks_grey_1", "Light  grey block wall"},
	{3823, "boxhses_sfsx", "ws_mixedbrick", "Mixed white/red brickwall"},
	{10375, "subshops_sfs", "ws_oldwarehouse10a", "Dark grey wall (6)"},
	{10375, "subshops_sfs", "ws_breezeblocks", "(R) - Breezeblocks Grey"},
	{8068, "vgsswrehse03", "GB_truckdepot18", "Breezeblocks (2)"},
	{10086, "slapart01sfe", "sl_vicbrikwall01", "Mixed brown brick wall"},
	{10826, "subpen1_sfse", "ws_sub_pen_conc", "Grey big block wall"},
	{3443, "vegashse4", "ws_cleanblock", "Clean Sandstone block"},
	{3484, "vegashse5", "vegashousewal7_256", "Sand - LV Wall"},
	{3484, "vegashse5", "vegashousewal1_256", "Pink - LV Wall"},
	{3445, "vegashse6", "vegashousewal3_256", "Blue - LV Wall"},
	{3487, "vegashse7", "vegashousewal5_256", "Grey - LV Wall"},
	{6199, "law_beach2", "LOG_ALLw_gazcoast2", "Small Plank Wall"},
	{3306, "cunte_house1", "des_ntwnwall1", "Small plank wall (2)"},
	{6138, "venice_law", "law_blue1", "Blue Plank Wall"},
	{6138, "venice_law", "law_gazgrn1", "Plain Green Concrete Wall"},
	{12862, "sw_block03", "sw_woodwall1", "Broken white plank wall"},
	{3313, "sw_poorhouse", "sw_barnwood1", "Broken white plank wall (2)"},
	{12805, "ce_loadbay", "sw_warewall", "Dark blue plank wall W/ list"},
	{13059, "ce_fact03", "sw_shedwall01", "White plank with green bottom"},
	{3313, "sw_poorhouse", "GB_nastybar08", "Dark grey plank ground"},
	{3313, "sw_poorhouse", "sw_barnwoodblu", "Blue Planks"},
	{17324, "cwsbarn", "des_redslats", "Red slats"},
	{18282, "cw_truckstopcs_t", "cw2_logwall", "(R) - Log Wall"},
	{3306, "cunte_house1", "ws_vic_wood1", "White plank wall"},
	{3306, "cunte_house1", "darkplanks1", "Dark Red planks"},
	{3823, "boxhses_sfsx", "tanboard1", "White/Brown plank wall"},
	{9904, "pier69", "pier69_brown3", "Brown Pier Plank"},
	{9904, "pier69", "pier69_brown5", "Brown Pier Plank (2)"},
	{9904, "pier69", "pier69_blue2", "Blue Pier Plank"},
	{9904, "pier69", "pier69_blue5", "Blue Pier Plank (2)"},
	{9904, "pier69", "pier69_blue3", "Blue Pier Plank (3)"},
	{16011, "des_ntown", "des_greyslats", "White Plank wall (2)"},
	{4014, "civic01_lan", "parking1plain", "(R) - Plain Grey Wall"},
	{4014, "civic01_lan", "ws_whitewall2_bottom", "Dirty white wall"},
	{4014, "civic01_lan", "sl_concretewall1", "Concrete Wall (2)"},
	{4079, "civic04_lan", "twintconc_LAn", "Brown plain Wall"},
	{4559, "lanlacma_lan2", "lasbrwnhus3", "Light grey plain Wall"},
	{6199, "law_beach2", "lombard_build2_5", "Dark grey plain wall"},
	{6199, "law_beach2", "lombard_build2_2", "Dark grey plain wall (2)"},
	{6138, "venice_law", "law_terra2", "(R) - Red plain wall"},
	{6138, "venice_law", "law_yellow2", "(R) - Yellow plain wall"},
	{5784, "melrose05_lawn", "lawshopwall4", "Dirty plain wall"},
	{5784, "melrose05_lawn", "lawshopwall1", "Dirty green wall"},
	{12941, "sw_ware01", "ws_whitewall2_top", "White wall (3)"},
	{10633, "queens2_sfs", "ws_apartmentmankyb2", "Dirty Wall (3)"},
	{9501, "boxybld_sfw", "lombard_build1_1", "Brown plain wall (2)"},
	{9507, "boxybld2_sfw", "ws_alley5_256_blank", "Yellow plain wall (2)"},
	{9507, "boxybld2_sfw", "lombard_build2_2", "(R) - Grey plain wall (3)"},
	{9547, "vict_sfw", "gz_vic1c", "White brick (3)"},
	{10945, "skyscrap_sfse", "ws_carparkwall1", "Car Park wall"},
	{10871, "blacksky_sfse", "ws_whiteplaster_top", "White plaster wall"},
	{10086, "slapart01sfe", "sl_hirise2_conc", "Yellow dirty wall"},
	{10086, "slapart01sfe", "sl_hirisergrnconc", "(R) - Green plain wall"},
	{10086, "slapart01sfe", "Bow_Abpave_Gen", "Black/Brown dirty wall"},
	{10086, "slapart01sfe", "sl_hiriseredconc", "(R) - Red Wall"},
	{10826, "subpen1_sfse", "ws_sub_pen_conc3", "Dirty Concrete Wall"},
	{10826, "subpen1_sfse", "ws_sub_pen_conc2", "(R) - Dirty Concrete Wall (2)"},
	{10771, "carrier_sfse", "ws_floor2", "Green metal wall"},
	{10771, "carrier_sfse", "ws_shipmetal5", "White metal wall"},
	{10771, "carrier_sfse", "ws_shipmetal1", "Grey metal wall"},
	{9301, "gazsfn2", "law_gazgrn2", "Blue/Green plain wall"},
	{16564, "des_stownw", "ws_whitewall2_top", "White/Grey ceiling"},
	{7417, "vgnbball", "vgngewall2_256", "Grey ground with top white"},
	{7417, "vgnbball", "vgngewall1_256", "Grey ground"},
	{8136, "vgsbikeschool", "ws_carparknew2", "(R) - Black carpark concrete"},
	{9090, "vgsecoast", "coasty_bit6_sfe", "Dirty grey with top"},
	{6997, "vegastemp1", "vgnbarbtex1_256", "Wild carpet"},
	{7506, "vgnretail2", "vgnmetalwall1_256", "Blue and White Metal"},
	{4011, "lanblokb", "greyground256", "Grey Ground"},
	{4014, "civic01_lan", "tarmacplain_bank", "Black Ground"},
	{4718, "buildblk555", "tarmacplain_bank", "Black Ground (2)"},
	{3823, "boxhses_sfsx", "ws_stucco_white_2", "White ground"},
	{9507, "boxybld2_sfw", "sf_concrete1", "Grey Concrete (3)"},
	{9585, "bigshap_sfw", "shipceiling_sfw", "Metal ground - Dirty"},
	{9585, "bigshap_sfw", "shipfloor_sfw", "Metal ground"},
	{4014, "civic01_lan", "sl_flagstone1", "Grey tile (3)"},
	{4014, "civic01_lan", "sl_laglasswall1", "Red tile"},
	{4559, "lanlacma_lan2", "sl_gallerywall1", "(R) - White tile"},
	{10826, "subpen1_sfse", "sf_pave2", "White tile (2)"},
	{4014, "civic01_lan", "sl_laglasswall2", "Glass wall"},
	{4600, "theatrelan2", "sf_windos_4", "Blue glass wall"},
	{14417, "dr_gsnew", "mp_furn_floor", "(R) - Wooden plank floor"},
	{18031, "cj_exp", "mp_diner_wood", "(R) - Diner wooden floor"},
	{14789, "ab_sfgymmain", "gym_floor6", "Very dark planks"},
	{14771, "int_brothelint3", "GB_nastybar12", "(R) - Dark brown planks"},
	{14777, "int_casinoint3", "GB_midbar05", "(R) - Wooden floor (2)"},
	{14709, "lamidint2", "mp_apt1_roomfloor", "(R) - Wooden floor (3)"},
	{14758, "sfmansion1", "ah_yelplnks", "Dirty planks"},
	{14417, "dr_gsnew", "mp_marble", "Marble floor"},
	{14417, "dr_gsnew", "mp_gs_pooltiles", "Dirty bathroom tiles"},
	{14669, "711c", "CJ_7_11_TILE", "Blue/Orange tile"},
	{14669, "711c", "bwtilebroth", "Black/White tile"},
	{18008, "intclothesa", "shop_floor1", "Blue tile"},
	{14846, "genintintpoliceb", "pol_flr3", "Black/White tile (2)"},
	{14847, "mp_policesf", "mp_cop_vinyl", "Grey tiles"},
	{18022, "genintintfasta", "swimpoolbtm1_128", "(R) - White bathroom tiles"},
	{18020, "genintintfastb2", "ws_terratiles", "Red tiles (2)"},
	{18029, "genintintsmallrest", "GB_restaursmll07", "Blue tiles"},
	{18029, "genintintsmallrest", "GB_restaursmll06", "Brown tiles"},
	{14815, "whore_main", "Strip_Ceiling", "Grey Tile Ceiling"},
	{14735, "newcrak", "ab_wallpaper01", "(R) - Brown tiles"},
	{14706, "labig2int2", "ab_tile1", "(R) - Grey tiles"},
	{14709, "lamidint2", "mp_apt1_bathfloor1", "(R) - Diamond tiles black/White"},
	{14417, "dr_gsnew", "mp_motel_carpet1", "Red Carpet"},
	{14672, "genintintsex", "la_carp3", "(R) - Grey Carpet"},
	{14846, "genintintpoliceb", "p_floor3", "(R) - Black Carpet"},
	{14846, "genintintpoliceb", "p_floor4", "(R) - Blue Carpet"},
	{14847, "mp_policesf", "mp_cop_carpet", "(R) - Light Blue Carpet"},
	{14858, "gen_pol_vegas", "blue_carpet_256", "Blue Carpet"},
	{18024, "intclotheshiphop", "cj_bricks", "Broken Brick wall"},
	{14803, "bdupsnew", "Bdup2_carpet", "Dark blue carpet"},
	{14707, "labig3int2", "HS2_3Wall9", "(R) - Red Carpet"},
	{14707, "labig3int2", "HS2_3Wall7", "(R) - Purple Carpet"},
	{14707, "labig3int2", "HS2_3Wall10", "(R) - Cyan Carpet"},
	{14748, "sfhsm1", "carpet3kb", "Blue Carpet (2)"},
	{14672, "genintintsex", "mp_cop_floor2", "Brown floor"},
	{14847, "mp_policesf", "mp_cop_floor", "Brown floor (2)"},
	{18018, "genintintbarb", "CJ_GALVANISED", "(R) - Grey concrete (4)"},
	{18018, "genintintbarb", "CJ_Black_metal", "(R) - Black Metal"},
	{14847, "mp_policesf", "mp_tank_roomplain", "Police grey/blue wall"},
	{14847, "mp_policesf", "mp_cop_wall", "LSPD Cop Wall"},
	{14847, "mp_policesf", "mp_cop_marble", "White Marble wall"},
	{14859, "gf1", "mp_cooch_wall", "Dirty grey Wall"},
	{14859, "gf1", "mp_cooch_carp", "(R) - Black carpet (2)"},
	{14593, "papaerchaseoffice", "ab_hosWallUpr", "(R) - White wall"},
	{18023, "genintintfastc", "CJ_PIZZA_WALL", "(R) - Pizza Stack Wall"},
	{18029, "genintintsmallrest", "GB_restaursmll08", "(R) - Blue plain wall"},
	{18018, "genintintbarb", "GB_midbar07", "Casino blue wall"},
	{14771, "int_brothelint3", "GB_midbar06", "(R) - Sand/Yellow plain wall"},
	{14803, "bdupsnew", "Bdup2_wallpaperC", "(R) Orange plain wall"},
	{14735, "newcrak", "kbdirty_wall1", "(R) - Red and blue wall"},
	{14706, "labig2int2", "mp_apt1_kitchwallpaper", "(R) - Kitchen wall"},
	{14708, "labig1int2", "GB_restaursmll38", "(R) - Plain White wall (2)"},
	{14708, "labig1int2", "GB_restaursmll32", "(R) - Old City Hall Wall"},
	{14709, "lamidint2", "mp_apt1_roomwall", "(R) - Old City Hall wall (2)"},
	{14709, "lamidint2", "mp_apt1_woodpanel", "(R) - Old City Hall wall (3)"},
	{14417, "dr_gsnew", "mp_gs_libwall", "(R) - Old City Hall Wall (4)"},
	{14718, "lasmall1int2", "motel_wall4", "Dity tile wall"},
	{14708, "labig1int2", "GB_vase01", "Dirty brown and white wall"},
	{14754, "sfhsb3", "wall6", "White wall (3)"},
	{14754, "sfhsb3", "ah_wpaper6", "Wallpaper flowers"},
	{14754, "sfhsb3", "ah_wpaper4", "Wallpaper green floers"},
	{14748, "sfhsm1", "AH_grepaper2", "(R) - Plain blue/green Wall"},
	{14847, "mp_policesf", "mp_cop_cell", "(R) - Blue/White brick wall"},
	{14876, "gf4", "mp_gimp_officewall", "(R) - Dirty office wall"},
	{14881, "gf5", "mp_jail_wall", "(R) - Dirty jail wall"},
	{18029, "genintintsmallrest", "GB_restaursmll05", "(R) - Restaurant Flagstone wall"},
	{18018, "genintintbarb", "GB_midbar01", "(R) - Restaurant brick wall"},
	{18028, "cj_bar2", "GB_nastybar03", "White dirty brick"},
	{14709, "lamidint2", "mp_apt1_bathtiles", "Dirty bathroom tiles green"},
	{18031, "cj_exp", "mp_cloth_wall", "(R)- Plain White Wall (3)"},
	{14417, "dr_gsnew", "mp_gs_wall1", "Old broken wall"},
	{14672, "genintintsex", "mp_porn_wall", "White brick with top"},
	{18029, "genintintsmallrest", "GB_restaursmll09", "(R) - Restaurant plank wall"},
	{18028, "cj_bar2", "GB_nastybar04", "(R) - Dark plank wall"},
	{14789, "ab_sfgymmain", "ab_wood02", "(R) - Black wooden wall" },
	{14417, "dr_gsnew", "mp_gs_woodpanel", "Wood panel"},
	{14417, "dr_gsnew", "mp_gs_woodpanel1", "Wood panel (2)"},
	{14847, "mp_policesf", "mp_cop_panel", "Wood panel (3)"},
	{18028, "cj_bar2", "GB_nastybar06", "Wood panel (4)"},
	{18028, "cj_bar2", "GB_nastybar01", "Wood panel (5)"},
	{14847, "mp_policesf", "mp_cop_ceiling", "(R) - Plain ceiling"},
	{18028, "cj_bar2", "GB_nastybar07", "(R) - Marble (3)"},
	{14708, "labig1int2", "mp_apt1_ceiling", "(R) - Plain Ceiling (2)"},
	{15042, "svsfsm", "GB_tile01", "Tile with flower"},
	{14420, "dr_gsbits", "mp_apt1_pic5", "(R) - Picture 1"},
	{14420, "dr_gsbits", "mp_apt1_pic8" "(R) - Picture 2"},
	{14420, "dr_gsbits", "mp_apt1_pic7" "(R) - Picture 3"},
	{14420, "dr_gsbits", "mp_apt1_pic6" "(R) - Picture 4"},
	{15042, "svsfsm", "mural07_LA", "(R) - Picture 5"},
	{15042, "svsfsm", "piratesign01_128", "(R) - Picture 6"},
	{15042, "svsfsm", "GB_rapposter01", "(R) - Picture 7"},
	{15042, "svsfsm", "GB_rapposter03", "(R) - Picture 8"},
	{15042, "svsfsm", "GB_canvas18", "(R) - Picture 9"},
	{15042, "svsfsm", "GB_canvas17", "(R) - Picture 10"},
	{15042, "svsfsm", "GB_canvas06", "(R) - PWainting"},
	{14526, "sweetsmain", "ab_kitchunit2", "White panel"},
	{14526, "sweetsmain", "GB_Pan01", "(R) - Restaurant wall"},
	{14471, "carls_kit1", "wall6", "White wall (5)"},
	{14471, "carls_kit1", "wall3", "(R) - White bathroom tile/wall"},
	{14746, "rylounge", "ab_wall3", "Dirty black wall"},
	{14444, "carter_block_2", "mp_carter_wallpaper", "Dirty blue wall"},
	{14444, "carter_block_2", "mp_carter_tilewall", "Dirty brown tiles"},
	{14444, "carter_block_2", "mp_carter_floor", "Dirty grey floor"},
	{14444, "carter_block_2", "mp_carter_pcarpet", "Red/blue/orange carpet"},
	{14444, "carter_block_2", "mp_carter_smoothwall", "Dirty white wall"},
	{14444, "carter_block_2", "cd_wall1", "(R) - Total black Nightclub wall"},
	{14475, "ganghoos", "mp_burn_carpet", "Black flower wall"},
	{15033, "vegassavesmal", "ah_wpaper4", "Green flower wall"},
	{15042, "svsfsm", "ws_chipboard", "Chipboard"},
	{14506, "imy_motel", "ab_tilehex2", "(R) - Hex tiles - Marble"},
	{14506, "imy_motel", "Bow_Abpave_Gen", "(R) - Dark grey wallpaper"},
	{14500, "imm_roomss", "mp_motel_wallpaper1", "Funky wall"},
	{14500, "imm_roomss", "mp_motel_wallpaper", "Funky wall (2)"},
	{15031, "lasmallsave", "ab_tile4", "Blue tiles (2)"},
	{15058, "svvgmid", "ah_wpaper3", "Red flower wall"},
	{14534, "ab_wooziea", "ab_fabricRed", "(R) - Red fabric"},
	{14534, "ab_wooziea", "walp72S", "(R) - Yellow fabric"},
	{14534, "ab_wooziea", "ab_tileDiamond", "(R) - Diamond tiles"},
	{14533, "pleas_dome", "club_wall4_SFw", "(R) - Purple club wall"},
	{14533, "pleas_dome", "ab_velvor", "(R) - Black Nightclub floor"},
	{14533, "pleas_dome", "ab_carpethexi", "(R) Purple nightclub floor"},
	{14533, "pleas_dome", "club_floor2_sfwTEST", "(R) - Black tiles"},
	{14624, "MafCasMain", "ab_CasRomTile1", "Grey Tile"},
	{14624, "MafCasMain", "ab_MarbleDiamond", "Grey Diamond Tile"},
	{14624, "MafCasMain", "ab_carpGreenEdge", "Green Carpet"},
	{14624, "MafCasMain", "ab_panel5", "Dark Blue/Grey Panel"},
	{14624, "MafCasMain", "ab_tileStar", "Star Tile"},
	{14624, "MafCasMain", "casino_carp", "Casino Carpet"},
	{14624, "MafCasMain", "cof_wood2", "Dark Wood Material"},
	{14624, "MafCasMain", "marble_wall", "Black Marble Wall"},
	{14624, "MafCasMain", "marble_wall2", "Grey Marble Wall"},
	{14624, "MafCasMain", "vaultFloor", "Grey Floor"},
	{1726, "mrk_couches2", "kb_sofa5_256", "(R) - Sofa material"},
	{1726, "mrk_couches2", "kbcornice_2_128", "Chrome"},
	{19466, "lsmall_shops", "lsmall_window01", "Window"},
	{19466, "lsmall_shops", "shop_floor1", "(R) - Black/White Chequered"},
	{19466, "lsmall_shops", "ws_stationfloor", "(R) - Grey kitchen floor"},
	{19466, "lsmall_shops", "hospital_wall2", "Hospital wall"}
};

// Functions

Dialog:FurnitureDialog(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		switch(listitem)
		{
			case 0:
			{
			    new string[256];

				for(new i = 0; i != sizeof(fCategory); ++i)
				{
				    format(string, sizeof(string), "%s%s\n", string, fCategory[i]);
				}

				Dialog_Show(playerid, FCategoryDialog, DIALOG_STYLE_LIST, "Categories:", string, "Select", "<<");
			}
			case 1:
			{
			    SetPVarInt(playerid, "FurniturePages", 0);

				ShowPlayerCurrentFurniture(playerid);
			}
			case 2:
			{
			    SendClientMessage(playerid, COLOR_YELLOW, "-> Updating your furniture limit.");

			    new houseid = InProperty[playerid], string[280], furnitures, furniture_limit;

                if(houseid != -1)
                {
                    furnitures = GetHouseFurnitures(houseid);
                    furniture_limit = GetMaximumHouseFurniture(houseid);

                    format(string, sizeof(string), "{FFFFFF}-This property currently\nhas {33AA33}%d{FFFFFF} items.\n-The items in this property\nare worth {33AA33}%s{FFFFFF}.\n-You have a furniture item limit of {33AA33}%d\n{FFFFFF}-You have the option\nto add up to{33AA33}%d{FFFFFF} more items.",
					furnitures, FormatNumber(0), furniture_limit, furniture_limit - furnitures);

					return Dialog_Show(playerid, ReturnFurnitureMain, DIALOG_STYLE_MSGBOX, "House Information", string, "<<", "");
				}

                houseid = InBusiness[playerid];

              	if(houseid != -1)
              	{
                    furnitures = GetBizFurnitures(houseid);
                    furniture_limit = GetMaximumBizFurniture(houseid);

                    format(string, sizeof(string), "{FFFFFF}-This property currently\nhas {33AA33}%d{FFFFFF} items.\n-The items in this property\nare worth {33AA33}%s{FFFFFF}.\n-You have a furniture item limit of {33AA33}%d\n{FFFFFF}-You have the option\nto add up to{33AA33}%d{FFFFFF} more items.",
					furnitures, FormatNumber(0), furniture_limit, furniture_limit - furnitures);

				  	return Dialog_Show(playerid, ReturnFurnitureMain, DIALOG_STYLE_MSGBOX, "Business Information", string, "<<", "");
				}
			}
		}
	}
	return true;
}

Dialog:ReturnFurnitureMain(playerid, response, listitem, inputtext[])
{
	return Dialog_Show(playerid, FurnitureDialog, DIALOG_STYLE_LIST, "Furniture Main Menu:", "Buy Furniture\nCurrent Furniture\nInformation", "Select", "<<");
}

Dialog:ReturnFurnitureEditMenu(playerid, response, listitem, inputtext[])
{
    Dialog_Show(playerid, FurnitureEditMenu, DIALOG_STYLE_LIST, "Object Editing:", "{FFFFFF}Information\nPosition\n{FF6347}Edit Materials{FFFFFF}\nSell\nRename\nDuplicate", "Select", "<<");
	return true;
}

Dialog:ReturnFurnitureMenu(playerid, response, listitem, inputtext[])
{
	SetPVarInt(playerid, "FurniturePages", 0);

	ShowPlayerCurrentFurniture(playerid);
	return true;
}

Dialog:FurnitureMaterialInfo(playerid, response, listitem, inputtext[])
{
	format(sgstr, sizeof(sgstr), "Editing Texture({FFFF00}%d{FFFFFF}):", GetPVarInt(playerid, "FurnitureEditingSlot") + 1);
	Dialog_Show(playerid, FurnitureEditingTexture, DIALOG_STYLE_LIST, sgstr, "Edit Texture\nRemove Material\nMaterial Information", "Select", "<<");
	return true;
}

OnPlayerEditHouseMaterial(houseid, furnitureslot, materialslot, materialid)
{
	SetDynamicObjectMaterial(HouseFurniture[houseid][furnitureslot][fObject], materialslot, MaterialData[materialid][mModel], MaterialData[materialid][mtxd], MaterialData[materialid][mtexture], HexToInt("0xFFFFFFFF"));

	mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `house_furnitures` SET `matModel%i` = '%i', `matTxd%i` = '%e', `matTexture%i` = '%e', `matColor%i` = '%e' WHERE `id` = '%i'",
	    materialslot + 1,
	    MaterialData[materialid][mModel],
	    materialslot + 1,
	    MaterialData[materialid][mtxd],
	    materialslot + 1,
	    MaterialData[materialid][mtexture],
	    materialslot + 1,
	    "0xFFFFFFFF",
		HouseFurniture[houseid][furnitureslot][fID]
	);

    mysql_tquery(dbCon, gquery);
}

OnPlayerEditBizMaterial(bizid, furnitureslot, materialslot, materialid)
{
	SetDynamicObjectMaterial(BizFurniture[bizid][furnitureslot][fObject], materialslot, MaterialData[materialid][mModel], MaterialData[materialid][mtxd], MaterialData[materialid][mtexture], HexToInt("0xFFFFFFFF"));

	mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `business_furnitures` SET `matModel%i` = '%i', `matTxd%i` = '%e', `matTexture%i` = '%e', `matColor%i` = '%e' WHERE `id` = '%i'",
	    materialslot + 1,
	    MaterialData[materialid][mModel],
	    materialslot + 1,
	    MaterialData[materialid][mtxd],
	    materialslot + 1,
	    MaterialData[materialid][mtexture],
	    materialslot + 1,
	    "0xFFFFFFFF",
		BizFurniture[bizid][furnitureslot][fID]
	);

    mysql_tquery(dbCon, gquery);
}

Dialog:FurnitureSelectMaterial(playerid, response, listitem, inputtext[])
{
	if(response)
	{
	    new page = GetPVarInt(playerid, "MaterialPages"), furnitureslot = GetPVarInt(playerid, "ChosenFurnitureSlot"), materialslot = GetPVarInt(playerid, "FurnitureEditingSlot");

		if(!strcmp(inputtext, ">>", true))
		{
			page++;

		    SetPVarInt(playerid, "MaterialPages", page);
		}
		else if(!strcmp(inputtext, "<<", true))
		{
		    page--;

		    SetPVarInt(playerid, "MaterialPages", page);
		}
		else
		{
		    new count;

		    new houseid = InProperty[playerid];

		    if(houseid != -1)
			{
				for(new i = page * 25; i != sizeof(MaterialData); ++i)
				{
					if(listitem == count)
					{
                        OnPlayerEditHouseMaterial(houseid, furnitureslot, materialslot, i);
					 	break;
					}

	              	count++;
				}

				Dialog_Show(playerid, FurnitureMaterial, DIALOG_STYLE_LIST, "Available Editing Slots:", "Texture Slot 1\nTexture Slot 2\nTexture Slot 3\nRemove All Materials", "Select", "<<");
			}

            houseid = InBusiness[playerid];

		    if(houseid != -1)
			{
				for(new i = page * 25; i != sizeof(MaterialData); ++i)
				{
					if(listitem == count)
					{
						OnPlayerEditBizMaterial(houseid, furnitureslot, materialslot, i);
					 	break;
					}

	              	count++;
				}

				Dialog_Show(playerid, FurnitureMaterial, DIALOG_STYLE_LIST, "Available Editing Slots:", "Texture Slot 1\nTexture Slot 2\nTexture Slot 3\nRemove All Materials", "Select", "<<");
			}
			return true;
		}

		new string[800], count;

		for(new i = page * 25; i != sizeof(MaterialData); ++i)
		{
			if(count >= 25)
			{
				format(string, sizeof(string), "%s>>\n", string);
				break;
			}

			format(string, sizeof(string), "%s%s\n", string, MaterialData[i][mName]);

			count++;
		}

		if(page > 0) format(string, sizeof(string), "%s<<\n", string);

		format(sgstr, sizeof(sgstr), "Editing Texture({FFFF00}%d{FFFFFF}):", materialslot + 1);
		Dialog_Show(playerid, FurnitureSelectMaterial, DIALOG_STYLE_LIST, sgstr, string, "Select", "<<");
	}
	else
	{
	    DeletePVar(playerid, "MaterialPages");

		format(sgstr, sizeof(sgstr), "Editing Texture({FFFF00}%d{FFFFFF}):", GetPVarInt(playerid, "FurnitureEditingSlot") + 1);
		Dialog_Show(playerid, FurnitureEditingTexture, DIALOG_STYLE_LIST, sgstr, "Edit Texture\nRemove Material\nMaterial Information", "Select", "<<");
	}
	return true;
}


Dialog:FurnitureEditingTexture(playerid, response, listitem, inputtext[])
{
	if(response)
	{
	    new
			furnitureslot = GetPVarInt(playerid, "ChosenFurnitureSlot"),
			materialslot = GetPVarInt(playerid, "FurnitureEditingSlot")
		;

		switch(listitem)
		{
		    case 0: // Edit Texture current slot > Show Material list
		    {
				new string[800], count;

				for(new i = 0; i != sizeof(MaterialData); ++i)
				{
					if(count >= 25)
					{
						format(string, sizeof(string), "%s>>\n", string);
						break;
					}

					format(string, sizeof(string), "%s%s\n", string, MaterialData[i][mName]);

					count++;
				}

				SetPVarInt(playerid, "MaterialPages", 0);

				format(sgstr, sizeof(sgstr), "Editing Texture({FFFF00}%d{FFFFFF}):", materialslot + 1);
				Dialog_Show(playerid, FurnitureSelectMaterial, DIALOG_STYLE_LIST, sgstr, string, "Select", "<<");
		    }
		    case 1: // Remove Texture current slot
		    {
		        new houseid = InProperty[playerid];

				if(houseid != -1) RemoveHouseFurnitureMaterial(houseid, furnitureslot, materialslot);

				houseid = InBusiness[playerid];

				if(houseid != -1) RemoveBizFurnitureMaterial(houseid, furnitureslot, materialslot);

				DeletePVar(playerid, "FurnitureEditingSlot");

				Dialog_Show(playerid, FurnitureMaterial, DIALOG_STYLE_LIST, "Available Editing Slots:", "Texture Slot 1\nTexture Slot 2\nTexture Slot 3\nRemove All Materials", "Select", "<<");
		    }
		    case 2: //Material Infomation current slot
		    {
		        new string[128], texturename[32] = "None", houseid = InProperty[playerid], matModel, matTxd[32], matTexture[32], matColor;

				if(houseid != -1) GetDynamicObjectMaterial(HouseFurniture[houseid][furnitureslot][fObject], materialslot, matModel, matTxd, matTexture, matColor, 32, 32);

				houseid = InBusiness[playerid];

				if(houseid != -1) GetDynamicObjectMaterial(BizFurniture[houseid][furnitureslot][fObject], materialslot, matModel, matTxd, matTexture, matColor, 32, 32);

				if(matModel)
				{
					for(new x = 0, num = sizeof(MaterialData); x < num; ++x)
					{
						if(!strcmp(matTexture, MaterialData[x][mtexture], true))
						{
							format(texturename, 32, "%s", MaterialData[x][mName]);
							break;
						}
					}
				}

				format(string, sizeof(string), "%s{FF6347}Slot %d | Texture: %s{FFFFFF}\n", string, materialslot + 1, texturename);

				Dialog_Show(playerid, FurnitureMaterialInfo, DIALOG_STYLE_MSGBOX, "Information:", string, "Close", "");
		    }
		}
	}
	else
	{
		DeletePVar(playerid, "FurnitureEditingSlot");

		Dialog_Show(playerid, FurnitureMaterial, DIALOG_STYLE_LIST, "Available Editing Slots:", "Texture Slot 1\nTexture Slot 2\nTexture Slot 3\nRemove All Materials", "Select", "<<");
	}
	return true;
}

RemoveHouseFurnitureMaterial(houseid, furnitureslot, materialslot)
{
    SetDynamicObjectMaterial(HouseFurniture[houseid][furnitureslot][fObject], materialslot, -1, "none", "none", 0);

	mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `house_furnitures` SET `matModel%i` = '-1', `matTxd%i` = 'none', `matTexture%i` = 'none', `matColor%i` = '0xFFFFFFFF' WHERE `id` = '%i'",
	    materialslot + 1,
	    materialslot + 1,
	    materialslot + 1,
	    materialslot + 1,
		HouseFurniture[houseid][furnitureslot][fID]
	);

	mysql_tquery(dbCon, gquery);
	return true;
}

RemoveBizFurnitureMaterial(bizid, furnitureslot, materialslot)
{
    SetDynamicObjectMaterial(BizFurniture[bizid][furnitureslot][fObject], materialslot, -1, "none", "none", 0);

	mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `business_furnitures` SET `matModel%i` = '-1', `matTxd%i` = 'none', `matTexture%i` = 'none', `matColor%i` = '0xFFFFFFFF' WHERE `id` = '%i'",
	    materialslot + 1,
	    materialslot + 1,
	    materialslot + 1,
	    materialslot + 1,
	    BizFurniture[bizid][furnitureslot][fID]
	);

	mysql_tquery(dbCon, gquery);
	return true;
}

Dialog:FurnitureMaterial(playerid, response, listitem, inputtext[])
{
	if(response)
	{
	    if(listitem == 3)
	    {
	        new furnitureslot = GetPVarInt(playerid, "ChosenFurnitureSlot"), houseid = InProperty[playerid];

			if(houseid != -1)
			{
		        for(new i = 0; i != MAX_MATERIAL; ++i)
				{
					RemoveHouseFurnitureMaterial(houseid, furnitureslot, i);
				}
			}

			houseid = InBusiness[playerid];

			if(houseid != -1)
			{
		        for(new i = 0; i != MAX_MATERIAL; ++i)
				{
					RemoveBizFurnitureMaterial(houseid, furnitureslot, i);
				}
			}

	        Dialog_Show(playerid, FurnitureEditMenu, DIALOG_STYLE_LIST, "Object Editing:", "{FFFFFF}Information\nPosition\n{FF6347}Edit Materials{FFFFFF}\nSell\nRename\nDuplicate", "Select", "<<");
	        return true;
	    }

	    SetPVarInt(playerid, "FurnitureEditingSlot", listitem);

	    format(sgstr, sizeof(sgstr), "Editing Texture({FFFF00}%d{FFFFFF}):", listitem + 1);
	    Dialog_Show(playerid, FurnitureEditingTexture, DIALOG_STYLE_LIST, sgstr, "Edit Texture\nRemove Material\nMaterial Information", "Select", "<<", listitem + 1);
	}
	else Dialog_Show(playerid, FurnitureEditMenu, DIALOG_STYLE_LIST, "Object Editing:", "{FFFFFF}Information\nPosition\n{FF6347}Edit Materials{FFFFFF}\nSell\nRename\nDuplicate", "Select", "<<");

	return true;
}

Dialog:FurnitureEditMenu(playerid, response, listitem, inputtext[])
{
    new string[512];

	if(response)
	{
		switch(listitem)
		{
		    case 0: // Information
		    {
		        new houseid = InProperty[playerid], furnitureslot = GetPVarInt(playerid, "ChosenFurnitureSlot");

				if(houseid != -1)
				{
				    new
				        count,
				        furnitureid = GetFurnitureID(HouseFurniture[houseid][furnitureslot][fModel]),
						category = FurnitureItems[furnitureid][furnitureCatalog],
						subid = FurnitureItems[furnitureid][furnitureSubCatalog],
						subcategory
					;

					for(new i = 0; i != sizeof(fSubCategory); ++i)
					{
					    if(fSubCategory[i][catid] == category)
						{
					        if(count == subid)
					        {
					            subcategory = i;
					            break;
					        }

	                        count++;
						}
					}

					format(string, sizeof(string), "{A9C4E4}Category:{FFFF00} %s\n{FFFFFF}Sub.Category:{FFFF00} %s\n{FFFFFF}Item:{FFFF00} %s\n{FFFFFF}Name:{FFFF00} %s\n{FFFFFF}Model ID:{FFFF00} %d\n{FFFFFF}Price: %s\n\n", fCategory[category], fSubCategory[subcategory][subname], FurnitureItems[furnitureid][furnitureName], HouseFurniture[houseid][furnitureslot][fName], HouseFurniture[houseid][furnitureslot][fModel], FormatNumberEx(FurnitureItems[furnitureid][furniturePrice]));

			        new matModel, matTxd[32], matTexture[32], matColor;

					for(new i = 0; i < MAX_MATERIAL; ++i)
					{
					    GetDynamicObjectMaterial(HouseFurniture[houseid][furnitureslot][fObject], i, matModel, matTxd, matTexture, matColor, 32, 32);

					    if(matModel)
						{
					        new texturename[32] = "None";

							for(new x = 0, num = sizeof(MaterialData); x < num; ++x)
							{
							    if(!strcmp(matTexture, MaterialData[x][mtexture], true))
								{
									format(texturename, 32, "%s", MaterialData[x][mName]);
									break;
							    }
							}

							format(string, sizeof(string), "%s{FF6347}Slot %d | Texture: %s{FFFFFF}\n", string, i + 1, texturename);
						}
					}
				}

				houseid = InBusiness[playerid];

				if(houseid != -1)
				{
				    new
				        count,
				        furnitureid = GetFurnitureID(BizFurniture[houseid][furnitureslot][fModel]),
						category = FurnitureItems[furnitureid][furnitureCatalog],
						subid = FurnitureItems[furnitureid][furnitureSubCatalog],
						subcategory
					;

					for(new i = 0; i != sizeof(fSubCategory); ++i)
					{
					    if(fSubCategory[i][catid] == category)
						{
					        if(count == subid)
					        {
					            subcategory = i;
					            break;
					        }

	                        count++;
						}
					}

					format(string, sizeof(string), "{A9C4E4}Category:{FFFF00} %s\n{FFFFFF}Sub.Category:{FFFF00} %s\n{FFFFFF}Item:{FFFF00} %s\n{FFFFFF}Name:{FFFF00} %s\n{FFFFFF}Model ID:{FFFF00} %d\n{FFFFFF}Price: %s\n\n", fCategory[category], fSubCategory[subcategory][subname], FurnitureItems[furnitureid][furnitureName], BizFurniture[houseid][furnitureslot][fName], BizFurniture[houseid][furnitureslot][fModel], FormatNumberEx(FurnitureItems[furnitureid][furniturePrice]));

                    new matModel, matTxd[32], matTexture[32], matColor;

					for(new i = 0; i < MAX_MATERIAL; ++i)
					{
					    GetDynamicObjectMaterial(BizFurniture[houseid][furnitureslot][fObject], i, matModel, matTxd, matTexture, matColor, 32, 32);

					    if(matModel)
						{
					        new texturename[32] = "None";

							for(new x = 0, num = sizeof(MaterialData); x < num; ++x)
							{
							    if(!strcmp(matTexture, MaterialData[x][mtexture], true))
								{
									format(texturename, 32, "%s", MaterialData[x][mName]);
									break;
							    }
							}

							format(string, sizeof(string), "%s{FF6347}Slot %d | Texture: %s{FFFFFF}\n", string, i + 1, texturename);
						}
					}
				}

				Dialog_Show(playerid, ReturnFurnitureEditMenu, DIALOG_STYLE_MSGBOX, "Information:", string, "Close", "");
		    }
		    case 1: // Position
		    {
		        new
					houseid = InProperty[playerid],
					furnitureslot = GetPVarInt(playerid, "ChosenFurnitureSlot")
				;

				SetPVarInt(playerid, "EditingFurniture", 1);

				if(houseid != -1)
				{
					EditDynamicObject(playerid, HouseFurniture[houseid][furnitureslot][fObject]);

					ShowPlayerFooter(playerid, "~n~HOLD \"~y~SPACE~w~\" AND PRESS YOUR \"~y~MMB~w~\" KEY TO MOVE YOUR FURNITURE ITEM BACK TO YOU.", 7000);
					return true;
				}

				houseid = InBusiness[playerid];

				if(houseid != -1)
				{
					EditDynamicObject(playerid, BizFurniture[houseid][furnitureslot][fObject]);

					ShowPlayerFooter(playerid, "~n~HOLD \"~y~SPACE~w~\" AND PRESS YOUR \"~y~MMB~w~\" KEY TO MOVE YOUR FURNITURE ITEM BACK TO YOU.", 7000);
					return true;
				}
		    }
		    case 2: // Material
		    {
                Dialog_Show(playerid, FurnitureMaterial, DIALOG_STYLE_LIST, "Available Editing Slots:", "Texture Slot 1\nTexture Slot 2\nTexture Slot 3\nRemove All Materials", "Select", "<<");

				ShowPlayerFooter(playerid, "~n~~n~EACH FURNITURE ITEM HAS AROUND 5 TEXTURE SLOTS.~n~EACH SLOT AFFECTS A PIECE OF THE ITEM.", 5000);
			}
		    case 3: // Sell
			{
		        new houseid = InProperty[playerid], furnitureslot = GetPVarInt(playerid, "ChosenFurnitureSlot");

				if(houseid != -1)
				{
				    new
				        count,
				        furnitureid = GetFurnitureID(HouseFurniture[houseid][furnitureslot][fModel]),
						category = FurnitureItems[furnitureid][furnitureCatalog],
						subid = FurnitureItems[furnitureid][furnitureSubCatalog],
						subcategory
					;

					for(new i = 0; i != sizeof(fSubCategory); ++i)
					{
					    if(fSubCategory[i][catid] == category)
						{
					        if(count == subid)
					        {
					            subcategory = i;
					            break;
					        }
	                        count++;
						}
					}

					format(string, sizeof(string), "{FFFFFF}Category:{FFFF00} %s\n{FFFFFF}Sub-Category:{FFFF00} %s\n{FFFFFF}Item:{FFFF00} %s\n{FFFFFF}Price: {A3A3A3}%s", fCategory[category], fSubCategory[subcategory][subname], FurnitureItems[furnitureid][furnitureName], FormatNumberEx(FurnitureItems[furnitureid][furniturePrice]));
					Dialog_Show(playerid, HandleFurnitureSelling, DIALOG_STYLE_MSGBOX, "Are you Sure:?", string, "Sell", "<<");
				}

				houseid = InBusiness[playerid];

				if(houseid != -1)
				{
				    new
				        count,
				        furnitureid = GetFurnitureID(BizFurniture[houseid][furnitureslot][fModel]),
						category = FurnitureItems[furnitureid][furnitureCatalog],
						subid = FurnitureItems[furnitureid][furnitureSubCatalog],
						subcategory
					;

					for(new i = 0; i != sizeof(fSubCategory); ++i)
					{
					    if(fSubCategory[i][catid] == category)
						{
					        if(count == subid)
					        {
					            subcategory = i;
					            break;
					        }

	                        count++;
						}
					}

					format(string, sizeof(string), "{FFFFFF}Category:{FFFF00} %s\n{FFFFFF}Sub-Category:{FFFF00} %s\n{FFFFFF}Item:{FFFF00} %s\n{FFFFFF}Price: {A3A3A3}%s", fCategory[category], fSubCategory[subcategory][subname], FurnitureItems[furnitureid][furnitureName], FormatNumberEx(FurnitureItems[furnitureid][furniturePrice]));
					Dialog_Show(playerid, HandleFurnitureSelling, DIALOG_STYLE_MSGBOX, "Are you Sure:?", string, "Sell", "<<");

				}
			}
		    case 4: // Rename
			{
				Dialog_Show(playerid, HandleFurnitureRename, DIALOG_STYLE_INPUT, "Custom Naming:", "You can give your furniture a name\n\t- The letter must not be less than 3 characters\n\t- Characters must be at least 3 characters\n\t- Special characters can not be used", "Select", "<<");
		    }
		    case 5: // Duplicate
		    {
		        new houseid = InProperty[playerid], furnitureslot = GetPVarInt(playerid, "ChosenFurnitureSlot");

				if(houseid != -1)
				{
					if(IsAddHouseFurniture(houseid, GetHouseFurnitures(houseid)))
					{
					    new i = -1;

					    if((i = GetNextHouseFurnitureSlot(houseid)) != -1)
						{
							new
							    name[48],
								price = HouseFurniture[houseid][furnitureslot][fMarketPrice],
								model = HouseFurniture[houseid][furnitureslot][fModel]
							;

					        format(name, 48, HouseFurniture[houseid][furnitureslot][fName]);

							if(PlayerData[playerid][pCash] >= price)
							{
								TakePlayerMoney(playerid, price);

								HouseFurniture[houseid][i][fObject] = CreateDynamicObject
								(
									model,
									HouseFurniture[houseid][furnitureslot][fPosX],
									HouseFurniture[houseid][furnitureslot][fPosY],
									HouseFurniture[houseid][furnitureslot][fPosZ],
									HouseFurniture[houseid][furnitureslot][fPosRX],
									HouseFurniture[houseid][furnitureslot][fPosRY],
									HouseFurniture[houseid][furnitureslot][fPosRZ],
									PropertyData[houseid][hWorld],
									PropertyData[houseid][hInterior],
									-1,
									100.0
								);

								SetPVarInt(playerid, "JustBoughtFurniture", 1);
								SetPVarInt(playerid, "ChosenFurnitureSlot", i);

								EditDynamicObject(playerid, HouseFurniture[houseid][i][fObject]);

								format(HouseFurniture[houseid][i][fName], 48, "%s", name);

								OnPlayerBuyHouseFurniture
								(
									houseid, PropertyData[houseid][hInterior], PropertyData[houseid][hWorld], i, model, price, name,
									HouseFurniture[houseid][furnitureslot][fPosX], HouseFurniture[houseid][furnitureslot][fPosY], HouseFurniture[houseid][furnitureslot][fPosZ],
									HouseFurniture[houseid][furnitureslot][fPosRX], HouseFurniture[houseid][furnitureslot][fPosRY], HouseFurniture[houseid][furnitureslot][fPosRZ]
								);

						        ShowPlayerFooter(playerid, "~n~HOLD \"~y~SPACE~w~\" AND PRESS YOUR \"~y~MMB~w~\" KEY TO MOVE YOUR FURNITURE ITEM BACK TO YOU.~n~PRESS YOUR \"~r~ESC~w~\" KEY TO RETURN THE ITEM IF YOU ARE NOT PLEASED", 7000);
								return true;
							}
							else SendClientMessage(playerid, COLOR_GRAD1, "You don't have enough money to buy this.");
						}
						else SendClientMessage(playerid, COLOR_LIGHTRED, "You've reached your furniture limit.");
					}
					else SendClientMessage(playerid, COLOR_LIGHTRED, "You've reached your furniture limit.");

					Dialog_Show(playerid, FurnitureEditMenu, DIALOG_STYLE_LIST, "Object Editing:", "{FFFFFF}Information\nPosition\n{FF6347}Edit Materials{FFFFFF}\nSell\nRename\nDuplicate", "Select", "<<");
					return true;
				}

				houseid = InBusiness[playerid];

				if(houseid != -1)
				{
					if(IsAddBizFurniture(houseid, GetBizFurnitures(houseid)))
					{
						new i = -1;

					    if((i = GetNextBizFurnitureSlot(houseid)) != -1)
						{
							new
							    name[48],
							    price = BizFurniture[houseid][furnitureslot][fMarketPrice],
							    model = BizFurniture[houseid][furnitureslot][fModel]
							;

					        format(name, 48, BizFurniture[houseid][furnitureslot][fName]);

							if(PlayerData[playerid][pCash] >= price)
							{
								TakePlayerMoney(playerid, price);

								BizFurniture[houseid][i][fObject] = CreateDynamicObject
								(
									model,
									BizFurniture[houseid][furnitureslot][fPosX],
									BizFurniture[houseid][furnitureslot][fPosY],
									BizFurniture[houseid][furnitureslot][fPosZ],
									BizFurniture[houseid][furnitureslot][fPosRX],
									BizFurniture[houseid][furnitureslot][fPosRY],
									BizFurniture[houseid][furnitureslot][fPosRZ],
									BusinessData[houseid][bWorld],
									BusinessData[houseid][bInterior],
									-1,
									200.0
								);

								SetPVarInt(playerid, "JustBoughtFurniture", 1);
								SetPVarInt(playerid, "ChosenFurnitureSlot", i);

								EditDynamicObject(playerid, BizFurniture[houseid][i][fObject]);

								format(BizFurniture[houseid][i][fName], 48, "%s", name);

								OnPlayerBuyBizFurniture
								(
									houseid, BusinessData[houseid][bInterior], BusinessData[houseid][bWorld], i, model, price, name,
									BizFurniture[houseid][furnitureslot][fPosX], BizFurniture[houseid][furnitureslot][fPosY], BizFurniture[houseid][furnitureslot][fPosZ],
									BizFurniture[houseid][furnitureslot][fPosRX], BizFurniture[houseid][furnitureslot][fPosRY], BizFurniture[houseid][furnitureslot][fPosRZ]
								);

						        ShowPlayerFooter(playerid, "~n~HOLD \"~y~SPACE~w~\" AND PRESS YOUR \"~y~MMB~w~\" KEY TO MOVE YOUR FURNITURE ITEM BACK TO YOU.~n~PRESS YOUR \"~r~ESC~w~\" KEY TO RETURN THE ITEM IF YOU ARE NOT PLEASED", 7000);
								return true;
							}
							else SendClientMessage(playerid, COLOR_GRAD1, "You don't have enough money to buy this.");
						}
						else SendClientMessage(playerid, COLOR_LIGHTRED, "You've reached your furniture limit.");
					}
					else SendClientMessage(playerid, COLOR_LIGHTRED, "You've reached your furniture limit.");

                    Dialog_Show(playerid, FurnitureEditMenu, DIALOG_STYLE_LIST, "Object Editing:", "{FFFFFF}Information\nPosition\n{FF6347}Edit Materials{FFFFFF}\nSell\nRename\nDuplicate", "Select", "<<");
					return true;
				}
		    }
		}
	}
	else
	{
	    DeletePVar(playerid, "ChosenFurnitureSlot");

		Dialog_Show(playerid, FurnitureDialog, DIALOG_STYLE_LIST, "Furniture Main Menu:", "Buy Furniture\nCurrent Furniture\nInformation", "Select", "<<");
	}
	return true;
}

Dialog:HandleFurnitureRename(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		if(strlen(inputtext) < 3 || strlen(inputtext) > 30)
		    return Dialog_Show(playerid, HandleFurnitureRename, DIALOG_STYLE_INPUT, "Custom Naming:", "You can give your furniture a name\n\t- The letter must not be less than 3 characters\n\t- Characters must be at least 3 characters\n\t- Special characters can not be used", "Select", "<<");

		new Regex:r = Regex_New("^[A-Za-z0-9 ]+$"), RegexMatch:m;

		if(!Regex_Match(inputtext, r, m))
		    return Dialog_Show(playerid, HandleFurnitureRename, DIALOG_STYLE_INPUT, "Custom Naming:", "You can give your furniture a name\n\t- The letter must not be less than 3 characters\n\t- Characters must be at least 3 characters\n\t- Special characters can not be used", "Select", "<<");

        OnPlayerRenameFurniture(playerid, GetPVarInt(playerid, "ChosenFurnitureSlot"), inputtext);
	}

	Dialog_Show(playerid, FurnitureEditMenu, DIALOG_STYLE_LIST, "Object Editing:", "{FFFFFF}Information\nPosition\n{FF6347}Edit Materials{FFFFFF}\nSell\nRename\nDuplicate", "Select", "<<");
	return true;
}

Dialog:HandleFurnitureSelling(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new houseid = InProperty[playerid], furnitureslot = GetPVarInt(playerid, "ChosenFurnitureSlot");

		if(houseid != -1)
		{
			new sellprice = floatround(float(HouseFurniture[houseid][furnitureslot][fMarketPrice]) * 0.7);

			SendPlayerMoney(playerid, sellprice);

			DestroyDynamicObject(HouseFurniture[houseid][furnitureslot][fObject]);
			OnPlayerSellHouseFurniture(playerid, houseid, furnitureslot);
		}

        houseid = InBusiness[playerid];

		if(houseid != -1)
		{
			new sellprice = floatround(float(BizFurniture[houseid][furnitureslot][fMarketPrice]) * 0.7);

            SendPlayerMoney(playerid, sellprice);

			DestroyDynamicObject(BizFurniture[houseid][furnitureslot][fObject]);
			OnPlayerSellBizFurniture(playerid, houseid, furnitureslot);
		}

		DeletePVar(playerid, "ChosenFurnitureSlot");

		Dialog_Show(playerid, FurnitureDialog, DIALOG_STYLE_LIST, "Furniture Main Menu:", "Buy Furniture\nCurrent Furniture\nInformation", "Select", "<<");
	}
	else Dialog_Show(playerid, FurnitureEditMenu, DIALOG_STYLE_LIST, "Object Editing:", "{FFFFFF}Information\nPosition\n{FF6347}Edit Materials{FFFFFF}\nSell\nRename\nDuplicate", "Select", "<<");

	return true;
}

GetFurnitureID(modelid)
{
	for(new i = 0; i != sizeof(FurnitureItems); ++i)
	{
		if(FurnitureItems[i][furnitureModel] == modelid)
		{
			return i;
		}
	}
	return 0;
}

Dialog:DisplayFurniture(playerid, response, listitem, inputtext[])
{
	if(response)
	{
	    new
			page = GetPVarInt(playerid, "FurniturePages")
		;

		if(!strcmp(inputtext, ">>", true))
		{
			page++;

		    SetPVarInt(playerid, "FurniturePages", page);

		    ShowPlayerCurrentFurniture(playerid, page);
		    return true;
		}
		else if(!strcmp(inputtext, "<<", true))
		{
		    page--;

		    SetPVarInt(playerid, "FurniturePages", page);

		    ShowPlayerCurrentFurniture(playerid, page);
		    return true;
		}
		else if(!strcmp(inputtext, "*Select The Furniture*", true))
		{
		    SetPVarInt(playerid, "SelectingFurniture", 1);

            SelectObject(playerid);
			return true;
		}
		else
		{
		    if(GetPVarInt(playerid, "EditingFurniture") == 1)
				return SendClientMessage(playerid, COLOR_LIGHTRED, "You are in the middle of fixing the furniture.");

		    new houseid = InProperty[playerid];

		    if(houseid != -1)
			{
				new index[20];
                strmid(index, inputtext, 5, strfind(inputtext, ":", false), 20);
                SetPVarInt(playerid, "ChosenFurnitureSlot", strval(index));

				Dialog_Show(playerid, FurnitureEditMenu, DIALOG_STYLE_LIST, "Object Editing:", "{FFFFFF}Information\nPosition\n{FF6347}Edit Materials{FFFFFF}\nSell\nRename\nDuplicate", "Select", "<<");
				return true;
			}

            houseid = InBusiness[playerid];

		    if(houseid != -1)
			{
				new index[20];
                strmid(index, inputtext, 5, strfind(inputtext, ":", false), 20);
                SetPVarInt(playerid, "ChosenFurnitureSlot", strval(index));

    			Dialog_Show(playerid, FurnitureEditMenu, DIALOG_STYLE_LIST, "Object Editing:", "{FFFFFF}Information\nPosition\n{FF6347}Edit Materials{FFFFFF}\nSell\nRename\nDuplicate", "Select", "<<");
    			return true;
			}
			return true;
		}
	}
	else
	{
		DeletePVar(playerid, "FurniturePages");

		Dialog_Show(playerid, FurnitureDialog, DIALOG_STYLE_LIST, "Furniture Main Menu:", "Buy Furniture\nCurrent Furniture\nInformation", "Select", "<<");
	}
	return true;
}

Dialog:FCategoryDialog(playerid, response, listitem, inputtext[])
{
	if(response)
	{
	    new category = listitem;

		SetPVarInt(playerid, "CategorySelected", category);

		new string[256];

		for(new i = 0; i != sizeof(fSubCategory); ++i)
		{
		    if(fSubCategory[i][catid] == category)
			{
				format(string, sizeof(string), "%s%s\n", string, fSubCategory[i][subname]);
			}
		}

		Dialog_Show(playerid, FSubCategoryDialog, DIALOG_STYLE_LIST, "Categories:", string, "Select", "<<");
	}
	else Dialog_Show(playerid, FurnitureDialog, DIALOG_STYLE_LIST, "Furniture Main Menu:", "Buy Furniture\nCurrent Furniture\nInformation", "Select", "<<");
}

Dialog:FSubCategoryDialog(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new category = GetPVarInt(playerid, "CategorySelected"), count;

		for(new i = 0; i != sizeof(fSubCategory); ++i)
		{
		    if(fSubCategory[i][catid] == category)
			{
				if(listitem == count)
				{
					SetPVarInt(playerid, "SubCategorySelected", i);
					break;
				}

				count++;
			}
		}

		SetPVarInt(playerid, "SubCategoryRow", listitem);

		gstr[0] = EOS;

		for(new i = 0; i != sizeof(FurnitureItems); ++i)
		{
		    if(FurnitureItems[i][furnitureCatalog] == category && FurnitureItems[i][furnitureSubCatalog] == listitem)
			{
				format(gstr, sizeof(gstr), "%s%s\t\t%s\n", gstr, FurnitureItems[i][furnitureName], FormatNumber(FurnitureItems[i][furniturePrice]));
			}
		}

		Dialog_Show(playerid, FurnitureBuyDialog, DIALOG_STYLE_TABLIST, "List of Available Furniture:", gstr, "Select", "<<");
	}
	else
	{
		new string[256];

		for(new i = 0; i != sizeof(fCategory); ++i)
		{
			format(string, sizeof(string), "%s%s\n", string, fCategory[i]);
		}

		Dialog_Show(playerid, FCategoryDialog, DIALOG_STYLE_LIST, "Categories:", string, "Select", "<<");

		DeletePVar(playerid, "CategorySelected");
	}
}

Dialog:FurnitureBuyDialog(playerid, response, listitem, inputtext[])
{
	new string[256];

	if(response)
	{
	    new
			furnitureid,
			count,
			subcategory = GetPVarInt(playerid, "SubCategorySelected"),
			category = GetPVarInt(playerid, "CategorySelected"),
			subrow = GetPVarInt(playerid, "SubCategoryRow")
		;

		for(new i = 0; i != sizeof(FurnitureItems); ++i)
		{
		    if(FurnitureItems[i][furnitureCatalog] == category && FurnitureItems[i][furnitureSubCatalog] == subrow)
			{
				if(listitem == count)
				{
					furnitureid = i;

					SetPVarInt(playerid, "FurnitureSelected", i);
					break;
				}

				count++;
			}
		}

		SetPVarInt(playerid, "FurnitureModelBuying", FurnitureItems[furnitureid][furnitureModel]);
		SetPVarInt(playerid, "FurniturePriceBuying", FurnitureItems[furnitureid][furniturePrice]);
		SetPVarString(playerid, "FurnitureNameBuying", FurnitureItems[furnitureid][furnitureName]);

		format(string, sizeof(string), "{FFFFFF}Category:{FFFF00} %s\n{FFFFFF}Sub-Category:{FFFF00} %s\n{FFFFFF}Item:{FFFF00} %s\n{FFFFFF}Price: {A3A3A3}%s", fCategory[category], fSubCategory[subcategory][subname], FurnitureItems[furnitureid][furnitureName], FormatNumberEx(FurnitureItems[furnitureid][furniturePrice]));
		Dialog_Show(playerid, HandleFurnitureBuying, DIALOG_STYLE_MSGBOX, "Are you Sure:?", string, "Buy", "<<");
	}
	else
	{
	    new category = GetPVarInt(playerid, "CategorySelected");

		for(new i = 0; i != sizeof(fSubCategory); ++i)
		{
		    if(fSubCategory[i][catid] == category)
			{
				format(string, sizeof(string), "%s%s\n", string, fSubCategory[i][subname]);
			}
		}

		Dialog_Show(playerid, FSubCategoryDialog, DIALOG_STYLE_LIST, "Categories:", string, "Select", "<<");
	}
}

Dialog:HandleFurnitureBuying(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new houseid = InProperty[playerid];

		if(houseid != -1)
		{
			if(IsAddHouseFurniture(houseid, GetHouseFurnitures(houseid)))
			{
			    new i = -1;

			    if((i = GetNextHouseFurnitureSlot(houseid)) != -1)
				{
					new Float:px, Float:py, Float:pz;
					GetPlayerPos(playerid, px, py, pz);

					new
					    name[48],
						price = GetPVarInt(playerid, "FurniturePriceBuying"),
						model = GetPVarInt(playerid, "FurnitureModelBuying")
					;

			        GetPVarString(playerid, "FurnitureNameBuying", name, 48);

					if(PlayerData[playerid][pCash] >= price)
					{
						TakePlayerMoney(playerid, price);

		                GetXYInFrontOfPlayer(playerid, px, py, 1.5);

						HouseFurniture[houseid][i][fObject] = CreateDynamicObject(model, px, py, pz, 0.0, 0.0, 0.0, PropertyData[houseid][hWorld], PropertyData[houseid][hInterior], -1, 100.0);

						SetPVarInt(playerid, "JustBoughtFurniture", 1);
						SetPVarInt(playerid, "ChosenFurnitureSlot", i);

						EditDynamicObject(playerid, HouseFurniture[houseid][i][fObject]);

						format(HouseFurniture[houseid][i][fName], 48, "%s", name);

						OnPlayerBuyHouseFurniture(houseid, PropertyData[houseid][hInterior], PropertyData[houseid][hWorld], i, model, price, name, px, py, pz);
				        ShowPlayerFooter(playerid, "~n~HOLD \"~y~SPACE~w~\" AND PRESS YOUR \"~y~MMB~w~\" KEY TO MOVE YOUR FURNITURE ITEM BACK TO YOU.~n~PRESS YOUR \"~r~ESC~w~\" KEY TO RETURN THE ITEM IF YOU ARE NOT PLEASED", 7000);
					}
					else SendClientMessage(playerid, COLOR_GRAD1, "You don't have enough money to buy this.");
				}
				else SendClientMessage(playerid, COLOR_LIGHTRED, "You've reached your furniture limit.");
			}
			else SendClientMessage(playerid, COLOR_LIGHTRED, "You've reached your furniture limit.");

			return true;
		}

		houseid = InBusiness[playerid];

		if(houseid != -1)
		{
			if(IsAddBizFurniture(houseid, GetBizFurnitures(houseid)))
			{
				new i = -1;

			    if((i = GetNextBizFurnitureSlot(houseid)) != -1)
				{
					new Float:px, Float:py, Float:pz;
					GetPlayerPos(playerid, px, py, pz);

					new
					    name[48],
						price = GetPVarInt(playerid, "FurniturePriceBuying"),
						model = GetPVarInt(playerid, "FurnitureModelBuying")
					;

			        GetPVarString(playerid, "FurnitureNameBuying", name, 48);

					if(PlayerData[playerid][pCash] >= price)
					{
						TakePlayerMoney(playerid, price);

		                GetXYInFrontOfPlayer(playerid, px, py, 1.5);

						BizFurniture[houseid][i][fObject] = CreateDynamicObject(model, px, py, pz, 0.0, 0.0, 0.0, BusinessData[houseid][bWorld], BusinessData[houseid][bInterior], -1, 200.0);

						SetPVarInt(playerid, "JustBoughtFurniture", 1);
						SetPVarInt(playerid, "ChosenFurnitureSlot", i);

						EditDynamicObject(playerid, BizFurniture[houseid][i][fObject]);

						format(BizFurniture[houseid][i][fName], 48, "%s", name);

						OnPlayerBuyBizFurniture(houseid, BusinessData[houseid][bInterior], BusinessData[houseid][bWorld], i, model, price, name, px, py, pz);
				        ShowPlayerFooter(playerid, "~n~HOLD \"~y~SPACE~w~\" AND PRESS YOUR \"~y~MMB~w~\" KEY TO MOVE YOUR FURNITURE ITEM BACK TO YOU.~n~PRESS YOUR \"~r~ESC~w~\" KEY TO RETURN THE ITEM IF YOU ARE NOT PLEASED", 7000);
					}
					else SendClientMessage(playerid, COLOR_GRAD1, "You don't have enough money to buy this.");
				}
				else SendClientMessage(playerid, COLOR_LIGHTRED, "You've reached your furniture limit.");
			}
			else SendClientMessage(playerid, COLOR_LIGHTRED, "You've reached your furniture limit.");

			return true;
		}
	}
	else
	{
		DeletePVar(playerid, "FurnitureModelBuying");
		DeletePVar(playerid, "FurniturePriceBuying");
		DeletePVar(playerid, "FurnitureNameBuying");

		new subrow = GetPVarInt(playerid, "SubCategoryRow"), category = GetPVarInt(playerid, "CategorySelected");

        //format(string, sizeof(string), "Furniture Name\tPrice\n");

		gstr[0] = EOS;

		for(new i = 0; i != sizeof(FurnitureItems); ++i)
		{
		    if(FurnitureItems[i][furnitureCatalog] == category && FurnitureItems[i][furnitureSubCatalog] == subrow)
			{
				format(gstr, sizeof(gstr), "%s%s\t\t%s\n", gstr, FurnitureItems[i][furnitureName], FormatNumber(FurnitureItems[i][furniturePrice]));
			}
		}

		Dialog_Show(playerid, FurnitureBuyDialog, DIALOG_STYLE_TABLIST, "List of Available Furniture:", gstr, "Select", "<<");
	}
	return true;
}

GetNextHouseFurnitureSlot(houseid)
{
	for(new i = 0; i < MAX_FURNITURE; ++i)
	{
		if(!HouseFurniture[houseid][i][fOn])
		{
			return i;
		}
	}

	return -1;
}

GetNextBizFurnitureSlot(bizid)
{
	for(new i = 0; i < MAX_FURNITURE; ++i)
	{
		if(!BizFurniture[bizid][i][fOn])
		{
			return i;
		}
	}

	return -1;
}

GetHouseFurnitures(houseid)
{
	new count = 0;

	for(new i = 0; i < MAX_FURNITURE; ++i)
	{
		if(HouseFurniture[houseid][i][fOn])
		{
			count++;
		}
	}

	return count;
}

GetBizFurnitures(bizid)
{
	new count = 0;

	for(new i = 0; i < MAX_FURNITURE; ++i)
	{
		if(BizFurniture[bizid][i][fOn])
		{
			count++;
		}
	}

	return count;
}

OnPlayerBuyHouseFurniture(houseid, interior, world, furnitureslot, model, price, name[], Float:x, Float:y, Float:z, Float:rx = 0.0, Float:ry = 0.0, Float:rz = 0.0)
{
    new largeQuery[512];

	mysql_format(dbCon, largeQuery, sizeof(largeQuery), "INSERT INTO `house_furnitures` (model, name, houseid, interior, virworld, marketprice, posx, posy, posz) VALUES (%d, '%e', %d, %d, %d, %d, %f, %f, %f)",
	model, name, PropertyData[houseid][hID], interior, world, price, x, y ,z);
	mysql_tquery(dbCon, largeQuery, "OnHouseFurnitureInsert", "ii", houseid, furnitureslot);

	HouseFurniture[houseid][furnitureslot][fMarketPrice] = price;
	HouseFurniture[houseid][furnitureslot][fModel] = model;
	HouseFurniture[houseid][furnitureslot][fPosX] = x;
	HouseFurniture[houseid][furnitureslot][fPosY] = y;
	HouseFurniture[houseid][furnitureslot][fPosZ] = z;
	HouseFurniture[houseid][furnitureslot][fPosRX] = rx;
	HouseFurniture[houseid][furnitureslot][fPosRY] = ry;
	HouseFurniture[houseid][furnitureslot][fPosRZ] = rz;
	HouseFurniture[houseid][furnitureslot][fOn] = 1;
	return true;
}

OnPlayerBuyBizFurniture(bizid, interior, world, furnitureslot, model, price, name[], Float:x, Float:y, Float:z, Float:rx = 0.0, Float:ry = 0.0, Float:rz = 0.0)
{
    new largeQuery[512];

	mysql_format(dbCon, largeQuery, sizeof(largeQuery), "INSERT INTO `business_furnitures` (model, name, houseid, interior, virworld, marketprice, posx, posy, posz) VALUES (%d, '%e', %d, %d, %d, %d, %f, %f, %f)",
	model, name, BusinessData[bizid][bID], interior, world, price, x, y ,z);
	mysql_tquery(dbCon, largeQuery, "OnBizFurnitureInsert", "ii", bizid, furnitureslot);

	BizFurniture[bizid][furnitureslot][fMarketPrice] = price;
	BizFurniture[bizid][furnitureslot][fModel] = model;
	BizFurniture[bizid][furnitureslot][fPosX] = x;
	BizFurniture[bizid][furnitureslot][fPosY] = y;
	BizFurniture[bizid][furnitureslot][fPosZ] = z;
	BizFurniture[bizid][furnitureslot][fPosRX] = rx;
	BizFurniture[bizid][furnitureslot][fPosRY] = ry;
	BizFurniture[bizid][furnitureslot][fPosRZ] = rz;
	BizFurniture[bizid][furnitureslot][fOn] = 1;
	return true;
}

IsAddHouseFurniture(houseid, current)
{
	new furniture = 75;

	if(Iter_Contains(Property, houseid))
	{
	    new checkQuery[128], rows, donaterank;
		mysql_format(dbCon, checkQuery, sizeof(checkQuery), "SELECT `DonateRank` FROM `characters` WHERE `ID` = '%d' LIMIT 1", PropertyData[houseid][hOwnerSQLID]);
		new Cache:cache = mysql_query(dbCon, checkQuery);

		rows = cache_num_rows();

		if(rows) cache_get_value_name_int(0, "DonateRank", donaterank);

		cache_delete(cache);

		switch(donaterank)
		{
			case 1:
				furniture = 150;
			case 2:
				furniture = 250;
			case 3:
				furniture = 300;
			default:
				furniture = 75;
		}
	}

	if(current < furniture) return true;

	return false;
}

IsAddBizFurniture(bizid, current)
{
	new furniture = 75;

	if(Iter_Contains(Business, bizid))
	{
	    new checkQuery[128], rows, donaterank;
		mysql_format(dbCon, checkQuery, sizeof(checkQuery), "SELECT `DonateRank` FROM `characters` WHERE `char_name` = '%s' LIMIT 1", BusinessData[bizid][bOwner]);
		new Cache:cache = mysql_query(dbCon, checkQuery);

		rows = cache_num_rows();

		if(rows) cache_get_value_name_int(0, "DonateRank", donaterank);

		cache_delete(cache);

		switch(donaterank)
		{
			case 1:
				furniture = 150;
			case 2:
				furniture = 250;
			case 3:
				furniture = 300;
			default:
				furniture = 75;
		}
	}

	if(current < furniture) return true;

	return false;
}

GetMaximumBizFurniture(bizid)
{
	new furniture = 75;

	if(Iter_Contains(Business, bizid))
	{
	    new checkQuery[128], rows, donaterank;
		mysql_format(dbCon, checkQuery, sizeof(checkQuery), "SELECT `DonateRank` FROM `characters` WHERE `char_name` = '%s' LIMIT 1", BusinessData[bizid][bOwner]);
		new Cache:cache = mysql_query(dbCon, checkQuery);

		rows = cache_num_rows();

		if(rows) cache_get_value_name_int(0, "DonateRank", donaterank);

		cache_delete(cache);

		switch(donaterank)
		{
			case 1:
				furniture = 150;
			case 2:
				furniture = 250;
			case 3:
				furniture = 300;
			default:
				furniture = 75;
		}
	}
	return furniture;
}

GetMaximumHouseFurniture(houseid)
{
	new furniture = 75;

	if(Iter_Contains(Property, houseid))
	{
	    new checkQuery[128], rows, donaterank;
		mysql_format(dbCon, checkQuery, sizeof(checkQuery), "SELECT `DonateRank` FROM `characters` WHERE `ID` = '%d' LIMIT 1", PropertyData[houseid][hOwnerSQLID]);
		new Cache:cache = mysql_query(dbCon, checkQuery);

		rows = cache_num_rows();

		if(rows) cache_get_value_name_int(0, "DonateRank", donaterank);

		cache_delete(cache);

		switch(donaterank)
		{
			case 1:
				furniture = 150;
			case 2:
				furniture = 250;
			case 3:
				furniture = 300;
			default:
				furniture = 75;
		}
	}
	return furniture;
}

LoadHouseFurnitures(houseid)
{
	format(gquery, sizeof(gquery), "SELECT * FROM `house_furnitures` WHERE `houseid` = %d", PropertyData[houseid][hID]);
	mysql_tquery(dbCon, gquery, "OnHouseFurnituresLoad", "i", houseid);
	return true;
}

LoadBizFurnitures(bizid)
{
	format(gquery, sizeof(gquery), "SELECT * FROM `business_furnitures` WHERE `houseid` = %d", BusinessData[bizid][bID]);
	mysql_tquery(dbCon, gquery, "OnBizFurnituresLoad", "i", bizid);
	return true;
}

isHouseDoor(model)
{
	switch (model)
	{
		case 3109, 19857, 3093, 2947, 2955, 2946, 2930, 977, 1491, 1492, 1493, 1494, 1495, 1496, 1497, 1498, 1499..1507, 1559, 1569, 1535, 1523, 1533, 1532, 1522:
		    return true;
	}
	return false;
}

forward OnHouseFurnituresLoad(houseid);
public OnHouseFurnituresLoad(houseid)
{
    new rows;

    cache_get_row_count(rows);

    if(rows)
    {
		for(new i = 0; i < rows; ++i)
		{
			cache_get_value_index_int(i, 0, HouseFurniture[houseid][i][fID]);
			cache_get_value_index_int(i, 1, HouseFurniture[houseid][i][fModel]);

			cache_get_value_index(i, 2, sgstr);
			format(HouseFurniture[houseid][i][fName], 48, sgstr);

			new test;

			cache_get_value_index_int(i, 4, test);
			cache_get_value_index_int(i, 5, test);
			cache_get_value_index_int(i, 6, HouseFurniture[houseid][i][fMarketPrice]);
			cache_get_value_index_float(i, 7, HouseFurniture[houseid][i][fPosX]);
			cache_get_value_index_float(i, 8, HouseFurniture[houseid][i][fPosY]);
			cache_get_value_index_float(i, 9, HouseFurniture[houseid][i][fPosZ]);
			cache_get_value_index_float(i, 10, HouseFurniture[houseid][i][fPosRX]);
			cache_get_value_index_float(i, 11, HouseFurniture[houseid][i][fPosRY]);
			cache_get_value_index_float(i, 12, HouseFurniture[houseid][i][fPosRZ]);

			HouseFurniture[houseid][i][fOn] = 1;

        	HouseFurniture[houseid][i][fObject] = CreateDynamicObject(HouseFurniture[houseid][i][fModel], HouseFurniture[houseid][i][fPosX], HouseFurniture[houseid][i][fPosY], HouseFurniture[houseid][i][fPosZ], HouseFurniture[houseid][i][fPosRX], HouseFurniture[houseid][i][fPosRY], HouseFurniture[houseid][i][fPosRZ], PropertyData[houseid][hWorld], PropertyData[houseid][hInterior], -1, 100.0, 100.0);

			new matModel[3], matTxd[32], matText[32], matColor[32];

            cache_get_value_index_int(i, 13, matModel[0]);
            cache_get_value_index_int(i, 14, matModel[1]);
            cache_get_value_index_int(i, 15, matModel[2]);

            if(matModel[0] != -1)
            {
                cache_get_value_index(i, 16, matTxd);
                cache_get_value_index(i, 19, matText);
                cache_get_value_index(i, 22, matColor);

                SetDynamicObjectMaterial(HouseFurniture[houseid][i][fObject], 0, matModel[0], matTxd, matText, HexToInt(matColor));
            }
            if(matModel[1] != -1)
            {
                cache_get_value_index(i, 17, matTxd);
                cache_get_value_index(i, 20, matText);
                cache_get_value_index(i, 23, matColor);

                SetDynamicObjectMaterial(HouseFurniture[houseid][i][fObject], 1, matModel[1], matTxd, matText, HexToInt(matColor));
            }
            if(matModel[2] != -1)
            {
                cache_get_value_index(i, 18, matTxd);
                cache_get_value_index(i, 21, matText);
                cache_get_value_index(i, 24, matColor);

                SetDynamicObjectMaterial(HouseFurniture[houseid][i][fObject], 2, matModel[2], matTxd, matText, HexToInt(matColor));
            }

			if(isHouseDoor(HouseFurniture[houseid][i][fModel]))
			{
				HouseFurniture[houseid][i][fLocked] = 1;
				HouseFurniture[houseid][i][fOpened] = false;
			}
		}
    }
    return true;
}

forward OnBizFurnituresLoad(bizid);
public OnBizFurnituresLoad(bizid)
{
    new rows;

    cache_get_row_count(rows);

    if(rows)
    {
		for(new i = 0; i < rows; ++i)
		{
			cache_get_value_index_int(i, 0, BizFurniture[bizid][i][fID]);
			cache_get_value_index_int(i, 1, BizFurniture[bizid][i][fModel]);

			cache_get_value_index(i, 2, sgstr);
			format(BizFurniture[bizid][i][fName], 48, sgstr);

			new test;

			cache_get_value_index_int(i, 4, test);
			cache_get_value_index_int(i, 5, test);
			cache_get_value_index_int(i, 6, BizFurniture[bizid][i][fMarketPrice]);
			cache_get_value_index_float(i, 7, BizFurniture[bizid][i][fPosX]);
			cache_get_value_index_float(i, 8, BizFurniture[bizid][i][fPosY]);
			cache_get_value_index_float(i, 9, BizFurniture[bizid][i][fPosZ]);
			cache_get_value_index_float(i, 10, BizFurniture[bizid][i][fPosRX]);
			cache_get_value_index_float(i, 11, BizFurniture[bizid][i][fPosRY]);
			cache_get_value_index_float(i, 12, BizFurniture[bizid][i][fPosRZ]);

			BizFurniture[bizid][i][fOn] = 1;

			BizFurniture[bizid][i][fObject] = CreateDynamicObject(BizFurniture[bizid][i][fModel], BizFurniture[bizid][i][fPosX], BizFurniture[bizid][i][fPosY], BizFurniture[bizid][i][fPosZ], BizFurniture[bizid][i][fPosRX], BizFurniture[bizid][i][fPosRY], BizFurniture[bizid][i][fPosRZ], BusinessData[bizid][bWorld], BusinessData[bizid][bInterior], -1, 150.0);

			new matModel[3], matTxd[32], matText[32], matColor[32];

            cache_get_value_index_int(i, 13, matModel[0]);
            cache_get_value_index_int(i, 14, matModel[1]);
            cache_get_value_index_int(i, 15, matModel[2]);

            if(matModel[0] != -1)
            {
                cache_get_value_index(i, 16, matTxd);
                cache_get_value_index(i, 19, matText);
                cache_get_value_index(i, 22, matColor);

                SetDynamicObjectMaterial(BizFurniture[bizid][i][fObject], 0, matModel[0], matTxd, matText, HexToInt(matColor));
            }
            if(matModel[1] != -1)
            {
                cache_get_value_index(i, 17, matTxd);
                cache_get_value_index(i, 20, matText);
                cache_get_value_index(i, 23, matColor);

                SetDynamicObjectMaterial(BizFurniture[bizid][i][fObject], 1, matModel[1], matTxd, matText, HexToInt(matColor));
            }
            if(matModel[2] != -1)
            {
                cache_get_value_index(i, 18, matTxd);
                cache_get_value_index(i, 21, matText);
                cache_get_value_index(i, 24, matColor);

                SetDynamicObjectMaterial(BizFurniture[bizid][i][fObject], 2, matModel[2], matTxd, matText, HexToInt(matColor));
            }

			if(isHouseDoor(BizFurniture[bizid][i][fModel]))
			{
				BizFurniture[bizid][i][fLocked] = 1;
				BizFurniture[bizid][i][fOpened] = false;
			}
		}
    }
    return true;
}

forward OnHouseFurnitureInsert(houseid, furnitureslot);
public OnHouseFurnitureInsert(houseid, furnitureslot)
{
	HouseFurniture[houseid][furnitureslot][fID] = cache_insert_id();
	return true;
}

forward OnBizFurnitureInsert(bizid, furnitureslot);
public OnBizFurnitureInsert(bizid, furnitureslot)
{
	BizFurniture[bizid][furnitureslot][fID] = cache_insert_id();
	return true;
}

OnPlayerEditedFurniture(playerid, furnitureslot, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	if(InProperty[playerid] != -1)
	{
		mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `house_furnitures` SET `posx` = %f, `posy` = %f, `posz` = %f, `posrx` = %f, `posry` = %f, `posrz` = %f WHERE `id` = %d",
		x, y, z, rx, ry, rz, HouseFurniture[ InProperty[playerid] ][furnitureslot][fID]);
		mysql_tquery(dbCon, gquery, "OnFurnitureUpdatePos", "iiffffff", playerid, furnitureslot, x, y, z, rx, ry, rz);
		return true;
	}

	if(InBusiness[playerid] != -1)
	{
		mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `business_furnitures` SET `posx` = %f, `posy` = %f, `posz` = %f, `posrx` = %f, `posry` = %f, `posrz` = %f WHERE `id` = %d",
		x, y, z, rx, ry, rz, BizFurniture[ InBusiness[playerid] ][furnitureslot][fID]);
		mysql_tquery(dbCon, gquery, "OnFurnitureUpdatePos", "iiffffff", playerid, furnitureslot, x, y, z, rx, ry, rz);
		return true;
	}
	return true;
}

forward OnFurnitureUpdatePos(playerid, furnitureslot, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz);
public OnFurnitureUpdatePos(playerid, furnitureslot, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	if(InProperty[playerid] != -1)
	{
		HouseFurniture[ InProperty[playerid] ][furnitureslot][fPosX] = x;
		HouseFurniture[ InProperty[playerid] ][furnitureslot][fPosY] = y;
		HouseFurniture[ InProperty[playerid] ][furnitureslot][fPosZ] = z;
		HouseFurniture[ InProperty[playerid] ][furnitureslot][fPosRX] = rx;
		HouseFurniture[ InProperty[playerid] ][furnitureslot][fPosRY] = ry;
		HouseFurniture[ InProperty[playerid] ][furnitureslot][fPosRZ] = rz;
		return true;
	}

	if(InBusiness[playerid] != -1)
	{
		BizFurniture[ InBusiness[playerid] ][furnitureslot][fPosX] = x;
		BizFurniture[ InBusiness[playerid] ][furnitureslot][fPosY] = y;
		BizFurniture[ InBusiness[playerid] ][furnitureslot][fPosZ] = z;
		BizFurniture[ InBusiness[playerid] ][furnitureslot][fPosRX] = rx;
		BizFurniture[ InBusiness[playerid] ][furnitureslot][fPosRY] = ry;
		BizFurniture[ InBusiness[playerid] ][furnitureslot][fPosRZ] = rz;
		return true;
	}
	return true;
}

OnPlayerRenameFurniture(playerid, furnitureslot, name[])
{
	if(InProperty[playerid] != -1)
	{
		mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `house_furnitures` SET `name` = '%e' WHERE `id` = '%d' LIMIT 1", name, HouseFurniture[ InProperty[playerid] ][furnitureslot][fID]);
		mysql_pquery(dbCon, gquery);

		format(HouseFurniture[ InProperty[playerid] ][furnitureslot][fName], 48, "%s", name);
		return true;
	}

	if(InBusiness[playerid] != -1)
	{
		mysql_format(dbCon, gquery, sizeof(gquery), "UPDATE `business_furnitures` SET `name` = '%e' WHERE `id` = '%d' LIMIT 1", name, BizFurniture[ InBusiness[playerid] ][furnitureslot][fID]);
		mysql_pquery(dbCon, gquery);

		format(BizFurniture[ InBusiness[playerid] ][furnitureslot][fName], 48, "%s", name);
		return true;
	}
	return true;
}

OnPlayerSellHouseFurniture(playerid, houseid, furnitureslot)
{
	mysql_format(dbCon, gquery, sizeof(gquery), "DELETE FROM `house_furnitures` WHERE `id` = '%d' LIMIT 1", HouseFurniture[houseid][furnitureslot][fID]);
	mysql_tquery(dbCon, gquery, "OnPlayerSoldHouseFurniture", "idd", playerid, houseid, furnitureslot);
	return true;
}

OnPlayerSellBizFurniture(playerid, bizid, furnitureslot)
{
	mysql_format(dbCon, gquery, sizeof(gquery), "DELETE FROM `business_furnitures` WHERE `id` = '%d' LIMIT 1", BizFurniture[bizid][furnitureslot][fID]);
	mysql_tquery(dbCon, gquery, "OnPlayerSoldBizFurniture", "idd", playerid, bizid, furnitureslot);
	return true;
}

forward OnPlayerSoldHouseFurniture(playerid, houseid, furnitureslot);
public OnPlayerSoldHouseFurniture(playerid, houseid, furnitureslot)
{
	HouseFurniture[houseid][furnitureslot][fMarketPrice] = 0;
	HouseFurniture[houseid][furnitureslot][fModel] = 0;
	HouseFurniture[houseid][furnitureslot][fPosX] = 0.0;
	HouseFurniture[houseid][furnitureslot][fPosY] = 0.0;
	HouseFurniture[houseid][furnitureslot][fPosZ] = 0.0;
	HouseFurniture[houseid][furnitureslot][fPosRX] = 0.0;
	HouseFurniture[houseid][furnitureslot][fPosRY] = 0.0;
	HouseFurniture[houseid][furnitureslot][fPosRZ] = 0.0;
	format(HouseFurniture[houseid][furnitureslot][fName], 46, "Null");
	HouseFurniture[houseid][furnitureslot][fOn] = 0;

	Property_Save(houseid);
	return true;
}

forward OnPlayerSoldBizFurniture(playerid, bizid, furnitureslot);
public OnPlayerSoldBizFurniture(playerid, bizid, furnitureslot)
{
	BizFurniture[bizid][furnitureslot][fMarketPrice] = 0;
	BizFurniture[bizid][furnitureslot][fModel] = 0;
	BizFurniture[bizid][furnitureslot][fPosX] = 0.0;
	BizFurniture[bizid][furnitureslot][fPosY] = 0.0;
	BizFurniture[bizid][furnitureslot][fPosZ] = 0.0;
	BizFurniture[bizid][furnitureslot][fPosRX] = 0.0;
	BizFurniture[bizid][furnitureslot][fPosRY] = 0.0;
	BizFurniture[bizid][furnitureslot][fPosRZ] = 0.0;
	format(BizFurniture[bizid][furnitureslot][fName], 46, "Null");
	BizFurniture[bizid][furnitureslot][fOn] = 0;

    Business_Save(bizid);
	return true;
}