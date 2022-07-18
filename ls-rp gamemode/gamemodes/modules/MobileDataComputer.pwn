stock CreatePenalCode()
{
    //0 - misdemeanour | 1 - felony | 2 - infraction

	//1. Crimes Against The Person (PC1-01 to PC1-13)
	AddPenalCodeRow(0, 0, "Intimidation", "A person who communicates that they will physically harm or kill another person�s close friends or relatives � in person, writing, or through media.", 0, 15);
	AddPenalCodeRow(0, 1, "Assault", "A person who intentionally puts another in the reasonable belief of imminent physical harm or offensive contact.", 0, 15);
	AddPenalCodeRow(0, 2, "Assault With A Deadly Weapon", "A person who attempts to cause or threaten immediate harm to another while using a weapon, tool, or other dangerous item to communicate that threat.", 1, 60);
	AddPenalCodeRow(0, 3, "Mutual Combat", "A person who engages in mutual combat with another individual in an area accessible to the public, or in public view, regardless of the consent of the individuals involved.", 0, 30);
	AddPenalCodeRow(0, 4, "Battery", "A person who uses intentional and unlawful force or violence to cause physical harm to another person.", 0, 45);
	AddPenalCodeRow(0, 5, "Aggravated Battery", "A person that uses a weapon, tool or other dangerous item to cause severe harm to a person(s).", 1, 60);
	AddPenalCodeRow(0, 6, "Attempted Murder", "A person who deliberately and intentionally attempts to kill or cause life threatening harm to another person through premeditated actions.", 1, 330);
	AddPenalCodeRow(0, 7, "Manslaughter", "A person who unintentionally kills another, with or without a quarrel or heat of passion.", 1, 240);
	AddPenalCodeRow(0, 8, "Murder", "A person who unlawfully kills another with malice aforethought", 1, 510);
	AddPenalCodeRow(0, 9, "False Imprisonment", "A person who detains or arrests another without their consent (or the consent of their guardian) without premeditated intent or ransom for less than one hour.", 1, 120);
	AddPenalCodeRow(0, 10, "Kidnapping", "A person who detains or arrests another without their consent (or the consent of their guardian) with the premeditated intent to do so.", 1, 270);
	AddPenalCodeRow(0, 11, "Mayhem", "A person who intentionally causes extreme pain and suffering to a person, with or without permanent damage to the body.", 1, 300);
	AddPenalCodeRow(0, 12, "Vehicular Murder", "A person who, while operating a motor vehicle in a severely reckless and deliberate manner, causes someones death.", 1, 510);

	//2. Crimes Against Property And Criminal Profiteering (PC2-01 to PC2-17)
	AddPenalCodeRow(1, 0, "Arson", "A person who intentionally and maliciously sets fire to or burns any structure, forest land, or property without prior authorization.", 1, 50);
	AddPenalCodeRow(1, 1, "Trespassing", "A person who enters another�s property while it is closed or not in operation without the expressed or written permission to do so.", 0, 10);
	AddPenalCodeRow(1, 2, "Trespassing within a Restricted Zone", "A person who, without proper authorization, enters any government owned or managed facility, or restricted section in a government building that is secured with the intent of keeping non-authorized personnel out due to a security or safety hazard.", 0, 30);
	AddPenalCodeRow(1, 3, "Burglary", "A person who enters into the locked or restricted property of another without their permission with the intention of committing a crime, typically theft.", 0, 25);
	AddPenalCodeRow(1, 4, "Possession Of Burglary Tools", "A person who has in their possession the appropriate combination of tools necessary to commit burglary, such as a tension bar, screwdriver, shimmy, or other appropriate items.", 2, 3000);
	AddPenalCodeRow(1, 5, "Robbery", "A person who takes property from the possession of another against their will, by means of force or fear, such as through intimidation, assault or battery.", 1, 120);
	AddPenalCodeRow(1, 6, "Armed Robbery", "A person who takes property from the possession of another against their will, by means of force facilitated with a weapon or with an item used as a weapon.", 1, 180);
	AddPenalCodeRow(1, 7, "Petty Theft", "A person who steals or takes the personal property of another worth $2,500 or less.", 0, 20);
	AddPenalCodeRow(1, 8, "Theft", "A person who steals or takes the personal property of another worth more than $2,500 but less than $10,000.", 0, 45);
	AddPenalCodeRow(1, 9, "Grand Theft", "A person who steals or takes the personal property of another worth $10,000 or more.", 1, 180);
	AddPenalCodeRow(1, 10, "Grand Theft Auto", "A person who commits the theft of any vehicle, no matter the value.", 1, 120);
	AddPenalCodeRow(1, 11, "Grand Theft Of A Firearm", "A person who commits theft of any firearm, no matter the value or whether it is registered.", 1, 180);
	AddPenalCodeRow(1, 12, "Receiving Stolen Property", "A person who knowingly buys or receives any property that has been stolen or that has been obtained in any manner constituting theft or extortion.", 0, 25);
	AddPenalCodeRow(1, 13, "Extortion", "A person who intimidates or influences another to provide or hand over properties or services.", 1, 180);
	AddPenalCodeRow(1, 14, "Forgery", "A person who knowingly alters, creates, or uses a written or electronic document with the intent to defraud or deceive another.", 0, 30);
	AddPenalCodeRow(1, 15, "Fraud", "A person who intentionally misrepresents a matter of fact - whether by words or by conduct, by false or misleading allegations, or by concealment of what should have been disclosed - that deceives and is intended to deceive another so that such other will act upon it to their disadvantage.", 1, 60);
	AddPenalCodeRow(1, 16, "Vandalism", "A person that defaces, damages, or destroys property which belongs to another.", 0, 10);

	//3. Crimes Against Public Decency (PC3-01 to PC3-10)
	AddPenalCodeRow(2, 0, "Lewd Or Dissolute Conduct In Public", "A person who solicits anyone to engage in inappropriate sexual or sexually suggestive conduct in any public place or in any place open to the public or exposed to public view.", 0, 10);
	AddPenalCodeRow(2, 1, "Indecent Exposure", "A person who intentionally exposes their naked body or genitalia on public property or in the public area of a privately owned business.", 0, 20);
	AddPenalCodeRow(2, 2, "Prostitution", "A person who knowingly engages in a sexual act in return for payment, goods, services or other items of value.", 1, 60);
	AddPenalCodeRow(2, 3, "Solicitation of Prostitution", "A person who offers payment, goods, services or other items of value to an individual in exchange for sexual acts.", 1, 60);
	AddPenalCodeRow(2, 4, "Pandering / Pimping", "A person who solicits or advertises, aids or provides transport or supervises persons involved in prostitution and retains some or all of the money earned.", 1, 90);
	AddPenalCodeRow(2, 5, "Sexual Assault", "A person who commits verbal abuse for the purpose of sexual arousal, gratification, or abuse.", 0, 25);
	AddPenalCodeRow(2, 6, "Sexual Battery", "A person who commits unwanted touching or sexual contact.", 1, 270);
	AddPenalCodeRow(2, 7, "Rape", "A person who forces another to engage in sexual intercourse.", 1, 360);
	AddPenalCodeRow(2, 8, "Statutory Rape", "A person who engages in mutually-interested sexual intercourse with another who is under the age of 18 and therefore cannot give legal consent.", 1, 300);
	AddPenalCodeRow(2, 9, "Stalking", "A person who intentionally and maliciously follows or harasses another person who has made it known that they do not consent to such following or harassment.", 1, 150);

	//4. Crimes Against Public Justice (PC4-01 to PC4-24)
    AddPenalCodeRow(3, 0, "Bribery", "A person who offers or gives a monetary gift, gratuity, valuable goods, or other reward to a public official, government employee, or peace officer in an attempt to influence their duties or actions.", 1, 180);
    AddPenalCodeRow(3, 1, "Failure To Pay A Fine", "A person who fails to pay a fine or court ordered fee within clearly stated and allotted time period.", 0, 15);
    AddPenalCodeRow(3, 2, "Contempt of Court", "A person who willfully disobeys the verbal or written order of a court authority, disrespects the decorum of the court, or otherwise infringes upon due process.", 0, 15);
    AddPenalCodeRow(3, 3, "Subpoena Violation", "A person who ignores or violates a subpoena order issued by the Courts.", 0, 30);
    AddPenalCodeRow(3, 4, "Dissuading A Witness Or Victim", "A person who knowingly and maliciously prevents or encourages any witness or victim from attending or giving testimony at any trial, proceeding, or inquiry authorized by law with the use of bribery, fear, or other tactics.", 1, 210);
    
	//5. Crimes Against Public Peace (PC5-01 to PC5-05)
	AddPenalCodeRow(4, 0, "Disturbing The Peace", "A person who creates a dangerous or intimidating situation in a public place or in the public area of private property.", 0, 15);
	AddPenalCodeRow(4, 1, "Unlawful Assembly", "A person who refuses to leave public property after being ordered to do so by its state agency property manager or a peace officer.", 0, 20);
	AddPenalCodeRow(4, 2, "Incitement To Riot", "A person whose actions deliberately agitates or intends to agitate a crowd or large group of people organized or located peacefully in a public or private area in order to promote acts of violence or civil unrest.", 1, 120);
	AddPenalCodeRow(4, 3, "Vigilantism", "A person who attempts to effect justice according to their own understanding of right and wrong, or an unauthorized person attempts to enforce the law. A citizen's arrest may only be effected when a civilian, out of fear for their own safety or the safety of their close friends or relatives, subdues or detains another who is violating the law.", 1, 90);
	AddPenalCodeRow(4, 4, "Terrorism", "A person who, uses systematic threats or actions against the public good to cause fear and intimidation at a grand scale.", 1, 900);

	//6. Crimes Against Public Health And Safety (PC6-01 to PC6-11)
    AddPenalCodeRow(5, 0, "Possession Of A Controlled Substance", "A person who possesses any controlled substance, except when the substance has been lawfully prescribed to them by a licensed practitioner of medicine or is legally available without a prescription.", 0, 15);
    AddPenalCodeRow(5, 1, "Possession Of A Controlled Substance With Intent To Sell", "A person in possession of a controlled substance or multiple controlled substances in an amount of over one ounce (28 grams)", 1, 30); //900
    AddPenalCodeRow(5, 2, "Possession Of Drug Paraphernalia", "A person who willingly possesses a device or mechanism used exclusively for the processing or consumption of an illegal controlled substance.", 2, 1500);
    AddPenalCodeRow(5, 3, "Maintaining A Place For The Purpose Of Distribution", "A person who opens or maintains any property for the purpose of unlawfully selling, giving away, storing, or using any controlled substance, firearm, or other illicit device, good, or service.", 0, 45);
    AddPenalCodeRow(5, 4, "Manufacture Of A Controlled Substance", "A person who, except as otherwise provided by law, manufactures, compounds, converts, produces, or prepares, either directly or indirectly by chemical or natural extraction, any illegal substance.", 1, 120);
    AddPenalCodeRow(5, 5, "Sale Of A Controlled Substance", "A person who sells, or offers to sell, a controlled substance to another person, regardless of whether or not they possess that controlled substance.", 1, 90);
    AddPenalCodeRow(5, 6, "Possession Of An Open Container", "A person who possesses an visible and open container of alcohol in a public place or in a motor vehicle.", 2, 1000);
    AddPenalCodeRow(5, 7, "Public Intoxication", "A person who is found in any public place under the influence of intoxicating liquor.", 0, 10);
    AddPenalCodeRow(5, 8, "Under The Influence Of A Controlled Substance", "A person who uses or is under the influence of a controlled substance or dangerous substance without the proper permits or prescription to use such a substance.", 0, 25);
    AddPenalCodeRow(5, 9, "Facial Obstruction While Committing A Crime", "A person who wears any mask, hood, or facial obstruction to conceal their identity in any public place that refuses to remove the obstruction upon order of a peace officer. This does not apply to individuals wearing traditional holiday costumes, or individuals wearing protective facial equipment for professional trades or employment.", 0, 10);
    
	//7. Crimes Against State Dependents (PC7-01 to PC7-05)
	AddPenalCodeRow(6, 0, "Animal Abuse / Cruelty", "A person who intentionally maims, mutilates, tortures, wounds, or kills a living animal.", 1, 80);
	AddPenalCodeRow(6, 1, "Child Abuse", "A person who willfully inflicts any cruel, excessive, or inhuman corporal punishment upon a child under 18 years of age.", 1, 360);
	AddPenalCodeRow(6, 2, "Sale of Alcohol To A Minor", "A person who willfully and knowingly sells alcohol to a minor under the age of 21.", 0, 25);
	AddPenalCodeRow(6, 3, "Minor Alcohol Violation", "A minor under the age of 21 who is in possession of alcohol for consumption, products for consumption containing alcohol, or appears to be under the influence of alcohol.", 2, 1500);

	//8. Vehicular Offenses (PC8-01 to PC8-13)
	AddPenalCodeRow(7, 0, "Driving With A Suspended License", "A person who drives a vehicle, whether on land, sea, or in air, while having a suspended license or authorization.", 0, 25);
	AddPenalCodeRow(7, 1, "Evading A Peace Officer", "A person who, while operating a vehicle on land, sea, or in air, or while operating a bicycle, willfully flees or otherwise attempts to elude or avoid a pursuing peace officer who communicates visually or audibly their request to pull over or stop.", 1, 120);
	AddPenalCodeRow(7, 2, "Flying Without A Pilot's License", "A person operating an aircraft without a proper license or authorization.", 0, 35);
	AddPenalCodeRow(7, 3, "Hit And Run", "A person who hits another person or occupied vehicle and leaves the scene of the accident.", 1, 180);
	AddPenalCodeRow(7, 4, "Reckless Operation Of An Aircraft", "A person who demonstrates careless or general disregard for the safety of themselves or others while operating an aircraft.", 0, 50);
	AddPenalCodeRow(7, 5, "Reckless Operation Of An Off-Road Or Naval Vehicle", "A person who demonstrates careless or general disregard for the safety of themselves or others while operating a naval vehicle or vehicle intended for off-road travel.", 0, 45);
	AddPenalCodeRow(7, 6, "Failure To Adhere To ATC Protocols", "A person who failures to respond to identification requests from nearby aircraft or Air Traffic Control.", 1, 180);
	AddPenalCodeRow(7, 7, "Failure To Adhere To Flight Protocols", "A person who failures to follow the flight protocols as detailed in Section 3. of the State Aviation Act Of 2015.", 1, 45);
	AddPenalCodeRow(7, 8, "Aerial Evasion", "A person who, while operating an aircraft, willfully flees or otherwise attempts to elude pursuing law enforcement who is broadcasting their request to land or halt.", 1, 180);
	AddPenalCodeRow(7, 9, "Restricted Airspace Violation", "A person who enters the restricted airspace as detailed in Section 4 of the State Aviation Act Of 2015 and refuses to leave such airspace after being ordered to leave such airspace.", 1, 180);

	//9. Control Of Deadly Weapons And Equipment (PC9-01 to PC9-13)
	AddPenalCodeRow(8, 0, "Possession Of An Illegal Blade", "A civilian who possesses a blade or improvised blade over three inches in length that can be used as a cutting, slashing or stabbing weapon, whether or not concealed.", 0, 25);
	AddPenalCodeRow(8, 1, "Possession Of An Unlicensed Firearm", "A civilian who carries a legal, but unlicensed weapon on their person, in their vehicle, place of business, or other facility without proper permits.", 0, 40);
	AddPenalCodeRow(8, 2, "Possession Of An Illegal Firearm", "A civilian who possesses any firearm that is illegal in possession or not considered part of any legal weapon type.", 1, 180);
	AddPenalCodeRow(8, 3, "Possession Of An Assault Weapon", "A civilian who possesses an illegal firearm which uses high-velocity, high-caliber, or specialized ammunition including, but not limited to, FMJ ammunition or HEIAP bullets.", 1, 240);
	AddPenalCodeRow(8, 4, "Unlicensed Sale Of A Firearm", "A person who illegally sells a firearm or improvised weapon of any type without proper permits or authorization.", 1, 330);
	AddPenalCodeRow(8, 5, "Possession Of An Explosive Device", "A civilian who possesses any manufactured or improvised device or equipment which is made from explosive and/or highly flammable liquid, gas or solid materials.", 1, 360);
	AddPenalCodeRow(8, 6, "Manufacture or Possession of an Improvised Device", "Except as otherwise provided by law, A civilian who manufactures, assembles, disassembles, or possesses parts of any dangerous weapon, explosive, trap, firearm, or other destructive device that does not apply or is appropriate to any other penal code entries.", 1, 240);
	AddPenalCodeRow(8, 7, "Possession of Weaponry With Intent To Sell", "A person who is in possession of more than 5 full weapons or weapon components in any combination or amount with the intent to distribute, deliver, or sell.", 1, 360);
	AddPenalCodeRow(8, 8, "Possession Of Explosive Devices With Intent To Sell", "A person who is in possession of more than 3 explosive devices or explosive device materials in any combination with the intent to distribute, deliver, or sell.", 1, 420);
	AddPenalCodeRow(8, 9, "Brandishing A Firearm", "A person who is pointing, holding, openly carrying or brandishing a firearm, air or gas operated weapon, or object that appears like a firearm without proper toy and prop identification in an attempt to elicit fear or hysteria.", 0, 30);
	AddPenalCodeRow(8, 10, "Weapons Discharge Violation", "A person who fires a firearm without due cause or justifiable motive regardless of registration status or legality.", 0, 35);
	AddPenalCodeRow(8, 11, "Drive-By Shooting", "A person who drives a vehicle, whether on land, sea, or in air, and has a passenger who they knowingly and willingly let discharge a firearm from within the vehicle, and the passenger is not an on-duty peace officer.", 1, 300);
	AddPenalCodeRow(8, 12, "CCW / PF Violation", "A person who carries concealed a legal, registered firearm that is not authorized as a conceal-carry weapon.", 0, 40);
}

//mdc data
stock AddPenalCodeRow(tile, row, const name[], const description[], ctype, jtime)
{
    format(penal_code[tile][row][crime_name], 60, name);
    format(penal_code[tile][row][crime_description], 180, description);
    penal_code[tile][row][crime_type] = ctype;
    penal_code[tile][row][jail_time] = jtime;
}

stock InitMDC(playerid)
{
	if(MDC_Created{playerid}) return true;

	MDC_UI[playerid][0] = CreatePlayerTextDraw(playerid, 471.000030, 161.600000, "usebox"); //161.618576
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][0], 0.000000, 30.755756);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][0], 168.333328, 0.000000);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][0], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][0], 0);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][0], true);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][0], -572662273);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][0], 0);
	PlayerTextDrawFont(playerid, MDC_UI[playerid][0], 0);

	MDC_UI[playerid][1] = CreatePlayerTextDraw(playerid, 170.666702, 161.000000, "LD_SPAC:white"); //160.947937
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][1], 0.000000, 1.144950);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][1], 298.000030, 10.785170);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][1], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][1], 186668031); //155656447
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][1], 255);
	PlayerTextDrawFont(playerid, MDC_UI[playerid][1], 4);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][1], 0);

	MDC_UI[playerid][2] = CreatePlayerTextDraw(playerid, 455.333404, 160.948135, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][2], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][2], 12.666644, 10.785187);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][2], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][2], -1204935681);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][2], 0);
	PlayerTextDrawFont(playerid, MDC_UI[playerid][2], 4);

	MDC_UI[playerid][3] = CreatePlayerTextDraw(playerid, 442.000030, 160.948181, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][3], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][3], 12.999979, 10.785179);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][3], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][3], 493146623);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][3], 0);
	PlayerTextDrawFont(playerid, MDC_UI[playerid][3], 4);

	MDC_UI[playerid][4] = CreatePlayerTextDraw(playerid, 446.999969, 162.607452, "-");
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][4], 0.213000, 0.791111);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][4], 450.000000, 6.000000);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][4], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][4], -1);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][4], 255);
	PlayerTextDrawFont(playerid, MDC_UI[playerid][4], 1);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][4], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][4], true);

	MDC_UI[playerid][5] = CreatePlayerTextDraw(playerid, 459.000000, 162.607452, "X");
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][5], 0.221333, 0.824296);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][5], 463.000000, 6.000000);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][5], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][5], -1);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][5], 255);
	PlayerTextDrawFont(playerid, MDC_UI[playerid][5], 1);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][5], 1);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][5], 0);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][5], true);

	MDC_UI[playerid][6] = CreatePlayerTextDraw(playerid, 172.666671, 162.607391, "hud:radar_emmetGun");
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][6], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][6], 8.000002, 7.881485);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][6], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][6], -1);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][6], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][6], 255);
	PlayerTextDrawFont(playerid, MDC_UI[playerid][6], 4);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][6], 0);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][6], 0);

	MDC_UI[playerid][7] = CreatePlayerTextDraw(playerid, 182.666656, 161.777832, "Los_Santos_Police_Department");
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][7], 0.199666, 0.861627);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][7], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][7], 0xC1C4CAFF); //203444479 -1044067585 -1161504513
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][7], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][7], 255);
	PlayerTextDrawFont(playerid, MDC_UI[playerid][7], 1);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][7], 1);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][7], 0);

	MDC_UI[playerid][8] = CreatePlayerTextDraw(playerid, 439.333190, 161.777801, "Offset_Test");
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][8], 0.199333, 0.882370);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][8], 3);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][8], -1785159937); //-1852136705
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][8], 0);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][8], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][8], 255);
	PlayerTextDrawFont(playerid, MDC_UI[playerid][8], 1);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][8], 1);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][8], 0);

	MDC_UI[playerid][9] = CreatePlayerTextDraw(playerid, 225.666671, 172.563003, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][9], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][9], 1.000026, 265.066986);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][9], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][9], -1431655681);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][9], 0);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][9], 0);
	PlayerTextDrawFont(playerid, MDC_UI[playerid][9], 4);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][9], 0);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][9], 0);

	MDC_UI[playerid][10] = CreatePlayerTextDraw(playerid, 221.666687, 164.955551, "");
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][10], 251.000000, 250.000000);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][10], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][10], -1);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][10], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][10], -256);
	PlayerTextDrawFont(playerid, MDC_UI[playerid][10], 5);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][10], 0);
	PlayerTextDrawSetPreviewModel(playerid, MDC_UI[playerid][10], 286);
	PlayerTextDrawSetPreviewRot(playerid, MDC_UI[playerid][10], 0.000000, 0.000000, 0.000000, 1.000000);

	MDC_UI[playerid][11] = CreatePlayerTextDraw(playerid, 302.000000, 252.622222, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][11], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][11], 103.000000, 167.170379);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][11], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][11], -572662273);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][11], 0);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][11], 0);
	PlayerTextDrawFont(playerid, MDC_UI[playerid][11], 4);

	MDC_UI[playerid][12] = CreatePlayerTextDraw(playerid, 230.666732, 248.474090, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][12], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][12], 233.999969, 11.614810);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][12], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][12], -842281473);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][12], 0);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][12], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][12], 255);
	PlayerTextDrawFont(playerid, MDC_UI[playerid][12], 4);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][12], 1);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][12], 0);

	MDC_UI[playerid][13] = CreatePlayerTextDraw(playerid, 347.666717, 249.718521, "Chief_Of_Police_Offset_Test");
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][13], 0.250333, 1.002667);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][13], 2);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][13], 791291903);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][13], 0);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][13], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][13], 255);
	PlayerTextDrawFont(playerid, MDC_UI[playerid][13], 1);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][13], 1);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][13], 0);

	MDC_UI[playerid][14] = CreatePlayerTextDraw(playerid, 231.666702, 264.651824, "Members_On_Duty~n~Active_Warrants");
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][14], 0.179333, 0.903111);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][14], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][14], 353637375);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][14], 0);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][14], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][14], 255);
	PlayerTextDrawFont(playerid, MDC_UI[playerid][14], 2);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][14], 1);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][14], 0);

	MDC_UI[playerid][15] = CreatePlayerTextDraw(playerid, 324.333160, 264.651824, "0~n~TBA");
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][15], 0.188666, 0.903110);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][15], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][15], -1920233985);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][15], 0);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][15], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][15], 255);
	PlayerTextDrawFont(playerid, MDC_UI[playerid][15], 2);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][15], 1);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][15], 0);

	MDC_UI[playerid][16] = CreatePlayerTextDraw(playerid, 347.333312, 264.651763, "Calls_Last_Hour~n~Arrests_Last_Hour~n~Fines_Last_Hour");
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][16], 0.180333, 0.903111);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][16], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][16], 353637375);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][16], 0);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][16], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][16], 255);
	PlayerTextDrawFont(playerid, MDC_UI[playerid][16], 2);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][16], 1);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][16], 0);

	MDC_UI[playerid][17] = CreatePlayerTextDraw(playerid, 440.333312, 264.651947, "0~n~0~n~0");
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][17], 0.196000, 0.903111);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][17], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][17], -1920233985);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][17], 0);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][17], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][17], 255);
	PlayerTextDrawFont(playerid, MDC_UI[playerid][17], 2);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][17], 1);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][17], 0);

	//start of look-up page textdraws
	MDC_UI[playerid][18] = CreatePlayerTextDraw(playerid, 300.999816, 177.955535, "");
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][18], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][18], 125.000022, 10.785196);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][18], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][18], -255);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][18], 0);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][18], 0);
	PlayerTextDrawFont(playerid, MDC_UI[playerid][18], 4);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][18], true);

	MDC_UI[playerid][19] = CreatePlayerTextDraw(playerid, 247.666748, 179.614868, "NAME");
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][19], 0.148662, 0.824293);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][19], 6.000000, 30.281473);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][19], 2);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][19], 858993663);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][19], true);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][19], -1431655681);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][19], 0);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][19], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][19], 51);
	PlayerTextDrawFont(playerid, MDC_UI[playerid][19], 2);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][19], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][19], true);

	MDC_UI[playerid][20] = CreatePlayerTextDraw(playerid, 282.666717, 179.614868, "PLATE");
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][20], 0.148662, 0.824293);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][20], 6.000000, 30.281473);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][20], 2);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][20], 858993663);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][20], true);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][20], -1431655681);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][20], 0);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][20], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][20], 51);
	PlayerTextDrawFont(playerid, MDC_UI[playerid][20], 2);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][20], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][20], true);

	MDC_UI[playerid][21] = CreatePlayerTextDraw(playerid, 302.333251, 179.614868, "_");
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][21], 0.200999, 0.824293);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][21], 424.666839, 53.511100);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][21], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][21], 825307647);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][21], true);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][21], -1);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][21], 0);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][21], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][21], 51);
	PlayerTextDrawFont(playerid, MDC_UI[playerid][21], 1);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][21], 1);

	MDC_UI[playerid][22] = CreatePlayerTextDraw(playerid, 444.666717, 179.614868, "REFRESH");
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][22], 0.148662, 0.824293);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][22], 6.000000, 30.281473);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][22], 2);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][22], 858993663);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][22], true);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][22], -1431655681);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][22], 0);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][22], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][22], 51);
	PlayerTextDrawFont(playerid, MDC_UI[playerid][22], 2);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][22], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][22], true);

	MDC_UI[playerid][23] = CreatePlayerTextDraw(playerid, 158.000427, 173.666656, "");
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][23], 213.000000, 213.000000);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][23], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][23], -1);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][23], 0);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][23], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][23], -256);
	PlayerTextDrawFont(playerid, MDC_UI[playerid][23], 5);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][23], 0);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][23], 0);
	PlayerTextDrawSetPreviewModel(playerid, MDC_UI[playerid][23], 304);
	PlayerTextDrawSetPreviewRot(playerid, MDC_UI[playerid][23], 0.000000, 0.000000, 30.000000, 1.000000);

	MDC_UI[playerid][24] = CreatePlayerTextDraw(playerid, 230.999984, 249.577819, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][24], 91.000000, 153.000000);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][24], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][24], -572662273);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][24], 1);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][24], 0);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][24], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][24], 255);
	PlayerTextDrawFont(playerid, MDC_UI[playerid][24], 4);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][24], 1);

	MDC_UI[playerid][25] = CreatePlayerTextDraw(playerid, 291.333251, 194.548171, "Name:~n~Number:~n~Priors:~n~Licenses:~n~Address:");
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][25], 0.152000, 0.803554);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][25], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][25], 858993663);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][25], 0);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][25], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][25], 255);
	PlayerTextDrawFont(playerid, MDC_UI[playerid][25], 2);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][25], 1);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][25], 0);

	MDC_UI[playerid][26] = CreatePlayerTextDraw(playerid, 324.333343, 194.548156, "_");
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][26], 0.170666, 0.807703);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][26], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][26], -1819044865);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][26], 0);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][26], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][26], 255);
	PlayerTextDrawFont(playerid, MDC_UI[playerid][26], 1);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][26], 1);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][26], 0);

	MDC_UI[playerid][27] = CreatePlayerTextDraw(playerid, 324.666625, 223.585266, "_");
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][27], 0.169999, 0.803555);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][27], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][27], -1819044865);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][27], 0);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][27], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][27], 255);
	PlayerTextDrawFont(playerid, MDC_UI[playerid][27], 1);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][27], 1);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][27], 0);
	//PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][27], true);

	MDC_UI[playerid][28] = CreatePlayerTextDraw(playerid, 232.333343, 252.622192, "~>~_Manage_Licenses");
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][28], 0.150333, 0.828444);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][28], 340.666687, 6.000000);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][28], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][28], 858993663);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][28], true);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][28], -1431655681);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][28], 0);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][28], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][28], 51);
	PlayerTextDrawFont(playerid, MDC_UI[playerid][28], 2);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][28], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][28], true);

	MDC_UI[playerid][29] = CreatePlayerTextDraw(playerid, 232.333297, 264.651702, "~>~_Apply_Charges");
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][29], 0.150333, 0.828444);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][29], 340.666656, 6.000000);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][29], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][29], 858993663);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][29], true);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][29], -1431655681);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][29], 0);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][29], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][29], 51);
	PlayerTextDrawFont(playerid, MDC_UI[playerid][29], 2);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][29], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][29], true);

	MDC_UI[playerid][30] = CreatePlayerTextDraw(playerid, 232.333328, 276.681212, "~>~_Write_Arrest_Record");
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][30], 0.150333, 0.828444);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][30], 340.666687, 6.000000);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][30], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][30], 858993663);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][30], true);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][30], -1431655681);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][30], 0);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][30], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][30], 51);
	PlayerTextDrawFont(playerid, MDC_UI[playerid][30], 2);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][30], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][30], true);

	MDC_UI[playerid][31] = CreatePlayerTextDraw(playerid, 403.666656, 252.622192, "~y~]~w~_CRIMINAL_RECORD_~y~]~w~");
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][31], 0.149666, 0.824295);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][31], -125.666641, 117.807472);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][31], 2);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][31], -1431655681);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][31], true);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][31], 858993663);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][31], 0);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][31], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][31], 51);
	PlayerTextDrawFont(playerid, MDC_UI[playerid][31], 2);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][31], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][31], true);

	MDC_UI[playerid][32] = CreatePlayerTextDraw(playerid, 344.666656, 264.651702, "There_are_no_outstanding_charges");
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][32], 0.169666, 0.807703);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][32], 462.666778, 32.355564);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][32], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][32], 1246382847);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][32], true);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][32], -256);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][32], 0);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][32], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][32], 51);
	PlayerTextDrawFont(playerid, MDC_UI[playerid][32], 1);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][32], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][32], true);

	MDC_UI[playerid][33] = CreatePlayerTextDraw(playerid, 232.333343, 252.622192, "test1");
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][33], 0.150333, 0.828444);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][33], 462.666656, 6.000000);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][33], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][33], 858993663);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][33], true);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][33], -1431655681);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][33], 0);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][33], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][33], 51);
	PlayerTextDrawFont(playerid, MDC_UI[playerid][33], 2);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][33], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][33], true);

	MDC_UI[playerid][34] = CreatePlayerTextDraw(playerid, 232.333343, 264.651702, "test1");
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][34], 0.150333, 0.828444);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][34], 462.666656, 6.000000);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][34], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][34], 858993663);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][34], true);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][34], -1431655681);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][34], 0);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][34], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][34], 51);
	PlayerTextDrawFont(playerid, MDC_UI[playerid][34], 2);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][34], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][34], true);

	MDC_UI[playerid][35] = CreatePlayerTextDraw(playerid, 232.333343, 276.681212, "test1");
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][35], 0.150333, 0.828444);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][35], 462.666656, 6.000000);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][35], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][35], 858993663);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][35], true);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][35], -1431655681);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][35], 0);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][35], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][35], 51);
	PlayerTextDrawFont(playerid, MDC_UI[playerid][35], 2);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][35], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][35], true);

	MDC_UI[playerid][36] = CreatePlayerTextDraw(playerid, 231.333343, 190.400115, "LD_SPAC:white"); // 38
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][36], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][36], 56.333351, 58.074043);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][36], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][36], 858993663);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][36], 0);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][36], 0);
	PlayerTextDrawFont(playerid, MDC_UI[playerid][36], 4);

	MDC_UI[playerid][37] = CreatePlayerTextDraw(playerid, 259.333190, 192.474044, "picture~n~not~n~available");
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][37], 0.354333, 1.989926);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][37], 2);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][37], -488447233);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][37], 0);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][37], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][37], 255);
	PlayerTextDrawFont(playerid, MDC_UI[playerid][37], 1);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][37], 1);

	MDC_UI[playerid][38] = CreatePlayerTextDraw(playerid, 229.666687, 174.637069, "~<~_Back_to_Firstname_Lastname"); // 40
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][38], 0.149333, 0.807703);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][38], 465.000000, 6.000000);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][38], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][38], -1431655681);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][38], true);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][38], -256);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][38], 0);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][38], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][38], 51);
	PlayerTextDrawFont(playerid, MDC_UI[playerid][38], 2);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][38], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][38], true);
	
	//menu
	new Float:cached_y = 174.637039; //174.222229

	MDC_MenuUI[playerid][0] = CreatePlayerTextDraw(playerid, 197.766717, cached_y, "Main_Screen");
	PlayerTextDrawLetterSize(playerid, MDC_MenuUI[playerid][0], 0.148999, 0.845035);
	PlayerTextDrawTextSize(playerid, MDC_MenuUI[playerid][0], 6.000000, 50.000000); //49.777770
	PlayerTextDrawAlignment(playerid, MDC_MenuUI[playerid][0], 2);
	PlayerTextDrawColor(playerid, MDC_MenuUI[playerid][0], 858993663);
	PlayerTextDrawUseBox(playerid, MDC_MenuUI[playerid][0], true);
	PlayerTextDrawBoxColor(playerid, MDC_MenuUI[playerid][0], -1431655681);
	PlayerTextDrawSetShadow(playerid, MDC_MenuUI[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, MDC_MenuUI[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_MenuUI[playerid][0], 51);
	PlayerTextDrawFont(playerid, MDC_MenuUI[playerid][0], 2);
	PlayerTextDrawSetProportional(playerid, MDC_MenuUI[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_MenuUI[playerid][0], true);

	//12.029602

	cached_y += 12.200000;

	MDC_MenuUI[playerid][1] = CreatePlayerTextDraw(playerid, 197.766717, cached_y, "Look_Up");
	PlayerTextDrawLetterSize(playerid, MDC_MenuUI[playerid][1], 0.148999, 0.845035);
	PlayerTextDrawTextSize(playerid, MDC_MenuUI[playerid][1], 6.000000, 50.000000);
	PlayerTextDrawAlignment(playerid, MDC_MenuUI[playerid][1], 2);
	PlayerTextDrawColor(playerid, MDC_MenuUI[playerid][1], 858993663);
	PlayerTextDrawUseBox(playerid, MDC_MenuUI[playerid][1], true);
	PlayerTextDrawBoxColor(playerid, MDC_MenuUI[playerid][1], -1431655681);
	PlayerTextDrawSetShadow(playerid, MDC_MenuUI[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, MDC_MenuUI[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_MenuUI[playerid][1], 51);
	PlayerTextDrawFont(playerid, MDC_MenuUI[playerid][1], 2);
	PlayerTextDrawSetProportional(playerid, MDC_MenuUI[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_MenuUI[playerid][1], true);

	cached_y += 12.200000;

	MDC_MenuUI[playerid][2] = CreatePlayerTextDraw(playerid, 197.766717, cached_y, "Emergency");
	PlayerTextDrawLetterSize(playerid, MDC_MenuUI[playerid][2], 0.148999, 0.845035);
	PlayerTextDrawTextSize(playerid, MDC_MenuUI[playerid][2], 6.000000, 50.000000);
	PlayerTextDrawAlignment(playerid, MDC_MenuUI[playerid][2], 2);
	PlayerTextDrawColor(playerid, MDC_MenuUI[playerid][2], 858993663);
	PlayerTextDrawUseBox(playerid, MDC_MenuUI[playerid][2], true);
	PlayerTextDrawBoxColor(playerid, MDC_MenuUI[playerid][2], -1431655681);
	PlayerTextDrawSetShadow(playerid, MDC_MenuUI[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, MDC_MenuUI[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_MenuUI[playerid][2], 51);
	PlayerTextDrawFont(playerid, MDC_MenuUI[playerid][2], 2);
	PlayerTextDrawSetProportional(playerid, MDC_MenuUI[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_MenuUI[playerid][2], true);

	cached_y += 24.400000;

	MDC_MenuUI[playerid][3] = CreatePlayerTextDraw(playerid, 197.766717, cached_y, "Roster");
	PlayerTextDrawLetterSize(playerid, MDC_MenuUI[playerid][3], 0.148999, 0.845035);
	PlayerTextDrawTextSize(playerid, MDC_MenuUI[playerid][3], 6.000000, 50.000000);
	PlayerTextDrawAlignment(playerid, MDC_MenuUI[playerid][3], 2);
	PlayerTextDrawColor(playerid, MDC_MenuUI[playerid][3], 858993663);
	PlayerTextDrawUseBox(playerid, MDC_MenuUI[playerid][3], true);
	PlayerTextDrawBoxColor(playerid, MDC_MenuUI[playerid][3], -1431655681);
	PlayerTextDrawSetShadow(playerid, MDC_MenuUI[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, MDC_MenuUI[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_MenuUI[playerid][3], 51);
	PlayerTextDrawFont(playerid, MDC_MenuUI[playerid][3], 2);
	PlayerTextDrawSetProportional(playerid, MDC_MenuUI[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_MenuUI[playerid][3], true);

	cached_y += 12.200000;

	MDC_MenuUI[playerid][4] = CreatePlayerTextDraw(playerid, 197.766717, cached_y, "CCTV");
	PlayerTextDrawLetterSize(playerid, MDC_MenuUI[playerid][4], 0.148999, 0.845035);
	PlayerTextDrawTextSize(playerid, MDC_MenuUI[playerid][4], 6.000000, 50.000000);
	PlayerTextDrawAlignment(playerid, MDC_MenuUI[playerid][4], 2);
	PlayerTextDrawColor(playerid, MDC_MenuUI[playerid][4], 858993663);
	PlayerTextDrawUseBox(playerid, MDC_MenuUI[playerid][4], true);
	PlayerTextDrawBoxColor(playerid, MDC_MenuUI[playerid][4], -1431655681);
	PlayerTextDrawSetShadow(playerid, MDC_MenuUI[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, MDC_MenuUI[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_MenuUI[playerid][4], 51);
	PlayerTextDrawFont(playerid, MDC_MenuUI[playerid][4], 2);
	PlayerTextDrawSetProportional(playerid, MDC_MenuUI[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_MenuUI[playerid][4], true);

	cached_y += 12.200000;

	MDC_MenuUI[playerid][5] = CreatePlayerTextDraw(playerid, 197.766717, cached_y, "Vehicle Bolo");
	PlayerTextDrawLetterSize(playerid, MDC_MenuUI[playerid][5], 0.148999, 0.845035);
	PlayerTextDrawTextSize(playerid, MDC_MenuUI[playerid][5], 6.000000, 50.000000);
	PlayerTextDrawAlignment(playerid, MDC_MenuUI[playerid][5], 2);
	PlayerTextDrawColor(playerid, MDC_MenuUI[playerid][5], 858993663);
	PlayerTextDrawUseBox(playerid, MDC_MenuUI[playerid][5], true);
	PlayerTextDrawBoxColor(playerid, MDC_MenuUI[playerid][5], -1431655681);
	PlayerTextDrawSetShadow(playerid, MDC_MenuUI[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, MDC_MenuUI[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_MenuUI[playerid][5], 51);
	PlayerTextDrawFont(playerid, MDC_MenuUI[playerid][5], 2);
	PlayerTextDrawSetProportional(playerid, MDC_MenuUI[playerid][5], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_MenuUI[playerid][5], true);
	//////////////////////
	
	//vehicle search UI
	MDC_VehicleUI[playerid][0] = CreatePlayerTextDraw(playerid, 224.000061, 176.985229, "");
	PlayerTextDrawTextSize(playerid, MDC_VehicleUI[playerid][0], 96.000000, 91.000000);
	PlayerTextDrawAlignment(playerid, MDC_VehicleUI[playerid][0], 1);
	PlayerTextDrawColor(playerid, MDC_VehicleUI[playerid][0], -1);
	PlayerTextDrawSetShadow(playerid, MDC_VehicleUI[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_VehicleUI[playerid][0], -256);
	PlayerTextDrawFont(playerid, MDC_VehicleUI[playerid][0], 5);
	PlayerTextDrawSetProportional(playerid, MDC_VehicleUI[playerid][0], 0);
	PlayerTextDrawSetPreviewModel(playerid, MDC_VehicleUI[playerid][0], 445);
	PlayerTextDrawSetPreviewRot(playerid, MDC_VehicleUI[playerid][0], 0.000000, 0.000000, 90.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, MDC_VehicleUI[playerid][0], 0, 0);

	MDC_VehicleUI[playerid][1] = CreatePlayerTextDraw(playerid, 319.333312, 199.525955, "Model:~N~Plate:~N~Owner:~N~Insurance:~N~Impounded:");
	PlayerTextDrawLetterSize(playerid, MDC_VehicleUI[playerid][1], 0.149999, 0.807703);
	PlayerTextDrawAlignment(playerid, MDC_VehicleUI[playerid][1], 1);
	PlayerTextDrawColor(playerid, MDC_VehicleUI[playerid][1], 858993663);
	PlayerTextDrawSetShadow(playerid, MDC_VehicleUI[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, MDC_VehicleUI[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_VehicleUI[playerid][1], 51);
	PlayerTextDrawFont(playerid, MDC_VehicleUI[playerid][1], 2);
	PlayerTextDrawSetProportional(playerid, MDC_VehicleUI[playerid][1], 1);

	MDC_VehicleUI[playerid][2] = CreatePlayerTextDraw(playerid, 359.333282, 199.940765, "Admiral~N~6NZT552~N~Firstname_Lastname~N~~w~Level_3~n~~b~No");
	PlayerTextDrawLetterSize(playerid, MDC_VehicleUI[playerid][2], 0.149999, 0.795259);
	PlayerTextDrawAlignment(playerid, MDC_VehicleUI[playerid][2], 1);
	PlayerTextDrawColor(playerid, MDC_VehicleUI[playerid][2], -1431655681);
	PlayerTextDrawSetShadow(playerid, MDC_VehicleUI[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, MDC_VehicleUI[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_VehicleUI[playerid][2], 51);
	PlayerTextDrawFont(playerid, MDC_VehicleUI[playerid][2], 2);
	PlayerTextDrawSetProportional(playerid, MDC_VehicleUI[playerid][2], 1);

	MDC_VehicleUI[playerid][3] = CreatePlayerTextDraw(playerid, 232.333343, 194.548141, "ERROR: NO MATCHES WERE FOUND");
	PlayerTextDrawLetterSize(playerid, MDC_VehicleUI[playerid][3], 0.150333, 0.803555);
	PlayerTextDrawTextSize(playerid, MDC_VehicleUI[playerid][3], 462.666656, 35.674068);
	PlayerTextDrawAlignment(playerid, MDC_VehicleUI[playerid][3], 1);
	PlayerTextDrawColor(playerid, MDC_VehicleUI[playerid][3], -1);
	PlayerTextDrawUseBox(playerid, MDC_VehicleUI[playerid][3], true);
	PlayerTextDrawBoxColor(playerid, MDC_VehicleUI[playerid][3], -1440603393);
	PlayerTextDrawSetShadow(playerid, MDC_VehicleUI[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, MDC_VehicleUI[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_VehicleUI[playerid][3], 51);
	PlayerTextDrawFont(playerid, MDC_VehicleUI[playerid][3], 2);
	PlayerTextDrawSetProportional(playerid, MDC_VehicleUI[playerid][3], 1);
	
	MDC_Created{playerid} = true;
	return true;
}

stock MDC_CreateChargesUI(playerid)
{
	MDC_Created{playerid} = false;
	
    MDC_ChargesUI[playerid][0] = CreatePlayerTextDraw(playerid, 229.333404, 183.348144, "LD_SPAC:WHITE");
    PlayerTextDrawLetterSize(playerid, MDC_ChargesUI[playerid][0], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, MDC_ChargesUI[playerid][0], 235.666748, 236.444213);
    PlayerTextDrawAlignment(playerid, MDC_ChargesUI[playerid][0], 1);
    PlayerTextDrawColor(playerid, MDC_ChargesUI[playerid][0], -1);
    PlayerTextDrawSetShadow(playerid, MDC_ChargesUI[playerid][0], 0);
    PlayerTextDrawSetOutline(playerid, MDC_ChargesUI[playerid][0], 0);
    PlayerTextDrawFont(playerid, MDC_ChargesUI[playerid][0], 4);

    new Float:current_y = 185.422225;

	for(new i = 1; i < 24; ++i)
	{
    	MDC_ChargesUI[playerid][i] = CreatePlayerTextDraw(playerid, 230.333328, current_y, "");
    	PlayerTextDrawLetterSize(playerid, MDC_ChargesUI[playerid][i], 0.170665, 0.832590);
    	PlayerTextDrawTextSize(playerid, MDC_ChargesUI[playerid][i], 464.000091, 6.000000);
    	PlayerTextDrawAlignment(playerid, MDC_ChargesUI[playerid][i], 1);
    	PlayerTextDrawColor(playerid, MDC_ChargesUI[playerid][i], 255);
    	PlayerTextDrawUseBox(playerid, MDC_ChargesUI[playerid][i], true);
    	PlayerTextDrawBoxColor(playerid, MDC_ChargesUI[playerid][i], 255);
    	PlayerTextDrawSetShadow(playerid, MDC_ChargesUI[playerid][i], 0);
    	PlayerTextDrawSetOutline(playerid, MDC_ChargesUI[playerid][i], 0);
    	PlayerTextDrawBackgroundColor(playerid, MDC_ChargesUI[playerid][i], 51);
    	PlayerTextDrawFont(playerid, MDC_ChargesUI[playerid][i], 1);
    	PlayerTextDrawSetProportional(playerid, MDC_ChargesUI[playerid][i], 1);
    	PlayerTextDrawSetSelectable(playerid, MDC_ChargesUI[playerid][i], true);

    	current_y += 9.955567;
	}

    MDC_ChargesUI[playerid][24] = CreatePlayerTextDraw(playerid, 346.666656, 425.599884, "1/1");
    PlayerTextDrawLetterSize(playerid, MDC_ChargesUI[playerid][24], 0.147999, 0.824295);
    PlayerTextDrawAlignment(playerid, MDC_ChargesUI[playerid][24], 2);
    PlayerTextDrawColor(playerid, MDC_ChargesUI[playerid][24], 255);
    PlayerTextDrawSetShadow(playerid, MDC_ChargesUI[playerid][24], 0);
    PlayerTextDrawSetOutline(playerid, MDC_ChargesUI[playerid][24], 0);
    PlayerTextDrawBackgroundColor(playerid, MDC_ChargesUI[playerid][24], 51);
    PlayerTextDrawFont(playerid, MDC_ChargesUI[playerid][24], 2);
    PlayerTextDrawSetProportional(playerid, MDC_ChargesUI[playerid][24], 1);

    MDC_ChargesUI[playerid][25] = CreatePlayerTextDraw(playerid, 229.666580, 185.837127, "Entry_ID");
    PlayerTextDrawLetterSize(playerid, MDC_ChargesUI[playerid][25], 0.168999, 0.762072);
    PlayerTextDrawAlignment(playerid, MDC_ChargesUI[playerid][25], 1);
    PlayerTextDrawColor(playerid, MDC_ChargesUI[playerid][25], 858993663);
    PlayerTextDrawSetShadow(playerid, MDC_ChargesUI[playerid][25], 0);
    PlayerTextDrawSetOutline(playerid, MDC_ChargesUI[playerid][25], 0);
    PlayerTextDrawBackgroundColor(playerid, MDC_ChargesUI[playerid][25], 51);
    PlayerTextDrawFont(playerid, MDC_ChargesUI[playerid][25], 1);
    PlayerTextDrawSetProportional(playerid, MDC_ChargesUI[playerid][25], 1);

    MDC_ChargesUI[playerid][26] = CreatePlayerTextDraw(playerid, 236.999984, 192.888916, "Name");
    PlayerTextDrawLetterSize(playerid, MDC_ChargesUI[playerid][26], 0.163332, 0.778666);
    PlayerTextDrawAlignment(playerid, MDC_ChargesUI[playerid][26], 1);
    PlayerTextDrawColor(playerid, MDC_ChargesUI[playerid][26], 858993663);
    PlayerTextDrawSetShadow(playerid, MDC_ChargesUI[playerid][26], 0);
    PlayerTextDrawSetOutline(playerid, MDC_ChargesUI[playerid][26], 0);
    PlayerTextDrawBackgroundColor(playerid, MDC_ChargesUI[playerid][26], 51);
    PlayerTextDrawFont(playerid, MDC_ChargesUI[playerid][26], 1);
    PlayerTextDrawSetProportional(playerid, MDC_ChargesUI[playerid][26], 1);

    MDC_ChargesUI[playerid][27] = CreatePlayerTextDraw(playerid, 236.333374, 200.355575, "Issuer");
    PlayerTextDrawLetterSize(playerid, MDC_ChargesUI[playerid][27], 0.167333, 0.708148);
    PlayerTextDrawAlignment(playerid, MDC_ChargesUI[playerid][27], 1);
    PlayerTextDrawColor(playerid, MDC_ChargesUI[playerid][27], 858993663);
    PlayerTextDrawSetShadow(playerid, MDC_ChargesUI[playerid][27], 0);
    PlayerTextDrawSetOutline(playerid, MDC_ChargesUI[playerid][27], 0);
    PlayerTextDrawBackgroundColor(playerid, MDC_ChargesUI[playerid][27], 51);
    PlayerTextDrawFont(playerid, MDC_ChargesUI[playerid][27], 1);
    PlayerTextDrawSetProportional(playerid, MDC_ChargesUI[playerid][27], 1);

    MDC_ChargesUI[playerid][28] = CreatePlayerTextDraw(playerid, 239.666641, 207.822189, "Date");
    PlayerTextDrawLetterSize(playerid, MDC_ChargesUI[playerid][28], 0.164664, 0.703998);
    PlayerTextDrawAlignment(playerid, MDC_ChargesUI[playerid][28], 1);
    PlayerTextDrawColor(playerid, MDC_ChargesUI[playerid][28], 858993663);
    PlayerTextDrawSetShadow(playerid, MDC_ChargesUI[playerid][28], 0);
    PlayerTextDrawSetOutline(playerid, MDC_ChargesUI[playerid][28], 0);
    PlayerTextDrawBackgroundColor(playerid, MDC_ChargesUI[playerid][28], 51);
    PlayerTextDrawFont(playerid, MDC_ChargesUI[playerid][28], 1);
    PlayerTextDrawSetProportional(playerid, MDC_ChargesUI[playerid][28], 1);

    MDC_ChargesUI[playerid][29] = CreatePlayerTextDraw(playerid, 239.000000, 214.459274, "Type");
    PlayerTextDrawLetterSize(playerid, MDC_ChargesUI[playerid][29], 0.170662, 0.791109);
    PlayerTextDrawAlignment(playerid, MDC_ChargesUI[playerid][29], 1);
    PlayerTextDrawColor(playerid, MDC_ChargesUI[playerid][29], 858993663);
    PlayerTextDrawSetShadow(playerid, MDC_ChargesUI[playerid][29], 0);
    PlayerTextDrawSetOutline(playerid, MDC_ChargesUI[playerid][29], 0);
    PlayerTextDrawBackgroundColor(playerid, MDC_ChargesUI[playerid][29], 51);
    PlayerTextDrawFont(playerid, MDC_ChargesUI[playerid][29], 1);
    PlayerTextDrawSetProportional(playerid, MDC_ChargesUI[playerid][29], 1);

    MDC_ChargesUI[playerid][30] = CreatePlayerTextDraw(playerid, 259.666595, 185.837005, "charge_data");
    PlayerTextDrawLetterSize(playerid, MDC_ChargesUI[playerid][30], 0.169666, 0.791109);
    PlayerTextDrawAlignment(playerid, MDC_ChargesUI[playerid][30], 1);
    PlayerTextDrawColor(playerid, MDC_ChargesUI[playerid][30], -1431655681);
    PlayerTextDrawSetShadow(playerid, MDC_ChargesUI[playerid][30], 0);
    PlayerTextDrawSetOutline(playerid, MDC_ChargesUI[playerid][30], 0);
    PlayerTextDrawBackgroundColor(playerid, MDC_ChargesUI[playerid][30], 51);
    PlayerTextDrawFont(playerid, MDC_ChargesUI[playerid][30], 1);
    PlayerTextDrawSetProportional(playerid, MDC_ChargesUI[playerid][30], 1);

    MDC_ChargesUI[playerid][31] = CreatePlayerTextDraw(playerid, 229.666748, 227.733337, "Charges");
    PlayerTextDrawLetterSize(playerid, MDC_ChargesUI[playerid][31], 0.166997, 0.786961);
    PlayerTextDrawAlignment(playerid, MDC_ChargesUI[playerid][31], 1);
    PlayerTextDrawColor(playerid, MDC_ChargesUI[playerid][31], 858993663);
    PlayerTextDrawSetShadow(playerid, MDC_ChargesUI[playerid][31], 0);
    PlayerTextDrawSetOutline(playerid, MDC_ChargesUI[playerid][31], 0);
    PlayerTextDrawBackgroundColor(playerid, MDC_ChargesUI[playerid][31], 51);
    PlayerTextDrawFont(playerid, MDC_ChargesUI[playerid][31], 1);
    PlayerTextDrawSetProportional(playerid, MDC_ChargesUI[playerid][31], 1);

    current_y = 239.762939;

    for(new i = 32; i < 37; ++i)
    {
    	MDC_ChargesUI[playerid][i] = CreatePlayerTextDraw(playerid, 230.666687, current_y, "-  Some more made up charges that justify the length of this extremely ...");
    	PlayerTextDrawLetterSize(playerid, MDC_ChargesUI[playerid][i], 0.170000, 0.795256);
    	PlayerTextDrawTextSize(playerid, MDC_ChargesUI[playerid][i], 464.666717, 6.000000);
    	PlayerTextDrawAlignment(playerid, MDC_ChargesUI[playerid][i], 1);
    	PlayerTextDrawColor(playerid, MDC_ChargesUI[playerid][i], -1431655681);
    	PlayerTextDrawUseBox(playerid, MDC_ChargesUI[playerid][i], true);
    	PlayerTextDrawBoxColor(playerid, MDC_ChargesUI[playerid][i], -1);
    	PlayerTextDrawSetShadow(playerid, MDC_ChargesUI[playerid][i], 0);
    	PlayerTextDrawSetOutline(playerid, MDC_ChargesUI[playerid][i], 0);
    	PlayerTextDrawBackgroundColor(playerid, MDC_ChargesUI[playerid][i], 51);
    	PlayerTextDrawFont(playerid, MDC_ChargesUI[playerid][i], 1);
    	PlayerTextDrawSetProportional(playerid, MDC_ChargesUI[playerid][i], 1);

    	current_y += 12.200012;
    }

    MDC_ChargesUI[playerid][37] = CreatePlayerTextDraw(playerid, 229.666809, 299.666687, "Quote");
    PlayerTextDrawLetterSize(playerid, MDC_ChargesUI[playerid][37], 0.166997, 0.786961);
    PlayerTextDrawAlignment(playerid, MDC_ChargesUI[playerid][37], 1);
    PlayerTextDrawColor(playerid, MDC_ChargesUI[playerid][37], 858993663);
    PlayerTextDrawSetShadow(playerid, MDC_ChargesUI[playerid][37], 0);
    PlayerTextDrawSetOutline(playerid, MDC_ChargesUI[playerid][37], 0);
    PlayerTextDrawBackgroundColor(playerid, MDC_ChargesUI[playerid][37], 51);
    PlayerTextDrawFont(playerid, MDC_ChargesUI[playerid][37], 1);
    PlayerTextDrawSetProportional(playerid, MDC_ChargesUI[playerid][37], 1);

    MDC_ChargesUI[playerid][38] = CreatePlayerTextDraw(playerid, 229.666687, 307.962890, "charge_quote");
    PlayerTextDrawLetterSize(playerid, MDC_ChargesUI[playerid][38], 0.170000, 0.795256);
    PlayerTextDrawTextSize(playerid, MDC_ChargesUI[playerid][38], 464.666778, -7.881481);
    PlayerTextDrawAlignment(playerid, MDC_ChargesUI[playerid][38], 1);
    PlayerTextDrawColor(playerid, MDC_ChargesUI[playerid][38], -1431655681);
    PlayerTextDrawUseBox(playerid, MDC_ChargesUI[playerid][38], true);
    PlayerTextDrawBoxColor(playerid, MDC_ChargesUI[playerid][38], 0);
    PlayerTextDrawSetShadow(playerid, MDC_ChargesUI[playerid][38], 0);
    PlayerTextDrawSetOutline(playerid, MDC_ChargesUI[playerid][38], 0);
    PlayerTextDrawBackgroundColor(playerid, MDC_ChargesUI[playerid][38], 51);
    PlayerTextDrawFont(playerid, MDC_ChargesUI[playerid][38], 1);
    PlayerTextDrawSetProportional(playerid, MDC_ChargesUI[playerid][38], 1);

    MDC_ChargesUI[playerid][39] = CreatePlayerTextDraw(playerid, 229.666702, 323.896331, "Arrest Record (written by Firstname Lastname)");
    PlayerTextDrawLetterSize(playerid, MDC_ChargesUI[playerid][39], 0.169330, 0.782812);
    PlayerTextDrawAlignment(playerid, MDC_ChargesUI[playerid][39], 1);
    PlayerTextDrawColor(playerid, MDC_ChargesUI[playerid][39], 858993663);
    PlayerTextDrawSetShadow(playerid, MDC_ChargesUI[playerid][39], 0);
    PlayerTextDrawSetOutline(playerid, MDC_ChargesUI[playerid][39], 0);
    PlayerTextDrawBackgroundColor(playerid, MDC_ChargesUI[playerid][39], 51);
    PlayerTextDrawFont(playerid, MDC_ChargesUI[playerid][39], 1);
    PlayerTextDrawSetProportional(playerid, MDC_ChargesUI[playerid][39], 1);

    MDC_ChargesUI[playerid][40] = CreatePlayerTextDraw(playerid, 229.666702, 331.777709, "arrest_record");
    PlayerTextDrawLetterSize(playerid, MDC_ChargesUI[playerid][40], 0.170000, 0.795256);
    PlayerTextDrawTextSize(playerid, MDC_ChargesUI[playerid][40], 464.333465, -2.074073);
    PlayerTextDrawAlignment(playerid, MDC_ChargesUI[playerid][40], 1);
    PlayerTextDrawColor(playerid, MDC_ChargesUI[playerid][40], -1431655681);
    PlayerTextDrawUseBox(playerid, MDC_ChargesUI[playerid][40], true);
    PlayerTextDrawBoxColor(playerid, MDC_ChargesUI[playerid][40], 0);
    PlayerTextDrawSetShadow(playerid, MDC_ChargesUI[playerid][40], 0);
    PlayerTextDrawSetOutline(playerid, MDC_ChargesUI[playerid][40], 0);
    PlayerTextDrawBackgroundColor(playerid, MDC_ChargesUI[playerid][40], 51);
    PlayerTextDrawFont(playerid, MDC_ChargesUI[playerid][40], 1);
    PlayerTextDrawSetProportional(playerid, MDC_ChargesUI[playerid][40], 1);
	
	MDC_Created{playerid} = true;
	return true;
}

stock MDC_CreateLicensesTD(playerid)
{
	MDC_Created{playerid} = false;

	MDC_LicensesUI[playerid][0] = CreatePlayerTextDraw(playerid, 229.333389, 186.666687, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, MDC_LicensesUI[playerid][0], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, MDC_LicensesUI[playerid][0], 117.333328, 48.533332);
	PlayerTextDrawAlignment(playerid, MDC_LicensesUI[playerid][0], 1);
	PlayerTextDrawColor(playerid, MDC_LicensesUI[playerid][0], -1);
	PlayerTextDrawSetShadow(playerid, MDC_LicensesUI[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LicensesUI[playerid][0], 0);
	PlayerTextDrawFont(playerid, MDC_LicensesUI[playerid][0], 4);

	MDC_LicensesUI[playerid][1] = CreatePlayerTextDraw(playerid, 229.333374, 186.251892, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, MDC_LicensesUI[playerid][1], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, MDC_LicensesUI[playerid][1], 117.333358, 10.370374);
	PlayerTextDrawAlignment(playerid, MDC_LicensesUI[playerid][1], 1);
	PlayerTextDrawColor(playerid, MDC_LicensesUI[playerid][1], 826708223);
	PlayerTextDrawSetShadow(playerid, MDC_LicensesUI[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LicensesUI[playerid][1], 0);
	PlayerTextDrawFont(playerid, MDC_LicensesUI[playerid][1], 4);

	MDC_LicensesUI[playerid][2] = CreatePlayerTextDraw(playerid, 231.666793, 186.666656, "hud:radar_impound");
	PlayerTextDrawLetterSize(playerid, MDC_LicensesUI[playerid][2], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, MDC_LicensesUI[playerid][2], 15.999982, 16.177801);
	PlayerTextDrawAlignment(playerid, MDC_LicensesUI[playerid][2], 1);
	PlayerTextDrawColor(playerid, MDC_LicensesUI[playerid][2], -1);
	PlayerTextDrawSetShadow(playerid, MDC_LicensesUI[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LicensesUI[playerid][2], 0);
	PlayerTextDrawFont(playerid, MDC_LicensesUI[playerid][2], 4);

	MDC_LicensesUI[playerid][3] = CreatePlayerTextDraw(playerid, 249.333358, 188.740783, "Driver's_License");
	PlayerTextDrawLetterSize(playerid, MDC_LicensesUI[playerid][3], 0.150333, 0.803555);
	PlayerTextDrawAlignment(playerid, MDC_LicensesUI[playerid][3], 1);
	PlayerTextDrawColor(playerid, MDC_LicensesUI[playerid][3], -1);
	PlayerTextDrawSetShadow(playerid, MDC_LicensesUI[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LicensesUI[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_LicensesUI[playerid][3], 51);
	PlayerTextDrawFont(playerid, MDC_LicensesUI[playerid][3], 2);
	PlayerTextDrawSetProportional(playerid, MDC_LicensesUI[playerid][3], 1);

	MDC_LicensesUI[playerid][4] = CreatePlayerTextDraw(playerid, 249.666656, 197.866638, "Status:~n~Warnings:");
	PlayerTextDrawLetterSize(playerid, MDC_LicensesUI[playerid][4], 0.178332, 0.778666);
	PlayerTextDrawAlignment(playerid, MDC_LicensesUI[playerid][4], 1);
	PlayerTextDrawColor(playerid, MDC_LicensesUI[playerid][4], -1431655681);
	PlayerTextDrawSetShadow(playerid, MDC_LicensesUI[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LicensesUI[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_LicensesUI[playerid][4], 51);
	PlayerTextDrawFont(playerid, MDC_LicensesUI[playerid][4], 1);
	PlayerTextDrawSetProportional(playerid, MDC_LicensesUI[playerid][4], 1);

	MDC_LicensesUI[playerid][5] = CreatePlayerTextDraw(playerid, 279.333343, 197.866653, "Acquired~n~0");
	PlayerTextDrawLetterSize(playerid, MDC_LicensesUI[playerid][5], 0.181666, 0.778665);
	PlayerTextDrawAlignment(playerid, MDC_LicensesUI[playerid][5], 1);
	PlayerTextDrawColor(playerid, MDC_LicensesUI[playerid][5], -1431655681);
	PlayerTextDrawSetShadow(playerid, MDC_LicensesUI[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LicensesUI[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_LicensesUI[playerid][5], 51);
	PlayerTextDrawFont(playerid, MDC_LicensesUI[playerid][5], 1);
	PlayerTextDrawSetProportional(playerid, MDC_LicensesUI[playerid][5], 1);

	MDC_LicensesUI[playerid][6] = CreatePlayerTextDraw(playerid, 247.666687, 224.000061, "REVOKE");
	PlayerTextDrawLetterSize(playerid, MDC_LicensesUI[playerid][6], 0.147999, 0.733035);
	PlayerTextDrawTextSize(playerid, MDC_LicensesUI[playerid][6], 6.000000, 29.451835);
	PlayerTextDrawAlignment(playerid, MDC_LicensesUI[playerid][6], 2);
	PlayerTextDrawColor(playerid, MDC_LicensesUI[playerid][6], -1);
	PlayerTextDrawUseBox(playerid, MDC_LicensesUI[playerid][6], true);
	PlayerTextDrawBoxColor(playerid, MDC_LicensesUI[playerid][6], -2061099265);
	PlayerTextDrawSetShadow(playerid, MDC_LicensesUI[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LicensesUI[playerid][6], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_LicensesUI[playerid][6], 51);
	PlayerTextDrawFont(playerid, MDC_LicensesUI[playerid][6], 2);
	PlayerTextDrawSetProportional(playerid, MDC_LicensesUI[playerid][6], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_LicensesUI[playerid][6], true);

	MDC_LicensesUI[playerid][7] = CreatePlayerTextDraw(playerid, 277.666687, 223.755645, "WARN");
	PlayerTextDrawLetterSize(playerid, MDC_LicensesUI[playerid][7], 0.147999, 0.733035);
	PlayerTextDrawTextSize(playerid, MDC_LicensesUI[playerid][7], 6.000000, 21.570339);
	PlayerTextDrawAlignment(playerid, MDC_LicensesUI[playerid][7], 2);
	PlayerTextDrawColor(playerid, MDC_LicensesUI[playerid][7], -1);
	PlayerTextDrawUseBox(playerid, MDC_LicensesUI[playerid][7], true);
	PlayerTextDrawBoxColor(playerid, MDC_LicensesUI[playerid][7], 539042047);
	PlayerTextDrawSetShadow(playerid, MDC_LicensesUI[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LicensesUI[playerid][7], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_LicensesUI[playerid][7], 51);
	PlayerTextDrawFont(playerid, MDC_LicensesUI[playerid][7], 2);
	PlayerTextDrawSetProportional(playerid, MDC_LicensesUI[playerid][7], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_LicensesUI[playerid][7], true);

	MDC_LicensesUI[playerid][8] = CreatePlayerTextDraw(playerid, 308.000030, 223.926010, "SUSPEND");
	PlayerTextDrawLetterSize(playerid, MDC_LicensesUI[playerid][8], 0.147999, 0.733035);
	PlayerTextDrawTextSize(playerid, MDC_LicensesUI[playerid][8], 6.000000, 30.281440);
	PlayerTextDrawAlignment(playerid, MDC_LicensesUI[playerid][8], 2);
	PlayerTextDrawColor(playerid, MDC_LicensesUI[playerid][8], -1);
	PlayerTextDrawUseBox(playerid, MDC_LicensesUI[playerid][8], true);
	PlayerTextDrawBoxColor(playerid, MDC_LicensesUI[playerid][8], 539042047);
	PlayerTextDrawSetShadow(playerid, MDC_LicensesUI[playerid][8], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LicensesUI[playerid][8], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_LicensesUI[playerid][8], 51);
	PlayerTextDrawFont(playerid, MDC_LicensesUI[playerid][8], 2);
	PlayerTextDrawSetProportional(playerid, MDC_LicensesUI[playerid][8], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_LicensesUI[playerid][8], true);

	MDC_LicensesUI[playerid][9] = CreatePlayerTextDraw(playerid, 349.333312, 186.666687, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, MDC_LicensesUI[playerid][9], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, MDC_LicensesUI[playerid][9], 117.333335, 48.533309);
	PlayerTextDrawAlignment(playerid, MDC_LicensesUI[playerid][9], 1);
	PlayerTextDrawColor(playerid, MDC_LicensesUI[playerid][9], -1);
	PlayerTextDrawSetShadow(playerid, MDC_LicensesUI[playerid][9], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LicensesUI[playerid][9], 0);
	PlayerTextDrawFont(playerid, MDC_LicensesUI[playerid][9], 4);

	MDC_LicensesUI[playerid][10] = CreatePlayerTextDraw(playerid, 349.333374, 186.251922, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, MDC_LicensesUI[playerid][10], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, MDC_LicensesUI[playerid][10], 117.333358, 10.370368);
	PlayerTextDrawAlignment(playerid, MDC_LicensesUI[playerid][10], 1);
	PlayerTextDrawColor(playerid, MDC_LicensesUI[playerid][10], 826708223);
	PlayerTextDrawSetShadow(playerid, MDC_LicensesUI[playerid][10], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LicensesUI[playerid][10], 0);
	PlayerTextDrawFont(playerid, MDC_LicensesUI[playerid][10], 4);

	MDC_LicensesUI[playerid][11] = CreatePlayerTextDraw(playerid, 351.666717, 187.081542, "hud:radar_ammugun");
	PlayerTextDrawLetterSize(playerid, MDC_LicensesUI[playerid][11], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, MDC_LicensesUI[playerid][11], 15.666707, 15.348154);
	PlayerTextDrawAlignment(playerid, MDC_LicensesUI[playerid][11], 1);
	PlayerTextDrawColor(playerid, MDC_LicensesUI[playerid][11], -1);
	PlayerTextDrawSetShadow(playerid, MDC_LicensesUI[playerid][11], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LicensesUI[playerid][11], 0);
	PlayerTextDrawFont(playerid, MDC_LicensesUI[playerid][11], 4);

	MDC_LicensesUI[playerid][12] = CreatePlayerTextDraw(playerid, 369.333312, 188.740753, "Weapon_License");
	PlayerTextDrawLetterSize(playerid, MDC_LicensesUI[playerid][12], 0.150000, 0.770370);
	PlayerTextDrawAlignment(playerid, MDC_LicensesUI[playerid][12], 1);
	PlayerTextDrawColor(playerid, MDC_LicensesUI[playerid][12], -1);
	PlayerTextDrawSetShadow(playerid, MDC_LicensesUI[playerid][12], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LicensesUI[playerid][12], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_LicensesUI[playerid][12], 51);
	PlayerTextDrawFont(playerid, MDC_LicensesUI[playerid][12], 2);
	PlayerTextDrawSetProportional(playerid, MDC_LicensesUI[playerid][12], 1);

	MDC_LicensesUI[playerid][13] = CreatePlayerTextDraw(playerid, 369.666595, 197.866683, "Status:~n~Type:~n~Guard:");
	PlayerTextDrawLetterSize(playerid, MDC_LicensesUI[playerid][13], 0.177333, 0.795259);
	PlayerTextDrawAlignment(playerid, MDC_LicensesUI[playerid][13], 1);
	PlayerTextDrawColor(playerid, MDC_LicensesUI[playerid][13], -1431655681);
	PlayerTextDrawSetShadow(playerid, MDC_LicensesUI[playerid][13], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LicensesUI[playerid][13], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_LicensesUI[playerid][13], 51);
	PlayerTextDrawFont(playerid, MDC_LicensesUI[playerid][13], 1);
	PlayerTextDrawSetProportional(playerid, MDC_LicensesUI[playerid][13], 1);

	MDC_LicensesUI[playerid][14] = CreatePlayerTextDraw(playerid, 399.333312, 197.866729, "Not acquired~n~N/A~n~No");
	PlayerTextDrawLetterSize(playerid, MDC_LicensesUI[playerid][14], 0.180333, 0.791111);
	PlayerTextDrawAlignment(playerid, MDC_LicensesUI[playerid][14], 1);
	PlayerTextDrawColor(playerid, MDC_LicensesUI[playerid][14], -1431655681);
	PlayerTextDrawSetShadow(playerid, MDC_LicensesUI[playerid][14], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LicensesUI[playerid][14], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_LicensesUI[playerid][14], 51);
	PlayerTextDrawFont(playerid, MDC_LicensesUI[playerid][14], 1);
	PlayerTextDrawSetProportional(playerid, MDC_LicensesUI[playerid][14], 1);

	MDC_LicensesUI[playerid][15] = CreatePlayerTextDraw(playerid, 367.666625, 224.170425, "REVOKE");
	PlayerTextDrawLetterSize(playerid, MDC_LicensesUI[playerid][15], 0.147999, 0.733035);
	PlayerTextDrawTextSize(playerid, MDC_LicensesUI[playerid][15], 6.000000, 29.451835);
	PlayerTextDrawAlignment(playerid, MDC_LicensesUI[playerid][15], 2);
	PlayerTextDrawColor(playerid, MDC_LicensesUI[playerid][15], -1);
	PlayerTextDrawUseBox(playerid, MDC_LicensesUI[playerid][15], true);
	PlayerTextDrawBoxColor(playerid, MDC_LicensesUI[playerid][15], -2061099265);
	PlayerTextDrawSetShadow(playerid, MDC_LicensesUI[playerid][15], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LicensesUI[playerid][15], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_LicensesUI[playerid][15], 51);
	PlayerTextDrawFont(playerid, MDC_LicensesUI[playerid][15], 2);
	PlayerTextDrawSetProportional(playerid, MDC_LicensesUI[playerid][15], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_LicensesUI[playerid][15], true);

	MDC_LicensesUI[playerid][16] = CreatePlayerTextDraw(playerid, 229.333328, 238.933364, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, MDC_LicensesUI[playerid][16], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, MDC_LicensesUI[playerid][16], 117.333389, 48.118522);
	PlayerTextDrawAlignment(playerid, MDC_LicensesUI[playerid][16], 1);
	PlayerTextDrawColor(playerid, MDC_LicensesUI[playerid][16], -1);
	PlayerTextDrawSetShadow(playerid, MDC_LicensesUI[playerid][16], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LicensesUI[playerid][16], 0);
	PlayerTextDrawFont(playerid, MDC_LicensesUI[playerid][16], 4);

	MDC_LicensesUI[playerid][17] = CreatePlayerTextDraw(playerid, 229.333343, 238.518554, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, MDC_LicensesUI[playerid][17], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, MDC_LicensesUI[playerid][17], 117.333366, 10.370370);
	PlayerTextDrawAlignment(playerid, MDC_LicensesUI[playerid][17], 1);
	PlayerTextDrawColor(playerid, MDC_LicensesUI[playerid][17], 826708223);
	PlayerTextDrawSetShadow(playerid, MDC_LicensesUI[playerid][17], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LicensesUI[playerid][17], 0);
	PlayerTextDrawFont(playerid, MDC_LicensesUI[playerid][17], 4);

	MDC_LicensesUI[playerid][18] = CreatePlayerTextDraw(playerid, 231.333419, 236.029586, "hud:radarRingPlane");
	PlayerTextDrawLetterSize(playerid, MDC_LicensesUI[playerid][18], -0.035666, -0.136888);
	PlayerTextDrawTextSize(playerid, MDC_LicensesUI[playerid][18], 16.333309, 17.007394);
	PlayerTextDrawAlignment(playerid, MDC_LicensesUI[playerid][18], 1);
	PlayerTextDrawColor(playerid, MDC_LicensesUI[playerid][18], -1);
	PlayerTextDrawSetShadow(playerid, MDC_LicensesUI[playerid][18], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LicensesUI[playerid][18], 0);
	PlayerTextDrawFont(playerid, MDC_LicensesUI[playerid][18], 4);

	MDC_LicensesUI[playerid][19] = CreatePlayerTextDraw(playerid, 249.333343, 240.592590, "Pilot_Certification");
	PlayerTextDrawLetterSize(playerid, MDC_LicensesUI[playerid][19], 0.150333, 0.803555);
	PlayerTextDrawAlignment(playerid, MDC_LicensesUI[playerid][19], 1);
	PlayerTextDrawColor(playerid, MDC_LicensesUI[playerid][19], -1);
	PlayerTextDrawSetShadow(playerid, MDC_LicensesUI[playerid][19], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LicensesUI[playerid][19], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_LicensesUI[playerid][19], 51);
	PlayerTextDrawFont(playerid, MDC_LicensesUI[playerid][19], 2);
	PlayerTextDrawSetProportional(playerid, MDC_LicensesUI[playerid][19], 1);

	MDC_LicensesUI[playerid][20] = CreatePlayerTextDraw(playerid, 249.333328, 249.718444, "Status:");
	PlayerTextDrawLetterSize(playerid, MDC_LicensesUI[playerid][20], 0.179666, 0.762073);
	PlayerTextDrawAlignment(playerid, MDC_LicensesUI[playerid][20], 1);
	PlayerTextDrawColor(playerid, MDC_LicensesUI[playerid][20], -1431655681);
	PlayerTextDrawSetShadow(playerid, MDC_LicensesUI[playerid][20], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LicensesUI[playerid][20], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_LicensesUI[playerid][20], 51);
	PlayerTextDrawFont(playerid, MDC_LicensesUI[playerid][20], 1);
	PlayerTextDrawSetProportional(playerid, MDC_LicensesUI[playerid][20], 1);

	MDC_LicensesUI[playerid][21] = CreatePlayerTextDraw(playerid, 279.333312, 249.718612, "Not acquired");
	PlayerTextDrawLetterSize(playerid, MDC_LicensesUI[playerid][21], 0.181333, 0.766221);
	PlayerTextDrawAlignment(playerid, MDC_LicensesUI[playerid][21], 1);
	PlayerTextDrawColor(playerid, MDC_LicensesUI[playerid][21], -1431655681);
	PlayerTextDrawSetShadow(playerid, MDC_LicensesUI[playerid][21], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LicensesUI[playerid][21], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_LicensesUI[playerid][21], 51);
	PlayerTextDrawFont(playerid, MDC_LicensesUI[playerid][21], 1);
	PlayerTextDrawSetProportional(playerid, MDC_LicensesUI[playerid][21], 1);

	MDC_LicensesUI[playerid][22] = CreatePlayerTextDraw(playerid, 247.666625, 276.192749, "REVOKE");
	PlayerTextDrawLetterSize(playerid, MDC_LicensesUI[playerid][22], 0.147999, 0.733035);
	PlayerTextDrawTextSize(playerid, MDC_LicensesUI[playerid][22], 6.000000, 29.451835);
	PlayerTextDrawAlignment(playerid, MDC_LicensesUI[playerid][22], 2);
	PlayerTextDrawColor(playerid, MDC_LicensesUI[playerid][22], -1);
	PlayerTextDrawUseBox(playerid, MDC_LicensesUI[playerid][22], true);
	PlayerTextDrawBoxColor(playerid, MDC_LicensesUI[playerid][22], -2061099265);
	PlayerTextDrawSetShadow(playerid, MDC_LicensesUI[playerid][22], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LicensesUI[playerid][22], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_LicensesUI[playerid][22], 51);
	PlayerTextDrawFont(playerid, MDC_LicensesUI[playerid][22], 2);
	PlayerTextDrawSetProportional(playerid, MDC_LicensesUI[playerid][22], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_LicensesUI[playerid][22], true);

	MDC_LicensesUI[playerid][23] = CreatePlayerTextDraw(playerid, 349.333343, 238.518554, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, MDC_LicensesUI[playerid][23], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, MDC_LicensesUI[playerid][23], 117.333335, 48.533321);
	PlayerTextDrawAlignment(playerid, MDC_LicensesUI[playerid][23], 1);
	PlayerTextDrawColor(playerid, MDC_LicensesUI[playerid][23], -1);
	PlayerTextDrawSetShadow(playerid, MDC_LicensesUI[playerid][23], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LicensesUI[playerid][23], 0);
	PlayerTextDrawFont(playerid, MDC_LicensesUI[playerid][23], 4);

	MDC_LicensesUI[playerid][24] = CreatePlayerTextDraw(playerid, 349.333312, 238.518463, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, MDC_LicensesUI[playerid][24], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, MDC_LicensesUI[playerid][24], 117.333358, 10.370370);
	PlayerTextDrawAlignment(playerid, MDC_LicensesUI[playerid][24], 1);
	PlayerTextDrawColor(playerid, MDC_LicensesUI[playerid][24], 826708223);
	PlayerTextDrawSetShadow(playerid, MDC_LicensesUI[playerid][24], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LicensesUI[playerid][24], 0);
	PlayerTextDrawFont(playerid, MDC_LicensesUI[playerid][24], 4);

	MDC_LicensesUI[playerid][25] = CreatePlayerTextDraw(playerid, 351.666564, 238.518539, "hud:radar_hostpital");
	PlayerTextDrawLetterSize(playerid, MDC_LicensesUI[playerid][25], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, MDC_LicensesUI[playerid][25], 15.666707, 16.177772);
	PlayerTextDrawAlignment(playerid, MDC_LicensesUI[playerid][25], 1);
	PlayerTextDrawColor(playerid, MDC_LicensesUI[playerid][25], -1);
	PlayerTextDrawSetShadow(playerid, MDC_LicensesUI[playerid][25], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LicensesUI[playerid][25], 0);
	PlayerTextDrawFont(playerid, MDC_LicensesUI[playerid][25], 4);

	MDC_LicensesUI[playerid][26] = CreatePlayerTextDraw(playerid, 369.666656, 240.592590, "Medical_License");
	PlayerTextDrawLetterSize(playerid, MDC_LicensesUI[playerid][26], 0.149333, 0.815999);
	PlayerTextDrawAlignment(playerid, MDC_LicensesUI[playerid][26], 1);
	PlayerTextDrawColor(playerid, MDC_LicensesUI[playerid][26], -1);
	PlayerTextDrawSetShadow(playerid, MDC_LicensesUI[playerid][26], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LicensesUI[playerid][26], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_LicensesUI[playerid][26], 51);
	PlayerTextDrawFont(playerid, MDC_LicensesUI[playerid][26], 2);
	PlayerTextDrawSetProportional(playerid, MDC_LicensesUI[playerid][26], 1);

	MDC_LicensesUI[playerid][27] = CreatePlayerTextDraw(playerid, 369.666687, 249.718505, "Status:~n~Type:");
	PlayerTextDrawLetterSize(playerid, MDC_LicensesUI[playerid][27], 0.175999, 0.778666);
	PlayerTextDrawAlignment(playerid, MDC_LicensesUI[playerid][27], 1);
	PlayerTextDrawColor(playerid, MDC_LicensesUI[playerid][27], -1431655681);
	PlayerTextDrawSetShadow(playerid, MDC_LicensesUI[playerid][27], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LicensesUI[playerid][27], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_LicensesUI[playerid][27], 51);
	PlayerTextDrawFont(playerid, MDC_LicensesUI[playerid][27], 1);
	PlayerTextDrawSetProportional(playerid, MDC_LicensesUI[playerid][27], 1);

	MDC_LicensesUI[playerid][28] = CreatePlayerTextDraw(playerid, 399.666656, 249.718536, "Not acquired~n~None");
	PlayerTextDrawLetterSize(playerid, MDC_LicensesUI[playerid][28], 0.178333, 0.786962);
	PlayerTextDrawAlignment(playerid, MDC_LicensesUI[playerid][28], 1);
	PlayerTextDrawColor(playerid, MDC_LicensesUI[playerid][28], -1431655681);
	PlayerTextDrawSetShadow(playerid, MDC_LicensesUI[playerid][28], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LicensesUI[playerid][28], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_LicensesUI[playerid][28], 51);
	PlayerTextDrawFont(playerid, MDC_LicensesUI[playerid][28], 1);
	PlayerTextDrawSetProportional(playerid, MDC_LicensesUI[playerid][28], 1);

	MDC_LicensesUI[playerid][29] = CreatePlayerTextDraw(playerid, 367.666595, 275.533538, "REVOKE");
	PlayerTextDrawLetterSize(playerid, MDC_LicensesUI[playerid][29], 0.147999, 0.733035);
	PlayerTextDrawTextSize(playerid, MDC_LicensesUI[playerid][29], 6.000000, 29.451835);
	PlayerTextDrawAlignment(playerid, MDC_LicensesUI[playerid][29], 2);
	PlayerTextDrawColor(playerid, MDC_LicensesUI[playerid][29], -1);
	PlayerTextDrawUseBox(playerid, MDC_LicensesUI[playerid][29], true);
	PlayerTextDrawBoxColor(playerid, MDC_LicensesUI[playerid][29], -2061099265);
	PlayerTextDrawSetShadow(playerid, MDC_LicensesUI[playerid][29], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LicensesUI[playerid][29], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_LicensesUI[playerid][29], 51);
	PlayerTextDrawFont(playerid, MDC_LicensesUI[playerid][29], 2);
	PlayerTextDrawSetProportional(playerid, MDC_LicensesUI[playerid][29], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_LicensesUI[playerid][29], true);

	MDC_LicensesUI[playerid][30] = CreatePlayerTextDraw(playerid, 229.333328, 290.370391, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, MDC_LicensesUI[playerid][30], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, MDC_LicensesUI[playerid][30], 117.333335, 48.533302);
	PlayerTextDrawAlignment(playerid, MDC_LicensesUI[playerid][30], 1);
	PlayerTextDrawColor(playerid, MDC_LicensesUI[playerid][30], -1);
	PlayerTextDrawSetShadow(playerid, MDC_LicensesUI[playerid][30], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LicensesUI[playerid][30], 0);
	PlayerTextDrawFont(playerid, MDC_LicensesUI[playerid][30], 4);

	MDC_LicensesUI[playerid][31] = CreatePlayerTextDraw(playerid, 229.333389, 290.370391, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, MDC_LicensesUI[playerid][31], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, MDC_LicensesUI[playerid][31], 117.333358, 10.785186);
	PlayerTextDrawAlignment(playerid, MDC_LicensesUI[playerid][31], 1);
	PlayerTextDrawColor(playerid, MDC_LicensesUI[playerid][31], 826708223);
	PlayerTextDrawSetShadow(playerid, MDC_LicensesUI[playerid][31], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LicensesUI[playerid][31], 0);
	PlayerTextDrawFont(playerid, MDC_LicensesUI[playerid][31], 4);

	MDC_LicensesUI[playerid][32] = CreatePlayerTextDraw(playerid, 231.666671, 291.199920, "hud:radar_truck");
	PlayerTextDrawLetterSize(playerid, MDC_LicensesUI[playerid][32], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, MDC_LicensesUI[playerid][32], 15.666637, 15.348142);
	PlayerTextDrawAlignment(playerid, MDC_LicensesUI[playerid][32], 1);
	PlayerTextDrawColor(playerid, MDC_LicensesUI[playerid][32], -1);
	PlayerTextDrawSetShadow(playerid, MDC_LicensesUI[playerid][32], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LicensesUI[playerid][32], 0);
	PlayerTextDrawFont(playerid, MDC_LicensesUI[playerid][32], 4);

	MDC_LicensesUI[playerid][33] = CreatePlayerTextDraw(playerid, 249.666702, 292.859130, "Trucking_License");
	PlayerTextDrawLetterSize(playerid, MDC_LicensesUI[playerid][33], 0.149000, 0.803555);
	PlayerTextDrawAlignment(playerid, MDC_LicensesUI[playerid][33], 1);
	PlayerTextDrawColor(playerid, MDC_LicensesUI[playerid][33], -1);
	PlayerTextDrawSetShadow(playerid, MDC_LicensesUI[playerid][33], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LicensesUI[playerid][33], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_LicensesUI[playerid][33], 51);
	PlayerTextDrawFont(playerid, MDC_LicensesUI[playerid][33], 2);
	PlayerTextDrawSetProportional(playerid, MDC_LicensesUI[playerid][33], 1);

	MDC_LicensesUI[playerid][34] = CreatePlayerTextDraw(playerid, 249.333343, 301.985076, "Status:~n~Type:");
	PlayerTextDrawLetterSize(playerid, MDC_LicensesUI[playerid][34], 0.183999, 0.766222);
	PlayerTextDrawAlignment(playerid, MDC_LicensesUI[playerid][34], 1);
	PlayerTextDrawColor(playerid, MDC_LicensesUI[playerid][34], -1431655681);
	PlayerTextDrawSetShadow(playerid, MDC_LicensesUI[playerid][34], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LicensesUI[playerid][34], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_LicensesUI[playerid][34], 51);
	PlayerTextDrawFont(playerid, MDC_LicensesUI[playerid][34], 1);
	PlayerTextDrawSetProportional(playerid, MDC_LicensesUI[playerid][34], 1);

	MDC_LicensesUI[playerid][35] = CreatePlayerTextDraw(playerid, 279.666687, 301.985137, "Not acquired~n~N/A");
	PlayerTextDrawLetterSize(playerid, MDC_LicensesUI[playerid][35], 0.178333, 0.749629);
	PlayerTextDrawAlignment(playerid, MDC_LicensesUI[playerid][35], 1);
	PlayerTextDrawColor(playerid, MDC_LicensesUI[playerid][35], -1431655681);
	PlayerTextDrawSetShadow(playerid, MDC_LicensesUI[playerid][35], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LicensesUI[playerid][35], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_LicensesUI[playerid][35], 51);
	PlayerTextDrawFont(playerid, MDC_LicensesUI[playerid][35], 1);
	PlayerTextDrawSetProportional(playerid, MDC_LicensesUI[playerid][35], 1);

	MDC_LicensesUI[playerid][36] = CreatePlayerTextDraw(playerid, 247.666610, 327.970581, "REVOKE");
	PlayerTextDrawLetterSize(playerid, MDC_LicensesUI[playerid][36], 0.147999, 0.733035);
	PlayerTextDrawTextSize(playerid, MDC_LicensesUI[playerid][36], 6.000000, 29.451835);
	PlayerTextDrawAlignment(playerid, MDC_LicensesUI[playerid][36], 2);
	PlayerTextDrawColor(playerid, MDC_LicensesUI[playerid][36], -1);
	PlayerTextDrawUseBox(playerid, MDC_LicensesUI[playerid][36], true);
	PlayerTextDrawBoxColor(playerid, MDC_LicensesUI[playerid][36], -2061099265);
	PlayerTextDrawSetShadow(playerid, MDC_LicensesUI[playerid][36], 0);
	PlayerTextDrawSetOutline(playerid, MDC_LicensesUI[playerid][36], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_LicensesUI[playerid][36], 51);
	PlayerTextDrawFont(playerid, MDC_LicensesUI[playerid][36], 2);
	PlayerTextDrawSetProportional(playerid, MDC_LicensesUI[playerid][36], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_LicensesUI[playerid][36], true);
	
	MDC_Created{playerid} = true;
	return true;
}

stock MDC_CreatePenalCodeTD(playerid)
{
    MDC_Created{playerid} = false;

	new Float:current_y = 185.422195;

	for(new i = 0; i < 21; ++i)
 	{
		MDC_PenalCodeUI[playerid][i] = CreatePlayerTextDraw(playerid, 230.333374, current_y, "_");
		PlayerTextDrawLetterSize(playerid, MDC_PenalCodeUI[playerid][i], 0.170331, 0.832589);
		PlayerTextDrawTextSize(playerid, MDC_PenalCodeUI[playerid][i], 329.666778, 6.000000);
		PlayerTextDrawAlignment(playerid, MDC_PenalCodeUI[playerid][i], 1);
		PlayerTextDrawColor(playerid, MDC_PenalCodeUI[playerid][i],  -1431655681);
		PlayerTextDrawUseBox(playerid, MDC_PenalCodeUI[playerid][i], true);
		PlayerTextDrawBoxColor(playerid, MDC_PenalCodeUI[playerid][i], -1);
		PlayerTextDrawSetShadow(playerid, MDC_PenalCodeUI[playerid][i], 0);
		PlayerTextDrawSetOutline(playerid, MDC_PenalCodeUI[playerid][i], 0);
		PlayerTextDrawBackgroundColor(playerid, MDC_PenalCodeUI[playerid][i], 51);
		PlayerTextDrawFont(playerid, MDC_PenalCodeUI[playerid][i], 1);
		PlayerTextDrawSetProportional(playerid, MDC_PenalCodeUI[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, MDC_PenalCodeUI[playerid][i], true);

		current_y += 12.029648;
	}

	MDC_PenalCodeUI[playerid][21] = CreatePlayerTextDraw(playerid, 334.333343, 185.422195, "filter charges ..."); //185.422241
	PlayerTextDrawLetterSize(playerid, MDC_PenalCodeUI[playerid][21], 0.170998, 0.832589); //0.845035
	PlayerTextDrawTextSize(playerid, MDC_PenalCodeUI[playerid][21], 430.000122, 6.000000);
	PlayerTextDrawAlignment(playerid, MDC_PenalCodeUI[playerid][21], 1);
	PlayerTextDrawColor(playerid, MDC_PenalCodeUI[playerid][21], -1431655681);
	PlayerTextDrawUseBox(playerid, MDC_PenalCodeUI[playerid][21], true);
	PlayerTextDrawBoxColor(playerid, MDC_PenalCodeUI[playerid][21], -1);
	PlayerTextDrawSetShadow(playerid, MDC_PenalCodeUI[playerid][21], 0);
	PlayerTextDrawSetOutline(playerid, MDC_PenalCodeUI[playerid][21], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_PenalCodeUI[playerid][21], 51);
	PlayerTextDrawFont(playerid, MDC_PenalCodeUI[playerid][21], 1);
	PlayerTextDrawSetProportional(playerid, MDC_PenalCodeUI[playerid][21], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_PenalCodeUI[playerid][21], true);

	MDC_PenalCodeUI[playerid][22] = CreatePlayerTextDraw(playerid, 449.666687, 185.422195, "CLEAR"); //185.422210
	PlayerTextDrawLetterSize(playerid, MDC_PenalCodeUI[playerid][22], 0.149997, 0.832589); //0.857478
	PlayerTextDrawTextSize(playerid, MDC_PenalCodeUI[playerid][22], 6.000000, 30.281475);
	PlayerTextDrawAlignment(playerid, MDC_PenalCodeUI[playerid][22], 2);
	PlayerTextDrawColor(playerid, MDC_PenalCodeUI[playerid][22], 858993663);
	PlayerTextDrawUseBox(playerid, MDC_PenalCodeUI[playerid][22], true);
	PlayerTextDrawBoxColor(playerid, MDC_PenalCodeUI[playerid][22], -1431655681);
	PlayerTextDrawSetShadow(playerid, MDC_PenalCodeUI[playerid][22], 0);
	PlayerTextDrawSetOutline(playerid, MDC_PenalCodeUI[playerid][22], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_PenalCodeUI[playerid][22], 51);
	PlayerTextDrawFont(playerid, MDC_PenalCodeUI[playerid][22], 2);
	PlayerTextDrawSetProportional(playerid, MDC_PenalCodeUI[playerid][22], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_PenalCodeUI[playerid][22], true);

	MDC_PenalCodeUI[playerid][23] = CreatePlayerTextDraw(playerid, 334.333404, 209.481475, "(1)10. Kidnapping is a felony punishable by 270 minutes of jail time");
	PlayerTextDrawLetterSize(playerid, MDC_PenalCodeUI[playerid][23], 0.170332, 0.824295);
	PlayerTextDrawTextSize(playerid, MDC_PenalCodeUI[playerid][23], 462.666503, 42.311115);
	PlayerTextDrawAlignment(playerid, MDC_PenalCodeUI[playerid][23], 1);
	PlayerTextDrawColor(playerid, MDC_PenalCodeUI[playerid][23], -1);
	PlayerTextDrawUseBox(playerid, MDC_PenalCodeUI[playerid][23], true);
	PlayerTextDrawBoxColor(playerid, MDC_PenalCodeUI[playerid][23], 0);
	PlayerTextDrawSetShadow(playerid, MDC_PenalCodeUI[playerid][23], 0);
	PlayerTextDrawSetOutline(playerid, MDC_PenalCodeUI[playerid][23], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_PenalCodeUI[playerid][23], 51);
	PlayerTextDrawFont(playerid, MDC_PenalCodeUI[playerid][23], 1);
	PlayerTextDrawSetProportional(playerid, MDC_PenalCodeUI[playerid][23], 1);

	MDC_PenalCodeUI[playerid][24] = CreatePlayerTextDraw(playerid, 334.333374, 233.540725, "1. A person who detains or arrests another without their consent (or the consent of their guardian) with the premeditated inten");
	PlayerTextDrawLetterSize(playerid, MDC_PenalCodeUI[playerid][24], 0.170331, 0.824294);
	PlayerTextDrawTextSize(playerid, MDC_PenalCodeUI[playerid][24], 463.333465, 12.029628);
	PlayerTextDrawAlignment(playerid, MDC_PenalCodeUI[playerid][24], 1);
	PlayerTextDrawColor(playerid, MDC_PenalCodeUI[playerid][24], 858993663);
	PlayerTextDrawUseBox(playerid, MDC_PenalCodeUI[playerid][24], true);
	PlayerTextDrawBoxColor(playerid, MDC_PenalCodeUI[playerid][24], 9568256);
	PlayerTextDrawSetShadow(playerid, MDC_PenalCodeUI[playerid][24], 0);
	PlayerTextDrawSetOutline(playerid, MDC_PenalCodeUI[playerid][24], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_PenalCodeUI[playerid][24], 51);
	PlayerTextDrawFont(playerid, MDC_PenalCodeUI[playerid][24], 1);

	MDC_PenalCodeUI[playerid][25] = CreatePlayerTextDraw(playerid, 449.666687, 305.718750, "ADD");
	PlayerTextDrawLetterSize(playerid, MDC_PenalCodeUI[playerid][25], 0.149994, 0.832589);
	PlayerTextDrawTextSize(playerid, MDC_PenalCodeUI[playerid][25], 6.000000, 30.281467);
	PlayerTextDrawAlignment(playerid, MDC_PenalCodeUI[playerid][25], 2);
	PlayerTextDrawColor(playerid, MDC_PenalCodeUI[playerid][25], 858993663);
	PlayerTextDrawUseBox(playerid, MDC_PenalCodeUI[playerid][25], true);
	PlayerTextDrawBoxColor(playerid, MDC_PenalCodeUI[playerid][25], -1431655681);
	PlayerTextDrawSetShadow(playerid, MDC_PenalCodeUI[playerid][25], 0);
	PlayerTextDrawSetOutline(playerid, MDC_PenalCodeUI[playerid][25], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_PenalCodeUI[playerid][25], 51);
	PlayerTextDrawFont(playerid, MDC_PenalCodeUI[playerid][25], 2);
	PlayerTextDrawSetProportional(playerid, MDC_PenalCodeUI[playerid][25], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_PenalCodeUI[playerid][25], true);

	MDC_PenalCodeUI[playerid][26] = CreatePlayerTextDraw(playerid, 399.666748, 317.748413, "~y~]_~w~Selected_Charges_~y~]");
	PlayerTextDrawLetterSize(playerid, MDC_PenalCodeUI[playerid][26], 0.149994, 0.832589);
	PlayerTextDrawTextSize(playerid, MDC_PenalCodeUI[playerid][26], -28.333337, 130.251846);
	PlayerTextDrawAlignment(playerid, MDC_PenalCodeUI[playerid][26], 2);
	PlayerTextDrawColor(playerid, MDC_PenalCodeUI[playerid][26], 572662527);
	PlayerTextDrawUseBox(playerid, MDC_PenalCodeUI[playerid][26], true);
	PlayerTextDrawBoxColor(playerid, MDC_PenalCodeUI[playerid][26], 255);
	PlayerTextDrawSetShadow(playerid, MDC_PenalCodeUI[playerid][26], 0);
	PlayerTextDrawSetOutline(playerid, MDC_PenalCodeUI[playerid][26], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_PenalCodeUI[playerid][26], 51);
	PlayerTextDrawFont(playerid, MDC_PenalCodeUI[playerid][26], 2);
	PlayerTextDrawSetProportional(playerid, MDC_PenalCodeUI[playerid][26], 1);

	current_y = 329.778061;

	for(new i = 27; i < 32; ++i)
	{
		MDC_PenalCodeUI[playerid][i] = CreatePlayerTextDraw(playerid, 334.333221, current_y, "_");
		PlayerTextDrawLetterSize(playerid, MDC_PenalCodeUI[playerid][i], 0.170329, 0.832589);
		PlayerTextDrawTextSize(playerid, MDC_PenalCodeUI[playerid][i], 465.000061, 6.000000);
		PlayerTextDrawAlignment(playerid, MDC_PenalCodeUI[playerid][i], 1);
		PlayerTextDrawColor(playerid, MDC_PenalCodeUI[playerid][i], COLOR_BLACK);
		PlayerTextDrawUseBox(playerid, MDC_PenalCodeUI[playerid][i], true);
		PlayerTextDrawBoxColor(playerid, MDC_PenalCodeUI[playerid][i], -1);
		PlayerTextDrawSetShadow(playerid, MDC_PenalCodeUI[playerid][i], 0);
		PlayerTextDrawSetOutline(playerid, MDC_PenalCodeUI[playerid][i], 0);
		PlayerTextDrawBackgroundColor(playerid, MDC_PenalCodeUI[playerid][i], 51);
		PlayerTextDrawFont(playerid, MDC_PenalCodeUI[playerid][i], 1);
		PlayerTextDrawSetProportional(playerid, MDC_PenalCodeUI[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, MDC_PenalCodeUI[playerid][i], true);

		current_y += 12.029648;
	}

	MDC_PenalCodeUI[playerid][32] = CreatePlayerTextDraw(playerid, 334.333374, 341.807709, "~>~ Clear");
	PlayerTextDrawLetterSize(playerid, MDC_PenalCodeUI[playerid][32], 0.170329, 0.832589);
	PlayerTextDrawTextSize(playerid, MDC_PenalCodeUI[playerid][32], 395.666687, 6.000000);
	PlayerTextDrawAlignment(playerid, MDC_PenalCodeUI[playerid][32], 1);
	PlayerTextDrawColor(playerid, MDC_PenalCodeUI[playerid][32], -1);
	PlayerTextDrawUseBox(playerid, MDC_PenalCodeUI[playerid][32], true);
	PlayerTextDrawBoxColor(playerid, MDC_PenalCodeUI[playerid][32], 858993663);
	PlayerTextDrawSetShadow(playerid, MDC_PenalCodeUI[playerid][32], 0);
	PlayerTextDrawSetOutline(playerid, MDC_PenalCodeUI[playerid][32], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_PenalCodeUI[playerid][32], 51);
	PlayerTextDrawFont(playerid, MDC_PenalCodeUI[playerid][32], 1);
	PlayerTextDrawSetProportional(playerid, MDC_PenalCodeUI[playerid][32], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_PenalCodeUI[playerid][32], true);

	MDC_PenalCodeUI[playerid][33] = CreatePlayerTextDraw(playerid, 399.333343, 341.807709, "~>~ Press Charges"); //341.392578
	PlayerTextDrawLetterSize(playerid, MDC_PenalCodeUI[playerid][33], 0.170329, 0.832589);
	PlayerTextDrawTextSize(playerid, MDC_PenalCodeUI[playerid][33], 465.000000, 6.000000);
	PlayerTextDrawAlignment(playerid, MDC_PenalCodeUI[playerid][33], 1);
	PlayerTextDrawColor(playerid, MDC_PenalCodeUI[playerid][33], -1);
	PlayerTextDrawUseBox(playerid, MDC_PenalCodeUI[playerid][33], true);
	PlayerTextDrawBoxColor(playerid, MDC_PenalCodeUI[playerid][33], -1440603393);
	PlayerTextDrawSetShadow(playerid, MDC_PenalCodeUI[playerid][33], 0);
	PlayerTextDrawSetOutline(playerid, MDC_PenalCodeUI[playerid][33], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_PenalCodeUI[playerid][33], 51);
	PlayerTextDrawFont(playerid, MDC_PenalCodeUI[playerid][33], 1);
	PlayerTextDrawSetProportional(playerid, MDC_PenalCodeUI[playerid][33], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_PenalCodeUI[playerid][33], true);

	MDC_PenalCodeUI[playerid][34] = CreatePlayerTextDraw(playerid, 334.333374, 197.866683, "ATT");
	PlayerTextDrawLetterSize(playerid, MDC_PenalCodeUI[playerid][34], 0.172333, 0.778667);
	PlayerTextDrawAlignment(playerid, MDC_PenalCodeUI[playerid][34], 1);
	PlayerTextDrawColor(playerid, MDC_PenalCodeUI[playerid][34], -1431655681);
	PlayerTextDrawSetShadow(playerid, MDC_PenalCodeUI[playerid][34], 0);
	PlayerTextDrawSetOutline(playerid, MDC_PenalCodeUI[playerid][34], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_PenalCodeUI[playerid][34], 51);
	PlayerTextDrawFont(playerid, MDC_PenalCodeUI[playerid][34], 1);
	PlayerTextDrawSetProportional(playerid, MDC_PenalCodeUI[playerid][34], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_PenalCodeUI[playerid][34], false);

	MDC_PenalCodeUI[playerid][35] = CreatePlayerTextDraw(playerid, 349.333251, 197.866622, "CON");
	PlayerTextDrawLetterSize(playerid, MDC_PenalCodeUI[playerid][35], 0.172333, 0.778666);
	PlayerTextDrawAlignment(playerid, MDC_PenalCodeUI[playerid][35], 1);
	PlayerTextDrawColor(playerid, MDC_PenalCodeUI[playerid][35], -1431655681);
	PlayerTextDrawSetShadow(playerid, MDC_PenalCodeUI[playerid][35], 0);
	PlayerTextDrawSetOutline(playerid, MDC_PenalCodeUI[playerid][35], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_PenalCodeUI[playerid][35], 51);
	PlayerTextDrawFont(playerid, MDC_PenalCodeUI[playerid][35], 1);
	PlayerTextDrawSetProportional(playerid, MDC_PenalCodeUI[playerid][35], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_PenalCodeUI[playerid][35], false);

	MDC_PenalCodeUI[playerid][36] = CreatePlayerTextDraw(playerid, 364.333312, 197.866592, "SOL");
	PlayerTextDrawLetterSize(playerid, MDC_PenalCodeUI[playerid][36], 0.172333, 0.778666);
	PlayerTextDrawAlignment(playerid, MDC_PenalCodeUI[playerid][36], 1);
	PlayerTextDrawColor(playerid, MDC_PenalCodeUI[playerid][36], -1431655681);
	PlayerTextDrawSetShadow(playerid, MDC_PenalCodeUI[playerid][36], 0);
	PlayerTextDrawSetOutline(playerid, MDC_PenalCodeUI[playerid][36], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_PenalCodeUI[playerid][36], 51);
	PlayerTextDrawFont(playerid, MDC_PenalCodeUI[playerid][36], 1);
	PlayerTextDrawSetProportional(playerid, MDC_PenalCodeUI[playerid][36], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_PenalCodeUI[playerid][36], false);

	MDC_PenalCodeUI[playerid][37] = CreatePlayerTextDraw(playerid, 379.333343, 197.866638, "GOV");
	PlayerTextDrawLetterSize(playerid, MDC_PenalCodeUI[playerid][37], 0.172333, 0.778666);
	PlayerTextDrawAlignment(playerid, MDC_PenalCodeUI[playerid][37], 1);
	PlayerTextDrawColor(playerid, MDC_PenalCodeUI[playerid][37], -1431655681);
	PlayerTextDrawSetShadow(playerid, MDC_PenalCodeUI[playerid][37], 0);
	PlayerTextDrawSetOutline(playerid, MDC_PenalCodeUI[playerid][37], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_PenalCodeUI[playerid][37], 51);
	PlayerTextDrawFont(playerid, MDC_PenalCodeUI[playerid][37], 1);
	PlayerTextDrawSetProportional(playerid, MDC_PenalCodeUI[playerid][37], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_PenalCodeUI[playerid][37], false);

	MDC_PenalCodeUI[playerid][38] = CreatePlayerTextDraw(playerid, 394.333312, 197.866653, "CAC");
	PlayerTextDrawLetterSize(playerid, MDC_PenalCodeUI[playerid][38], 0.172333, 0.778666);
	PlayerTextDrawAlignment(playerid, MDC_PenalCodeUI[playerid][38], 1);
	PlayerTextDrawColor(playerid, MDC_PenalCodeUI[playerid][38], -1431655681);
	PlayerTextDrawSetShadow(playerid, MDC_PenalCodeUI[playerid][38], 0);
	PlayerTextDrawSetOutline(playerid, MDC_PenalCodeUI[playerid][38], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_PenalCodeUI[playerid][38], 51);
	PlayerTextDrawFont(playerid, MDC_PenalCodeUI[playerid][38], 1);
	PlayerTextDrawSetProportional(playerid, MDC_PenalCodeUI[playerid][38], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_PenalCodeUI[playerid][38], false);

	MDC_PenalCodeUI[playerid][39] = CreatePlayerTextDraw(playerid, 409.333343, 197.866668, "AAF");
	PlayerTextDrawLetterSize(playerid, MDC_PenalCodeUI[playerid][39], 0.172333, 0.778666);
	PlayerTextDrawAlignment(playerid, MDC_PenalCodeUI[playerid][39], 1);
	PlayerTextDrawColor(playerid, MDC_PenalCodeUI[playerid][39], -1431655681);
	PlayerTextDrawSetShadow(playerid, MDC_PenalCodeUI[playerid][39], 0);
	PlayerTextDrawSetOutline(playerid, MDC_PenalCodeUI[playerid][39], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_PenalCodeUI[playerid][39], 51);
	PlayerTextDrawFont(playerid, MDC_PenalCodeUI[playerid][39], 1);
	PlayerTextDrawSetProportional(playerid, MDC_PenalCodeUI[playerid][39], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_PenalCodeUI[playerid][39], false);
	
	MDC_Created{playerid} = true;
	return true;
}

stock MDC_CreatePropertiesTD(playerid)
{
    MDC_Created{playerid} = false;

	MDC_PropertiesUI[playerid][0] = CreatePlayerTextDraw(playerid, 229.666702, 185.837036, "Selected Address");
	PlayerTextDrawLetterSize(playerid, MDC_PropertiesUI[playerid][0], 0.169666, 0.757926);
	PlayerTextDrawAlignment(playerid, MDC_PropertiesUI[playerid][0], 1);
	PlayerTextDrawColor(playerid, MDC_PropertiesUI[playerid][0], 858993663);
	PlayerTextDrawSetShadow(playerid, MDC_PropertiesUI[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, MDC_PropertiesUI[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_PropertiesUI[playerid][0], 51);
	PlayerTextDrawFont(playerid, MDC_PropertiesUI[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, MDC_PropertiesUI[playerid][0], 1);

	MDC_PropertiesUI[playerid][1] = CreatePlayerTextDraw(playerid, 229.666732, 193.888885, "1403 Martin Luther King Drive~n~Idlewood~n~Los Santos 415~n~San Andreas");
	PlayerTextDrawLetterSize(playerid, MDC_PropertiesUI[playerid][1], 0.168999, 0.786962);
	PlayerTextDrawAlignment(playerid, MDC_PropertiesUI[playerid][1], 1);
	PlayerTextDrawColor(playerid, MDC_PropertiesUI[playerid][1], -1431655681);
	PlayerTextDrawSetShadow(playerid, MDC_PropertiesUI[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, MDC_PropertiesUI[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_PropertiesUI[playerid][1], 51);
	PlayerTextDrawFont(playerid, MDC_PropertiesUI[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, MDC_PropertiesUI[playerid][1], 1);

	MDC_PropertiesUI[playerid][2] = CreatePlayerTextDraw(playerid, 229.666687, 225.000015, "Other Addresses");
	PlayerTextDrawLetterSize(playerid, MDC_PropertiesUI[playerid][2], 0.169666, 0.757926);
	PlayerTextDrawAlignment(playerid, MDC_PropertiesUI[playerid][2], 1);
	PlayerTextDrawColor(playerid, MDC_PropertiesUI[playerid][2], 858993663);
	PlayerTextDrawSetShadow(playerid, MDC_PropertiesUI[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, MDC_PropertiesUI[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_PropertiesUI[playerid][2], 51);
	PlayerTextDrawFont(playerid, MDC_PropertiesUI[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, MDC_PropertiesUI[playerid][2], 1);

	new Float:current_y = 235.125946;

	for(new i = 3; i < 19; ++i)
	{
		MDC_PropertiesUI[playerid][i] = CreatePlayerTextDraw(playerid, 230.666671, current_y, "- 240 Alandele Avenue");
		PlayerTextDrawLetterSize(playerid, MDC_PropertiesUI[playerid][i], 0.169666, 0.757926);
		PlayerTextDrawTextSize(playerid, MDC_PropertiesUI[playerid][i], 339.666748, 6.000000);
		PlayerTextDrawAlignment(playerid, MDC_PropertiesUI[playerid][i], 1);
		PlayerTextDrawColor(playerid, MDC_PropertiesUI[playerid][i], -1431655681);
		PlayerTextDrawUseBox(playerid, MDC_PropertiesUI[playerid][i], true);
		PlayerTextDrawBoxColor(playerid, MDC_PropertiesUI[playerid][i], -1);
		PlayerTextDrawSetShadow(playerid, MDC_PropertiesUI[playerid][i], 0);
		PlayerTextDrawSetOutline(playerid, MDC_PropertiesUI[playerid][i], 0);
		PlayerTextDrawBackgroundColor(playerid, MDC_PropertiesUI[playerid][i], 51);
		PlayerTextDrawFont(playerid, MDC_PropertiesUI[playerid][i], 1);
		PlayerTextDrawSetProportional(playerid, MDC_PropertiesUI[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, MDC_PropertiesUI[playerid][i], true);

		current_y += 11.785202;
	}

	MDC_PropertiesUI[playerid][19] = CreatePlayerTextDraw(playerid, 347.999969, 175.466659, "samaps:gtasamapbit4");
	PlayerTextDrawLetterSize(playerid, MDC_PropertiesUI[playerid][19], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, MDC_PropertiesUI[playerid][19], 119.333320, 119.051864);
	PlayerTextDrawAlignment(playerid, MDC_PropertiesUI[playerid][19], 1);
	PlayerTextDrawColor(playerid, MDC_PropertiesUI[playerid][19], -1);
	PlayerTextDrawSetShadow(playerid, MDC_PropertiesUI[playerid][19], 0);
	PlayerTextDrawSetOutline(playerid, MDC_PropertiesUI[playerid][19], 0);
	PlayerTextDrawFont(playerid, MDC_PropertiesUI[playerid][19], 4);
	
	MDC_Created{playerid} = true;
	return true;
}

stock MDC_DestroyPage(playerid, page)
{
    MDC_Created{playerid} = false;

	switch(page)
	{
	    case 1:
	    {
			switch(e_Player_MDC_Cache[playerid][current_page])
     		{
     		    case 2, 3:
     		    {
					for(new i = 0; i < 41; ++i)
					{
					    PlayerTextDrawDestroy(playerid, MDC_ChargesUI[playerid][i]);
					}
     		    }
     		    case 4:
     		    {
					for(new i = 0; i < 37; ++i)
					{
					    PlayerTextDrawDestroy(playerid, MDC_LicensesUI[playerid][i]);
					}
     		    }
	        	case 5:
	            {
	                for(new i = 0; i < 40; ++i)
	                {
	                    PlayerTextDrawDestroy(playerid, MDC_PenalCodeUI[playerid][i]);
	                }
	            }
	        	case 6:
	            {
	                for(new i = 0; i < 20; ++i)
	                {
	                    PlayerTextDrawDestroy(playerid, MDC_PropertiesUI[playerid][i]);
	                }
	            }
			}
	    }
	    case 2:
	    {
	        for(new i = 0; i < 27; ++i)
	        {
	            PlayerTextDrawDestroy(playerid, MDC_Emergency[playerid][i]);
	        }
	    }
	    case 3:
	    {
	        for(new i = 0; i < 24; ++i)
	        {
	            PlayerTextDrawDestroy(playerid, MDC_RosterUI[playerid][i]);
	        }
	    }
	    case 5:
	    {
	        for(new i = 0; i < 11; ++i)
	        {
	            PlayerTextDrawDestroy(playerid, MDC_VehicleBOLO[playerid][i]);
	        }
	    }
	}
	
	MDC_Created{playerid} = true;
	return true;
}

stock MDC_CreatePage(playerid, page)
{
    MDC_Created{playerid} = false;

	new Float:current_y;

	switch(page)
	{
		case 2:
		{
			//emergency

			new Float:current_pos[5];

			current_pos[0] = 176.137039;
			current_pos[1] = 176.711120;
			current_pos[2] = 176.466705;
			current_pos[3] = 212.799987;
			current_pos[4] = 212.799987; //212.555587

			for(new i = 0; i < 24; i += 5)
			{
			    if(i >= 24) break;

				MDC_Emergency[playerid][i] = CreatePlayerTextDraw(playerid, 467.333312, current_pos[0], "usebox");
				PlayerTextDrawLetterSize(playerid, MDC_Emergency[playerid][i], 0.000000, 4.983743);
				PlayerTextDrawTextSize(playerid, MDC_Emergency[playerid][i], 227.666671, 0.000000);
				PlayerTextDrawAlignment(playerid, MDC_Emergency[playerid][i], 1);
				PlayerTextDrawColor(playerid, MDC_Emergency[playerid][i], 0);
				PlayerTextDrawUseBox(playerid, MDC_Emergency[playerid][i], true);
				PlayerTextDrawBoxColor(playerid, MDC_Emergency[playerid][i], -1);
				PlayerTextDrawSetShadow(playerid, MDC_Emergency[playerid][i], 0);
				PlayerTextDrawSetOutline(playerid, MDC_Emergency[playerid][i], 0);
				PlayerTextDrawFont(playerid, MDC_Emergency[playerid][i], 0);

				current_pos[0] += 49.948135;

				MDC_Emergency[playerid][i + 1] = CreatePlayerTextDraw(playerid, 231.666687, current_pos[1], "Caller:~n~Services:~n~Location:~n~Situation:~n~Time:~n~Status:");
				PlayerTextDrawLetterSize(playerid, MDC_Emergency[playerid][i + 1], 0.168000, 0.799407);
				PlayerTextDrawAlignment(playerid, MDC_Emergency[playerid][i + 1], 1);
				PlayerTextDrawColor(playerid, MDC_Emergency[playerid][i + 1], 858993663);
				PlayerTextDrawSetShadow(playerid, MDC_Emergency[playerid][i + 1], 0);
				PlayerTextDrawSetOutline(playerid, MDC_Emergency[playerid][i + 1], 0);
				PlayerTextDrawBackgroundColor(playerid, MDC_Emergency[playerid][i + 1], 51);
				PlayerTextDrawFont(playerid, MDC_Emergency[playerid][i + 1], 1);
				PlayerTextDrawSetProportional(playerid, MDC_Emergency[playerid][i + 1], 1);

				current_pos[1] += 49.948151;

				MDC_Emergency[playerid][i + 2] = CreatePlayerTextDraw(playerid, 259.666656, current_pos[2], "#~n~Police~n~Las Colinas~n~Two~n~2019-09-10~n~Not handled");
				PlayerTextDrawLetterSize(playerid, MDC_Emergency[playerid][i + 2], 0.168000, 0.799407);
				PlayerTextDrawAlignment(playerid, MDC_Emergency[playerid][i + 2], 1);
				PlayerTextDrawColor(playerid, MDC_Emergency[playerid][i + 2], -1431655681);
				PlayerTextDrawSetShadow(playerid, MDC_Emergency[playerid][i + 2], 0);
				PlayerTextDrawSetOutline(playerid, MDC_Emergency[playerid][i + 2], 0);
				PlayerTextDrawBackgroundColor(playerid, MDC_Emergency[playerid][i + 2], 51);
				PlayerTextDrawFont(playerid, MDC_Emergency[playerid][i + 2], 1);
				PlayerTextDrawSetProportional(playerid, MDC_Emergency[playerid][i + 2], 1);

				current_pos[2] += 50.362961;

				MDC_Emergency[playerid][i + 3] = CreatePlayerTextDraw(playerid, 414.666656, current_pos[3], "HANDLE");
				PlayerTextDrawLetterSize(playerid, MDC_Emergency[playerid][i + 3], 0.150000, 0.769999);
				PlayerTextDrawTextSize(playerid, MDC_Emergency[playerid][i + 3], 6.000000, 30.281471); //95.666694
				PlayerTextDrawAlignment(playerid, MDC_Emergency[playerid][i + 3], 2);
				PlayerTextDrawColor(playerid, MDC_Emergency[playerid][i + 3], -1);
				PlayerTextDrawUseBox(playerid, MDC_Emergency[playerid][i + 3], true);
				PlayerTextDrawBoxColor(playerid, MDC_Emergency[playerid][i + 3], -1440603393);
				PlayerTextDrawSetShadow(playerid, MDC_Emergency[playerid][i + 3], 0);
				PlayerTextDrawSetOutline(playerid, MDC_Emergency[playerid][i + 3], 0);
				PlayerTextDrawBackgroundColor(playerid, MDC_Emergency[playerid][i + 3], 51);
				PlayerTextDrawFont(playerid, MDC_Emergency[playerid][i + 3], 2);
				PlayerTextDrawSetProportional(playerid, MDC_Emergency[playerid][i + 3], 1);
				PlayerTextDrawSetSelectable(playerid, MDC_Emergency[playerid][i + 3], true);

				current_pos[3] += 49.948242;

				MDC_Emergency[playerid][i + 4] = CreatePlayerTextDraw(playerid, 448.666564, current_pos[4], "DETAILS");
				PlayerTextDrawLetterSize(playerid, MDC_Emergency[playerid][i + 4], 0.150000, 0.769999);
				PlayerTextDrawTextSize(playerid, MDC_Emergency[playerid][i + 4], 6.000000, 30.281471); //95.666694
				PlayerTextDrawAlignment(playerid, MDC_Emergency[playerid][i + 4], 2);
				PlayerTextDrawColor(playerid, MDC_Emergency[playerid][i + 4], -1);
				PlayerTextDrawUseBox(playerid, MDC_Emergency[playerid][i + 4], true);
				PlayerTextDrawBoxColor(playerid, MDC_Emergency[playerid][i + 4], 858993663);
				PlayerTextDrawSetShadow(playerid, MDC_Emergency[playerid][i + 4], 0);
				PlayerTextDrawSetOutline(playerid, MDC_Emergency[playerid][i + 4], 0);
				PlayerTextDrawBackgroundColor(playerid, MDC_Emergency[playerid][i + 4], 51);
				PlayerTextDrawFont(playerid, MDC_Emergency[playerid][i + 4], 2);
				PlayerTextDrawSetProportional(playerid, MDC_Emergency[playerid][i + 4], 1);
				PlayerTextDrawSetSelectable(playerid, MDC_Emergency[playerid][i + 4], true);

				current_pos[4] += 49.948242; //50.362992
			}

			MDC_Emergency[playerid][25] = CreatePlayerTextDraw(playerid, 288.333160, 426.429565, "~<~");
			PlayerTextDrawLetterSize(playerid, MDC_Emergency[playerid][25], 0.280999, 0.840888);
			PlayerTextDrawTextSize(playerid, MDC_Emergency[playerid][25], 6.000000, 114.903732);
			PlayerTextDrawAlignment(playerid, MDC_Emergency[playerid][25], 2);
			PlayerTextDrawColor(playerid, MDC_Emergency[playerid][25], -1);
			PlayerTextDrawUseBox(playerid, MDC_Emergency[playerid][25], true);
			PlayerTextDrawBoxColor(playerid, MDC_Emergency[playerid][25], -1431655681);
			PlayerTextDrawSetShadow(playerid, MDC_Emergency[playerid][25], 0);
			PlayerTextDrawSetOutline(playerid, MDC_Emergency[playerid][25], 1);
			PlayerTextDrawBackgroundColor(playerid, MDC_Emergency[playerid][25], 51);
			PlayerTextDrawFont(playerid, MDC_Emergency[playerid][25], 1);
			PlayerTextDrawSetProportional(playerid, MDC_Emergency[playerid][25], 1);
			PlayerTextDrawSetSelectable(playerid, MDC_Emergency[playerid][25], true);

			MDC_Emergency[playerid][26] = CreatePlayerTextDraw(playerid, 406.666381, 426.185272, "~>~");
			PlayerTextDrawLetterSize(playerid, MDC_Emergency[playerid][26], 0.280999, 0.840888);
			PlayerTextDrawTextSize(playerid, MDC_Emergency[playerid][26], 6.000000, 114.903778);
			PlayerTextDrawAlignment(playerid, MDC_Emergency[playerid][26], 2);
			PlayerTextDrawColor(playerid, MDC_Emergency[playerid][26], -1);
			PlayerTextDrawUseBox(playerid, MDC_Emergency[playerid][26], true);
			PlayerTextDrawBoxColor(playerid, MDC_Emergency[playerid][26], -1431655681);
			PlayerTextDrawSetShadow(playerid, MDC_Emergency[playerid][26], 0);
			PlayerTextDrawSetOutline(playerid, MDC_Emergency[playerid][26], 1);
			PlayerTextDrawBackgroundColor(playerid, MDC_Emergency[playerid][26], 51);
			PlayerTextDrawFont(playerid, MDC_Emergency[playerid][26], 1);
			PlayerTextDrawSetProportional(playerid, MDC_Emergency[playerid][26], 1);
			PlayerTextDrawSetSelectable(playerid, MDC_Emergency[playerid][26], true);
		}
	    case 3:
	    {
			//roster UI

			MDC_RosterUI[playerid][0] = CreatePlayerTextDraw(playerid, 230.333297, 174.637039, "List of units on duty");
			PlayerTextDrawLetterSize(playerid, MDC_RosterUI[playerid][0], 0.170999, 0.845035);
			PlayerTextDrawTextSize(playerid, MDC_RosterUI[playerid][0], 369.666687, 38.162956);
			PlayerTextDrawAlignment(playerid, MDC_RosterUI[playerid][0], 1);
			PlayerTextDrawColor(playerid, MDC_RosterUI[playerid][0], -1431655681);
			PlayerTextDrawUseBox(playerid, MDC_RosterUI[playerid][0], true);
			PlayerTextDrawBoxColor(playerid, MDC_RosterUI[playerid][0], 858993663);
			PlayerTextDrawSetShadow(playerid, MDC_RosterUI[playerid][0], 0);
			PlayerTextDrawSetOutline(playerid, MDC_RosterUI[playerid][0], 0);
			PlayerTextDrawBackgroundColor(playerid, MDC_RosterUI[playerid][0], 51);
			PlayerTextDrawFont(playerid, MDC_RosterUI[playerid][0], 1);
			PlayerTextDrawSetProportional(playerid, MDC_RosterUI[playerid][0], 1);

			MDC_RosterUI[playerid][1] = CreatePlayerTextDraw(playerid, 374.333374, 174.637039, "Change_Callsign");
			PlayerTextDrawLetterSize(playerid, MDC_RosterUI[playerid][1], 0.170999, 0.845035);
			PlayerTextDrawTextSize(playerid, MDC_RosterUI[playerid][1], 466.666778, 6.000000);
			PlayerTextDrawAlignment(playerid, MDC_RosterUI[playerid][1], 1);
			PlayerTextDrawColor(playerid, MDC_RosterUI[playerid][1], -1431655681);
			PlayerTextDrawUseBox(playerid, MDC_RosterUI[playerid][1], true);
			PlayerTextDrawBoxColor(playerid, MDC_RosterUI[playerid][1], 858993663);
			PlayerTextDrawSetShadow(playerid, MDC_RosterUI[playerid][1], 0);
			PlayerTextDrawSetOutline(playerid, MDC_RosterUI[playerid][1], 0);
			PlayerTextDrawBackgroundColor(playerid, MDC_RosterUI[playerid][1], 51);
			PlayerTextDrawFont(playerid, MDC_RosterUI[playerid][1], 1);
			PlayerTextDrawSetProportional(playerid, MDC_RosterUI[playerid][1], 1);
			PlayerTextDrawSetSelectable(playerid, MDC_RosterUI[playerid][1], true);

			MDC_RosterUI[playerid][2] = CreatePlayerTextDraw(playerid, 374.333282, 186.837039, "filter_units_...");
			PlayerTextDrawLetterSize(playerid, MDC_RosterUI[playerid][2], 0.170999, 0.845035);
			PlayerTextDrawTextSize(playerid, MDC_RosterUI[playerid][2], 466.666778, 6.000000);
			PlayerTextDrawAlignment(playerid, MDC_RosterUI[playerid][2], 1);
			PlayerTextDrawColor(playerid, MDC_RosterUI[playerid][2], -1431655681);
			PlayerTextDrawUseBox(playerid, MDC_RosterUI[playerid][2], true);
			PlayerTextDrawBoxColor(playerid, MDC_RosterUI[playerid][2], -1);
			PlayerTextDrawSetShadow(playerid, MDC_RosterUI[playerid][2], 0);
			PlayerTextDrawSetOutline(playerid, MDC_RosterUI[playerid][2], 0);
			PlayerTextDrawBackgroundColor(playerid, MDC_RosterUI[playerid][2], 51);
			PlayerTextDrawFont(playerid, MDC_RosterUI[playerid][2], 1);
			PlayerTextDrawSetProportional(playerid, MDC_RosterUI[playerid][2], 1);
			PlayerTextDrawSetSelectable(playerid, MDC_RosterUI[playerid][2], true);

			MDC_RosterUI[playerid][3] = CreatePlayerTextDraw(playerid, 374.333312, 199.037039, "View unit templates");
			PlayerTextDrawLetterSize(playerid, MDC_RosterUI[playerid][3], 0.170999, 0.845035);
			PlayerTextDrawTextSize(playerid, MDC_RosterUI[playerid][3], 466.666778, 6.000000);
			PlayerTextDrawAlignment(playerid, MDC_RosterUI[playerid][3], 1);
			PlayerTextDrawColor(playerid, MDC_RosterUI[playerid][3], -1431655681);
			PlayerTextDrawUseBox(playerid, MDC_RosterUI[playerid][3], true);
			PlayerTextDrawBoxColor(playerid, MDC_RosterUI[playerid][3], 858993663);
			PlayerTextDrawSetShadow(playerid, MDC_RosterUI[playerid][3], 0);
			PlayerTextDrawSetOutline(playerid, MDC_RosterUI[playerid][3], 0);
			PlayerTextDrawBackgroundColor(playerid, MDC_RosterUI[playerid][3], 51);
			PlayerTextDrawFont(playerid, MDC_RosterUI[playerid][3], 1);
			PlayerTextDrawSetProportional(playerid, MDC_RosterUI[playerid][3], 1);
			PlayerTextDrawSetSelectable(playerid, MDC_RosterUI[playerid][3], true);

			current_y = 186.837039;

		    for(new i = 4; i < 24; ++i)
		    {
				MDC_RosterUI[playerid][i] = CreatePlayerTextDraw(playerid, 230.333374, current_y, "_");
				PlayerTextDrawLetterSize(playerid, MDC_RosterUI[playerid][i], 0.170666, 0.845035);
				PlayerTextDrawTextSize(playerid, MDC_RosterUI[playerid][i], 369.666687, 6.000000);
				PlayerTextDrawAlignment(playerid, MDC_RosterUI[playerid][i], 1);
				PlayerTextDrawColor(playerid, MDC_RosterUI[playerid][i], 1128547071);
				PlayerTextDrawUseBox(playerid, MDC_RosterUI[playerid][i], true);
				PlayerTextDrawBoxColor(playerid, MDC_RosterUI[playerid][i], -1431655681);
				PlayerTextDrawSetShadow(playerid, MDC_RosterUI[playerid][i], 0);
				PlayerTextDrawSetOutline(playerid, MDC_RosterUI[playerid][i], 0);
				PlayerTextDrawBackgroundColor(playerid, MDC_RosterUI[playerid][i], 51);
				PlayerTextDrawFont(playerid, MDC_RosterUI[playerid][i], 1);
				PlayerTextDrawSetProportional(playerid, MDC_RosterUI[playerid][i], 0);
				PlayerTextDrawSetSelectable(playerid, MDC_RosterUI[playerid][i], true);

				current_y += 12.200000;
		    }
		}
		case 4:
		{
		    //CCTV
		}
		case 5:
		{
			//Vehicle BOLO
			MDC_VehicleBOLO[playerid][0] = CreatePlayerTextDraw(playerid, 374.666625, 175.066696, "Add Vehicle BOLO");
			PlayerTextDrawLetterSize(playerid, MDC_VehicleBOLO[playerid][0], 0.170000, 0.724740);
			PlayerTextDrawTextSize(playerid, MDC_VehicleBOLO[playerid][0], 466.000000, 5.000000);
			PlayerTextDrawAlignment(playerid, MDC_VehicleBOLO[playerid][0], 1);
			PlayerTextDrawColor(playerid, MDC_VehicleBOLO[playerid][0], -1431655681);
			PlayerTextDrawUseBox(playerid, MDC_VehicleBOLO[playerid][0], 1);
			PlayerTextDrawBoxColor(playerid, MDC_VehicleBOLO[playerid][0], 858993663);
			PlayerTextDrawSetShadow(playerid, MDC_VehicleBOLO[playerid][0], 0);
			PlayerTextDrawBackgroundColor(playerid, MDC_VehicleBOLO[playerid][0], 255);
			PlayerTextDrawFont(playerid, MDC_VehicleBOLO[playerid][0], 1);
			PlayerTextDrawSetProportional(playerid, MDC_VehicleBOLO[playerid][0], 1);
			PlayerTextDrawSetSelectable(playerid, MDC_VehicleBOLO[playerid][0], true);

		    current_y = 187.096328;

			for(new i = 1; i < 11; ++i)
			{
				MDC_VehicleBOLO[playerid][i] = CreatePlayerTextDraw(playerid, 230.666656, current_y, "White Alpha, 1BCB041");
				PlayerTextDrawLetterSize(playerid, MDC_VehicleBOLO[playerid][i], 0.170000, 0.724740);
				PlayerTextDrawTextSize(playerid, MDC_VehicleBOLO[playerid][i], 439.000000, 5.000000);
				PlayerTextDrawAlignment(playerid, MDC_VehicleBOLO[playerid][i], 1);
				PlayerTextDrawColor(playerid, MDC_VehicleBOLO[playerid][i], -1);
				PlayerTextDrawUseBox(playerid, MDC_VehicleBOLO[playerid][i], 1);
				PlayerTextDrawBoxColor(playerid, MDC_VehicleBOLO[playerid][i], 186668031);
				PlayerTextDrawSetShadow(playerid, MDC_VehicleBOLO[playerid][i], 0);
				PlayerTextDrawBackgroundColor(playerid, MDC_VehicleBOLO[playerid][i], 255);
				PlayerTextDrawFont(playerid, MDC_VehicleBOLO[playerid][i], 1);
				PlayerTextDrawSetProportional(playerid, MDC_VehicleBOLO[playerid][i], 1);
		        PlayerTextDrawSetSelectable(playerid, MDC_VehicleBOLO[playerid][i], true);

				current_y += 11.199997;
			}
		}
	}
	
	MDC_Created{playerid} = true;
	return true;
}

TogglePlayerMDC(playerid, bool:Toggle, bool:Save = false)
{
    new cached_page = GetPVarInt(playerid, "LastPage_ID");

	if(Toggle)
	{
	    new menu_shown = 6;
	    
	    if(cached_page <= 0)
		{
			cached_page = 0;
			
			SetPVarInt(playerid, "LastPage_ID", 0);

			//resetting the buttons
		    PlayerTextDrawColor(playerid, MDC_UI[playerid][19], -1431655681);
		    PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][19], 858993663);

		    PlayerTextDrawColor(playerid, MDC_MenuUI[playerid][0], -1431655681);
		    PlayerTextDrawBoxColor(playerid, MDC_MenuUI[playerid][0], 858993663);
		}
		else
		{
  			PlayerTextDrawColor(playerid, MDC_MenuUI[playerid][cached_page], -1431655681);
    		PlayerTextDrawBoxColor(playerid, MDC_MenuUI[playerid][cached_page], 858993663);
		}

        UsingMDC{playerid} = true;
        
		if(e_Player_MDC_Cache[playerid][faction_type] == FACTION_MEDIC) menu_shown = 3;

		for(new i; i < 10; i ++)
		{
			PlayerTextDrawShow(playerid, MDC_UI[playerid][i]);
			
			if(i < menu_shown) PlayerTextDrawShow(playerid, MDC_MenuUI[playerid][i]);
		}

		if(cached_page != 0)
		{
		    MDC_CreatePage(playerid, cached_page);
		}

        MDC_ShowPage(playerid, cached_page);
        
        if(cached_page != 1)
		{
			UpdatePlayerMDC(playerid, cached_page, -1);
		}
	}
	else
	{
	    for(new i = 0; i < 39; i ++)
		{
		    PlayerTextDrawHide(playerid, MDC_UI[playerid][i]);
		
		    if(i < 6) PlayerTextDrawHide(playerid, MDC_MenuUI[playerid][i]);
		    
		    if(i < 4) PlayerTextDrawHide(playerid, MDC_VehicleUI[playerid][i]);
		}
		
		if(cached_page) MDC_DestroyPage(playerid, cached_page);

	    if(!Save)
	    {
		    PlayerTextDrawColor(playerid, MDC_UI[playerid][20], 858993663);
		    PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][20], -1431655681);

			for(new x = 0; x < 6; x ++)
			{
			    PlayerTextDrawColor(playerid, MDC_MenuUI[playerid][x], 858993663);
			    PlayerTextDrawBoxColor(playerid, MDC_MenuUI[playerid][x], -1431655681);
			}

			//resetting the buttons
		    PlayerTextDrawColor(playerid, MDC_UI[playerid][19], -1431655681);
		    PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][19], 858993663);

		    PlayerTextDrawColor(playerid, MDC_MenuUI[playerid][0], -1431655681);
		    PlayerTextDrawBoxColor(playerid, MDC_MenuUI[playerid][0], 858993663);

		    SetPVarInt(playerid, "Query_Mode", 0);
		    SetPVarInt(playerid, "LastPage_ID", 0);

		    ResetMDCData(playerid);
		}

        UsingMDC{playerid} = false;
	}
	return true;
}

stock MDC_OnRecordSearch(playerid)
{
	new
		dbid = ReturnDBIDFromName(e_Player_MDC_Cache[playerid][player_name])
	;

	if(!dbid)
	{
        e_Player_MDC_Cache[playerid][player_dbid] = -1;
        e_Player_MDC_Cache[playerid][current_page] = 0;
        
        DeletePVar(playerid, "MDC_ViewingProfile");
        
		return PlayerTextDrawShow(playerid, MDC_VehicleUI[playerid][3]);
	}

	e_Player_MDC_Cache[playerid][player_dbid] = dbid;
	e_Player_MDC_Cache[playerid][current_page] = 1;
	
	MDC_GatherInformation(playerid, dbid, 1);
	return true;
}

stock MDC_GatherInformation(playerid, dbid, type)
{
	new
		query[255]
	;

	switch(type)
	{
	    case 1:
	    {
			mysql_format(dbCon, query, sizeof(query), "SELECT ID, Jailed, Incarcerated, PrisonSkin, PhoneNumbr, ActiveListings, PrisonTimes, JailTimes, CarLic, WepLic, FlyLic, MedLic FROM characters WHERE ID = %i", e_Player_MDC_Cache[playerid][player_dbid]);
			mysql_tquery(dbCon, query, "MDC_OnNameFound", "ii", playerid, dbid);
		}
		case 2:
		{
			mysql_format(dbCon, query, sizeof(query), "SELECT carModel, carName, carColor1, carColor2, carOwner, carPlate, carInsurance FROM cars WHERE carID = %d", e_Player_MDC_Cache[playerid][vehicle_dbid]);
			mysql_tquery(dbCon, query, "MDC_OnPlateFound", "iii", playerid, dbid, true);
		}
		case 3:
		{
			mysql_format(dbCon, query, sizeof(query), "SELECT carID, carModel, carName, carColor1, carColor2, carOwner, carPlate, carInsurance FROM cars WHERE carPlate = '%e'", e_Player_MDC_Cache[playerid][vehicle_plate]);
			mysql_tquery(dbCon, query, "MDC_OnPlateFound", "iii", playerid, -1, false);
		}
	}

	return true;
}

MDC_ChangeProfilePage(playerid, page, lastpage, extraid = -1)
{
	if(!MDC_Created{playerid} || ActiveQuery{playerid})
		return SendErrorMessage(playerid, "Not so fast mister fast fingers, you're clicking too fast!");

	new
		query[255]
	;

    e_Player_MDC_Cache[playerid][current_page] = page;

    ActiveQuery{playerid} = true;

	switch(page)
	{
	    case 1:
		{
		    if(lastpage != -1)
		    {
			    switch(lastpage)
			    {
			        case 2:
			        {
			            PlayerTextDrawHide(playerid, MDC_UI[playerid][38]);

						for(new i = 0; i < 41; i ++)
							PlayerTextDrawDestroy(playerid, MDC_ChargesUI[playerid][i]);
			        }
			        case 4:
			        {
			            PlayerTextDrawHide(playerid, MDC_UI[playerid][38]);

					    for(new i = 0; i < 37; i ++)
							PlayerTextDrawDestroy(playerid, MDC_LicensesUI[playerid][i]);
			        }
			        case 5:
			        {
			            PlayerTextDrawHide(playerid, MDC_UI[playerid][38]);

		                for(new i = 0; i < 40; i ++)
		            		PlayerTextDrawDestroy(playerid, MDC_PenalCodeUI[playerid][i]);
			        }
			        case 6:
			        {
			            PlayerTextDrawHide(playerid, MDC_UI[playerid][38]);

		                for(new i = 0; i < 20; i ++)
		            		PlayerTextDrawDestroy(playerid, MDC_PropertiesUI[playerid][i]);
			        }
			    }
			}

			MDC_GatherInformation(playerid, e_Player_MDC_Cache[playerid][player_dbid], 1);
		}
	    case 2:
	    {
		    if(lastpage != -1)
		    {
			    switch(lastpage)
			    {
			        case 1:
			        {
						for(new i = 18; i < sizeof(MDC_UI[]); i ++)
							PlayerTextDrawHide(playerid, MDC_UI[playerid][i]);
			        }
			        case 3:
			        {
						for(new i = 25; i < sizeof(MDC_ChargesUI[]); i ++)
						{
							PlayerTextDrawHide(playerid, MDC_ChargesUI[playerid][i]);
						}
					}
				}
			}

			if(lastpage == -1 || lastpage == 1)
			{
			    MDC_CreateChargesUI(playerid);
			}

			mysql_format(dbCon, query, sizeof(query), "SELECT idx, charge_quote, charge_type, add_date FROM criminal_record WHERE player_name = '%e' OR player_name = '%e' ORDER BY idx DESC LIMIT 23", e_Player_MDC_Cache[playerid][player_name], UnFormatName(e_Player_MDC_Cache[playerid][player_name]));
			mysql_tquery(dbCon, query, "MDC_ViewCriminalRecord", "i", playerid);
	    }
	    case 3:
	    {
	        if(lastpage == -1)
	        {
	            MDC_CreateChargesUI(playerid);
	        }
	        else if(lastpage == 2)
	        {
				for(new i = 0; i < 25; i ++)
					PlayerTextDrawHide(playerid, MDC_ChargesUI[playerid][i]);
			}
				
			if(extraid == -1) extraid = GetPVarInt(playerid, "ViewingCharge");

			mysql_format(dbCon, query, sizeof(query), "SELECT idx, charge_type, player_name, issuer_name, add_date, add_time, charge_quote, charges_count, arrest_record FROM criminal_record WHERE idx = %d", extraid);
			mysql_tquery(dbCon, query, "MDC_ViewChargeDetails", "ii", playerid, extraid);
	    }
	    case 4:
	    {
		    if(lastpage != -1)
		    {
			    switch(lastpage)
			    {
			        case 1:
			        {
						for(new i = 18; i < sizeof(MDC_UI[]); i ++)
							PlayerTextDrawHide(playerid, MDC_UI[playerid][i]);
			        }
				}
			}
			
			if(lastpage != 4)
			{
				MDC_CreateLicensesTD(playerid);
			}

			mysql_format(dbCon, query, sizeof(query), "SELECT CarLic, CarLicWarns, CarLicSuspended, WepLic, FlyLic, MedLic, TruckLic FROM characters WHERE ID = %d", e_Player_MDC_Cache[playerid][player_dbid]);
			mysql_tquery(dbCon, query, "MDC_ViewLicenses", "i", playerid);
	    }
	    case 5:
	    {
		    if(lastpage != -1)
		    {
			    switch(lastpage)
			    {
			        case 1:
			        {
						for(new i = 18; i < sizeof(MDC_UI[]); i ++)
							PlayerTextDrawHide(playerid, MDC_UI[playerid][i]);
			        }
				}
			}
			
			MDC_CreatePenalCodeTD(playerid);

			ShowPenalCodeUI(playerid);
	    }
	    case 6:
	    {
		    if(lastpage != -1)
		    {
			    switch(lastpage)
			    {
			        case 1:
			        {
						for(new i = 18; i < sizeof(MDC_UI[]); i ++)
							PlayerTextDrawHide(playerid, MDC_UI[playerid][i]);
			        }
				}
			}
			
			MDC_CreatePropertiesTD(playerid);

			mysql_format(dbCon, query, sizeof(query), "SELECT `id`, `posx`, `posy` FROM `houses` WHERE `owner` = '%e' OR `owner` = '%e' LIMIT 16", e_Player_MDC_Cache[playerid][player_name], UnFormatName(e_Player_MDC_Cache[playerid][player_name]));
			mysql_tquery(dbCon, query, "MDC_ViewProperties", "iii", playerid, 0, 0);
	    }
	}

	return true;
}

stock MDCSelectCharge(playerid, id)
{
	ClickedCrime[playerid][0] = FoundCrime[playerid][id][0];
	ClickedCrime[playerid][1] = FoundCrime[playerid][id][1];

	new
	    string[400],
	    idx = ClickedCrime[playerid][0],
		crime = ClickedCrime[playerid][1]
	;

	switch(penal_code[idx][crime][crime_type])
	{
	    case 0: format(string, sizeof(string), "~l~(%d)%02d. %s is a ~y~misdemeanor ~l~punishable by %d minutes of jail time", idx + 1, crime + 1, penal_code[idx][crime][crime_name], penal_code[idx][crime][jail_time]);
	    case 1: format(string, sizeof(string), "~l~(%d)%02d. %s is a ~r~felony ~l~punishable by %d minutes of jail time", idx + 1, crime + 1, penal_code[idx][crime][crime_name], penal_code[idx][crime][jail_time]);
	    case 2: format(string, sizeof(string), "~l~(%d)%02d. %s is a ~g~infraction ~l~punishable by 0 min. and a ~g~%s ~l~fine", idx + 1, crime + 1, penal_code[idx][crime][crime_name], FormatNumber(penal_code[idx][crime][jail_time]));
	}

	PlayerTextDrawSetString(playerid, MDC_PenalCodeUI[playerid][23], string);
	
	format(string, sizeof(string), "1. %s~n~~>~ For more info check full PC", penal_code[idx][crime][crime_description]);
	PlayerTextDrawSetString(playerid, MDC_PenalCodeUI[playerid][24], string);

	PlayerTextDrawShow(playerid, MDC_PenalCodeUI[playerid][23]);
	PlayerTextDrawShow(playerid, MDC_PenalCodeUI[playerid][24]);

	PlayerTextDrawShow(playerid, MDC_PenalCodeUI[playerid][34]);
	PlayerTextDrawShow(playerid, MDC_PenalCodeUI[playerid][35]);
	PlayerTextDrawShow(playerid, MDC_PenalCodeUI[playerid][36]);
	PlayerTextDrawShow(playerid, MDC_PenalCodeUI[playerid][37]);
	PlayerTextDrawShow(playerid, MDC_PenalCodeUI[playerid][38]);
	PlayerTextDrawShow(playerid, MDC_PenalCodeUI[playerid][39]);
	return true;
}

stock InsertCriminalRecord(playerid, playerb, type, quote[], charges)
{
	new query[300 + 2000];
	new month, day, year; getdate(year, month, day);
	new hour, minute, second; gettime(hour, minute, second);

	GetPVarString(playerb, "ArrestRecord", query, sizeof(query));

	mysql_format(dbCon, query, sizeof(query), "INSERT INTO criminal_record (userid, player_name, issuer_name, charge_quote, charges_count, charge_type, add_date, add_time, arrest_record) VALUES(%d, '%e', '%e', '%e', %d, %d, '%d-%02d-%02d', '%02d:%02d:%02d', '%e')",
	PlayerData[playerid][pID], ReturnName(playerb), ReturnName(playerid, 0), quote, charges, type, year, month, day, hour, minute, second, query);
	mysql_tquery(dbCon, query);

	DeletePVar(playerb, "ArrestRecord");
}

stock MDCProccessCharges(playerid)
{
	new
	    count = 0,
	    time_sum,
		query[320],
		description[200],
		suspect[MAX_PLAYER_NAME],
		playerb = e_Player_MDC_Cache[playerid][player_dbid]
	;

	new month, day, year; getdate(year, month, day);
	new hour, minute, second; gettime(hour, minute, second);

	format(suspect, MAX_PLAYER_NAME, ReturnDBIDName(playerb));

	for(new i = 0; i < 5; ++i)
	{
	    if(ChargesSelected[playerid][i][0] != -1)
	    {
	 		time_sum += penal_code[ChargesSelected[playerid][i][0]][ChargesSelected[playerid][i][1]][jail_time];

			format(description, sizeof(description), "(%d)%02d. %s", ChargesSelected[playerid][i][0] + 1, ChargesSelected[playerid][i][1] + 1, penal_code[ChargesSelected[playerid][i][0]][ChargesSelected[playerid][i][1]][crime_name]);

			mysql_format(dbCon, query, sizeof(query), "INSERT INTO criminal_record (player_name, issuer_name, charge_quote, charge_type, charge_idx, charge_row, add_date, add_time) VALUES('%e', '%e', '%e', %d, %d, %d, '%d-%02d-%02d', '%02d:%02d:%02d')",
				suspect,
				ReturnName(playerid, 0),
				description,
				CHARGE_TYPE_NORMAL,
				ChargesSelected[playerid][i][0],
				ChargesSelected[playerid][i][1],
				year, month, day, hour, minute, second
			);

			mysql_tquery(dbCon, query);

	 		count++;
		}
	}

	if(!count) return SendErrorMessage(playerid, "No charges were selected.");

    SendPoliceMessage(COLOR_POLICE, "** %s pressed %d %s, summing up to %d minutes of jail time against %s.", ReturnName(playerid, 0), count, NeedAnS("charge", count), time_sum, FormatName(e_Player_MDC_Cache[playerid][player_name]));

    MDCClearCharges(playerid);

	mysql_format(dbCon, query, sizeof(query), "UPDATE `characters` SET `ActiveListings` = `ActiveListings` + %d WHERE `ID` = '%i'", count, playerb);
	mysql_pquery(dbCon, query);
	return true;
}

stock MDCClearCharges(playerid)
{
	PlayerTextDrawHide(playerid, MDC_PenalCodeUI[playerid][26]);

	for(new i = 0; i < 5; ++i)
	{
	    PlayerTextDrawHide(playerid, MDC_PenalCodeUI[playerid][i + 27]);
	    
 		ChargesSelected[playerid][i][0] = -1;
 		ChargesSelected[playerid][i][1] = -1;
	}

	PlayerTextDrawHide(playerid, MDC_PenalCodeUI[playerid][32]);
	PlayerTextDrawHide(playerid, MDC_PenalCodeUI[playerid][33]);
	return true;
}

stock MDCAddCharge(playerid, idx, crime)
{
	new
		count = 0,
		string[256],
		Float:current_y = 329.777801
	;

	for(new i = 0; i < 5; ++i)
	{
	    if(ChargesSelected[playerid][i][0] == -1)
	    {
	        ChargesSelected[playerid][i][0] = idx;
	        ChargesSelected[playerid][i][1] = crime;

	        count++;

	        current_y += 12.029648; //12.029754
	        break;
	    }
	    else
		{
			count++;

			current_y += 12.029648; //11.614777
		}
	}

	if(strlen(penal_code[idx][crime][crime_name]) > 30)
		format(string, sizeof(string), "~p~~h~X ~l~(%d)%02d. %.30s ...", idx + 1, crime + 1, penal_code[idx][crime][crime_name]);
	else
	    format(string, sizeof(string), "~p~~h~X ~l~(%d)%02d. %s", idx + 1, crime + 1, penal_code[idx][crime][crime_name]);

	PlayerTextDrawSetString(playerid, MDC_PenalCodeUI[playerid][count + 26], string);

	PlayerTextDrawDestroy(playerid, MDC_PenalCodeUI[playerid][32]);
	PlayerTextDrawDestroy(playerid, MDC_PenalCodeUI[playerid][33]);

	MDC_PenalCodeUI[playerid][32] = CreatePlayerTextDraw(playerid, 334.333374, current_y, "~>~ Clear");
	PlayerTextDrawLetterSize(playerid, MDC_PenalCodeUI[playerid][32], 0.170329, 0.832589);
	PlayerTextDrawTextSize(playerid, MDC_PenalCodeUI[playerid][32], 395.666687, 6.000000);
	PlayerTextDrawAlignment(playerid, MDC_PenalCodeUI[playerid][32], 1);
	PlayerTextDrawColor(playerid, MDC_PenalCodeUI[playerid][32], -1);
	PlayerTextDrawUseBox(playerid, MDC_PenalCodeUI[playerid][32], true);
	PlayerTextDrawBoxColor(playerid, MDC_PenalCodeUI[playerid][32], 858993663);
	PlayerTextDrawSetShadow(playerid, MDC_PenalCodeUI[playerid][32], 0);
	PlayerTextDrawSetOutline(playerid, MDC_PenalCodeUI[playerid][32], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_PenalCodeUI[playerid][32], 51);
	PlayerTextDrawFont(playerid, MDC_PenalCodeUI[playerid][32], 1);
	PlayerTextDrawSetProportional(playerid, MDC_PenalCodeUI[playerid][32], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_PenalCodeUI[playerid][32], true);

	MDC_PenalCodeUI[playerid][33] = CreatePlayerTextDraw(playerid, 399.333343, current_y, "~>~ Press Charges");
	PlayerTextDrawLetterSize(playerid, MDC_PenalCodeUI[playerid][33], 0.170329, 0.832589);
	PlayerTextDrawTextSize(playerid, MDC_PenalCodeUI[playerid][33], 465.000000, 6.000000);
	PlayerTextDrawAlignment(playerid, MDC_PenalCodeUI[playerid][33], 1);
	PlayerTextDrawColor(playerid, MDC_PenalCodeUI[playerid][33], -1);
	PlayerTextDrawUseBox(playerid, MDC_PenalCodeUI[playerid][33], true);
	PlayerTextDrawBoxColor(playerid, MDC_PenalCodeUI[playerid][33], -1440603393);
	PlayerTextDrawSetShadow(playerid, MDC_PenalCodeUI[playerid][33], 0);
	PlayerTextDrawSetOutline(playerid, MDC_PenalCodeUI[playerid][33], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_PenalCodeUI[playerid][33], 51);
	PlayerTextDrawFont(playerid, MDC_PenalCodeUI[playerid][33], 1);
	PlayerTextDrawSetProportional(playerid, MDC_PenalCodeUI[playerid][33], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_PenalCodeUI[playerid][33], true);

	PlayerTextDrawShow(playerid, MDC_PenalCodeUI[playerid][26]);
	PlayerTextDrawShow(playerid, MDC_PenalCodeUI[playerid][count + 26]);
	PlayerTextDrawShow(playerid, MDC_PenalCodeUI[playerid][32]);
	PlayerTextDrawShow(playerid, MDC_PenalCodeUI[playerid][33]);
	return true;
}

stock MDCFilterCharges(playerid, const filter[])
{
	for(new i = 0; i < 21; ++i)
		PlayerTextDrawHide(playerid, MDC_PenalCodeUI[playerid][i]);

	new
	    count = 0,
	    string[180],
		wasfound = -1
	;

	for(new i = 0; i < PENAL_CODE_TILES; ++i)
	{
	    if(count == 20) break;

	    if(IsPenalCodeActive(i))
	    {
	        count++;

	        wasfound = count;

	        for(new x = 0; x < PenalCodeMaxCrimes(i); ++x)
	        {
				if(count == 20) break;

	            if(strfind(penal_code[i][x][crime_name], filter, true) != -1)
	            {
			        PlayerTextDrawColor(playerid, MDC_PenalCodeUI[playerid][count], -1431655681);
			        PlayerTextDrawBoxColor(playerid, MDC_PenalCodeUI[playerid][count], -1);

			        format(string, sizeof(string), "(%d)%02d. %s", i + 1, x + 1, penal_code[i][x][crime_name]);
			        if(strlen(string) > 33) format(string, sizeof(string), "%.29s ...", string);

			        PlayerTextDrawSetString(playerid, MDC_PenalCodeUI[playerid][count], string);

			        FoundCrime[playerid][count][0] = i;
			        FoundCrime[playerid][count][1] = x;

			        //SendClientMessageEx(playerid, -1, "found crime %d|%s", x, penal_code[i][x][crime_name]);

			        count++;
				}
	        }

	        if(wasfound != count)
	        {
		        PlayerTextDrawColor(playerid, MDC_PenalCodeUI[playerid][wasfound - 1], -1);
		        PlayerTextDrawBoxColor(playerid, MDC_PenalCodeUI[playerid][wasfound - 1], 858993663);

		        format(string, sizeof(string), "%d.%s", i + 1, ReturnPenalCodeName(i));
		        if(strlen(string) > 33) format(string, sizeof(string), "%.29s ...", string);

		        PlayerTextDrawSetString(playerid, MDC_PenalCodeUI[playerid][wasfound - 1], string);
		        //SendClientMessageEx(playerid, -1, "found tile %d|%s", i, ReturnPenalCodeName(i));

		        FoundCrime[playerid][wasfound - 1][0] = -1;
	        }
	        else count--;
	    }
	}

	if(count == 0)
	{
 		PlayerTextDrawColor(playerid, MDC_PenalCodeUI[playerid][0], -1);
 		PlayerTextDrawBoxColor(playerid, MDC_PenalCodeUI[playerid][0], 858993663);
 		PlayerTextDrawSetString(playerid, MDC_PenalCodeUI[playerid][0], "No results found!");
 		PlayerTextDrawShow(playerid, MDC_PenalCodeUI[playerid][0]);
	    return true;
	}
	else if(count == 20)
	{
  		PlayerTextDrawBoxColor(playerid, MDC_PenalCodeUI[playerid][20], 858993663);
  		PlayerTextDrawSetString(playerid, MDC_PenalCodeUI[playerid][20], "___________________~d~");

  		FoundCrime[playerid][20][0] = -1;

  		count++;
	}

	for(new p = 0; p < count; p++)
		PlayerTextDrawShow(playerid, MDC_PenalCodeUI[playerid][p]);

	return true;
}

stock ShowPenalCodeUI(playerid, bool:advance_page = false, bool:hide = false, bool:last_page = false)
{
    ActiveQuery{playerid} = false;

	if(hide)
	{
		for(new i = 0; i < 21; ++i)
			PlayerTextDrawHide(playerid, MDC_PenalCodeUI[playerid][i]);
	}

	if(strlen(FilterCharges[playerid]) > 0)
	{
	    MDCFilterCharges(playerid, FilterCharges[playerid]);
	}
	else
	{
	    new
	        count = 0,
	        string[256]
		;

		if(advance_page) //Go to next page
		{
		    new
				index[2]
			;

			index[0] = PenalCodeIndex[playerid][0];
			index[1] = PenalCodeIndex[playerid][1];
			
			PenalCodePage[playerid]++;
			
			CacheThisPage(playerid);

			for(new i = index[0]; i < PENAL_CODE_TILES; ++i)
			{
			    if(count == 20) break;
			    
				if(count == 0 && i != 0)
				{
					PlayerTextDrawBoxColor(playerid, MDC_PenalCodeUI[playerid][0], 858993663);
					PlayerTextDrawSetString(playerid, MDC_PenalCodeUI[playerid][0], "___________________~u~");

					FoundCrime[playerid][0][0] = 500;

					count++;
				}

			    if(IsPenalCodeActive(i))
			    {
			        if(index[1] == 0)
			        {
			            if(count != 0)
			            {
							PlayerTextDrawColor(playerid, MDC_PenalCodeUI[playerid][count], -1);
						    PlayerTextDrawBoxColor(playerid, MDC_PenalCodeUI[playerid][count], 858993663);

						    format(string, sizeof(string), "%d.%s", i + 1, ReturnPenalCodeName(i));
						    if(strlen(string) > 33) format(string, sizeof(string), "%.29s ...", string);

						    PlayerTextDrawSetString(playerid, MDC_PenalCodeUI[playerid][count], string);

						    FoundCrime[playerid][count][0] = -1;

						    count++;
						}
					}

					PenalCodeIndex[playerid][0] = i;

					new maxcrimes = PenalCodeMaxCrimes(i);

			        for(new x = index[1]; x < maxcrimes; ++x)
			        {
			            if(count == 20) break;

				        PlayerTextDrawColor(playerid, MDC_PenalCodeUI[playerid][count], -1431655681);
				        PlayerTextDrawBoxColor(playerid, MDC_PenalCodeUI[playerid][count], -1);

				        format(string, sizeof(string), "(%d)%02d. %s", i + 1, x + 1, penal_code[i][x][crime_name]);
				        if(strlen(string) > 33) format(string, sizeof(string), "%.29s ...", string);

				        PlayerTextDrawSetString(playerid, MDC_PenalCodeUI[playerid][count], string);

				        if(x + 1 < maxcrimes) PenalCodeIndex[playerid][1] = x + 1;
				        else
						{
						    PenalCodeIndex[playerid][0] = i + 1;
							PenalCodeIndex[playerid][1] = 0;
						}

				        FoundCrime[playerid][count][0] = i;
				        FoundCrime[playerid][count][1] = x;

				        count++;
			        }

			        index[1] = 0;
			    }
			}
		}
		else
		{
			if(last_page) //Go to last page
			{
			    new
					index[2]
				;
				
				PenalCodePage[playerid]--;
				
				new page = PenalCodePage[playerid];
				
				index[0] = CachedPages[playerid][page][0];
				index[1] = CachedPages[playerid][page][1];

				for(new i = index[0]; i < PENAL_CODE_TILES; ++i)
				{
				    if(count == 20) break;
				    
				    if(count == 0 && i != 0)
				    {
						PlayerTextDrawBoxColor(playerid, MDC_PenalCodeUI[playerid][0], 858993663);
						PlayerTextDrawSetString(playerid, MDC_PenalCodeUI[playerid][0], "___________________~u~");

						FoundCrime[playerid][0][0] = 500;
						
						count++;
				    }

				    if(IsPenalCodeActive(i))
				    {
				        if( (index[1] == 0 && count != 0) || page == 0 )
				        {
							PlayerTextDrawColor(playerid, MDC_PenalCodeUI[playerid][count], -1);
							PlayerTextDrawBoxColor(playerid, MDC_PenalCodeUI[playerid][count], 858993663);

							format(string, sizeof(string), "%d.%s", i + 1, ReturnPenalCodeName(i));
							if(strlen(string) > 33) format(string, sizeof(string), "%.29s ...", string);

							PlayerTextDrawSetString(playerid, MDC_PenalCodeUI[playerid][count], string);

							FoundCrime[playerid][count][0] = -1;

							count++;
						}

						PenalCodeIndex[playerid][0] = i;

						new maxcrimes = PenalCodeMaxCrimes(i);

				        for(new x = index[1]; x < maxcrimes; ++x)
				        {
				            if(count == 20) break;

					        PlayerTextDrawColor(playerid, MDC_PenalCodeUI[playerid][count], -1431655681);
					        PlayerTextDrawBoxColor(playerid, MDC_PenalCodeUI[playerid][count], -1);

					        format(string, sizeof(string), "(%d)%02d. %s", i + 1, x + 1, penal_code[i][x][crime_name]);
					        if(strlen(string) > 33) format(string, sizeof(string), "%.29s ...", string);

					        PlayerTextDrawSetString(playerid, MDC_PenalCodeUI[playerid][count], string);

					        if(x + 1 < maxcrimes) PenalCodeIndex[playerid][1] = x + 1;
					        else
							{
							    PenalCodeIndex[playerid][0] = i + 1;
								PenalCodeIndex[playerid][1] = 0;
							}

					        FoundCrime[playerid][count][0] = i;
					        FoundCrime[playerid][count][1] = x;

					        count++;
				        }

				        index[1] = 0;
				    }
				}
			}
			else //First Page
			{
			    PenalCodePage[playerid] = 0;
			    
			    PenalCodeIndex[playerid][0] = 0;
			    PenalCodeIndex[playerid][1] = 0;
			    
			    CacheThisPage(playerid);
			
				for(new i = 0; i < PENAL_CODE_TILES; ++i)
				{
				    if(count == 20) break;

				    if(IsPenalCodeActive(i))
				    {
				        PlayerTextDrawColor(playerid, MDC_PenalCodeUI[playerid][count], -1);
				        PlayerTextDrawBoxColor(playerid, MDC_PenalCodeUI[playerid][count], 858993663);

				        format(string, sizeof(string), "%d.%s", i + 1, ReturnPenalCodeName(i));
				        if(strlen(string) > 33) format(string, sizeof(string), "%.29s ...", string);

				        PlayerTextDrawSetString(playerid, MDC_PenalCodeUI[playerid][count], string);

				        FoundCrime[playerid][count][0] = -1;
				        PenalCodeIndex[playerid][0] = i;

				        count++;

	                    new maxcrimes = PenalCodeMaxCrimes(i);

				        for(new x = 0; x < maxcrimes; ++x)
				        {
				            if(count == 20) break;

					        PlayerTextDrawColor(playerid, MDC_PenalCodeUI[playerid][count], -1431655681);
					        PlayerTextDrawBoxColor(playerid, MDC_PenalCodeUI[playerid][count], -1);

					        format(string, sizeof(string), "(%d)%02d. %s", i + 1, x + 1, penal_code[i][x][crime_name]);
					        if(strlen(string) > 33) format(string, sizeof(string), "%.29s ...", string);

					        PlayerTextDrawSetString(playerid, MDC_PenalCodeUI[playerid][count], string);

					        if(x + 1 < maxcrimes) PenalCodeIndex[playerid][1] = x + 1;
					        else
							{
							    PenalCodeIndex[playerid][0] = i + 1;
								PenalCodeIndex[playerid][1] = 0;
							}

					        FoundCrime[playerid][count][0] = i;
					        FoundCrime[playerid][count][1] = x;

					        count++;
				        }
				    }
				}
			}
		}

		if(count == 20)
		{
  			PlayerTextDrawBoxColor(playerid, MDC_PenalCodeUI[playerid][20], 858993663);
  			PlayerTextDrawSetString(playerid, MDC_PenalCodeUI[playerid][20], "___________________~d~");

  			FoundCrime[playerid][20][0] = -1;

  			count++;
		}

		for(new p = 0; p < count; p++)
			PlayerTextDrawShow(playerid, MDC_PenalCodeUI[playerid][p]);
	}

	UpdatePlayerMDCPageHeaders(playerid, e_Player_MDC_Cache[playerid][current_page], "Penal Code", true);

	PlayerTextDrawShow(playerid, MDC_PenalCodeUI[playerid][21]);
	PlayerTextDrawShow(playerid, MDC_PenalCodeUI[playerid][22]);
	PlayerTextDrawShow(playerid, MDC_PenalCodeUI[playerid][25]);

	new idx, crime;

	for(new i = 0; i < 5; ++i)
	{
        if(ChargesSelected[playerid][i][0] != -1)
        {
            idx = ChargesSelected[playerid][i][0];
            crime = ChargesSelected[playerid][i][1];
            
            ChargesSelected[playerid][i][0] = -1;
 			ChargesSelected[playerid][i][1] = -1;
 			
 			MDCAddCharge(playerid, idx, crime);
        }
	}

	/*if(ChargesSelected[playerid][0][0] != -1)
	{
	    PlayerTextDrawShow(playerid, MDC_PenalCodeUI[playerid][26]);

		for(new i = 0; i < 5; ++i)
		{
		    if(ChargesSelected[playerid][i][0] != -1)
		    {
                PlayerTextDrawShow(playerid, MDC_PenalCodeUI[playerid][i + 27]);
		    }
		}

		PlayerTextDrawShow(playerid, MDC_PenalCodeUI[playerid][32]);
		PlayerTextDrawShow(playerid, MDC_PenalCodeUI[playerid][33]);
	}*/
	return true;
}

stock CacheThisPage(playerid)
{
	new page = PenalCodePage[playerid];

    CachedPages[playerid][page][0] = PenalCodeIndex[playerid][0];
    CachedPages[playerid][page][1] = PenalCodeIndex[playerid][1];
}

stock PenalCodeMaxCrimes(id)
{
	new
		maxcrimes = 0
 	;

	switch(id)
	{
	    case 0: maxcrimes = 13;
	    case 1: maxcrimes = 17;
	    case 2: maxcrimes = 10;
	    case 3: maxcrimes = 5;
	    case 4: maxcrimes = 5;
	    case 5: maxcrimes = 10;
	    case 6: maxcrimes = 4;
	    case 7: maxcrimes = 10;
	    case 8: maxcrimes = 13;
	}

	return maxcrimes;
}

stock ReturnPenalCodeName(id)
{
	new
		returnName[60]
 	;

	switch(id)
	{
	    case 0: returnName = "Crimes Against The Person";
	    case 1: returnName = "Crimes Against Property And Criminal Profiteering";
	    case 2: returnName = "Crimes Against Public Decency";
	    case 3: returnName = "Crimes Against Public Justice";
	    case 4: returnName = "Crimes Against Public Peace";
	    case 5: returnName = "Crimes Against Public Health And Safety";
	    case 6: returnName = "Crimes Against State Dependents";
	    case 7: returnName = "Vehicular Offenses";
	    case 8: returnName = "Control Of Deadly Weapons And Equipment";
	    case 9: returnName = "Sentencing Enhancements";
	    case 10: returnName = "Road Law";
	    case 11: returnName = "Code Policy";
	    case 12: returnName = "State Code Violations";
	    case 13: returnName = "Peace Officers";
	    case 14: returnName = "Amendments & Additions";
	}

	return returnName;
}

stock IsPenalCodeActive(id)
{
	switch(id)
	{
	    case 0 , 1 , 2 , 3 , 4 , 5, 6, 7, 8:
			return true;
	    default:
			return false;
	}
	return false;
}

stock SelectProperty(playerid, propertyid)
{
	if(e_Player_MDC_Cache[playerid][current_property] != propertyid)
	{
	    ActiveQuery{playerid} = true;

	    new query[256];
		mysql_format(dbCon, query, sizeof(query), "SELECT `id`, `posx`, `posy` FROM `houses` WHERE `id` = %d LIMIT 1", e_Player_MDC_Cache[playerid][property_idx][propertyid]);
		mysql_tquery(dbCon, query, "MDC_ViewProperties", "iii", playerid, propertyid, 1);
	}

	return true;
}

FUNX::MDC_ViewProperties(playerid, selected, refresh)
{
    ActiveQuery{playerid} = false;

	new
	    hsqlid,
		Float:hPosX,
		Float:hPosY,
		streetName[MAX_ZONE_NAME],
		streetLocation[MAX_ZONE_NAME],
		streetCity[MAX_ZONE_NAME],
		list[256],
		count = 3
	;

	e_Player_MDC_Cache[playerid][current_property] = selected;

	if(refresh)
	{
	    cache_get_value_name_int(0, "id", hsqlid);
	
		cache_get_value_name_float(0, "posx", hPosX);
		cache_get_value_name_float(0, "posy", hPosY);

		GetStreet(hPosX, hPosY, streetName, MAX_ZONE_NAME);
		Get2DZone(hPosX, hPosY, streetLocation, MAX_ZONE_NAME);
		GetCity(hPosX, hPosY, streetCity, MAX_ZONE_NAME);

  		format(list, sizeof(list), "%d_%s~n~%s~n~%s_%d~n~San_Andreas", hsqlid, streetName, streetLocation, streetCity, ReturnAreaCode(streetLocation));
  		PlayerTextDrawSetString(playerid, MDC_PropertiesUI[playerid][1], list);
	}
	else
	{
		for(new i = 0; i < cache_num_rows(); ++i)
		{
		    cache_get_value_name_int(i, "id", hsqlid);

			cache_get_value_name_float(i, "posx", hPosX);
			cache_get_value_name_float(i, "posy", hPosY);

			GetStreet(hPosX, hPosY, streetName, MAX_ZONE_NAME);
			Get2DZone(hPosX, hPosY, streetLocation, MAX_ZONE_NAME);
			GetCity(hPosX, hPosY, streetCity, MAX_ZONE_NAME);

		    if(i == e_Player_MDC_Cache[playerid][current_property])
		    {
		        format(list, sizeof(list), "%d_%s~n~%s~n~%s_%d~n~San_Andreas", hsqlid, streetName, streetLocation, streetCity, ReturnAreaCode(streetLocation));
		        PlayerTextDrawSetString(playerid, MDC_PropertiesUI[playerid][1], list);
		    }

		    format(list, sizeof(list), "- %d %s", hsqlid, streetName);
			PlayerTextDrawSetString(playerid, MDC_PropertiesUI[playerid][3 + i], list);

			e_Player_MDC_Cache[playerid][property_idx][i] = hsqlid;

			count++;
		}
	}

	UpdatePlayerMDCPageHeaders(playerid, e_Player_MDC_Cache[playerid][current_page], "Property Account", true);

	for(new i = 0; i < count; ++i)
	    PlayerTextDrawShow(playerid, MDC_PropertiesUI[playerid][i]);

	PlayerTextDrawShow(playerid, MDC_PropertiesUI[playerid][19]);

	return true;
}

stock RevokePlayerLicense(playerid, type)
{
	new
	    sql_name[30],
	    userid = IsCharacterOnline(e_Player_MDC_Cache[playerid][player_dbid])
	;
	
	switch(type)
	{
	    case 6:
	    {
	        sql_name = "CarLic";
	        
	        if(userid != -1) PlayerData[userid][pCarLic] = 0;
	        
	        SendPoliceMessage(COLOR_POLICE, "** %s revoked %s's driving license.", ReturnName(playerid, 0), e_Player_MDC_Cache[playerid][player_name]);
	    }
	    case 15:
	    {
	        sql_name = "WepLic";
	        
	        if(userid != -1) PlayerData[userid][pWepLic] = 0;
	        
	        SendPoliceMessage(COLOR_POLICE, "** %s revoked %s's weapon license.", ReturnName(playerid, 0), e_Player_MDC_Cache[playerid][player_name]);
	    }
	    case 22: sql_name = "FlyLic";
	    case 29: sql_name = "MedLic";
	    case 36: sql_name = "TruckLic";
	}
	
	new
	    string[128 + MAX_PLAYER_NAME];

	if(type == 6) format(string, sizeof(string), "UPDATE `characters` SET `%s` = '0', `CarLicWarns` = '0', `CarLicSuspended` = '0' WHERE `ID` = '%d'", sql_name, e_Player_MDC_Cache[playerid][player_dbid]);
	else format(string, sizeof(string), "UPDATE `characters` SET `%s` = '0' WHERE `ID` = '%d'", sql_name, e_Player_MDC_Cache[playerid][player_dbid]);

	mysql_tquery(dbCon, string);
	
	MDC_ChangeProfilePage(playerid, 4, 4);
	return true;
}

stock WarnDriverLicense(playerid)
{
	new
	    string[128];

    SendPoliceMessage(COLOR_POLICE, "** %s added a warning to %s's driving license (1).", ReturnName(playerid, 0), e_Player_MDC_Cache[playerid][player_name]);

	format(string, sizeof(string), "UPDATE characters SET CarLicWarns = CarLicWarns + 1 WHERE ID = '%d'", e_Player_MDC_Cache[playerid][player_dbid]);
	mysql_tquery(dbCon, string);

	MDC_ChangeProfilePage(playerid, 4, 4);
}

stock SuspendDriverLicense(playerid, hours)
{
	new
	    string[128];
    
    SendPoliceMessage(COLOR_POLICE, "** %s suspended %s's driving license for %d hours.", ReturnName(playerid, 0), e_Player_MDC_Cache[playerid][player_name], hours);

	hours = hours * 3600;

	format(string, sizeof(string), "UPDATE characters SET CarLicSuspended = '%d' WHERE ID = '%d'", gettime() + hours, e_Player_MDC_Cache[playerid][player_dbid]);
	mysql_tquery(dbCon, string);

	MDC_ChangeProfilePage(playerid, 4, 4);
}

Dialog:RevokeDriverLicense(playerid, response, listitem, inputtext[])
{
	if(!response) return true;
	
	RevokePlayerLicense(playerid, 6);
	return true;
}

Dialog:RevokeWeaponLicense(playerid, response, listitem, inputtext[])
{
	if(!response) return true;

	RevokePlayerLicense(playerid, 15);
	return true;
}

Dialog:IssueLicenseWarning(playerid, response, listitem, inputtext[])
{
	if(!response) return true;
	
	WarnDriverLicense(playerid);
	return true;
}

Dialog:IssueLicenseSuspension(playerid, response, listitem, inputtext[])
{
	if(!response) return true;

	if(!IsNumeric(inputtext))
		return SendErrorMessage(playerid, "Invalid number.");
		
	SuspendDriverLicense(playerid, strval(inputtext));
	return true;
}

FUNX::MDC_ViewLicenses(playerid)
{
    ActiveQuery{playerid} = false;

	new
		dlic,
		dlicWarns,
		dlicSuspended,
		wlic,
		plic,
		mlic,
		tlic
	;

	cache_get_value_name_int(0, "CarLic", dlic);
	cache_get_value_name_int(0, "CarLicWarns", dlicWarns);
	cache_get_value_name_int(0, "CarLicSuspended", dlicSuspended);
	cache_get_value_name_int(0, "WepLic", wlic);
	cache_get_value_name_int(0, "FlyLic", plic);
	cache_get_value_name_int(0, "MedLic", mlic);
	cache_get_value_name_int(0, "TruckLic", tlic);
	
	new stamp = gettime();

	if(dlic)
	{
	    new str[64];
	
	    if(stamp < dlicSuspended)
		{
			format(str, 64, "~y~Suspended~n~~g~%d~n~%s", dlicWarns, HowLongAgo(dlicSuspended - stamp));
			
			PlayerTextDrawSetString(playerid, MDC_LicensesUI[playerid][8], "ALLOW");
		}
	    else
		{
		    switch(dlicWarns)
		    {
		        case 0:
				{
					format(str, 64, "~g~Acquired~n~~g~%d", dlicWarns);
				}
		        case 1:
				{
					format(str, 64, "~g~Acquired~n~~y~%d", dlicWarns);
				}
		        default:
				{
					format(str, 64, "~g~Acquired~n~~r~%d", dlicWarns);
				}
		    }
			
			PlayerTextDrawSetString(playerid, MDC_LicensesUI[playerid][8], "SUSPEND");
		}
		
		PlayerTextDrawSetString(playerid, MDC_LicensesUI[playerid][5], str);
	}
	else PlayerTextDrawSetString(playerid, MDC_LicensesUI[playerid][5], "~r~Not_acquired~n~~l~N/A");

	if(wlic)
	    PlayerTextDrawSetString(playerid, MDC_LicensesUI[playerid][14], "~g~Acquired~n~~l~N/A~n~~r~No");
	else
	    PlayerTextDrawSetString(playerid, MDC_LicensesUI[playerid][14], "~r~Not_acquired~n~~l~N/A~n~~r~No");

	if(plic)
	    PlayerTextDrawSetString(playerid, MDC_LicensesUI[playerid][21], "~g~Acquired");
	else
	    PlayerTextDrawSetString(playerid, MDC_LicensesUI[playerid][21], "~r~Not_acquired");

	if(mlic)
	    PlayerTextDrawSetString(playerid, MDC_LicensesUI[playerid][28], "~g~Acquired~n~~l~None");
	else
	    PlayerTextDrawSetString(playerid, MDC_LicensesUI[playerid][28], "~r~Not_acquired~n~~l~None");

	if(tlic)
	    PlayerTextDrawSetString(playerid, MDC_LicensesUI[playerid][35], "~g~Acquired~n~~l~N/A");
	else
	    PlayerTextDrawSetString(playerid, MDC_LicensesUI[playerid][35], "~r~Not_acquired~n~~l~N/A");

	UpdatePlayerMDCPageHeaders(playerid, e_Player_MDC_Cache[playerid][current_page], "Licenses", true);

	for(new i = 0; i < 37; ++i)
	{
	    if( !dlic && (i >= 6 && i <= 8) ) PlayerTextDrawHide(playerid, MDC_LicensesUI[playerid][i]);
	    
	    else if( !wlic && i == 15 ) PlayerTextDrawHide(playerid, MDC_LicensesUI[playerid][i]);
	    
	    else if( !plic && i == 22 ) PlayerTextDrawHide(playerid, MDC_LicensesUI[playerid][i]);
	    
	    else if( !mlic && i == 29 ) PlayerTextDrawHide(playerid, MDC_LicensesUI[playerid][i]);
	    
	    else if( !tlic && i == 36 ) PlayerTextDrawHide(playerid, MDC_LicensesUI[playerid][i]);
	    
	    else PlayerTextDrawShow(playerid, MDC_LicensesUI[playerid][i]);
	}

	return true;
}

FUNX::MDC_ViewChargeDetails(playerid, dbid)
{
    ActiveQuery{playerid} = false;
    
    SetPVarInt(playerid, "ViewingCharge", dbid);

	new
	    ch_idx,
	    charge_type,
	    issued_name[MAX_PLAYER_NAME],
	    issuer_name[MAX_PLAYER_NAME],
	    charge_date[24],
	    charge_time[24],
	    charge_quote[128],
	    charges_count,
	    sub_str[128],
	    arrest_record[800],
	    ch_type,
	    count = 0
	;

 	cache_get_value_name_int(0, "idx", ch_idx);
    cache_get_value_name_int(0, "charge_type", charge_type);
    cache_get_value_name(0, "player_name", issued_name, MAX_PLAYER_NAME);
    cache_get_value_name(0, "issuer_name", issuer_name, MAX_PLAYER_NAME);
    cache_get_value_name(0, "add_date", charge_date, 24);
    cache_get_value_name(0, "add_time", charge_time, 24);
    cache_get_value_name(0, "charge_quote", charge_quote, 128);
    cache_get_value_name_int(0, "charges_count", charges_count);
    
    ch_type = charge_type;
    
    if(charge_type != CHARGE_TYPE_NORMAL) cache_get_value_name(0, "arrest_record", arrest_record, 2000);
    
    if(isnull(arrest_record) || !strlen(arrest_record)) arrest_record = "N/A";

	format(sub_str, sizeof(sub_str), "#%d~n~%s~n~%s~n~%s_%s~n~", dbid, issued_name, issuer_name, charge_date, charge_time);

	switch(charge_type)
	{
	    case CHARGE_TYPE_NORMAL:
	    {
			strcat(sub_str, "Normal");
	    }
 		case CHARGE_TYPE_ARREST:
  		{
            strcat(sub_str, "~r~Arrest (prison)");
  		}
  		case CHARGE_TYPE_JAIL:
  		{
            strcat(sub_str, "~r~Arrest (jail)");
  		}
	}

	PlayerTextDrawSetString(playerid, MDC_ChargesUI[playerid][30], sub_str);
	cache_get_value_name(0, "charge_quote", charge_quote, 128);

	if(charge_type == CHARGE_TYPE_NORMAL)
	{
	    for(new i = 37; i < 39; ++i) PlayerTextDrawDestroy(playerid, MDC_ChargesUI[playerid][i]);

		MDC_ChargesUI[playerid][37] = CreatePlayerTextDraw(playerid, 229.666809, 227.733337, "Quote");
		PlayerTextDrawLetterSize(playerid, MDC_ChargesUI[playerid][37], 0.166997, 0.786961);
		PlayerTextDrawAlignment(playerid, MDC_ChargesUI[playerid][37], 1);
		PlayerTextDrawColor(playerid, MDC_ChargesUI[playerid][37], 858993663);
		PlayerTextDrawSetShadow(playerid, MDC_ChargesUI[playerid][37], 0);
		PlayerTextDrawSetOutline(playerid, MDC_ChargesUI[playerid][37], 0);
		PlayerTextDrawBackgroundColor(playerid, MDC_ChargesUI[playerid][37], 51);
		PlayerTextDrawFont(playerid, MDC_ChargesUI[playerid][37], 1);
		PlayerTextDrawSetProportional(playerid, MDC_ChargesUI[playerid][37], 1);

		MDC_ChargesUI[playerid][38] = CreatePlayerTextDraw(playerid, 229.666687, 235.614807, charge_quote);
		PlayerTextDrawLetterSize(playerid, MDC_ChargesUI[playerid][38], 0.170000, 0.795256);
		PlayerTextDrawTextSize(playerid, MDC_ChargesUI[playerid][38], 464.666778, -7.881481);
		PlayerTextDrawAlignment(playerid, MDC_ChargesUI[playerid][38], 1);
		PlayerTextDrawColor(playerid, MDC_ChargesUI[playerid][38], -1431655681);
		PlayerTextDrawUseBox(playerid, MDC_ChargesUI[playerid][38], true);
		PlayerTextDrawBoxColor(playerid, MDC_ChargesUI[playerid][38], 0);
		PlayerTextDrawSetShadow(playerid, MDC_ChargesUI[playerid][38], 0);
		PlayerTextDrawSetOutline(playerid, MDC_ChargesUI[playerid][38], 0);
		PlayerTextDrawBackgroundColor(playerid, MDC_ChargesUI[playerid][38], 51);
		PlayerTextDrawFont(playerid, MDC_ChargesUI[playerid][38], 1);
		PlayerTextDrawSetProportional(playerid, MDC_ChargesUI[playerid][38], 1);
	}
	else
	{
	    for(new i = 37; i < 41; ++i) PlayerTextDrawDestroy(playerid, MDC_ChargesUI[playerid][i]);

	    new query[256];
		mysql_format(dbCon, query, sizeof(query), "SELECT charge_type, charge_quote, charge_idx, charge_row FROM criminal_record WHERE player_name = '%e' AND idx < %d OR player_name = '%e' AND idx < %d ORDER BY idx DESC LIMIT %d", e_Player_MDC_Cache[playerid][player_name], ch_idx, UnFormatName(e_Player_MDC_Cache[playerid][player_name]), ch_idx, charges_count);
		new Cache:record_cache = mysql_query(dbCon, query);

		if(!cache_num_rows())
		{
			MDC_ChargesUI[playerid][37] = CreatePlayerTextDraw(playerid, 229.666809, 227.733337, "Quote");
			PlayerTextDrawLetterSize(playerid, MDC_ChargesUI[playerid][37], 0.166997, 0.786961);
			PlayerTextDrawAlignment(playerid, MDC_ChargesUI[playerid][37], 1);
			PlayerTextDrawColor(playerid, MDC_ChargesUI[playerid][37], 858993663);
			PlayerTextDrawSetShadow(playerid, MDC_ChargesUI[playerid][37], 0);
			PlayerTextDrawSetOutline(playerid, MDC_ChargesUI[playerid][37], 0);
			PlayerTextDrawBackgroundColor(playerid, MDC_ChargesUI[playerid][37], 51);
			PlayerTextDrawFont(playerid, MDC_ChargesUI[playerid][37], 1);
			PlayerTextDrawSetProportional(playerid, MDC_ChargesUI[playerid][37], 1);

			MDC_ChargesUI[playerid][38] = CreatePlayerTextDraw(playerid, 229.666687, 235.614807, charge_quote);
			PlayerTextDrawLetterSize(playerid, MDC_ChargesUI[playerid][38], 0.170000, 0.795256);
			PlayerTextDrawTextSize(playerid, MDC_ChargesUI[playerid][38], 464.666778, -7.881481);
			PlayerTextDrawAlignment(playerid, MDC_ChargesUI[playerid][38], 1);
			PlayerTextDrawColor(playerid, MDC_ChargesUI[playerid][38], -1431655681);
			PlayerTextDrawUseBox(playerid, MDC_ChargesUI[playerid][38], true);
			PlayerTextDrawBoxColor(playerid, MDC_ChargesUI[playerid][38], 0);
			PlayerTextDrawSetShadow(playerid, MDC_ChargesUI[playerid][38], 0);
			PlayerTextDrawSetOutline(playerid, MDC_ChargesUI[playerid][38], 0);
			PlayerTextDrawBackgroundColor(playerid, MDC_ChargesUI[playerid][38], 51);
			PlayerTextDrawFont(playerid, MDC_ChargesUI[playerid][38], 1);
			PlayerTextDrawSetProportional(playerid, MDC_ChargesUI[playerid][38], 1);
		}
		else
		{
		    new charge_idx, charge_row, Float:current_y = 239.762939; //, last_type = -1;

		    for(new i = 0; i < cache_num_rows(); ++i)
		    {
		        if(count == charges_count) break;

		        cache_get_value_name_int(i, "charge_type", charge_type);
		        cache_get_value_name_int(i, "charge_idx", charge_idx);
		        cache_get_value_name_int(i, "charge_row", charge_row);

		        format(sub_str, sizeof(sub_str), "-  %s", penal_code[charge_idx][charge_row][crime_name]);
		        PlayerTextDrawSetString(playerid, MDC_ChargesUI[playerid][32 + count], sub_str);

		        current_y += 12.200012;

		        count++;
		    }

		    current_y -= 12.200012;

		    current_y += 11.103577;

			MDC_ChargesUI[playerid][37] = CreatePlayerTextDraw(playerid, 229.666809, current_y, "Quote");
			PlayerTextDrawLetterSize(playerid, MDC_ChargesUI[playerid][37], 0.166997, 0.786961);
			PlayerTextDrawAlignment(playerid, MDC_ChargesUI[playerid][37], 1);
			PlayerTextDrawColor(playerid, MDC_ChargesUI[playerid][37], 858993663);
			PlayerTextDrawSetShadow(playerid, MDC_ChargesUI[playerid][37], 0);
			PlayerTextDrawSetOutline(playerid, MDC_ChargesUI[playerid][37], 0);
			PlayerTextDrawBackgroundColor(playerid, MDC_ChargesUI[playerid][37], 51);
			PlayerTextDrawFont(playerid, MDC_ChargesUI[playerid][37], 1);
			PlayerTextDrawSetProportional(playerid, MDC_ChargesUI[playerid][37], 1);

			current_y += 8.296203;

			MDC_ChargesUI[playerid][38] = CreatePlayerTextDraw(playerid, 229.666687, current_y, charge_quote);
			PlayerTextDrawLetterSize(playerid, MDC_ChargesUI[playerid][38], 0.170000, 0.795256);
			PlayerTextDrawTextSize(playerid, MDC_ChargesUI[playerid][38], 464.666778, -7.881481);
			PlayerTextDrawAlignment(playerid, MDC_ChargesUI[playerid][38], 1);
			PlayerTextDrawColor(playerid, MDC_ChargesUI[playerid][38], -1431655681);
			PlayerTextDrawUseBox(playerid, MDC_ChargesUI[playerid][38], true);
			PlayerTextDrawBoxColor(playerid, MDC_ChargesUI[playerid][38], 0);
			PlayerTextDrawSetShadow(playerid, MDC_ChargesUI[playerid][38], 0);
			PlayerTextDrawSetOutline(playerid, MDC_ChargesUI[playerid][38], 0);
			PlayerTextDrawBackgroundColor(playerid, MDC_ChargesUI[playerid][38], 51);
			PlayerTextDrawFont(playerid, MDC_ChargesUI[playerid][38], 1);
			PlayerTextDrawSetProportional(playerid, MDC_ChargesUI[playerid][38], 1);
			
			if(ch_type != CHARGE_TYPE_NORMAL)
			{
			    current_y += 11.103577; current_y += 8.296203;
			
				MDC_ChargesUI[playerid][39] = CreatePlayerTextDraw(playerid, 229.666702, current_y, "Arrest Record");
				PlayerTextDrawLetterSize(playerid, MDC_ChargesUI[playerid][39], 0.169330, 0.782812);
				PlayerTextDrawAlignment(playerid, MDC_ChargesUI[playerid][39], 1);
				PlayerTextDrawColor(playerid, MDC_ChargesUI[playerid][39], 858993663);
				PlayerTextDrawSetShadow(playerid, MDC_ChargesUI[playerid][39], 0);
				PlayerTextDrawSetOutline(playerid, MDC_ChargesUI[playerid][39], 0);
				PlayerTextDrawBackgroundColor(playerid, MDC_ChargesUI[playerid][39], 51);
				PlayerTextDrawFont(playerid, MDC_ChargesUI[playerid][39], 1);
				PlayerTextDrawSetProportional(playerid, MDC_ChargesUI[playerid][39], 1);
				
				current_y += 8.296203;

				MDC_ChargesUI[playerid][40] = CreatePlayerTextDraw(playerid, 229.666702, current_y, arrest_record);
				PlayerTextDrawLetterSize(playerid, MDC_ChargesUI[playerid][40], 0.170000, 0.795256);
				PlayerTextDrawTextSize(playerid, MDC_ChargesUI[playerid][40], 464.333465, -2.074073);
				PlayerTextDrawAlignment(playerid, MDC_ChargesUI[playerid][40], 1);
				PlayerTextDrawColor(playerid, MDC_ChargesUI[playerid][40], -1431655681);
				PlayerTextDrawUseBox(playerid, MDC_ChargesUI[playerid][40], true);
				PlayerTextDrawBoxColor(playerid, MDC_ChargesUI[playerid][40], 0);
				PlayerTextDrawSetShadow(playerid, MDC_ChargesUI[playerid][40], 0);
				PlayerTextDrawSetOutline(playerid, MDC_ChargesUI[playerid][40], 0);
				PlayerTextDrawBackgroundColor(playerid, MDC_ChargesUI[playerid][40], 51);
				PlayerTextDrawFont(playerid, MDC_ChargesUI[playerid][40], 1);
				PlayerTextDrawSetProportional(playerid, MDC_ChargesUI[playerid][40], 1);
			}
		}

	    cache_delete(record_cache);
	}

	UpdatePlayerMDCPageHeaders(playerid, e_Player_MDC_Cache[playerid][current_page], "Criminal_Record", true);

	for(new i = 25; i < 31; ++i)
		PlayerTextDrawShow(playerid, MDC_ChargesUI[playerid][i]);

	if(count)
	{
    	PlayerTextDrawShow(playerid, MDC_ChargesUI[playerid][31]);

		for(new i = 32; i < 32 + count; ++i)
		    PlayerTextDrawShow(playerid, MDC_ChargesUI[playerid][i]);
	}

	PlayerTextDrawShow(playerid, MDC_ChargesUI[playerid][37]);
	PlayerTextDrawShow(playerid, MDC_ChargesUI[playerid][38]);
	
	if(ch_type != CHARGE_TYPE_NORMAL)
	{
		PlayerTextDrawShow(playerid, MDC_ChargesUI[playerid][39]);
		PlayerTextDrawShow(playerid, MDC_ChargesUI[playerid][40]);
	}

	return true;
}

FUNX::MDC_ViewCriminalRecord(playerid)
{
    ActiveQuery{playerid} = false;

	for(new i = 1; i < 24; i ++)
	{
		PlayerTextDrawSetString(playerid, MDC_ChargesUI[playerid][i], "_");
		PlayerTextDrawColor(playerid, MDC_ChargesUI[playerid][i], 858993663);
		PlayerTextDrawUseBox(playerid, MDC_ChargesUI[playerid][i], false);
		PlayerTextDrawBoxColor(playerid, MDC_ChargesUI[playerid][i], -1);
		PlayerTextDrawSetSelectable(playerid, MDC_ChargesUI[playerid][i], false);
	}

	new
	    charge_id,
	    charge_quote[128],
	    charge_date[24],
	    charge_type,
	    charges_found = 0,
		sub_str[128]
	;

	for(new i = 0; i < cache_num_rows(); ++i)
	{
	    cache_get_value_name_int(i, "idx", charge_id);
	    cache_get_value_name(i, "charge_quote", charge_quote, 128);
        cache_get_value_name(i, "add_date", charge_date, 24);
        cache_get_value_name_int(i, "charge_type", charge_type);

  		e_Player_MDC_Cache[playerid][viewing_charge][charges_found] = charge_id;

  		switch(charge_type)
  		{
			case CHARGE_TYPE_NORMAL:
			{
				format(sub_str, sizeof(sub_str), "%s_%s", charge_date, charge_quote);
		  		PlayerTextDrawSetString(playerid, MDC_ChargesUI[playerid][charges_found + 1], sub_str);
			}
  		    case CHARGE_TYPE_ARREST:
  		    {
				format(sub_str, sizeof(sub_str), "%s_Imprisoned", charge_date);
		  		PlayerTextDrawSetString(playerid, MDC_ChargesUI[playerid][charges_found + 1], sub_str);

  		        PlayerTextDrawColor(playerid, MDC_ChargesUI[playerid][charges_found + 1], -439960833);
  		        PlayerTextDrawUseBox(playerid, MDC_ChargesUI[playerid][charges_found + 1], true);
  		        PlayerTextDrawBoxColor(playerid, MDC_ChargesUI[playerid][charges_found + 1], -1440603393);
  		    }
  		    case CHARGE_TYPE_JAIL:
  		    {
				format(sub_str, sizeof(sub_str), "%s_Jailed", charge_date);
		  		PlayerTextDrawSetString(playerid, MDC_ChargesUI[playerid][charges_found + 1], sub_str);

    		    PlayerTextDrawColor(playerid, MDC_ChargesUI[playerid][charges_found + 1], -1);
    		    PlayerTextDrawUseBox(playerid, MDC_ChargesUI[playerid][charges_found + 1], true);
  		        PlayerTextDrawBoxColor(playerid, MDC_ChargesUI[playerid][charges_found + 1], -6029057);
  		    }
  		}

  		PlayerTextDrawSetSelectable(playerid, MDC_ChargesUI[playerid][charges_found + 1], true);

  		charges_found++;
	}

	if(charges_found == 0)
	{
	    PlayerTextDrawSetString(playerid, MDC_ChargesUI[playerid][1], "No_entries");
	    PlayerTextDrawSetSelectable(playerid, MDC_ChargesUI[playerid][1], false);
	}

	PlayerTextDrawSetString(playerid, MDC_ChargesUI[playerid][24], "1/1");
	UpdatePlayerMDCPageHeaders(playerid, e_Player_MDC_Cache[playerid][current_page], "Criminal_Record", true);

	for(new i = 0; i < 25; i ++)
		PlayerTextDrawShow(playerid, MDC_ChargesUI[playerid][i]);

	return true;
}

UpdatePlayerMDCPageHeaders(playerid, page, const header[], bool:show = false)
{
	new
	    str[128],
	    abbrv[60]
	;
	
	switch(e_Player_MDC_Cache[playerid][faction_type])
	{
		case FACTION_POLICE:
		    format(abbrv, 60, "POLICE");
		case FACTION_SHERIFF:
		    format(abbrv, 60, "SHERIFF");
		default:
		    format(abbrv, 60, "POLICE");
	}

	switch(page)
	{
	    case 1:
		{
		 	format(str, sizeof(str), "%s_~>~_%s", abbrv, e_Player_MDC_Cache[playerid][player_name]);
		  	PlayerTextDrawSetString(playerid, MDC_UI[playerid][7], str);
		}

	    case 2 , 4:
		{
		 	format(str, sizeof(str), "%s_~>~_%s_~>~_%s", abbrv, e_Player_MDC_Cache[playerid][player_name], header);
		  	PlayerTextDrawSetString(playerid, MDC_UI[playerid][7], str);

			format(str, sizeof(str), "~<~_Back_to_%s", e_Player_MDC_Cache[playerid][player_name]);
			PlayerTextDrawSetString(playerid, MDC_UI[playerid][38], str);
		}

	    case 3:
		{
			format(str, sizeof(str), "~<~_Back_to_%s's_Criminal_Record", e_Player_MDC_Cache[playerid][player_name]);
			PlayerTextDrawSetString(playerid, MDC_UI[playerid][38], str);
		}

		case 5, 6:
		{
			format(str, sizeof(str), "~<~_Back_to_%s", e_Player_MDC_Cache[playerid][player_name]);
			PlayerTextDrawSetString(playerid, MDC_UI[playerid][38], str);
		}
	}

	if(show)
		PlayerTextDrawShow(playerid, MDC_UI[playerid][38]);

	return true;
}

FUNX::MDC_OnNameFound(playerid, dbid)
{
    PlayerTextDrawHide(playerid, MDC_VehicleUI[playerid][3]);

	if(GetPVarInt(playerid, "MDC_ViewingVehicle"))
	{
 		for(new i = 0; i < sizeof(MDC_VehicleUI[]); i ++)
			PlayerTextDrawHide(playerid, MDC_VehicleUI[playerid][i]);
			
		e_Player_MDC_Cache[playerid][vehicle_dbid] = -1;

		DeletePVar(playerid, "MDC_ViewingVehicle");
	}

    if(!cache_num_rows())
	{
        ActiveQuery{playerid} = false;
		return true;
	}

	new
		primary_str[300],
		sub_str[128],
		active_listing,
		jail_times,
		skin,
		dlic,
		wlic,
		plic,
		mlic,
		licenses_found = 0,
		charid,
		phone_number,
		prison_times,
		list[256],
		license_str[64],
		query[256]
	;

	cache_get_value_name_int(0, "PhoneNumbr", phone_number);
	cache_get_value_name_int(0, "ActiveListings", active_listing);
	cache_get_value_name_int(0, "JailTimes", jail_times);
	cache_get_value_name_int(0, "PrisonTimes", prison_times);
	cache_get_value_name_int(0, "CarLic", dlic);
	cache_get_value_name_int(0, "WepLic", wlic);
	cache_get_value_name_int(0, "FlyLic", plic);
	cache_get_value_name_int(0, "MedLic", mlic);
	cache_get_value_name_int(0, "PrisonSkin", skin);
	cache_get_value_name_int(0, "ID", charid);

	new bool:incarcerated;
	cache_get_value_name_bool(0, "Jailed", incarcerated);

 	format(sub_str, sizeof(sub_str), "POLICE_~>~_%s", e_Player_MDC_Cache[playerid][player_name]);
  	PlayerTextDrawSetString(playerid, MDC_UI[playerid][7], sub_str);
	PlayerTextDrawSetPreviewModel(playerid, MDC_UI[playerid][23], skin);

	if(prison_times > 0)
	{
	    format(list, sizeof(list), "%s~n~%d~n~%d_prison_%s", e_Player_MDC_Cache[playerid][player_name], phone_number, prison_times, NeedAnS("sentence", prison_times));
	}
    else if(jail_times > 0)
    {
	    format(list, sizeof(list), "%s~n~%d~n~%d_jail_%s", e_Player_MDC_Cache[playerid][player_name], phone_number, jail_times, NeedAnS("sentence", jail_times));
	}
	else if(prison_times > 0 && jail_times > 0)
	{
	    format(list, sizeof(list), "%s~n~%d~n~%d_prison_%s, %d_jail_%s", e_Player_MDC_Cache[playerid][player_name], phone_number, prison_times, NeedAnS("sentence", prison_times), jail_times, NeedAnS("sentence", jail_times));
	}
	else
	{
	    format(list, sizeof(list), "%s~n~%d~n~None", e_Player_MDC_Cache[playerid][player_name], phone_number);
	}

	if(dlic)
		strcat(license_str, "Driver"), licenses_found++;

	if(wlic)
		if(licenses_found > 0)
			strcat(license_str, ", Weapon"), licenses_found++;
		else
		    strcat(license_str, "Weapon"), licenses_found++;

	if(plic)
		if(licenses_found > 0)
			strcat(license_str, ", Pilot"), licenses_found++;
		else
		    strcat(license_str, "Pilot"), licenses_found++;

	if(mlic)
		if(licenses_found > 0)
			strcat(license_str, ", Medical (ILS)"), licenses_found++;
		else
		    strcat(license_str, "Medical (ILS)"), licenses_found++;

	if(licenses_found == 0)
	    license_str = "None";

    format(list, sizeof(list), "%s~n~%s", list, license_str);
    PlayerTextDrawSetString(playerid, MDC_UI[playerid][26], list);

    UpdatePlayerMDCPageHeaders(playerid, e_Player_MDC_Cache[playerid][current_page], "_");

	new info_rows = 0, first_row = 33;

	mysql_format(dbCon, query, sizeof(query), "SELECT `id`, `posx`, `posy` FROM `houses` WHERE `owner` = '%e'", e_Player_MDC_Cache[playerid][player_name]);
	new Cache:house_cache = mysql_query(dbCon, query);

	if(!cache_num_rows())
	{
	    PlayerTextDrawSetString(playerid, MDC_UI[playerid][27], "Not available");
		//PlayerTextDrawSetString(playerid, MDC_UI[playerid][29], "]_This_Person_has_no_registered_properties");
	}
	else
	{
	    new
	        hSQLID,
			Float:hPosX,
			Float:hPosY,
			streetName[MAX_ZONE_NAME],
			streetLocation[MAX_ZONE_NAME],
			streetCity[MAX_ZONE_NAME]
		;

		cache_get_value_name_int(0, "id", hSQLID);
		cache_get_value_name_float(0, "posx", hPosX);
		cache_get_value_name_float(0, "posy", hPosY);

		GetStreet(hPosX, hPosY, streetName, MAX_ZONE_NAME);
		Get2DZone(hPosX, hPosY, streetLocation, MAX_ZONE_NAME);
		GetCity(hPosX, hPosY, streetCity, MAX_ZONE_NAME);

		format(list, sizeof(list), "%d_%s~n~%s~n~%s_%d", hSQLID, streetName, streetLocation, streetCity, ReturnAreaCode(streetLocation));
		PlayerTextDrawSetString(playerid, MDC_UI[playerid][27], list);

		if(cache_num_rows() > 1)
		{
		    PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][first_row], 0xFFFFF22FF);
		    PlayerTextDrawColor(playerid, MDC_UI[playerid][first_row], 858993663);
			PlayerTextDrawSetString(playerid, MDC_UI[playerid][first_row], "]_This_Person_has_multiple_addresses,_click_here_for_a_list");

			info_rows++; first_row++;
		}
	}
	
    cache_delete(house_cache);

	/*if(active_listing > 0)
	{
		TextDrawBoxColor(MDC_UI[playerid][first_row], -1440603393);
        TextDrawColor(MDC_UI[playerid][first_row], -1);
		PlayerTextDrawSetString(playerid, MDC_UI[playerid][first_row], "]_This_Person_is_linked_to_a_warrant!_click_here_for_info");

		info_rows++; first_row++;
	}*/

    mysql_format(dbCon, query, sizeof(query), "SELECT `fineExpire` FROM `fines` WHERE `fineName` = '%e' ORDER BY `ID` DESC", e_Player_MDC_Cache[playerid][player_name]);
    new Cache:fines_cache = mysql_query(dbCon, query);
    
    new fines[3];

    if(cache_num_rows())
    {
 		for(new i = 0, j = cache_num_rows(); i < j; ++i)
		{
			cache_get_value_name_int(i, "fineExpire", fines[2]);

			if(gettime() > fines[2])
			{
				fines[1]++; // expired fines
			}
			else
			{
				fines[0]++; // pending fines
			}
		}
	}

	cache_delete(fines_cache);

	if(fines[0] || fines[1])
	{
		if(fines[0] && fines[1])
		{
			PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][first_row], -1440603393);
			PlayerTextDrawColor(playerid, MDC_UI[playerid][first_row], -1);
			format(list, sizeof(list), "] Fines: %d pending, %d expired!!", fines[0], fines[1]);
			PlayerTextDrawSetString(playerid, MDC_UI[playerid][first_row], list);			
		}
		else if(fines[0] && !fines[1])
		{
			PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][first_row], 0xFFFFF22FF);
			PlayerTextDrawColor(playerid, MDC_UI[playerid][first_row], 858993663);
			format(list, sizeof(list), "] %d pending fines, click for info", fines[0]);
			PlayerTextDrawSetString(playerid, MDC_UI[playerid][first_row], list);	
		}
		else if(!fines[0] && fines[1])
		{
			PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][first_row], -1440603393);
			PlayerTextDrawColor(playerid, MDC_UI[playerid][first_row], -1);
			format(list, sizeof(list), "] %d expired fines, click for info", fines[1]);
			PlayerTextDrawSetString(playerid, MDC_UI[playerid][first_row], list);			
		}		

	    info_rows++; first_row++;
	}

	mysql_format(dbCon, query, sizeof(query), "SELECT `charge_type`, `charge_quote` FROM `criminal_record` WHERE `player_name` = '%e' OR `player_name` = '%e' ORDER BY idx DESC LIMIT 5", e_Player_MDC_Cache[playerid][player_name], UnFormatName(e_Player_MDC_Cache[playerid][player_name]));
	new Cache:cache = mysql_query(dbCon, query);
	
	new charge_type, charge_quote[128], count = 0; //, charge_type, last_type = -1, bool:more_row = false;

	//Currently incarcerated

	if(!cache_num_rows())
	{
		primary_str = "There_are_no_outstanding_charges";
	}
	else
	{
		for(new i, j = cache_num_rows(); i < j; ++i)
		{
			if(count == 5) break;

			cache_get_value_name_int(i, "charge_type", charge_type);

			if(charge_type != CHARGE_TYPE_NORMAL) break;

			cache_get_value_name(i, "charge_quote", charge_quote, 128);
			format(sub_str, sizeof(sub_str), "-_%s~n~", charge_quote);
			strcat(primary_str, sub_str);

	        count++;
		}
	}
	
	if(!count) primary_str = "There_are_no_outstanding_charges";

	if(incarcerated)
	{
		if(!count) primary_str[0] = EOS;
		
		format(primary_str, 300, "Currently_Incarcerated~n~%s", primary_str);
	}

    PlayerTextDrawSetString(playerid, MDC_UI[playerid][32], primary_str);

	cache_delete(cache);

	for(new i = 28; i < 33; ++i) PlayerTextDrawDestroy(playerid, MDC_UI[playerid][i]);

	new Float:pos_y = 252.622192;

	for(new i = 0; i < info_rows; ++i)
 	{
        pos_y += 12.02951;
	}

	MDC_UI[playerid][28] = CreatePlayerTextDraw(playerid, 232.333343, pos_y, "~>~_Manage_Licenses");
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][28], 0.150333, 0.828444);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][28], 340.666687, 6.000000);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][28], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][28], 858993663);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][28], true);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][28], -1431655681);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][28], 0);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][28], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][28], 51);
	PlayerTextDrawFont(playerid, MDC_UI[playerid][28], 2);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][28], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][28], true);

	MDC_UI[playerid][31] = CreatePlayerTextDraw(playerid, 403.666656, pos_y, "~y~]~w~_CRIMINAL_RECORD_~y~]~w~");
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][31], 0.149666, 0.824295);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][31], 6.000000, 117.807472); //-125.666641
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][31], 2);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][31], -1431655681);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][31], true);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][31], 858993663);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][31], 0);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][31], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][31], 51);
	PlayerTextDrawFont(playerid, MDC_UI[playerid][31], 2);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][31], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][31], true);

	pos_y += 12.02951;

	MDC_UI[playerid][29] = CreatePlayerTextDraw(playerid, 232.333297, pos_y, "~>~_Apply_Charges");
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][29], 0.150333, 0.828444);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][29], 340.666656, 6.000000);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][29], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][29], 858993663);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][29], true);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][29], -1431655681);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][29], 0);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][29], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][29], 51);
	PlayerTextDrawFont(playerid, MDC_UI[playerid][29], 2);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][29], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][29], true);

	MDC_UI[playerid][32] = CreatePlayerTextDraw(playerid, 344.666656, pos_y, primary_str);
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][32], 0.169666, 0.807703);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][32], 462.666778, 32.355564);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][32], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][32], 1246382847);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][32], true);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][32], -256);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][32], 0);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][32], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][32], 51);
	PlayerTextDrawFont(playerid, MDC_UI[playerid][32], 1);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][32], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][32], true);

	pos_y += 12.02951;

	MDC_UI[playerid][30] = CreatePlayerTextDraw(playerid, 232.333328, pos_y, "~>~_Write_Arrest_Record");
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][30], 0.150333, 0.828444);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][30], 340.666687, 6.000000);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][30], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][30], 858993663);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][30], true);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][30], -1431655681);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][30], 0);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][30], 0);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][30], 51);
	PlayerTextDrawFont(playerid, MDC_UI[playerid][30], 2);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][30], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][30], true);

    for(new x = 18; x < 33 + info_rows; x ++)
    {
        PlayerTextDrawHide(playerid, MDC_UI[playerid][x]);
    	PlayerTextDrawShow(playerid, MDC_UI[playerid][x]);
    }

	if(!prison_times && !jail_times)
	{
        PlayerTextDrawHide(playerid, MDC_UI[playerid][23]);
    	PlayerTextDrawShow(playerid, MDC_UI[playerid][36]);
    	PlayerTextDrawShow(playerid, MDC_UI[playerid][37]);
	}

    SetPVarInt(playerid, "MDC_ViewingProfile", 1);
    
    ActiveQuery{playerid} = false;
	return true;
}

FUNX::MDC_OnPlateFound(playerid, dbid, bool:valid_id)
{
    if(!cache_num_rows())
    {
        ActiveQuery{playerid} = false;
		return PlayerTextDrawShow(playerid, MDC_VehicleUI[playerid][3]);
	}

	new
		model,
		carname[64],
		color1,
		color2,
		owner,
		plate[20],
		insurance,
		impounded,
		sub_str[64],
		//stolen,
		primary_str[200]
	;

	if(!valid_id)
	{
		cache_get_value_name_int(0, "carID", dbid);
		e_Player_MDC_Cache[playerid][vehicle_dbid] = dbid;
	}
	cache_get_value_name_int(0, "carModel", model);
	cache_get_value_name(0, "carName", carname, 64);
	cache_get_value_name_int(0, "carColor1", color1);
	cache_get_value_name_int(0, "carColor2", color2);
	cache_get_value_name_int(0, "carOwner", owner);
	cache_get_value_name(0, "carPlate", plate, 20);
	cache_get_value_name_int(0, "carInsurance", insurance);
	cache_get_value_name_int(0, "carInsurance", impounded);
	
    //cache_get_value_name_int(0, "carStolen", stolen);

	/*if(stolen)
	{
	    PlayerTextDrawShow(playerid, MDC_UI[playerid][67]);
	    PlayerTextDrawShow(playerid, MDC_UI[playerid][68]);
		new year, month, day, MonthStr[16], str[64];
		getdate(year, month, day);
		switch(month)
		{
		    case 1:  MonthStr = "Jan";
		    case 2:  MonthStr = "Feb";
		    case 3:  MonthStr = "Mar";
		    case 4:  MonthStr = "Apr";
		    case 5:  MonthStr = "May";
		    case 6:  MonthStr = "Jun";
		    case 7:  MonthStr = "Jul";
		    case 8:  MonthStr = "Aug";
		    case 9:  MonthStr = "Sep";
		    case 10: MonthStr = "Oct";
		    case 11: MonthStr = "Nov";
		    case 12: MonthStr = "Dec";
		}
		format(str, sizeof str, "_NOTE(s):_Vehicle_reported_stolen_-_%d/%s/%d", day, MonthStr, year);
	    PlayerTextDrawSetString(playerid, MDC_UI[playerid][68], "_NOTE(s):_Vehicle_reported_stolen");
	}*/

	switch(insurance)
	{
	    case 0: sub_str = "~r~Level_0";
	    case 1: sub_str = "~y~Level_1";
	    case 2: sub_str = "~g~Level_2";
	    case 3: sub_str = "~g~Level_3";
	}

    PlayerTextDrawSetPreviewModel(playerid, MDC_VehicleUI[playerid][0], model);
    PlayerTextDrawSetPreviewVehCol(playerid, MDC_VehicleUI[playerid][0], color1, color2);
    
    if(strlen(carname) > 0)
		format(primary_str, sizeof primary_str, "%s (( %s ))~n~%s~n~%s~n~%s~n~%s", carname, ReturnVehicleModelName(model), plate, ReturnDBIDName(owner), sub_str, (impounded) ? ("~r~Yes") : ("~l~No"));
    else
		format(primary_str, sizeof primary_str, "%s~n~%s~n~%s~n~%s~n~%s", ReturnVehicleModelName(model), plate, ReturnDBIDName(owner), sub_str, (impounded) ? ("~r~Yes") : ("~l~No"));
    
    PlayerTextDrawSetString(playerid, MDC_VehicleUI[playerid][2], primary_str);

    for(new x = 0; x < 3; x ++)
    {
        PlayerTextDrawHide(playerid, MDC_VehicleUI[playerid][x]);
    	PlayerTextDrawShow(playerid, MDC_VehicleUI[playerid][x]);
    }

    SetPVarInt(playerid, "MDC_ViewingVehicle", 1);
    
    ActiveQuery{playerid} = false;
	return true;
}

FUNX::MDC_HidePage(playerid, page)
{
	if(e_Player_MDC_Cache[playerid][faction_type] == FACTION_MEDIC)
	{
	    switch(page)
	    {
	        case 1:
				page = 2;
	        case 2:
				page = 3;
	    }
	}

	switch(page)
	{
	    case 0:
	    {
	        for(new i = 10; i < 18; i ++)
				PlayerTextDrawHide(playerid, MDC_UI[playerid][i]);
	    }
	    case 1:
	    {
	        switch(e_Player_MDC_Cache[playerid][current_page])
	        {
	            case 0, 1:
	            {
	                for(new i = 18; i < sizeof(MDC_UI[]); i ++)
	                {
						PlayerTextDrawHide(playerid, MDC_UI[playerid][i]);
					}

					PlayerTextDrawHide(playerid, MDC_VehicleUI[playerid][3]);
	            }
	            case 2:
	            {
		        	for(new i = 0; i < 25; i ++)
						PlayerTextDrawHide(playerid, MDC_ChargesUI[playerid][i]);
	            }
	            case 3:
	            {
		        	for(new i = 25; i < sizeof(MDC_ChargesUI[]); i ++)
						PlayerTextDrawHide(playerid, MDC_ChargesUI[playerid][i]);
	            }
	            case 4:
	            {
	                for(new i = 0; i < 37; i ++)
	            		PlayerTextDrawHide(playerid, MDC_LicensesUI[playerid][i]);
	            }
	            case 5:
	            {
	                for(new i = 0; i < 40; i ++)
	            		PlayerTextDrawHide(playerid, MDC_PenalCodeUI[playerid][i]);
	            }
	            case 6:
	            {
	            	for(new i = 0; i < 20; ++i)
	    				PlayerTextDrawHide(playerid, MDC_PropertiesUI[playerid][i]);
	            }
			}

			if(GetPVarInt(playerid, "MDC_ViewingVehicle"))
			{
				for(new i = 0; i < sizeof(MDC_VehicleUI[]); ++i)
					PlayerTextDrawHide(playerid, MDC_VehicleUI[playerid][i]);
			}

			PlayerTextDrawHide(playerid, MDC_UI[playerid][38]);

			//ResetMDCData(playerid);
	    }
	    case 2:
	    {
	        for(new i = 0; i < sizeof(MDC_Emergency[]); i ++)
				PlayerTextDrawHide(playerid, MDC_Emergency[playerid][i]);
	    }
	    case 3:
	    {
	        switch(e_Player_MDC_Cache[playerid][unit_temp_page])
	        {
	            case 0:
	            {
			        for(new i = 0; i < sizeof(MDC_RosterUI[]); i ++)
						PlayerTextDrawHide(playerid, MDC_RosterUI[playerid][i]);
				}
	            /*case 1:
	            {
	                PlayerTextDrawHide(playerid, MDC_UI[playerid][38]);
	            
			        for(new i = 0; i < 21; i ++)
						PlayerTextDrawHide(playerid, MDC_UnitTemplates[playerid][i]);
				}
				case 2:
				{
				    PlayerTextDrawHide(playerid, MDC_UI[playerid][38]);
				
					for(new i = 21; i < 34; ++i)
					{
					    PlayerTextDrawHide(playerid, MDC_UnitTemplates[playerid][i]);
					}
				}*/
			}
			
			e_Player_MDC_Cache[playerid][unit_temp_page] = 0;
	    }
	    case 5:
	    {
	        for(new i = 0; i < sizeof(MDC_VehicleBOLO[]); i ++)
	            PlayerTextDrawHide(playerid, MDC_VehicleBOLO[playerid][i]);
	    }
	}
	return true;
}

stock MDC_ShowPage(playerid, page, lastpage = -1)
{
	if(e_Player_MDC_Cache[playerid][faction_type] == FACTION_MEDIC)
	{
	    switch(page)
	    {
	        case 1:
				page = 2;
	        case 2:
				page = 3;
	    }
	}

	switch(page)
	{
	    case 0:
	    {
	        for(new i = 10; i < 18; i ++) PlayerTextDrawShow(playerid, MDC_UI[playerid][i]);
	    }
	    case 1:
	    {
	        if(GetPVarInt(playerid, "MDC_ViewingProfile"))
	        {
	            if(lastpage != 1)
				{
					MDC_ChangeProfilePage(playerid, e_Player_MDC_Cache[playerid][current_page], -1);
				}
	            else MDC_ChangeProfilePage(playerid, 1, e_Player_MDC_Cache[playerid][current_page]);
			}
			else if(GetPVarInt(playerid, "MDC_ViewingVehicle"))
			{
		        for(new i = 18; i < 23; i ++)
					PlayerTextDrawShow(playerid, MDC_UI[playerid][i]);
			
			    MDC_GatherInformation(playerid, e_Player_MDC_Cache[playerid][vehicle_dbid], 2);
			}
			else
	        {
		        PlayerTextDrawSetString(playerid, MDC_UI[playerid][21], "_");

		        for(new i = 18; i < 23; i ++)
					PlayerTextDrawShow(playerid, MDC_UI[playerid][i]);
			}
	    }
	    case 3:
	    {
	        for(new i = 0; i < 3; i ++)
				PlayerTextDrawShow(playerid, MDC_RosterUI[playerid][i]);

			if(HasFactionRank(playerid, 1)) PlayerTextDrawShow(playerid, MDC_RosterUI[playerid][3]);
	    }
	}
	return true;
}

stock ShowEmergencyCalls(playerid, page, wholepage = -1, bool:reset = false)
{
	if(wholepage > -1) PenalCodePage[playerid] = wholepage;
	
	if(reset) for(new i = 0; i < 27; ++i) PlayerTextDrawHide(playerid, MDC_Emergency[playerid][i]);

	new idx = 0, count = 0, string[256];
	
	new cpage = PenalCodePage[playerid], bool:next_page = false;

	for(new i = page; i >= 0; i--)
	{
	    if(count == 5)
		{
		    if(EmergencyCalls[i][Caller] != INVALID_PLAYER_ID) next_page = true;
		
			break;
		}
	    
	    if(EmergencyCalls[i][Caller] == INVALID_PLAYER_ID) continue;
	    
	    if(strlen(EmergencyCalls[i][CallerSituation]) > 52) format(string, sizeof(string), "#%d %s~n~%s~n~%s~n~%.49s...~n~%s~n~~r~Not handled", EmergencyCalls[i][CallerNumber], EmergencyCalls[i][CallerName], EmergencyCalls[i][CallerServices], EmergencyCalls[i][CallerLocation], EmergencyCalls[i][CallerSituation], EmergencyCalls[i][CallerTime]);
	    else format(string, sizeof(string), "#%d %s~n~%s~n~%s~n~%s~n~%s~n~~r~Not handled", EmergencyCalls[i][CallerNumber], EmergencyCalls[i][CallerName], EmergencyCalls[i][CallerServices], EmergencyCalls[i][CallerLocation], EmergencyCalls[i][CallerSituation], EmergencyCalls[i][CallerTime]);
	    
	    PlayerTextDrawSetString(playerid, MDC_Emergency[playerid][idx + 2], string);
	    
	    count++;
	    
	    idx += 5;
	    
	    if(count == 1) CachedPages[playerid][cpage][0] = i;
	    
	    CachedPages[playerid][cpage][1] = i - 1;
	}

	for(new i = 0; i < count * 5; i += 5)
	{
	    if(i >= ((count * 5) - 1) ) break;
	
		PlayerTextDrawShow(playerid, MDC_Emergency[playerid][i]);
		PlayerTextDrawShow(playerid, MDC_Emergency[playerid][i + 1]);
		PlayerTextDrawShow(playerid, MDC_Emergency[playerid][i + 2]);
		PlayerTextDrawShow(playerid, MDC_Emergency[playerid][i + 3]);
		PlayerTextDrawShow(playerid, MDC_Emergency[playerid][i + 4]);
	}
	
	if(cpage != 0) PlayerTextDrawShow(playerid, MDC_Emergency[playerid][25]);
	if(next_page) PlayerTextDrawShow(playerid, MDC_Emergency[playerid][26]);
	
	return true;
}

Dialog:CreateBolo(playerid, response, listitem, inputtext[])
{
    if(!response) return true;

	SetPVarString(playerid, "BOLO_VehicleModel", inputtext);
	
	new str[500];
	
	format(str, sizeof(str), "\t\t{8D8DFF}LOS SANTOS POLICE DEPARTMENT\n\t\t\t{FF6347}SUBMIT A VEHICLE ALERT\n\n{FF6347}Vehicle Model:\n\t{FFFFFF}%s\n\nWhat's the vehicle plate? Partial plates acceptable.", inputtext);
	
	Dialog_Show(playerid, BoloPlate, DIALOG_STYLE_INPUT, "Submit Vehicle Alert", str, "Submit", "Exit");
	return true;
}

Dialog:BoloPlate(playerid, response, listitem, inputtext[])
{
	if(!response) return true;

	SetPVarString(playerid, "BOLO_VehiclePlate", inputtext);

	new
		str[500],
		model[200]
	;
	
	GetPVarString(playerid, "BOLO_VehicleModel", model, 200);

	format(str, sizeof(str), "\t\t{8D8DFF}LOS SANTOS POLICE DEPARTMENT\n\t\t\t{FF6347}SUBMIT A VEHICLE ALERT\n\n{FF6347}Vehicle Model:\n\t{FFFFFF}%s\n\n{FF6347}Vehicle Plate:\n\t{FFFFFF}%s\n\nWhat's the alert for? Enter charges.", model, inputtext);

	Dialog_Show(playerid, BoloCharges, DIALOG_STYLE_INPUT, "Submit Vehicle Alert", str, "Submit", "Exit");
	return true;
}

Dialog:BoloCharges(playerid, response, listitem, inputtext[])
{
	if(!response) return true;

	SetPVarString(playerid, "BOLO_VehicleCharges", inputtext);

	new
		str[500],
		model[200],
		plate[200]
	;

	GetPVarString(playerid, "BOLO_VehicleModel", model, 200);
	GetPVarString(playerid, "BOLO_VehiclePlate", plate, 200);

	format(str, sizeof(str), "\t\t{8D8DFF}LOS SANTOS POLICE DEPARTMENT\n\t\t\t{FF6347}SUBMIT A VEHICLE ALERT\n\n{FF6347}Vehicle Model:\n\t{FFFFFF}%s\n\n{FF6347}Vehicle Plate:\n\t{FFFFFF}%s\n\n{FF6347}Vehicle Crimes:\n\t{FFFFFF}%s\n\nHit Submit after your review this.", model, plate, inputtext);

	Dialog_Show(playerid, BoloConfirm, DIALOG_STYLE_MSGBOX, "Submit Vehicle Alert", str, "Submit", "Exit");
	return true;
}

enum BOLO_DATA
{
	bool:Exists,
	boloModel[60],
	boloPlate[24],
	boloCharges[128],
	lastPing
};

new VehicleBOLOS[MAX_VEHICLE_BOLOS][BOLO_DATA];

Dialog:BoloConfirm(playerid, response, listitem, inputtext[])
{
    if(!response)
    {
        DeletePVar(playerid, "BOLO_VehicleModel");
        DeletePVar(playerid, "BOLO_VehiclePlate");
        DeletePVar(playerid, "BOLO_VehicleCharges");
        return true;
    }
    
	new idx = -1;

	for(new i = 0; i < MAX_VEHICLE_BOLOS; ++i)
	{
		if(!VehicleBOLOS[i][Exists])
		{
		    VehicleBOLOS[i][Exists] = true;
		    VehicleBOLOS[i][lastPing] = 0;
		    
		    GetPVarString(playerid, "BOLO_VehicleModel", VehicleBOLOS[i][boloModel], 60);
		    GetPVarString(playerid, "BOLO_VehiclePlate", VehicleBOLOS[i][boloPlate], 24);
		    GetPVarString(playerid, "BOLO_VehicleCharges", VehicleBOLOS[i][boloCharges], 128);
		    
		    idx = i;
		    break;
		}
	}
	
	if(idx == -1) return SendErrorMessage(playerid, "Something went wrong, contact an administrator.");
    
    SendPoliceMessage(COLOR_POLICE, "* HQ: %s %s has placed a BOLO on license plate %s for: %s", Faction_GetRank(playerid), ReturnName(playerid, 0), VehicleBOLOS[idx][boloPlate], VehicleBOLOS[idx][boloCharges]);
	SendPoliceMessage(COLOR_WHITE, "[{8D8DFF}MDC ALERT{FFFFFF}] Vehicle Alert Posted");
	
	foreach (new i : Player)
	{
	    if(!UsingMDC{i}) continue;
	
	    new
			cached_page = GetPVarInt(i, "LastPage_ID")
		;
	
	    if(cached_page == 5) ShowVehicleBOLOS(i);
	}
	
 	DeletePVar(playerid, "BOLO_VehicleModel");
 	DeletePVar(playerid, "BOLO_VehiclePlate");
 	DeletePVar(playerid, "BOLO_VehicleCharges");
	return true;
}

stock ShowVehicleBOLOS(playerid)
{
	PlayerTextDrawShow(playerid, MDC_VehicleBOLO[playerid][0]);
	
	new
	    count = 1,
	    str[128]
	;
	
	for(new i = 0; i < MAX_VEHICLE_BOLOS; ++i)
	{
	    if(count > 10) break;
	
		if(VehicleBOLOS[i][Exists])
		{
		    format(str, 128, "%s, %s", VehicleBOLOS[i][boloModel], VehicleBOLOS[i][boloPlate]);
		
		    PlayerTextDrawSetString(playerid, MDC_VehicleBOLO[playerid][count], str);
		    
		    count++;
		}
	}
	
	if(count > 1)
	{
		for(new i = 1; i < count; ++i)
		    PlayerTextDrawShow(playerid, MDC_VehicleBOLO[playerid][i]);
	}
}

/*stock MDC_ShowUnitTemplates(playerid)
{
	for(new i = 0; i < 24; ++i)
	{
	    PlayerTextDrawHide(playerid, MDC_RosterUI[playerid][i]);
	}
	
	PlayerTextDrawSetString(playerid, MDC_UI[playerid][38], "~<~_Back_to_Roster");

	for(new i = 0; i < 21; ++i)
	{
	    PlayerTextDrawShow(playerid, MDC_UnitTemplates[playerid][i]);
	}
	
	PlayerTextDrawShow(playerid, MDC_UI[playerid][38]);
	
	e_Player_MDC_Cache[playerid][unit_temp_page] = 1;
	return true;
}

stock MDC_EditUnitTemplate(playerid)
{
	for(new i = 0; i < 21; ++i)
	{
	    PlayerTextDrawHide(playerid, MDC_UnitTemplates[playerid][i]);
	}
	
	PlayerTextDrawSetString(playerid, MDC_UI[playerid][38], "~<~_Back_to_Unit_List");
	
	for(new i = 21; i < 34; ++i)
	{
	    PlayerTextDrawShow(playerid, MDC_UnitTemplates[playerid][i]);
	}
	
	PlayerTextDrawShow(playerid, MDC_UI[playerid][38]);

	e_Player_MDC_Cache[playerid][unit_temp_page] = 2;
	return true;
}*/

stock UpdatePlayerMDC(playerid, page, lastpage)
{
	new str[256], cached_page = GetPVarInt(playerid, "LastPage_ID");

	if(lastpage != -1)
	{
	    MDC_HidePage(playerid, lastpage);
	
	    if(lastpage != 0 && page != lastpage)
	    {
			MDC_DestroyPage(playerid, lastpage);
	    }
	}
	
	if(page != 0 && page != cached_page)
	{
	    MDC_CreatePage(playerid, page);
	}
	
	MDC_ShowPage(playerid, page, lastpage);
	
	if(e_Player_MDC_Cache[playerid][faction_type] == FACTION_MEDIC)
	{
	    switch(page)
	    {
	        case 1: page = 2;
	        case 2: page = 3;
	    }
	}

	switch(page)
	{
		case 0: //main page
		{
		    PlayerTextDrawSetPreviewModel(playerid, MDC_UI[playerid][10], GetPlayerSkin(playerid));
		 	format(str, sizeof(str), "%s_%s", Faction_GetRank(playerid), ReturnName(playerid));
		  	PlayerTextDrawSetString(playerid, MDC_UI[playerid][13], str);
		  	PlayerTextDrawHide(playerid, MDC_UI[playerid][10]);
            PlayerTextDrawShow(playerid, MDC_UI[playerid][10]);

            if(e_Player_MDC_Cache[playerid][faction_type] == FACTION_MEDIC)
            {
				new medics;

				foreach (new i : Player)
				{
				    if(GetFactionType(i) != FACTION_MEDIC) continue;

				    if(PlayerData[playerid][pOnDuty]) medics ++;
				}
				
				PlayerTextDrawSetString(playerid, MDC_UI[playerid][14], "Members_On_Duty");
				
				PlayerTextDrawSetString(playerid, MDC_UI[playerid][16], "Medic_Calls_Last_Hour");

				format(str, sizeof(str), "%d", medics);
				PlayerTextDrawSetString(playerid, MDC_UI[playerid][15], str);
				format(str, sizeof(str), "%d", MDC_Global_Cache[MedicCalls]);
				PlayerTextDrawSetString(playerid, MDC_UI[playerid][17], str);
            }
            else
            {
				new cops;

				foreach (new i : Player)
				{
				    if(GetFactionType(i) != FACTION_POLICE && GetFactionType(i) != FACTION_SHERIFF) continue;

				    if(PlayerData[playerid][pOnDuty]) cops ++;
				}
				
				PlayerTextDrawSetString(playerid, MDC_UI[playerid][14], "Members_On_Duty~n~Active_Warrants");
				
				PlayerTextDrawSetString(playerid, MDC_UI[playerid][16], "Calls_Last_Hour~n~Arrests_Last_Hour~n~Fines_Last_Hour");

				format(str, sizeof(str), "%d~n~TBA", cops);
				PlayerTextDrawSetString(playerid, MDC_UI[playerid][15], str);
				format(str, sizeof(str), "%d~n~%d~n~%d", MDC_Global_Cache[PoliceCalls], MDC_Global_Cache[Arrests], MDC_Global_Cache[Fines]);
				PlayerTextDrawSetString(playerid, MDC_UI[playerid][17], str);
			}
		}
		case 2: //emergency
		{
            ShowEmergencyCalls(playerid, MAX_PLAYERS - 1, 0);
		}
		case 3: //roster
		{
		    new
		        units_found = 0,
		        spacestr[15]
			;

		    foreach (new i : Player)
		    {
		        if(units_found == 20) break;

		        if(strlen(CallSign[i]) > 0)
		        {
		            switch(strlen(CallSign[i]))
		            {
		                case 1:  spacestr = "_____________";
		                case 2:  spacestr = "____________";
		                case 3:  spacestr = "___________";
		                case 4:  spacestr = "_________";
		                case 5:  spacestr = "________";
		                case 6:  spacestr = "_______";
		                case 7:  spacestr = "______";
		                case 8:  spacestr = "_____";
		                case 9:  spacestr = "____";
		                case 10: spacestr = "___";
		                case 11: spacestr = "__";
		                case 12: spacestr = "_";
		            }

		            format(str, sizeof(str), "%s%s~h~%s", CallSign[i], spacestr, ReturnNameLetter(i));
		            PlayerTextDrawSetString(playerid, MDC_RosterUI[playerid][units_found + 4], str);

		            units_found ++;
		        }
		    }

		    for(new i = 4; i < units_found + 4; ++i)
				PlayerTextDrawShow(playerid, MDC_RosterUI[playerid][i]);
				
			e_Player_MDC_Cache[playerid][unit_temp_page] = 0;
		}
		case 4: //cctv
		{

		}
		case 5: //vehicle bolo
		{
		    ShowVehicleBOLOS(playerid);
		}
	}
	
 	format(str, sizeof(str), "%s", ReturnPage(playerid, page));
  	PlayerTextDrawSetString(playerid, MDC_UI[playerid][7], str);

 	format(str, sizeof(str), "%s", ReturnFormatName(playerid)); 
  	PlayerTextDrawSetString(playerid, MDC_UI[playerid][8], str);
  	return true;
}

ReturnPage(playerid, page)
{
    new str[64], type = e_Player_MDC_Cache[playerid][faction_type];
	
	switch(type)
	{
	    case FACTION_POLICE:
	    {
	        switch(page)
	        {
				case 0: str = "Los_Santos_Police_Department";
				case 1: str = "POLICE_~>~_Look-Up";
				case 2: str = "POLICE_~>~_Emergency";
				case 3: str = "POLICE_~>~_Roster";
				case 4: str = "POLICE_~>~_CCTV";
				case 5: str = "POLICE_~>~_Vehicle_BOLOs";
			}
	    }
	    case FACTION_SHERIFF:
	    {
	        switch(page)
	        {
				case 0: str = "Los_Santos_County_Sheriff's_Department";
				case 1: str = "SHERIFF_~>~_Look-Up";
				case 2: str = "SHERIFF_~>~_Emergency";
				case 3: str = "SHERIFF_~>~_Roster";
				case 4: str = "SHERIFF_~>~_CCTV";
				case 5: str = "SHERIFF_~>~_Vehicle_BOLOs";
			}
	    }
	    case FACTION_MEDIC:
	    {
	        switch(page)
	        {
				case 0: str = "Los_Santos_Fire_Department";
				case 2: str = "MEDIC_~>~_Emergency";
				case 3: str = "MEDIC_~>~_Roster";
			}
	    }
	    default:
	    {
	        switch(page)
	        {
				case 0: str = "Los_Santos_Police_Department";
				case 1: str = "POLICE_~>~_Look-Up";
				case 2: str = "POLICE_~>~_Emergency";
				case 3: str = "POLICE_~>~_Roster";
				case 4: str = "POLICE_~>~_CCTV";
				case 5: str = "POLICE_~>~_Vehicle_BOLOs";
			}
	    }
	}

	return str;
}

FUNX::ResetMDCData(playerid)
{
    e_Player_MDC_Cache[playerid][player_name][0] = EOS;
    e_Player_MDC_Cache[playerid][player_dbid] = -1;
    e_Player_MDC_Cache[playerid][vehicle_plate][0] = EOS;
    e_Player_MDC_Cache[playerid][vehicle_dbid] = -1;
    e_Player_MDC_Cache[playerid][vehicle_id] = -1;
    e_Player_MDC_Cache[playerid][current_page] = 0;
    e_Player_MDC_Cache[playerid][unit_temp_page] = 0;
    
    DeletePVar(playerid, "MDC_ViewingProfile");
    DeletePVar(playerid, "MDC_ViewingVehicle");
    
    ActiveQuery{playerid} = false;
    return true;
}
//end of mdc functions
