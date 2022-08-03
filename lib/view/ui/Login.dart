import 'package:flutter/material.dart';
import 'package:thingstodoapp/view/ui/homePage.dart';
import 'package:thingstodoapp/view/shared/textfield_container.dart';
import 'package:url_launcher/url_launcher.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.network(
                "https://firebasestorage.googleapis.com/v0/b/sadasd-241f5.appspot.com/o/Logo.png?alt=media&token=a86733d1-4115-48d4-81c8-4e6c66dc1998",
                height: 200,
                width: 200,
              ),
            ),
            Form(
              key: _formkey,
              child: Column(
                children: [
                  TextFieldContainer(
                      width: 0.8,
                      controller: _userNameController,
                      hintText: "Username",
                      formkey: _formkey,
                      presuffixIcon: const Icon(Icons.person),
                      errorMsg: "",
                      keyboardType: TextInputType.name,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return '';
                        }

                        return null;
                      }),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFieldContainer(
                      width: 0.8,
                      controller: _passwordController,
                      hintText: "Password",
                      formkey: _formkey,
                      presuffixIcon: const Icon(Icons.lock),
                      errorMsg: "",
                      obscureText: true,
                      maxLines: 1,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return '';
                        }
                        if (!RegExp("^[0-9]").hasMatch(value)) {
                          return '';
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.84,
              child: Column(
                children: [
                  TextButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        if (_userNameController.text == "abdullatif2022" &&
                            _passwordController.text == "12580") {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Operation success",
                                style: TextStyle(fontFamily: "Almarai")),
                          ));
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()));
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Please enter right information",
                                style: TextStyle(fontFamily: "Almarai")),
                          ));
                        }
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("All fields are required",
                              style: TextStyle(fontFamily: "Almarai")),
                        ));
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: const Color(0XFF6035D0),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Center(
                            child: Text(
                          "LOGIN OR SIGNUP",
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(width: 120, child: const Divider()),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "OR",
                  style: TextStyle(color: Colors.grey[400]),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(width: 120, child: const Divider()),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: Image.network(
                      "https://firebasestorage.googleapis.com/v0/b/sadasd-241f5.appspot.com/o/Group%2010.png?alt=media&token=93a58bd7-dd52-40ca-b048-59e0b61e83e1",
                      height: 75,
                      width: 75,
                    ),
                    onTap: () {
                      launchUrl(Uri.parse("https://www.facebook.com/login/"));
                    },
                  ),
                  GestureDetector(
                    child: Image.network(
                      "https://firebasestorage.googleapis.com/v0/b/sadasd-241f5.appspot.com/o/Group%2011.png?alt=media&token=e586ca2f-76f4-4295-8278-127aa4dcd64b",
                      height: 75,
                      width: 75,
                    ),
                    onTap: () {
                      launchUrl(Uri.parse("https://twitter.com/i/flow/login"));
                    },
                  ),
                  GestureDetector(
                    child: Image.network(
                      "https://firebasestorage.googleapis.com/v0/b/sadasd-241f5.appspot.com/o/Group%2012.png?alt=media&token=b234d004-26eb-40ed-a54a-75f701d7a24c",
                      height: 75,
                      width: 75,
                    ),
                    onTap: () {
                      launchUrl(Uri.parse(
                          "https://accounts.google.com/signin/v2/identifier?flowName=GlifWebSignIn&flowEntry=ServiceLogin"));
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
