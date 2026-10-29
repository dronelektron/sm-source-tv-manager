static bool g_recording = false;

void Detour_Create() {
    GameData gameData = LoadGameData("source-tv-manager.games");

    Recorder_Create(gameData);
    Recorder_Status_Create(gameData);
    Recorder_DemoName_Create(gameData);
    Recorder_RecordingTime_Create(gameData);
    StartRecording_Create(gameData);
    StopRecording_Create(gameData);

    delete gameData;
}

static void Recorder_Create(GameData gameData) {
    Address address = GetFunctionAddress(gameData, "CHLTVDemoRecorder::CHLTVDemoRecorder");
    DynamicDetour detour = DHookCreateDetour(address, CallConv_THISCALL, ReturnType_Void, ThisPointer_Address);

    detour.Enable(Hook_Post, OnRecorder);

    delete detour;
}

static MRESReturn OnRecorder(Address pThis) {
    Recorder_Set(pThis);

    return MRES_Ignored;
}

static void Recorder_Status_Create(GameData gameData) {
    Address address = GetFieldOffset(gameData, "CHLTVDemoRecorder::m_bRecording");

    Recorder_Status_Set(address);
}

static void Recorder_DemoName_Create(GameData gameData) {
    Address address = GetFieldOffset(gameData, "CHLTVDemoRecorder::m_szDemoName");

    Recorder_DemoName_Set(address);
}

static void Recorder_RecordingTime_Create(GameData gameData) {
    Address address = GetFieldOffset(gameData, "CHLTVDemoRecorder::m_flRecordingTime");

    Recorder_RecordingTime_Set(address);
}

static void StartRecording_Create(GameData gameData) {
    Address address = GetFunctionAddress(gameData, "CHLTVDemoRecorder::StartRecording");
    DynamicDetour detour = DHookCreateDetour(address, CallConv_THISCALL, ReturnType_Void, ThisPointer_Ignore);

    detour.AddParam(HookParamType_CharPtr);
    detour.AddParam(HookParamType_Bool);
    detour.Enable(Hook_Post, OnStartRecording);

    delete detour;
}

static MRESReturn OnStartRecording(DHookParam params) {
    if (Recorder_IsActive()) {
        char name[PLATFORM_MAX_PATH];

        params.GetString(1, name, sizeof(name));

        Forward_OnStartRecording(name);
    }

    return MRES_Ignored;
}

static void StopRecording_Create(GameData gameData) {
    Address address = GetFunctionAddress(gameData, "CHLTVDemoRecorder::StopRecording");
    DynamicDetour detour = DHookCreateDetour(address, CallConv_THISCALL, ReturnType_Void, ThisPointer_Ignore);

    detour.Enable(Hook_Pre, OnStopRecording_Pre);
    detour.Enable(Hook_Post, OnStopRecording_Post);

    delete detour;
}

static MRESReturn OnStopRecording_Pre() {
    g_recording = Recorder_IsActive();

    return MRES_Ignored;
}

static MRESReturn OnStopRecording_Post() {
    if (g_recording) {
        char name[PLATFORM_MAX_PATH];

        Recorder_GetDemoName(name);

        float recordingTime = Recorder_GetRecordingTime();

        Forward_OnStopRecording(name, recordingTime);
    }

    return MRES_Ignored;
}

static GameData LoadGameData(const char[] name) {
    GameData gameData = new GameData(name);

    if (gameData == null) {
        SetFailState("Failed to load '%s' game data", name);
    }

    return gameData;
}

static Address GetFunctionAddress(GameData gameData, const char[] name) {
    Address address = gameData.GetMemSig(name);

    if (address == Address_Null) {
        SetFailState("Failed to get address of '%s' function", name);
    }

    return address;
}

static Address GetFieldOffset(GameData gameData, const char[] name) {
    int offset = gameData.GetOffset(name);

    if (offset == -1) {
        SetFailState("Failed to get offset of '%s' field", name);
    }

    return view_as<Address>(offset);
}
