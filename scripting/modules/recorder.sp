static Address g_recorder = Address_Null;
static Address g_status = Address_Null;
static Address g_demoName = Address_Null;

void Recorder_Set(Address address) {
    g_recorder = address;
}

void Recorder_Status_Set(Address address) {
    g_status = address;
}

void Recorder_DemoName_Set(Address address) {
    g_demoName = address;
}

bool Recorder_IsActive() {
    Address address = g_recorder + g_status;

    return LoadFromAddress(address, NumberType_Int8);
}

void Recorder_GetDemoName(char[] name) {
    Address address = g_recorder + g_demoName;

    ReadStringFromAddress(address, name, PLATFORM_MAX_PATH);
}

static void ReadStringFromAddress(Address address, char[] buffer, int size) {
    int i = 0;

    while (i < size - 1) {
        char ch = LoadFromAddress(address + view_as<Address>(i), NumberType_Int8);

        if (ch == 0) {
            break;
        }

        buffer[i] = ch;
        i++;
    }

    buffer[i] = '\0';
}
