
class RscFrame1
{
    type = 0;
    idc = -1;
    style = 0x80;
    colorBackground[] = {0,0,0,0.7};
    shadow = 2;
    colorSelection[] = {0,1,0,1};
	colorText[] = {1,1,1,1};
	colorDisabled[] = {1,0,0,1};
    font = "PuristaLight";
    sizeEx = 0.03;
    text = "";
};
class RscButton1
{
   access = 0;
    type = 1;
    text = "";
    colorText[] = {1,1,1,.9};
    colorDisabled[] = {0.4,0.4,0.4,0};
    colorBackground[] = {0.75,0.75,0.75,0.8};
    colorBackgroundDisabled[] = {0,0.0,0};
    colorBackgroundActive[] = {0.75,0.75,0.75,1};
    colorFocused[] = {0.75,0.75,0.75,.5};
    colorShadow[] = {0.023529,0,0.0313725,1};
    colorBorder[] = {0.023529,0,0.0313725,1};
	soundEnter[] = {"",0.1,1};
	soundPush[] = {"",0.1,1};
	soundClick[] = {"",0.1,1};
	soundEscape[] = {"",0.1,1};
    style = 2;
    x = 0;
    y = 0;
    w = 0.055589;
    h = 0.039216;
    shadow = 2;
    font = "PuristaLight";
    sizeEx = 0.03921;
    offsetX = 0.003;
    offsetY = 0.003;
    offsetPressedX = 0.002;
    offsetPressedY = 0.002;
    borderSize = 0;
};
class RscListBox1
{
 access = 0;
 type = 5;
 style = 0;
 w = 0.4;
 h = 0.4;
 font = "PuristaLight";
 sizeEx = 0.04;
 rowHeight = 0;
 colorText[] = {1,1,1,1};
 colorScrollbar[] = {1,1,1,1};
 colorSelect[] = {0,0,0,1};
 colorSelect2[] = {1,0.5,0,1};
 colorSelectBackground[] = {0.6,0.6,0.6,1};
 colorSelectBackground2[] = {0.2,0.2,0.2,1};
 colorBackground[] = {0,0,0,0};
 colorDisabled[] = {1,1,1,0.5};

 maxHistoryDelay = 1.0;
 soundSelect[] = {"",0.1,1};
 period = 1;
 autoScrollSpeed = -1;
 autoScrollDelay = 5;
 autoScrollRewind = 0;
 arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
 arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
 shadow = 0;
 class ListScrollBar
 {
  color[] = {1,1,1,0.6};
  colorActive[] = {1,1,1,1};
  colorDisabled[] = {1,1,1,0.3};
  thumb = "#(argb,8,8,3)color(1,1,1,1)";
  arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
  arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
  border = "#(argb,8,8,3)color(1,1,1,1)";
  shadow = 0;
 };
};
class ca_respawndiag
{
	idd= 1996;
	movingenable=false;
    onLoad= "[] spawn { [] execvm 'ca\respawn\ca_respawndialogsupport.sqf'}";
	class controls
	{
        class frame: RscFrame1
        {
        	idc = 1800;
        	text = "Reinforcements manager ";
            x = 0.3 * safezoneW + safezoneX;
        	y = 0.2 * safezoneH + safezoneY;
        	w = 0.45 * safezoneW;
        	h = 0.6 * safezoneH;
        };
        class listbox1: RscListbox1
        {
        	idc = 1500;
            x = 0.5 * safezoneW + safezoneX;
        	y = 0.3 * safezoneH + safezoneY;
        	w = 0.1 * safezoneW;
        	h = 0.5 * safezoneH;
        };
        class button: RscButton1
        {
        	idc = 1600;
        	text = "Spawn reinforcement wave";
            x = 0.3 * safezoneW + safezoneX;
        	y = 0.35 * safezoneH + safezoneY;
        	w = 0.2 * safezoneW;
        	h = 0.05 * safezoneH;
            action =  "[] spawn ca_fnc_respawnwave;";
            //closeDialog 0; if((ca_respawnmode == 2 && rankid player > ca_corank) || (serverCommandAvailable '#kick')) then {[] call ca_fnc_respawnwave;}
        };
        class infotext2: RscFrame
        {
            idc = 1004;
            text = "waves";
            x = 0.6 * safezoneW + safezoneX;
            y = 0.3 * safezoneH + safezoneY;
            w = 0.15 * safezoneW;
            h = 0.05 * safezoneH;
        };
        class infotext3: RscFrame
        {
            idc = 1005;
            text = "numbplayer";
            x = 0.6 * safezoneW + safezoneX;
            y = 0.4 * safezoneH + safezoneY;
            w = 0.15 * safezoneW;
            h = 0.05 * safezoneH;
        };
        class infotext4: RscFrame
        {
            idc = 1006;
            text = "timer";
            x = 0.6 * safezoneW + safezoneX;
            y = 0.5 * safezoneH + safezoneY;
            w = 0.15 * safezoneW;
            h = 0.05 * safezoneH;
        };
        class infotext1: RscFrame
        {
            idc = 1001;
            text = "List of players in spectator";
            x = 0.3 * safezoneW + safezoneX;
            y = 0.3 * safezoneH + safezoneY;
            w = 0.15 * safezoneW;
            h = 0.05 * safezoneH;
        };
        class button1: RscButton1
        {
            idc = 1601;
            text = "Close";
            x = 0.3 * safezoneW + safezoneX;
        	y = 0.7 * safezoneH + safezoneY;
        	w = 0.1 * safezoneW;
        	h = 0.1 * safezoneH;
            action =  "closeDialog 0;";

        };
};
};
