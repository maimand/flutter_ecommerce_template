import 'package:ecommerce_int2/utils/app_properties.dart';
import 'package:ecommerce_int2/data/models/user.model.dart';
import 'package:ecommerce_int2/data/repository/auth.repository.dart';
import 'package:ecommerce_int2/screens/auth/welcome_back_page.dart';
import 'package:ecommerce_int2/screens/main/main_page.dart';
import 'package:ecommerce_int2/utils/message_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthService extends GetxService {
  final AuthRepository repository;

  final store = GetStorage();

  UserModel? userModel;

  AuthService(this.repository);

  @override
  void onInit() {
    // login('manmaihuu@gmail.com', '123456A');
    getUserInfo();
    super.onInit();
  }


  void getUserInfo() async {
    try {
      final res = await repository.getUserInfo();
      userModel = res;
      store.write(user, userModel!.toJson());
      Navigator.of(Get.context!)
          .pushReplacement(MaterialPageRoute(builder: (_) => MainPage()));
    } catch (e) {
      Navigator.of(Get.context!).pushReplacement(
          MaterialPageRoute(builder: (_) => WelcomeBackPage()));
    }
  }

  Future<void> login(String username, String password) async {
    try {
      MessageDialog.showLoading();
      final res = await repository.login(username, password);
      MessageDialog.hideLoading();
      await setAccessToken(res.token);
      getUserInfo();
      Navigator.of(Get.context!)
          .pushReplacement(MaterialPageRoute(builder: (_) => MainPage()));
    } catch (e) {
      MessageDialog.hideLoading();
      MessageDialog.showToast("Email and password wrong");
      print(e);
    }
  }

  Future<void> setAccessToken(String token) async {
    await store.write(accessToken, token);
  }

  String getAccessToken() {
    final String? token = store.read(accessToken);
    if (token == null) throw Exception("Access token not available");
    return token;
  }

  Future<void> register(String username, String password, String firstName,
      String lastName) async {
    try {
      MessageDialog.showLoading();
      repository.register(username, password, firstName, lastName);
      MessageDialog.hideLoading();
      MessageDialog.showToast('Successfully created new account');
      Get.offAll(() => WelcomeBackPage());
    } on Exception catch (e) {
      MessageDialog.showLoading();

      Navigator.of(Get.context!).pushReplacement(
          MaterialPageRoute(builder: (_) => WelcomeBackPage()));
    }
  }

  Future<void> forgetPassword(String email) async {
    try {
      repository.forgotPassword(email);
      MessageDialog.showToast('Please check your email to reset password');

    } finally {
      Navigator.of(Get.context!).pushReplacement(
          MaterialPageRoute(builder: (_) => WelcomeBackPage()));
    }
  }

  void logout() {
    store.remove(accessToken);
    Navigator.of(Get.context!)
        .pushReplacement(MaterialPageRoute(builder: (_) => WelcomeBackPage()));
  }

  void resetPassword(String password) {
    try {
      repository.resetPassword(password);
    } catch (e) {}
  }
}
