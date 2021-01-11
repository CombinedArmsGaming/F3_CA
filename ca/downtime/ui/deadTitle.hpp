#define GUI_GRID_X		(0)
#define GUI_GRID_Y		(0)
#define GUI_GRID_W		(0.025)
#define GUI_GRID_H		(0.04)

class CA2_DowntimeDead
{
    idd = 13174;

	movingEnable = false;
	enableSimulation = true;

    fadein = 1;
    duration = 4;
	fadeout = 3;

    onLoad = "_this call ca_fnc_downtimeDead_onLoad;";

    class ControlsBackground
    {
        class YouAre: RscText
        {
        	idc = 1000;
            style = ST_CENTER;
        	text = "You have";
            font = "PuristaBold";
        	x = 7.5 * GUI_GRID_W + GUI_GRID_X;
        	y = 7 * GUI_GRID_H + GUI_GRID_Y;
        	w = 25 * GUI_GRID_W;
        	h = 3 * GUI_GRID_H;
        	sizeEx = 2 * GUI_GRID_H;
        };

        class Dead: RscText
        {
        	idc = 1001;
            style = ST_CENTER;
        	text = " Died.";
            font = "PuristaBold";
			colorText[] = {1,0.1,0.1,1};
        	x = 7.5 * GUI_GRID_W + GUI_GRID_X;
        	y = 9 * GUI_GRID_H + GUI_GRID_Y;
        	w = 25 * GUI_GRID_W;
        	h = 3 * GUI_GRID_H;
        	sizeEx = 3 * GUI_GRID_H;
        };

        class Subtitle: RscText
        {
        	idc = 1002;
            style = ST_CENTER;
        	text = "";
        	x = 7.5 * GUI_GRID_W + GUI_GRID_X;
        	y = 11.5 * GUI_GRID_H + GUI_GRID_Y;
        	w = 25 * GUI_GRID_W;
        	h = 3 * GUI_GRID_H;
        	sizeEx = 1 * GUI_GRID_H;
        };

    };

};
