import 'package:flutter/material.dart';
import 'package:flutter_project_4/models/calendar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // Define a key to access the form

  String _userEmail = '';
  String _userName = '';
  String _password = '';
  String _confirmPassword = '';
  String _phoneNumber='';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

   // Create storage
  final _storage = const FlutterSecureStorage();

final TextEditingController _userEmailController =
      TextEditingController(text: "");
  final TextEditingController _usernameController =
      TextEditingController(text: "");
  final TextEditingController _passwordController =
      TextEditingController(text: "");
      final TextEditingController _confirmPasswordController =
      TextEditingController(text: "");
  final TextEditingController _phoneNumberController =
      TextEditingController(text: "");

  bool passwordHidden = true;
  bool _savePassword = true;

  // Read values
  Future<void> _readFromStorage() async {
   _userEmailController.text = await _storage.read(key: "KEY_USEREMAIL") ?? '';
    _usernameController.text = await _storage.read(key: "KEY_USERNAME") ?? '';
    _passwordController.text = await _storage.read(key: "KEY_PASSWORD") ?? '';
    _confirmPasswordController.text = await _storage.read(key: "KEY_CONFIRMPASSWORD") ?? '';
    _phoneNumberController.text = await _storage.read(key: "KEY_PHONENUMBER") ?? '';
    
  }

  _onFormSubmit() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (_savePassword) {
        // Write values
        await _storage.write(key: "KEY_USEREMAIL", value: _userEmailController.text);
        await _storage.write(key: "KEY_USERNAME", value: _usernameController.text);
        await _storage.write(key: "KEY_PASSWORD", value: _passwordController.text);
        await _storage.write(key: "KEY_CONFIRMPASSWORD", value: _confirmPasswordController.text);
        await _storage.write(key: "KEY_PHONENUMBER", value: _phoneNumberController.text);
       
      }
    }
  }


  

  @override
  void initState() {
    super.initState();
    _readFromStorage();
  }

  @override
  void dispose() {
    super.dispose();
    _userEmailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneNumberController.dispose();
  }




  // This function is triggered when the user press the "Sign Up" button
  void _SignUp() {
    final bool? isValid = _formKey.currentState?.validate();
    if (isValid == true) {
      debugPrint('Everything looks good!');
      debugPrint(_userEmail);
      debugPrint(_userName);
      debugPrint(_password);
      debugPrint(_confirmPassword);
      debugPrint(_phoneNumber);
       Navigator.push(
                               this.context,
                              MaterialPageRoute(
                                 builder: (context) => Calender()),
                           );
     
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Sign Up',
        style: TextStyle(color: Colors.white54),
        ),
        centerTitle: true,
        backgroundColor: Colors.black54,
      ),
      body: Container(
        color: Colors.white10,
        alignment: Alignment.center,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// Email
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Email'),
                      controller:_userEmailController ,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your email address';
                        }
                        // Check if the entered email has the right format
                        if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        // Return null if the entered email is valid
                        return null;
                      },
                      onChanged: (value) => _userEmail = value,
                    ),

                    /// username
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'Username'),
                          controller:_usernameController ,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'This field is required';
                        }
                        if (value.trim().length < 4) {
                          return 'Username must be at least 4 characters in length';
                        }
                        // Return null if the entered username is valid
                        return null;
                      },
                      onChanged: (value) => _userName = value,
                    ),

                    /// Password
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'Password'),
                          controller:_passwordController ,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'This field is required';
                        }
                        if (value.trim().length < 8) {
                          return 'Password must be at least 8 characters in length';
                        }
                        // Return null if the entered password is valid
                        return null;
                      },
                      onChanged: (value) => _password = value,
                    ),

                    /// Confirm Password
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Confirm Password'),
                      obscureText: true,
                      controller:_confirmPasswordController ,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }

                        if (value != _password) {
                          return 'Confimation password does not match the entered password';
                        }

                        return null;
                      },
                      onChanged: (value) => _confirmPassword = value,
                    ),
                    ///Phone number
                    
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'PhoneNumber'),
                          controller:_phoneNumberController ,
                      validator: (value) {
                        if (RegExp(r'^[6-9]\d{9}$').hasMatch(value!)) {
                        return 'Please enter valid phone number';
                      }
                      return null;
                      },
                      onChanged: (value) => _phoneNumber = value,
                    ),
                    const SizedBox(height: 20),

              CheckboxListTile(
                value: _savePassword,
                onChanged: (bool? newValue) {
                  setState(() {
                    _savePassword = newValue!;
                  });
                },
                title: const Text("Remember me"),
                activeColor: Colors.black26,
              ),
              SizedBox(
                height: 15,
              ),

                    Container(
                        alignment: Alignment.center,
                        child: OutlinedButton(
                        onPressed: _SignUp,
                            child: const Text('Sign Up',
                            style: TextStyle(color: Colors.black54),
                            )))
                  ],
                )),
          ),
        ),
      ),
    );
  }
}