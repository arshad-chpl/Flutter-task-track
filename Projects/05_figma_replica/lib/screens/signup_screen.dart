import 'package:figma_replica/screens/login_screen.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFB9D3F2),
              Color(0xFFB49EF4),
              Colors.white,
              Colors.white,
            ],
            stops: [0.0, 0.3, 0.6, 1.0],
          ),
        ),


        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 10),

              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "assets/icons/logo.png",
                      height: 40,
                      width: 40,
                      fit: BoxFit.contain,
                    ),

                    const SizedBox(width: 12),

                    Image.asset(
                      "assets/icons/company_name.png",
                      height: 50,
                      width: 100,
                      fit: BoxFit.contain,
                    ),
                  ],
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Already have an account? ",
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),

                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginScreen(),
                                          ),
                                        );
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
                                child: buildTextField(
                                  label: "First Name",
                                  hint: "Rahul",
                                ),
                              ),

                              const SizedBox(width: 12),

                              Expanded(
                                child: buildTextField(
                                  label: "Last Name",
                                  hint: "Sharma",
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 18),

                         
                          buildTextField(
                            label: "Email",
                            hint: "rahulsharma@gmail.com",
                          ),

                          const SizedBox(height: 18),

                    
                          buildTextField(
                            label: "Birth of date",
                            hint: "18/03/2016",
                            icon: Icons.calendar_today_outlined,
                          ),

                          const SizedBox(height: 18),

                     
                          buildPhoneField(),

                          const SizedBox(height: 18),

                         
                          buildTextField(
                            label: "Set Password",
                            hint: "*******",
                            obscureText: true,
                            icon: Icons.visibility_off_outlined,
                          ),

                          const SizedBox(height: 30),

                          
                          SizedBox(
                            width: double.infinity,
                            height: 55,

                            child: ElevatedButton(
                              onPressed: () {},

                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color(0xFF3366FF),

                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(14),
                                ),
                              ),

                              child: const Text(
                                "Register",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
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
    );
  }
  
  Widget buildTextField({
    required String label,
    required String hint,
    bool obscureText = false,
    IconData? icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),
        ),

        const SizedBox(height: 8),

        TextField(
          obscureText: obscureText,

          decoration: InputDecoration(
            hintText: hint,

            hintStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),

            suffixIcon: Icon(icon),

            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildPhoneField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Phone Number",
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),
        ),

        const SizedBox(height: 8),

        TextField(
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12),

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

            hintText: "+91 9786543210",

            hintStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),

            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }
}