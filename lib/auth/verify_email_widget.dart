part of 'authentication.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified = false;
  bool canResendVerification = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendEmailVerification();

      timer = Timer.periodic(
        const Duration(seconds: 3),
            (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return isEmailVerified
        ? const HomePage()
        : Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        title: const Text(
          'Verify Email',
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(padding: EdgeInsets.all(20),
              child: const Text(
                "Check your Email inbox, we have sent a message to verify your Email ",
                style: TextStyle(
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            ElevatedButton.icon(
              style: stylesButton(),
                onPressed: canResendVerification? sendEmailVerification: null,
                icon: const Icon(
                  Icons.email_rounded,
                  size: 25,
                ),
                label: const Text(
                  'Resent Email',
                  style: TextStyle(fontSize: 20),
                )),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
              style: stylesButton(),
                onPressed: () => FirebaseAuth.instance.signOut(),
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 25,
                ),
                label: const Text(
                  'Cancel',
                  style: TextStyle(fontSize: 20),
                ))
          ],
        ),
      ),
    );
  }


  Future sendEmailVerification() async{
    try{
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(()=> canResendVerification =false);
      await Future.delayed(const Duration(seconds: 5));
      setState(() {
        canResendVerification =true;
      });
    } catch (e){
      Utils.showSnackbar(e.toString());
    }

  }
}


