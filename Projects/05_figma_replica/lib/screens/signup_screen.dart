import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/app_assets.dart';
import '../constants/app_colors.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/primary_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController firstNameController =
      TextEditingController();

  final TextEditingController lastNameController =
      TextEditingController();

  final TextEditingController emailController =
      TextEditingController();

  final TextEditingController dobController =
      TextEditingController();

  final TextEditingController phoneController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    dobController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.signupGradient,
            stops: [0.0, 0.3, 0.6, 1.0],
          ),
        ),

        child: SafeArea(
          child: Form(
            key: _formKey,

            child: Column(
              children: [

                const SizedBox(height: 10),

                Center(
                  child: SvgPicture.asset(
                    AppAssets.companyLogo,
                    height: 30,
                    //width: 100,
                    fit: BoxFit.contain,
                  ),
                ),

                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),

                      child: Container(
                        padding: const EdgeInsets.all(22),

                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(24),
                        ),

                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,

                          children: [

                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },

                              icon: const Icon(
                                Icons.arrow_back,
                              ),
                            ),

                            Center(
                              child: Column(
                                children: [

                                  const Text(
                                    "Sign Up",
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight:
                                          FontWeight.bold,
                                      color: Color(0xFFB26DFF),
                                    ),
                                  ),

                                  const SizedBox(height: 8),

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,

                                    children: [

                                      const Text(
                                        "Already have an account? ",
                                      ),

                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pop(
                                            context,
                                          );
                                        },

                                        child: const Text(
                                          "Login",
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight:
                                                FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 30),

                            Row(
                              children: [

                                Expanded(
                                  child: AuthTextField(
                                    controller:
                                        firstNameController,
                                    label: "First Name",
                                    hint: "Rahul",

                                    validator: (value) {

                                      if (value == null ||
                                          value.isEmpty) {
                                        return "Enter first name";
                                      }

                                      return null;
                                    },
                                  ),
                                ),

                                const SizedBox(width: 12),

                                Expanded(
                                  child: AuthTextField(
                                    controller:
                                        lastNameController,
                                    label: "Last Name",
                                    hint: "Sharma",

                                    validator: (value) {

                                      if (value == null ||
                                          value.isEmpty) {
                                        return "Enter last name";
                                      }

                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 18),

                            AuthTextField(
                              controller: emailController,
                              label: "Email",
                              hint:
                                  "rahulsharma@gmail.com",

                              keyboardType:
                                  TextInputType.emailAddress,

                              validator: (value) {

                                if (value == null ||
                                    value.isEmpty) {
                                  return "Email is required";
                                }

                                if (!value.contains('@')) {
                                  return "Enter valid email";
                                }

                                return null;
                              },
                            ),

                            const SizedBox(height: 18),

                            AuthTextField(
                              controller: dobController,
                              label: "Birth of date",
                              hint: "18/03/2016",
                              suffixIcon:
                                  Icons.calendar_today_outlined,

                              validator: (value) {

                                if (value == null ||
                                    value.isEmpty) {
                                  return "Enter date of birth";
                                }

                                return null;
                              },
                            ),

                            const SizedBox(height: 18),

                            AuthTextField(
                              controller: phoneController,
                              label: "Phone Number",
                              hint: "+91 9876543210",

                              keyboardType:
                                  TextInputType.phone,

                              validator: (value) {

                                if (value == null ||
                                    value.isEmpty) {
                                  return "Enter phone number";
                                }

                                if (value.length < 10) {
                                  return "Enter valid phone number";
                                }

                                return null;
                              },

                              prefixIcon: Padding(
                                padding:
                                    const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),

                                child: Row(
                                  mainAxisSize:
                                      MainAxisSize.min,

                                  children: const [

                                    Text(
                                      "🇮🇳",
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),

                                    SizedBox(width: 4),

                                    Icon(
                                      Icons
                                          .keyboard_arrow_down,
                                      size: 18,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(height: 18),

                            AuthTextField(
                              controller:
                                  passwordController,

                              label: "Set Password",

                              hint: "*******",

                              obscureText: true,

                              suffixIcon:
                                  Icons.visibility_off_outlined,

                              validator: (value) {

                                if (value == null ||
                                    value.isEmpty) {
                                  return "Enter password";
                                }

                                if (value.length < 6) {
                                  return "Password must be at least 6 characters";
                                }

                                return null;
                              },
                            ),

                            const SizedBox(height: 30),

                            PrimaryButton(
                              text: "Register",

                              onPressed: () {

                                if (_formKey.currentState!
                                    .validate()) {

                                  ScaffoldMessenger.of(
                                    context,
                                  ).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "Registration Successful",
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}