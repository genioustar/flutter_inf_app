import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const ACCESS_TOKE_KEY = 'ACCESS_TOKEN';
const REFRESH_TOKEN_KEY = 'REFRESH_TOKEN';

// localhost for android emulator and ios simulator
const emulatorIp = '10.0.2.2:8099';
const simulatorIp = '127.0.0.1:8099';

// 모바일 디바이스에 따라서 다른 ip를 사용
final ip = Platform.isIOS ? simulatorIp : emulatorIp;

// 전역적으로 사용하는 secure storage 선언
const storage = FlutterSecureStorage();
