part of 'authentication.dart';

class LoginWidget extends StatefulWidget {
  final Function() onClickedSignUp;

  const LoginWidget({
    super.key,
    required this.onClickedSignUp,
  });

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.amber),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 150,
                      ),
                      Center(
                        child: Text(
                          'Daily Prayer',
                          style: TextStyle(fontSize: 50),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      intro(),
                      intro2(),
                      const SizedBox(
                        height: 200,
                      ),
                      TextFormField(
                        controller: emailController,
                        cursorColor: Colors.white,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white70,
                          border: OutlineInputBorder(
                              // borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(20)),
                          labelText: 'Email',
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (email) =>
                            email != null && !EmailValidator.validate(email)
                                ? 'Enter a valid email'
                                : null,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      TextFormField(
                        controller: passwordController,
                        cursorColor: Colors.white,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white70,
                          border: OutlineInputBorder(
                            // borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          labelText: 'Password',
                        ),
                        obscureText: true,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) => value != null && value.length < 6
                            ? 'Enter min 6 character'
                            : null,
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                    ],
                  ),
                ),
                ElevatedButton.icon(
                  style: stylesButton(),
                  onPressed: () async {
                    await signIn();
                  },
                  icon: const Icon(
                    Icons.lock_open,
                    size: 32,
                  ),
                  label: const Text('Sign In'),
                ),
                const SizedBox(
                  height: 5,
                ),
                GestureDetector(
                  child: Text('Forgot Password?',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 15)),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ForgotPasswordPage()));
                  },
                ),
                RichText(
                    text: TextSpan(
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w200),
                        text: 'No account? ',
                        children: [
                      TextSpan(
                          text: 'Sign Up',
                          recognizer: TapGestureRecognizer()
                            ..onTap = widget.onClickedSignUp,
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Theme.of(context).colorScheme.secondary,
                          ))
                    ])),
                SizedBox(height: 150)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signIn() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      Utils.showSnackbar(e.message);
      print(e.message);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}

stylesButton() {
  return ElevatedButton.styleFrom(
    foregroundColor: Colors.amber, backgroundColor: Colors.black, // Warna teks
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20), // Bentuk tombol
    ),
  );
}
