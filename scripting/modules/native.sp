void Native_Create() {
    CreateNative("SourceTV_IsRecording", IsRecording);
}

static any IsRecording(Handle plugin, int numParams) {
    return Recorder_IsActive();
}
