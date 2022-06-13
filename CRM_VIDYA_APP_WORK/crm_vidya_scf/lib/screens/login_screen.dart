import 'package:crm_vidya_scf/services/servicehandle.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dashboard.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  String result = '';
  String name = '';
  String user = '';

  bool _isChecked = false;

  void _handleRemeberme(bool value) {
    _isChecked = value;
    SharedPreferences.getInstance().then(
      (prefs) {
        prefs.setBool("remember_me", value);
        prefs.setString('userid', username.text.trim());
        prefs.setString('password', password.text.trim());
      },
    );
    setState(() {
      _isChecked = value;
    });
  }

  void _loadUserIDPassword() async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      String userid = _prefs.getString("userid")!;
      String local_password = _prefs.getString("password")!;
      var _remeberMe = _prefs.getBool("remember_me") ?? false;

      if (_remeberMe) {
        setState(() {
          _isChecked = true;
        });
        username.text = userid;
        password.text = local_password;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _loadUserIDPassword();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: size.width,
              height: size.height,
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                padding: EdgeInsets.zero,
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      width: size.width,
                      height: size.height * 0.2,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        color: Color(0xff0274BB),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.elliptical(
                            size.height * 0.9,
                            size.height * 0.5,
                          ),
                          bottomRight: Radius.elliptical(
                            size.height * 0.9,
                            size.height * 0.5,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                    Text(
                      "Welcome To Sonai Cattle Feed CRM",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xff0274BB),
                        fontWeight: FontWeight.w600,
                        fontSize: size.height * 0.028,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Text(
                      "powered by CRM Vidya, Ver. 2.1.5",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: size.height * 0.011,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.07,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: username,
                        decoration: const InputDecoration(
                            labelText: "Login ID",
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.email)),
                      ),
                    ),
                    SizedBox(height: size.height * 0.025),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        obscureText: true,
                        controller: password,
                        decoration: const InputDecoration(
                            labelText: "Password",
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.password)),
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                            value: _isChecked,
                            onChanged: (value) => _handleRemeberme(value!)),
                        const Text('Remember Me'),
                      ],
                    ),
                    // SizedBox(height: size.height * 0.02),
                    MaterialButton(
                      minWidth: size.width * 0.85,
                      color: Color(0xffFD8701),
                      textColor: Colors.white,
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();

                        ServerHandler()
                            .getLogin(
                                username.text.trim(), password.text.trim())
                            .then(
                              (value) => value == "Incorrect"
                                  ? null
                                  : {
                                      prefs
                                          .setString(
                                              "username", value["username"])
                                          .then((v) => prefs.setString(
                                              "userid", value["id"]))
                                          .then((v) => prefs.setString(
                                              "password", value["password"]))
                                          .then((v) => prefs.setString(
                                              "fullname", value["fullname"]))
                                          .then(
                                            (v) => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => Dashboard(
                                                  currentUser: value,
                                                ),
                                              ),
                                            ),
                                          ),
                                    },
                            );
                      },
                      height: size.height * 0.06,
                      child: Text(
                        "Sign In",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: size.height * 0.022,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0.0,
              right: 0.0,
              top: size.height * 0.11,
              child: Container(
                padding: EdgeInsets.all(size.height * 0.02),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 1.5,
                      spreadRadius: 0.5,
                      color: Colors.grey.shade300,
                    ),
                  ],
                ),
                child: Image.asset(
                  'asset/Icon.png',
                  height: size.height * 0.12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
