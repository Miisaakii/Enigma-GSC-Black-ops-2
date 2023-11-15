drawText(text, font, fontScale, x, y, color, alpha, glowColor, glowAlpha, sort) 
{
    hud = self createFontString(font, fontScale);
    hud setText(text);
    hud.x = x;
    hud.y = y;
    hud.color = color;
    hud.alpha = alpha;
    hud.glowColor = glowColor;
    hud.glowAlpha = glowAlpha;
    hud.sort = sort;
    hud.alpha = alpha;
    return hud;
}

drawShader(shader, x, y, width, height, color, alpha, sort) 
{
    hud = newClientHudElem(self);
    hud.elemtype = "icon";
    hud.color = color;
    hud.alpha = alpha;
    hud.sort = sort;
    hud.children = [];
    hud setParent(level.uiParent);
    hud setShader(shader, width, height);
    hud.x = x;
    hud.y = y;
    return hud;
}

drawShaders(shader, x, y, width, height, color, alpha, sort, allclients) 
{
    if(!isDefined(allclients))
        allclients = false;

    if(!allclients)
        hud = newClientHudElem(self);
    else
        hud = newHudElem();
    hud.elemtype = "icon";
    hud.color = color;
    hud.alpha = alpha;
    hud.sort = sort;
    hud.children = [];
    hud setParent(level.uiParent);
    hud setShader(shader, width, height);
    hud.x = x;
    hud.y = y;
    return hud;
}

drawTexts(text, font, fontScale, x, y, color, alpha, glowColor, glowAlpha, sort, allclients) {
    if(!isDefined(allclients))
        allclients = false;

    if(!allclients)
        hud = self createFontString(font, fontScale);
    else
        hud = level createServerFontString(font, fontScale);
    hud setText(text);
    hud.x = x;
    hud.y = y;
    hud.color = color;
    hud.alpha = alpha;
    hud.glowColor = glowColor;
    hud.glowAlpha = glowAlpha;
    hud.sort = sort;
    hud.alpha = alpha;
    return hud;
}

StoreShaders() 
{
    self.menu.background = self drawshader("extracam2d", 250, -50, 200, 500, (0, 0, 0), 0, 2);
    self.menu.scroller = self drawshader("ui_slider2", 250, 550, 200, 18, (1, 0, 0), 255, 7);
    self.menu.line = self drawshader("line_horizontal", 350, 550, 50, 500, (1, 0, 0), 255, 0);
    self.menu.line2 = self drawshader("line_horizontal", 150, 550, 50, 500, (1, 0, 0), 255, 1); 
    self.menu.line3 = self drawShader("white", 350, 550, 3, 500, (1, 0, 0), 255, 3);
    self.menu.line4 = self drawShader("white", 150, 550, 3, 500, (1, 0, 0), 255, 4);
    self.menu.background1 = self drawshader("compass_emp", 250, -50, 200, 500, (.4, 0, 0), 0, 3);
    self.menu.background2 = self drawshader("overlay_low_health", 250, -50, 200, 500, (0, 0, 0), 0, 4);
    self.menu.barinfo1 = self drawshader("hud_mp_vis_ks_dpad_box_back_lit", -45, -1000, 600, 60, (0, 0, 0), 255, 0);
	self.menu.barinfo2 = self drawshader("hud_mp_vis_ks_dpad_box", -45, -950, 600, 60, (1, 0, 0), 255, 1);
}

ShadersLoader()
{
    self.mbm.archived = 1;
	self.mbm.alpha = 1;
    self.menu.background FadeOverTime(0.30);
    self.menu.background.alpha = .6;
    self.menu.background1 FadeOverTime(0.30);
    self.menu.background1.alpha = 1;
    self.menu.background2 FadeOverTime(0.30);
    self.menu.background2.alpha = 1;
    self.menu.barinfo1 moveovertime( 0,3 );
	self.menu.barinfo1.y = 380;	
	self.menu.barinfo2 moveovertime( 0,3 );
	self.menu.barinfo2.y = 380;
    self.menu.line MoveOverTime(0.30);
    self.menu.line.y = -50;
    self.menu.line2 MoveOverTime(0.30);
    self.menu.line2.y = -50;
    self.menu.line3 MoveOverTime(0.30);
    self.menu.line3.y = -50;
    self.menu.line4 MoveOverTime(0.30);
    self.menu.line4.y = -50;
}

ShadersUnload()
{
    self.mbm fadeovertime( 0 );
	self.mbm.alpha = 0;
    self.menu.options FadeOverTime(0.3);
    self.menu.options.alpha = 0;
    self.menu.background FadeOverTime(0.3);
    self.menu.background.alpha = 0;
    self.menu.background1 FadeOverTime(0.3);
    self.menu.background1.alpha = 0;
    self.menu.background2 FadeOverTime(0.3);
    self.menu.background2.alpha = 0;    
    self.menu.barinfo1 fadeovertime( 0,5 );
	self.menu.barinfo1 moveovertime( 0,3 );
	self.menu.barinfo1.y = -1000;  
    self.menu.barinfo2 fadeovertime( 0,5 );
	self.menu.barinfo2 moveovertime( 0,3 );
	self.menu.barinfo2.y = -1000;
    self.menu.title FadeOverTime(0.3);
    self.menu.title.alpha = 0;
    self.tez FadeOverTime(0.3);
    self.tez.alpha = 0;
    self.tezz FadeOverTime(0.3);
    self.tezz.alpha = 0;
    self.menu.line MoveOverTime(0.15);
    self.menu.line.y = -550;
    self.menu.line2 MoveOverTime(0.15);
    self.menu.line2.y = -550;    
    self.menu.line3 MoveOverTime(0.15);
    self.menu.line3.y = -550;   
    self.menu.line4 MoveOverTime(0.15);
    self.menu.line4.y = -550;
    self.menu.scroller MoveOverTime(0.15);
    self.menu.scroller.y = -500;
    self.menu.open = false;
}

StoreText(menu, title) 
{
    self.menu.currentmenu = menu;
    string = "";
    self.menu.title destroy();
    self.menu.title = drawText(title, "default", 2, 250, 30, (1, 1, 1), 0, (0, 0, 0), 3, 5);
    self.menu.title FadeOverTime(0.3);
    self.menu.title.alpha = 1;
    self notify("stopScale");
    self thread scaleLol();
    self.tez destroy();
    self.tez = self createFontString("default", 2.5);
    self.tez setPoint("CENTER", "TOP", 250, 5);
    self.tez setText("+ Enigma +");
    self.tez FadeOverTime(0.3);
    self.tez.alpha = 1;
    self.tez.foreground = true;
    self.tez.archived = false;
    self.tez.glowAlpha = 1;
    self.tez.glowColor = (1, 0, 0);
    self.tezz destroy();
    self.tezz = self createFontString("default", 1.2);
    self.tezz setPoint("CENTER", "TOP", 300, 420);
    self.tezz setText("^7Menu By ^1AimMisaki");
    self.tezz fadeovertime( 0 );
	self.tezz.glowalpha = 1;
	self.tezz.glowcolor = ( 1, 0, 0 );
	self.tezz.color = ( 1, 1, 1 );
	self.tezz.alpha = 1;
	self.tezz.foreground = 1;
	self.tezz.archived = 1;
    for(i = 0; i < self.menu.menuopt[menu].size; i++) 
    {
        string += self.menu.menuopt[menu][i] + "\n";
    }

    self.menu.options destroy();
    self.menu.options = drawText(string, "objective", 1.5, 210, 68, (1, 1, 1), 0, (0, 0.58, 0), 0, 6);
    self.menu.options FadeOverTime(0.3);
    self.menu.options.alpha = 1;
}

menubarbasmessage()
{
	self.mbm = self createfontstring("smallfixed", 1);
	self.mbm.color = ( 1, 1, 1 );
	self.mbm.foreground = 1;
	self.mbm.glowalpha = 1;
	self.mbm fadeovertime(0);
	self.mbm.alpha = 0;
	self.mbm.glowcolor = ( 0, 0, 602 );
	self.mbm.x = -125;
	self.mbm.y = 401;
	self.mbm.archived = 1;
	self thread menubarmessagechange();
}

menubarmessagechange() 
{
    self endon("stop_doheart");
    for(;;) 
    {
        self.mbm settypewriterfx(20, 3000, 1000);
        self.mbm settext("Welcome to ^1+ Enigma +");
        self.mbm.color = (1, 1, 1);
        self.mbm.glowalpha = 1;
        self.mbm.glowcolor = (0, 0, 602);
        wait 6;
        self.mbm settypewriterfx(20, 3000, 1000);
        self.mbm settext("Menu made by AimMisaki");
        self.mbm.color = (1, 1, 1);
        self.mbm.glowalpha = 1;
        self.mbm.glowcolor = (0, 0, 602);
        wait 5;
        self.mbm settypewriterfx(20, 3000, 1000);
        self.mbm settext("^1discord^7 misaki57");
        self.mbm.color = (1, 1, 1);
        self.mbm.glowalpha = 1;
        self.mbm.glowcolor = (0, 0, 602);
        wait 5;
        self.mbm settypewriterfx(20, 3000, 1000);
        self.mbm settext("^1Youtube^7/Misakiii");
        self.mbm.color = (1, 1, 1);
        self.mbm.glowalpha = 1;
        self.mbm.glowcolor = (0, 0, 602);
        wait 5;
        self.mbm settypewriterfx(20, 3000, 1000);
        self.mbm settext("^1Love ^2Modding ^3<3");
        self.mbm.color = (1, 1, 1);
        self.mbm.glowalpha = 1;
        self.mbm.glowcolor = (0, 0, 602);
        wait 5;
        self.mbm settypewriterfx(20, 3000, 1000);
        self.mbm settext("This menu is private");
        self.mbm.color = (1, 1, 1);
        self.mbm.glowalpha = 1;
        self.mbm.glowcolor = (0, 0, 602);
        wait 5;
    }
}







