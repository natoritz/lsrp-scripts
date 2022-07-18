// Defines

#define MAX_CLOTHES (15)

#define BUYZIP      (1)
#define BUYHARDWARE (2)
#define BUYSPORTS   (3)
#define BUYMUSIC    (4)

// Variables

enum e_cldata
{
	e_model,
	e_price,
	e_bone,
	e_name[35],
	Float:e_x,
	Float:e_y,
	Float:e_z,
	Float:e_rx,
	Float:e_ry,
	Float:e_rz,
	Float:e_sx,
	Float:e_sy,
	Float:e_sz
};

new const cl_SportsData[][e_cldata] = // 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0
{
	{18645, 2000, 2, "(Red & White) Motorcycle Helmet", 0.059999, 0.023999, 0.005, 93.6, 75.3, 0.0, 1.0, 1.0, 1.0},
	{18976, 2000, 2, "(Blue & White) DirtBike Helmet", 0.084999, 0.043999, -0.002, 82.1, 88.2999, 8.5, 1.0, 1.0, 1.0},
	{18977, 2000, 2, "(Red & Black) Motorcycle Helmet", 0.052999, 0.016999, 0.006999, 0.0, 91.1, 75.7, 1.0, 1.0, 1.0},
	{18978, 2000, 2, "(Blue & White) Motorcycle Helmet", 0.052999, 0.032, -0.007, 74.9, 86.5, -4.60001, 1.0, 1.0, 1.0},
	{18979, 2000, 2, "(Purple) Motorcycle Helmet", 0.051999, 0.028, 0.0, 93.3, 74.8, -9.6, 1.0, 1.0, 1.0},
	{19036, 157, 2, "White Hockey Mask", 0.088996, 0.043997, -0.002998, 101.3, 92.2001, -16.5, 1.0, 1.0, 1.0},
	{19037, 157, 2, "Red Hockey Mask", 0.088996, 0.043997, -0.002998, 101.3, 92.2001, -16.5, 1.0, 1.0, 1.0},
	{19038, 157, 2, "Green Hockey Mask", 0.088996, 0.043997, -0.002998, 101.3, 92.2001, -16.5, 1.0, 1.0, 1.0},
	{3026, 450, 1, "Backpack", -0.147999, -0.061999, 0.006999, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0},
	{11745, 660, 6, "Sports Bag", 0.209999, -0.118999, 0.0, 10.5, -91.4, -92.5, 1.0, 1.0, 1.0}
};

new const cl_ZipData[][e_cldata] = // 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0
{
	{19066, 400, 2, "Santa Hat", 0.1229, 0.0350, 0.000, 90.7, 119.2999, -2.4, 1.0, 1.0, 1.0},
	{18970, 200, 2, "Tiger Pimp Hat", 0.1089, 0.0360, 0.0000, 0.0000, 93.5999, 87.7999, 1.0, 1.0, 1.0},
	{18971, 200, 2, "Disco Pimp Hat", 0.1089, 0.0360, 0.0000, 0.0000, 93.5999, 87.7999, 1.0, 1.0, 1.0},
	{18972, 200, 2, "Lava Pimp Hat", 0.1089, 0.0360, 0.0000, 0.0000, 93.5999, 87.7999, 1.0, 1.0, 1.0},
	{18973, 200, 2, "Camo Pimp Hat", 0.1089, 0.0360, 0.0000, 0.0000, 93.5999, 87.7999, 1.0, 1.0, 1.0},
	{18921, 210, 2, "Beret", 0.1430, 0.0210, -0.0029, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{18922, 210, 2, "Red Beret", 0.1430, 0.0210, -0.0029, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{18923, 210, 2, "Blue Beret", 0.1430, 0.0210, -0.0029, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{18924, 210, 2, "Camo Beret", 0.1430, 0.0210, -0.0029, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{19067, 220, 2, "Red Hoody Hat", 0.1239, 0.0290, -0.0009, 85.5999, 118.7000, 1.0000, 1.0, 1.0, 1.0},
	{19068, 220, 2, "Zebra Hoody Hat", 0.1239, 0.0290, -0.0009, 85.5999, 118.7000, 1.0000, 1.0, 1.0, 1.0},
	{19069, 220, 2, "Black Hoody Hat", 0.1239, 0.0290, -0.0009, 85.5999, 118.7000, 1.0000, 1.0, 1.0, 1.0},
	{18926, 200, 2, "Camo Hat", 0.1460, 0.0250, -0.0070, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{18927, 200, 2, "Blue Flame Hat", 0.1460, 0.0250, -0.0070, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{18928, 200, 2, "Hippie Hat", 0.1460, 0.0250, -0.0070, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{18929, 200, 2, "Illusion Hat", 0.1460, 0.0250, -0.0070, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{18930, 200, 2, "Fire Hat", 0.1460, 0.0250, -0.0070, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{18931, 200, 2, "Dark Flame Hat", 0.1460, 0.0250, -0.0070, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{18932, 200, 2, "Lava Hat", 0.1460, 0.0250, -0.0070, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{18933, 200, 2, "Poka Dot Hat", 0.1460, 0.0250, -0.0070, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{18934, 200, 2, "Red Hat", 0.1460, 0.0250, -0.0070, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{18935, 200, 2, "Yellow Hat", 0.1460, 0.0250, -0.0070, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{18941, 200, 2, "Black Hat", 0.1460, 0.0250, -0.0070, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{18942, 200, 2, "Dark Blue Hat", 0.1460, 0.0250, -0.0070, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{18943, 200, 2, "Green Hat", 0.1460, 0.0250, -0.0070, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{18961, 200, 2, "Trucker Hat", 0.1370, 0.0320, 0.0030, 103.0000, 94.0000, -14.9000, 1.0, 1.0, 1.0},
	{18960, 200, 2, "Cap Rim Up", 0.1370, 0.0320, 0.0030, 103.0000, 94.0000, -14.9000, 1.0, 1.0, 1.0},
	{18936, 250, 2, "Grey Helmet", 0.0980, 0.0369, 0.0000, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{18937, 250, 2, "Red Helmet", 0.0980, 0.0369, 0.0000, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{18938, 250, 2, "Purple Helmet", 0.0980, 0.0369, 0.0000, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{19101, 240, 2, "Army Helmet(Straps)", 0.1470, 0.0260, 0.0000, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{19102, 240, 2, "Navy Helmet(Straps)", 0.1470, 0.0260, 0.0000, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{19103, 240, 2, "Desert Helmet(Straps)", 0.1470, 0.0260, 0.0000, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{19104, 240, 2, "Day Camo Helmet(Straps)", 0.1470, 0.0260, 0.0000, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{19105, 240, 2, "Night Camo Helmet(Straps)", 0.1470, 0.0260, 0.0000, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{19106, 220, 2, "Army Helmet", 0.1470, 0.0260, 0.0000, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{19107, 220, 2, "Navy Helmet", 0.1470, 0.0260, 0.0000, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{19108, 220, 2, "Desert Helmet", 0.1470, 0.0260, 0.0000, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{19109, 220, 2, "Day Camo Helmet", 0.1470, 0.0260, 0.0000, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{19110, 220, 2, "Night Camo Helmet", 0.1470, 0.0260, 0.0000, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{19111, 220, 2, "Sand Camo Helmet", 0.1470, 0.0260, 0.0000, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{19112, 220, 2, "Pink Camo Helmet", 0.1470, 0.0260, 0.0000, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{18911, 150, 2, "Skull Bandana", 0.0785, 0.0348, -0.0007, 268.9704, 1.5333, 269.2237, 1.0, 1.0, 1.0},
    {18912, 150, 2, "Black Bandana", 0.0785, 0.0348, -0.0007, 268.9704, 1.5333, 269.2237, 1.0, 1.0, 1.0},
    {18913, 150, 2, "Green Bandana", 0.0785, 0.0348, -0.0007, 268.9704, 1.5333, 269.2237, 1.0, 1.0, 1.0},
    {18914, 150, 2, "Camo Bandana", 0.0785, 0.0348, -0.0007, 268.9704, 1.5333, 269.2237, 1.0, 1.0, 1.0},
    {18915, 150, 2, "Funky Bandana", 0.0785, 0.0348, -0.0007, 268.9704, 1.5333, 269.2237, 1.0, 1.0, 1.0},
    {18916, 150, 2, "Triangle Bandana", 0.0785, 0.0348, -0.0007, 268.9704, 1.5333, 269.2237, 1.0, 1.0, 1.0},
    {18917, 150, 2, "Dark Blue Bandana", 0.0785, 0.0348, -0.0007, 268.9704, 1.5333, 269.2237, 1.0, 1.0, 1.0},
    {18918, 150, 2, "Black & White Bandana", 0.0785, 0.0348, -0.0007, 268.9704, 1.5333, 269.2237, 1.0, 1.0, 1.0},
    {18919, 150, 2, "Dots Bandana", 0.0785, 0.0348, -0.0007, 268.9704, 1.5333, 269.2237, 1.0, 1.0, 1.0},
    {18920, 150, 2, "Triangle & Dots Bandana", 0.0785, 0.0348, -0.0007, 268.9704, 1.5333, 269.2237, 1.0, 1.0, 1.0},
    {19469, 150, 1, "Scarf", 0.3000, 0.0550, -0.0369, -5.8999, 0.0000, 26.2000, 1.0000, 1.5519, 1.3889},
	{18944, 210, 2, "Lava Hat Boater", 0.1330, 0.0180, 0.0000, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{18945, 210, 2, "Grey Hat Boater", 0.1330, 0.0180, 0.0000, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{18946, 210, 2, "Casual Hat Boater", 0.1330, 0.0180, 0.0000, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{18947, 230, 2, "Black Hat Bowler", 0.1390, 0.0180, -0.0010, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
    {18948, 230, 2, "Blue Hat Bowler", 0.1390, 0.0180, -0.0010, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
    {18949, 230, 2, "Green Hat Bowler", 0.1390, 0.0180, -0.0010, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
    {18950, 230, 2, "Red Hat Bowler", 0.1390, 0.0180, -0.0010, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
    {18951, 230, 2, "Yellow Hat Bowler", 0.1390, 0.0180, -0.0010, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{18953, 200, 2, "Black Cap Knit", 0.1110, 0.0340, -0.0010, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{18954, 200, 2, "Grey Cap Knit", 0.1110, 0.0340, -0.0010, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{18955, 205, 2, "Lava Cap Eye", 0.1030, 0.0440, 0.0009, -95.6000, 92.2001, -161.9002, 1.0, 1.0, 1.0},
	{18956, 205, 2, "Dark Flame Cap Eye", 0.1030, 0.0440, 0.0009, -95.6000, 92.2001, -161.9002, 1.0, 1.0, 1.0},
	{18957, 205, 2, "Blue Cap Eye", 0.1030, 0.0440, 0.0009, -95.6000, 92.2001, -161.9002, 1.0, 1.0, 1.0},
	{18958, 205, 2, "Cheetah Cap Eye", 0.1030, 0.0440, 0.0009, -95.6000, 92.2001, -161.9002, 1.0, 1.0, 1.0},
	{18959, 205, 2, "Camo Cap Eye", 0.1030, 0.0440, 0.0009, -95.6000, 92.2001, -161.9002, 1.0, 1.0, 1.0},
	{18964, 180, 2, "Black Skully Cap", 0.1210, 0.0310, 0.0000, 95.3000, 107.1999, 0.0000, 1.0, 1.0, 1.0},
	{18965, 180, 2, "Skully Cap", 0.1210, 0.0310, 0.0000, 95.3000, 107.1999, 0.0000, 1.0, 1.0, 1.0},
	{18966, 180, 2, "Funky Skully Cap", 0.1210, 0.0310, 0.0000, 95.3000, 107.1999, 0.0000, 1.0, 1.0, 1.0},
	{18967, 180, 2, "Black Chav Hat", 0.1030, 0.0260, 0.0000, 95.7000, 87.3999, -0.3999, 1.0, 1.0, 1.0},
	{18968, 180, 2, "Chav Hat", 0.1030, 0.0260, 0.0000, 95.7000, 87.3999, -0.3999, 1.0, 1.0, 1.0},
	{18969, 180, 2, "Lava Chav Hat", 0.1030, 0.0260, 0.0000, 95.7000, 87.3999, -0.3999, 1.0, 1.0, 1.0},
	{19006, 50, 2, "Red Glasses", 0.0879, 0.0460, 0.0000, 91.0999, 85.3999, 0.0000, 1.0, 1.0, 1.0},
	{19007, 50, 2, "Orange Glasses", 0.0879, 0.0460, 0.0000, 91.0999, 85.3999, 0.0000, 1.0, 1.0, 1.0},
	{19008, 50, 2, "Green Glasses", 0.0879, 0.0460, 0.0000, 91.0999, 85.3999, 0.0000, 1.0, 1.0, 1.0},
	{19009, 50, 2, "Blue Glasses", 0.0879, 0.0460, 0.0000, 91.0999, 85.3999, 0.0000, 1.0, 1.0, 1.0},
	{19010, 50, 2, "Pink Glasses", 0.0879, 0.0460, 0.0000, 91.0999, 85.3999, 0.0000, 1.0, 1.0, 1.0},
	{19011, 50, 2, "Black & White Glasses", 0.0879, 0.0460, 0.0000, 91.0999, 85.3999, 0.0000, 1.0, 1.0, 1.0},
	{19012, 50, 2, "Black Glasses", 0.0879, 0.0460, 0.0000, 91.0999, 85.3999, 0.0000, 1.0, 1.0, 1.0},
	{19013, 50, 2, "Dot Glasses", 0.0879, 0.0460, 0.0000, 91.0999, 85.3999, 0.0000, 1.0, 1.0, 1.0},
	{19014, 50, 2, "Square Glasses", 0.0879, 0.0460, 0.0000, 91.0999, 85.3999, 0.0000, 1.0, 1.0, 1.0},
	{19015, 50, 2, "Lucent Glasses", 0.0879, 0.0460, 0.0000, 91.0999, 85.3999, 0.0000, 1.0, 1.0, 1.0},
	{19016, 50, 2, "X-Ray Glasses", 0.0879, 0.0460, 0.0000, 91.0999, 85.3999, 0.0000, 1.0, 1.0, 1.0},
	{19017, 50, 2, "Plain Yellow Glasses", 0.0879, 0.0460, 0.0000, 91.0999, 85.3999, 0.0000, 1.0, 1.0, 1.0},
	{19018, 50, 2, "Plain Orange Glasses", 0.0879, 0.0460, 0.0000, 91.0999, 85.3999, 0.0000, 1.0, 1.0, 1.0},
	{19019, 50, 2, "Plain Red Glasses", 0.0879, 0.0460, 0.0000, 91.0999, 85.3999, 0.0000, 1.0, 1.0, 1.0},
	{19020, 50, 2, "Plain Blue Glasses", 0.0879, 0.0460, 0.0000, 91.0999, 85.3999, 0.0000, 1.0, 1.0, 1.0},
	{19021, 50, 2, "Plain Green Glasses", 0.0879, 0.0460, 0.0000, 91.0999, 85.3999, 0.0000, 1.0, 1.0, 1.0},
	{19022, 50, 2, "Lucent Aviators", 0.0879, 0.0460, 0.0000, 91.0999, 85.3999, 0.0000, 1.0, 1.0, 1.0},
	{19023, 50, 2, "Blue Aviators", 0.0879, 0.0460, 0.0000, 91.0999, 85.3999, 0.0000, 1.0, 1.0, 1.0},
	{19024, 50, 2, "Purple Aviators", 0.0879, 0.0460, 0.0000, 91.0999, 85.3999, 0.0000, 1.0, 1.0, 1.0},
	{19025, 50, 2, "Pink Aviators", 0.0879, 0.0460, 0.0000, 91.0999, 85.3999, 0.0000, 1.0, 1.0, 1.0},
	{19026, 50, 2, "Red Aviators", 0.0879, 0.0460, 0.0000, 91.0999, 85.3999, 0.0000, 1.0, 1.0, 1.0},
	{19027, 50, 2, "Orange Aviators", 0.0879, 0.0460, 0.0000, 91.0999, 85.3999, 0.0000, 1.0, 1.0, 1.0},
	{19028, 50, 2, "Yellow Aviators", 0.0879, 0.0460, 0.0000, 91.0999, 85.3999, 0.0000, 1.0, 1.0, 1.0},
	{19029, 50, 2, "Green Aviators", 0.0879, 0.0460, 0.0000, 91.0999, 85.3999, 0.0000, 1.0, 1.0, 1.0},
	{19030, 50, 2, "Thick Lucent", 0.0879, 0.0460, 0.0000, 91.0999, 85.3999, 0.0000, 1.0, 1.0, 1.0},
	{19031, 50, 2, "Thick Yellow", 0.0879, 0.0460, 0.0000, 91.0999, 85.3999, 0.0000, 1.0, 1.0, 1.0},
	{19032, 50, 2, "Thick Red", 0.0879, 0.0460, 0.0000, 91.0999, 85.3999, 0.0000, 1.0, 1.0, 1.0},
	{19033, 50, 2, "Plain Black Glasses", 0.0879, 0.0460, 0.0000, 91.0999, 85.3999, 0.0000, 1.0, 1.0, 1.0},
    {19024, 50, 2, "Squares Glasses", 0.0879, 0.0460, 0.0000, 91.0999, 85.3999, 0.0000, 1.0, 1.0, 1.0},
    {19025, 50, 2, "Dark Blue Glasses", 0.0879, 0.0460, 0.0000, 91.0999, 85.3999, 0.0000, 1.0, 1.0, 1.0},
	{19349, 50, 2, "Monocle", 0.0769, 0.1050, 0.0340, 120.9999, 2.6999, -96.3998, 1.0, 1.0, 1.0},
	{18891, 150, 2, "Blue Bandana", 0.1149, 0.0160, -0.0029, -88.2001, 8.3999, -95.0999, 1.0, 1.0, 1.0},
	{18892, 150, 2, "Red Bandana", 0.1149, 0.0160, -0.0029, -88.2001, 8.3999, -95.0999, 1.0, 1.0, 1.0},
	{18893, 150, 2, "White & Red  Bandana", 0.1149, 0.0160, -0.0029, -88.2001, 8.3999, -95.0999, 1.0, 1.0, 1.0},
	{18894, 150, 2, "Bob Marley Bandana", 0.1149, 0.0160, -0.0029, -88.2001, 8.3999, -95.0999, 1.0, 1.0, 1.0},
	{18895, 150, 2, "Skulls Bandana", 0.1149, 0.0160, -0.0029, -88.2001, 8.3999, -95.0999, 1.0, 1.0, 1.0},
	{18896, 150, 2, "Black & White Bandana", 0.1149, 0.0160, -0.0029, -88.2001, 8.3999, -95.0999, 1.0, 1.0, 1.0},
	{18897, 150, 2, "Blue & White Bandana", 0.1149, 0.0160, -0.0029, -88.2001, 8.3999, -95.0999, 1.0, 1.0, 1.0},
	{18898, 150, 2, "Green & White Bandana", 0.1149, 0.0160, -0.0029, -88.2001, 8.3999, -95.0999, 1.0, 1.0, 1.0},
	{18899, 150, 2, "Purple & White Bandana", 0.1149, 0.0160, -0.0029, -88.2001, 8.3999, -95.0999, 1.0, 1.0, 1.0},
	{18900, 150, 2, "Psychedelic Bandana", 0.1149, 0.0160, -0.0029, -88.2001, 8.3999, -95.0999, 1.0, 1.0, 1.0},
	{18901, 150, 2, "Fall Camo Bandana", 0.1149, 0.0160, -0.0029, -88.2001, 8.3999, -95.0999, 1.0, 1.0, 1.0},
	{18902, 150, 2, "Yellow Bandana", 0.1149, 0.0160, -0.0029, -88.2001, 8.3999, -95.0999, 1.0, 1.0, 1.0},
	{18903, 150, 2, "Light Blue Bandana", 0.1149, 0.0160, -0.0029, -88.2001, 8.3999, -95.0999, 1.0, 1.0, 1.0},
	{18904, 150, 2, "Dark Blue Bandana", 0.1149, 0.0160, -0.0029, -88.2001, 8.3999, -95.0999, 1.0, 1.0, 1.0},
    {18905, 150, 2, "Hay Bandana", 0.1149, 0.0160, -0.0029, -88.2001, 8.3999, -95.0999, 1.0, 1.0, 1.0},
    {18906, 150, 2, "Red & Yellow Bandana", 0.1149, 0.0160, -0.0029, -88.2001, 8.3999, -95.0999, 1.0, 1.0, 1.0},
	{18907, 150, 2, "Psychedelic Bandana", 0.1149, 0.0160, -0.0029, -88.2001, 8.3999, -95.0999, 1.0, 1.0, 1.0},
	{18908, 150, 2, "Waves Bandana", 0.1149, 0.0160, -0.0029, -88.2001, 8.3999, -95.0999, 1.0, 1.0, 1.0},
	{18909, 150, 2, "Sky Blue Bandana", 0.1149, 0.0160, -0.0029, -88.2001, 8.3999, -95.0999, 1.0, 1.0, 1.0},
	{18910, 150, 2, "Lava Bandana", 0.1149, 0.0160, -0.0029, -88.2001, 8.3999, -95.0999, 1.0, 1.0, 1.0},
	{18962, 200, 2, "Black Cowboy Hat", 0.1630, 0.0270, 0.0000, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{19095, 200, 2, "Light Brown Cowboy Hat", 0.1630, 0.0270, 0.0000, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{19096, 200, 2, "Dark Blue Cowboy Hat", 0.1630, 0.0270, 0.0000, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
	{19097, 200, 2, "Red Cowboy Hat", 0.1630, 0.0270, 0.0000, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
    {19098, 200, 2, "Brown Cowboy Hat", 0.1630, 0.0270, 0.0000, 0.0000, 0.0000, 0.0000, 1.0, 1.0, 1.0},
    {19352, 220, 2, "Top Hat", 0.1039, 0.0210, 0.0060, 93.7000, 74.3000, 0.0000, 1.0, 1.0, 1.0}
};

new const cl_MusicData[][e_cldata] =
{
	{19317, 14500, 6, "Bass Guitar", 0.059999, 0.023999, 0.005, 93.6, 75.3, 0.0, 1.0, 1.0, 1.0},
	{19318, 16240, 6, "Electric Guitar", 0.084999, 0.043999, -0.002, 82.1, 88.2999, 8.5, 1.0, 1.0, 1.0},
	{19610, 1000, 6, "Microphone", 0.052999, 0.016999, 0.006999, 0.0, 91.1, 75.7, 1.0, 1.0, 1.0}
};

enum E_CLOTHING_DATA
{
	cl_sid,
	cl_object,
	Float:cl_x,
	Float:cl_y,
	Float:cl_z,
	Float:cl_rx,
	Float:cl_ry,
	Float:cl_rz,
	Float:cl_scalex,
	Float:cl_scaley,
	Float:cl_scalez,
	cl_bone,
	cl_slot,
	cl_equip,
	cl_name[32]
};

new ClothingData[MAX_PLAYERS][MAX_CLOTHES][E_CLOTHING_DATA];
new cl_selected[MAX_PLAYERS];
new cl_index[MAX_PLAYERS];
new cl_dataslot[MAX_PLAYERS][MAX_CLOTHES];
new cl_buying[MAX_PLAYERS];
new cl_buyingpslot[MAX_PLAYERS];
new cl_buyingindex[MAX_PLAYERS];
new cl_buyingpages[MAX_PLAYERS][10][2];

#define MAX_CLOTHING_PER_PAGE (25)

// Functions

ShowClothingDialog(playerid, page, index = 0)
{
	new count = 0, next_page = true;

	gstr[0] = EOS;

	switch(cl_buying[playerid])
	{
		case BUYSPORTS:
		{
			for(new i = index; i != sizeof(cl_SportsData); ++i)
			{
				if(count == MAX_CLOTHING_PER_PAGE)
				{
					next_page = true;
					break;
				}

				if(!count) cl_buyingpages[playerid][page][0] = i;

				format(gstr, sizeof(gstr), "%s%d\t%s\t{48E348}$%d{FFFFFF}\n", gstr, i, cl_SportsData[i][e_name], cl_SportsData[i][e_price]);
	
				count++;

				cl_buyingpages[playerid][page][1] = i;						
			}
		}
		case BUYZIP:
		{
			for(new i = index; i != sizeof(cl_ZipData); ++i)
			{
				if(count == MAX_CLOTHING_PER_PAGE)
				{
					next_page = true;
					break;
				}

				if(!count) cl_buyingpages[playerid][page][0] = i;

				format(gstr, sizeof(gstr), "%s%d\t%s\t{48E348}$%d{FFFFFF}\n", gstr, i, cl_ZipData[i][e_name], cl_ZipData[i][e_price]);
	
				count++;

				cl_buyingpages[playerid][page][1] = i;						
			}
		}
      	case BUYMUSIC:
		{
			for(new i = index; i != sizeof(cl_MusicData); ++i)
			{
				if(count == MAX_CLOTHING_PER_PAGE)
				{
					next_page = true;
					break;
				}

				if(!count) cl_buyingpages[playerid][page][0] = i;

				format(gstr, sizeof(gstr), "%s%d\t%s\t{48E348}$%d{FFFFFF}\n", gstr, i, cl_MusicData[i][e_name], cl_MusicData[i][e_price]);
	
				count++;

				cl_buyingpages[playerid][page][1] = i;				
			}
		}	
		default:
		{
			return true;
		}	
	}

	if(page) strcat(gstr, "\n{F2EB35}Last Page");
	if(next_page) strcat(gstr, "\n{F2EB35}Next Page");

	cl_buyingindex[playerid] = page;

	Dialog_Show(playerid, buyClothing, DIALOG_STYLE_TABLIST, "/buy ItemID", gstr, "Ok", "Cancel");
	return true;
}

Dialog:buyClothing(playerid, response, listitem, inputtext[])
{
	if(!response) return true;

	if(!strcmp(inputtext, "Next Page", false))
	{
		ShowClothingDialog(playerid, cl_buyingindex[playerid] + 1, cl_buyingpages[playerid][ cl_buyingindex[playerid] ][1] + 1);
		return true;
	}

	if(!strcmp(inputtext, "Last Page", false))
	{
		ShowClothingDialog(playerid, cl_buyingindex[playerid] - 1, cl_buyingpages[playerid][ cl_buyingindex[playerid] - 1 ][0]);
		return true;
	}	

	PurchaseClothing(playerid, strval(inputtext));
	return true;
}

PurchaseClothing(playerid, slot)
{
	if((cl_buyingpslot[playerid] = ClothingExistSlot(playerid)) == -1)
		return SendClientMessage(playerid, COLOR_LIGHTRED, "This item can not be purchased.");

	new model, bone, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, Float:sx, Float:sy, Float:sz;

	switch(cl_buying[playerid])
	{
	    case BUYSPORTS:
	    {
	        if(slot < 0 || slot >= sizeof(cl_SportsData)) return 0;

	        model = cl_SportsData[slot][e_model];
	        bone = cl_SportsData[slot][e_bone];
	        x = cl_SportsData[slot][e_x];
	        y = cl_SportsData[slot][e_y];
	        z = cl_SportsData[slot][e_z];
	        rx = cl_SportsData[slot][e_rx];
	        ry = cl_SportsData[slot][e_ry];
	        rz = cl_SportsData[slot][e_rz];
	        sx = cl_SportsData[slot][e_sx];
	        sy = cl_SportsData[slot][e_sy];
	        sz = cl_SportsData[slot][e_sz];
	    }
	    case BUYZIP:
	    {
	        if(slot < 0 || slot >= sizeof(cl_ZipData)) return 0;

	        model = cl_ZipData[slot][e_model];
	        bone = cl_ZipData[slot][e_bone];
	        x = cl_ZipData[slot][e_x];
	        y = cl_ZipData[slot][e_y];
	        z = cl_ZipData[slot][e_z];
	        rx = cl_ZipData[slot][e_rx];
	        ry = cl_ZipData[slot][e_ry];
	        rz = cl_ZipData[slot][e_rz];
	        sx = cl_ZipData[slot][e_sx];
	        sy = cl_ZipData[slot][e_sy];
	        sz = cl_ZipData[slot][e_sz];
	    }
    	case BUYMUSIC:
 		{
	        if(slot < 0 || slot >= sizeof(cl_MusicData)) return 0;

	        model = cl_MusicData[slot][e_model];
	        bone = cl_MusicData[slot][e_bone];
	        x = cl_MusicData[slot][e_x];
	        y = cl_MusicData[slot][e_y];
	        z = cl_MusicData[slot][e_z];
	        rx = cl_MusicData[slot][e_rx];
	        ry = cl_MusicData[slot][e_ry];
	        rz = cl_MusicData[slot][e_rz];
	        sx = cl_MusicData[slot][e_sx];
	        sy = cl_MusicData[slot][e_sy];
	        sz = cl_MusicData[slot][e_sz];
	    }
		default:
		{
			return true;
		}
	}

	SetPlayerAttachedObject(playerid, cl_buyingpslot[playerid], model, bone, x, y, z, rx, ry, rz, sx, sy, sz);
	EditAttachedObject(playerid, cl_buyingpslot[playerid]);

	BuyClothing{playerid} = true;

	SendClientMessage(playerid, COLOR_WHITE, "HINT: Use {FFFF00}SPACE{FFFFFF} to look around. Press {FFFF00}ESC{FFFFFF} to go back to the menu.");
	SendClientMessage(playerid, COLOR_WHITE, "Enjoy your new item!");

	ApplyAnimation(playerid, "CLOTHES", "CLO_Buy", 4.1, 0, 0, 0, 1, 0, 1);
	return true;
}

ClothingExistSlot(playerid)
{
	new checkQuery[128], rows, slot = -1;

	for(new i = 0; i != MAX_CLOTHES; ++i)
	{
		mysql_format(dbCon, checkQuery, sizeof(checkQuery), "SELECT `id` FROM `clothing` WHERE `owner` = '%d' AND `slot` = '%d'", PlayerData[playerid][pID], i);
		new Cache:cache = mysql_query(dbCon, checkQuery);

        rows = cache_num_rows();

        cache_delete(cache);

		if(!rows)
		{
		    slot = i;
		    break;
		}
	}

	return slot;
}

cl_DressPlayer(playerid)
{
	for(new id = 0; id < MAX_CLOTHES; ++id)
	{
	    if(ClothingData[playerid][id][cl_object] && ClothingData[playerid][id][cl_equip])
		{
			SetPlayerAttachedObject(playerid, ClothingData[playerid][id][cl_slot], ClothingData[playerid][id][cl_object], ClothingData[playerid][id][cl_bone], ClothingData[playerid][id][cl_x], ClothingData[playerid][id][cl_y],
			ClothingData[playerid][id][cl_z], ClothingData[playerid][id][cl_rx], ClothingData[playerid][id][cl_ry], ClothingData[playerid][id][cl_rz], ClothingData[playerid][id][cl_scalex], ClothingData[playerid][id][cl_scaley], ClothingData[playerid][id][cl_scalez]);
		}
	}
}

cl_ResetDressPlayer(playerid)
{
	for(new i = 0; i != MAX_PLAYER_ATTACHED_OBJECTS; ++i)
		RemovePlayerAttachedObject(playerid, i);

	for(new id = 0; id < MAX_CLOTHES; ++id)
	{
	    if(ClothingData[playerid][id][cl_object] && ClothingData[playerid][id][cl_equip])
		{
			ClothingData[playerid][id][cl_equip] = 0;
		}
	}
}

RemovePlayerClothing(playerid)
{
	for(new i = 0; i != MAX_PLAYER_ATTACHED_OBJECTS; ++i)
		RemovePlayerAttachedObject(playerid, i);
}

cl_ShowClothingMenu(playerid)
{
	new str[256], count;

	for(new i = 0; i < MAX_CLOTHES; ++i)
	{
	    if(ClothingData[playerid][i][cl_object])
	    {
		    cl_dataslot[playerid][count] = i;

			format(str, sizeof(str), "%s{FFFF00}%d.{FFFFFF} %s (Index: %d)\n", str, count + 1, ClothingData[playerid][i][cl_name], ClothingData[playerid][i][cl_slot] + 1);

			count++;
		}
	}

	if(!count) return SendNoticeMessage(playerid, "You don't have any clothing items.");

	Dialog_Show(playerid, ClothingList, DIALOG_STYLE_LIST, "Clothing List", str, "Select", "<< Exit");
	return true;
}

forward OnQueryBuyClothing(playerid, id);
public OnQueryBuyClothing(playerid, id)
{
	new insert_id = cache_insert_id();

	if(insert_id != -1) ClothingData[playerid][id][cl_sid] = insert_id;
	else ClothingData[playerid][id][cl_object] = 0;

	return true;
}

Dialog:ClothingList(playerid, response, listitem, inputtext[])
{
	if(!response) return true;

	new id;

	cl_selected[playerid] = listitem;
	id = cl_dataslot[playerid][listitem];

	return Dialog_Show(playerid, ClothingMenu, DIALOG_STYLE_LIST, "What are you going to do?", "{FFFFFF}Adjust Item\nChange Bone Slot\nChange Index Slot\n%s", "Select", "<<", (ClothingData[playerid][id][cl_equip]) ? ("{FFFFFF}Place{FFFF00} Off") : ("{FFFFFF}Place{FFFF00} On")); // Place On Take Off
}

Dialog:ClothingMenu(playerid, response, listitem, inputtext[])
{
	if(!response)
	{
		cl_ShowClothingMenu(playerid);
	}
	else
	{
		switch(listitem)
		{
		    case 0: // Adjust The Item
		    {
		        new id = cl_dataslot[playerid][cl_selected[playerid]];

			    SetPlayerAttachedObject(playerid, ClothingData[playerid][id][cl_slot], ClothingData[playerid][id][cl_object], ClothingData[playerid][id][cl_bone], ClothingData[playerid][id][cl_x], ClothingData[playerid][id][cl_y],
				ClothingData[playerid][id][cl_z], ClothingData[playerid][id][cl_rx], ClothingData[playerid][id][cl_ry], ClothingData[playerid][id][cl_rz], ClothingData[playerid][id][cl_scalex], ClothingData[playerid][id][cl_scaley], ClothingData[playerid][id][cl_scalez]);

				ApplyAnimation(playerid, "CLOTHES", "CLO_Buy", 4.1, 0, 0, 0, 1, 0, 1);
				EditAttachedObject(playerid, ClothingData[playerid][id][cl_slot]);

				EditClothing{playerid} = true;

				SendClientMessage(playerid, COLOR_WHITE, "HINT: Use {FFFF00}SPACE{FFFFFF} to look around. Press {FFFF00}ESC{FFFFFF}to go back to the menu.");
		    }
		    case 1: // Change Bone Slot
		    {
                Dialog_Show(playerid, ClothingBone, DIALOG_STYLE_LIST, "Change The Bone Slot", "spine\nhead\nUpper left arm\nRight arm\nleft hand\nright hand\nLeft leg\nRight thigh\nLeft foot\nRight foot\nRight calf\nLeft calf\nleft arm\nright arm\nLeft collarbone\nRight collarbone\nneck\njaw", "Select", "<<");
		    }
 		    case 2: // Change Index Slot
		    {
				if(PlayerData[playerid][pDonateRank] <= 1)
					Dialog_Show(playerid, ClothingIndex, DIALOG_STYLE_LIST, "Change The Index Slot", "Index Slot 1\nIndex Slot 2\nIndex Slot 3\nIndex Slot 4\nIndex Slot 5", "Select", "<<");

                if(PlayerData[playerid][pDonateRank] == 2)
					Dialog_Show(playerid, ClothingIndex, DIALOG_STYLE_LIST, "Change The Index Slot", "Index Slot 1\nIndex Slot 2\nIndex Slot 3\nIndex Slot 4\nIndex Slot 5\nIndex Slot 6", "Select", "<<");

                if(PlayerData[playerid][pDonateRank] == 3)
					Dialog_Show(playerid, ClothingIndex, DIALOG_STYLE_LIST, "Change The Index Slot", "Index Slot 1\nIndex Slot 2\nIndex Slot 3\nIndex Slot 4\nIndex Slot 5\nIndex Slot 6\nIndex Slot 7", "Select", "<<");
		    }
 		    case 3: // On-Off
		    {
		        new id = cl_dataslot[playerid][cl_selected[playerid]];

				if(ClothingData[playerid][id][cl_equip]) 
                {
					RemovePlayerAttachedObject(playerid, ClothingData[playerid][id][cl_slot]);
					ClothingData[playerid][id][cl_equip] = 0;
					SendClientMessageEx(playerid, COLOR_WHITE, "You took off your{FFFF00} %s", ClothingData[playerid][id][cl_name]);
				}
				else
				{
				    SetPlayerAttachedObject(playerid, ClothingData[playerid][id][cl_slot], ClothingData[playerid][id][cl_object], ClothingData[playerid][id][cl_bone], ClothingData[playerid][id][cl_x], ClothingData[playerid][id][cl_y],
					ClothingData[playerid][id][cl_z], ClothingData[playerid][id][cl_rx], ClothingData[playerid][id][cl_ry], ClothingData[playerid][id][cl_rz], ClothingData[playerid][id][cl_scalex], ClothingData[playerid][id][cl_scaley], ClothingData[playerid][id][cl_scalez]);
					SendClientMessageEx(playerid, COLOR_WHITE, "You put on your{FFFF00} %s", ClothingData[playerid][id][cl_name]);

					for(new i = 0; i < MAX_CLOTHES; ++i)
					{
					    if(ClothingData[playerid][i][cl_object] && ClothingData[playerid][i][cl_equip] && ClothingData[playerid][i][cl_slot] == ClothingData[playerid][id][cl_slot])
					    {
					        ClothingData[playerid][i][cl_equip] = 0;
						}
					}

					ClothingData[playerid][id][cl_equip] = 1;
				}

		    }
		}
	}
	return true;
}

Dialog:ClothingBone(playerid, response, listitem, inputtext[])
{
	if(!response) return cl_ShowClothingMenu(playerid);

	new id = cl_dataslot[playerid][cl_selected[playerid]];
	ClothingData[playerid][id][cl_bone] = listitem;
	SetPlayerAttachedObject(playerid, ClothingData[playerid][id][cl_slot], ClothingData[playerid][id][cl_object], ClothingData[playerid][id][cl_bone]);
	ApplyAnimation(playerid, "CLOTHES", "CLO_Buy", 4.1, 0, 0, 0, 1, 0, 1);
	EditAttachedObject(playerid, ClothingData[playerid][id][cl_slot]);

	EditClothing{playerid} = true;

	SendClientMessageEx(playerid, COLOR_WHITE, "You have changed the clothing item ({FFFF00}%s{FFFFFF}) bone to {FFFF00}%s{FFFFFF}.", ClothingData[playerid][id][cl_name], BoneName[listitem]);
    return true;
}

Dialog:ClothingIndex(playerid, response, listitem, inputtext[])
{
	if(!response) return cl_ShowClothingMenu(playerid);

	new id = cl_dataslot[playerid][cl_selected[playerid]];
	ClothingData[playerid][id][cl_slot] = listitem;

	RemovePlayerClothing(playerid);
	cl_DressPlayer(playerid);

	SendClientMessageEx(playerid, COLOR_WHITE, "You have changed the clothing item ({FFFF00}%s{FFFFFF}) index to {FFFF00}#%d{FFFFFF}.", ClothingData[playerid][id][cl_name], listitem + 1);
    return true;
}

stock CountPlayerClothing(playerid)
{
	new count;

	for(new id = 0; id < MAX_CLOTHES; ++id)
	{
		if(ClothingData[playerid][id][cl_object])
		{
			count++;
		}
	}
	return count;
}

stock AddPlayerClothing(playerid,modelid,Float:fOffsetX,Float:fOffsetY,Float:fOffsetZ,Float:fRotX,Float:fRotY,Float:fRotZ,boneid,index,Float:fScaleX,Float:fScaleY,Float:fScaleZ,const Name[], sid = -1)
{
	new num = CountPlayerClothing(playerid), bool:success, clothingid;

	switch(PlayerData[playerid][pDonateRank])
	{
		case 0: if(num >= 6) return -1;
		case 1: if(num >= 8) return -1;
		case 2: if(num >= 10) return -1;
		case 3: if(num >= 15) return -1;
	}

	for(new id = 0; id < MAX_CLOTHES; ++id)
	{
	    if(!ClothingData[playerid][id][cl_object])
	    {
			ClothingData[playerid][id][cl_sid] = sid;
			ClothingData[playerid][id][cl_object] = modelid;
			ClothingData[playerid][id][cl_x] = fOffsetX;
			ClothingData[playerid][id][cl_y] = fOffsetY;
			ClothingData[playerid][id][cl_z] = fOffsetZ;
			ClothingData[playerid][id][cl_rx] = fRotX;
			ClothingData[playerid][id][cl_ry] = fRotY;
			ClothingData[playerid][id][cl_rz] = fRotZ;
			ClothingData[playerid][id][cl_scalex] = fScaleX;
			ClothingData[playerid][id][cl_scaley] = fScaleY;
			ClothingData[playerid][id][cl_scalez] = fScaleZ;
	    	ClothingData[playerid][id][cl_bone] = boneid;
			ClothingData[playerid][id][cl_slot] = index;
			ClothingData[playerid][id][cl_equip] = 0;
			format(ClothingData[playerid][id][cl_name], 32, Name);

			clothingid = id;

	        success = true;
	        break;
	    }
	}

	if(success)
	{
	    return clothingid;
	}

	return -1;
}