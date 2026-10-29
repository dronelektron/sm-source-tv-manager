#if defined _source_tv_manager_api_included
 #endinput
#endif
#define _source_tv_manager_api_included

forward void SourceTV_OnStartRecording(const char[] name);

forward void SourceTV_OnStopRecording();

native bool SourceTV_IsRecording();
