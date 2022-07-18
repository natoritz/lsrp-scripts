#define LOCAL_GARAGE 400
#define LOCAL_BIZZ 500
#define LOCAL_HOUSE 600
#define LOCAL_APARTMENT 800

// Type Offer
#define OFFER_TYPE_NONE		0
#define OFFER_TYPE_VSELL	1
#define OFFER_TYPE_SERVICE	2
#define OFFER_TYPE_RENT	3

// Weapon Skill
#define NORMAL_SKILL	1
#define MEDIUM_SKILL	2
#define FULL_SKILL		3

#define MAX_SERVER_TIMERS 3
#define MAX_SERVER_HEALTH (200.0)
#define MAX_SCENES 50
#define MAX_COOLDOWNS 3
#define MAX_SIGNALTOWER 60
#define MAX_DROP_ITEMS 100
#define MAX_ADMIN_VEHICLES 20
#define MAX_SMS 30
#define MAX_CALLHISTORY 50
#define MAX_INTERIORS 100
#define MAX_MATERIAL 3
#define MAX_BUYHOUSES 4
#define MAX_INDUSTRY 31
#define MAX_TRUCKER_ITEMS 26
#define MAX_CRATE 60
#define MAX_AD_QUEUE 5
#define MAX_PLAYER_TICKETS 10
#define MAX_PLAYER_WEAPON_PACKAGE 12
#define MAX_CAR_WEAPON_PACKAGE 20
#define MAX_MOVEDOORS 100
#define MAX_GATES 100
#define MAX_ATTACH_WEAPON 17

#define COOLDOWN_CLOTHES  	0
#define COOLDOWN_ENGINE  	1

/* Checkpoint */
#define CHECKPOINT_NONE 			0
#define CHECKPOINT_HOUSE 			1
#define CHECKPOINT_UNLOADFISHING	7
#define CHECKPOINT_GOFISHING 		8
#define CHECKPOINT_FARMER 			9
#define CHECKPOINT_FARMER2 			10
#define CHECKPOINT_COMP 			11
#define CHECKPOINT_VEH 				12
#define CHECKPOINT_NEWSPAPER 		13
#define CHECKPOINT_CAREXAM          14
#define CHECKPOINT_APARTMENT        15

/* Race Checkpoint */
#define RCHECKPOINT_NONE 			0
#define RCHECKPOINT_TRUCKER 		1
#define RCHECKPOINT_TRUCKERJOB 		2

// Server values
#define levelcost 25000
#define levelexp 3
#define multiplyexp 1
#define deathcost 500
#define cchargetime 30
#define callcost 10

#define PH_LBUTTON		0
#define PH_RBUTTON		1
#define PH_SELFIE		2
#define PH_UP 			3
#define PH_DOWN     	4
#define PH_CLICKOPEN  	5

#define PH_OUTGOING 0
#define PH_INCOMING 1
#define PH_MISSED 	2

// Main configuration
#define TollCost (50) 					// How much it costs to pass the tolls
#define TollDelayCop (4) 				// The timespace in seconds between each /toll command for all cops (To avoid spam)
#define TollOpenDistance (4.0) 			// The distance in units the player can be from the icon to open the toll

// Tolls configuration
#define MAX_TOLLS (5) // Amount of tolls
#define INVALID_TOLL_ID (-1)
#define RichmanToll (0)
#define FlintToll (1)
#define LVToll (2)
#define BlueberryTollR (3)
#define BlueberryTollL (4)

// Job defines
#define JOB_NONE			0
#define JOB_FARMER			1
#define JOB_TRUCKER         2
#define JOB_MECHANIC        3
#define JOB_TAXI        	4
#define JOB_GUIDE        	5
#define JOB_WPDEALER		6
#define JOB_SUPPLIER  	    7
