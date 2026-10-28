void Detour_Create() {
    GameData gameData = new GameData("source-tv-manager.games");

    StartRecording_Create(gameData);
    StopRecording_Create(gameData);

    delete gameData;
}

static void StartRecording_Create(GameData gameData) {
    Address address = gameData.GetMemSig("CHLTVDemoRecorder::StartRecording");
    DynamicDetour detour = DHookCreateDetour(address, CallConv_THISCALL, ReturnType_Void, ThisPointer_Ignore);

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
    Address address = gameData.GetMemSig("CHLTVDemoRecorder::StopRecording");
    DynamicDetour detour = DHookCreateDetour(address, CallConv_THISCALL, ReturnType_Void, ThisPointer_Ignore);

    detour.Enable(Hook_Post, OnStopRecording);

    delete detour;
}

static MRESReturn OnStopRecording() {
    PrintToServer("[Detour] OnStopRecording");

    return MRES_Ignored;
}
