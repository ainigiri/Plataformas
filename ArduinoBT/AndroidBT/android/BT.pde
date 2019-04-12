// The following code is required to enable bluetooth at startup.
void onCreate(Bundle savedInstanceState)
{
  super.onCreate(savedInstanceState);
  bt = new KetaiBluetooth(this);//create the BtSerial object that will handle the connection
}

void onActivityResult(int requestCode, int resultCode, Intent data)
{
    bt.onActivityResult(requestCode, resultCode, data);
}//to show the discovered device

void onKetaiListSelection(KetaiList klist)
{
  String selection = klist.getSelection();            //select the device to connect
  bt.connectToDeviceByName(selection);        //connect to the device
  klist = null;                                                      //dispose of bluetooth list for now
}

//Call back method to manage data received
void onBluetoothDataEvent(String who, byte[] data)
{
  if (isConfiguring) return;      //received
  info += new String(data);
  if(info.length() > 150)             //clean the words on screen if string to long
  info = "";
}
