import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../services/local_storage_service.dart';

import 'package:provider/provider.dart';
import 'package:birth_picker/birth_picker.dart';
import '../provider/auth_provider.dart';
//import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_assets.dart';
import '../constants/app_colors.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/primary_button.dart';
//import '../services/auth_service.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController firstNameController = TextEditingController();

  final TextEditingController lastNameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController dobController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  //final AuthService _authService = AuthService();
  final LocalStorageService _storageService = LocalStorageService();
  bool _isLoading = false;

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool acceptTerms = false;
  // bool isLoading = false;

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    dobController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  // Future<void> _signup() async {
  //   if (!_formKey.currentState!.validate()) {
  //     return;
  //   }

  //   setState(() {
  //     _isLoading = true;
  //   });
  //   if (!acceptTerms) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text("Please accept Terms & Conditions")),
  //     );
  //     return;
  //   }

  //   setState(() {
  //     _isLoading = true;
  //   });

  //   // try {
  //   //   final response = await _authService.signup(
  //   //     firstName: firstNameController.text.trim(),
  //   //     lastName: lastNameController.text.trim(),
  //   //     email: emailController.text.trim(),
  //   //     phone: phoneController.text.trim(),
  //   //     password: passwordController.text.trim(),
  //   //   );

  //     // final prefs = await SharedPreferences.getInstance();

  //     // await prefs.setString('username', firstNameController.text.trim());

  //     // await prefs.setBool('isLoggedIn', true);

  //     await _storageService.saveFirstName(firstNameController.text.trim());
  //     await _storageService.saveEmail(emailController.text.trim());

  //     await _storageService.saveLoginStatus(true);

  //     if (!mounted) return;

  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('User created: ${response.firstName}')),
  //     );

  //     Navigator.pushReplacementNamed(context, '/home');
  //   }
  Future<void> _signup() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!acceptTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please accept Terms & Conditions")),
      );

      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final authProvider = context.read<AuthProvider>();

      final success = await authProvider.signup(
        firstName: firstNameController.text.trim(),

        lastName: lastNameController.text.trim(),

        email: emailController.text.trim(),

        phone: phoneController.text.trim(),

        password: passwordController.text.trim(),

        dob: dobController.text.trim(),
      );

      if (!mounted) return;

      if (success) {
        await _storageService.saveFirstName(firstNameController.text.trim());

        await _storageService.saveEmail(emailController.text.trim());

        await _storageService.saveLoginStatus(true);

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Signup Successful")));

        Navigator.pushReplacementNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Signup failed")));
      }
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error.toString())));
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
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
                  child: Hero(
                    tag: 'testAnimation',
                    child: SvgPicture.asset(
                      AppAssets.companyLogo,
                      height: 30,
                      //width: 100,
                      fit: BoxFit.contain,
                    ),
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
                          borderRadius: BorderRadius.circular(24),
                        ),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },

                              icon: const Icon(Icons.arrow_back),
                            ),

                            Center(
                              child: Column(
                                children: [
                                  const Text(
                                    "Sign Up",
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFB26DFF),
                                    ),
                                  ),

                                  const SizedBox(height: 8),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,

                                    children: [
                                      const Text("Already have an account? "),

                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },

                                        child: const Text(
                                          "Login",
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.w600,
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
                                    controller: firstNameController,
                                    label: "First Name",
                                    hint: "Rahul",

                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Enter first name";
                                      }

                                      return null;
                                    },
                                  ),
                                ),

                                const SizedBox(width: 12),

                                Expanded(
                                  child: AuthTextField(
                                    controller: lastNameController,
                                    label: "Last Name",
                                    hint: "Sharma",

                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
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
                              hint: "rahulsharma@gmail.com",

                              keyboardType: TextInputType.emailAddress,

                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Email is required";
                                }

                                final emailRegex = RegExp(
                                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                );

                                if (!emailRegex.hasMatch(value)) {
                                  return "Enter a valid email address";
                                }

                                return null;
                              },
                            ),

                            const SizedBox(height: 18),

                            AuthTextField(
                              controller: dobController,
                              label: "Birth of date",
                              hint: "DD/MM/YYYY",
                              suffixIcon: Icons.calendar_today_outlined,

                              readOnly: true,

                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now().subtract(
                                    const Duration(
                                      days: 365 * 18,
                                    ), // default 18 years old
                                  ),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now(),
                                );

                                if (pickedDate != null) {
                                  dobController.text =
                                      "${pickedDate.day.toString().padLeft(2, '0')}/"
                                      "${pickedDate.month.toString().padLeft(2, '0')}/"
                                      "${pickedDate.year}";
                                }
                              },

                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Enter date of birth";
                                }

                                final parts = value.split('/');

                                if (parts.length != 3) {
                                  return "Use DD/MM/YYYY format";
                                }

                                final day = int.tryParse(parts[0]);
                                final month = int.tryParse(parts[1]);
                                final year = int.tryParse(parts[2]);

                                if (day == null ||
                                    month == null ||
                                    year == null) {
                                  return "Enter valid numbers";
                                }

                                if (day < 1 ||
                                    day > 31 ||
                                    month < 1 ||
                                    month > 12) {
                                  return "Enter valid date";
                                }

                                return null;
                              },
                            ),

                            const SizedBox(height: 18),

                            AuthTextField(
                              controller: phoneController,
                              label: "Phone Number",
                              hint: "10 digits number",
                              keyboardType: TextInputType.phone,

                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Enter phone number";
                                }

                                if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                                  return "Phone number must be exactly 10 digits";
                                }

                                return null;
                              },

                              prefixIcon: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),

                                child: Row(
                                  mainAxisSize: MainAxisSize.min,

                                  children: const [
                                    Text(
                                      "🇮🇳",
                                      style: TextStyle(fontSize: 18),
                                    ),

                                    SizedBox(width: 4),

                                    Icon(
                                      Icons.keyboard_arrow_down,
                                      size: 18,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(height: 18),

                            AuthTextField(
                              controller: passwordController,
                              label: "Enter Password",
                              hint: "Password",
                              obscureText: obscurePassword,
                              suffixIcon: obscurePassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              onSuffixTap: () {
                                setState(() {
                                  obscurePassword = !obscurePassword;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Password is required";
                                }
                                if (value.length < 6) {
                                  return "Password must be at least 6 characters";
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 18),

                            AuthTextField(
                              controller: confirmPasswordController,
                              label: "Confirm Password",
                              hint: "Confirm Password",
                              obscureText: obscureConfirmPassword,
                              suffixIcon: obscureConfirmPassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              onSuffixTap: () {
                                setState(() {
                                  obscureConfirmPassword =
                                      !obscureConfirmPassword;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Confirm your password";
                                }
                                if (value != passwordController.text) {
                                  return "Passwords do not match";
                                }
                                return null;
                              },
                            ),

                            Row(
                              children: [
                                Checkbox(
                                  value: acceptTerms,
                                  onChanged: (value) {
                                    setState(() {
                                      acceptTerms = value ?? false;
                                    });
                                  },
                                ),
                                const Expanded(
                                  child: Text(
                                    'I agree to "Terms & Conditions"',
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 30),

                            // PrimaryButton(
                            //   text: isLoading ? "Signing up..." : "Sign up",
                            //   onPressed: isLoading
                            //       ? null
                            //       : () async {
                            //           if (!_formKey.currentState!.validate()) {
                            //             return;
                            //           }

                            //           if (!acceptTerms) {
                            //             ScaffoldMessenger.of(context).showSnackBar(
                            //               const SnackBar(
                            //                 content: Text(
                            //                   "Please accept Terms & Conditions",
                            //                 ),
                            //               ),
                            //             );
                            //             return;
                            //           }

                            //           setState(() {
                            //             isLoading = true;

                            //           });

                            //           await Future.delayed(
                            //             const Duration(seconds: 1),
                            //           );

                            //           setState(() {
                            //             isLoading = false;
                            //           });

                            // ScaffoldMessenger.of(context).showSnackBar(
                            //     const SnackBar(
                            //         content: Text(
                            //           "Sign up Successful",
                            //         ),
                            //       ),
                            //     );
                            //   },
                            // ),
                            PrimaryButton(
                              text: _isLoading ? "Signing up..." : "Sign Up",
                              //text: 'Sign up',
                              isLoading: _isLoading,
                              onPressed: _signup,
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
