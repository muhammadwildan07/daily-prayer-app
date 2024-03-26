// import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'auth/authentication.dart';
import 'firebase_options.dart';

final formKey = GlobalKey<FormState>();
final navigatorKey = GlobalKey<NavigatorState>();

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  runApp(const MainPage());
}


class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // fontFamily: GoogleFonts.aBeeZee().fontFamily,
      ),
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: Utils.messengerKey,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const VerifyEmailPage();
          } else {
            return const AuthPage();
          }
        },
      ),
    );
  }
}

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    return isLogin
        ? LoginWidget(
      onClickedSignUp: toggle,
    )
        : SignUpWidget(
      onClickedSignIn: toggle,
    );
  }

  void toggle() {
    setState(() {
      isLogin = !isLogin;
    });
  }
}
