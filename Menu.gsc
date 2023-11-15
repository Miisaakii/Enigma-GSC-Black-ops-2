CreateMenu() {
    self add_menu("Main Menu", undefined, "Unverified");
    self add_option("Main Menu", "Main Menu", ::submenu, "SubMenu1", "Main Menu");
    self add_option("Main Menu", "Fun Menu", ::submenu, "SubMenu2", "Fun Menu");
    self add_option("Main Menu", "Aimbot Menu", ::submenu, "SubMenu8", "Aimbot Menu");
    self add_option("Main Menu", "Weapons Menu", ::submenu, "SubMenu3", "Weapons Menu");
    self add_option("Main Menu", "Bot Menu", ::submenu, "SubMenu7", "Bot Menu");
    self add_option("Main Menu", "Killstreaks Menu", ::submenu, "SubMenu5", "Killstreaks Menu");
    self add_option("Main Menu", "Bullets Types", ::submenu, "SubMenu4", "Bullets Types");
    self add_option("Main Menu", "Messages Menu", ::submenu, "SubMenu9", "Messages Menu");
    self add_option("Main Menu", "Account Menu", ::submenu, "Account Menu", "Account Menu");
    self add_option("Main Menu", "Host Menu", ::submenu, "SubMenu10", "Host Menu");
    self add_option("Main Menu", "Game Settings Menu", ::submenu, "SubMenu6", "Game Settings Menu");
    self add_option("Main Menu", "Custom Maps", ::submenu, "CustomMaps", "Custom Maps");
    self add_option("Main Menu", "Map Menu", ::submenu, "Map Menu", "Map Menu");
    self add_option("Main Menu", "Spawn Menu", ::submenu, "Spawn Menu", "Spawn Menu");
    self add_option("Main Menu", "Players", ::submenu, "PlayersMenu", "Players Menu");
    self add_option("Main Menu", "All Players", ::submenu, "AllPlayers", "All Players");
    self add_option("Main Menu", "Menu Theme", ::submenu, "SubMenu11", "Menu Theme");

    self add_menu("SubMenu1", "Main Menu", "VIP");
    self add_option("SubMenu1", "God Mode", ::GOD_MODE);
    self add_option("SubMenu1", "Demi God Mode", ::DEMI_GOD_MODE);
    self add_option("SubMenu1", "Invisible", ::INVISIBLE);
    self add_option("SubMenu1", "Give All Perks", ::GIVE_ALL_PERKS);
    self add_option("SubMenu1", "Unlimited Ammo", ::INFINITE_AMMO);
    self add_option("SubMenu1", "Change Your Class", ::CHANGE_CLASS);
    self add_option("SubMenu1", "Change Your Team", ::CHANGE_TEAM);

    self add_menu("SubMenu2", "Main Menu", "VIP");
    self add_option("SubMenu2", "Crosshair +", ::DRAW_CROSSHAIR);
    self add_option("SubMenu2", "Speed", ::Toggle_SpeedX2);
    self add_option("SubMenu2", "Clone me", ::cloneyourself);
    self add_option("SubMenu2", "Teleport Gun", ::ToggleTeleportGun);
    self add_option("SubMenu2", "Third Person", ::ThirdPerson);
    self add_option("SubMenu2", "Change Vision", ::togglevision);
    self add_option("SubMenu2", "Crazy Dogs", ::ewwmodel, "german_shepherd_vest");
    self add_option("SubMenu2", "JetPack", ::doJetPack);
    self add_option("SubMenu2", "Drivable Car", ::spawnDrivableCar);
    self add_option("SubMenu2", "Spawn Landmines", ::domineSpawner2);
    self add_option("SubMenu2", "Sky Color", ::DoSky);
    self add_option("SubMenu2", "Save and Load", ::saveandload);
    self add_option("SubMenu2", "Jet", ::spawnFlyableJet);
    self add_option("SubMenu2", "Helicopter", ::spawnFlyablehelico);
    self add_option("SubMenu2", "Pokeball", ::pokeBall);
    self add_option("SubMenu2", "Teleport rocket", ::rocketTeleportGun);

    self add_menu("SubMenu3", "Main Menu", "Verified");
    self add_option("SubMenu3", "Default Weapons", ::BG_GivePlayerWeapon, "defaultweapon_mp");
    self add_option("SubMenu3", "MP7", ::BG_GivePlayerWeapon, "mp7_mp");
    self add_option("SubMenu3", "Balista", ::BG_GivePlayerWeapon, "ballista_mp");
    self add_option("SubMenu3", "DSR 50", ::BG_GivePlayerWeapon, "dsr50_mp");
    self add_option("SubMenu3", "Knife", ::BG_GivePlayerWeapon, "knife_mp");
    self add_option("SubMenu3", "AN 94", ::BG_GivePlayerWeapon, "an94_mp");
    self add_option("SubMenu3", "Peacepeeker", ::BG_GivePlayerWeapon, "peacekeeper_mp");
    self add_option("SubMenu3", "Death Machine", ::BG_GivePlayerWeapon, "minigun_mp");
    self add_option("SubMenu3", "War Machine", ::BG_GivePlayerWeapon, "m32_mp");
    self add_option("SubMenu3", "Earthquake Gun", ::ToggleEarthquakegun);
    self add_option("SubMenu3", "Teleport Gun", ::ToggleTeleportGun);

    self add_menu("SubMenu4", "Main Menu", "Admin");
    self add_option("SubMenu4", "Explosive Bullets", ::Toggle_ExplosiveBullets);
    self add_option("SubMenu4", "Care Package Bullets", ::doCarePBullets);
    self add_option("SubMenu4", "Swarms", ::ToggleSwarmGun);
    self add_option("SubMenu4", "Grenades", ::ToggleGGun);
    self add_option("SubMenu4", "RPG", ::initRPGBullet);

    self add_menu("Account Menu", "Main Menu", "Host");
    self add_option("Account Menu", "Level 55", ::setLevel55);
    self add_option("Account Menu", "Max Prestige", ::setPrestigeMaster);
    self add_option("Account Menu", "Unlock All Trophies", ::unlockAllCheevos);
    
    self add_menu("CustomMaps", "Main Menu", "Host");
    self add_option("CustomMaps", "Nuketown 2035", ::MapNuketown2035);

    self add_menu("Spawn Menu", "Main Menu", "Host");
    self add_option("Spawn Menu", "Spawn Carepackage", ::SpawnCrate);
    self add_option("Spawn Menu", "Turret", ::spawnTurretPlayer, "auto_gun_turret_mp");
    self add_option("Spawn Menu", "Turret (Heli)", ::spawnTurretPlayer, "heli_gunner_rockets_mp");
    self add_option("Spawn Menu", "Rockets (Strafe)", ::spawnTurretPlayer, "straferun_rockets_mp");
    self add_option("Spawn Menu", "Chopper Minigun", ::spawnTurretPlayer, "chopper_minigun_mp");



    self add_menu("SubMenu5", "Main Menu", "Admin");
    self add_option("SubMenu5", "Radar", ::GiveUAV);
    self add_option("SubMenu5", "CounterUAV", ::GiveCUAV);
    self add_option("SubMenu5", "RC-XD", ::GiveRC);
    self add_option("SubMenu5", "Hunter Killer", ::GiveHunt);
    self add_option("SubMenu5", "Care Package", ::GiveCare);
    self add_option("SubMenu5", "Guardian", ::GiveGaurd);
    self add_option("SubMenu5", "Hellfire", ::GiveHell);
    self add_option("SubMenu5", "Lightning Strike", ::GiveLS);
    self add_option("SubMenu5", "Sentry Gun", ::GiveSG);
    self add_option("SubMenu5", "AGR", ::GiveAG);
    self add_option("SubMenu5", "Stealth Chopper", ::GiveSC);
    self add_option("SubMenu5", "VSAT", ::GiveVSAT);
    self add_option("SubMenu5", "Escort Drone", ::GiveED);
    self add_option("SubMenu5", "EMP", ::GiveEMP);
    self add_option("SubMenu5", "Warthog", ::GiveWH);
    self add_option("SubMenu5", "Lodestar", ::GiveLST);
    self add_option("SubMenu5", "VTOL Warship", ::GiveVW);
    self add_option("SubMenu5", "Swarm", ::GiveSwarm);


    self add_menu("SubMenu6", "Main Menu", "Co-Host");
    self add_option("SubMenu6", "Super Speed", ::Speed);
    self add_option("SubMenu6", "Super Jump", ::ToggleSuperJump);
    self add_option("SubMenu6", "Timescales", ::Toggle_Timescales);
    self add_option("SubMenu6", "Anti-Quit", ::toggleAntiQuit);
    self add_option("SubMenu6", "Map Restart", ::MapRestartKidWhyAreULEeechinghm);
    self add_option("SubMenu6", "End Game", ::endGame);
    self add_option("SubMenu6", "Unlimited Game", ::Inf_Game);
    self add_option("SubMenu6", "Fast Restart", ::doRestart);

    self add_menu("SubMenu7", "Main Menu", "Co-Host");
    self add_option("SubMenu7", "Spawn 1 Bot", ::spawn1);
    self add_option("SubMenu7", "Spawn 3 Bots", ::spawn3);
    self add_option("SubMenu7", "Spawn 18 Bots", ::spawn18);

    self add_menu("SubMenu8", "Main Menu", "Co-Host");
    self add_option("SubMenu8", "Aimbot", ::doAimbots2);
    self add_option("SubMenu8", "Aimbot Required", ::NoScopeAimbot);
    self add_option("SubMenu8", "Unfair Aimbot", ::aimBot);
    self add_option("SubMenu8", "TrickShot Aimbot", ::superaimbot);

    self add_menu("SubMenu9", "Main Menu", "Admin");
    self add_option("SubMenu9", "^1+ Enigma +", ::typewritter, "^1+ Enigma +");
    self add_option("SubMenu9", "^7Host " + level.hostname, ::typewritter, "^2" + level.hostname + " ^2is ^7your ^2host");
    self add_option("SubMenu9", "^2Yes", ::typewritter, "^2Yes");
    self add_option("SubMenu9", "^1No", ::typewritter, "^1No");
    self add_option("SubMenu9", "^6I love you ^1<3", ::typewritter, "^6I love you ^1<3");
    self add_option("SubMenu9", "Fuck you", ::typewritter, "Fuck you ^6bitch");
    self add_option("SubMenu9", "^7Creator", ::typewritter, "^1Enigma ^7created by AimMisaki");
    self add_option("SubMenu9", "^7Admin", ::typewritter, "^2Want free admin?");
    self add_option("SubMenu9", "^1Derank?", ::typewritter, "^1Want a derank?");
    self add_option("SubMenu9", "^7DDoS", ::typewritter, "^7I gonna DDoS your connection");
    self add_option("SubMenu9", "^2Infect Xbox", ::typewritter, "^2Infection Xbox Started^F...");
    self add_option("SubMenu9", "^7Fake IP", ::typewritter, "Your ip address is: ^1" + randomintrange( 0, 999 ) + "." + randomintrange( 0, 999 ) + "." + randomintrange( 0, 999 ) + "." + randomintrange( 0, 999 ) + "");
    self add_option("SubMenu9", "^6Pussy", ::typewritter, "your pussy: ^6({})");
   

    self add_menu("SubMenu10", "Main Menu", "Co-Host");
    self add_option("SubMenu10", "Kamikaze", ::kamikaze);
    self add_option("SubMenu10", "StrafeRun", ::initStrafeRun);
    self add_option("SubMenu10", "Forge Mode", ::ToggleForgeMode);
    self add_option("SubMenu10", "Pickup", ::togglePickup);
    self add_option("SubMenu10", "Jericho Missile", ::initJericho);
    self add_option("SubMenu10", "Advertise", ::doAdvert);
    self add_option("SubMenu10", "Spawn Name", ::skytext);
    self add_option("SubMenu10", "BIG Xp (TDM)", ::bigxp);

    self add_menu("Map Menu", "Main Menu", "Host");
    self add_option("Map Menu", "Nuketown 2025", ::doMap, "mp_nuketown_2020");
    self add_option("Map Menu", "Aftermath", ::doMap, "mp_la");
    self add_option("Map Menu", "Cargo", ::doMap, "mp_dockside");
    self add_option("Map Menu", "Carrier", ::doMap, "mp_carrier");
    self add_option("Map Menu", "Drone", ::doMap, "mp_drone");
    self add_option("Map Menu", "Express", ::doMap, "mp_express");
    self add_option("Map Menu", "Hijacked", ::doMap, "mp_hijacked");
    self add_option("Map Menu", "Meltdown", ::doMap, "mp_meltdown");
    self add_option("Map Menu", "Overflow", ::doMap, "mp_overflow");
    self add_option("Map Menu", "Plaza", ::doMap, "mp_nightclub");
    self add_option("Map Menu", "Raid", ::doMap, "mp_raid");
    self add_option("Map Menu", "Slums", ::doMap, "mp_slums");
    self add_option("Map Menu", "Standoff", ::doMap, "mp_village");
    self add_option("Map Menu", "Turbine", ::doMap, "mp_turbine");
    self add_option("Map Menu", "Yemen", ::doMap, "mp_socotra");

    self add_menu("SubMenu11", "Main Menu", "Verified");
    self add_option("SubMenu11", "Default Theme", ::doGreentheme);
    self add_option("SubMenu11", "White Theme", ::doWhiteTheme);
    self add_option("SubMenu11", "Red Theme", ::doRedtheme);
    self add_option("SubMenu11", "Blue Theme", ::dobluetheme);
    self add_option("SubMenu11", "Yellow Theme", ::doYellowtheme);
    self add_option("SubMenu11", "Pink Theme", ::doPinktheme);
    self add_option("SubMenu11", "Cyan Theme", ::doCyantheme);
    self add_option("SubMenu11", "Aqua Theme", ::doAquatheme);
    self add_option("SubMenu11", "Black Theme", ::doBlackTheme);
    self add_option("SubMenu11", "Default Color", ::doGreentheme2);
    self add_option("SubMenu11", "White Color", ::doWhiteTheme2);
    self add_option("SubMenu11", "Red Color", ::doRedtheme2);
    self add_option("SubMenu11", "Blue Color", ::dobluetheme2);

    self add_option("LineAndScroll", "Black Theme", ::doBlackTheme);

    self add_menu("SubMenu12", "Main Menu", "Verified");




    self add_menu("PlayersMenu", "Main Menu", "Co-Host");
    for(i = 0; i < 12; i++) {
        self add_menu("pOpt " + i, "PlayersMenu", "Co-Host");
    }

    self add_menu("AllPlayers", "Main Menu", "Host");
    self add_option("AllPlayers", "Kill All", ::killall);
    self add_option("AllPlayers", "Kick All Unverified", ::kickall);
    self add_option("AllPlayers", "God mode All", ::godmodeall);
    self add_option("AllPlayers", "Infinite Ammo All", ::infiniteammoall);
    self add_option("AllPlayers", "Freeze/Unfreeze All", ::freezeall);
    self add_option("AllPlayers", "Take All Weapons", ::takeallplayerweapons);
    self add_option("AllPlayers", "Send All To Space", ::sendalltospace);
    self add_option("AllPlayers", "Verify All", ::verifyall);
    self add_option("AllPlayers", "VIP All", ::vipall);
    self add_option("AllPlayers", "Unverify All", ::unverifyall);
    self add_option("AllPlayers", "Blind All", ::blindall);
    self add_option("AllPlayers", "Teleport To Crosshairs", ::teleToCrosshairs);
}



















