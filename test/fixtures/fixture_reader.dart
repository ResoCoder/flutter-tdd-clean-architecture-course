import 'dart:io';

String fixture(String name) => File('test/fixtures/$name').readAsStringSync();
