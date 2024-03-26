part of 'authentication.dart';
final TextEditingController nameController = TextEditingController();
class SignUpWidget extends StatefulWidget {
  const SignUpWidget({
    super.key,
    required this.onClickedSignIn,
  });

  final VoidCallback onClickedSignIn;

  @override
  State<StatefulWidget> createState() {
    return _SignUpWidgetState();
  }
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController tokenController = TextEditingController();


  // FirebaseFirestore firestore = FirebaseFirestore.instance.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.amber),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                          borderRadius: BorderRadius.circular(20)),
                      labelText: 'Password',
                    ),
                    obscureText: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => value != null && value.length < 6
                        ? 'Enter min 6 character'
                        : null,
                  ),
                  const SizedBox(
                    height: 4,
                  ),

                  TextFormField(
                    controller: tokenController,
                    cursorColor: Colors.white,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white70,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),),
                      labelText: 'Insert Your Password Again',
                      hintText: 'Insert a valid token',
                    ),
                    obscureText: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => value != null && value.length < 6
                        ? 'Enter min 6 character'
                        : null,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton.icon(
                    style: stylesButton(),
                    onPressed: signUp,
                    icon: const Icon(
                      Icons.arrow_forward,
                      size: 32,
                    ),
                    label: const Text('Sign Up'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w200),
                      text: 'Already have an account? ',
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = widget.onClickedSignIn,
                          text: ' Log In',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future signUp() async {

    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      Utils.showSnackbar(e.message);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
final messengerKey = GlobalKey<ScaffoldMessengerState>();
