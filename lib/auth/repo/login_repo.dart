import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:omwaytech/auth/model/login_model.dart';
import 'package:omwaytech/utils/api.dart';
import 'package:omwaytech/utils/om_ways_repo.dart';
import 'package:omwaytech/utils/request_enum.dart';

import '../../utils/custom_storage.dart';
import '../../utils/token.dart';

class LoginRepo {
  Future<bool> login(String userName, String email, String password) async {
    OmWaysRepo omWaysRepo = OmWaysRepo(Client());
    final repo = await omWaysRepo.request(
      requestType: RequestEnum.post,
      url: Api.loginApi,
      parameter: {"name": userName, "email": email, "password": password},
    );
    log(repo.statusCode.toString());
    try {
      if (repo.statusCode == 201) {
        LoginModel loginModel = LoginModel.fromJson(jsonDecode(repo.body));
        AccessToken.token = loginModel.token!;
        AccessToken.userId = loginModel.user!.id.toString();
        //AccessToken.token = jsonDecode(repo.body)["token"];
        writeTokenAccess(AccessToken.token);
        writeID(AccessToken.userId);
        log(repo.body.toString());
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception("Login Error $e");
    }
  }
}
