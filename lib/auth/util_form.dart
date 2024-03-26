part of 'authentication.dart';

class Utils {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackbar(String? text) {
    if (text == null) return;

    final snackBar = SnackBar(
      content: Text(text),
      backgroundColor: Colors.red,
    );

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}

Widget logoImage(){
  return     Image.asset(
    'assets/logo.png',
    width: 175,
    height: 175,
  );
}

BoxDecoration background(){
  return const BoxDecoration( image:
  DecorationImage(
      image: AssetImage("assets/background.png"),
      fit: BoxFit.fitHeight)
  );
}
BoxDecoration background1(){
  return const BoxDecoration( image:
  DecorationImage(
      image: AssetImage("assets/background_1.png"),
      fit: BoxFit.fill),
  );
}

Text intro(){
  return const Text(
    '''Welcome''',
    textAlign: TextAlign.center,
    style:
    TextStyle(fontSize: 32, fontWeight: FontWeight.w200),
  );
}
Center intro2(){
  return const Center(child: Text(
    '''
وَالَّذِيْنَ هُمْ عَلٰى صَلَوٰتِهِمْ يُحَافِظُوْنَ ۘ 
اُولٰۤىِٕكَ هُمُ الْوٰرِثُوْنَ ۙ 
الَّذِيْنَ يَرِثُوْنَ الْفِرْدَوْسَۗ هُمْ فِيْهَا خٰلِدُوْنَ 

"Orang-orang yang memelihara salat mereka. Mereka itulah orang-orang yang akan mewarisi. (Yaitu) orang-orang yang akan mewarisi (surga) Firdaus. Mereka kekal di dalamnya."''',
    textAlign: TextAlign.center,
    style:
    TextStyle(fontSize: 18, fontWeight: FontWeight.w200, color: Colors.black54),
  ));
}
