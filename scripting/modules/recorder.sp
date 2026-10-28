static Address g_recorder = Address_Null;
static Address g_status = Address_Null;

void Recorder_Set(Address address) {
    g_recorder = address;
}

void Recorder_Status_Set(Address address) {
    g_status = address;
}

bool Recorder_IsActive() {
    Address address = g_recorder + g_status;

    return LoadFromAddress(address, NumberType_Int8);
}
