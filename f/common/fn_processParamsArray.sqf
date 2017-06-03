// F3 - Process ParamsArray
// Credits: Please see the F3 online manual (http://www.ferstaberinde.com/f3/en/)
// ====================================================================================

//Testing has shown that paramArrays only exists on the server during preInit
//The publicVariable will synchronize the value to the clients.
//Super bodge, if you know what you are doing please fix, either case not all parameters are initialized.

_paramArray = paramsArray;
{
	_paramName =(configName ((missionConfigFile >> "Params") select _forEachIndex));
	_paramValue = (_paramArray select _forEachIndex);
	_paramCode = ( getText (missionConfigFile >> "Params" >> _paramName >> "code"));
	_code = format[_paramCode, _paramValue];
	call compile _code;
	if (isServer) then {
		publicVariable _paramName;
	};
} foreach _paramArray;

//PreInit
if (isServer) then {
    if (isNil "f_paramsArray_complete") then {
        if (isNil "paramsArray") then {
            {
                _paramName = (configName _x);
                _paramValue = (getNumber (missionConfigFile >> "Params" >> _paramName >> "default"));
                missionNamespace setVariable [_paramName,_paramValue];
                publicVariable _paramName;
            } forEach ("true" configClasses (missionConfigFile >> "Params"));
        } else {
            {
                _paramName =(configName ((missionConfigFile >> "Params") select _forEachIndex));
                missionNamespace setVariable [_paramName,_x];
                publicVariable _paramName;
            } forEach paramsArray;
            f_ParamsArray_complete = true;
        };
    };
};
