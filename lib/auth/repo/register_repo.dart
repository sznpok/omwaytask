import 'dart:developer';

import 'package:http/http.dart';
import 'package:omwaytech/utils/api.dart';
import 'package:omwaytech/utils/om_ways_repo.dart';
import 'package:omwaytech/utils/request_enum.dart';

class RegisterRepo {
  Future<bool> register(String userName, String email, String password) async {
    OmWaysRepo omWaysRepo = OmWaysRepo(Client());
    final repo = await omWaysRepo.request(
      requestType: RequestEnum.post,
      url: Api.registerApi,
      parameter: {"name": userName, "email": email, "password": password},
    );
    log(repo.statusCode.toString());
    try {
      if (repo.statusCode == 201) {
        log("success register");
        log(repo.body.toString());
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception("register Error $e");
    }
  }
}
