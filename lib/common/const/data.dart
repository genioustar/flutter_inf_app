import 'dart:io';

const ACCESS_TOKEN_KEY = 'ACCESS_TOKEN';
const REFRESH_TOKEN_KEY = 'REFRESH_TOKEN';

// localhost for android emulator and ios simulator
const emulatorIp = '10.0.2.2:8099';
const simulatorIp = '127.0.0.1:8099';

// 모바일 디바이스에 따라서 다른 ip를 사용
final ip = Platform.isIOS ? simulatorIp : emulatorIp;
