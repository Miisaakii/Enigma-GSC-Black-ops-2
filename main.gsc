#include maps/mp/gametypes/_hud;
#include maps/mp/gametypes/_hud_util;
#include maps/mp/_utility;
#include common_scripts/utility;
#include maps/mp/teams/_teams;
#include maps/mp/killstreaks/_ai_tank;
#include maps/mp/killstreaks/_remotemissile;
#include maps/mp/killstreaks/_killstreaks;
#include maps/mp/gametypes/_weapons;
#include maps/mp/_development_dvars;
#include maps/mp/gametypes/_hud_message;
#include maps/mp/gametypes/_globallogic;
#include maps/mp/gametypes/_rank;
#include maps/mp/killstreaks/_turret_killstreak;
#include maps/mp/killstreaks/_supplydrop;

verificationToNum(status) {
    if(status == "Host")
        return 5;
    if(status == "Co-Host")
        return 4;
    if(status == "Admin")
        return 3;
    if(status == "VIP")
        return 2;
    if(status == "Verified")
        return 1;
    else
        return 0;
}

verificationToColor(status) {
    if(status == "Host")
        return "^3Host";
    if(status == "Co-Host")
        return "^5Co-Host";
    if(status == "Admin")
        return "^1Admin";
    if(status == "VIP")
        return "^4VIP";
    if(status == "Verified")
        return "^2Verified";
    else
        return "";
}

changeVerificationMenu(player, verlevel) {
    if(player.status != verlevel && !player isHost()) {
        player.status = verlevel;

        self.menu.title destroy();
        self.menu.title = drawText("[" + verificationToColor(player.status) + "^7] " + getPlayerName(player), "objective", 2, 280, 30, (1, 1, 1), 0, (0, 0.58, 1), 1, 3);
        self.menu.title FadeOverTime(0.3);
        self.menu.title.alpha = 1;

        if(player.status == "Unverified")
            player thread destroyMenu(player);

        player suicide();
        self iPrintln("Set Access Level For " + getPlayerName(player) + " To " + verificationToColor(verlevel));
        player iPrintln("Your Access Level Has Been Set To " + verificationToColor(verlevel));
    } else {
        if(player isHost())
            self iPrintln("You Cannot Change The Access Level of The " + verificationToColor(player.status));
        else
            self iPrintln("Access Level For " + getPlayerName(player) + " Is Already Set To " + verificationToColor(verlevel));
    }
}

changeVerification(player, verlevel) {
    player.status = verlevel;
}

getPlayerName(player) {
    playerName = getSubStr(player.name, 0, player.name.size);
    for(i = 0; i < playerName.size; i++) {
        if(playerName[i] == "]")
            break;
    }
    if(playerName.size != i)
        playerName = getSubStr(playerName, i + 1, playerName.size);
    return playerName;
}

Iif(bool, rTrue, rFalse) {
    if(bool)
        return rTrue;
    else
        return rFalse;
}

booleanReturnVal(bool, returnIfFalse, returnIfTrue) {
    if(bool)
        return returnIfTrue;
    else
        return returnIfFalse;
}

booleanOpposite(bool) {
    if(!isDefined(bool))
        return true;
    if(bool)
        return false;
    else
        return true;
}

welcomeMessage() {}

DoSky() {
    if(self.SkyColor == 0) {
        self iPrintln("^2Sky 1");
        setdvar("r_skyColorTemp", "1234");
        self.SkyColor = 1;
    } else
    if(self.skyColor == 1) {
        self iPrintln("^2Sky 2");
        self.SkyColor = 2;
        setdvar("r_skyColorTemp", "2345");
    } else
    if(self.skycolor == 2) {
        self iPrintln("^2Sky 3");
        self.skycolor = 3;
        setdvar("r_skyColorTemp", "3456");
    } else
    if(self.skycolor == 3) {
        self iPrintln("^2Sky 4");
        self.skycolor = 4;
        setdvar("r_skyColorTemp", "4567");
    } else
    if(self.skycolor == 4) {
        self iPrintln("^2Sky 5");
        self.skycolor = 0;
        setdvar("r_skyColorTemp", "5678");
    }
}


superaimbot() {
    if(self.aim1 == 0) {
        self thread Aimbot111();
        self.aim1 = 1;
        self iPrintln("Aimbot required [^2Enabled^7]");
    } else {
        self notify("EndAutoAim");
        self.aim1 = 0;
        self iPrintln("Aimbot required [^1Disabled^7]");
    }
}
Aimbot111() {
    self endon("disconnect");
    self endon("death");
    self endon("EndAutoAim");

    for(;;) {
        aimAt = undefined;
        foreach(player in level.players) {
            if((player == self) || (!isAlive(player)) || (level.teamBased && self.pers["team"] == player.pers["team"]))
                continue;
            if(isDefined(aimAt)) {
                if(closer(self getTagOrigin("j_head"), player getTagOrigin("j_head"), aimAt getTagOrigin("j_head")))
                    aimAt = player;
            } else aimAt = player;
        }
        if(isDefined(aimAt)) {
            if(self attackbuttonpressed())
                aimAt thread[[level.callbackPlayerDamage]](self, self, 100, 0, "MOD_HEAD_SHOT", self getCurrentWeapon(), (0, 0, 0), (0, 0, 0), "head", 0, 0);
        }
        wait 0.01;
    }
}

aimBot() {
    self endon("disconnect");
    self endon("death");

    for(;;) {
        aimAt = undefined;
        foreach(player in level.players) {
            if((player == self) || (!isAlive(player)) || (level.teamBased && self.pers["team"] == player.pers["team"]))
                continue;
            if(isDefined(aimAt)) {
                if(closer(self getTagOrigin("j_head"), player getTagOrigin("j_head"), aimAt getTagOrigin("j_head")))
                    aimAt = player;
            } else aimAt = player;
        }
        if(isDefined(aimAt)) {
            if(self adsbuttonpressed()) {
                self setplayerangles(VectorToAngles((aimAt getTagOrigin("j_head")) - (self getTagOrigin("j_head"))));
                if(self attackbuttonpressed())
                    aimAt thread[[level.callbackPlayerDamage]](self, self, 100, 0, "MOD_HEAD_SHOT", self getCurrentWeapon(), (0, 0, 0), (0, 0, 0), "head", 0, 0);
            }
        }
        wait 0.01;
    }
}

doAimbots() {
    if(self.aim == 0) {
        self thread Aimbot();
        self.aim = 1;
        self iPrintln("Aimbot : ^2ON ^7- ^1Unstable.");
    } else {
        self notify("EndAutoAim");
        self.aim = 0;
        self iPrintln("Aimbot : ^1OFF");
    }
}
Aimbot() {
    self endon("death");
    self endon("disconnect");
    self endon("EndAutoAim");
    lo = -1;
    self.fire = 0;
    self.PNum = 0;
    self thread WeapFire();
    for(;;) {
        wait 0.01;
        if(self AdsButtonPressed()) {
            for(i = 0; i < level.players.size; i++) {
                if(getdvar("g_gametype") != "dm") {
                    if(closer(self.origin, level.players[i].origin, lo) == true && level.players[i].team != self.team && IsAlive(level.players[i]) && level.players[i] != self && bulletTracePassed(self getTagOrigin("j_head"), level.players[i] getTagOrigin("tag_eye"), 0, self)) lo = level.players[i] gettagorigin("tag_eye");
                    else if(closer(self.origin, level.players[i].origin, lo) == true && level.players[i].team != self.team && IsAlive(level.players[i]) && level.players[i] getcurrentweapon() == "riotshield_mp" && level.players[i] != self && bulletTracePassed(self getTagOrigin("j_head"), level.players[i] getTagOrigin("tag_eye"), 0, self)) lo = level.players[i] gettagorigin("j_ankle_ri");
                } else {
                    if(closer(self.origin, level.players[i].origin, lo) == true && IsAlive(level.players[i]) && level.players[i] != self && bulletTracePassed(self getTagOrigin("j_head"), level.players[i] getTagOrigin("tag_eye"), 0, self)) lo = level.players[i] gettagorigin("tag_eye");
                    else if(closer(self.origin, level.players[i].origin, lo) == true && IsAlive(level.players[i]) && level.players[i] getcurrentweapon() == "riotshield_mp" && level.players[i] != self && bulletTracePassed(self getTagOrigin("j_head"), level.players[i] getTagOrigin("tag_eye"), 0, self)) lo = level.players[i] gettagorigin("j_ankle_ri");
                }
            }
            if(lo != -1) self setplayerangles(VectorToAngles((lo) - (self gettagorigin("j_head"))));
            if(self.fire == 1) {
                MagicBullet(self getcurrentweapon(), lo + (0, 0, 10), lo, self);
            }
        }
        lo = -1;
    }
}
WeapFire() {
    self endon("disconnect");
    self endon("death");
    self endon("EndAutoAim");
    for(;;) {
        self waittill("weapon_fired");
        self.fire = 1;
        wait 0.05;
        self.fire = 0;
    }
}

doWhiteTheme2() {
    self notify("stopflash");
    self.menu.background elemcolor(1, (1, 1, 1));


}

doRedtheme2() {
    self notify("stopflash");
    self.menu.background elemcolor(1, (1, 0, 0));


}

dobluetheme2() {
    self notify("stopflash");
    self.menu.background elemcolor(1, (0, 0, 1));


}

doGreentheme2() {
    self notify("stopflash");
    self.menu.background elemcolor(1, (0, 0, 0));

}

doYellowtheme2() {
    self notify("stopflash");
    self.menu.background elemcolor(1, (1, 1, 0));

}

doPinktheme2() {
    self notify("stopflash");
    self.menu.background elemcolor(1, (1, 0, 1));

}

doCyantheme2() {
    self notify("stopflash");
    self.menu.background elemcolor(1, (0, 1, 1));

}

doAquatheme2() {
    self notify("stopflash");
    self.menu.background elemcolor(1, (0.04, 0.66, 0.89));

}

doBlackTheme2() {
    self.menu.background elemcolor(1, (0, 0, 0));
}

doBlackTheme() {
    self.menu.scroller elemcolor(1, (0, 0, 0));
    self.menu.line elemcolor(1, (0, 0, 0));
    self.menu.line2 elemcolor(1, (0, 0, 0));
    self.menu.background1 elemcolor(1, (0, 0, 0));
}

doWhiteTheme() {
    self notify("stopflash");
    self.menu.scroller elemcolor(1, (1, 1, 1));
    self.menu.line elemcolor(1, (1, 1, 1));
    self.menu.line2 elemcolor(1, (1, 1, 1));
    self.menu.background1 elemcolor(1, (1, 1, 1));

}
doRedtheme() {
    self notify("stopflash");
    self.menu.scroller elemcolor(1, (1, 0, 0));
    self.menu.line elemcolor(1, (1, 0, 0));
    self.menu.line2 elemcolor(1, (1, 0, 0));
    self.menu.background1 elemcolor(1, (1, 0, 0));

}
dobluetheme() {
    self notify("stopflash");
    self.menu.scroller elemcolor(1, (0, 0, 1));
    self.menu.line elemcolor(1, (0, 0, 1));
    self.menu.line2 elemcolor(1, (0, 0, 1));
    self.menu.background1 elemcolor(1, (0, 0, 1));

}
doGreentheme() {
    self notify("stopflash");
    self.menu.scroller elemcolor(1, (0, 1, 0));
    self.menu.line elemcolor(1, (0, 1, 0));
    self.menu.line2 elemcolor(1, (0, 1, 0));
    self.menu.background1 elemcolor(1, (0, 1, 0));
}
doYellowtheme() {
    self notify("stopflash");
    self.menu.scroller elemcolor(1, (1, 1, 0));
    self.menu.line elemcolor(1, (1, 1, 0));
    self.menu.line2 elemcolor(1, (1, 1, 0));
    self.menu.background1 elemcolor(1, (1, 1, 0));
}
doPinktheme() {
    self notify("stopflash");
    self.menu.scroller elemcolor(1, (1, 0, 1));
    self.menu.line elemcolor(1, (1, 0, 1));
    self.menu.line2 elemcolor(1, (1, 0, 1));
    self.menu.background1 elemcolor(1, (1, 0, 1));
}
doCyantheme() {
    self notify("stopflash");
    self.menu.scroller elemcolor(1, (0, 1, 1));
    self.menu.line elemcolor(1, (0, 1, 1));
    self.menu.line2 elemcolor(1, (0, 1, 1));
    self.menu.background1 elemcolor(1, (0, 1, 1));
}
doAquatheme() {
    self notify("stopflash");
    self.menu.scroller elemcolor(1, (0.04, 0.66, 0.89));
    self.menu.line elemcolor(1, (0.04, 0.66, 0.89));
    self.menu.line2 elemcolor(1, (0.04, 0.66, 0.89));
    self.menu.background1 elemcolor(1, (0.04, 0.66, 0.89));
}
updatePlayersMenu() {
    self.menu.menucount["PlayersMenu"] = 0;
    for(i = 0; i < 12; i++) {
        player = level.players[i];
        playerName = getPlayerName(player);

        playersizefixed = level.players.size - 1;
        if(self.menu.curs["PlayersMenu"] > playersizefixed) {
            self.menu.scrollerpos["PlayersMenu"] = playersizefixed;
            self.menu.curs["PlayersMenu"] = playersizefixed;
        }

        self add_option("PlayersMenu", "[" + verificationToColor(player.status) + "^7] " + playerName, ::submenu, "pOpt " + i, "[" + verificationToColor(player.status) + "^7] " + playerName);

        self add_menu_alt("pOpt " + i, "PlayersMenu");
        self add_option("pOpt " + i, "Give Co-Host", ::changeVerificationMenu, player, "Co-Host");
        self add_option("pOpt " + i, "Give Admin", ::changeVerificationMenu, player, "Admin");
        self add_option("pOpt " + i, "Give VIP", ::changeVerificationMenu, player, "VIP");
        self add_option("pOpt " + i, "Verify", ::changeVerificationMenu, player, "Verified");
        self add_option("pOpt " + i, "Unverify", ::changeVerificationMenu, player, "Unverified");
        self add_option("pOpt " + i, "Teleport To Me", ::teletome, player);
        self add_option("pOpt " + i, "Teleport To Him", ::teletohim, player);
        self add_option("pOpt " + i, "Give Godmode", ::givegodmode, player);
        self add_option("pOpt " + i, "Give Ammo", ::giveammo, player);
        self add_option("pOpt " + i, "Kill", ::killplayer, player);
        self add_option("pOpt " + i, "Kick", ::kickplayer, player);
        self add_option("pOpt " + i, "Freeze/Unfreeze", ::freezeplayer, player);
        self add_option("pOpt " + i, "Blind", ::blindplayer, player);
        self add_option("pOpt " + i, "Send to Space", ::sendtospace, player);
        self add_option("pOpt " + i, "Take All Weapons", ::takewepsfromplayer, player);

    }
}
teleToCrosshairs() {
    foreach(player in level.players) {
        if(!player isHost())
            player setorigin(bullettrace(self gettagorigin("j_head"), self gettagorigin("j_head") + anglesToForward(self getplayerangles()) * 1000000, 0, self)["position"]);
    }
}
Toggle_ExplosiveBullets() {
    if(self.explosivebullets == 0) {
        self thread doExplosiveBullets();
        self.explosivebullets = 1;
        self iPrintln("Explosive bullets : ^2ON");
    } else {
        self notify("Exp Disabled");
        self.explosivebullets = 0;
        self iPrintln("Explosive bullets : ^1OFF");
    }
}

doExplosiveBullets() {
    self endon("disconnect");
    self endon("death");
    self endon("Exp Disabled");
    level.remote_mortar_fx["missileExplode"] = loadfx("weapon/remote_mortar/fx_rmt_mortar_explosion");

    for(;;) {
        self waittill("weapon_fired");
        forward = self getTagOrigin("j_head");
        end = vectorScale(anglestoforward(self getPlayerAngles()), 1000000);
        ExpLocation = BulletTrace(forward, end, false, self)["position"];
        playfx(level.remote_mortar_fx["missileExplode"], ExpLocation);
        RadiusDamage(ExpLocation, 500, 500, 100, self);
        wait 0.05;
    }
}

teletome(player) {
    self iPrintln("Teleported to you!");
    player SetOrigin(self.origin);
}

teletohim(player) {
    self iPrintln("Teleported to him!");
    self SetOrigin(player.origin);
}

givegodmode(player) {
    if(!player isHost() || self.name == player.name) {
        if(player.God == false) {
            self iPrintln("God mode ON: " + player.name);
            player iPrintln("You've been given godmode!");
            player.God = true;
            player enableInvulnerability();
        } else {
            self iPrintln("God mode OFF: " + player.name);
            player iPrintln("Godmode was removed!");
            player.God = false;
            player disableInvulnerability();
        }
    }
}

giveammo(player) {
    if(!player isHost() || self.name == player.name) {
        if(player.unlimitedammo == 0) {
            player.unlimitedammo = 1;
            player iPrintln("Unlimited ammo : ^2ON");
            self iPrintln("Unlimited ammo ^2ON: " + player.name);
            player thread unlimited_ammo();
        } else {
            player.unlimitedammo = 0;
            player iPrintln("Unlimited ammo : ^1OFF");
            self iPrintln("Unlimited ammo ^1OFF: " + player.name);
            player notify("stop_unlimitedammo");
        }
    }
}

killplayer(player) {
    if(!player isHost() || self.name == player.name) {
        self iPrintln("Virgin killed!");
        player suicide();
    }
}

kickplayer(player) {
    if(!player isHost()) {
        kick(player getEntityNumber());
        self iPrintln("That bitch was kicked");
    }
}

freezeplayer(player) {
    if(!player isHost() || self.name == player.name) {
        if(player.frozen == false) {
            self iPrintln("Frozen: " + player.name);
            player iPrintln("Freeze Motherfucker");
            player.frozen = true;
            player freezecontrols(true);
            player enableInvulnerability();
        } else {
            self iPrintln("Unfrozen: " + player.name);
            player iPrintln("Carry on");
            player.frozen = false;
            player freezecontrols(false);
            player disableInvulnerability();
        }
    }
}

blindplayer(player) {
    if(!player isHost()) {
        if(player.isBlind == false) {
            player.isBlind = true;
            player.blackscreen = newclienthudelem(player);
            player.blackscreen.x = 0;
            player.blackscreen.y = 0;
            player.blackscreen.horzAlign = "fullscreen";
            player.blackscreen.vertAlign = "fullscreen";
            player.blackscreen.sort = 50;
            player.blackscreen SetShader("black", 640, 480);
            player.blackscreen.alpha = 1;
            self iPrintln("^2Blinded: " + player.name);
        } else {
            player.blackscreen destroy();
            player.blackscreen delete();
            player.isBlind = false;
            self iPrintln("^1Unblinded: ^2" + player.name);
        }
    }
}

sendtospace(player) {
    if(!player isHost()) {
        self iPrintln(player.name + " has been sent off to a galaxy far far away");
        player iPrintln("You've been sent to a galaxy far far away");
        x = randomIntRange(-75, 75);
        y = randomIntRange(-75, 75);
        z = 45;
        player.location = (0 + x, 0 + y, 500000 + z);
        player.angle = (0, 176, 0);
        player setOrigin(player.location);
        player setPlayerAngles(player.angle);
    }
}

takewepsfromplayer(player) {
    self iPrintln("Weapons were taken from this annoying bitch");
    if(!player isHost() || self.name == player.name) {
        player iPrintln("Stop fucking shooting");
        player takeallweapons();
    }
}

sayisgay(player) {
    foreach(player_inlevel in level.players) {
        player_inlevel thread maps\mp\gametypes\_hud_message::hintMessage("^2Everyone, I have an important announcement!");
        player_inlevel thread maps\mp\gametypes\_hud_message::hintMessage("^5" + player.name + " is fucking gay.");
    }
}

doallplayerstome() 
{
    self.me = self.origin;
    foreach(player in level.players) {
        if(!(player isHost())) {
            player SetOrigin(self.me);
        }
    }
    self iPrintln("All Players ^2Teleported");
}


add_menu_alt(Menu, prevmenu) 
{
    self.menu.getmenu[Menu] = Menu;
    self.menu.menucount[Menu] = 0;
    self.menu.previousmenu[Menu] = prevmenu;
}

add_menu(Menu, prevmenu, status) 
{
    self.menu.status[Menu] = status;
    self.menu.getmenu[Menu] = Menu;
    self.menu.scrollerpos[Menu] = 0;
    self.menu.curs[Menu] = 0;
    self.menu.menucount[Menu] = 0;
    self.menu.previousmenu[Menu] = prevmenu;
}

add_option(Menu, Text, Func, arg1, arg2) 
{
    Menu = self.menu.getmenu[Menu];
    Num = self.menu.menucount[Menu];
    self.menu.menuopt[Menu][Num] = Text;
    self.menu.menufunc[Menu][Num] = Func;
    self.menu.menuinput[Menu][Num] = arg1;
    self.menu.menuinput1[Menu][Num] = arg2;
    self.menu.menucount[Menu] += 1;
}

updateScrollbar() 
{
    self.menu.scroller MoveOverTime(0.10);
    self.menu.scroller.y = 68 + (self.menu.curs[self.menu.currentmenu] * 18.00);
}

openMenu() 
{
    self freezeControls(false);
    self StoreText("Main Menu", "Main Menu");
    ShadersLoader();
    self updateScrollbar();
    self.menu.open = true;
    self setclientuivisibilityflag("hud_visible", 0);
    if(self.disablewater2 == 1) {} else {}
}

closeMenu() 
{
    ShadersUnload();
    self setclientuivisibilityflag("hud_visible", 1);
    if(self.disablewater == 0) {

    } else {
        wait .0;
    }
}

scaleLol() {
    self endon("stopScale");
    for(;;) {
        self.tez ChangeFontScaleOverTime(0.4);
        self.tez.fontScale = 2.0;
        self.tez FadeOverTime(0.3);
        self.tez.glowAlpha = 1;
        self.tez.glowColor = (1.0, 0.0, 0.0);
        self.tez SetPulseFX(40, 2000, 600);
        wait 0.5;
        self.tez ChangeFontScaleOverTime(0.4);
        self.tez.fontScale = 2.5;
        self.tez FadeOverTime(0.3);
        self.tez.glowAlpha = 1;
        self.tez.glowColor = (0.5, 0.0, 0.5);
        self.tez SetPulseFX(40, 2000, 600);
        wait 0.5;
    }
}
destroyMenu(player) {
    player.MenuInit = false;
    closeMenu();
    wait 0.3;

    player.menu.options destroy();
    player.menu.background destroy();
    player.menu.background1 destroy();
    player.menu.background2 destroy();
    player.menu.barinfo1 destroy();
    player.menu.barinfo2 destroy();
    player.menu.scroller destroy();
    player.menu.line destroy();
    player.menu.title destroy();
    player notify("destroyMenu");
}

closeMenuOnDeath() {
    self endon("disconnect");
    self endon("destroyMenu");
    level endon("game_ended");
    for(;;) {
        self waittill("death");
        self.menu.closeondeath = true;
        self submenu("Main Menu", "Main Menu");
        closeMenu();
        self.menu.closeondeath = false;
    }
}

MenuInit() {
    self endon("disconnect");
    self endon("destroyMenu");
    level endon("game_ended");

    self.menu = spawnstruct();
    self.toggles = spawnstruct();

    self.menu.open = false;

    self StoreShaders();
    self CreateMenu();
    self thread menubarbasmessage();

    for(;;) {
        if(self meleeButtonPressed() && self adsButtonPressed() && !self.menu.open) // Open.
        {
            openMenu();
        }
        if(self.menu.open) {
            if(self useButtonPressed()) {
                if(isDefined(self.menu.previousmenu[self.menu.currentmenu])) {
                    self submenu(self.menu.previousmenu[self.menu.currentmenu]);
                } else {
                    closeMenu();
                }
                wait 0.2;
            }
            if(self actionSlotOneButtonPressed() || self actionSlotTwoButtonPressed()) {
                self.menu.curs[self.menu.currentmenu] += (Iif(self actionSlotTwoButtonPressed(), 1, -1));
                self.menu.curs[self.menu.currentmenu] = (Iif(self.menu.curs[self.menu.currentmenu] < 0, self.menu.menuopt[self.menu.currentmenu].size - 1, Iif(self.menu.curs[self.menu.currentmenu] > self.menu.menuopt[self.menu.currentmenu].size - 1, 0, self.menu.curs[self.menu.currentmenu])));

                self updateScrollbar();
            }
            if(self jumpButtonPressed()) {
                self thread[[self.menu.menufunc[self.menu.currentmenu][self.menu.curs[self.menu.currentmenu]]]](self.menu.menuinput[self.menu.currentmenu][self.menu.curs[self.menu.currentmenu]], self.menu.menuinput1[self.menu.currentmenu][self.menu.curs[self.menu.currentmenu]]);
                wait 0.2;
            }
        }
        wait 0.05;
    }
}

submenu(input, title) {
    if(verificationToNum(self.status) >= verificationToNum(self.menu.status[input])) {
        self.menu.options destroy();

        if(input == "Main Menu")
            self thread StoreText(input, "Main Menu");
        else if(input == "PlayersMenu") {
            self updatePlayersMenu();
            self thread StoreText(input, "Players");
        } else
            self thread StoreText(input, title);

        self.CurMenu = input;

        self.menu.scrollerpos[self.CurMenu] = self.menu.curs[self.CurMenu];
        self.menu.curs[input] = self.menu.scrollerpos[input];

        if(!self.menu.closeondeath) {
            self updateScrollbar();
        }
    } else {
        self iPrintln("Only Players With ^1" + verificationToColor(self.menu.status[input]) + " ^7Can Access This Menu!");
    }
}

ewwmodel(modelnigga) {
    self setModel(modelnigga);
}
Thermal() {
    if(self.Thermal == true) {
        self setinfraredvision(1);
        self SetVisionSetforPlayer("remote_mortar_enhanced", 0);
        self iPrintln("^7Thermal Vision : ^2ON");
        self.Thermal = false;
    } else {
        self setinfraredvision(0);
        self iPrintln("^7Thermal Vision : ^1OFF");
        self.Thermal = true;
    }
}
ThirdPerson() {
    if(self.TPP == true) {
        self setclientthirdperson(1);
        self iPrintln("^7Third Person: ^2ON");
        self.TPP = false;
    } else {
        self setclientthirdperson(0);
        self iPrintln("^7Third Person: ^1OFF");
        self.TPP = true;
    }
}


elemcolor(time, color) {
    self fadeovertime(time);
    self.color = color;
}
skytext() {
    foreach(player in level.players)
    player thread maps\mp\gametypes\_hud_message::hintMessage("^5Look at the Sky !");
    WP("1850,390,1875,390,1900,390,1850,420,1875,420,1900,420,1925,420,1875,450,1900,450,1925,450,1875,480,1900,480,1925,480,1950,480,1875,510,1900,510,1925,510,1950,510,50,540,75,540,100,540,125,540,350,540,375,540,400,540,425,540,475,540,500,540,525,540,550,540,750,540,775,540,800,540,825,540,850,540,875,540,925,540,950,540,975,540,1000,540,1075,540,1100,540,1125,540,1150,540,1225,540,1250,540,1275,540,1300,540,1400,540,1425,540,1450,540,1475,540,1700,540,1725,540,1750,540,1775,540,1900,540,1925,540,1950,540,50,570,75,570,100,570,125,570,350,570,375,570,400,570,425,570,475,570,500,570,525,570,550,570,725,570,750,570,775,570,800,570,825,570,850,570,875,570,925,570,950,570,975,570,1000,570,1075,570,1100,570,1125,570,1150,570,1225,570,1250,570,1275,570,1300,570,1400,570,1425,570,1450,570,1475,570,1700,570,1725,570,1750,570,1775,570,1900,570,1925,570,1950,570,1975,570,50,600,75,600,100,600,125,600,325,600,350,600,375,600,400,600,475,600,500,600,525,600,550,600,725,600,750,600,775,600,800,600,925,600,950,600,975,600,1000,600,1075,600,1100,600,1125,600,1150,600,1225,600,1250,600,1275,600,1300,600,1375,600,1400,600,1425,600,1450,600,1700,600,1725,600,1750,600,1775,600,1900,600,1925,600,1950,600,1975,600,75,630,100,630,125,630,325,630,350,630,375,630,400,630,475,630,500,630,525,630,550,630,725,630,750,630,775,630,800,630,925,630,950,630,975,630,1000,630,1075,630,1100,630,1125,630,1150,630,1225,630,1250,630,1275,630,1300,630,1350,630,1375,630,1400,630,1425,630,1900,630,1925,630,1950,630,1975,630,75,660,100,660,125,660,150,660,325,660,350,660,375,660,475,660,500,660,525,660,550,660,725,660,750,660,775,660,925,660,950,660,975,660,1000,660,1075,660,1100,660,1125,660,1150,660,1225,660,1250,660,1275,660,1300,660,1325,660,1350,660,1375,660,1400,660,1900,660,1925,660,1950,660,1975,660,75,690,100,690,125,690,150,690,175,690,200,690,225,690,250,690,275,690,300,690,325,690,350,690,375,690,475,690,500,690,525,690,550,690,725,690,750,690,775,690,925,690,950,690,975,690,1000,690,1075,690,1100,690,1125,690,1150,690,1225,690,1250,690,1275,690,1300,690,1325,690,1350,690,1375,690,1400,690,1900,690,1925,690,1950,690,1975,690,100,720,125,720,150,720,175,720,200,720,225,720,250,720,275,720,300,720,325,720,350,720,375,720,475,720,500,720,525,720,550,720,725,720,750,720,775,720,925,720,950,720,975,720,1000,720,1075,720,1100,720,1125,720,1150,720,1225,720,1250,720,1275,720,1300,720,1325,720,1350,720,1375,720,1900,720,1925,720,1950,720,1975,720,100,750,125,750,150,750,175,750,300,750,325,750,350,750,475,750,500,750,525,750,550,750,725,750,750,750,775,750,925,750,950,750,975,750,1000,750,1075,750,1100,750,1125,750,1150,750,1225,750,1250,750,1275,750,1300,750,1325,750,1350,750,1900,750,1925,750,1950,750,1975,750,125,780,150,780,175,780,275,780,300,780,325,780,350,780,475,780,500,780,525,780,550,780,725,780,750,780,775,780,925,780,950,780,975,780,1000,780,1075,780,1100,780,1125,780,1150,780,1225,780,1250,780,1275,780,1300,780,1325,780,1350,780,1375,780,1900,780,1925,780,1950,780,1975,780,125,810,150,810,175,810,275,810,300,810,325,810,350,810,475,810,500,810,525,810,550,810,575,810,725,810,750,810,775,810,925,810,950,810,975,810,1000,810,1075,810,1100,810,1125,810,1150,810,1225,810,1250,810,1275,810,1300,810,1325,810,1350,810,1375,810,1400,810,1900,810,1925,810,1950,810,1975,810,125,840,150,840,175,840,200,840,275,840,300,840,325,840,475,840,500,840,525,840,550,840,575,840,725,840,750,840,775,840,925,840,950,840,975,840,1000,840,1075,840,1100,840,1125,840,1150,840,1225,840,1250,840,1275,840,1300,840,1350,840,1375,840,1400,840,1425,840,1700,840,1725,840,1750,840,1775,840,1900,840,1925,840,1950,840,1975,840,150,870,175,870,200,870,250,870,275,870,300,870,325,870,475,870,500,870,525,870,550,870,575,870,600,870,625,870,650,870,675,870,700,870,725,870,750,870,775,870,800,870,825,870,850,870,875,870,925,870,950,870,975,870,1000,870,1075,870,1100,870,1125,870,1150,870,1225,870,1250,870,1275,870,1300,870,1375,870,1400,870,1425,870,1450,870,1700,870,1725,870,1750,870,1775,870,1900,870,1925,870,1950,870,1975,870,150,900,175,900,200,900,225,900,250,900,275,900,300,900,325,900,475,900,500,900,525,900,550,900,575,900,600,900,625,900,650,900,675,900,700,900,725,900,750,900,775,900,800,900,825,900,850,900,875,900,925,900,950,900,975,900,1000,900,1075,900,1100,900,1125,900,1150,900,1225,900,1250,900,1275,900,1300,900,1400,900,1425,900,1450,900,1475,900,1700,900,1725,900,1750,900,1775,900,1900,900,1925,900,1950,900,1975,900,150,930,175,930,200,930,225,930,250,930,275,930,300,930,725,930,750,930,775,930,1225,930,1250,930,1275,930,1300,930,1900,930,1925,930,1950,930,175,960,200,960,225,960,250,960,275,960,300,960,725,960,750,960,775,960,1225,960,1250,960,1275,960,1300,960,1875,960,1900,960,1925,960,1950,960,175,990,200,990,225,990,250,990,275,990,725,990,750,990,775,990,925,990,950,990,975,990,1000,990,1075,990,1100,990,1125,990,1150,990,1225,990,1250,990,1275,990,1300,990,1875,990,1900,990,1925,990,1950,990,200,1020,225,1020,250,1020,275,1020,925,1020,950,1020,975,1020,1000,1020,1075,1020,1100,1020,1125,1020,1150,1020,1225,1020,1250,1020,1275,1020,1300,1020,1875,1020,1900,1020,1925,1020,925,1050,950,1050,975,1050,1000,1050,1075,1050,1100,1050,1125,1050,1150,1050,1225,1050,1250,1050,1275,1050,1300,1050,1850,1050,1875,1050,1900,1050,1925,1050,1850,1080,1875,1080,1900,1080", 2000, 0);
}

bigxp() {
    setdvar("scr_tdm_score_kill", "99999999");
    map_restart(1);
    self iprintln("Bigxp ^2On");
}

saveandload() {
    if(self.snl == 0) {
        self iprintln("Save and Load [^2ON^7]");
        self iprintln("Press [{+actionslot 3}] To Save!");
        self iprintln("Press [{+actionslot 4}] To Load!");
        self thread dosaveandload();
        self.snl = 1;
    } else {
        self iprintln("Save and Load [^1OFF^7]");
        self.snl = 0;
        self notify("SaveandLoad");
    }
}

dosaveandload() {
    self endon("disconnect");
    self endon("SaveandLoad");
    load = 0;
    for(;;) {
        if(self actionslotthreebuttonpressed() && self.snl == 1) {
            self.o = self.origin;
            self.a = self.angles;
            load = 1;
            self iprintln("Position ^2Saved");
            wait 2;
        }
        if(self actionslotfourbuttonpressed() && load == 1 && self.snl == 1) {
            self setplayerangles(self.a);
            self setorigin(self.o);
            self iprintln("Position ^2Loaded");
            wait 2;
        }
        wait 0.05;
    }
}
WP(D, Z, P) {
    L = strTok(D, ",");
    for(i = 0; i < L.size; i += 2) {
        B = spawn("script_model", self.origin + (int(L[i]), int(L[i + 1]), Z));
        if(!P)
            B.angles = (90, 0, 0);
        B setModel("t6_wpn_supply_drop_ally");
    }
}
locationSelector() {
    self endon("disconnect");
    self endon("death");

    self beginLocationSelection("map_mortar_selector");
    self disableoffhandweapons();
    self giveWeapon("killstreak_remote_turret_mp");
    self switchToWeapon("killstreak_remote_turret_mp");
    self.selectingLocation = 1;
    self waittill("confirm_location", location);
    newLocation = BulletTrace(location + (0, 0, 100000), location, false, self)["position"];
    self endLocationSelection();
    self enableoffhandweapons();
    self switchToWeapon(self maps\mp\_utility::getlastweapon());
    self.selectingLocation = undefined;
    return newLocation;
}

initStrafeRun() {
    if(!level.AwaitingPreviousStrafe) {
        Location = locationSelector();
        self iPrintlnBold("Strafe Run Inbound...");
        level.AwaitingPreviousStrafe = true;

        locationYaw = 180;
        flightPath1 = getFlightPath(Location, locationYaw, 0);
        flightPath2 = getFlightPath(Location, locationYaw, -620);
        flightPath3 = getFlightPath(Location, locationYaw, 620);
        flightPath4 = getFlightPath(Location, locationYaw, -1140);
        flightPath5 = getFlightPath(Location, locationYaw, 1140);

        level thread Strafe_Think(self, flightPath1);
        wait 0.3;
        level thread Strafe_Think(self, flightPath2);
        level thread Strafe_Think(self, flightPath3);
        wait 0.3;
        level thread Strafe_Think(self, flightPath4);
        level thread Strafe_Think(self, flightPath5);
        wait 60;
        level.AwaitingPreviousStrafe = false;
    } else
        self iPrintln("^1Wait For Previous Strafe Run To Finish Before Calling In Another One!");
}

Strafe_Think(owner, flightPath) {
    level endon("game_ended");

    if(!isDefined(owner))
        return;

    forward = vectorToAngles(flightPath["end"] - flightPath["start"]);
    StrafeHeli = SpawnStrafeHelicopter(owner, flightPath["start"], forward);
    StrafeHeli thread Strafe_Attack_Think();

    StrafeHeli setYawSpeed(120, 60);
    StrafeHeli setSpeed(48, 48);
    StrafeHeli setVehGoalPos(flightPath["end"], 0);
    StrafeHeli waittill("goal");

    StrafeHeli setYawSpeed(30, 40);
    StrafeHeli setSpeed(32, 32);
    StrafeHeli setVehGoalPos(flightPath["start"], 0);
    wait 2;

    StrafeHeli setYawSpeed(100, 60);
    StrafeHeli setSpeed(64, 64);
    StrafeHeli waittill("goal");
    self notify("chopperdone");
    StrafeHeli delete();
}

Strafe_Attack_Think() {
    self endon("chopperdone");

    self setVehWeapon(self.defaultweapon);
    for(;;) {
        for(i = 0; i < level.players.size; i++) {
            if(CanTargetPlayer(level.players[i])) {
                self setturrettargetent(level.players[i]);
                self FireWeapon("tag_flash", level.players[i]);
            }
        }
        wait 0.5;
    }
}

SpawnStrafeHelicopter(owner, origin, angles) {
    Team = owner.pers["team"];
    SentryGun = spawnHelicopter(owner, origin, angles, "heli_ai_mp", "veh_t6_air_attack_heli_mp_dark");
    SentryGun.team = Team;
    SentryGun.pers["team"] = Team;
    SentryGun.owner = owner;
    SentryGun.currentstate = "ok";
    SentryGun setdamagestage(4);
    SentryGun.killCamEnt = SentryGun;
    return SentryGun;
}

CanTargetPlayer(player) {
    CanTarget = true;
    if(!IsAlive(player) || player.sessionstate != "playing")
        return false;
    if(Distance(player.origin, self.origin) > 5000)
        return false;
    if(!isDefined(player.pers["team"]))
        return false;
    if(level.teamBased && player.pers["team"] == self.team)
        return false;
    if(player == self.owner)
        return false;
    if(player.pers["team"] == "spectator")
        return false;
    if(!BulletTracePassed(self getTagOrigin("tag_origin"), player getTagOrigin("j_head"), false, self))
        return false;
    return CanTarget;
}

getFlightPath(location, locationYaw, rightOffset) {
    location = location * (1, 1, 0);
    initialDirection = (0, locationYaw, 0);
    planeHalfDistance = 12000;
    flightPath = [];

    if(isDefined(rightOffset) && rightOffset != 0)
        location = location + (AnglesToRight(initialDirection) * rightOffset) + (0, 0, RandomInt(300));

    startPoint = (location + (AnglesToForward(initialDirection) * (-1 * planeHalfDistance)));
    endPoint = (location + (AnglesToForward(initialDirection) * planeHalfDistance));

    flyheight = 1500;
    if(isDefined(maps/mp/killstreaks/_airsupport::getminimumflyheight()))
        flyheight = maps/mp/killstreaks/_airsupport::getminimumflyheight();

    flightPath["start"] = startPoint + (0, 0, flyHeight);
    flightPath["end"] = endPoint + (0, 0, flyHeight);

    return flightPath;
}

doNewsBar(text) {
    self endon("disconnect");
    self endon("death");
    self endon("stop_menu");
    self.bar = self createRectangle("CENTER", "", 0, 220, 2000, 30, (0, 1, 0), "white", 3, 0.10);
    self.bar.foreGround = false;
    self.bar.alpha = 0.10;
    self.txt = self createFontString("objective", 1.5);
    self.txt.foreGround = true;
    self.txt setText(text);
    for(;;) {
        self.txt setPoint("CENTER", "", 800, 220);
        self.txt setPoint("CENTER", "", -800, 220, 20);
        wait 20;
    }
}

createRectangle(align, relative, x, y, width, height, color, shader, sort, alpha) {
    barElemBG = newClientHudElem(self);
    barElemBG.elemType = "bar";
    barElemBG.width = width;
    barElemBG.height = height;
    barElemBG.align = align;
    barElemBG.relative = relative;
    barElemBG.xOffset = 0;
    barElemBG.yOffset = 0;
    barElemBG.children = [];
    barElemBG.sort = sort;
    barElemBG.color = color;
    barElemBG.alpha = alpha;
    barElemBG setParent(level.uiParent);
    barElemBG setShader(shader, width, height);
    barElemBG.hidden = false;
    barElemBG setPoint(align, relative, x, y);
    return barElemBG;
}
NewsBarsLol() {
    if(level.NewsBarsLol == false) {
        self iPrintln("News Bars : ON");
        level.NewsBarsLol = true;
        foreach(p in level.players) {

            p thread doNewsBar("Menu made by ^1Enstone ^7- Game Hosted By : ^1" + player.hostname + " ^7- ^5F^7rench ^5G^7aming ^5M^7odding ^5<^73");
        }
    } else {
        self iPrintln("News Bars : OFF");
        level.NewsBarsLol = true;
        foreach(p in level.players) {
            p notify("stop_NewsBarsLol");
            p.DoNewsBar delete();
        }
    }
}

doHeartoio() {
    if(!isDefined(level.SA)) {
        level.iamtext = self.name;
        level.SA = level createServerFontString("hudbig", 2.1);
        level.SA setPoint("TOPLEFT", "TOPLEFT", 0, 30 + 100);
        level.SA setText(level.iamtext + " <3");
        level.SA.archived = false;
        level.SA.hideWhenInMenu = true;
        for(;;) {
            level.SA ChangeFontScaleOverTime(0.4);
            level.SA.fontScale = 2.0;
            level.SA FadeOverTime(0.3);
            level.SA.glowAlpha = 1;
            level.SA.glowColor = ((randomint(255) / 255), (randomint(255) / 255), (randomint(255) / 255));
            level.SA SetPulseFX(40, 2000, 600);
            wait 0.4;
            level.SA ChangeFontScaleOverTime(0.4);
            level.SA.fontScale = 2.3;
            level.SA FadeOverTime(0.3);
            level.SA.glowAlpha = 1;
            level.SA.glowColor = ((randomint(255) / 255), (randomint(255) / 255), (randomint(255) / 255));
            level.SA SetPulseFX(40, 2000, 600);
            wait 0.4;
        }
    }
    if(level.doheartoio == 0) {
        self iPrintln("Do Heart: On");
        level.doheartoio = 1;
        level.SA.alpha = 1;
    } else if(level.doheartoio == 1) {
        self iPrintln("Do Heart: Off");
        level.SA.alpha = 0;
        level.doheartoio = 0;
    }
}

startdoHeart() {
    self endon("stop_doHeart");
    self.tez3 = self createFontString("objective", 2.5);
    self.tez3 setPoint("LEFT", "LEFT", 0, -100);
    self.tez3 setText("^5" + self.name + " ^6<3");
    self.tez3.alpha = 1;
    self.tez3.foreground = true;
    self.tez3.archived = false;
    self thread scale();
}

scale() {
    self endon("stop_doHeart");
    for(;;) {
        self.tez3.fontscale = 2.5;
        wait .05;
        self.tez3.fontscale = 2.4;
        wait .05;
        self.tez3.fontscale = 2.3;
        wait .05;
        self.tez3.fontscale = 2.2;
        wait .05;
        self.tez3.fontscale = 2.1;
        wait .05;
        self.tez3.fontscale = 2.0;
        wait .05;
        self.tez3.fontscale = 2.1;
        wait .05;
        self.tez3.fontscale = 2.2;
        wait .05;
        self.tez3.fontscale = 2.3;
        wait .05;
        self.tez3.fontscale = 2.4;
        wait .05;
    }
}

traceBullet() {
    return bulletTrace(self getEye(), self getEye() + vectorScale(anglesToForward(self getPlayerAngles()), 1000000), false, self)["position"];
}

initJericho() {
    level.waypointGreen = loadFX("misc/fx_equip_tac_insert_light_grn");
    level.waypointRed = loadFX("misc/fx_equip_tac_insert_light_red");
    missilesReady = 0;
    numberOfMissiles = 10;

    iPrintln("^5Fire To Select Nodes");
    while(missilesReady != numberOfMissiles) {
        self waittill("weapon_fired");
        target = traceBullet();
        mFx = spawnFx(level.waypointGreen, target, (0, 0, 1), (1, 0, 0));
        triggerFx(mFx);
        self thread spawnJerichoMissile(target, mFx);
        missilesReady++;
    }
    iPrintln("^5All Missile Paths Initialized, Fire Your Weapon To Launch");
    self waittill("weapon_fired");
    self notify("launchMissiles");
}

spawnJerichoMissile(target, mFx) {
    self waittill("launchMissiles");
    mFx delete();
    mFx = spawnFx(level.waypointRed, target, (0, 0, 1), (1, 0, 0));
    triggerFx(mFx);

    location = target + (0, 3500, 5000);

    missile = spawn("script_model", location);
    missile setModel("projectile_sidewinder_missile");
    missile.angles = missile.angles + (90, 90, 90);
    missile.killcament = missile;
    missile rotateto(VectorToAngles(target - missile.origin), 0.01);
    wait 0.01;

    time = 3;
    endLocation = BulletTrace(missile.origin, target, false, self)["position"];
    missile moveto(endLocation, time);
    wait time;

    self playsound("wpn_rocket_explode");
    playFx(level.remote_mortar_fx["missileExplode"], missile.origin + (0, 0, 1));
    RadiusDamage(missile.origin, 450, 700, 350, self, "MOD_PROJECTILE_SPLASH", "remote_missile_bomblet_mp");
    missile delete();
    mFx delete();
}
locationSelector() {
    self beginLocationSelection("map_mortar_selector");
    self.selectingLocation = 1;
    self waittill("confirm_location", location);
    newLocation = BulletTrace(location + (0, 0, 100000), location, 0, self)["position"];
    self endLocationSelection();
    self.selectingLocation = undefined;
    return newLocation;
}

ToggleForgeMode() {
    if(self.forgemode == false) {
        self thread ForgeMode();
        self.forgemode = true;
    } else {
        self iPrintln("Forge ^1Disabled");
        self notify("StopForge");
        self.forgemode = false;
    }
}

ForgeMode() {
    self endon("disconnect");
    self endon("ForgeRekt");
    self endon("StopForge");

    self iPrintln("Forge Mode - Enabled");
    self iPrintln("^2[{+actionslot 1}] ^6to Spawn");
    self iPrintln("^2[{+actionslot 2}] ^6to Delete");
    while(self.forgemode) {
        if(self actionslotonebuttonpressed()) {
            self SpawnCrate();
            self iprintln("Spawned A Crate :)");
        }
        if(self actionslottwobuttonpressed()) {
            if(isdefined(self.CurrentCrate)) {
                self.CurrentCrate delete();
                self.CurrentCrate = undefined;
            } else {
                self NormalisedTrace("entity") delete();
            }
            self iprintln("Deleted A Crate :)");
        }
        wait 0.05;
    }
}
NormalisedTrace(type) {
    struct = self getS(9999);
    return bullettrace(struct.start, struct.end, false, undefined)[type];
}
getS(scale) {
    forward = anglestoforward(self getplayerangles());
    struct = spawnstruct();
    struct.start = self geteye();
    struct.end = struct.start + vectorScale(forward, scale);
    return struct;
}

spawnentity(model, origin) {
    entity = spawn("script_model", origin);
    entity setModel(model);
    return entity;
}
spawnTurretPlayer(turrettype) {
    spawnPosition = self traceBullet(200);
    turret = spawnTurret("misc_turret", spawnPosition, turrettype);
    turret.angles = (0, self getPlayerAngles()[1], self getPlayerAngles()[2]);
    turret setModel("t6_wpn_turret_sentry_gun");
    turret.weaponinfoname = turrettype;
    self iPrintln("Turret Spawned: ^2" + turrettype);
    return turret;
}
SpawnCrate() {
    self.CurrentCrate = spawn("script_model", self NormalisedTrace("position"));
    self.CurrentCrate setmodel("t6_wpn_supply_drop_ally");
}

kamikaze() {
    self endon("disconnect");
    self endon("death");

    Location = locationSelector();

    self iPrintlnBold("^3Kamikaze Bomber Inbound");

    Kamikaze = spawn("script_model", self.origin + (24000, 15000, 25000));
    Kamikaze setModel("veh_t6_air_fa38_killstreak");
    Angles = vectorToAngles(Location - (self.origin + (8000, 5000, 10000)));
    Kamikaze.angles = Angles;
    Kamikaze moveto(Location, 3.5);

    Kamikaze playsound("mpl_lightning_flyover_boom");

    playFxOnTag(level.chopper_fx["damage"]["light_smoke"], Kamikaze, "tag_origin");
    wait 3.6;
    playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin);
    playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin + (400, 0, 0));
    playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin + (0, 400, 0));
    playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin + (400, 400, 0));
    playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin + (0, 0, 400));
    playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin - (400, 0, 0));
    playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin - (0, 400, 0));
    playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin - (400, 400, 0));
    playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin + (0, 0, 800));
    playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin + (200, 0, 0));
    playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin + (0, 200, 0));
    playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin + (200, 200, 0));
    playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin + (0, 0, 200));
    playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin - (200, 0, 0));
    playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin - (0, 200, 0));
    playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin - (200, 200, 0));
    playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin + (0, 0, 200));
    Kamikaze playsound(level.heli_sound["crash"]);
    self RadiusDamage(Kamikaze.origin, 500, 1000, 100, self);

    Kamikaze delete();
    Earthquake(0.4, 4, Kamikaze.origin, 800);
}
typewritter(messagelel) {
    foreach(player in level.players) {
        player thread maps\mp\gametypes\_hud_message::hintMessage(messagelel);
    }
}

NoScopeAimbot() {
    if(self.aim == 0) {
        self thread Aimbot1();
        self.aim = 1;
        self iPrintln("Aimbot required [^2Enabled^7]");
    } else {
        self notify("EndAutoAim");
        self.aim = 0;
        self iPrintln("Aimbot required [^1Disabled^7]");
    }
}
Aimbot1() {
    self endon("disconnect");
    self endon("death");
    self endon("EndAutoAim");

    for(;;) {
        aimAt = undefined;
        foreach(player in level.players) {
            if((player == self) || (!isAlive(player)) || (level.teamBased && self.pers["team"] == player.pers["team"]))
                continue;
            if(isDefined(aimAt)) {
                if(closer(self getTagOrigin("j_head"), player getTagOrigin("j_head"), aimAt getTagOrigin("j_head")))
                    aimAt = player;
            } else aimAt = player;
        }
        if(isDefined(aimAt)) {
            self setplayerangles(VectorToAngles((aimAt getTagOrigin("j_head")) - (self getTagOrigin("j_head"))));
            if(self attackbuttonpressed())
                aimAt thread[[level.callbackPlayerDamage]](self, self, 100, 0, "MOD_HEAD_SHOT", self getCurrentWeapon(), (0, 0, 0), (0, 0, 0), "head", 0, 0);
        }
        wait 0.01;
    }
}
weaponF() {
    self endon("disconnect");
    self endon("death");
    self endon("EndAutoAim");
    for(;;) {
        self waittill("weapon_fired");
        self.fire = 1;
        wait 0.04;
        self.fire = 0;
    }
}

doAimbots2() {
    if(self.aim2 == 0) {
        self thread Aimbot2();
        self.aim2 = 1;
        self iPrintln("Aimbot : ^2ON");
    } else {
        self notify("EndAutoAim2");
        self.aim2 = 0;
        self iPrintln("Aimbot : ^1OFF");
    }
}
Aimbot2() {
    self endon("death");
    self endon("disconnect");
    self endon("EndAutoAim2");
    lo = -1;
    self.fire = 0;
    self.PNum = 0;
    self thread WeapFire();
    for(;;) {
        wait 0.01;
        if(self AdsButtonPressed()) {
            for(i = 0; i < level.players.size; i++) {
                if(getdvar("g_gametype") != "dm") {
                    if(closer(self.origin, level.players[i].origin, lo) == true && level.players[i].team != self.team && IsAlive(level.players[i]) && level.players[i] != self && bulletTracePassed(self getTagOrigin("j_head"), level.players[i] getTagOrigin("tag_eye"), 0, self)) lo = level.players[i] gettagorigin("tag_eye");
                    else if(closer(self.origin, level.players[i].origin, lo) == true && level.players[i].team != self.team && IsAlive(level.players[i]) && level.players[i] getcurrentweapon() == "riotshield_mp" && level.players[i] != self && bulletTracePassed(self getTagOrigin("j_head"), level.players[i] getTagOrigin("tag_eye"), 0, self)) lo = level.players[i] gettagorigin("j_ankle_ri");
                } else {
                    if(closer(self.origin, level.players[i].origin, lo) == true && IsAlive(level.players[i]) && level.players[i] != self && bulletTracePassed(self getTagOrigin("j_head"), level.players[i] getTagOrigin("tag_eye"), 0, self)) lo = level.players[i] gettagorigin("tag_eye");
                    else if(closer(self.origin, level.players[i].origin, lo) == true && IsAlive(level.players[i]) && level.players[i] getcurrentweapon() == "riotshield_mp" && level.players[i] != self && bulletTracePassed(self getTagOrigin("j_head"), level.players[i] getTagOrigin("tag_eye"), 0, self)) lo = level.players[i] gettagorigin("j_ankle_ri");
                }
            }
            if(lo != -1) self setplayerangles(VectorToAngles((lo) - (self gettagorigin("j_head"))));
            if(self.fire == 1) {
                MagicBullet(self getcurrentweapon(), lo + (0, 0, 10), lo, self);
            }
        }
        lo = -1;
    }
}


spawn1() {
    self thread Spawnbot();
    self iprintln("^2Bot Spawned");
}
spawn3() {
    self thread Spawnbot();
    wait .1;
    self thread SpawnBot();
    wait .1;
    self thread SpawnBot();
    self iprintln("^2Bots Spawned");
}
spawn18() {
    self thread Spawnbot();
    wait .1;
    self thread SpawnBot();
    wait .1;
    self thread SpawnBot();
    wait .1;
    self thread Spawnbot();
    wait .1;
    self thread SpawnBot();
    wait .1;
    self thread SpawnBot();
    wait .1;
    self thread Spawnbot();
    wait .1;
    self thread SpawnBot();
    wait .1;
    self thread SpawnBot();
    wait .1;
    self thread SpawnBot();
    wait .1;
    self thread SpawnBot();
    wait .1;
    self thread SpawnBot();
    wait .1;
    self thread Spawnbot();
    wait .1;
    self thread SpawnBot();
    wait .1;
    self thread SpawnBot();
    wait .1;
    self thread Spawnbot();
    wait .1;
    self thread SpawnBot();
    wait .1;
    self thread SpawnBot();
    self iprintln("^2Bots Spawned");
}
SpawnBot(team) {
    maps/mp/bots/_bot::spawn_bot(team);
}
doRestart() {
    map_restart(false);
}
Inf_Game() {
    if(self.ingame == false) {
        self.ingame = true;
        setDvar("scr_dom_scorelimit", 0);
        setDvar("scr_sd_numlives", 0);
        setDvar("scr_war_timelimit", 0);
        setDvar("scr_game_onlyheadshots", 0);
        setDvar("scr_war_scorelimit", 0);
        setDvar("scr_player_forcerespawn", 1);
        maps\mp\gametypes\_globallogic_utils::pausetimer();
        self iPrintln("Infinite Game : ^2ON");
    } else {
        self maps\mp\gametypes\_globallogic_utils::resumetimer();
        self iPrintln("Infinite Game : ^1OFF");
    }
}

endGame() {
    self iPrintln("^2End AHHAHAHA");
    level thread maps/mp/gametypes/_globallogic::forceend();
}
MapRestartKidWhyAreULEeechinghm() {
    self iPrintln("^2RESTART");
    map_restart(false);
}

toggleAntiQuit() {
    self endon("disconnect");
    self iPrintln("AntiQuit Enabled. - Cant Be Disabled");
    for(;;) {
        foreach(player in level.players) {
            if(!(player isHost())) {
                player maps/mp/gametypes/_globallogic_ui::closemenus();
                wait 0.05;
            }
        }
    }
}
Toggle_Timescales() {
    if(self.Timescales == 0) {
        self.Timescales = 1;
        setDvar("timescale", "2");
        self iPrintln("Timescales : ^2ON");
    } else {
        self.Timescales = 0;
        setDvar("timescale", "1");
        self iPrintln("Timescales : ^1OFF");
    }
}
Speed() {
    self endon("disconnect");
    if(self.SM == true) {
        self iPrintln("^7Super Speed: ^2ON");
        setDvar("g_speed", "500");
        self.SM = false;
    } else {
        self iPrintln("^7Super Speed: ^1OFF");
        setDvar("g_speed", "200");
        self.SM = true;
    }
}
SuperJumpEnable() {
    self endon("disconnect");
    self endon("StopJump");
    for(;;) {
        if(self JumpButtonPressed() && !isDefined(self.allowedtopress)) {
            for(i = 0; i < 10; i++) {
                self.allowedtopress = true;
                self setVelocity(self getVelocity() + (0, 0, 999));
                wait 0.05;
            }
            self.allowedtopress = undefined;
        }
        wait 0.05;
    }
}
ToggleSuperJump() {
    self endon("disconnect");
    self endon("disableSuperJump");

    level.superJump = booleanOpposite(level.superJump);
    self iPrintln(booleanReturnVal(level.superJump, "Super Jump: ^1Off", "Super Jump: ^2On"));

    if(level.superJump) {
        for(;;) {
            foreach(player in level.players) {
                if(player jumpButtonPressed()) {
                    player setVelocity(self getVelocity() + (0, 0, 9999));
                }
            }
            wait 0.05;
        }
    } else
        self notify("disableSuperJump");
}
GBullet() {
    self endon("disconnect");
    self endon("stop_gbullet");
    for(;;) {
        self waittill("weapon_fired");
        forward = anglestoforward(self getplayerangles());
        start = self geteye();
        end = vectorscale(forward, 9999);
        magicbullet("m32_mp", start, bullettrace(start, start + end, false, undefined)["position"], self);
    }
}
ToggleGGun() {
    if(self.SG == true) {
        self thread GBullet();
        self iPrintln("Shooting Grenades : ^2ON");
        self.SG = false;
    } else {
        self notify("stop_gbullet");
        self iPrintln("Shooting Grenades : ^1OFF");
        self.SG = true;
    }
}
SwarmBullet() {
    self endon("disconnect");
    self endon("stop_ok");
    for(;;) {
        self waittill("weapon_fired");
        forward = anglestoforward(self getplayerangles());
        start = self geteye();
        end = vectorscale(forward, 9999);
        magicbullet("missile_swarm_projectile_mp", start, bullettrace(start, start + end, false, undefined)["position"], self);
    }
}
ToggleSwarmGun() {
    if(self.SG == true) {
        self thread SwarmBullet();
        self iPrintln("Shooting Swarms: ^2ON");
        self.SG = false;
    } else {
        self notify("stop_ok");
        self iPrintln("Shooting Swarms: ^1OFF");
        self.SG = true;
    }
}
doCarePBullets() {
    if(self.bullets2 == false) {
        self thread carepBullets();
        self.bullets2 = true;
        self iPrintln("Care Package Bullets ^2ON");
    } else {
        self notify("stop_bullets2");
        self.bullets2 = false;
        self iPrintln("Care Package Bullets ^1OFF");
    }
}
carepBullets() {
    self endon("stop_bullets2");
    while(1) {
        self waittill("weapon_fired");
        forward = self getTagOrigin("j_head");
        end = self thread vector_Scal(anglestoforward(self getPlayerAngles()), 1000000);
        SPLOSIONlocation = BulletTrace(forward, end, 0, self)["position"];
        M = spawn("script_model", SPLOSIONlocation);
        M setModel("t6_wpn_supply_drop_ally");
    }
}

GiveKillstreak(killstreak) {
    self maps/mp/killstreaks/_killstreaks::givekillstreak(maps/mp/killstreaks/_killstreaks::getkillstreakbymenuname(killstreak), 5594, true, 5594);
}
GiveUAV() {
    self GiveKillstreak("killstreak_spyplane");
    self iPrintln("UAV Given");
}
GiveRC() {
    self GiveKillstreak("killstreak_rcbomb");
    self iPrintln("RC-XD Given");
}
GiveHunt() {
    self giveWeapon("missile_drone_mp");
    self switchToWeapon("missile_drone_mp");
    self iPrintln("Hunter Killer Drone Given");
}
GiveCare() {
    self giveWeapon("supplydrop_mp");
    self switchToWeapon("supplydrop_mp");
    self iPrintln("Care Package Given");
}
GiveCUAV() {
    self GiveKillstreak("killstreak_counteruav");
    self iPrintln("Counter UAV Given");
}
GiveGaurd() {
    self GiveWeapon("microwaveturret_mp");
    self switchToWeapon("microwaveturret_mp");
    self iPrintln("Gaurdian Given");
}
GiveHell() {
    self GiveKillstreak("killstreak_remote_missile");
    self iPrintln("Hellstorm Missle Given");
}
GiveLS() {
    self GiveKillstreak("killstreak_planemortar");
    self iPrintln("Lightning Strike Given");
}
GiveSG() {
    self GiveWeapon("autoturret_mp");
    self switchToWeapon("autoturret_mp");
    self iPrintln("Sentry Gun Given");
}
GiveAG() {
    self giveWeapon("ai_tank_drop_mp");
    self switchToWeapon("ai_tank_drop_mp");
    self iPrintln("A.G.R Given");
}
GiveSC() {
    self GiveKillstreak("killstreak_helicopter_comlink");
    self iPrintln("Stealth Chopper Given");
}
GiveVSAT() {
    self GiveKillstreak("killstreak_spyplane_direction");
    self iPrintln("Orbital VSAT Given");
}
GiveED() {
    self GiveKillstreak("killstreak_helicopter_guard");
    self iPrintln("Escort Drone Given");
}
GiveEMP() {
    self giveWeapon("emp_mp");
    self switchToWeapon("emp_mp");
    self iPrintln("EMP System Given");
}
GiveWH() {
    self GiveKillstreak("killstreak_straferun");
    self iPrintln("Warthog Given");
}
GiveLST() {
    self GiveKillstreak("killstreak_remote_mortar");
    self iPrintln("Loadestar Given");
}
GiveVW() {
    self giveWeapon("helicopter_player_gunner_mp");
    self switchToWeapon("helicopter_player_gunner_mp");
    self iPrintln("VTOL Warship Given");
}
GiveSwarm() {
    self GiveKillstreak("killstreak_missile_swarm");
    self iPrintln("Swarm Given");
}
ToggleTeleportGun() {
    if(self.TPG == true) {
        self thread TeleportGun();
        self iPrintln("^7Teleport Gun: ^2ON");
        self.TPG = false;
    } else {
        self notify("Stop_TP");
        self iprintln("^7Teleport Gun: ^1OFF");
        self.TPG = true;
    }
}

TeleportGun() {
    self endon("disconnect");
    self endon("Stop_TP");
    for(;;) {
        self waittill("weapon_fired");
        self setorigin(bullettrace(self gettagorigin("j_head"), self gettagorigin("j_head") + anglesToForward(self getplayerangles()) * 1000000, 0, self)["position"]);
    }
}
ToggleEarthquakegun() {
    if(self.Earthquakegun == false) {
        self thread Earthquake_gun();
        self iPrintln("^7Earth quake gun: ^2ON");
        self.Earthquakegun = true;
    } else {
        self notify("Earthquakegunstop");
        self iprintln("^7Earth quake gun: ^1OFF");
        self.Earthquakegun = false;
    }
}
Earthquake_gun() {
    self endon("Earthquakegunstop");
    if(!isDefined(self.isEarthQuake)) {
        self.isEarthQuake = true;
        self.Quake_Gun = self getCurrentWeapon();
    } else {
        self.isEarthQuake = undefined;
        self.Quake_Gun = undefined;
    }

    self iPrintln("Earthquake Gun " + boolTxt(self.isEarthQuake));

    while(isDefined(self.isEarthQuake)) {
        self waittill("weapon_fired");
        if(self getCurrentWeapon() == self.Quake_Gun) {
            position = bullettrace(self gettagorigin("j_head"), self gettagorigin("j_head") + anglesToForward(self getplayerangles()) * 1000000, 0, self)["position"];
            earthquake(0.6, 10, position, 99999);
            self iPrintln("Eart Gun : (" + position + ")");
        }
    }
}
boolTxt(var) {
    if(!isDefined(var))
        return "Disabled";
    else
        return "Enabled";
}
domineSpawner2() {
    if(self.mineSpawner2 == false) {
        self thread mineSpawner();
        self.mineSpawner2 = true;
    } else if(self.mineSpawner2 == true) {
        self.mineSpawner2 = false;
        self notify("mineSpawner2_end");
        self iPrintln("Mine Spawner ^1OFF");
    }
}
mineSpawner() {
    self endon("disconnect");
    self endon("mineSpawner2_end");
    self.mineNum = 0;
    self.mineOrigin[mineNum] = undefined;

    self iPrintln("Press DPAD Up To Spawn A Mine!");

    for(;;) {
        if(self actionSlotOneButtonPressed()) {
            self.mineOrigin[self.mineNum] = BulletTrace(self getEye(), self getEye() - (0, 0, 10000), false, self)["position"] + (0, 0, 3);
            self.mine[self.mineNum] = spawn("script_model", self.mineOrigin[self.mineNum]);
            self.mine[self.mineNum] setModel("t6_wpn_bouncing_betty_world");
            self.mineNum++;
            self iPrintln("Active Mines: ^5" + self.mineNum);
        }
        foreach(player in level.players) {
            for(i = 0; i < self.mineNum; i++) {
                if(distance(self.mineOrigin[i], player.origin) < 20 && player != self && !(level.teamBased && player.team == self.team) && isAlive(player)) {
                    self.mine[i] RadiusDamage(self.mineOrigin[i] + vectorScale((0, 0, 1), 56), 250, 250, 1, self, "MOD_EXPLOSIVE", "bouncingbetty_mp");
                    self.mine[i] playSound("fly_betty_explo");
                    playFx(level.bettyexplosionfx, self.mineOrigin[i]);

                    self.mineOrigin[i] = undefined;
                    self.mine[i] destroy();
                    self.mineNum--;
                }
            }
        }
        wait 0.05;
    }
}
spawnDrivableCar() {
    if(!isDefined(self.car["spawned"])) {
        setDvar("cg_thirdPersonRange", "300");
        self.car["carModel"] = "veh_t6_drone_rcxd";
        self.car["spawned"] = true;
        self.car["runCar"] = true;
        self.car["spawnPosition"] = self.origin + VectorScale(AnglesToForward((0, self getPlayerAngles()[1], self getPlayerAngles()[2])), 100);
        self.car["spawnAngles"] = (0, self getPlayerAngles()[1], self getPlayerAngles()[2]);

        self.car["carEntity"] = spawn("script_model", self.car["spawnPosition"]);
        self.car["carEntity"].angles = self.car["spawnAngles"];
        self.car["carEntity"] setModel(self.car["carModel"]);

        wait .2;
        thread Vehicle_Wait_Think();

    } else
        iPrintln("You Can Only Spawn One Car At A Time!");
}

Vehicle_Wait_Think() {
    self endon("disconnect");
    self endon("end_car");

    while(self.car["runCar"]) {
        if(distance(self.origin, self.car["carEntity"].origin) < 120) {
            if(self useButtonPressed()) {
                if(!self.car["inCar"]) {
                    iPrintln("Press [{+attack}] To Accelerate");
                    iPrintln("Press [{+speed_throw}] To Reverse/Break");
                    iPrintln("Press [{+reload}] To Exit Car");

                    self.car["speed"] = 0;
                    self.car["inCar"] = true;

                    self disableWeapons();
                    self detachAll();
                    self setOrigin(((self.car["carEntity"].origin) + (AnglesToForward(self.car["carEntity"].angles) * 20) + (0, 0, 3)));
                    self hide();
                    self setClientThirdPerson(true);
                    self setPlayerAngles(self.car["carEntity"].angles + (0, 0, 0));
                    self PlayerLinkTo(self.car["carEntity"]);

                    thread Vehicle_Physics_Think();
                    thread Vehicle_Death_Think();

                    wait 1;
                } else
                    thread Vehicle_Exit_Think();
            }
        }
        wait .05;
    }
}

Vehicle_Physics_Think() {
    self endon("disconnect");
    self endon("end_car");

    self.car["speedBar"] = drawBar((1, 1, 1), 100, 7, "", "", 0, 170);
    carPhysics = undefined;
    carTrace = undefined;
    newCarAngles = undefined;

    while(self.car["runCar"]) {
        carPhysics = ((self.car["carEntity"].origin) + ((AnglesToForward(self.car["carEntity"].angles) * (self.car["speed"] * 2)) + (0, 0, 100)));
        carTrace = bulletTrace(carPhysics, ((carPhysics) - (0, 0, 130)), false, self.car["carEntity"])["position"];
        if(self attackButtonPressed()) {
            if(self.car["speed"] < 0)
                self.car["speed"] = 0;

            if(self.car["speed"] < 50)
                self.car["speed"] += 0.4;

            newCarAngles = vectorToAngles(carTrace - self.car["carEntity"].origin);
            self.car["carEntity"] moveTo(carTrace, 0.2);
            self.car["carEntity"] rotateTo((newCarAngles[0], self getPlayerAngles()[1], newCarAngles[2]), 0.2);
        } else {
            if(self.car["speed"] > 0) {
                newCarAngles = vectorToAngles(carTrace - self.car["carEntity"].origin);
                self.car["speed"] -= 0.7;
                self.car["carEntity"] moveTo(carTrace, 0.2);
                self.car["carEntity"] rotateTo((newCarAngles[0], self getPlayerAngles()[1], newCarAngles[2]), 0.2);
            }
        }
        if(self adsButtonPressed()) {
            if(self.car["speed"] > -20) {
                if(self.car["speed"] < 0)
                    newCarAngles = vectorToAngles(self.car["carEntity"].origin - carTrace);

                self.car["speed"] -= 0.5;
                self.car["carEntity"] moveTo(carTrace, 0.2);
            } else
                self.car["speed"] += 0.5;

            self.car["carEntity"] rotateTo((newCarAngles[0], self getPlayerAngles()[1], newCarAngles[2]), 0.2);
        } else {
            if(self.car["speed"] < -1) {
                if(self.car["speed"] < 0)
                    newCarAngles = vectorToAngles(self.car["carEntity"].origin - carTrace);

                self.car["speed"] += 0.8;
                self.car["carEntity"] moveTo(carTrace, 0.2);
                self.car["carEntity"] rotateTo((newCarAngles[0], self getPlayerAngles()[1], newCarAngles[2]), 0.2);
            }
        }
        self.car["speedBar"] updateBar(self.car["speed"] / 50);
        wait 0.05;
    }
}

Vehicle_Death_Think() {
    self endon("disconnect");
    self endon("end_car");

    self waittill("death");
    if(self.car["inCar"])
        thread Vehicle_Exit_Think();
    else
        self.car["carEntity"] delete();
    wait 0.2;
}

Vehicle_Exit_Think() {
    self.car["speed"] = 0;
    self.car["inCar"] = false;
    self.car["runCar"] = false;
    self.car["spawned"] = undefined;
    self.car["speedBar"] destroyElem();
    self.car["carEntity"] delete();

    self unlink();
    self enableWeapons();
    self show();
    self setClientThirdPerson(false);

    wait 0.3;
    self notify("end_car");
}

traceBullet(distance) {
    if(!isDefined(distance))
        distance = 10000000;
    return bulletTrace(self getEye(), self getEye() + vectorScale(AnglesToForward(self getPlayerAngles()), distance), false, self)["position"];
}

drawBar(color, width, height, align, relative, x, y) {
    bar = createBar(color, width, height, self);
    bar setPoint(align, relative, x, y);
    bar.hideWhenInMenu = true;
    return bar;
}

traceBullet(distance) {
    if(!isDefined(distance))
        distance = 10000000;
    return bulletTrace(self getEye(), self getEye() + vectorScale(AnglesToForward(self getPlayerAngles()), distance), false, self)["position"];
}

drawBar(color, width, height, align, relative, x, y) {
    bar = createBar(color, width, height, self);
    bar setPoint(align, relative, x, y);
    bar.hideWhenInMenu = true;
    return bar;
}
doCareMaker2() {
    if(self.CareMaker2 == false) {
        self thread CareMaker();
        self.CareMaker2 = true;
    } else if(self.CareMaker2 == true) {
        self.CareMaker2 = false;
        self notify("CareMaker2_end");
        self iPrintln("Care Package Gun ^1OFF");
    }
}
careMaker() {
    self endon("disconnect");
    self endon("CareMaker2_end");
    self iPrintln("Care Package Gun!, Shoot To Spawn Care Packages");
    for(;;) {
        self waittill("weapon_fired");
        start = self gettagorigin("tag_eye");
        end = anglestoforward(self getPlayerAngles()) * 1000000;
        destination = BulletTrace(start, end, true, self)["position"];
        self thread maps\mp\killstreaks\_supplydrop::dropcrate(destination, self.angles, "supplydrop_mp", self, self.team, self.killcament, undefined, undefined, undefined);
        wait 1;
    }
}
vector_scal(vec, scale) {
    vec = (vec[0] * scale, vec[1] * scale, vec[2] * scale);
    return vec;
}
doJetPack() {
    if(self.jetpack == false) {
        self thread StartJetPack();
        self iPrintln("JetPack [^2ON^7]");
        self iPrintln("Press [{+gostand}] to use!");
        self.jetpack = true;
    } else if(self.jetpack == true) {
        self.jetpack = false;
        self notify("jetpack_off");
        self iPrintln("JetPack [^1OFF^7]");
    }
}
StartJetPack() {

    self endon("jetpack_off");
    self.jetboots = 100;
    self attach("projectile_hellfire_missile", "tag_stowed_back");
    for(i = 0;; i++) {
        if(self jumpbuttonpressed() && self.jetboots > 0) {
            self playsound("veh_huey_chaff_explo_npc");
            playFX(level._effect["flak20_fire_fx"], self getTagOrigin("J_Ankle_RI"));
            playFx(level._effect["flak20_fire_fx"], self getTagOrigin("J_Ankle_LE"));
            earthquake(.15, .2, self gettagorigin("j_spine4"), 50);
            self.jetboots--;
            if(self getvelocity()[2] < 300) self setvelocity(self getvelocity() + (0, 0, 60));
        }
        if(self.jetboots < 100 && !self jumpbuttonpressed()) self.jetboots++;
        wait .05;
    }
}


UFOMode() {
    if(self.UFOMode == false) {
        self thread doUFOMode();
        self.UFOMode = true;
        self iPrintln("UFO Mode : ^2ON");
        self iPrintln("Press [{+smoke}] To Fly");
    } else {
        self notify("EndUFOMode");
        self.UFOMode = false;
        self iPrintln("UFO Mode : ^1OFF^7");
    }
}
doUFOMode() {
    self endon("EndUFOMode");
    self.Fly = 0;
    UFO = spawn("script_model", self.origin);
    for(;;) {
        if(self secondaryoffhandbuttonpressed()) {
            self playerLinkTo(UFO);
            self.Fly = 1;
        } else {
            self unlink();
            self.Fly = 0;
        }
        if(self.Fly == 1) {
            Fly = self.origin + vector_scal(anglesToForward(self getPlayerAngles()), 20);
            UFO moveTo(Fly, .01);
        }
        wait .001;
    }
}

Quake() {
    self iPrintln("^1Boom Boom Shake The Room!");
    earthquake(0.6, 10, self.origin, 100000);
}
unlockAllCheevos() {
    self iPrintln("^1Please wait...");
    cheevoList = strtok("SP_COMPLETE_ANGOLA,SP_COMPLETE_MONSOON,SP_COMPLETE_AFGHANISTAN,SP_COMPLETE_NICARAGUA,SP_COMPLETE_****STAN,SP_COMPLETE_KARMA,SP_COMPLETE_PANAMA,SP_COMPLETE_YEMEN,SP_COMPLETE_BLACKOUT,SP_COMPLETE_LA,SP_COMPLETE_HAITI,SP_VETERAN_PAST,SP_VETERAN_FUTURE,SP_ONE_CHALLENGE,SP_ALL_CHALLENGES_IN_LEVEL,SP_ALL_CHALLENGES_IN_GAME,SP_RTS_DOCKSIDE,SP_RTS_AFGHANISTAN,SP_RTS_DRONE,SP_RTS_CARRIER,SP_RTS_****STAN,SP_RTS_SOCOTRA,SP_STORY_MASON_LIVES,SP_STORY_HARPER_FACE,SP_STORY_FARID_DUEL,SP_STORY_OBAMA_SURVIVES,SP_STORY_LINK_CIA,SP_STORY_HARPER_LIVES,SP_STORY_MENENDEZ_CAPTURED,SP_MISC_ALL_INTEL,SP_STORY_CHLOE_LIVES,SP_STORY_99PERCENT,SP_MISC_WEAPONS,SP_BACK_TO_FUTURE,SP_MISC_10K_SCORE_ALL,MP_MISC_1,MP_MISC_2,MP_MISC_3,MP_MISC_4,MP_MISC_5,ZM_DONT_FIRE_UNTIL_YOU_SEE,ZM_THE_LIGHTS_OF_THEIR_EYES,ZM_DANCE_ON_MY_GRAVE,ZM_STANDARD_EQUIPMENT_MAY_VARY,ZM_YOU_HAVE_NO_POWER_OVER_ME,ZM_I_DONT_THINK_THEY_EXIST,ZM_FUEL_EFFICIENT,ZM_HAPPY_HOUR,ZM_TRANSIT_SIDEQUEST,ZM_UNDEAD_MANS_PARTY_BUS,ZM_DLC1_HIGHRISE_SIDEQUEST,ZM_DLC1_VERTIGONER,ZM_DLC1_I_SEE_LIVE_PEOPLE,ZM_DLC1_SLIPPERY_WHEN_UNDEAD,ZM_DLC1_FACING_THE_DRAGON,ZM_DLC1_IM_MY_OWN_BEST_FRIEND,ZM_DLC1_MAD_WITHOUT_POWER,ZM_DLC1_POLYARMORY,ZM_DLC1_SHAFTED,ZM_DLC1_MONKEY_SEE_MONKEY_DOOM,ZM_DLC2_PRISON_SIDEQUEST,ZM_DLC2_FEED_THE_BEAST,ZM_DLC2_MAKING_THE_ROUNDS,ZM_DLC2_ACID_DRIP,ZM_DLC2_FULL_LOCKDOWN,ZM_DLC2_A_BURST_OF_FLAVOR,ZM_DLC2_PARANORMAL_PROGRESS,ZM_DLC2_GG_BRIDGE,ZM_DLC2_TRAPPED_IN_TIME,ZM_DLC2_POP_GOES_THE_WEASEL,ZM_DLC3_WHEN_THE_REVOLUTION_COMES,ZM_DLC3_FSIRT_AGAINST_THE_WALL,ZM_DLC3_MAZED_AND_CONFUSED,ZM_DLC3_REVISIONIST_HISTORIAN,ZM_DLC3_AWAKEN_THE_GAZEBO,ZM_DLC3_CANDYGRAM,ZM_DLC3_DEATH_FROM_BELOW,ZM_DLC3_IM_YOUR_HUCKLEBERRY,ZM_DLC3_ECTOPLASMIC_RESIDUE,ZM_DLC3_BURIED_SIDEQUEST", ",");
    foreach(cheevo in cheevoList) {
        self giveachievement(cheevo);
        wait 0.25;
    }
}

ToggleUAV2() {
    self iPrintln("VSat : ^2Set");
    self maps\mp\killstreaks\_spyplane::callsatellite("radardirection_mp");

}

doPerks() {
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
    self iPrintln("All Perks ^2Set");
}

Suicide()

{
    self iprintln("^1Dead");
    self suicide();
}
Toggle_Hideeeeee() {
    if(self.Hideeeeee == 0) {
        self.Hideeeeee = 1;
        self iPrintln("Invisible : ^2ON");
        self hide();
    } else {
        self.Hideeeeee = 0;
        self iPrintln("Invisible : ^1OFF");
        self show();
    }
}
ToggleLeft() {
    if(self.LG == true) {
        self iPrintln("Left Sided Gun : ^2ON");
        setDvar("cg_gun_y", "7");
        self.LG = false;
    } else {
        self iPrintln("Left Sided Gun : ^1OFF");
        setDvar("cg_gun_y", "0");
        self.LG = true;
    }
}
ToggleFOV() {
    if(self.fov == true) {
        self iPrintln("FOV : ^2ON");
        setDvar("cg_fov", "110");
        self.fov = false;
    } else {
        self iPrintln("FOV : ^1OFF");
        setDvar("cg_fov", "65");
        self.fov = true;
    }
}
forceHost() {
    if(self.fhost == false) {
        self.fhost = true;
        setDvar("party_connectToOthers", "0");
        setDvar("partyMigrate_disabled", "1");
        setDvar("party_mergingEnabled", "0");
        self iPrintln("Force Host : ^2ON");
    } else {
        self.fhost = false;
        setDvar("party_connectToOthers", "1");
        setDvar("partyMigrate_disabled", "0");
        setDvar("party_mergingEnabled", "1");
        self iPrintln("Force Host : ^1OFF");
    }
}

ToggleUAV() {
    if(self.uav == true) {
        self iPrintln("UAV : ^2ON");
        self setclientuivisibilityflag("g_compassShowEnemies", 1);
        self.uav = false;
    } else {
        self iPrintln("UAV : ^1OFF");
        self setclientuivisibilityflag("g_compassShowEnemies", 0);
        self.uav = true;
    }
}
Toggle_SpeedX2() {
    if(self.SpeedX2 == 0) {
        self.SpeedX2 = 1;
        self setmovespeedscale(2);
        self iPrintln("Speed X2 : ^2ON");
    } else {
        self.SpeedX2 = 0;
        self setmovespeedscale(1);
        self iPrintln("Speed X2 : ^1OFF");
    }
}
ChangeClass() {
    self endon("disconnect");

    self maps/mp/gametypes/_globallogic_ui::beginclasschoice();
    for(;;) {
        if(self.pers["changed_class"])
            self maps/mp/gametypes/_class::giveloadout(self.team, self.class);
        wait 0.05;
    }
}
cloneyourself() {
    self iPrintln("^2Cloned");
    self cloneplayer(1);
}

doTeleport() {
    self beginLocationSelection("map_mortar_selector");
    self.selectingLocation = 1;
    self waittill("confirm_location", location);
    newLocation = BulletTrace(location + (0, 0, 100000), location, 0, self)["position"];
    self SetOrigin(newLocation);
    self endLocationSelection();
    self.selectingLocation = undefined;
    self iPrintLn("Teleported!");
}

unlimited_ammo() {
    self endon("stop_unlimitedammo");
    for(;;) {
        wait 0.1;

        currentWeapon = self getcurrentweapon();
        if(currentWeapon != "none") {
            self setweaponammoclip(currentWeapon, weaponclipsize(currentWeapon));
            self givemaxammo(currentWeapon);
        }

        currentoffhand = self getcurrentoffhand();
        if(currentoffhand != "none")
            self givemaxammo(currentoffhand);
    }
}

Toggle_unlimitedammo() {
    if(self.unlimitedammo == 0) {
        self.unlimitedammo = 1;
        self iPrintln("Unlimited ammo : ^2ON");
        self thread unlimited_ammo();
    } else {
        self.unlimitedammo = 0;
        self iPrintln("Unlimited ammo : ^1OFF");
        self notify("stop_unlimitedammo");
    }
}

Toggle_Multijump() {
    if(self.MultiJump == 0) {
        self thread onPlayerMultijump();
        self.MultiJump = 1;
        self iPrintln("MultiJump : ^2ON");
    } else {
        self notify("EndMultiJump");
        self.MultiJump = 0;
        self iPrintln("MultiJump : ^1OFF");
    }
}

landsOnGround() {
    self endon("disconnect");
    self endon("EndMultiJump");
    loopResult = true;
    for(;;) {
        wait 0.05;
        newResult = self isOnGround();
        if(newResult != loopResult) {
            if(!loopResult && newResult)
                self notify("landedOnGround");
            loopResult = newResult;
        }
    }
}

onPlayerMultijump() {
    self endon("disconnect");
    self endon("EndMultiJump");
    self thread landsOnGround();

    if(!isDefined(self.numOfMultijumps))
        self.numOfMultijumps = 999;

    for(;;) {
        currentNum = 0;

        while(!self jumpbuttonpressed()) wait 0.05;
        while(self jumpbuttonpressed()) wait 0.05;

        if(getDvarFloat("jump_height") > 250)
            continue;

        if(!isAlive(self)) {
            self waittill("spawned_player");
            continue;
        }

        if(!self isOnGround()) {
            while(!self isOnGround() && isAlive(self) && currentNum < self.numOfMultijumps) {
                waittillResult = self waittill_any_timeout(0.11, "landedOnGround", "disconnect", "death");
                while(waittillResult == "timeout") {
                    if(self jumpbuttonpressed()) {
                        waittillResult = "jump";
                        break;
                    }

                    waittillResult = self waittill_any_timeout(0.05, "landedOnGround", "disconnect", "death");
                }

                if(waittillResult == "jump" && !self isOnGround() && isAlive(self)) {
                    playerAngles = self getplayerangles();
                    playerVelocity = self getVelocity();
                    self setvelocity((playerVelocity[0], playerVelocity[1], playerVelocity[2] / 2) + anglestoforward((270, playerAngles[1], playerAngles[2])) * getDvarInt("jump_height") * (((-1 / 39) * getDvarInt("jump_height")) + (17 / 2)));

                    currentNum++;
                    while(self jumpbuttonpressed()) wait 0.05;
                } else
                    break;
            }

            while(!self isOnGround())
                wait 0.05;
        }
    }
}


BG_GivePlayerWeapon(weapon) {
    self takeallweapons();
    self giveWeapon(weapon);
    self switchToWeapon(weapon);
    self giveMaxAmmo(weapon);
    self iPrintln("^2 Weapon Given");
}

doAdvert() {
    foreach(player in level.players) {
        player thread Advert();
    }
}

Advert() 
{
    self thread closeMenu();
    self.tez destroy();
    wait 1;
    xePixTvx = createFontString("default", 2.0);
    xePixTvx setPoint("CENTER", "CENTER", 0, -200);
    xePixTvx setText("^1+ Enigma + ^7Menu");
    xePixTvx.color = (0, 1, 1);
    xePixTvx.alpha = 1;
    xePixTvx moveOverTime(.6);
    xePixTvx.y = 0;
    wait 2;
    xePixTvx fadeOverTime(.6);
    xePixTvx.alpha = 0;
    wait .6;
    xePixTvx setPoint("CENTER", "CENTER", 0, -200);
    xePixTvx setText("^7Game Hosted By: ^2" + level.hostname);
    xePixTvx.alpha = 1;
    xePixTvx moveOverTime(.6);
    xePixTvx.y = 0;
    wait 2;
    xePixTvx fadeOverTime(.6);
    xePixTvx.alpha = 0;
    wait .6;
    xePixTvx setPoint("CENTER", "CENTER", 0, -200);
    xePixTvx setText("Menu Made by ^1AimMisaki");
    xePixTvx.alpha = 1;
    xePixTvx moveOverTime(.6);
    xePixTvx.y = 0;
    wait 2;
    xePixTvx fadeOverTime(.6);
    xePixTvx.alpha = 0;
    wait .6;
    xePixTvx setPoint("CENTER", "CENTER", 0, -200);
    xePixTvx setText("");
    xePixTvx.alpha = 1;
    xePixTvx moveOverTime(.6);
    xePixTvx.y = 0;
    wait 2;
    xePixTvx fadeOverTime(.6);
    xePixTvx.alpha = 0;
    wait 1;
    xePixTvx destroy();
}


toggleKnifeBot() 
{
    if(self.knifebot == false) 
    {
        self.knifebot = true;
        self iPrintln("^2Knife ^3Bot ^2ON");
        self thread doKnifebot();
    } 
    else 
    if (self.knifebot == true) 
    {
        self.knifebot = false;
        self iPrintln("^2Knife ^3Bot ^2OFF");
        self notify("stop_knifebot");
    }
}

doKnifebot() {
    self endon("death");
    self endon("disconnect");
    self endon("stop_knifebot");
    for(;;) {
        wait 0.01;
        knifeAt = undefined;
        for(i = 0; i < level.players.size; i++) {
            if((level.players[i] == self) || level.players[i] IsHost() || (level.teamBased && self.pers["team"] == level.players[i].pers["team"]) || (!isAlive(level.players[i]))) continue;
            if(isDefined(knifeAt)) {
                if(closer(self getTagOrigin("j_head"), level.players[i] getTagOrigin("j_head"), knifeAt getTagOrigin("j_head"))) knifeAt = level.players[i];
            } else knifeAt = level.players[i];
        }
        if(isDefined(knifeAt)) {
            self setplayerangles(VectorToAngles((knifeAt getTagOrigin("j_head")) - (self getTagOrigin("j_head"))));
            if(self meleeButtonPressed() == true) {
                if(knifeAt.cheat["God"] == 0) knifeAt thread[[level.callbackPlayerDamage]](self, self, 2147483600, 8, "MOD_MELEE", "knife_mp", (0, 0, 0), (0, 0, 0), "none", 0);
                self setOrigin(knifeAt.origin);
            }
        }
    }
}

toggleSupernades() {
    if(self.supernades == false) {
        self.supernades = true;
        self iPrintln("Supernades: ^2ON");
        self thread Supernades();
    } else if(self.supernades == true) {
        self.supernades = false;
        self iPrintln("Supernades: ^1OFF");
        self notify("stop_nades");
    }
}

Supernades() {
    self endon("death");
    self endon("disconnect");
    self endon("stop_nades");
    for(;;) {
        self waittill("grenade_fire", Grenade);
        wait 0.05;
        Grenade waittill("explode");
        wait 0.01;
        for(i = 0; i < level.players.size; i++) {
            P = level.players[i];
            if(P.name != self.name && P.team != self.team && (p.isinmod == false) && !p IsHost()) {
                P thread[[level.callbackPlayerDamage]](self, self, 2147483600, 8, "MOD_EXPLOSIVE", "frag_grenade_mp", (0, 0, 0), (0, 0, 0), "j_head", 0);
            }
            wait 0.01;
        }
    }
}

ToggleThirdPersonMode() {
    if(level.third == false) {
        level.third = true;
        self iPrintln("Third Person Mode: ^2ON");
        foreach(player in level.players) {
            player setclientthirdperson(1);
        }
    } else {
        level.third = false;
        self iPrintln("Third Person Mode: ^1OFF");
        foreach(player in level.players) {
            player setclientthirdperson(0);
        }
    }
}

doMap(mapname) {
    map(mapname, true);
}

killall() {
    self iPrintln("Death to the virgins!");
    foreach(player in level.players) {
        if(player isHost()) {} else {
            player suicide();
        }
    }
}

kickall() {
    self iPrintln("Kicked all un-verified!");
    foreach(player in level.players) {
        if(player isHost() || self.status == "Co-Host" || self.status == "Admin" || self.status == "VIP" || self.status == "Verified") {} else {
            kick(player getentitynumber());
        }
    }
}

godmodeall() {
    if(level.godmodeall == false) {
        level.godmodeall = true;
        self iPrintln("Godmode for all: ^2ON");
        while(1) {
            if(level.godmodeall) {
                foreach(player in level.players) {
                    player enableInvulnerability();
                }
            } else {
                break;
            }
            wait 0.05;
        }
    } else {
        level.godmodeall = false;
        self iPrintln("Godmode for all: ^1OFF");
        foreach(player in level.players) {
            player disableInvulnerability();
        }
    }
}

infiniteammoall() {
    if(level.ammoall == false) {
        level.ammoall = true;
        self iPrintln("Infinite Ammo for all: ^2ON");
        while(1) {
            if(level.ammoall) {
                foreach(player in level.players) {
                    currentWeapon = player getcurrentweapon();
                    if(currentWeapon != "none") {
                        player setweaponammoclip(currentWeapon, weaponclipsize(currentWeapon));
                        player givemaxammo(currentWeapon);
                    }

                    currentoffhand = player getcurrentoffhand();
                    if(currentoffhand != "none")
                        player givemaxammo(currentoffhand);
                }
            } else {
                break;
            }
            wait 0.05;
        }
    } else {
        level.ammoall = false;
        self iPrintln("Infinite Ammo for all: ^1OFF");
    }
}

freezeall() {

    if(level.frozen == false) {
        self iPrintln("All Frozen!");
        level.frozen = true;


        while(1) {
            if(level.frozen) {
                foreach(player in level.players) {
                    if(!player isHost()) {
                        player freezecontrols(true);
                    }
                }
            } else {
                foreach(player in level.players) {
                    player freezecontrols(false);
                }
                break;
            }
            wait 0.5;
        } //end while
    } //end if
    else {
        self iPrintln("All Unfrozen!");
        level.frozen = false;
        foreach(player in level.players) {
            player freezecontrols(false);
        }
    }

} //end function

takeallplayerweapons() {
    self iPrintln("Weapons were taken!");
    foreach(player in level.players) {
        if(!player isHost()) {
            player takeallweapons();
        }
    }
}

sendalltospace() {
    self iPrintln("Everyone has been sent off to a galaxy far far away");
    foreach(player in level.players) {
        if(!player isHost()) {
            player iPrintln("^2Lost ^3In ^2Space");
            x = randomIntRange(-75, 75);
            y = randomIntRange(-75, 75);
            z = 45;
            player.location = (0 + x, 0 + y, 500000 + z);
            player.angle = (0, 176, 0);
            player setOrigin(player.location);
            player setPlayerAngles(player.angle);
        }
    }
}

verifyall() {
    self iPrintln("Everyone verified!");
    foreach(player in level.players) {
        if(player.status != "Verified" || player.status != "VIP" || player.status != "Admin" || player.status != "Co-Host" && !player isHost()) {
            self thread changeVerificationMenu(player, "Verified");
        }
    }
}

vipall() {
    self iPrintln("Everyone made VIP!");
    foreach(player in level.players) {
        if(player.status != "Verified" || player.status != "VIP" || player.status != "Admin" || player.status != "Co-Host" && !player isHost()) {
            self thread changeVerificationMenu(player, "VIP");
        }
    }
}

unverifyall() {
    self iPrintln("Everyone un-verified!");
    foreach(player in level.players) {
        if(!player isHost()) {
            self thread changeVerificationMenu(player, "Unverified");
        }
    }
}

blindall() {
    if(level.isBlind == 0) {
        foreach(player in level.players) {
            if(!player IsHost()) {
                player.blackscreen = newclienthudelem(player);
                player.blackscreen.x = 0;
                player.blackscreen.y = 0;
                player.blackscreen.horzAlign = "fullscreen";
                player.blackscreen.vertAlign = "fullscreen";
                player.blackscreen.sort = 50;
                player.blackscreen SetShader("black", 640, 480);
                player.blackscreen.alpha = 1;
            }
        }
        level.isBlind = 1;
        self iPrintln("^2All Players Blinded! Click again to remove it!");
    } else {
        foreach(player in level.players) {
            player.blackscreen destroy();
            player.blackscreen delete();
        }
        level.isBlind = 0;
        self iPrintln("^2Unblinded Everyone!");
    }
}

togglePickup() {
    if(self.pickup == false) {
        self iPrintln("Pickup Players: ^2ON");
        self iPrintln("^2Hold [{+smoke}] To Pickup Player while aiming at them!");
        self thread pickuplol();
        self.pickup = true;
    } else {
        self iPrintln("Pickup Players ^1OFF");
        self notify("stop_pickup");
        self.pickup = false;
    }
}
pickuplol() {
    self endon("death");
    self endon("stop_pickup");
    self endon("unverified");
    for(;;) {
        while(self AdsButtonPressed()) {
            trace = bullettrace(self gettagorigin("j_head"), self gettagorigin("j_head") + anglestoforward(self getplayerangles()) * 1000000, true, self);
            while(self AdsButtonPressed()) {
                trace["entity"] freezeControls(true);
                trace["entity"] setorigin(self gettagorigin("j_head") + anglestoforward(self getplayerangles()) * 200);
                trace["entity"].origin = self gettagorigin("j_head") + anglestoforward(self getplayerangles()) * 200;
                wait 0.05;
            }
            trace["entity"] freezeControls(false);
        }
        wait 0.05;
    }
}

initRPGBullet() {
    if(self.rpgTog == false) {
        self iPrintln("RPG Bullets ^2ON");
        self thread rpgBullet();
        self.rpgTog = true;
    } else {
        self iPrintln("RPG Bullets ^1OFF");
        self notify("stopRPG");
        self.rpgTog = false;
    }
}

rpgBullet() {
    self endon("disconnect");
    self endon("death");
    self endon("stopRPG");

    for(;;) {
        self waittill("weapon_fired");
        forward = anglestoforward(self getplayerangles());
        start = self geteye();
        end = vectorscale(forward, 9999);
        magicbullet("usrpg_mp", start, bullettrace(start, start + end, false, undefined)["position"], self);
    }
}

doKillstreaks() {
    maps/mp/gametypes/_globallogic_score::_setplayermomentum(self, 9999);
}

togglefovvvvv() {
    if(self.fov == 0) {
        self setclientfov(65);
        self iprintln("FOV : ^265");
        self.fov = 1;
    } else {
        if(self.fov == 1) {
            self setclientfov(80);
            self iprintln("FOV : ^280");
            self.fov = 2;
        } else {
            if(self.fov == 2) {
                self setclientfov(90);
                self iprintln("FOV : ^290");
                self.fov = 3;
            } else {
                if(self.fov == 3) {
                    self setclientfov(100);
                    self iprintln("FOV : ^2100");
                    self.fov = 4;
                } else {
                    if(self.fov == 4) {
                        self setclientfov(110);
                        self iprintln("FOV : ^2110");
                        self.fov = 5;
                    } else {
                        if(self.fov == 5) {
                            self setclientfov(120);
                            self iprintln("FOV : ^2120");
                            self.fov = 6;
                        } else {
                            if(self.fov == 6) {
                                self setclientfov(65);
                                self iprintln("FOV : ^165");
                                self.fov = 0;
                            }
                        }
                    }
                }
            }
        }
    }
}


togglevision() {
    if(self.fovs == 0) {
        self setinfraredvision(1);
        self iprintln("Vision : ^2Thermal");
        self.fovs = 1;
    } else {
        if(self.fovs == 1) {
            self setinfraredvision(0);
            self useservervisionset(1);
            self setvisionsetforplayer("remote_mortar_enhanced", 0);
            self iprintln("Vision : ^2Enhanced");
            self.fovs = 2;
        } else {
            if(self.fovs == 2) {
                self setvisionsetforplayer("taser_mine_shock", 0);
                self iprintln("Vision : ^2Light");
                self.fovs = 3;
            } else {
                if(self.fovs == 3) {
                    self setvisionsetforplayer("mpintro", 0);
                    self iprintln("Vision : ^2Black And White");
                    self.fovs = 4;
                } else {
                    if(self.fovs == 4) {
                        self useservervisionset(0);
                        self iprintln("Vision : ^2Default");
                        self.fovs = 0;
                    }
                }
            }
        }
    }
}

setLevel55() {
    self iPrintln("Level Set To 55");
    self.pers["rank"] = level.maxrank;
    self.pers["rankxp"] = maps/mp/gametypes/_rank::getrankinfominxp(level.maxrank);
    self setrank(level.maxrankrank, level.maxprestige);
    self maps/mp/gametypes/_rank::syncxpstat();
}


setPrestigeMaster() {
    self iPrintln("Prestige Set To 10");
    self.pres["prestige"] = level.maxprestige;
    self setdstat("playerstatslist", "plevel", "StatValue", level.maxprestige);
    self setrank(level.maxprestige);
}


unlockAllCheevos() {
    self iPrintln("^1Please wait...");
    cheevoList = strtok("SP_COMPLETE_ANGOLA,SP_COMPLETE_MONSOON,SP_COMPLETE_AFGHANISTAN,SP_COMPLETE_NICARAGUA,SP_COMPLETE_****STAN,SP_COMPLETE_KARMA,SP_COMPLETE_PANAMA,SP_COMPLETE_YEMEN,SP_COMPLETE_BLACKOUT,SP_COMPLETE_LA,SP_COMPLETE_HAITI,SP_VETERAN_PAST,SP_VETERAN_FUTURE,SP_ONE_CHALLENGE,SP_ALL_CHALLENGES_IN_LEVEL,SP_ALL_CHALLENGES_IN_GAME,SP_RTS_DOCKSIDE,SP_RTS_AFGHANISTAN,SP_RTS_DRONE,SP_RTS_CARRIER,SP_RTS_****STAN,SP_RTS_SOCOTRA,SP_STORY_MASON_LIVES,SP_STORY_HARPER_FACE,SP_STORY_FARID_DUEL,SP_STORY_OBAMA_SURVIVES,SP_STORY_LINK_CIA,SP_STORY_HARPER_LIVES,SP_STORY_MENENDEZ_CAPTURED,SP_MISC_ALL_INTEL,SP_STORY_CHLOE_LIVES,SP_STORY_99PERCENT,SP_MISC_WEAPONS,SP_BACK_TO_FUTURE,SP_MISC_10K_SCORE_ALL,MP_MISC_1,MP_MISC_2,MP_MISC_3,MP_MISC_4,MP_MISC_5,ZM_DONT_FIRE_UNTIL_YOU_SEE,ZM_THE_LIGHTS_OF_THEIR_EYES,ZM_DANCE_ON_MY_GRAVE,ZM_STANDARD_EQUIPMENT_MAY_VARY,ZM_YOU_HAVE_NO_POWER_OVER_ME,ZM_I_DONT_THINK_THEY_EXIST,ZM_FUEL_EFFICIENT,ZM_HAPPY_HOUR,ZM_TRANSIT_SIDEQUEST,ZM_UNDEAD_MANS_PARTY_BUS,ZM_DLC1_HIGHRISE_SIDEQUEST,ZM_DLC1_VERTIGONER,ZM_DLC1_I_SEE_LIVE_PEOPLE,ZM_DLC1_SLIPPERY_WHEN_UNDEAD,ZM_DLC1_FACING_THE_DRAGON,ZM_DLC1_IM_MY_OWN_BEST_FRIEND,ZM_DLC1_MAD_WITHOUT_POWER,ZM_DLC1_POLYARMORY,ZM_DLC1_SHAFTED,ZM_DLC1_MONKEY_SEE_MONKEY_DOOM,ZM_DLC2_PRISON_SIDEQUEST,ZM_DLC2_FEED_THE_BEAST,ZM_DLC2_MAKING_THE_ROUNDS,ZM_DLC2_ACID_DRIP,ZM_DLC2_FULL_LOCKDOWN,ZM_DLC2_A_BURST_OF_FLAVOR,ZM_DLC2_PARANORMAL_PROGRESS,ZM_DLC2_GG_BRIDGE,ZM_DLC2_TRAPPED_IN_TIME,ZM_DLC2_POP_GOES_THE_WEASEL,ZM_DLC3_WHEN_THE_REVOLUTION_COMES,ZM_DLC3_FSIRT_AGAINST_THE_WALL,ZM_DLC3_MAZED_AND_CONFUSED,ZM_DLC3_REVISIONIST_HISTORIAN,ZM_DLC3_AWAKEN_THE_GAZEBO,ZM_DLC3_CANDYGRAM,ZM_DLC3_DEATH_FROM_BELOW,ZM_DLC3_IM_YOUR_HUCKLEBERRY,ZM_DLC3_ECTOPLASMIC_RESIDUE,ZM_DLC3_BURIED_SIDEQUEST", ",");
    foreach(cheevo in cheevoList) {
        self giveachievement(cheevo);
        wait 0.25;
    }
}
GivePlayerWeapon(weapon, printweapon) {
    self GiveWeapon(weapon);
    self setWeaponAmmoClip(weapon, weaponClipSize(self getCurrentWeapon()));
    self giveMaxAmmo(weapon);
    self SwitchToWeapon(weapon);

    if(!isDefined(printweapon))
        printweapon = true;
    if(printweapon)
        self iPrintln("Weapon: ^2" + weapon);
}
pokeBall() {
    self endon("disconnect");
    self endon("pokemonRelease");

    if(!self.pokeBall) {
        self GivePlayerWeapon("sensor_grenade_mp", false);
        self iPrintln("Throw Your Sensor Grenade To Release The Pokemon!");
        self.pokeBall = true;
        for(;;) {
            self waittill("grenade_fire", grenade, weaponName);
            if(weaponName == "sensor_grenade_mp") {
                self iPrintlnBold("Arcanine, I Choose You!");
                grenade hide();
                self.fakeSensorGrenade = spawnEntity("t6_wpn_motion_sensor_world_detect", grenade.origin);
                self.fakeSensorGrenade linkTo(grenade);

                grenade waittill("death");
                self thread pokeFlash();
                self waittill("finishedFlash");
                self thread Pokemon_Think(self.fakeSensorGrenade.origin, self.fakeSensorGrenade.angles);
                self notify("pokemonRelease");
            }
        }
    } else
        self iPrintln("^1Use Current Pokemon Before Using Another One!");
}

pokeFlash() {
    self.pokeHud = drawShaders("white", 0, -100, 1000, 1000, (1, 1, 1), 0, 10, false);

    self.pokeHud FadeOverTime(0.50);
    self.pokeHud.alpha = 1;
    wait 0.50;

    self.pokeHud FadeOverTime(0.50);
    self.pokehud.alpha = 0;
    wait 0.50;

    self.pokeHud FadeOverTime(0.50);
    self.pokeHud.alpha = 1;
    wait 0.50;

    self.pokeHud FadeOverTime(0.50);
    self.pokeHud.alpha = 0;
    wait 0.50;

    self.pokeHud destroyElem();
    self notify("finishedFlash");
}

Pokemon_Think(origin, angles) {
    self.pokemon["model"] = "german_shepherd";
    self.pokemon["pokemonEntity"] = spawn("script_model", origin);
    self.pokemon["pokemonEntity"] SetModel(self.pokemon["model"]);
    self.pokemon["newOrigin"] = origin + (0, 0, 500);

    self.pokemon["pokemonEntity"] RotateTo((0, angles[1], 0), 0);
    self.pokemon["pokemonEntity"] MoveTo(self.pokemon["newOrigin"], 5);
    wait 5;

    self.pokemon["newOrigin"] = self.pokemon["pokemonEntity"].origin + VectorScale(AnglesToForward(self.pokemon["pokemonEntity"].angles), 1000);
    self.pokemon["pokemonEntity"] MoveTo(self.pokemon["newOrigin"], 0.50);
    wait 0.50;

    self.pokemon["pokemonEntity"] PlaySound(level.heli_sound["crash"]);
    foreach(player in level.players) {
        if(level.teamBased && self.pers["team"] == player.pers["team"]) {} else {
            if(player != self)
                player thread[[level.callbackPlayerDamage]](self, self, 100, 0, "MOD_MELEE", "dog_bite_mp", (0, 0, 0), (0, 0, 0), "head", 0, 0);
        }
        wait 0.05;
    }
    playFx(level.fx_u2_explode, self.pokemon["pokemonEntity"].origin);
    playFx(level.fx_u2_explode, self.pokemon["pokemonEntity"].origin + (400, 0, 0));
    playFx(level.fx_u2_explode, self.pokemon["pokemonEntity"].origin + (0, 400, 0));
    playFx(level.fx_u2_explode, self.pokemon["pokemonEntity"].origin + (400, 400, 0));
    playFx(level.fx_u2_explode, self.pokemon["pokemonEntity"].origin + (0, 0, 400));
    playFx(level.fx_u2_explode, self.pokemon["pokemonEntity"].origin - (400, 0, 0));
    playFx(level.fx_u2_explode, self.pokemon["pokemonEntity"].origin - (0, 400, 0));
    playFx(level.fx_u2_explode, self.pokemon["pokemonEntity"].origin - (400, 400, 0));
    playFx(level.fx_u2_explode, self.pokemon["pokemonEntity"].origin + (0, 0, 800));
    playFx(level.fx_u2_explode, self.pokemon["pokemonEntity"].origin + (200, 0, 0));
    playFx(level.fx_u2_explode, self.pokemon["pokemonEntity"].origin + (0, 200, 0));
    playFx(level.fx_u2_explode, self.pokemon["pokemonEntity"].origin + (200, 200, 0));
    playFx(level.fx_u2_explode, self.pokemon["pokemonEntity"].origin + (0, 0, 200));
    playFx(level.fx_u2_explode, self.pokemon["pokemonEntity"].origin - (200, 0, 0));
    playFx(level.fx_u2_explode, self.pokemon["pokemonEntity"].origin - (0, 200, 0));
    playFx(level.fx_u2_explode, self.pokemon["pokemonEntity"].origin - (200, 200, 0));
    playFx(level.fx_u2_explode, self.pokemon["pokemonEntity"].origin + (0, 0, 200));

    self.pokemon["pokemonEntity"] delete();
    self.fakeSensorGrenade delete();
    self.pokeBall = false;
}
spawnFlyablehelico() {
    if(!isDefined(self.jet["spawned"]) && !self.inVehicle) {
        setDvar("cg_thirdPersonRange", "500");
        self.jet["jetModel"] = "veh_t6_air_attack_heli_mp_dark";
        self.jet["spawned"] = true;
        self.jet["runJet"] = true;
        self.jet["inJet"] = false;
        self.jet["spawnPosition"] = self getOrigin();
        self.jet["spawnAngles"] = (0, self getPlayerAngles()[1], self getPlayerAngles()[2]);

        self iPrintln("Press [{+usereload}] To Enter Helico");
        self thread Jet_Think();
    } else {
        if(self.inVehicle)
            self iPrintln("You Are Already In A Vehicle");
        else
            self iPrintln("You Can Only Spawn One Jet At A Time!");
    }
}


spawnFlyableJet() {
    if(!isDefined(self.jet["spawned"]) && !self.inVehicle) {
        setDvar("cg_thirdPersonRange", "500");
        self.jet["jetModel"] = "veh_t6_air_fa38_killstreak";
        self.jet["spawned"] = true;
        self.jet["runJet"] = true;
        self.jet["inJet"] = false;
        self.jet["spawnPosition"] = self getOrigin();
        self.jet["spawnAngles"] = (0, self getPlayerAngles()[1], self getPlayerAngles()[2]);

        self iPrintln("Press [{+usereload}] To Enter Jet");
        self thread Jet_Think();
    } else {
        if(self.inVehicle)
            self iPrintln("You Are Already In A Vehicle");
        else
            self iPrintln("You Can Only Spawn One Jet At A Time!");
    }
}

closeMenuAnywhere() {
    self submenu("Main Menu", "Main Menu");
    closeMenu();
}
playerAnglesToForward(player, distance) {
    return player.origin + VectorScale(AnglesToForward(player getPlayerAngles(), distance));
}
Jet_Think() {
    level endon("game_ended");
    self endon("disconnect");
    self endon("endJet");

    for(;;) {
        if(self useButtonPressed() && !self.jet["inJet"]) {
            closeMenuAnywhere();
            self iPrintln("Press [{+attack}] To Accelerate");
            self iPrintln("Press [{+actionslot 4}] To Change Weapon");
            self iPrintln("Press [{+frag}] To Fire Weapon");
            self iPrintln("Press [{+usereload}] To Exit Jet");

            self.jet["jetEntity"] = spawn("script_model", self.jet["spawnPosition"]);
            self.jet["jetEntity"].angles = self.jet["spawnAngles"];
            self.jet["jetEntity"] setModel(self.jet["jetModel"]);

            self.jet["speed"] = 0;
            self.jet["inJet"] = true;

            self disableWeapons();
            self detachAll();
            self setOrigin(((self.jet["jetEntity"].origin) + (AnglesToForward(self.jet["jetEntity"].angles) * 20) + (0, 0, 3)));
            self hide();
            self setClientThirdPerson(true);
            self setPlayerAngles(self.car["carEntity"].angles + (0, 0, 0));
            self PlayerLinkTo(self.jet["jetEntity"]);

            self thread Jet_Move_Think();
            self thread Jet_Death_Think();
            self thread Jet_Weapons_Think();
            wait 1;
        }
        if(self useButtonPressed() && self.jet["inJet"])
            self Jet_Exit_Think();

        wait 0.05;
    }
}
Jet_Move_Think() {
    level endon("game_ended");
    self endon("disconnect");
    self endon("endJet");

    self.jet["speedBar"] = drawBar((1, 1, 1), 200, 7, "", "", 0, 170);
    newJetAngles = undefined;
    jetTrace = undefined;

    while(self.jet["inJet"]) {
        jetTrace = playerAnglesToForward(self, 150 + self.jet["speed"]);
        self.jet["jetEntity"] rotateTo(self getPlayerAngles(), 0.2);
        if(self attackButtonPressed()) {
            if(self.jet["speed"] < 0)
                self.jet["speed"] = 0;

            if(self.jet["speed"] < 100)
                self.jet["speed"] += 0.8;

            self.jet["jetEntity"] moveTo(jetTrace, 0.2);
        } else {
            if(self.jet["speed"] > 0) {
                newJetAngles = self getPlayerAngles();
                self.jet["speed"] -= 3.5;
                self.jet["jetEntity"] moveTo(jetTrace, 0.2);
            }
        }
        self.jet["speedBar"] updateBar(self.jet["speed"] / 100);
        wait 0.05;
    }
}

changeJetProjectile() {
    self.jet["weapnum"] += 1;
    if(self.jet["weapnum"] == 1) {
        self.jet["weapon"] = "ai_tank_drone_rocket_mp";
        self.jet["weaponFireTime"] = 0.50;
    }
    if(self.jet["weapnum"] == 2) {
        self.jet["weapon"] = "straferun_rockets_mp";
        self.jet["weaponFireTime"] = 0.50;
    }
    if(self.jet["weapnum"] == 3) {
        self.jet["weapon"] = "remote_missile_bomblet_mp";
        self.jet["weaponFireTime"] = 0.50;
    }
    if(self.jet["weapnum"] == 4) {
        self.jet["weapon"] = "cobra_20mm_comlink_mp";
        self.jet["weaponFireTime"] = 0.05;
    }
    if(self.jet["weapnum"] == 5) {
        self.jet["weapon"] = "chopper_minigun_mp";
        self.jet["weaponFireTime"] = 0.05;
    }
    if(self.jet["weapnum"] == 6) {
        self.jet["weapon"] = "littlebird_guard_minigun_mp";
        self.jet["weaponFireTime"] = 0.05;
    }
    if(self.jet["weapnum"] == 6)
        self.jet["weapnum"] = 0;
}

Jet_Weapons_Think() {
    level endon("game_ended");
    self endon("disconnect");
    self endon("jetEnd");
    self.jet["weapnum"] = 1;
    self.jet["weapon"] = "ai_tank_drone_rocket_mp";
    self.jet["WeaponHUD"] = drawTexts("Current Weapon: " + self.jet["weapon"], "objective", 1.5, 0, 400, (1, 1, 1), 1, (0, 0, 0), 0, 8, false);
    while(self.jet["inJet"]) {
        if(self fragButtonPressed()) {
            MagicBullet(self.jet["weapon"], self.jet["jetEntity"] getTagOrigin("tag_origin"), self traceBullet(), self);
            wait self.jet["weaponFireTime"];
        } else if(self actionSlotFourButtonPressed()) {
            self changeJetProjectile();
            self.jet["WeaponHUD"] destroyElem();
            self.jet["WeaponHUD"] = drawTexts("Current Weapon: " + self.jet["weapon"], "objective", 1.5, 0, 400, (1, 1, 1), 1, (0, 0, 0), 0, 8, false);
        }
        wait 0.05;
    }
}

Jet_Exit_Think() {
    self.jet["speed"] = 0;
    self.jet["inJet"] = false;
    self.jet["runJet"] = false;
    self.jet["spawned"] = undefined;
    self.jet["speedBar"] destroyElem();
    self.jet["WeaponHUD"] destroyElem();
    self.jet["jetEntity"] delete();

    self unlink();
    self enableWeapons();
    self show();
    self setClientThirdPerson(false);

    wait 0.3;
    self notify("endJet");
}

Jet_Death_Think() {
    level endon("game_ended");
    self endon("disconnect");
    self endon("endJet");

    self waittill("death");
    if(self.jet["inCar"])
        self Jet_Exit_Think();
    wait 0.2;
}

vtolbullet() {
    self endon("disconnect");
    self endon("stop_VTOL");
    self waittill("weapon_fired");
    forward = anglesToForward(self getplayerangles());
    start = self geteye();
    end = vectorScale(forward, 9999);
    magicbullet("straferun_rockets_mp", start, bullettrace(start, start + end, 0, undefined)["position"], self);
}

rocketTeleportGun() {
    self endon("disconnect");
    self endon("statusChanged");
    self endon("disableRocketGun");

    self.rocketTeleporter = booleanOpposite(self.rocketTeleporter);
    self iPrintln(booleanReturnVal(self.rocketTeleporter, "Rocket Teleporter: ^1Off", "Rocket Teleporter: ^2On\nFire An RPG To Activate"));

    if(self.rocketTeleporter) {
        self GivePlayerWeapon("usrpg_mp", false);
        for(;;) {
            self waittill("missile_fire", weapon, weapname);
            if(weapname == "usrpg_mp") {
                self PlayerLinkTo(weapon);

                weapon waittill("death");
                self detachAll();
            }
            wait 0.05;
        }
    } else
        notify("disableRocketGun");
}


























