import 'dart:io';

import 'dart:typed_data';

import 'package:linux_can/linux_can.dart';



void main() async {

 final linuxcan = LinuxCan.instance;

 // Assuming that the devices property contains a list of devices

  var devices = linuxcan.devices;

  devices.forEach((device) {

    print('Device Name: ${device.networkInterface.name}');

    print('Status: ${device.isUp}');

    // You can print other relevant information about the device if needed

  });


// Find the CAN interface with name `myvcan0`.

final device = linuxcan.devices.singleWhere((device) => device.networkInterface.name == 'myvcan0');


// Actually open the device, so we can send/receive frames.

final socket = device.open();


// Send some example CAN frame.

socket.send(CanFrame.standard(id: 0x123, data: [0x01, 0x02, 0x03, 0x04]));


// Listen on a Stream of CAN frames

await for (final frame in socket.receive()) {

  print('received frame $frame');

  //break;

}

print('closed');

// Close the socket to release all resources.

await socket.close();

}





