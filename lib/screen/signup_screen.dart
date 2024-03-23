import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/responsive/mobile_screen_layout.dart';
import 'package:instagram_clone/responsive/responsive_layout_screen.dart';
import 'package:instagram_clone/responsive/web_screen_layout.dart';
import 'package:instagram_clone/screen/login_screen.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/widgets/text_field_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  Uint8List? _image;
  bool isLoading = false;

  void selectImage() async {
    final Uint8List image = await pickImage(ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  void signUpUser() async {
    setState(() {
      isLoading = true;
    });

    final String res = await AuthMethods().signup(
      username: _userNameController.text,
      email: _emailController.text,
      password: _passController.text,
      bio: _bioController.text,
      image: _image!,
    );

    setState(() {
      isLoading = false;
    });

    if (res == 'Success') {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => ResponsiveLayout(
            webScreenLayout: WebScreenLayout(),
            mobileScreenLayout: MobileScreenLayout()),
      ));
    } else {
      showSnackBar(context, res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: mobileBackgroundColor,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height - 40,
              child: Column(
                children: [
                  Flexible(child: Container(), flex: 2),
                  SvgPicture.asset(
                    "assets/ic_instagram.svg",
                    color: Colors.white,
                  ),
                  SizedBox(height: 24),
                  Stack(
                    children: [
                      _image != null
                          ? CircleAvatar(
                              radius: 56,
                              backgroundImage: MemoryImage(_image!),
                            )
                          : CircleAvatar(
                              radius: 56,
                              backgroundImage:
                                  AssetImage("assets/default_profile.png"),
                            ),
                      Positioned(
                        right: -5,
                        bottom: -10,
                        child: IconButton(
                          onPressed: selectImage,
                          icon: Icon(
                            Icons.add_a_photo,
                            size: 26,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 24),
                  TextFieldInput(
                    controller: _userNameController,
                    hintText: "Enter Your User Name",
                    textInputType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 24),
                  TextFieldInput(
                    controller: _emailController,
                    hintText: "Enter Your Email",
                    textInputType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 24),
                  TextFieldInput(
                    controller: _passController,
                    hintText: "Enter Your Password",
                    textInputType: TextInputType.text,
                    isObscure: true,
                  ),
                  SizedBox(height: 24),
                  TextFieldInput(
                    controller: _bioController,
                    hintText: "Enter Your Bio",
                    textInputType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 24),
                  InkWell(
                    onTap: signUpUser,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: blueColor,
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      child: isLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Text("Sign up"),
                    ),
                  ),
                  Flexible(child: Container(), flex: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        child: Text("Login"),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
