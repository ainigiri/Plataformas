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
  int val = 0;
  if (isConfiguring) {
    return;
  }

  if (data != null){
     String in = new String(data);
     if (in.charAt(0) != ' '){
       String sub_in = in.substring(0, in.length() - 2);
       val = Integer.valueOf(sub_in);
       print("Value in integer: ");
       print(val);
       println();
     }
     if(val == 123){
       btReceived = true;
     }
     else{
       btReceived = false;
     }
  }
  
  info = String.valueOf(val);
  print("Converted into string again: " + info);
}
