import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const FlutterSecureStorage _localStorage = FlutterSecureStorage();

Future<String?> readTokenAccess() async {
  return await _localStorage.read(key: "token");
}

writeTokenAccess(data) async {
  return await _localStorage.write(key: "token", value: data);
}

deleteTokenAccess() async {
  return await _localStorage.delete(key: "token");
}

Future<String?> readID() async {
  return await _localStorage.read(key: "author_id");
}

writeID(data) async {
  return await _localStorage.write(key: "author_id", value: data);
}

deleteID() async {
  return await _localStorage.delete(key: "author_id");
}
