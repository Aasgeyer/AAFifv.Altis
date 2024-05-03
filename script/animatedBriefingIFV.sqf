private _mult = 0.5;
_timeline = [
	[0.0*_mult, {
		//zoom on area
		[markerSize "marker_brief_2", markerpos "marker_brief_2", 2] call BIS_fnc_zoomOnArea;
		["Instructor", "Some areas, i.e. urban or forests, are not accessible for vehicles. In this case the dismounted troops come into play."] spawn BIS_fnc_showSubtitle;
	}],
	[6*_mult, {
		//move apc
		["marker_brief_1", markerpos "marker_brief_3", 4] call BIS_fnc_moveMarker;
		["Instructor", "The APC moves up to the dismount position. It should provide cover and concealment for the dismounting troops."] spawn BIS_fnc_showSubtitle;
	}],
	[12*_mult, {
		//dismount troops
		["show", ["marker_brief_4"]] call BIS_fnc_showMarkers;
	}],
	[18*_mult, {
		//move dismounted to obj 2
		["marker_brief_4", markerpos "marker_obj_2", 3] call BIS_fnc_moveMarker;
		["marker_brief_4", markerpos "marker_brief_4" getDir markerPos "marker_obj_2", true, 0, 1] spawn BIS_fnc_rotateMarker;
		["Instructor", "The squad attacks the position after dismounting, the IFV supports by fire."] spawn BIS_fnc_showSubtitle;
	}],
	[24*_mult, {
		//move apc up
		["marker_brief_1", markerpos "marker_brief_5", 4] call BIS_fnc_moveMarker;
		["marker_brief_1", markerDir "marker_brief_5", true, 0, 2] spawn BIS_fnc_rotateMarker;
		//destroy enemy
		["marker_brief_6", 1, 2] spawn BIS_fnc_cancelMarker;
		["hide", ["marker_brief_6"]] call BIS_fnc_showMarkers;
		["Instructor", "The squad succesfully assaults the enemy position. The IFV moves up to cover for possbile enemy counter attacks."] spawn BIS_fnc_showSubtitle;
	}],
	[30*_mult, {
		// move dismounted to apc
		["marker_brief_4", markerpos "marker_brief_4" getDir markerPos "marker_brief_1", true, 0, 1] spawn BIS_fnc_rotateMarker;
		["marker_brief_4", markerpos "marker_brief_1", 3] call BIS_fnc_moveMarker;
		["Instructor", "The squad mounts the IFV again."] spawn BIS_fnc_showSubtitle;
	}],
	[36*_mult, {
		//infantry mount
		["hide", ["marker_brief_4"]] call BIS_fnc_showMarkers;
		["Instructor", "Remember that dismounted troops are more vulnerable and slower than when mounted. Only fight dismounted when neccessary."] spawn BIS_fnc_showSubtitle;
	}],
	[42*_mult, {
	}]
];

private _initalPosAndDir = AAS_briefingMarkers apply {[markerpos _x, markerDir _x]};
private _showMarkers = ["marker_brief_1","marker_brief_6"];
private _hideMarkers = AAS_briefingMarkers-_showMarkers;
private _fn_endCode = {};

[_timeline, 0, nil, _hideMarkers, _showMarkers, "marker_brief_2", true, _fn_endCode] spawn BIS_fnc_animatedBriefing;

waitUntil { !(missionNamespace getVariable ["BIS_fnc_eventTimeline_playing",true]); };
sleep 0.1;
{
	private _posAndDir = _initalPosAndDir#_foreachIndex;
	_x setMarkerPos (_posAndDir#0);
	_x setMarkerDir (_posAndDir#1);
	_x setMarkerAlpha 0;
} forEach AAS_briefingMarkers;