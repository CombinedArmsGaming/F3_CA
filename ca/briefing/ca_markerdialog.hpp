/*
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
*/

class ca_groupid
{
	idd= 1995;
	movingenable=false;
    onLoad= "[] spawn { [] execvm 'ca\briefing\ca_marker_listboxfill.sqf'}";
	class controls
	{

	        class frame: RscFrame
	        {
	        	idc = 1800;
			style = ST_HUD_BACKGROUND;
	    		colorBackground[] = {0,0,0,0.7};
			text = "Marker Management System";
	            x = 38.9624 * pixelGridNoUIScale * pixelW + safezoneX;
	        	y = 21.1275 * pixelGridNoUIScale * pixelH + safezoneY;
	        	w = 40.2187 * pixelGridNoUIScale * pixelW;
	        	h = 25.9875 * pixelGridNoUIScale * pixelH;
	        };
			
	        class pic: RscPicture
	        {
	            idc = 1200;
	            text = "ca\briefing\ca_markers.jpg";
	            x = 72.3747134 * pixelGridNoUIScale * pixelW + safezoneX;
	        	y = 22.6125 * pixelGridNoUIScale * pixelH + safezoneY;
	        	w = 5.99997624 * pixelGridNoUIScale * pixelW;
	        	h = 23.625 * pixelGridNoUIScale * pixelH;
	        };
	        class infotext: RscFrame
	        {
		    idc = 1000;
		    style = ST_HUD_BACKGROUND;
		    colorBackground[] = {0,0,0,0.7};
		    text = "Enter groupid(Markertext) below";
	            x = 39.58112326 * pixelGridNoUIScale * pixelW + safezoneX;
	        	y = 22.6125 * pixelGridNoUIScale * pixelH + safezoneY;
	        	w = 13.61238609 * pixelGridNoUIScale * pixelW;
	        	h = 2.2275 * pixelGridNoUIScale * pixelH;
	        };
	        class edittype: RscEdit
	        {
	        	idc = 1400;
	        	text = "";
	            x = 40.19984081 * pixelGridNoUIScale * pixelW + safezoneX;
	        	y = 25.5825 * pixelGridNoUIScale * pixelH + safezoneY;
	        	w = 12.374951 * pixelGridNoUIScale * pixelW;
	        	h = 2.97 * pixelGridNoUIScale * pixelH;
	        };
	        class listbox1: RscListbox
	        {
	        	idc = 1500;
	            x = 53.8123469 * pixelGridNoUIScale * pixelW + safezoneX;
	        	y = 22.6125 * pixelGridNoUIScale * pixelH + safezoneY;
	        	w = 8.043712147 * pixelGridNoUIScale * pixelW;
	        	h = 23.76 * pixelGridNoUIScale * pixelH;
	        };
	        class listbox2: RscListbox
	        {
			idc = 1501;
	            x = 63.09347015 * pixelGridNoUIScale * pixelW + safezoneX;
	        	y = 22.6125 * pixelGridNoUIScale * pixelH + safezoneY;
	        	w = 8.043712147 * pixelGridNoUIScale * pixelW;
	        	h = 23.76 * pixelGridNoUIScale * pixelH;
	        };
	        class button: RscButton
	        {
	        	idc = 1600;
	        	text = "Apply";
	            x = 40.19984081 * pixelGridNoUIScale * pixelW + safezoneX;
	        	y = 43.4025 * pixelGridNoUIScale * pixelH + safezoneY;
	        	w = 4.799980992 * pixelGridNoUIScale * pixelW;
	        	h = 3.375 * pixelGridNoUIScale * pixelH;
	            	action =  "(group player) setgroupidglobal [ctrlText 1400]; _ind1 = lbCurSel 1500;(group player) setVariable ['ca_groupcolor',(lbData [1500,_ind1]),true]; _ind2 = lbCurSel 1501; (group player) setVariable ['ca_grouptype', (lbData [1501,_ind2]),true];";
	            //closeDialog 0;
	        };

	        class button1: RscButton
	        {
	            idc = 1601;
	            text = "Close";
	            x = 47.62481141 * pixelGridNoUIScale * pixelW + safezoneX;
	        	y = 43.4025 * pixelGridNoUIScale * pixelH + safezoneY;
	        	w = 4.799980992 * pixelGridNoUIScale * pixelW;
	        	h = 3.375 * pixelGridNoUIScale * pixelH;
	            action =  "closeDialog 0;";

	        };


	};
};
