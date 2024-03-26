part of 'authentication.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.amber,
        elevation: 0,
        title: const Text('Reset Password'),
      ),
        body: Container(
            decoration: BoxDecoration(color: Colors.amber),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
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
                              const Center(
                                child: Text(
                                    '''Enter your email to reset your password.'''),
                              ),
                              // intro(),
                              // intro2(),
                              const SizedBox(
                                height: 233,
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
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (email) => email != null &&
                                        !EmailValidator.validate(email)
                                    ? 'Enter a valid email'
                                    : null,
                              ),
                              const SizedBox(
                                height: 4,
                              ),

                              ElevatedButton.icon(
                                style: stylesButton(),
                                onPressed: resetPassword,
                                icon: const Icon(
                                  Icons.email_rounded,
                                  size: 27,
                                ),
                                label: const Text(
                                  'Reset Password',
                                  style: TextStyle(fontSize: 17),
                                ),
                              ),
                              SizedBox(height: 187,)
                            ],
                          ),
                        ),
                      ]),
                ),
              ),
            )));
  }

  Future resetPassword() async {
    showDialog(
        context: context,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ));
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      Utils.showSnackbar('Password Reset Email Sent ');
      Navigator.of(context).popUntil((route) => route.isActive);
    } on FirebaseAuthException catch (e) {
      Utils.showSnackbar(e.message);
      Navigator.of(context).pop();
    }
  }
}
