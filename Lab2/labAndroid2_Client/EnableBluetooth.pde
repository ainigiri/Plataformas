void onCreate(Bundle savedInstanceState){
  super.onCreate(savedInstanceState);
  bt = new KetaiBluetooth(this);
}

void onActivityResult(int requestCode, int resultCode, Intent data){
  bt.onActivityResult(requestCode, resultCode, data);
}

String getBluetoothInformation(){
  String btInfo = "Server Running: ";
  btInfo += bt.isStarted() + "\n";
  btInfo += "Discovering: " + bt.isDiscovering() + "\n";
  btInfo += "Device Discoverable: " + bt.isDiscoverable() + "\n";
  btInfo +="\nConnected Devices: \n";
  
  ArrayList<String> devices = bt.getConnectedDeviceNames();
  for(String device:devices){
    btInfo += device+"\n";
  }
  return btInfo;
}

void onBluetoothDataEvent(String who, byte[] data){
  if(isConfiguring)
    return;
  
  KetaiOSCMessage m = new KetaiOSCMessage(data);
  if(m.isValid()){
    if(m.checkAddrPattern("/infoAuto/")){
      if(m.checkTypetag("i")){
        event = m.get(0).intValue();
      }
    }
  }
}
