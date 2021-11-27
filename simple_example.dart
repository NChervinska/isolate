import 'dart:isolate';

void printIsolate(String message) {
  print('the message is :${message}');
}

void main() {
  Isolate.spawn(printIsolate, 'Hello!!');
  Isolate.spawn(printIsolate, 'Whats up!!');
  Isolate.spawn(printIsolate, 'Welcome!!');

  print('execution from main1');
  print('execution from main2');
  print('execution from main3');
}
