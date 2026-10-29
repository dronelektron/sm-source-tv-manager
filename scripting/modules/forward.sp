static GlobalForward g_startRecording;
static GlobalForward g_stopRecording;

void Forward_Create() {
    g_startRecording = new GlobalForward("SourceTV_OnStartRecording", ET_Ignore, Param_String);
    g_stopRecording = new GlobalForward("SourceTV_OnStopRecording", ET_Ignore);
}

void Forward_OnStartRecording(const char[] name) {
    Call_StartForward(g_startRecording);
    Call_PushString(name);
    Call_Finish();
}

void Forward_OnStopRecording() {
    Call_StartForward(g_stopRecording);
    Call_Finish();
}
