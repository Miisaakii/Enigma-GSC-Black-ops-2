GOD_MODE() 
{
    if(self.God == false) 
    {
        self iPrintln("God Mode [^2ON^7]");
        self enableInvulnerability();
        self.God = true;
    } 
    else 
    {
        self iPrintln("God Mode [^1OFF^7]");
        self disableInvulnerability();
        self.God = false;
    }
}

DEMI_GOD_MODE()
{
	if (self.demigodmode == 0)
	{
	    self iprintln( "Demi God Mode: [^2ON^7]" );
		self.demigodmode = 1;
		
		self endon("disconnect");
		self endon("Stop_GodMode");
		self.maxhealth = 2147483647;
		self.health = self.maxhealth;
		while(1)
		{
		    wait .1;
		    if (self.health < self.maxhealth)
		    {
		        self.health = self.maxhealth;
		    }
		}
	}
	else
	{
		self iprintln( "Demi God Mode: [^1OFF^7]" );
		self.demigodmode = 0;
		self endon("disconnect");
		self endon("Stop_GodMode");
		self.maxhealth = 57;
		self.health = self.maxhealth;
		while(1)
		{
		    wait .1;
		    if (self.health < self.maxhealth)
		    {
		        self.health = self.maxhealth;
		    }
		}
	}
}

INVISIBLE()
{
	self.invisible = booleanopposite( self.invisible );
	self iprintln( booleanreturnval( self.invisible, "Invisible: [^1OFF^7]", "Invisible: [^2ON^7]" ) );
	if (self.invisible)
	{
		self hide();
	}
	else
	{
		self show();
	}
}

GIVE_ALL_PERKS()
{
	self clearperks();
	self setperk("specialty_additionalprimaryweapon");
	self setperk("specialty_armorpiercing");
	self setperk("specialty_armorvest");
	self setperk("specialty_bulletaccuracy");
	self setperk("specialty_bulletdamage");
	self setperk("specialty_bulletflinch");
	self setperk("specialty_bulletpenetration");
	self setperk("specialty_deadshot");
	self setperk("specialty_delayexplosive");
	self setperk("specialty_detectexplosive");
	self setperk("specialty_disarmexplosive");
	self setperk("specialty_earnmoremomentum");
	self setperk("specialty_explosivedamage");
	self setperk("specialty_extraammo");
	self setperk("specialty_fallheight");
	self setperk("specialty_fastads");
	self setperk("specialty_fastequipmentuse");
	self setperk("specialty_fastladderclimb");
	self setperk("specialty_fastmantle");
	self setperk("specialty_fastmeleerecovery");
	self setperk("specialty_fastreload");
	self setperk("specialty_fasttoss");
	self setperk("specialty_fastweaponswitch");
	self setperk("specialty_finalstand");
	self setperk("specialty_fireproof");
	self setperk("specialty_flakjacket");
	self setperk("specialty_flashprotection");
	self setperk("specialty_gpsjammer");
	self setperk("specialty_grenadepulldeath");
	self setperk("specialty_healthregen");
	self setperk("specialty_holdbreath");
	self setperk("specialty_immunecounteruav");
	self setperk("specialty_immuneemp");
	self setperk("specialty_immunemms");
	self setperk("specialty_immunenvthermal");
	self setperk("specialty_immunerangefinder");
	self setperk("specialty_killstreak");
	self setperk("specialty_longersprint");
	self setperk("specialty_loudenemies");
	self setperk("specialty_marksman");
	self setperk("specialty_movefaster");
	self setperk("specialty_nomotionsensor");
	self setperk("specialty_noname");
	self setperk("specialty_nottargetedbyairsupport");
	self setperk("specialty_nokillstreakreticle");
	self setperk("specialty_nottargettedbysentry");
	self setperk("specialty_pin_back");
	self setperk("specialty_pistoldeath");
	self setperk("specialty_proximityprotection");
	self setperk("specialty_quickrevive");
	self setperk("specialty_quieter");
	self setperk("specialty_reconnaissance");
	self setperk("specialty_rof");
	self setperk("specialty_scavenger");
	self setperk("specialty_showenemyequipment");
	self setperk("specialty_stunprotection");
	self setperk("specialty_shellshock");
	self setperk("specialty_sprintrecovery");
	self setperk("specialty_showonradar");
	self setperk("specialty_stalker");
	self setperk("specialty_twogrenades");
	self setperk("specialty_twoprimaries");
	self setperk("specialty_unlimitedsprint");
	self iprintln("All perks ^2send" );
}

INFINITE_AMMO()
{
	self endon("disconnect");
	self endon("disableInfAmmo");
	self.infiniteammo = booleanopposite(self.infiniteammo);
	self iprintln(booleanreturnval(self.infiniteammo, "Unlimited Ammo: [^1OFF^7]", "Unlimited Ammo: [^2ON^7]" ) );
	while (self.infiniteammo)
	{
		if (self getcurrentweapon() != "none")
		{
			self setweaponammoclip(self getcurrentweapon(), weaponclipsize(self getcurrentweapon()));
			self givemaxammo(self getcurrentweapon());
		}
		if (self getcurrentoffhand() != "none")
		{
			self givemaxammo(self getcurrentoffhand());
		}
		wait .05;
	}
	self notify("disableInfAmmo");
}

CHANGE_CLASS()
{
	self endon("disconnect");
	self endon("death");
	self endon("sChClass");
	self maps/mp/gametypes/_globallogic_ui::beginclasschoice();
	for(;;)
	{
		if(self.pers[ "changed_class" ])
		{
			self maps/mp/gametypes/_class::giveloadout( self.team, self.class );
			self iprintlnbold(" ");
			self notify("sChClass");
		}
		wait .05;
	}
}

CHANGE_TEAM()
{
	if(self.pers["team"]=="allies")
	{
		self iPrintlnbold("Team set to ^6axis");
		self changeteamfunc("axis");
	}
	else if(self.pers["team"]=="axis")
	{
		self iPrintlnbold("Team set to ^6allies");
		self changeteamfunc("allies");
	}
}

changeteamfunc(team)
{
	if (self.sessionstate != "dead")
	{
		self.switching_teams = 1;
		self.joining_team = team;
		self.leaving_team = self.pers["team"];
	}
	self.pers["team"] = team;
	self.team = team;
	self.sessionteam = self.pers["team"];
	self maps/mp/gametypes/_globallogic_ui::updateobjectivetext();
	self maps/mp/gametypes/_spectating::setspectatepermissions();
	self notify("end_respawn");
}

DRAW_CROSSHAIR() 
{
    if(self.crosshair == false) 
    {
        xePixTvx = createFontString("default", 2.0);
        xePixTvx setPoint("CENTER", "CENTER", 0, -200);
        xePixTvx setText("^7+");
        xePixTvx.alpha = 1;
        xePixTvx.y = 0;
        self iprintln("Crosshair : + ^2Given");
        self.crosshair = true;
    } 
    else
    {
        self iprintln("^1Off");
        self.crosshair = false;
        xePixTvx destroy();
    }
}



