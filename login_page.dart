
import 'package:flutter/material.dart';
import 'package:flutter_project_4/models/calendar.dart';
import 'package:flutter_project_4/models/sign_up_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
   static const Color primaryColor = Colors.black26;

 String _username = '';
  String _password = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

   // Create storage
  final _storage = const FlutterSecureStorage();

  final TextEditingController _usernameController =
      TextEditingController(text: "");
  final TextEditingController _passwordController =
      TextEditingController(text: "");

  bool passwordHidden = true;
  bool _savePassword = true;

  // Read values
  Future<void> _readFromStorage() async {
    _usernameController.text = await _storage.read(key: "KEY_USERNAME") ?? '';
    _passwordController.text = await _storage.read(key: "KEY_PASSWORD") ?? '';
  }

  _onFormSubmit() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (_savePassword) {
        // Write values
        await _storage.write(key: "KEY_USERNAME", value: _usernameController.text);
        await _storage.write(key: "KEY_PASSWORD", value: _passwordController.text);
 
  
       
      }
      
    }
  }

  
 void _LogIn() {
    final bool? isValid = _formKey.currentState?.validate();
    if (isValid == true) {
      debugPrint('Everything looks good!');
      
      debugPrint(_username);
      debugPrint(_password);
     
       Navigator.push(
                               this.context,
                              MaterialPageRoute(
                                 builder: (context) => Calender()),
                           );
     
    }
  }


  _onSignUp() {
    Navigator.push(
                               this.context,
                              MaterialPageRoute(
                                 builder: (context) => SignUpPage()),
                           );

  }

  @override
  void initState() {
    super.initState();
    _readFromStorage();
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
        backgroundColor: Colors.black26,
      ),
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          padding: EdgeInsets.all(size.width - size.width * .85),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              
              
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Username",
                        labelStyle: const TextStyle(color: primaryColor),
                        focusedBorder: UnderlineInputBorder(borderRadius: BorderRadius.circular(0), borderSide: const BorderSide(color: primaryColor, width: 2),),
                      ),
                      controller: _usernameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Required field';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      textCapitalization: TextCapitalization.none,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: size.height * .02,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.done,
                      validator: (value) {
                        return value!.isEmpty ? "Required field" : null;
                      },
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: const TextStyle(color: Color(0xFF95989A)),
                        focusedBorder: UnderlineInputBorder(borderRadius: BorderRadius.circular(0), borderSide: const BorderSide(color: primaryColor, width: 2),),
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              passwordHidden = !passwordHidden;
                            });
                          },
                          child: Icon(
                            passwordHidden
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: const Color(0xff747881),
                            size: 23,
                          ),
                        ),
                      ),
                      controller: _passwordController,
                      obscureText: passwordHidden,
                      enableSuggestions: false,
                      toolbarOptions: const ToolbarOptions(
                        copy: false,
                        paste: false,
                        cut: false,
                        selectAll: false,
                        //by default all are disabled 'false'
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * .045,
              ),
              CheckboxListTile(
                value: _savePassword,
                onChanged: (bool? newValue) {
                  setState(() {
                    _savePassword = newValue!;
                  });
                },
                title: const Text("Remember me"),
                activeColor: primaryColor,
              ),
              SizedBox(
                height: size.height * .05,
              ),
              SizedBox(
                width: size.width,
                child: ElevatedButton(
                  onPressed: _LogIn,
                  child: const Text("Login"),
                  style: ElevatedButton.styleFrom(
                    primary: primaryColor,
                    textStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)
                  ),
                ),
              ),
              SizedBox(
                height: size.height * .015,
              ),
              
          
              const Center(
                child: Text(
                  "You don't have an account?",
                  style: TextStyle(fontSize: 14, ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: size.height * .01,
              ),
              Center(
                child: InkWell(
                  onTap: _onSignUp,
                  child: const Text(
                    "Sign Up now to get access.",
                    style: TextStyle( color: primaryColor,fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}