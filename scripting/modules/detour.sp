void Detour_Create() {
    GameData gameData = new GameData("source-tv-manager.games");

    StartRecording_Create(gameData);
    StopRecording_Create(gameData);

    delete gameData;
}

static void StartRecording_Create(GameData gameData) {
    DynamicDetour detour = DHookCreateDetour(Address_Null, CallConv_THISCALL, ReturnType_Void, ThisPointer_Ignore);

    detour.SetFromConf(gameData, SDKConf_Signature, "CHLTVDemoRecorder::StartRecording");
    detour.AddParam(HookParamType_CharPtr);
    detour.AddParam(HookParamType_Bool);
    detour.Enable(Hook_Post, OnStartRecording);

    delete detour;
}

static MRESReturn OnStartRecording() {
    PrintToServer("[Detour] OnStartRecording");

    return MRES_Ignored;
}

static void StopRecording_Create(GameData gameData) {
    DynamicDetour detour = DHookCreateDetour(Address_Null, CallConv_THISCALL, ReturnType_Void, ThisPointer_Ignore);

    detour.SetFromConf(gameData, SDKConf_Signature, "CHLTVDemoRecorder::StopRecording");
    detour.Enable(Hook_Post, OnStopRecording);

    delete detour;
}

static MRESReturn OnStopRecording() {
    PrintToServer("[Detour] OnStopRecording");

    return MRES_Ignored;
}
