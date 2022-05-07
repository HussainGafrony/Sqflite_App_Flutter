import 'package:flutter/material.dart';
import 'package:sqlflite_flutter/DB/sqlflite.dart';
import 'package:sqlflite_flutter/addnotes.dart';
import 'package:sqlflite_flutter/editnote.dart';

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({Key? key}) : super(key: key);

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
  SqlDb sqlDb = SqlDb();
  bool isloading = true;
  List notes = [];
  Future readData() async {
    List<Map> response = await sqlDb.readData("SELECT * FROM notes");
    notes.addAll(response);
    isloading = false;
    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('HomeScreen2'),
        ),
        body: isloading
            ? Center(child: Text('Loading.........'))
            : Column(
                children: [
                  Container(
                    color: Colors.green[100],
                    child: MaterialButton(
                      color: Colors.red,
                      onPressed: () async {
                        await sqlDb.deleteMyDataBase();
                        print('my DataBase Deleted');
                      },
                      child: Text('DeleteMyDataBase'),
                    ),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: notes.length,
                      itemBuilder: (BuildContext context, index) {
                        return Card(
                          child: ListTile(
                            title: Text('${notes[index]['title']}'),
                            subtitle: Text('${notes[index]['note']}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () async {
                                    int response = await sqlDb.deleteData(
                                        "DELETE FROM notes WHERE id = ${notes[index]['id']} ");
                                    if (response > 0) {
                                      notes.removeWhere((element) =>
                                          element['id'] == notes[index]['id']);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text('Note Deleted')));
                                      setState(() {});
                                    }
                                  },
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => EditNote(
                                                  id: notes[index]['id'].toString(),
                                                  note: notes[index]['note'],
                                                  title: notes[index]['title'],
                                                  color: notes[index]['color'],
                                                )));
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ],
              ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddNote()));
            }),
      ),
    );
  }
}
