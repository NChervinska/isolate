import 'dart:async';
import 'dart:io';
import 'dart:isolate';

Isolate? isolate;

Future<void> start() async {
  ReceivePort receivePort = ReceivePort();
  isolate = await Isolate.spawn(runTimer, receivePort.sendPort);
  receivePort.listen((data) {
    print('Receiving: ' + data + ', ');
  });
}

void runTimer(sendPort) {
  int count = 0;
  Timer.periodic(new Duration(seconds: 1), (Timer t) {
    count++;
    String msg = 'notification ' + count.toString();
    print('Sending: ' + msg + ' -');
    sendPort.send(msg);
  });
}

void stop() {
  if (isolate != null) {
    print('Stopping Isolate.....');
    isolate?.kill(priority: Isolate.immediate);
    isolate = null;
  }
}

void main() async {
  print('Starting Isolate...');
  await start();
  print('Hit enter key to quit');
  await stdin.first;
  stop();
  print('Bye!');
  exit(0);
}
