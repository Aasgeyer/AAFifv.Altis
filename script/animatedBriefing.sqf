

private _showMarkers = ["marker_alpha_"] call BIS_fnc_getMarkers;
private _hideMarkers = (["marker_briefing_arrow_"] call BIS_fnc_getMarkers) + (["marker_alpha_"] call BIS_fnc_getMarkers);
private _fn_endCode = {deleteVehicle (missionNamespace getVariable ["AAS_soundSourceBriefing",objNull])};


_timeline =
[
	[0.0,	{
		[groupId group I_hq, format ["Morning %1. Let's dive into the briefing. Have a look at the map.", tolower rank player]] spawn BIS_fnc_showSubtitle;
	}	],
	[2.0,	{
		[markerSize "marker_briefing_zoom_1", markerPos "marker_briefing_zoom_1", 1] call BIS_fnc_zoomOnArea;
	}	],
	[4-1,	{
		["marker_AA_t", 0.5, 3] spawn BIS_fnc_blinkMarker;
		[groupId group I_hq, format ["We’re currently stationed at Assembly Area Blue, to the west of Molos."]] spawn BIS_fnc_showSubtitle;
	}	],
	[9-1,	{
		[AAS_markers_briefAlpha, 2] spawn BIS_fnc_showMarkerArray;
		[groupId group I_hq, format ["Our forces are composed of one mechanized squad, Alpha 1-1, and two infantry squads, Alpha 1-2 and Alpha 1-3."]] spawn BIS_fnc_showSubtitle;
	}	],
	[14.0,	{
		//[markerSize "marker_briefing_zoom_2", markerPos "marker_briefing_zoom_2", 1] call BIS_fnc_zoomOnArea;
	}	],
	[18-1.0,	{
		["marker_7", 0.5, 3] spawn BIS_fnc_blinkMarker;
		[groupId group I_hq, format ["We anticipate enemy infantry in section strength, likely entrenched in buildings and forests."]] spawn BIS_fnc_showSubtitle;
	}	],
	[23.0,	{
		[markerSize "marker_briefing_zoom_1", markerPos "marker_briefing_zoom_1", 1.5] call BIS_fnc_zoomOnArea;
	}	],
	[25-1.0,	{
		for "_a" from 0 to 2 do {
			[AAS_markers_briefAlpha#_a, markerpos ((["marker_alpha_"] call BIS_fnc_getMarkers)#_a), 3] call BIS_fnc_moveMarker;
		};
		[groupId group I_hq, format ["Here's the plan: Alpha 1-1, you're assigned the southernmost corridor, where you'll encounter small settlements."]] spawn BIS_fnc_showSubtitle;
	}	],
	[30,	{
		[markerSize "marker_briefing_zoom_3", markerPos "marker_briefing_zoom_3", 1] call BIS_fnc_zoomOnArea;
	}	],
	[33-1,	{
		[groupId group I_hq, format ["Alpha 1-2 and Alpha 1-3, you're to the right, facing hilly and forested terrain."]] spawn BIS_fnc_showSubtitle;
	}	],
	[39-1,	{
		private _markers_move1 = ["marker_move1_"] call BIS_fnc_getMarkers;
		for "_a" from 0 to 2 do {
			[AAS_markers_briefAlpha#_a, markerpos (_markers_move1#_a), 3] call BIS_fnc_moveMarker;
		};
		[groupId group I_hq, format ["All squads will cross the Line of Departure, designated %1. Be ready for contact.", markerText "mrk_PLtext_1_0"]] spawn BIS_fnc_showSubtitle;
	}	],
	[44.0-1,	{
		for "_a" from 0 to 2 do {
		private _markers_move2 = ["marker_move2_"] call BIS_fnc_getMarkers;
			[AAS_markers_briefAlpha#_a, markerpos (_markers_move2#_a), 3] call BIS_fnc_moveMarker;
		};
		[groupId group I_hq, format ["Alpha 1-1, you'll secure your objective first. Alpha 1-2 and 1-3, you'll jointly secure your first objective."]] spawn BIS_fnc_showSubtitle;
	}	],
	[50.0,	{
		[markerSize "marker_briefing_AO", markerPos "marker_briefing_AO", 2] call BIS_fnc_zoomOnArea;
	}	],
	[53.0-1,	{
		for "_a" from 0 to 2 do {
			private _markers_move3 = ["marker_move3_"] call BIS_fnc_getMarkers;
			[AAS_markers_briefAlpha#_a, markerpos (_markers_move3#_a), 3] call BIS_fnc_moveMarker;
		};
		[groupId group I_hq, format ["After crossing %1, Alpha 1-3, you'll split from Alpha 1-2 and head north.", markerText "mrk_PLtext_2_0"]] spawn BIS_fnc_showSubtitle;
	}	],
	[58.0,	{}	],
	[60.0-1,	{
		private _markers_move4 = ["marker_move4_"] call BIS_fnc_getMarkers;
		for "_a" from 0 to 2 do {
			[AAS_markers_briefAlpha#_a, markerpos (_markers_move4#_a), 6] call BIS_fnc_moveMarker;
		};
		["marker_7", 1, 2] spawn BIS_fnc_cancelMarker;
		[groupId group I_hq, format ["All squads will continue advancing in their assigned corridors, clearing objectives until reaching the Limit of Advance, designated %1.", markerText "mrk_PLtext_5_0"]] spawn BIS_fnc_showSubtitle;
	}	],
	[67.0-1,	{
		for "_a" from 0 to 2 do {
			[AAS_markers_briefAlpha#_a,"ColorGrey"] spawn BIS_fnc_changeColorMarker;
		};
		[groupId group I_hq, format ["That's the end of the briefing. Move out and Godspeed."]] spawn BIS_fnc_showSubtitle;
	}	],
	[72.0,	{}	]
];

AAS_soundSourceBriefing = [I_hq, player] say3D "briefingVoiceover";
[_timeline, 0, nil, _hideMarkers, _showMarkers, "marker_briefing_AO", true, _fn_endCode] spawn BIS_fnc_animatedBriefing;

waitUntil { !(missionNamespace getVariable ["BIS_fnc_eventTimeline_playing",true]); };

AAS_animatedBriefingDone = true;
[] execVM "script\briefing.sqf";