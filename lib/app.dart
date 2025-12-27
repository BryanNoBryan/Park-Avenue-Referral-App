import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:referral_app/navigation/MyNavigator.dart';
import 'package:referral_app/providers/referralFormModel.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return ReferralFormModel();
          },
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: MyNavigator.router,
        title: 'Park Ave OMS',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.white, // base color
            primary: Colors.black,   // affects focused TextFormField, cursor, label
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.white, // bg color
            selectedItemColor: Colors.black, // selected icon/text
            unselectedItemColor: Colors.grey,
          ),
          scaffoldBackgroundColor: Colors.white,
          fontFamily: 'Montserrat',
        ),
      )
    );
  }
}
