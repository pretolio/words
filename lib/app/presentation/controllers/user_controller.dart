


import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/datasources/remote/fireauth_sources.dart';
import 'providers.dart';

class UserController extends DisposableProvider{
  final FireAuthSources _sources = FireAuthSources();
  UserCredential? user;
  String uEmail = '';
  String upass = '';

  UserController(){
    _autoSignIn();
  }

  Future<void> signIn(String email, String password) async {
    final result = await _sources.signIn(email, password);
    user = result;
    uEmail = email;
    upass = password;
    _saveLogin();
    notifyListeners();
  }

  Future<void> createUser(String email, String password) async {
    final result = await _sources.createUser(email, password);
    user = result;
    notifyListeners();
  }

  Future<void> sendPassword(String email) async {
    await _sources.sendPassword(email);
  }

  Future<void> signOut(BuildContext context) async {
    try{
      await _sources.signOut();
      final pref = await SharedPreferences.getInstance();
      pref.clear();
      Providers.disposeAllDisposableProviders(context);
    }catch(e){
      print(e);
    }
  }

  Future<void> _saveLogin() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString("email", uEmail,  );
    await pref.setString("pass", upass,  );
  }

  Future<void> _loadLogin() async {
    final pref = await SharedPreferences.getInstance();
    uEmail = (pref.getString("email")) ?? '';
    upass = (pref.getString("pass")) ?? '';
  }

  Future<void> _autoSignIn() async {
    await _loadLogin();

    if (uEmail != '' && upass != '') {
      try {
        await signIn(uEmail, upass);
      } catch (ex) {
        debugPrint(ex.toString());
      }
    }
  }

  @override
  void disposeValues() {
    user = null;
    notifyListeners();
    uEmail = '';
    upass = '';
  }

}