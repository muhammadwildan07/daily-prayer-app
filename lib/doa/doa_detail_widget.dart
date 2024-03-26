part of 'doas.dart';

// Widget untuk menampilkan detail doa
class DoaDetailWidget extends StatefulWidget {
  final int index;

  const DoaDetailWidget({Key? key, required this.index}) : super(key: key);

  @override
  State<DoaDetailWidget> createState() => _DoaDetailWidgetState();
}

class _DoaDetailWidgetState extends State<DoaDetailWidget> {
  late Future<List<Doa>> _doaList;

  @override
  void initState() {
    super.initState();
    _doaList = fetchDoa();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.home),
          onPressed: () {

            print(isDetailVisible);
            setState(() {isDetailVisible =
            false;
            });
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        title: Text(doaName),
      ),
      body: Center(
        child: FutureBuilder<List<Doa>>(
          future: _doaList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Doa> doaList = snapshot.data!;

              return ListView.builder(
                shrinkWrap: true,
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      SafeArea(
                        child: SizedBox(
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              'DOA',
                              style: TextStyle(fontSize: 30),
                            ),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 20)),
                      SafeArea(
                        child: Container(
                          padding: EdgeInsets.only(right: 20, left: 20),
                          child: SizedBox(
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                textAlign: TextAlign.center,
                                doaList[widget.index].ayat + '',
                                style: TextStyle(
                                    fontSize: 30, fontFamily: 'Arial'),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 5)),
                      SafeArea(
                        child: Container(
                          padding: EdgeInsets.only(right: 20, left: 20),
                          child: SizedBox(
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                doaList[widget.index].latin,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 5)),
                      SafeArea(
                        child: Container(
                          padding: EdgeInsets.only(right: 20, left: 20),
                          child: SizedBox(
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                doaList[widget.index].artinya,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                },
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
    );
  }
}
