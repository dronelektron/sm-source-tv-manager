#include <sourcemod>
#include <dhooks>

#include "modules/detour.sp"

public Plugin myinfo = {
    name = "SourceTV manager",
    author = "Dron-elektron",
    description = "Allows you to manage SourceTV",
    version = "0.1.0",
    url = "https://github.com/dronelektron/sm-source-tv-manager"
};

public void OnPluginStart() {
    Detour_Create();
}
