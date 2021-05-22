//Sorted roughly top left to bottom right
class ca_hierarchydialog
{
	idd= 1809;
    movingEnable = 1;
    enableSimulation = 1;
    onLoad= "[] spawn { [] execvm 'ca\hierarchy\ca_hierarchydialogsupport.sqf'}";
	class controls
	{
        class frame: RscFrame1
        {
        	idc = 1810;
            x = 52 * 0.00126263 * 8 + safeZoneX;
            y = 30 * 0.0016835 * 8 + safeZoneY;
            w = 500 * (0.00126263 * 2);
            h = 300 * (0.0016835 * 2);
            moving = 1;
        };
        class banner: RscText 
        {
        	idc = -1;
            style = ST_CENTER;
            x = 52 * 0.00126263 * 8 + safeZoneX;
            y = 24 * 0.0016835 * 8 + safeZoneY;
            sizeEx = 14 * (0.0016835 * 2);
            w = 500 * (0.00126263 * 2);
            h = 20 * (0.0016835 * 2);
            colorBackground[] = {0.45,0.65,0.34,0.8};
            colorText[] = {1,1,1,0.9};
            text = "CA Hierachy User Interface";
            moving = 1;
        };
        class tree: RscTree
        {
        	idc = 1811;
            colorBackground[] = {0,0,0,0.8};
	        colorText[] = {1,1,1,0.9};
            sizeEx = 10 * (0.0016835 * 2);
            x = 73 * 0.00126263 * 8 + safeZoneX;
            y = 30 * 0.0016835 * 8 + safeZoneY;
            w = 90 * (0.00126263 * 2);
            h = 300 * (0.0016835 * 2);
            expandOnDoubleclick = 1; // Expand/collapse item upon double-click
            moving = 1;

            class ScrollBar : ScrollBar
            {};
        };
        class groupcontrol: RscText
        {
            idc = -1;
            text = "Group controls";
            sizeEx = 10 * (0.0016835 * 2);
            style = ST_LEFT;
            x = 52 * 0.00126263 * 8 + safeZoneX;
            y = 30 * 0.0016835 * 8 + safeZoneY;
            w = 95 * (0.00126263 * 2);
            h = 15 * (0.0016835 * 2);
        };
        class selectsquad: RscButton
        {
            idc = -1;
            text = "Pin/Unpin group";
            tooltip = "Pin/unpins the group you have clicked on in the list of groups";
            sizeEx = 10 * (0.0016835 * 2);
            style = ST_LEFT;
            x = 52 * 0.00126263 * 8 + safeZoneX;
            y = 35 * 0.0016835 * 8 + safeZoneY;
            w = 80 * (0.00126263 * 2);
            h = 20 * (0.0016835 * 2);
            action =  "[] spawn ca_fnc_selectgroup";
        };
            class movesquad: RscButton
        {
            idc = -1;
            text = "Assign pinned group to";
            tooltip = "Moves the pinned group to underneath the group you have clicked on";
            sizeEx = 10 * (0.0016835 * 2);
            style = ST_LEFT;
            x = 52 * 0.00126263 * 8 + safeZoneX;
            y = 40 * 0.0016835 * 8 + safeZoneY;
            w = 80 * (0.00126263 * 2);
            h = 20 * (0.0016835 * 2);
            action =  "[] spawn ca_fnc_movegroup";
        };
            class registergroup: RscButton
        {
            idc = -1;
            text = "Register group";
            tooltip = "Registers the current group";
            sizeEx = 10 * (0.0016835 * 2);
            style = ST_LEFT;
            x = 52 * 0.00126263 * 8 + safeZoneX;
            y = 45 * 0.0016835 * 8 + safeZoneY;
            w = 80 * (0.00126263 * 2);
            h = 20 * (0.0016835 * 2);
            action =  "[] spawn ca_fnc_registergroup";
        };
        class joingroup: RscButton
        {
            idc = -1;
            text = "Join group";
            tooltip = "Join the currently selected group";
            sizeEx = 10 * (0.0016835 * 2);
            style = ST_LEFT;
            x = 52 * 0.00126263 * 8 + safeZoneX;
            y = 50 * 0.0016835 * 8 + safeZoneY;
            w = 80 * (0.00126263 * 2);
            h = 20 * (0.0016835 * 2);
            action =  "[player] joinSilent ca_selectedgroup; closeDialog 0; systemchat 'Joined selected group!'";
        };
        class respawngroup: RscButton
        {
            idc = 1805;
            deletable = 1;
            text = "Respawn group";
            tooltip = "Respawns the current group";
            sizeEx = 10 * (0.0016835 * 2);
            style = ST_LEFT;
            x = 52 * 0.00126263 * 8 + safeZoneX;
            y = 55 * 0.0016835 * 8 + safeZoneY;
            w = 80 * (0.00126263 * 2);
            h = 20 * (0.0016835 * 2);
            action =  "[] spawn ca_fnc_respawngroup";
        };
        class selectedgroupinfo: RscText
        {
            idc = -1;
            text = "Pinned group:";
            sizeEx = 10 * (0.0016835 * 2);
            style = ST_LEFT;
            x = 52 * 0.00126263 * 8 + safeZoneX;
            y = 60 * 0.0016835 * 8 + safeZoneY;
            w = 100 * (0.00126263 * 2);
            h = 15 * (0.0016835 * 2);
        };
        class selectedgroup: RscText
        {
            idc = 1818;
            text = "None";
            sizeEx = 10 * (0.0016835 * 2);
            style = ST_LEFT;
            x = 52 * 0.00126263 * 8 + safeZoneX;
            y = 65 * 0.0016835 * 8 + safeZoneY;
            w = 100 * (0.00126263 * 2);
            h = 15 * (0.0016835 * 2);
        };
        class superiorinfo: RscText
        {
            idc = -1;
            text = "Superiors callsign:";
            sizeEx = 10 * (0.0016835 * 2);
            style = ST_LEFT;
            x = 52 * 0.00126263 * 8 + safeZoneX;
            y = 70 * 0.0016835 * 8 + safeZoneY;
            w = 100 * (0.00126263 * 2);
            h = 15 * (0.0016835 * 2);
        };
        class superiorgroup: RscText
        {
            idc = 1819;
            text = "None";
            sizeEx = 10 * (0.0016835 * 2);
            style = ST_LEFT;
            x = 52 * 0.00126263 * 8 + safeZoneX;
            y = 75 * 0.0016835 * 8 + safeZoneY;
            w = 100 * (0.00126263 * 2);
            h = 15 * (0.0016835 * 2);
        };
        class aliveplayers: RscListbox1
        {
        	idc = 1812;
            sizeEx = 10 * (0.0016835 * 2);
            x = 97 * 0.00126263 * 8 + safeZoneX;
            y = 35 * 0.0016835 * 8 + safeZoneY;
            w = 93 * (0.00126263 * 2);
            h = 120 * (0.0016835 * 2);

        };
        class aliveplayerinfo: RscText
        {
            idc = -1;
            text = "Alive players in group";
            sizeEx = 10 * (0.0016835 * 2);
            style = ST_CENTER;
            x = 97 * 0.00126263 * 8 + safeZoneX;
            y = 30 * 0.0016835 * 8 + safeZoneY;
            w = 95 * (0.00126263 * 2);
            h = 15 * (0.0016835 * 2);
        };
        class playercontrol: RscText
        {
            idc = -1;
            text = "Player controls";
            sizeEx = 10 * (0.0016835 * 2);
            style = ST_LEFT;
            x = 121 * 0.00126263 * 8 + safeZoneX;
            y = 30 * 0.0016835 * 8 + safeZoneY;
            w = 95 * (0.00126263 * 2);
            h = 15 * (0.0016835 * 2);
        };
        class demote: RscButton
        {
            idc = -1;
            text = "Demote player";
            sizeEx = 10 * (0.0016835 * 2);
            style = ST_LEFT;
            x = 121 * 0.00126263 * 8 + safeZoneX;
            y = 35 * 0.0016835 * 8 + safeZoneY;
            w = 80 * (0.00126263 * 2);
            h = 20 * (0.0016835 * 2);
            action =  "[false] spawn ca_fnc_changerank";
        };
         class promote: RscButton
        {
            idc = -1;
            text = "Promote player";
            sizeEx = 10 * (0.0016835 * 2);
            style = ST_LEFT;
            x = 121 * 0.00126263 * 8 + safeZoneX;
            y = 40 * 0.0016835 * 8 + safeZoneY;
            w = 80 * (0.00126263 * 2);
            h = 20 * (0.0016835 * 2);
            action =  "[true] spawn ca_fnc_changerank";
        };
        class givelocalmark: RscButton 
        {
            idc = -1;
            text = "Give map Marker";
            tooltip = "Gives the selected player a specialist marker";
            sizeEx = 10 * (0.0016835 * 2);
            style = ST_LEFT;
            x = 121 * 0.00126263 * 8 + safeZoneX;
            y = 45 * 0.0016835 * 8 + safeZoneY;
            w = 80 * (0.00126263 * 2);
            h = 20 * (0.0016835 * 2);
            action =  "[] spawn ca_fnc_giveSpecialistMarker";
            //closeDialog 0;
        };
        class markerinfo: RscText //moved 
        {
            idc = -1;
            text = "Group Marker Controls";
            sizeEx = 10 * (0.0016835 * 2);
            style = ST_LEFT;
            x = 121 * 0.00126263 * 8 + safeZoneX;
            y = 50 * 0.0016835 * 8 + safeZoneY;
            w = 80 * (0.00126263 * 2);
            h = 20 * (0.0016835 * 2);
        };
        class givegroupmarker: RscButton 
        {
            idc = 1822;
            deletable = 1;
            text = "Give groupmarker";
            tooltip = "Gives the group you've selected a groupmarker";
            sizeEx = 10 * (0.0016835 * 2);
            style = ST_LEFT;
            x = 121 * 0.00126263 * 8 + safeZoneX;
            y = 55 * 0.0016835 * 8 + safeZoneY;
            w = 80 * (0.00126263 * 2);
            h = 20 * (0.0016835 * 2);
            action =  "if(rankid player >= ca_ftlrank && (!isnil {ca_selectedgroup})) then { [(ca_selectedgroup)] remoteExec ['ca_fnc_groupMarker', (side player)];} else {hint 'You are not FTL rank or don't have a group selected!'};";
            //closeDialog 0;
        };
        class changegroupmarker: RscButton 
        {
            idc = -1;
            text = "Change callsign/color";
            tooltip = "Opens a menu to change the group info";
            sizeEx = 10 * (0.0016835 * 2);
            style = ST_LEFT;
            x = 121 * 0.00126263 * 8 + safeZoneX;
            y = 60 * 0.0016835 * 8 + safeZoneY;
            w = 80 * (0.00126263 * 2);
            h = 20 * (0.0016835 * 2);
            action =  "if(rankid player >= ca_ftlrank || serverCommandAvailable '#kick') then {_groupiddialog=createdialog 'ca_groupid'; } else {systemchat 'You are not FTL rank and thus cant change callsigns!'}";
        };
        class deadplayers: RscListbox1
        {
        	idc = 1813;
            sizeEx = 10 * (0.0016835 * 2);
            x = 97 * 0.00126263 * 8 + safeZoneX;
            y = 75 * 0.0016835 * 8 + safeZoneY;
            w = 93 * (0.00126263 * 2);
            h = 115 * (0.0016835 * 2);
        };
        class deadplayerinfo: RscText
        {
            idc = -1;
            text = "Dead players in group";
            style = ST_CENTER;
            sizeEx = 10 * (0.0016835 * 2);
            x = 97 * 0.00126263 * 8 + safeZoneX;
            y = 69 * 0.0016835 * 8 + safeZoneY;
            w = 95 * (0.00126263 * 2);
            h = 15 * (0.0016835 * 2);
        };
        class shortrangech: RscEdit //moved 
        {
            idc = 1814;
            sizeEx = 15 * (0.0016835 * 2);
            text = "";
            x = 145 * 0.00126263 * 8 + safeZoneX;
            y = 35 * 0.0016835 * 8 + safeZoneY;
            w = 100 * (0.00126263 * 2);
            h = 25 * (0.0016835 * 2);
        };
        class longrangechannel: RscEdit //moved 
        {
            idc = 1815;
            sizeEx = 15 * (0.0016835 * 2);
            text = "";
            x = 145 * 0.00126263 * 8 + safeZoneX;
            y = 50 * 0.0016835 * 8 + safeZoneY;
            w = 100 * (0.00126263 * 2);
            h = 25 * (0.0016835 * 2);
        };
        class shortrangeinfo: RscText //moved 
        {
            idc = -1;
            text = "Selected group SR radio channel";
            style = ST_LEFT;
            sizeEx = 10 * (0.0016835 * 2);
            x = 144 * 0.00126263 * 8 + safeZoneX;
            y = 30 * 0.0016835 * 8 + safeZoneY;
            w = 200 * (0.00126263 * 2);
            h = 15 * (0.0016835 * 2);
        };
        class longrangeinfo: RscText //moved 
        {
            idc = -1;
            text = "Selected group LR radio channels";
            sizeEx = 10 * (0.0016835 * 2);
            style = ST_LEFT;
            x = 144 * 0.00126263 * 8 + safeZoneX;
            y = 45 * 0.0016835 * 8 + safeZoneY;
            w = 200 * (0.00126263 * 2);
            h = 15 * (0.0016835 * 2);
        };
        class updateradios: RscButton 
        {
            idc = -1;
            text = "Update Radio Channels";
            tooltip = "Only affects new radios issued";
            sizeEx = 10 * (0.0016835 * 2);
            style = ST_LEFT;
            x = 145 * 0.00126263 * 8 + safeZoneX;
            y = 58 * 0.0016835 * 8 + safeZoneY;
            w = 90 * (0.00126263 * 2);
            h = 20 * (0.0016835 * 2);
            action =  "[] spawn ca_fnc_updateradioCHs";
            //closeDialog 0;
        };
        class applySRradios: RscButton 
        {
            idc = -1;
            text = "Apply radio CHs to group";
            tooltip = "Applies specified radio channels to currently selected group";
            sizeEx = 10 * (0.0016835 * 2);
            style = ST_LEFT;
            x = 145 * 0.00126263 * 8 + safeZoneX;
            y = 63 * 0.0016835 * 8 + safeZoneY;
            w = 90 * (0.00126263 * 2);
            h = 20 * (0.0016835 * 2);
            action =  "[] spawn ca_fnc_applyradiochannels";
            //closeDialog 0;
        };     
        class tickinfo: RscText  
        {
            idc = -1;
            text = "Group Ticket Controls (Group respawn only)";
            sizeEx = 10 * (0.0016835 * 2);
            style = ST_LEFT;
            x = 122 * 0.00126263 * 8 + safeZoneX;
            y = 69 * 0.0016835 * 8 + safeZoneY;
            w = 200 * (0.00126263 * 2);
            h = 20 * (0.0016835 * 2);
        };
        class sidetickets: RscText
        {
            idc = 1816;
            text = "Select group to show";
            sizeEx = 10 * (0.0016835 * 2);
            style = ST_LEFT;
            x = 122 * 0.00126263 * 8 + safeZoneX;
            y = 75 * 0.0016835 * 8 + safeZoneY;
            w = 90 * (0.00126263 * 2);
            h = 15 * (0.0016835 * 2);
        };
        class squadtickets: RscText
        {
            idc = 1817;
            text = "";
            deletable = 1;
            sizeEx = 10 * (0.0016835 * 2);
            style = ST_LEFT;
            x = 122 * 0.00126263 * 8 + safeZoneX;
            y = 80 * 0.0016835 * 8 + safeZoneY;
            w = 100 * (0.00126263 * 2);
            h = 15 * (0.0016835 * 2);
        };
        class givetickets: RscButton
        {
            idc = 1806;
            text = "+1";
            tooltip = "Gives 1 group ticket to the selected group";
            deletable = 1;
            sizeEx = 10 * (0.0016835 * 2);
            style = ST_LEFT;
            x = 122 * 0.00126263 * 8 + safeZoneX;
            y = 85 * 0.0016835 * 8 + safeZoneY;
            w = 15 * (0.00126263 * 2);
            h = 15 * (0.0016835 * 2);
            action =  "[1] spawn ca_fnc_transferSquadTickets";
        };
        class taketickets: RscButton
        {
            idc = 1807;
            text = "-1";
            tooltip = "Takes 1 group ticket from the selected group";
            deletable = 1;
            sizeEx = 10 * (0.0016835 * 2);
            style = ST_LEFT;
            x = 122 * 0.00126263 * 8 + safeZoneX;
            y = 90 * 0.0016835 * 8 + safeZoneY;
            w = 15 * (0.00126263 * 2);
            h = 15 * (0.0016835 * 2);
            action =  "[-1] spawn ca_fnc_transferSquadTickets";
        };
        class give5: RscButton
        {
            idc = 1808;
            text = "+5";
            tooltip = "Gives 5 group tickets to the selected group";
            deletable = 1;
            sizeEx = 10 * (0.0016835 * 2);
            style = ST_LEFT;
            x = 127 * 0.00126263 * 8 + safeZoneX;
            y = 85 * 0.0016835 * 8 + safeZoneY;
            w = 15 * (0.00126263 * 2);
            h = 15 * (0.0016835 * 2);
            action =  "[5] spawn ca_fnc_transferSquadTickets";
        };
        class take5: RscButton
        {
            idc = 1804;
            text = "-5";
            tooltip = "Takes 5 group tickets from the selected group";
            deletable = 1;
            sizeEx = 10 * (0.0016835 * 2);
            style = ST_LEFT;
            x = 127 * 0.00126263 * 8 + safeZoneX;
            y = 90 * 0.0016835 * 8 + safeZoneY;
            w = 15 * (0.00126263 * 2);
            h = 15 * (0.0016835 * 2);
            action =  "[-5] spawn ca_fnc_transferSquadTickets";
        };
        class grptimer: RscText
        {
            idc = 1820;
            deletable = 1;
            text = "Group respawn timer";
            sizeEx = 10 * (0.0016835 * 2);
            style = ST_LEFT;
            x = 122 * 0.00126263 * 8 + safeZoneX;
            y = 100 * 0.0016835 * 8 + safeZoneY;
            w = 200 * (0.00126263 * 2);
            h = 15 * (0.0016835 * 2);
        };
            class becomeco: RscButton
        {
            idc = -1;
            text = "Become CO";
            sizeEx = 10 * (0.0016835 * 2);
            style = ST_LEFT;
            x = 145 * 0.00126263 * 8 + safeZoneX;
            y = 80 * 0.0016835 * 8 + safeZoneY;
            w = 90 * (0.00126263 * 2);
            h = 20 * (0.0016835 * 2);
            action =  "[] spawn ca_fnc_becomeco";
        };
        class waveinfo: RscText //moved 
        {
            idc = -1;
            text = "Commanding Officer controls";
            sizeEx = 10 * (0.0016835 * 2);
            style = ST_LEFT;
            x = 145 * 0.00126263 * 8 + safeZoneX;
            y = 75 * 0.0016835 * 8 + safeZoneY;
            w = 140 * (0.00126263 * 2);
            h = 20 * (0.0016835 * 2);
        };
            class waverespawn: RscButton
        {
            idc = -1;
            text = "Wave Respawn Interface";
            tooltip = "Full list of all dead players";
            sizeEx = 10 * (0.0016835 * 2);
            style = ST_LEFT;
            x = 145 * 0.00126263 * 8 + safeZoneX;
            y = 85 * 0.0016835 * 8 + safeZoneY;
            w = 90 * (0.00126263 * 2);
            h = 20 * (0.0016835 * 2);
            action =  "if(rankid player >= ca_corank || serverCommandAvailable '#kick') then {_handle=createdialog 'ca_respawndiag'; } else {systemchat 'You are not CO rank and thus cant wave respawn!'}";
        };
    };
};
