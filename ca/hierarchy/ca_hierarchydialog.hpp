
class ca_hierarchydialog
{
	idd= 1809;
	movingenable=false;
    onLoad= "[] spawn { [] execvm 'ca\hierarchy\ca_hierarchydialogsupport.sqf'}";
	class controls
	{
        class frame: RscFrame1
        {
        	idc = 1810;
            x = 30 * (pixelW * pixelGrid) * safezoneW + safeZoneX;
            y = 30 * (pixelH * pixelGrid) + safeZoneY;
            w = 400 * (pixelW * 2);
            h = 300 * (pixelH * 2);
        };
        class tree: RscTree
        {
        	idc = 1811;
            colorBackground[] = {0,0,0,0.8};
	        colorText[] = {1,1,1,0.9};
            sizeEx = 10 * (pixelH * 2);
            x = 30 * (pixelW * pixelGrid) * safezoneW + safeZoneX;
            y = 30 * (pixelH * pixelGrid) + safeZoneY;
            w = 90 * (pixelW * 2);
            h = 300 * (pixelH * 2);
            expandOnDoubleclick = 1; // Expand/collapse item upon double-click

            class ScrollBar : ScrollBar
            {};
        };
        class aliveplayers: RscListbox1
        {
        	idc = 1812;
            sizeEx = 10 * (pixelH * 2);
            x = 40 * (pixelW * pixelGrid) * safezoneW + safeZoneX;
            y = 35 * (pixelH * pixelGrid) + safeZoneY;
            w = 95 * (pixelW * 2);
            h = 120 * (pixelH * 2);

        };
        class aliveplayerinfo: RscText
        {
            idc = -1;
            text = "Alive players in group";
            sizeEx = 10 * (pixelH * 2);
            style = ST_CENTER;
            x = 40 * (pixelW * pixelGrid) * safezoneW + safeZoneX;
            y = 30 * (pixelH * pixelGrid) + safeZoneY;
            w = 95 * (pixelW * 2);
            h = 15 * (pixelH * 2);
        };
        class deadplayers: RscListbox1
        {
        	idc = 1813;
            sizeEx = 10 * (pixelH * 2);
            x = 40 * (pixelW * pixelGrid) * safezoneW + safeZoneX;
            y = 74 * (pixelH * pixelGrid) + safeZoneY;
            w = 95 * (pixelW * 2);
            h = 120 * (pixelH * 2);
        };
        class deadplayerinfo: RscText
        {
            idc = -1;
            text = "Dead players in group";
            style = ST_CENTER;
            sizeEx = 10 * (pixelH * 2);
            x = 40 * (pixelW * pixelGrid) * safezoneW + safeZoneX;
            y = 69 * (pixelH * pixelGrid) + safeZoneY;
            w = 95 * (pixelW * 2);
            h = 15 * (pixelH * 2);
        };
        class shortrangech: RscEdit
        {
            idc = 1814;
            sizeEx = 15 * (pixelH * 2);
            text = "";
            x = 51 * (pixelW * pixelGrid) * safezoneW + safeZoneX;
            y = 35 * (pixelH * pixelGrid) + safeZoneY;
            w = 100 * (pixelW * 2);
            h = 25 * (pixelH * 2);
        };
        class longrangechannel: RscEdit
        {
            idc = 1815;
            sizeEx = 15 * (pixelH * 2);
            text = "";
            x = 51 * (pixelW * pixelGrid) * safezoneW + safeZoneX;
            y = 50 * (pixelH * pixelGrid) + safeZoneY;
            w = 100 * (pixelW * 2);
            h = 25 * (pixelH * 2);
        };
        class shortrangeinfo: RscText
        {
            idc = -1;
            text = "SR radio channel next respawn";
            style = ST_CENTER;
            sizeEx = 10 * (pixelH * 2);
            x = 49 * (pixelW * pixelGrid) * safezoneW + safeZoneX;
            y = 30 * (pixelH * pixelGrid) + safeZoneY;
            w = 140 * (pixelW * 2);
            h = 15 * (pixelH * 2);
        };
        class longrangeinfo: RscText
        {
            idc = -1;
            text = "LR radio channels next respawn";
            sizeEx = 10 * (pixelH * 2);
            style = ST_CENTER;
            x = 49 * (pixelW * pixelGrid) * safezoneW + safeZoneX;
            y = 45 * (pixelH * pixelGrid) + safeZoneY;
            w = 140 * (pixelW * 2);
            h = 15 * (pixelH * 2);
        };
        class updateradios: RscButton
        {
            idc = -1;
            text = "Update Radio CHs";
            sizeEx = 10 * (pixelH * 2);
            style = ST_LEFT;
            x = 63 * (pixelW * pixelGrid) * safezoneW + safeZoneX;
            y = 30 * (pixelH * pixelGrid) + safeZoneY;
            w = 80 * (pixelW * 2);
            h = 20 * (pixelH * 2);
            action =  "[] spawn ca_fnc_updateradioCHs";
            //closeDialog 0;
        };
        class givelocalmark: RscButton
        {
            idc = -1;
            text = "Give Medic Marker";
            sizeEx = 10 * (pixelH * 2);
            style = ST_LEFT;
            x = 63 * (pixelW * pixelGrid) * safezoneW + safeZoneX;
            y = 40 * (pixelH * pixelGrid) + safeZoneY;
            w = 80 * (pixelW * 2);
            h = 20 * (pixelH * 2);
            action =  "[] spawn ca_fnc_giveMedicMarker";
            //closeDialog 0;
        };
        class sidetickets: RscText
        {
            idc = 1816;
            text = "Select a group";
            sizeEx = 10 * (pixelH * 2);
            style = ST_LEFT;
            x = 50 * (pixelW * pixelGrid) * safezoneW + safeZoneX;
            y = 60 * (pixelH * pixelGrid) + safeZoneY;
            w = 80 * (pixelW * 2);
            h = 15 * (pixelH * 2);
        };
        class squadtickets: RscText
        {
            idc = 1817;
            text = "To begin";
            sizeEx = 10 * (pixelH * 2);
            style = ST_LEFT;
            x = 50 * (pixelW * pixelGrid) * safezoneW + safeZoneX;
            y = 65 * (pixelH * pixelGrid) + safeZoneY;
            w = 100 * (pixelW * 2);
            h = 15 * (pixelH * 2);
        };
        class respawngroup: RscButton
        {
            idc = -1;
            text = "Respawn selected group";
            sizeEx = 10 * (pixelH * 2);
            style = ST_LEFT;
            x = 50 * (pixelW * pixelGrid) * safezoneW + safeZoneX;
            y = 70 * (pixelH * pixelGrid) + safeZoneY;
            w = 100 * (pixelW * 2);
            h = 20 * (pixelH * 2);
            action =  "[] spawn ca_fnc_respawngroup";
        };
        class givetickets: RscButton
        {
            idc = -1;
            text = "+1";
            sizeEx = 10 * (pixelH * 2);
            style = ST_LEFT;
            x = 57 * (pixelW * pixelGrid) * safezoneW + safeZoneX;
            y = 60 * (pixelH * pixelGrid) + safeZoneY;
            w = 15 * (pixelW * 2);
            h = 15 * (pixelH * 2);
            action =  "[1] spawn ca_fnc_transferSquadTickets";
        };
        class taketickets: RscButton
        {
            idc = -1;
            text = "-1";
            sizeEx = 10 * (pixelH * 2);
            style = ST_LEFT;
            x = 57 * (pixelW * pixelGrid) * safezoneW + safeZoneX;
            y = 65 * (pixelH * pixelGrid) + safeZoneY;
            w = 15 * (pixelW * 2);
            h = 15 * (pixelH * 2);
            action =  "[-1] spawn ca_fnc_transferSquadTickets";
        };
        class give5: RscButton
        {
            idc = -1;
            text = "+5";
            sizeEx = 10 * (pixelH * 2);
            style = ST_LEFT;
            x = 59 * (pixelW * pixelGrid) * safezoneW + safeZoneX;
            y = 60 * (pixelH * pixelGrid) + safeZoneY;
            w = 15 * (pixelW * 2);
            h = 15 * (pixelH * 2);
            action =  "[5] spawn ca_fnc_transferSquadTickets";
        };
        class take5: RscButton
        {
            idc = -1;
            text = "-5";
            sizeEx = 10 * (pixelH * 2);
            style = ST_LEFT;
            x = 59 * (pixelW * pixelGrid) * safezoneW + safeZoneX;
            y = 65 * (pixelH * pixelGrid) + safeZoneY;
            w = 15 * (pixelW * 2);
            h = 15 * (pixelH * 2);
            action =  "[-5] spawn ca_fnc_transferSquadTickets";
        };
            class selectsquad: RscButton
        {
            idc = -1;
            text = "Select squad";
            sizeEx = 10 * (pixelH * 2);
            style = ST_LEFT;
            x = 63 * (pixelW * pixelGrid) * safezoneW + safeZoneX;
            y = 60 * (pixelH * pixelGrid) + safeZoneY;
            w = 80 * (pixelW * 2);
            h = 20 * (pixelH * 2);
            action =  "[] spawn ca_fnc_selectgroup";
        };

            class movesquad: RscButton
        {
            idc = -1;
            text = "Move selected squad";
            sizeEx = 10 * (pixelH * 2);
            style = ST_LEFT;
            x = 63 * (pixelW * pixelGrid) * safezoneW + safeZoneX;
            y = 65 * (pixelH * pixelGrid) + safeZoneY;
            w = 80 * (pixelW * 2);
            h = 20 * (pixelH * 2);
            action =  "[] spawn ca_fnc_movegroup";
        };
    };
};
