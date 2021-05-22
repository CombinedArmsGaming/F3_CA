#include "macros.hpp"





class CA_Rsc_ZeusUI {
	idd = -1;
	name = "CA_Rsc_ZeusUI";
	onLoad = "uiNamespace setVariable ['ca_dialog_zeusUI', _this select 0]";

	class Controls {
		class Background : RscBox {
			idc = -1;
			x = 0.1;
			y = 0.1;
			w = safeZoneW * 0.3;
			h = safeZoneH * 0.3;
			colorBackground[] = CURLY(MACRO_COLOUR_BACKGROUND);
		};
	};
};





// ------------------------------------------------------------------------------------------------------------------------------------------------
// SCRIPTED CONTROLS
class CA_ZeusUI_ScriptedControlsGroup : RscControlsGroupNoScrollbars {
	x = 0;
	y = 0;
	w = 0;
	h = 0;
};

class CA_ZeusUI_ScriptedBox : RscBox {
	shadow = 0;
	x = 0;
	y = 0;
	w = 0;
	h = 0;
};

class CA_ZeusUI_ScriptedFrame : RscText {
	x = 0;
	y = 0;
	w = 0;
	h = 0;
};

class CA_ZeusUI_ScriptedText : RscText {
	style = ST_LEFT;
	font = "RobotoCondensed";
	sizeEx = 0.032;
	shadow = 0;
	x = 0;
	y = 0;
	w = 0;
	h = 0;
};
class CA_ZeusUI_ScriptedOutline : RscBox {
	style = ST_WITH_RECT;
	shadow = 0;
	colorBackground[] = {0,0,0,0};
	x = 0;
	y = 0;
	w = 0;
	h = 0;
};

class CA_ZeusUI_ScriptedListBox : RscCombo {
	font = "RobotoCondensed";
	sizeEx = 0.032;
	x = 0;
	y = 0;
	w = 0;
	h = 0;
};

class CA_ZeusUI_ScriptedButton : RscButton {
	font = "RobotoCondensed";
	sizeEx = 0.04;
	shadow = 0;
	colorBackground[] = CURLY(MACRO_COLOUR_BUTTON);
	colorBackgroundActive[] = CURLY(MACRO_COLOUR_BUTTON);
	colorShadow[] = {0,0,0,0};
	offsetX = 0;
	offsetY = 0;
	offsetPressedX = 0;
	offsetPressedY = 0;
	x = 0;
	y = 0;
	w = 0;
	h = 0;
};

class CA_ZeusUI_ScriptedButton_Red : CA_ZeusUI_ScriptedButton {
	colorBackground[] = CURLY(MACRO_COLOUR_RED);
	colorBackgroundActive[] = CURLY(MACRO_COLOUR_RED);
};


class CA_ZeusUI_ScriptedTextBox : RscEdit {
	font = "RobotoCondensed";
	sizeEx = 0.032;
	style = ST_MULTI + ST_RIGHT;
	maxChars = 5;
	x = 0;
	y = 0;
	w = 0;
	h = 0;
};
