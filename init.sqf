

AAS_obj_markers = ["marker_obj_"] call BIS_fnc_getMarkers;
AAS_PL_markers = ["marker_PL_"] call BIS_fnc_getMarkers;
AAS_PL_names = ["Flint", "Slate", "Jett", "Stone", "Ash", "Steel", "Cedar", "Blaze", "Cliff", "Onyx", "Pearl", "Ember"];
"marker_AO" setMarkerAlpha 0;
AAS_briefingMarkers = (getMissionLayerEntities "Layer_briefing") select 1;
AAS_briefingMarkers apply {
	_x setMarkerAlpha 0;
};
AAS_markers_briefAlpha = ["marker_briefing_alpha_"] call BIS_fnc_getMarkers;
[AAS_markers_briefAlpha,0] spawn BIS_fnc_hideMarkerArray;
AAS_atPositionMarkers = ["marker_atPos_"] call BIS_fnc_getMarkers;
AAS_atPositionMarkers apply {_x setMarkerColor "ColorUNKNOWN";};

[] execVM "script\spawnObjectives.sqf";
[] execVM "script\IFVinit.sqf";
//[] execVM "script\briefing.sqf";