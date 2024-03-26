part of'doas.dart';

class AnimatedContainerDoa extends StatefulWidget {
  const AnimatedContainerDoa({super.key});

  @override
  State<AnimatedContainerDoa> createState() => _AnimatedContainerDoaState();
}

class _AnimatedContainerDoaState extends State<AnimatedContainerDoa> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      decoration: BoxDecoration(
          border: Border.all(
// Menambahkan border
            color: Colors.white, // Warna border
            width: 2, // Lebar border
          ),
          color: Colors.amber,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20))),
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      height:
      MediaQuery.of(context).size.height * 0.5 ,
      child:  DoaDetailWidget(
        index: indexDoa, )
,
    );
  }
}
