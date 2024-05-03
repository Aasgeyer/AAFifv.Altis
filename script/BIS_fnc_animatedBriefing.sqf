scriptname "BIS_fnc_animatedBriefing";
#include "\a3\Functions_F_Tacops\Systems\fn_animatedScreen.inc"
/*
    Author: Zozo, modified by Riccardo Argiolas

    Description:
    Plays the Animated Briefings. Basically, it is a wrap function for the eventTimeline function.

     Parameters:
     Select 0 - 2D ARRAY : timeline in format [ [1.0, {code} ], [2.0, {code} ], [2.3, {code} ], [4.7, {code} ] ]
    Select 1 - NUMBER: index of the event to play
    Select 2 (OPTIONAL)- ARRAY: markers to hide before the briefing starts and when the briefing has been completed
    Select 3 (OPTIONAL)- ARRAY: markers to show after the briefing has been completed
    Select 4 (OPTIONAL)- STRING: marker to zoom to instantly when the briefing is over
    Select 5 (OPTIONAL)- BOOL: will the player have the ability to close the map at the end of the briefing?
    Select 6 (OPTIONAL)- CODE: code that will be executed when the briefing is over or is skipped

    Returns:
    none
*/

params
[
     [ "_timeline", [], [ [] ] ],
    [ "_pointer", 0, [ 0 ] ],
    [ "_music", "", [""] ],
    [ "_hideMarkers", [], [ [] ] ],
    [ "_showMarkers", [], [ [] ] ],
    [ "_endPosition","",[""]],
    [ "_canCloseMap",true,[true]],
    [ "_endUserCode",{},[{}]]
];

titlecut ["","BLACK FADED"];
Sleep 1.5;

//open map and force it open
openMap [true, true];

//disable saving (we don't know what might happen)
enableSaving [false, false];

//enable zoom locking
missionNamespace setVariable ["BIS_lockZoomAllowed", true]; 

private _hideAllMarkers = false;

if (count _hideMarkers > 0) then
{
    //if user specified all map markers, then set this variable to true so that we're gonna find all map markers again when we have to delete them
    //this is to make sure that new markers that are added during the briefing will also be deleted
    if(_hideMarkers isEqualTo allMapMarkers) then
    {
        _hideAllMarkers = true;
    };

    [_hideMarkers, 0] call BIS_fnc_hideMarkerArray;
};
titlecut ["","BLACK IN",3];
BIS_fnc_AnimatedBriefing_speaker1 = "Sign_Arrow_Large_Pink_F" createVehicle [0,0,0];
BIS_fnc_AnimatedBriefing_speaker2 = "Sign_Arrow_Large_Green_F" createVehicle [0,0,0];

missionNamespace setVariable ["BIS_AnimatedBriefingparams", [_hideMarkers,_showMarkers,_endPosition,_hideAllMarkers] ]; //parameters for the code which is passed as parameter and will be executed after the eventTimeline is done

//list of spawned scripts that should be terminated when the timeline is over
//(ideally, scripts that interfere with the showing/hiding of markers at the end of briefings)
missionNamespace setVariable ["BIS_fnc_eventTimeline_array", []];

private _codeInterrupt =
{
    //disable zooming on code end (in case we skip the briefing while a zoom animation has been commited)
    disableSerialization;
     ctrlMapAnimClear ((findDisplay getNumber (configFile >> "RscDisplayMainMap" >> "idd")) displayCtrl (getNumber (configfile >> "RscDisplayMainMap" >> "controlsBackground" >> "CA_Map" >> "idc")));
};

private _codeEnd =
{
    //stop spawned scripts that should be terminated when the timeline is over
    //(ideally, scripts that interfere with the showing/hiding of markers at the end of briefings)
    private _tempArray = missionNamespace getVariable "BIS_fnc_eventTimeline_array";

    {
        terminate _x;
    } 
    forEach _tempArray;
    missionNamespace setVariable ["BIS_fnc_eventTimeline_array", nil];


    
    private _hideMarkers = (missionNamespace getVariable "BIS_AnimatedBriefingparams") select 0;
    private _showMarkers = (missionNamespace getVariable "BIS_AnimatedBriefingparams") select 1;
    private _endPosition = (missionNamespace getVariable "BIS_AnimatedBriefingparams") select 2;
    private _hideAllMarkers = (missionNamespace getVariable "BIS_AnimatedBriefingparams") select 3;

    {deleteVehicle _x} forEach [BIS_fnc_AnimatedBriefing_speaker1, BIS_fnc_AnimatedBriefing_speaker2];

    //if an end position marker has been defined, zoom to it
    if(_endPosition != "") then
    {
        [markerSize _endPosition, markerpos _endPosition, 0] spawn BIS_fnc_zoomOnArea;
    };

    //show and hide markers if they have been passed as parameters
    if (count _showMarkers > 0) then
    {
        [_showMarkers, 0] call BIS_fnc_showMarkerArray;
    };

    //if the user passed all markers then re-get all the map markers to make sure we also delete new ones
    if(_hideAllMarkers) then
    {
        _hideMarkers = allMapMarkers;
    };

    _arrayToHide = _hideMarkers - _showMarkers;
    if (count _arrayToHide > 0) then
    {
        [_arrayToHide, 0] call BIS_fnc_hideMarkerArray;
    };

    missionNamespace setVariable ["BIS_AnimatedBriefingparams", nil];       //deinitialize helper variables

    //remove the hold key handlers and text
    [ "remove" ] spawn BIS_fnc_holdKey;    

    //make sure zoomOnArea scripts cannot lock the zoom from now on
    missionNamespace setVariable ["BIS_lockZoomAllowed", false];
    //make sure zoom is unlocked and you can move freely around the map (needed becaise if endPosition is Nil, nothing unlocks the zoom)
    [] call BIS_fnc_zoomUnlock;

    //re-enable saving (it was disabled at start of AnimatedBriefing script)
    enableSaving true; 

    //destroy previous animated screen, if any
    //this destroys the layer/controls on which the "press space to skip" text is stored
    #include "\a3\Functions_F_Tacops\Systems\fn_animatedScreen.inc"
    [MODE_DESTROY] call bis_fnc_animatedScreen;
};

//extra code that allows player to close the map
private _codeEndCanClose =
{
    //Check if the player wants to close the map (by either pressing the keybind for "close map" or by pressing ESC)
    //event handler that checks if ESC is pressed
    missionNamespace setVariable 
    [
        "BIS_unforceMapEH",
        (findDisplay 12) displayAddEventHandler    
        [
            "KeyDown",    
            {
                // check if we pressed ESC
                if (_this select 1 == 1) then
                {
                    //close the map
                    openMap [false, false];

                    //make sure zoom is unlocked
                    [] call BIS_fnc_zoomUnlock;

                    //destroy this event handler
                    (findDisplay 12) displayRemoveEventHandler ["KeyDown", missionNamespace getVariable "BIS_unforceMapEH"];

                    //terminate the script checking the "close map" keybind, if it exists
                    _scriptHandle = missionNamespace setVariable ["BIS_unforceMapSCRIPT", nil];

                    if( !isNil{_scriptHandle} ) then
                    {
                        terminate _scriptHandle;
                    };
                };
            }
        ]
    ];

    //script waiting for "close map" keybind to be pressed
    missionNamespace setVariable 
    [
        "BIS_unforceMapSCRIPT",
        [] spawn 
        {
            //wait until it is pressed
            waitUntil {inputAction "hideMap" > 0};

            //close the map
            openMap [false, false];

            //make sure zoom is unlocked
            [] call BIS_fnc_zoomUnlock;

            //destroy the even handler checking for ESC, if it exists
            _ehHandle = missionNamespace getVariable "BIS_unforceMapEH";
            
            if( !isNil{_ehHandle} ) then
            {
                (findDisplay 12) displayRemoveEventHandler ["KeyDown", _ehHandle];
            };
        }
    ];
};

if(_canCloseMap) then
{
    [ _timeline, _pointer, _music, _codeInterrupt, [_codeEnd, _codeEndCanClose, _endUserCode] ] spawn BIS_fnc_eventTimeline;
}
else
{
    [ _timeline, _pointer, _music, _codeInterrupt, [_codeEnd, _endUserCode] ] spawn BIS_fnc_eventTimeline;
};

//[(findDisplay 12), 57, 2, { missionNamespace setVariable ["BIS_fnc_eventTimeline_play", false] }] call BIS_fnc_holdKey;

//
// The following section is to use warka's animatedScreen functions to show the "press space to skip" text so that it it consistent to what is shown in the animated openings
//

//setup new animated screen framework
[MODE_INIT,[0,0,1],1.05] call bis_fnc_animatedScreen;

//this is needed because initializing the animatedScreen makes everything black
LAYER_BACKGROUND cutText ["","BLACK OUT",10e10];

//create the overlay control
private _ctrlOverlay = [MODE_OVERLAY_CREATE,0," ",[0.5,1],ALIGN_BOTTOM,nil,1,2,1,"PuristaBold"] call bis_fnc_animatedScreen;

waitUntil{time > 1};

//add the hold key feature with the previously created text overlay control
[(findDisplay 12), 57, 2, { missionNamespace setVariable ["BIS_fnc_eventTimeline_play", false] }, _ctrlOverlay] call BIS_fnc_holdKey;