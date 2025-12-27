// ignore_for_file: file_names

import 'dart:developer';

import 'package:referral_app/content/PostOpInstructionsView.dart';
import 'package:referral_app/content/ReferralView.dart';

import 'NavBarPage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


/// My implementation of a go_router navigator by use of a singleton factory
class MyNavigator {

  //singleton pattern
  static final MyNavigator _instance = MyNavigator._internal();
  static MyNavigator get instance => _instance;
  factory MyNavigator() {
    return _instance;
  }

  // stucture branches -> individual pages
  // the shell manages the branches
  // the router manages the pages within the branches
  // must travel to the correct branch before the page
  // e.g. MyNavigator.shell.goBranch(1);
  // e.g. MyNavigator.router.go(MyNavigator.postOpInstructionsPath);
  static late StatefulNavigationShell _navigationShell;
  static StatefulNavigationShell get shell => _navigationShell;

  static late final GoRouter router;

  static final GlobalKey<NavigatorState> parentNavigatorKey =
      GlobalKey<NavigatorState>();

  static final GlobalKey<NavigatorState> referralKey =
      GlobalKey<NavigatorState>();

  static final GlobalKey<NavigatorState> postOpInstructionsKey =
      GlobalKey<NavigatorState>();

  static const String referralPath = '/';
  static const String postOpInstructionsPath = '/login';

  MyNavigator._internal() {
    final routes = [
      StatefulShellRoute.indexedStack(
        parentNavigatorKey: parentNavigatorKey,
        branches: [
          //login and default check
          StatefulShellBranch(
              navigatorKey: referralKey,
              initialLocation: referralPath,
              routes: [
                GoRoute(
                    path: referralPath,
                    pageBuilder: (context, GoRouterState state) {
                      return getPage(
                        child: const ReferralView(),
                        state: state,
                      );
                    }),
              ]),
          //content
          StatefulShellBranch(
              navigatorKey: postOpInstructionsKey,
              initialLocation: postOpInstructionsPath,
              routes: [
                GoRoute(
                    path: postOpInstructionsPath,
                    pageBuilder: (context, GoRouterState state) {
                      return getPage(
                        child: const PostOpInstructionsView(),
                        state: state,
                      );
                    }),
              ]),
        ],
        pageBuilder: (
          BuildContext context,
          GoRouterState state,
          StatefulNavigationShell navigationShell,
        ) {
          _navigationShell = navigationShell;
          return getPage(
            child: NavBarPage(child: navigationShell),
            state: state,
          );
        },
      )
    ];
    router = GoRouter(
      navigatorKey: parentNavigatorKey,
      initialLocation: referralPath,
      routes: routes,
    );
  }

  // helper function: 
  // The content in the content folder are not wrapped in a materialPage, so I do it here (expected by go_router)
  static Page getPage({
    required Widget child,
    required GoRouterState state,
  }) {
    return MaterialPage(
      key: state.pageKey,
      child: child,
    );
  }

  // automatic navigation based on user conditions, currently unused
  static Future<void> calculateNavigation() async {
    // log('nav calculation');
    // await Database().initRecords();
    // await UserDatabase().initUser();
    // UserState state = UserState();
    // bool loggedIn = state.loggedIn;
    // bool verified = state.verified;
    // log('logged in $loggedIn');
    // log('verified $verified');
    // if (loggedIn) {
    //   if (!verified) {
    //     log('part 1');
    //     MyNavigator.router.go(MyNavigator.verifyEmailPath);
    //   } else {
    //     log('part 2');
    //     MyNavigator.shell.goBranch(1);
    //     MyNavigator.router.go(MyNavigator.AIViewPath);
    //     log('part 3');
    //   }
    // } else {
    //   MyNavigator.shell.goBranch(0);
    //   MyNavigator.router.go(MyNavigator.loginPath);
    // }
  }
}