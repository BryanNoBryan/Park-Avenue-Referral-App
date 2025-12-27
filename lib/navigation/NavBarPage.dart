// ignore_for_file: file_names
import 'package:flutter_svg/svg.dart';

import 'MyNavigator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavBarPage extends StatefulWidget {
  const NavBarPage({super.key, required this.child});

  final StatefulNavigationShell child;

  @override
  State<NavBarPage> createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavBarPage> {
  int idx = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 120,
        leadingWidth: 170,
        leading: Container(
          margin: EdgeInsets.all(2),
          // padding: EdgeInsets.all(8),
          child: SvgPicture.asset('assets/svg/Park_Ave_OMS_logo.svg', semanticsLabel: 'Park Avenue OMS',  fit: BoxFit.contain,),
          ),
        title: Align(
            alignment: Alignment.centerRight,
            child: Text('Dr. James Choi', style: TextStyle(fontFamily: 'Montserrat-Medium'),),
          ),
      ),
      body: SafeArea(
        child: widget.child,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: idx,
        onTap: (index) {
          idx = index;
          switch (index) {
            case 0:
              MyNavigator.shell.goBranch(0);
              break;
            case 1:
              MyNavigator.shell.goBranch(1);
              break;
          }
          setState(() {});
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: 'Referral',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            label: 'PostOp Instructions',
          ),
        ],
      ),
    );
  }
}