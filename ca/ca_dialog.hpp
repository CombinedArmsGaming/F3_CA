
class RscFrame
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
class RscPicture
{
 access = 0;
 type = 0;
 idc = -1;
 style = 48;//ST_PICTURE
 colorBackground[] = {0,0,0,0};
 colorText[] = {1,1,1,1};
 font = "PuristaLight";
 sizeEx = 0;
 lineSpacing = 0;
 text = "";
 fixedWidth = 0;
 shadow = 0;
};

class RscButton
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
    soundEnter[] = {"\ca\ui\data\sound\onover",0.09,1};
    soundPush[] = {"\ca\ui\data\sound\new1",0,0};
    soundClick[] = {"\ca\ui\data\sound\onclick",0.07,1};
    soundEscape[] = {"\ca\ui\data\sound\onescape",0.09,1};
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

class RscEdit
{
	idc = -1;
	type = 2;
	style = "16";
	x = 0;
	y = 0;
	h = 0.2;
	w = 1;
	font = "PuristaLight";
	sizeEx = 0.04;
	autocomplete = "";
	canModify = true;
	maxChars = 100;
	forceDrawCaret = false;
	colorSelection[] = {0,1,0,1};
	colorText[] = {1,1,1,1};
	colorDisabled[] = {1,0,0,1};
	colorBackground[] = {0,0,0,0.5};
};


class RscListBox
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


class ca_groupid
{
	idd= 1995;
	movingenable=false;
    onLoad= "[] spawn { [] execvm 'ca\ca_marker_listboxfill.sqf'}";
	class controls
	{

        class frame: RscFrame
        {
        	idc = 1800;
        	text = "Marker Management System";
            x = 0.324687 * safezoneW + safezoneX;
        	y = 0.313 * safezoneH + safezoneY;
        	w = 0.335156 * safezoneW;
        	h = 0.385 * safezoneH;
        };
        class pic: RscPicture
        {
            idc = 1200;
            text = "ca\ca_markers.jpg";
            x = 0.603125 * safezoneW + safezoneX;
            y = 0.335 * safezoneH + safezoneY;
            w = 0.05 * safezoneW;
            h = 0.35 * safezoneH;
        };
        class infotext: RscFrame
        {
            idc = 1000;
            text = "Enter groupid(Markertext) below";
            x = 0.329844 * safezoneW + safezoneX;
            y = 0.335 * safezoneH + safezoneY;
            w = 0.113437 * safezoneW;
            h = 0.033 * safezoneH;
        };
        class edittype: RscEdit
        {
        	idc = 1400;
        	text = "";
            x = 0.335 * safezoneW + safezoneX;
        	y = 0.379 * safezoneH + safezoneY;
        	w = 0.103125 * safezoneW;
        	h = 0.044 * safezoneH;
        };
        class listbox1: RscListbox
        {
        	idc = 1500;
            x = 0.448438 * safezoneW + safezoneX;
        	y = 0.335 * safezoneH + safezoneY;
        	w = 0.0670312 * safezoneW;
        	h = 0.352 * safezoneH;
        };
        class listbox2: RscListbox
        {
			idc = 1501;
            x = 0.525781 * safezoneW + safezoneX;
        	y = 0.335 * safezoneH + safezoneY;
        	w = 0.0670312 * safezoneW;
        	h = 0.352 * safezoneH;
        };
        class button: RscButton
        {
        	idc = 1600;
        	text = "Apply";
            x = 0.335 * safezoneW + safezoneX;
        	y = 0.643 * safezoneH + safezoneY;
        	w = 0.04 * safezoneW;
        	h = 0.05 * safezoneH;
            action =  "(group player) setgroupidglobal [ctrlText 1400]; _ind1 = lbCurSel 1500;(group player) setVariable ['ca_groupcolor',(lbData [1500,_ind1]),true]; _ind2 = lbCurSel 1501; (group player) setVariable ['ca_grouptype', (lbData [1501,_ind2]),true];";
            //closeDialog 0;
        };

        class button1: RscButton
        {
            idc = 1601;
            text = "Close"; //--- ToDo: Localize;
            x = 0.396875 * safezoneW + safezoneX;
        	y = 0.643 * safezoneH + safezoneY;
        	w = 0.04 * safezoneW;
        	h = 0.05 * safezoneH;
            action =  "closeDialog 0;";

        };


};
};
