import 'package:fake_store/authentication/data/models/user_model.dart';
import 'package:fake_store/authentication/data/repositeries/auth_repositery.dart';
import 'package:fake_store/authentication/presentation/screens/profile_screen.dart';
import 'package:fake_store/authentication/presentation/screens/signup_screen.dart';
import 'package:fake_store/data/repositeries/product_repositery.dart';
import 'package:fake_store/domain/product_cubit/products_cubit.dart';
import 'package:fake_store/presentation/screens/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {
  //bnady 3l function ely bt3ml initalization gwa el shared prefrences
  WidgetsFlutterBinding.ensureInitialized();
  AuthRepositery.init();

  await EasyLocalization.ensureInitialized();
  var user = AuthRepositery.getUserData();
  runApp(EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      path: 'assets/translations',
      child: MainApp(
        usersData: user,
      )));
}

class MainApp extends StatelessWidget {
  UserModel? usersData;
  MainApp({super.key, required this.usersData});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsCubit()..fetchData(),
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        // home: ProfileScreen(userData: UserModel(username: 'username', email: 'email', phone: '0111111'),),
        home: usersData == null
            ? SignupScreen()
            : ProductScreen(userData: usersData!),
        // : ProfileScreen(
        //     userData: userData!,
        //   ),
      ),
    );
  }
}
