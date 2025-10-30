import 'package:flutter/material.dart';
import 'signup.dart';
import 'package:movie/features/navigation/nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text('Sign In', style: TextStyle(color: Colors.white)),
        // backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 20.0),
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    mainAxisSize: MainAxisSize
                        .min, // ensure column wraps its content so it centers
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Center(
                        child: Text(
                          'Movie',
                          style: TextStyle(
                            color: Color(
                              0xFFCD3E10,
                            ), // accent color used in app
                            fontSize: 38,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      userField(
                        'Email',
                        Icons.email,
                        emailController,
                        false,
                        true,
                      ),
                      userField(
                        'Password',
                        Icons.lock,
                        passwordController,
                        true,
                        false,
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFCD3E10),
                          minimumSize: const Size(
                            double.infinity,
                            56,
                          ), // full-width and taller
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await _authenticate();
                          }
                        },
                        child: const Text('Sign In'),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account? ",
                            // style: TextStyle(color: Colors.white70),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: const Color(0xFFCD3E10),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const SignUpPage(),
                                ),
                              );
                            },
                            child: const Text('Sign Up'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget userField(
    String label,
    IconData icon,
    TextEditingController controller,
    bool isPassword, [
    bool isEmail = false,
  ]) {
    final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        onChanged: (value) {
          // re-validate the form as the user types so the "required" message disappears
          if (_formKey.currentState != null) _formKey.currentState!.validate();
        },
        controller: controller,
        obscureText: isPassword ? obscure : false,
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.white70,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
          if (isEmail && !emailRegex.hasMatch(value.trim())) {
            return 'Enter a valid email';
          }
          return null;
        },
        decoration: InputDecoration(
          filled: true,
          // fillColor: const Color(0xFF1E1E1E),
          prefixIcon: Icon(icon, ),
          labelText: label,
          // labelStyle: const TextStyle(color: Colors.white70),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 12.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    obscure ? Icons.visibility_off : Icons.visibility,
                    // color: Colors.white70,
                  ),
                  onPressed: () => setState(() => obscure = !obscure),
                )
              : null,
        ),
      ),
    );
  }

  Future<void> _authenticate() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    final storedEmail = prefs.getString('user_email');
    final storedPassword = prefs.getString('user_password');

    if (storedEmail == null || storedPassword == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No user found. Please sign up.')),
      );
      return;
    }

    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email == storedEmail && password == storedPassword) {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MyNavBar()),
      );
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid email or password')),
      );
    }
  }
}
