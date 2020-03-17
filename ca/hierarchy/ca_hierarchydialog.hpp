
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
            x = 21.5 * pixelW * pixelGrid * safezoneW + safeZoneX;
            y = 30 * pixelH * pixelGrid + safeZoneY;
            w = 480 * (pixelW * 2);
            h = 300 * (pixelH * 2);
        };
        class tree: RscTree
        {
        	idc = 1811;
            colorBackground[] = {0,0,0,0.8};
	        colorText[] = {1,1,1,0.9};
            sizeEx = 10 * (pixelH * 2);
            x = 30 * pixelW * pixelGrid * safezoneW + safeZoneX;
            y = 30 * pixelH * pixelGrid + safeZoneY;
            w = 90 * (pixelW * 2);
            h = 300 * (pixelH * 2);
            expandOnDoubleclick = 1; // Expand/collapse item upon double-click

            class ScrollBar : ScrollBar
            {};
        };
        class groupcontrol: RscText
        {
            idc = -1;
            text = "Group controls";
            sizeEx = 10 * (pixelH * 2);
            style = ST_LEFT;
            x = 21.5 * pixelW * pixelGrid * safezoneW + safeZoneX;
            y = 30 * pixelH * pixelGrid + safeZoneY;
            w = 95 * (pixelW * 2);
            h = 15 * (pixelH * 2);
        };
        class selectsquad: RscButton
        {
            idc = -1;
            text = "Select/Deselect group";
            sizeEx = 10 * (pixelH * 2);
            style = ST_LEFT;
            x = 21.5 * pixelW * pixelGrid * safezoneW + safeZoneX;
            y = 35 * pixelH * pixelGrid + safeZoneY;
            w = 80 * (pixelW * 2);
            h = 20 * (pixelH * 2);
            action =  "[] spawn ca_fnc_selectgroup";
        };
            class movesquad: RscButton
        {
            idc = -1;
            text = "Assign subgroup";
            sizeEx = 10 * (pixelH * 2);
            style = ST_LEFT;
            x = 21.5 * pixelW * pixelGrid * safezoneW + safeZoneX;
            y = 40 * pixelH * pixelGrid + safeZoneY;
            w = 80 * (pixelW * 2);
            h = 20 * (pixelH * 2);
            action =  "[] spawn ca_fnc_movegroup";
        };
            class registergroup: RscButton
        {
            idc = -1;
            text = "Register group";
            sizeEx = 10 * (pixelH * 2);
            style = ST_LEFT;
            x = 21.5 * pixelW * pixelGrid * safezoneW + safeZoneX;
            y = 45 * pixelH * pixelGrid + safeZoneY;
            w = 80 * (pixelW * 2);
            h = 20 * (pixelH * 2);
            action =  "[] spawn ca_fnc_registergroup";
        };
        class respawngroup: RscButton
        {
            idc = -1;
            text = "Respawn group";
            sizeEx = 10 * (pixelH * 2);
            style = ST_LEFT;
            x = 21.5 * pixelW * pixelGrid * safezoneW + safeZoneX;
            y = 50 * pixelH * pixelGrid + safeZoneY;
            w = 80 * (pixelW * 2);
            h = 20 * (pixelH * 2);
            action =  "[] spawn ca_fnc_respawngroup";
        };
        class selectedgroupinfo: RscText
        {
            idc = -1;
            text = "Selected group:";
            sizeEx = 10 * (pixelH * 2);
            style = ST_LEFT;
            x = 21.5 * pixelW * pixelGrid * safezoneW + safeZoneX;
            y = 60 * pixelH * pixelGrid + safeZoneY;
            w = 100 * (pixelW * 2);
            h = 15 * (pixelH * 2);
        };
        class selectedgroup: RscText
        {
            idc = 1818;
            text = "None";
            sizeEx = 10 * (pixelH * 2);
            style = ST_LEFT;
            x = 21.5 * pixelW * pixelGrid * safezoneW + safeZoneX;
            y = 65 * pixelH * pixelGrid + safeZoneY;
            w = 100 * (pixelW * 2);
            h = 15 * (pixelH * 2);
        };
        class superiorinfo: RscText
        {
            idc = -1;
            text = "Superiors callsign:";
            sizeEx = 10 * (pixelH * 2);
            style = ST_LEFT;
            x = 21.5 * pixelW * pixelGrid * safezoneW + safeZoneX;
            y = 70 * pixelH * pixelGrid + safeZoneY;
            w = 100 * (pixelW * 2);
            h = 15 * (pixelH * 2);
        };
        class superiorgroup: RscText
        {
            idc = 1819;
            text = "None";
            sizeEx = 10 * (pixelH * 2);
            style = ST_LEFT;
            x = 21.5 * pixelW * pixelGrid * safezoneW + safeZoneX;
            y = 75 * pixelH * pixelGrid + safeZoneY;
            w = 100 * (pixelW * 2);
            h = 15 * (pixelH * 2);
        };
        class aliveplayers: RscListbox1
        {
        	idc = 1812;
            sizeEx = 10 * (pixelH * 2);
            x = 40 * pixelW * pixelGrid * safezoneW + safeZoneX;
            y = 35 * pixelH * pixelGrid + safeZoneY;
            w = 95 * (pixelW * 2);
            h = 120 * (pixelH * 2);

        };
        class aliveplayerinfo: RscText
        {
            idc = -1;
            text = "Alive players in group";
            sizeEx = 10 * (pixelH * 2);
            style = ST_CENTER;
            x = 40 * pixelW * pixelGrid * safezoneW + safeZoneX;
            y = 30 * pixelH * pixelGrid + safeZoneY;
            w = 95 * (pixelW * 2);
            h = 15 * (pixelH * 2);
        };
        class playercontrol: RscText
        {
            idc = -1;
            text = "Player controls";
            sizeEx = 10 * (pixelH * 2);
            style = ST_LEFT;
            x = 50 * pixelW * pixelGrid * safezoneW + safeZoneX;
            y = 30 * pixelH * pixelGrid + safeZoneY;
            w = 95 * (pixelW * 2);
            h = 15 * (pixelH * 2);
        };
        class demote: RscButton
        {
            idc = -1;
            text = "Demote player";
            sizeEx = 10 * (pixelH * 2);
            style = ST_LEFT;
            x = 50 * pixelW * pixelGrid * safezoneW + safeZoneX;
            y = 35 * pixelH * pixelGrid + safeZoneY;
            w = 80 * (pixelW * 2);
            h = 20 * (pixelH * 2);
            action =  "[false] spawn ca_fnc_changerank";
        };
         class promote: RscButton
        {
            idc = -1;
            text = "Promote player";
            sizeEx = 10 * (pixelH * 2);
            style = ST_LEFT;
            x = 50 * pixelW * pixelGrid * safezoneW + safeZoneX;
            y = 40 * pixelH * pixelGrid + safeZoneY;
            w = 80 * (pixelW * 2);
            h = 20 * (pixelH * 2);
            action =  "[true] spawn ca_fnc_changerank";
        };
        class givelocalmark: RscButton 
        {
            idc = -1;
            text = "Give map Marker";
            sizeEx = 10 * (pixelH * 2);
            style = ST_LEFT;
            x = 50 * pixelW * pixelGrid * safezoneW + safeZoneX;
            y = 45 * pixelH * pixelGrid + safeZoneY;
            w = 80 * (pixelW * 2);
            h = 20 * (pixelH * 2);
            action =  "[] spawn ca_fnc_giveSpecialistMarker";
            //closeDialog 0;
        };
        class deadplayers: RscListbox1
        {
        	idc = 1813;
            sizeEx = 10 * (pixelH * 2);
            x = 40 * pixelW * pixelGrid * safezoneW + safeZoneX;
            y = 75 * pixelH * pixelGrid + safeZoneY;
            w = 95 * (pixelW * 2);
            h = 115 * (pixelH * 2);
        };
        class deadplayerinfo: RscText
        {
            idc = -1;
            text = "Dead players in group";
            style = ST_CENTER;
            sizeEx = 10 * (pixelH * 2);
            x = 40 * pixelW * pixelGrid * safezoneW + safeZoneX;
            y = 69 * pixelH * pixelGrid + safeZoneY;
            w = 95 * (pixelW * 2);
            h = 15 * (pixelH * 2);
        };
        class shortrangech: RscEdit //moved 
        {
            idc = 1814;
            sizeEx = 15 * (pixelH * 2);
            text = "";
            x = 60 * pixelW * pixelGrid * safezoneW + safeZoneX;
            y = 35 * pixelH * pixelGrid + safeZoneY;
            w = 100 * (pixelW * 2);
            h = 25 * (pixelH * 2);
        };
        class longrangechannel: RscEdit //moved 
        {
            idc = 1815;
            sizeEx = 15 * (pixelH * 2);
            text = "";
            x = 60 * pixelW * pixelGrid * safezoneW + safeZoneX;
            y = 50 * pixelH * pixelGrid + safeZoneY;
            w = 100 * (pixelW * 2);
            h = 25 * (pixelH * 2);
        };
        class shortrangeinfo: RscText //moved 
        {
            idc = -1;
            text = "SR radio channel next respawn";
            style = ST_LEFT;
            sizeEx = 10 * (pixelH * 2);
            x = 59 * pixelW * pixelGrid * safezoneW + safeZoneX;
            y = 30 * pixelH * pixelGrida + safeZoneY;
            w = 200 * (pixelW * 2);
            h = 15 * (pixelH * 2);
        };
        class longrangeinfo: RscText //moved 
        {
            idc = -1;
            text = "LR radio channels next respawn";
            sizeEx = 10 * (pixelH * 2);
            style = ST_LEFT;
            x = 59 * pixelW * pixelGrid * safezoneW + safeZoneX;
            y = 45 * pixelH * pixelGrid + safeZoneY;
            w = 200 * (pixelW * 2);
            h = 15 * (pixelH * 2);
        };
        class updateradios: RscButton 
        {
            idc = -1;
            text = "Update Radio CHs";
            sizeEx = 10 * (pixelH * 2);
            style = ST_LEFT;
            x = 59 * pixelW * pixelGrid * safezoneW + safeZoneX;
            y = 58 * pixelH * pixelGrid + safeZoneY;
            w = 110 * (pixelW * 2);
            h = 20 * (pixelH * 2);
            action =  "[] spawn ca_fnc_updateradioCHs";
            //closeDialog 0;
        };
        class tickinfo: RscText //moved 
        {
            idc = -1;
            text = "Group Ticket Controls";
            sizeEx = 10 * (pixelH * 2);
            style = ST_LEFT;
            x = 50 * pixelW * pixelGrid * safezoneW + safeZoneX;
            y = 69 * pixelH * pixelGrid + safeZoneY;
            w = 140 * (pixelW * 2);
            h = 20 * (pixelH * 2);
        };
        class sidetickets: RscText
        {
            idc = 1816;
            text = "Select a group";
            sizeEx = 10 * (pixelH * 2);
            style = ST_LEFT;
            x = 50 * pixelW * pixelGrid * safezoneW + safeZoneX;
            y = 75 * pixelH * pixelGrid + safeZoneY;
            w = 80 * (pixelW * 2);
            h = 15 * (pixelH * 2);
        };
        class squadtickets: RscText
        {
            idc = 1817;
            text = "To begin";
            sizeEx = 10 * (pixelH * 2);
            style = ST_LEFT;
            x = 50 * pixelW * pixelGrid * safezoneW + safeZoneX;
            y = 80 * pixelH * pixelGrid + safeZoneY;
            w = 100 * (pixelW * 2);
            h = 15 * (pixelH * 2);
        };
        class givetickets: RscButton
        {
            idc = -1;
            text = "+1";
            sizeEx = 10 * (pixelH * 2);
            style = ST_LEFT;
            x = 50 * pixelW * pixelGrid * safezoneW + safeZoneX;
            y = 85 * pixelH * pixelGrid + safeZoneY;
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
            x = 50 * pixelW * pixelGrid * safezoneW + safeZoneX;
            y = 90 * pixelH * pixelGrid + safeZoneY;
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
            x = 52 * pixelW * pixelGrid * safezoneW + safeZoneX;
            y = 85 * pixelH * pixelGrid + safeZoneY;
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
            x = 52 * pixelW * pixelGrid * safezoneW + safeZoneX;
            y = 90 * pixelH * pixelGrid + safeZoneY;
            w = 15 * (pixelW * 2);
            h = 15 * (pixelH * 2);
            action =  "[-5] spawn ca_fnc_transferSquadTickets";
        };
            class becomeco: RscButton
        {
            idc = -1;
            text = "Become CO";
            sizeEx = 10 * (pixelH * 2);
            style = ST_LEFT;
            x = 50 * pixelW * pixelGrid * safezoneW + safeZoneX;
            y = 95 * pixelH * pixelGrid + safeZoneY;
            w = 80 * (pixelW * 2);
            h = 20 * (pixelH * 2);
            action =  "[] spawn ca_fnc_becomeco";
        };
    };
};
