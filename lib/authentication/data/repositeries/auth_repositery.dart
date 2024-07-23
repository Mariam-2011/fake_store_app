import 'package:fake_store/authentication/data/models/user_model.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepositery {
  static late final SharedPreferences sp;

// initalization ll sharedprefrencess
  static init() async {
    sp = await SharedPreferences.getInstance();
  }

//function to save user data m no3 usermodel
  static savUserData(UserModel userdata) {
    // key ana aly bdhaloh wl value mn no3 usermodel aly hwa el userdata
    sp.setString('username', userdata.username);
    sp.setString('email', userdata.email);
    sp.setString('phone', userdata.phone);
  }

  static bool checkData(UserModel userdata) {
    var emailCheck = sp.getString('email');
    var usernameCheck = sp.getString('username');
    if (emailCheck == userdata.email || usernameCheck == userdata.username) {
      return true;
    } else {
      return false;
    }
  }

// login
  static Login() {}
  //logout
  static logout() {}
// check islogin
  static isLogin() {}

//get user data mn el usermodel
  static UserModel? getUserData() {
    if (sp.getString('email')! == null) {
      return null;
    }
    return UserModel(
        username: sp.getString('username')!,
        email: sp.getString('email')!,
        phone: sp.getString('phone')!);
  }

//to delete account
  static deleteAccount() {
    sp.clear();
  }

  static saveImageProfile(String img) {
    //save image in sp
    sp.setString('profile', img);
  }

  // check imageprofile
  static String? getImageProfile() {
    var imageCheck = sp.getString('profile');
    return imageCheck;
  }

  //cover photo
  static saveCoverPhoto(String cover) {
    sp.setString('coverPhoto', cover);
  }

//check coverphoto
  static String? getCoverPhoto() {
    var coverCheck = sp.getString('coverPhoto');
    return coverCheck;
  }
}
