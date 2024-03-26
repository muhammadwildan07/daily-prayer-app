part of'doas.dart';


class DoaWidget extends StatefulWidget {
  @override
  _DoaWidgetState createState() => _DoaWidgetState();
}

class _DoaWidgetState extends State<DoaWidget> {
  late Future<List<Doa>> _doaList;


  @override
  void initState() {
    super.initState();
    _doaList = fetchDoa();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        backgroundColor: Colors.amberAccent,

        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text('Daftar Doa'),
        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<Doa>>(
                future: _doaList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Doa> doaList = snapshot.data!;
                    return Scaffold( backgroundColor: Colors.transparent,
                      body: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/background.jpg'),
                                fit: BoxFit.fill)),
                        child: ListView.builder(
                          itemCount: doaList.length,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                Expanded(
                                  child: Card(
                                    elevation: 4,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 16),
                                    color: Colors.white.withOpacity(0.7),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: ListTile(
                                      onTap: () {
                                        setState(() {
                                          if(indexDoa != index){
                                            indexDoa = index;
                                            doaName = doaList[index].doa;
                                            isDetailVisible =
                                            true;
                                          }else{isDetailVisible =
                                          !isDetailVisible;}
                                          // Tampilkan detail
                                        });
                                      },
                                      title: Text('Doa',style: TextStyle(fontSize: 20,),textAlign: TextAlign.center,),
                                      subtitle: Text('${doaList[index].doa}',style: TextStyle(fontSize: 15),textAlign: TextAlign.center),
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            // AnimatedContainer untuk menampilkan detail dengan efek slide-up
            isDetailVisible?AnimatedContainerDoa():Container()
          ],
        ),
      ),
    );
  }
}

