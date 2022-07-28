-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 28, 2022 at 05:59 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `roleplay`
--

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE `accounts` (
  `ID` int(11) NOT NULL,
  `Username` varchar(24) DEFAULT NULL,
  `Password` varchar(129) DEFAULT NULL,
  `Online` int(11) NOT NULL DEFAULT 0,
  `Quiz` int(11) NOT NULL DEFAULT 0,
  `Admin` int(11) NOT NULL DEFAULT 0,
  `DonateRank` int(11) NOT NULL DEFAULT 0,
  `Email` varchar(32) NOT NULL,
  `SecretWord` varchar(24) NOT NULL,
  `SecretHint` varchar(24) NOT NULL,
  `RegisterDate` timestamp NOT NULL DEFAULT current_timestamp(),
  `LoginDate` int(11) NOT NULL DEFAULT 0,
  `IP` varchar(16) DEFAULT 'n/a',
  `LastIP` varchar(60) NOT NULL DEFAULT 'N/A',
  `answer1` varchar(5000) NOT NULL,
  `answer2` varchar(5000) NOT NULL,
  `answered_questions` int(11) NOT NULL DEFAULT 0,
  `Namechanges` int(11) NOT NULL DEFAULT 0,
  `Phonechanges` int(11) NOT NULL DEFAULT 0,
  `Discord` varchar(256) NOT NULL,
  `Forum` varchar(60) NOT NULL,
  `AdminNote` varchar(256) NOT NULL,
  `Serial` varchar(128) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `advertisement`
--

CREATE TABLE `advertisement` (
  `a_id` int(11) NOT NULL,
  `charid` int(11) NOT NULL,
  `text` text NOT NULL,
  `time` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `apartments`
--

CREATE TABLE `apartments` (
  `ID` int(11) NOT NULL,
  `ePosX` float NOT NULL,
  `ePosY` float NOT NULL,
  `ePosZ` float NOT NULL,
  `iPosX` float NOT NULL DEFAULT 0,
  `iPosY` float NOT NULL DEFAULT 0,
  `iPosZ` float NOT NULL DEFAULT 0,
  `interior` int(11) NOT NULL DEFAULT 0,
  `world` int(11) NOT NULL DEFAULT 0,
  `name` varchar(60) NOT NULL,
  `ownerSQLID` int(11) NOT NULL DEFAULT -1,
  `owner` varchar(24) NOT NULL DEFAULT 'The State',
  `owned` int(11) NOT NULL DEFAULT 0,
  `locked` int(11) NOT NULL DEFAULT 0,
  `price` int(11) NOT NULL DEFAULT 100000,
  `levelbuy` int(11) NOT NULL DEFAULT 1,
  `rentprice` int(11) NOT NULL DEFAULT 0,
  `rentable` int(11) NOT NULL DEFAULT 0,
  `faction` int(11) NOT NULL DEFAULT -1,
  `pickup` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `application`
--

CREATE TABLE `application` (
  `id` int(10) UNSIGNED NOT NULL,
  `master` int(11) NOT NULL,
  `char_name` varchar(24) NOT NULL,
  `story` varchar(5000) NOT NULL,
  `ip_address` varchar(60) NOT NULL,
  `country_name` varchar(40) NOT NULL,
  `country_code` varchar(10) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `reviewed_by` int(11) NOT NULL DEFAULT -1,
  `accepted` int(11) NOT NULL DEFAULT 0,
  `reason` varchar(3000) NOT NULL,
  `date_of_submit` timestamp NOT NULL DEFAULT current_timestamp(),
  `date_of_review` varchar(24) NOT NULL,
  `date_of_verdict` varchar(60) NOT NULL,
  `origin` varchar(26) NOT NULL,
  `gender` varchar(26) NOT NULL,
  `age` int(11) NOT NULL,
  `skin` int(11) NOT NULL DEFAULT 264
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ateles`
--

CREATE TABLE `ateles` (
  `id` int(11) NOT NULL,
  `mapname` varchar(255) DEFAULT NULL,
  `posx` float DEFAULT NULL,
  `posy` float DEFAULT NULL,
  `posz` float DEFAULT NULL,
  `interior` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `atms`
--

CREATE TABLE `atms` (
  `ID` int(11) NOT NULL,
  `posX` float NOT NULL,
  `posY` float NOT NULL,
  `posZ` float NOT NULL,
  `rotX` float NOT NULL,
  `rotY` float NOT NULL,
  `rotZ` float NOT NULL,
  `CreatedBy` varchar(24) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `bans`
--

CREATE TABLE `bans` (
  `id` int(11) NOT NULL,
  `name` varchar(24) DEFAULT NULL,
  `bannedby` varchar(24) NOT NULL,
  `reason` varchar(100) DEFAULT NULL,
  `playerIP` varchar(100) DEFAULT NULL,
  `perm` int(11) NOT NULL DEFAULT 1,
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  `expire` datetime NOT NULL,
  `serial` varchar(80) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `business`
--

CREATE TABLE `business` (
  `biz_id` int(11) NOT NULL,
  `biz_owned` int(11) NOT NULL,
  `biz_owner` varchar(32) NOT NULL DEFAULT 'The State',
  `biz_info` varchar(256) NOT NULL,
  `biz_items` varchar(256) NOT NULL,
  `biz_type` int(11) NOT NULL,
  `biz_subtype` int(11) NOT NULL,
  `biz_enX` float NOT NULL,
  `biz_enY` float NOT NULL,
  `biz_enZ` float NOT NULL,
  `biz_etX` float NOT NULL,
  `biz_etY` float NOT NULL,
  `biz_etZ` float NOT NULL,
  `biz_level` int(11) NOT NULL,
  `biz_price` int(11) NOT NULL,
  `biz_encost` int(11) NOT NULL,
  `biz_till` int(11) NOT NULL,
  `biz_locked` int(11) NOT NULL,
  `biz_interior` int(11) NOT NULL,
  `biz_world` int(11) NOT NULL,
  `biz_prod` int(11) NOT NULL,
  `biz_maxprod` int(11) NOT NULL,
  `biz_priceprod` int(11) NOT NULL,
  `biz_carX` float NOT NULL DEFAULT 0,
  `biz_carY` float NOT NULL DEFAULT 0,
  `biz_carZ` float NOT NULL DEFAULT 0,
  `biz_carA` float NOT NULL DEFAULT 0,
  `biz_boatX` float NOT NULL DEFAULT 0,
  `biz_boatY` float NOT NULL DEFAULT 0,
  `biz_boatZ` float NOT NULL DEFAULT 0,
  `biz_boatA` float NOT NULL DEFAULT 0,
  `biz_airX` float NOT NULL DEFAULT 0,
  `biz_airY` float NOT NULL DEFAULT 0,
  `biz_airZ` float NOT NULL DEFAULT 0,
  `biz_airA` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `business_furnitures`
--

CREATE TABLE `business_furnitures` (
  `id` int(11) NOT NULL,
  `model` int(11) DEFAULT -1,
  `name` varchar(255) DEFAULT NULL,
  `houseid` int(11) DEFAULT -1,
  `interior` int(11) DEFAULT 0,
  `virworld` int(11) DEFAULT 0,
  `marketprice` int(11) DEFAULT 0,
  `posx` float DEFAULT 0,
  `posy` float DEFAULT 0,
  `posz` float DEFAULT 0,
  `posrx` float DEFAULT 0,
  `posry` float DEFAULT 0,
  `posrz` float DEFAULT 0,
  `matModel1` int(11) NOT NULL DEFAULT -1,
  `matModel2` int(11) NOT NULL DEFAULT -1,
  `matModel3` int(11) NOT NULL DEFAULT -1,
  `matTxd1` varchar(32) NOT NULL DEFAULT 'none',
  `matTxd2` varchar(32) NOT NULL DEFAULT 'none',
  `matTxd3` varchar(32) NOT NULL DEFAULT 'none',
  `matTexture1` varchar(32) NOT NULL DEFAULT 'none',
  `matTexture2` varchar(32) NOT NULL DEFAULT 'none',
  `matTexture3` varchar(32) NOT NULL DEFAULT 'none',
  `matColor1` varchar(32) NOT NULL DEFAULT '0xFFFFFFFF',
  `matColor2` varchar(32) NOT NULL DEFAULT '0xFFFFFFFF',
  `matColor3` varchar(32) NOT NULL DEFAULT '0xFFFFFFFF'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `cars`
--

CREATE TABLE `cars` (
  `carID` int(11) NOT NULL,
  `carModel` int(11) DEFAULT 0,
  `carOwner` int(11) DEFAULT 0,
  `carName` varchar(64) NOT NULL,
  `carUItag` varchar(15) NOT NULL,
  `carPosX` float DEFAULT 0,
  `carPosY` float DEFAULT 0,
  `carPosZ` float DEFAULT 0,
  `carPosR` float DEFAULT 0,
  `carColor1` int(11) DEFAULT 0,
  `carColor2` int(11) DEFAULT 0,
  `carPaintjob` int(11) DEFAULT 3,
  `carLocked` int(11) DEFAULT 0,
  `carMod1` int(11) DEFAULT 0,
  `carMod2` int(11) DEFAULT 0,
  `carMod3` int(11) DEFAULT 0,
  `carMod4` int(11) DEFAULT 0,
  `carMod5` int(11) DEFAULT 0,
  `carMod6` int(11) DEFAULT 0,
  `carMod7` int(11) DEFAULT 0,
  `carMod8` int(11) DEFAULT 0,
  `carMod9` int(11) DEFAULT 0,
  `carMod10` int(11) DEFAULT 0,
  `carMod11` int(11) DEFAULT 0,
  `carMod12` int(11) DEFAULT 0,
  `carMod13` int(11) DEFAULT 0,
  `carMod14` int(11) DEFAULT 0,
  `carFuel` float DEFAULT 100,
  `carXM` int(11) NOT NULL DEFAULT 0,
  `carInsurance` int(11) DEFAULT 0,
  `carInsuranceOwe` int(11) NOT NULL,
  `carInsuranceTime` int(11) NOT NULL,
  `carDamage1` int(11) DEFAULT 0,
  `carDamage2` int(11) DEFAULT 0,
  `carDamage3` int(11) DEFAULT 0,
  `carDamage4` int(11) DEFAULT 0,
  `carDestroyed` int(11) DEFAULT 0,
  `carHealth` float DEFAULT 0,
  `carArmour` float NOT NULL DEFAULT 0,
  `carLock` int(11) DEFAULT 0,
  `carMileage` float DEFAULT 0,
  `carImmob` int(11) DEFAULT 0,
  `carAlarm` int(11) NOT NULL DEFAULT 0,
  `carBatteryL` float NOT NULL DEFAULT 100,
  `carEngineL` float NOT NULL DEFAULT 100,
  `carPlate` varchar(32) NOT NULL DEFAULT 'None',
  `carDate` int(11) DEFAULT NULL,
  `carComps` int(11) NOT NULL DEFAULT 0,
  `carDuplicate` int(11) NOT NULL,
  `licenseWeapons` varchar(255) NOT NULL,
  `carWeapon0` int(11) NOT NULL,
  `carWeapon1` int(11) NOT NULL,
  `carWeapon2` int(11) NOT NULL,
  `carWeapon3` int(11) NOT NULL,
  `carAmmo0` int(11) NOT NULL,
  `carAmmo1` int(11) NOT NULL,
  `carAmmo2` int(11) NOT NULL,
  `carAmmo3` int(11) NOT NULL,
  `carPlacePos` varchar(255) NOT NULL,
  `carPackageWeapons` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `characters`
--

CREATE TABLE `characters` (
  `ID` int(11) NOT NULL,
  `master` int(11) NOT NULL,
  `char_name` varchar(24) NOT NULL DEFAULT 'Test_Test',
  `Online` int(11) NOT NULL DEFAULT 0,
  `Tutorial` int(11) DEFAULT 0,
  `Activated` int(11) NOT NULL DEFAULT 0,
  `Model` int(11) DEFAULT 264,
  `PhoneNumbr` int(11) NOT NULL DEFAULT 0,
  `PhoneModel` int(11) NOT NULL DEFAULT 0,
  `PhoneSilent` int(11) NOT NULL DEFAULT 0,
  `PhoneAir` int(11) NOT NULL DEFAULT 0,
  `PhoneRingtone` int(11) NOT NULL DEFAULT 0,
  `PhoneTextRingtone` int(11) NOT NULL,
  `PosX` float DEFAULT 0,
  `PosY` float DEFAULT 0,
  `PosZ` float DEFAULT 0,
  `PosA` float DEFAULT 0,
  `Local` int(11) NOT NULL DEFAULT 255,
  `SpawnHealth` float NOT NULL DEFAULT 50,
  `Hunger` float NOT NULL DEFAULT 0,
  `Health` float NOT NULL DEFAULT 150,
  `Armour` float NOT NULL DEFAULT 0,
  `Interior` int(11) DEFAULT 0,
  `World` int(11) DEFAULT 0,
  `Faction` int(11) NOT NULL DEFAULT -1,
  `FactionRank` int(11) NOT NULL DEFAULT 0,
  `FactionSpawn` int(11) NOT NULL DEFAULT 0,
  `Injured` int(11) NOT NULL DEFAULT 0,
  `playerTimeout` int(11) NOT NULL DEFAULT 0,
  `timeoutProp` int(11) NOT NULL DEFAULT -1,
  `timeoutApp` int(11) NOT NULL DEFAULT -1,
  `timeoutBizz` int(11) NOT NULL DEFAULT -1,
  `SpawnPoint` int(11) NOT NULL DEFAULT 0,
  `PlayingHours` int(11) NOT NULL DEFAULT 0,
  `PlayingSeconds` int(11) NOT NULL DEFAULT 0,
  `CreateDate` int(11) DEFAULT 0,
  `LastLogin` int(11) DEFAULT 0,
  `LastIP` varchar(16) NOT NULL,
  `Level` int(11) NOT NULL DEFAULT 1,
  `Exp` int(11) NOT NULL DEFAULT 0,
  `ExpCounter` int(11) NOT NULL DEFAULT 0,
  `MedicBill` int(11) NOT NULL DEFAULT 0,
  `plaUpgrade` int(11) NOT NULL DEFAULT 0,
  `DonateRank` int(11) NOT NULL DEFAULT 0,
  `DonateExpired` int(11) NOT NULL DEFAULT 0,
  `PayDay` int(11) NOT NULL DEFAULT 0,
  `PayDayHad` int(11) NOT NULL DEFAULT 0,
  `PayCheck` int(11) NOT NULL DEFAULT 0,
  `ChequeCash` int(11) NOT NULL,
  `BankAccount` int(11) NOT NULL DEFAULT 5000,
  `Cash` int(11) NOT NULL DEFAULT 10000,
  `Savings` int(11) NOT NULL DEFAULT 0,
  `SavingsCollect` int(11) NOT NULL,
  `playerHouseKey` int(11) NOT NULL DEFAULT -1,
  `playerComplexKey` int(11) NOT NULL DEFAULT -1,
  `PlayerBusinessKey` int(11) NOT NULL DEFAULT -1,
  `Gun1` int(11) NOT NULL DEFAULT 0,
  `Gun2` int(11) NOT NULL DEFAULT 0,
  `Gun3` int(11) NOT NULL DEFAULT 0,
  `Ammo1` int(11) NOT NULL DEFAULT 0,
  `Ammo2` int(11) NOT NULL DEFAULT 0,
  `Ammo3` int(11) NOT NULL DEFAULT 0,
  `OnDuty` int(11) NOT NULL DEFAULT 0,
  `OnDutySkin` int(11) NOT NULL DEFAULT 0,
  `FavUniform` int(11) NOT NULL DEFAULT 0,
  `Radio` int(11) NOT NULL DEFAULT 0,
  `RadioChannel` int(11) NOT NULL DEFAULT 0,
  `RadioSlot` int(11) NOT NULL DEFAULT 0,
  `playerJob` int(11) NOT NULL DEFAULT 0,
  `playerSideJob` int(11) NOT NULL DEFAULT 0,
  `playerJobRank` int(11) NOT NULL DEFAULT 0,
  `ContractTime` int(11) NOT NULL DEFAULT 0,
  `playerCareer` int(11) NOT NULL DEFAULT 0,
  `PlayerCarkey` int(11) NOT NULL DEFAULT 9999,
  `Checkpoint_Type` int(11) NOT NULL DEFAULT -1,
  `Checkpoint_X` float NOT NULL DEFAULT 0,
  `Checkpoint_Y` float NOT NULL DEFAULT 0,
  `Checkpoint_Z` float NOT NULL DEFAULT 0,
  `Fishes` int(11) NOT NULL DEFAULT 0,
  `QAPoint` int(11) NOT NULL DEFAULT 0,
  `Masked` int(11) NOT NULL DEFAULT 0,
  `MaskID` int(11) NOT NULL DEFAULT 0,
  `MaskIDEx` int(11) NOT NULL DEFAULT 0,
  `Attribute` varchar(500) NOT NULL,
  `Jailed` int(11) NOT NULL,
  `SentenceTime` int(11) NOT NULL,
  `Incarcerated` int(11) NOT NULL DEFAULT 0,
  `FightStyle` int(11) NOT NULL DEFAULT 1,
  `CarLic` int(11) NOT NULL,
  `CarLicWarns` int(11) NOT NULL DEFAULT 0,
  `CarLicSuspended` int(11) NOT NULL DEFAULT 0,
  `FlyLic` int(11) NOT NULL DEFAULT 0,
  `MedLic` int(11) NOT NULL DEFAULT 0,
  `TruckLic` int(11) NOT NULL DEFAULT 0,
  `WepLic` int(11) NOT NULL,
  `ADPoint` int(11) NOT NULL,
  `PackageWeapons` varchar(255) NOT NULL,
  `PrimaryLicense` int(11) NOT NULL,
  `SecondaryLicense` int(11) NOT NULL,
  `CCWLicense` int(11) NOT NULL,
  `pWalk` int(11) NOT NULL DEFAULT 1,
  `pTalk` int(11) NOT NULL DEFAULT 0,
  `pJog` int(11) NOT NULL DEFAULT 1,
  `pHUDStyle` int(11) NOT NULL DEFAULT 0,
  `HudToggle` int(11) NOT NULL DEFAULT 0,
  `LoginToggle` int(11) NOT NULL DEFAULT 0,
  `LoginSound` int(11) NOT NULL DEFAULT 0,
  `LoginNotify` int(11) NOT NULL DEFAULT 0,
  `MainSlot` int(11) NOT NULL DEFAULT 1,
  `PrisonSkin` int(11) NOT NULL DEFAULT 0,
  `PrisonTimes` int(11) NOT NULL DEFAULT 0,
  `JailTimes` int(11) NOT NULL DEFAULT 0,
  `ActiveListings` int(11) NOT NULL DEFAULT 0,
  `SprayBanned` int(11) NOT NULL DEFAULT 0,
  `Cigarettes` int(11) NOT NULL DEFAULT 0,
  `Drinks` int(11) NOT NULL DEFAULT 0,
  `GasCan` int(11) NOT NULL DEFAULT 0,
  `TotalDamages` int(11) NOT NULL DEFAULT 0,
  `LastBlow` int(11) NOT NULL DEFAULT 0,
  `Knockout` int(11) NOT NULL DEFAULT 0,
  `DrugStamp` int(11) NOT NULL DEFAULT 0,
  `AdminDuty` int(11) NOT NULL DEFAULT 0,
  `TesterDuty` int(11) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `cheques`
--

CREATE TABLE `cheques` (
  `id` int(6) UNSIGNED ZEROFILL NOT NULL,
  `owner_ID` int(11) NOT NULL,
  `sender` varchar(255) NOT NULL,
  `reciever` varchar(255) NOT NULL,
  `amount` int(11) NOT NULL,
  `code` varchar(255) NOT NULL,
  `stamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `clothing`
--

CREATE TABLE `clothing` (
  `id` int(11) NOT NULL,
  `object` int(11) NOT NULL,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `rx` float NOT NULL,
  `ry` float NOT NULL,
  `rz` float NOT NULL,
  `bone` int(11) NOT NULL,
  `slot` int(11) NOT NULL,
  `owner` int(11) NOT NULL,
  `equip` tinyint(1) NOT NULL,
  `scalex` float NOT NULL DEFAULT 1,
  `scaley` float NOT NULL DEFAULT 1,
  `scalez` float NOT NULL DEFAULT 1,
  `name` varchar(32) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `criminal_record`
--

CREATE TABLE `criminal_record` (
  `idx` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `player_name` varchar(32) NOT NULL,
  `issuer_name` varchar(32) NOT NULL,
  `charge_type` int(11) NOT NULL,
  `charge_quote` varchar(128) NOT NULL,
  `charges_count` int(11) NOT NULL DEFAULT 0,
  `charge_idx` int(11) NOT NULL DEFAULT 0,
  `charge_row` int(11) NOT NULL DEFAULT 0,
  `add_date` varchar(90) NOT NULL,
  `add_time` varchar(90) NOT NULL,
  `arrest_record` varchar(2000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `damages`
--

CREATE TABLE `damages` (
  `ID` int(11) NOT NULL,
  `damageTaken` int(11) NOT NULL,
  `damageTime` int(11) NOT NULL,
  `damageWeapon` int(11) NOT NULL,
  `damageBodypart` int(11) NOT NULL,
  `damageArmor` int(11) NOT NULL,
  `damageBy` int(11) NOT NULL,
  `playerID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `emergency`
--

CREATE TABLE `emergency` (
  `id` int(11) NOT NULL,
  `name` varchar(32) NOT NULL,
  `number` int(11) NOT NULL,
  `service` varchar(16) NOT NULL,
  `trace` varchar(32) NOT NULL,
  `location` varchar(32) NOT NULL,
  `situation` varchar(128) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `factions`
--

CREATE TABLE `factions` (
  `factionID` int(11) NOT NULL,
  `factionName` varchar(60) DEFAULT NULL,
  `factionLeader` varchar(24) NOT NULL,
  `factionShort` varchar(20) NOT NULL,
  `factionColor` int(11) DEFAULT 0,
  `factionColorChat` int(11) NOT NULL,
  `factionType` int(11) DEFAULT 0,
  `factionMaxMembers` int(11) NOT NULL DEFAULT 90,
  `factionMaxVehicles` int(11) NOT NULL DEFAULT 10,
  `factionRanks` int(11) DEFAULT 0,
  `factionRank1` varchar(32) DEFAULT NULL,
  `factionRank2` varchar(32) DEFAULT NULL,
  `factionRank3` varchar(32) DEFAULT NULL,
  `factionRank4` varchar(32) DEFAULT NULL,
  `factionRank5` varchar(32) DEFAULT NULL,
  `factionRank6` varchar(32) DEFAULT NULL,
  `factionRank7` varchar(32) DEFAULT NULL,
  `factionRank8` varchar(32) DEFAULT NULL,
  `factionRank9` varchar(32) DEFAULT NULL,
  `factionRank10` varchar(32) DEFAULT NULL,
  `factionRank11` varchar(32) DEFAULT NULL,
  `factionRank12` varchar(32) DEFAULT NULL,
  `factionRank13` varchar(32) DEFAULT NULL,
  `factionRank14` varchar(32) DEFAULT NULL,
  `factionRank15` varchar(32) DEFAULT NULL,
  `factionRank16` varchar(32) DEFAULT NULL,
  `factionRank17` varchar(32) DEFAULT NULL,
  `factionRank18` varchar(32) DEFAULT NULL,
  `factionRank19` varchar(32) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `factionspawns`
--

CREATE TABLE `factionspawns` (
  `id` int(11) NOT NULL,
  `factionID` float NOT NULL,
  `SpawnX` float NOT NULL,
  `SpawnY` float NOT NULL,
  `SpawnZ` float NOT NULL,
  `SpawnA` float NOT NULL,
  `Interior` int(11) NOT NULL,
  `World` int(11) NOT NULL,
  `Apartment` int(11) NOT NULL DEFAULT -1,
  `Local` int(11) NOT NULL,
  `Name` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `fines`
--

CREATE TABLE `fines` (
  `id` int(11) NOT NULL,
  `cop` varchar(255) NOT NULL,
  `addressee` varchar(255) NOT NULL,
  `agency` varchar(255) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  `price` int(11) NOT NULL,
  `reason` varchar(255) NOT NULL,
  `exp` int(11) NOT NULL,
  `type` int(11) NOT NULL COMMENT '0 - Player, 1 - Vehicle'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `flags`
--

CREATE TABLE `flags` (
  `ID` int(11) NOT NULL,
  `Text` varchar(256) NOT NULL,
  `userid` int(11) NOT NULL,
  `master_name` varchar(24) NOT NULL,
  `char_name` varchar(24) NOT NULL,
  `admin_name` varchar(24) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `gates`
--

CREATE TABLE `gates` (
  `id` int(11) NOT NULL,
  `model` int(11) DEFAULT NULL,
  `faction` int(11) DEFAULT NULL,
  `posx` float DEFAULT NULL,
  `posy` float DEFAULT NULL,
  `posz` float DEFAULT NULL,
  `posrx` float DEFAULT NULL,
  `posry` float DEFAULT NULL,
  `posrz` float DEFAULT NULL,
  `interior` int(11) DEFAULT NULL,
  `virworld` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `openspeed` float NOT NULL,
  `movex` float NOT NULL,
  `movey` float NOT NULL,
  `movez` float NOT NULL,
  `moverx` float NOT NULL,
  `movery` float NOT NULL,
  `moverz` float NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `houses`
--

CREATE TABLE `houses` (
  `id` int(11) NOT NULL,
  `posx` float DEFAULT 0,
  `posy` float DEFAULT 0,
  `posz` float DEFAULT 0,
  `exitx` float DEFAULT 0,
  `exity` float DEFAULT 0,
  `exitz` float DEFAULT 0,
  `info` varchar(128) NOT NULL,
  `ownerSQLID` int(11) NOT NULL DEFAULT -1,
  `owner` varchar(255) DEFAULT NULL,
  `owned` int(11) DEFAULT 0,
  `locked` int(11) DEFAULT 0,
  `price` int(11) DEFAULT 0,
  `levelbuy` int(11) DEFAULT 0,
  `rentprice` int(11) DEFAULT 0,
  `rentable` int(11) DEFAULT 0,
  `interior` int(11) DEFAULT 0,
  `world` int(11) DEFAULT 0,
  `cash` int(11) DEFAULT 0,
  `weapons` text DEFAULT NULL,
  `checkx` float DEFAULT 0,
  `checky` float DEFAULT 0,
  `checkz` float DEFAULT 0,
  `radio` int(11) DEFAULT NULL,
  `subid` int(11) NOT NULL DEFAULT -1,
  `items` varchar(64) NOT NULL,
  `complex` int(11) NOT NULL DEFAULT -1,
  `scriptid` int(11) NOT NULL DEFAULT -1
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `house_furnitures`
--

CREATE TABLE `house_furnitures` (
  `id` int(11) NOT NULL,
  `model` int(11) DEFAULT -1,
  `name` varchar(255) DEFAULT NULL,
  `houseid` int(11) DEFAULT -1,
  `interior` int(11) DEFAULT 0,
  `virworld` int(11) DEFAULT 0,
  `marketprice` int(11) DEFAULT 0,
  `posx` float DEFAULT 0,
  `posy` float DEFAULT 0,
  `posz` float DEFAULT 0,
  `posrx` float DEFAULT 0,
  `posry` float DEFAULT 0,
  `posrz` float DEFAULT 0,
  `matModel1` int(11) NOT NULL DEFAULT -1,
  `matModel2` int(11) NOT NULL DEFAULT -1,
  `matModel3` int(11) NOT NULL DEFAULT -1,
  `matTxd1` varchar(32) NOT NULL DEFAULT 'none',
  `matTxd2` varchar(32) NOT NULL DEFAULT 'none',
  `matTxd3` varchar(32) NOT NULL DEFAULT 'none',
  `matTexture1` varchar(32) NOT NULL DEFAULT 'none',
  `matTexture2` varchar(32) NOT NULL DEFAULT 'none',
  `matTexture3` varchar(32) NOT NULL DEFAULT 'none',
  `matColor1` varchar(32) NOT NULL DEFAULT '0xFFFFFFFF',
  `matColor2` varchar(32) NOT NULL DEFAULT '0xFFFFFFFF',
  `matColor3` varchar(32) NOT NULL DEFAULT '0xFFFFFFFF'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `industry`
--

CREATE TABLE `industry` (
  `id` int(11) NOT NULL,
  `posx` float NOT NULL,
  `posy` float NOT NULL,
  `posz` float NOT NULL,
  `item` int(11) NOT NULL,
  `industryid` int(11) NOT NULL,
  `trading_type` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `consumption` int(11) NOT NULL,
  `stock` int(11) NOT NULL,
  `maximum` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `logs_all`
--

CREATE TABLE `logs_all` (
  `ID` int(11) NOT NULL,
  `User` int(11) NOT NULL,
  `Log` varchar(256) NOT NULL,
  `Timestamp` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `logs_ban`
--

CREATE TABLE `logs_ban` (
  `id` int(11) NOT NULL,
  `IP` varchar(16) DEFAULT '0.0.0.0',
  `Character` varchar(24) DEFAULT NULL,
  `BannedBy` varchar(24) DEFAULT NULL,
  `Reason` varchar(128) DEFAULT NULL,
  `Date` timestamp NOT NULL DEFAULT current_timestamp(),
  `character_id` int(11) NOT NULL DEFAULT -1,
  `user_id` int(11) NOT NULL DEFAULT -1
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `logs_connection`
--

CREATE TABLE `logs_connection` (
  `id` int(11) NOT NULL,
  `ip` varchar(255) NOT NULL,
  `master` varchar(24) NOT NULL,
  `char_name` varchar(24) NOT NULL,
  `stamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `disconnected` datetime NOT NULL,
  `serial` varchar(128) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `logs_death`
--

CREATE TABLE `logs_death` (
  `id` int(10) UNSIGNED NOT NULL,
  `killer` varchar(64) NOT NULL,
  `victim` varchar(64) NOT NULL,
  `reason` smallint(6) NOT NULL,
  `killerid` int(11) NOT NULL,
  `victimid` int(11) NOT NULL,
  `stamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `logs_jail`
--

CREATE TABLE `logs_jail` (
  `id` int(11) NOT NULL,
  `IP` varchar(16) DEFAULT '0.0.0.0',
  `Character` varchar(24) DEFAULT NULL,
  `JailedBy` varchar(24) DEFAULT NULL,
  `Minutes` int(11) NOT NULL,
  `Reason` varchar(128) DEFAULT NULL,
  `Date` timestamp NOT NULL DEFAULT current_timestamp(),
  `character_id` int(11) NOT NULL DEFAULT -1,
  `user_id` int(11) NOT NULL DEFAULT -1
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `logs_kick`
--

CREATE TABLE `logs_kick` (
  `id` int(11) NOT NULL,
  `IP` varchar(16) DEFAULT '0.0.0.0',
  `Character` varchar(24) DEFAULT NULL,
  `KickedBy` varchar(24) DEFAULT NULL,
  `Reason` varchar(128) DEFAULT NULL,
  `Date` timestamp NOT NULL DEFAULT current_timestamp(),
  `character_id` int(11) NOT NULL DEFAULT -1,
  `user_id` int(11) NOT NULL DEFAULT -1
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `logs_mask`
--

CREATE TABLE `logs_mask` (
  `id` int(10) UNSIGNED NOT NULL,
  `admin` int(11) NOT NULL,
  `action_key` varchar(128) NOT NULL,
  `action_log` varchar(255) NOT NULL,
  `stamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `logs_spray`
--

CREATE TABLE `logs_spray` (
  `ID` int(11) NOT NULL,
  `SprayID` int(11) NOT NULL,
  `Log` varchar(256) NOT NULL,
  `Timestamp` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `motd`
--

CREATE TABLE `motd` (
  `id` int(11) NOT NULL,
  `Line1` varchar(256) NOT NULL,
  `Line2` varchar(256) NOT NULL,
  `Line3` varchar(256) NOT NULL,
  `Line4` varchar(256) NOT NULL,
  `Line5` varchar(256) NOT NULL,
  `EditedBy` varchar(24) NOT NULL,
  `EditedDate` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `movedoors`
--

CREATE TABLE `movedoors` (
  `id` int(11) NOT NULL,
  `model` int(11) DEFAULT NULL,
  `faction` int(11) DEFAULT NULL,
  `posx` float DEFAULT NULL,
  `posy` float DEFAULT NULL,
  `posz` float DEFAULT NULL,
  `posrx` float DEFAULT NULL,
  `posry` float DEFAULT NULL,
  `posrz` float DEFAULT NULL,
  `interior` int(11) DEFAULT NULL,
  `virworld` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `openspeed` float NOT NULL,
  `movex` float NOT NULL,
  `movey` float NOT NULL,
  `movez` float NOT NULL,
  `moverx` float NOT NULL,
  `movery` float NOT NULL,
  `moverz` float NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `namechanges`
--

CREATE TABLE `namechanges` (
  `namechangeid` int(11) NOT NULL,
  `charid` int(11) NOT NULL,
  `oldname` varchar(24) NOT NULL,
  `newname` varchar(24) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `ID` int(11) NOT NULL,
  `master` int(11) NOT NULL,
  `title` varchar(60) NOT NULL,
  `body` varchar(1500) DEFAULT '0',
  `time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `read` int(11) DEFAULT 0,
  `sender` varchar(24) NOT NULL,
  `friend` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `particles`
--

CREATE TABLE `particles` (
  `ID` int(11) NOT NULL,
  `Creator` varchar(24) NOT NULL,
  `Model` int(11) NOT NULL,
  `PosX` float NOT NULL DEFAULT 0,
  `PosY` float NOT NULL DEFAULT 0,
  `PosZ` float NOT NULL DEFAULT 0,
  `RotX` float NOT NULL DEFAULT 0,
  `RotY` float NOT NULL DEFAULT 0,
  `RotZ` float NOT NULL DEFAULT 0,
  `Stamp` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `phone_contacts`
--

CREATE TABLE `phone_contacts` (
  `contactID` int(11) NOT NULL,
  `contactAdded` int(11) NOT NULL,
  `contactAddee` int(11) NOT NULL,
  `contactName` varchar(24) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `phone_sms`
--

CREATE TABLE `phone_sms` (
  `id` int(11) NOT NULL,
  `PhoneOwner` int(11) NOT NULL,
  `PhoneReceive` int(11) NOT NULL,
  `PhoneSMS` varchar(128) NOT NULL,
  `ReadSMS` int(11) NOT NULL DEFAULT 0,
  `Archive` int(11) NOT NULL DEFAULT 0,
  `Date` varchar(36) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `player_drugs`
--

CREATE TABLE `player_drugs` (
  `idx` int(11) NOT NULL,
  `drugType` int(11) NOT NULL,
  `drugAmount` float NOT NULL,
  `drugStrength` float NOT NULL,
  `drugStorage` int(11) NOT NULL,
  `drugStamp` int(11) NOT NULL,
  `PlayerSQLID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `points`
--

CREATE TABLE `points` (
  `ID` int(11) NOT NULL,
  `outsideX` float NOT NULL,
  `outsideY` float NOT NULL,
  `outsideZ` float NOT NULL,
  `outsideA` float NOT NULL,
  `insideX` float NOT NULL DEFAULT 0,
  `insideY` float NOT NULL DEFAULT 0,
  `insideZ` float NOT NULL DEFAULT 0,
  `insideA` float NOT NULL DEFAULT 0,
  `outsideApartment` int(11) NOT NULL DEFAULT -1,
  `insideApartment` int(11) NOT NULL DEFAULT -1,
  `pointRange` float NOT NULL DEFAULT 3,
  `pointType` int(11) NOT NULL DEFAULT 0,
  `pointLocked` int(11) NOT NULL DEFAULT 0,
  `pointFaction` int(11) NOT NULL DEFAULT -1,
  `pointName` varchar(80) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `radio`
--

CREATE TABLE `radio` (
  `id` int(11) NOT NULL,
  `channel` int(11) NOT NULL,
  `slot` int(11) NOT NULL,
  `owner` int(11) NOT NULL,
  `password` varchar(16) NOT NULL DEFAULT 'None'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `radio_station`
--

CREATE TABLE `radio_station` (
  `id` int(11) NOT NULL,
  `genres_id` int(11) NOT NULL,
  `subgenres_id` int(11) NOT NULL,
  `station_name` varchar(255) NOT NULL,
  `station_url` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `signal_tower`
--

CREATE TABLE `signal_tower` (
  `id` int(11) NOT NULL,
  `t_posX` float NOT NULL,
  `t_posY` float NOT NULL,
  `t_posZ` float NOT NULL,
  `t_range` float NOT NULL,
  `t_name` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `spraylocations`
--

CREATE TABLE `spraylocations` (
  `ID` int(11) NOT NULL,
  `creator` varchar(24) NOT NULL DEFAULT 'N/A',
  `name` varchar(256) DEFAULT NULL,
  `posX` float NOT NULL,
  `posY` float NOT NULL,
  `posZ` float NOT NULL,
  `rotX` float NOT NULL,
  `rotY` float NOT NULL,
  `rotZ` float NOT NULL,
  `model` int(11) NOT NULL,
  `defaultModel` int(11) NOT NULL DEFAULT -1,
  `font` varchar(24) NOT NULL DEFAULT 'Arial'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `ucp_friends`
--

CREATE TABLE `ucp_friends` (
  `ID` int(11) NOT NULL,
  `friendName` varchar(24) NOT NULL,
  `playerName` varchar(24) NOT NULL,
  `friendID` int(11) NOT NULL,
  `playerID` int(11) NOT NULL,
  `friendPending` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ucp_logins`
--

CREATE TABLE `ucp_logins` (
  `id` int(11) NOT NULL,
  `User` varchar(24) NOT NULL,
  `IP` varchar(24) NOT NULL,
  `Browser` varchar(24) NOT NULL,
  `OS` varchar(24) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `vehicles`
--

CREATE TABLE `vehicles` (
  `vehicleID` int(11) NOT NULL,
  `vehicleModelID` int(11) NOT NULL DEFAULT 0,
  `vehiclePosX` varchar(255) NOT NULL DEFAULT '0',
  `vehiclePosY` varchar(255) NOT NULL DEFAULT '0',
  `vehiclePosZ` varchar(255) NOT NULL DEFAULT '0',
  `vehiclePosRotation` varchar(255) NOT NULL DEFAULT '0',
  `vehicleFaction` int(11) NOT NULL DEFAULT -1,
  `vehiclePlate` varchar(24) NOT NULL,
  `vehicleSiren` int(11) NOT NULL DEFAULT 0,
  `vehicleCol1` int(11) NOT NULL DEFAULT -1,
  `vehicleCol2` int(11) NOT NULL DEFAULT -1,
  `vehicleSign` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_drugs`
--

CREATE TABLE `vehicle_drugs` (
  `idx` int(11) NOT NULL,
  `drugType` int(11) NOT NULL,
  `drugAmount` float NOT NULL,
  `drugStrength` float NOT NULL,
  `drugStorage` int(11) NOT NULL,
  `drugStamp` int(11) NOT NULL,
  `vehicle` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `weapon`
--

CREATE TABLE `weapon` (
  `id` int(11) NOT NULL,
  `weaponid` int(11) NOT NULL,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `rx` float NOT NULL,
  `ry` float NOT NULL,
  `rz` float NOT NULL,
  `bone` int(11) NOT NULL,
  `owner` int(11) NOT NULL,
  `hide` tinyint(1) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `advertisement`
--
ALTER TABLE `advertisement`
  ADD PRIMARY KEY (`a_id`);

--
-- Indexes for table `apartments`
--
ALTER TABLE `apartments`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `application`
--
ALTER TABLE `application`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ateles`
--
ALTER TABLE `ateles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `atms`
--
ALTER TABLE `atms`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `bans`
--
ALTER TABLE `bans`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `business`
--
ALTER TABLE `business`
  ADD PRIMARY KEY (`biz_id`);

--
-- Indexes for table `business_furnitures`
--
ALTER TABLE `business_furnitures`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cars`
--
ALTER TABLE `cars`
  ADD PRIMARY KEY (`carID`);

--
-- Indexes for table `characters`
--
ALTER TABLE `characters`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `cheques`
--
ALTER TABLE `cheques`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `clothing`
--
ALTER TABLE `clothing`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `criminal_record`
--
ALTER TABLE `criminal_record`
  ADD PRIMARY KEY (`idx`);

--
-- Indexes for table `damages`
--
ALTER TABLE `damages`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `emergency`
--
ALTER TABLE `emergency`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `factions`
--
ALTER TABLE `factions`
  ADD PRIMARY KEY (`factionID`);

--
-- Indexes for table `factionspawns`
--
ALTER TABLE `factionspawns`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `fines`
--
ALTER TABLE `fines`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `flags`
--
ALTER TABLE `flags`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `gates`
--
ALTER TABLE `gates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `houses`
--
ALTER TABLE `houses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `house_furnitures`
--
ALTER TABLE `house_furnitures`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `industry`
--
ALTER TABLE `industry`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `logs_all`
--
ALTER TABLE `logs_all`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `logs_ban`
--
ALTER TABLE `logs_ban`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `logs_connection`
--
ALTER TABLE `logs_connection`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `logs_death`
--
ALTER TABLE `logs_death`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `logs_jail`
--
ALTER TABLE `logs_jail`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `logs_kick`
--
ALTER TABLE `logs_kick`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `logs_mask`
--
ALTER TABLE `logs_mask`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `logs_spray`
--
ALTER TABLE `logs_spray`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `motd`
--
ALTER TABLE `motd`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `movedoors`
--
ALTER TABLE `movedoors`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `namechanges`
--
ALTER TABLE `namechanges`
  ADD PRIMARY KEY (`namechangeid`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `particles`
--
ALTER TABLE `particles`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `phone_contacts`
--
ALTER TABLE `phone_contacts`
  ADD PRIMARY KEY (`contactID`);

--
-- Indexes for table `phone_sms`
--
ALTER TABLE `phone_sms`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `player_drugs`
--
ALTER TABLE `player_drugs`
  ADD PRIMARY KEY (`idx`);

--
-- Indexes for table `points`
--
ALTER TABLE `points`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `radio`
--
ALTER TABLE `radio`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `radio_station`
--
ALTER TABLE `radio_station`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `signal_tower`
--
ALTER TABLE `signal_tower`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `spraylocations`
--
ALTER TABLE `spraylocations`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `ucp_friends`
--
ALTER TABLE `ucp_friends`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `ucp_logins`
--
ALTER TABLE `ucp_logins`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `vehicles`
--
ALTER TABLE `vehicles`
  ADD PRIMARY KEY (`vehicleID`);

--
-- Indexes for table `vehicle_drugs`
--
ALTER TABLE `vehicle_drugs`
  ADD PRIMARY KEY (`idx`);

--
-- Indexes for table `weapon`
--
ALTER TABLE `weapon`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `advertisement`
--
ALTER TABLE `advertisement`
  MODIFY `a_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `apartments`
--
ALTER TABLE `apartments`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `application`
--
ALTER TABLE `application`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ateles`
--
ALTER TABLE `ateles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `atms`
--
ALTER TABLE `atms`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bans`
--
ALTER TABLE `bans`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `business`
--
ALTER TABLE `business`
  MODIFY `biz_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `business_furnitures`
--
ALTER TABLE `business_furnitures`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cars`
--
ALTER TABLE `cars`
  MODIFY `carID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `characters`
--
ALTER TABLE `characters`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cheques`
--
ALTER TABLE `cheques`
  MODIFY `id` int(6) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `clothing`
--
ALTER TABLE `clothing`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `criminal_record`
--
ALTER TABLE `criminal_record`
  MODIFY `idx` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `damages`
--
ALTER TABLE `damages`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `emergency`
--
ALTER TABLE `emergency`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `factions`
--
ALTER TABLE `factions`
  MODIFY `factionID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `factionspawns`
--
ALTER TABLE `factionspawns`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fines`
--
ALTER TABLE `fines`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `flags`
--
ALTER TABLE `flags`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `gates`
--
ALTER TABLE `gates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `houses`
--
ALTER TABLE `houses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `house_furnitures`
--
ALTER TABLE `house_furnitures`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `industry`
--
ALTER TABLE `industry`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `logs_all`
--
ALTER TABLE `logs_all`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `logs_ban`
--
ALTER TABLE `logs_ban`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `logs_connection`
--
ALTER TABLE `logs_connection`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `logs_death`
--
ALTER TABLE `logs_death`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `logs_jail`
--
ALTER TABLE `logs_jail`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `logs_kick`
--
ALTER TABLE `logs_kick`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `logs_mask`
--
ALTER TABLE `logs_mask`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `logs_spray`
--
ALTER TABLE `logs_spray`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `motd`
--
ALTER TABLE `motd`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `movedoors`
--
ALTER TABLE `movedoors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `namechanges`
--
ALTER TABLE `namechanges`
  MODIFY `namechangeid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `particles`
--
ALTER TABLE `particles`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `phone_contacts`
--
ALTER TABLE `phone_contacts`
  MODIFY `contactID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `phone_sms`
--
ALTER TABLE `phone_sms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `player_drugs`
--
ALTER TABLE `player_drugs`
  MODIFY `idx` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `points`
--
ALTER TABLE `points`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `radio`
--
ALTER TABLE `radio`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `radio_station`
--
ALTER TABLE `radio_station`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `signal_tower`
--
ALTER TABLE `signal_tower`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `spraylocations`
--
ALTER TABLE `spraylocations`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ucp_friends`
--
ALTER TABLE `ucp_friends`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ucp_logins`
--
ALTER TABLE `ucp_logins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `vehicles`
--
ALTER TABLE `vehicles`
  MODIFY `vehicleID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `vehicle_drugs`
--
ALTER TABLE `vehicle_drugs`
  MODIFY `idx` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `weapon`
--
ALTER TABLE `weapon`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
