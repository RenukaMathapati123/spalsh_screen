import 'package:flutter/material.dart';
import 'package:flutter_project_4/models/login_page.dart';


class SpalshScreen extends StatefulWidget {
  const SpalshScreen({Key? key}) : super(key: key);

  @override
  State<SpalshScreen> createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {
 
  @override
  void initState(){
    super.initState();
    _navigatetohome();
  }
 
  _navigatetohome() async {
  await Future.delayed(Duration(milliseconds: 2000),(){});
   Navigator.push(
                              this.context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage(title: 'Login',)),
                            );
 }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Image.asset('logo.png'),
          ),
      ),
    );
  }
}