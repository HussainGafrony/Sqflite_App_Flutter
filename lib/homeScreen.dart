import 'package:flutter/material.dart';
import 'package:sqlflite_flutter/DB/sqlflite.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SqlDb sqlDb = SqlDb();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('HomScreen'),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    int response = await sqlDb.insertData(
                        "INSERT INTO 'notes' ('note') VALUES ('note two') ");
                    print(response);
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green)),
                  child: Text('InsertData')),
              Divider(
                height: 15,
              ),
              ElevatedButton(
                  onPressed: () async {
                    List<Map> response =
                        await sqlDb.readData("SELECT * FROM 'notes' ");
                    print(response);
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red)),
                  child: Text('ReadData')),
              Divider(
                height: 15,
              ),
              ElevatedButton(
                  onPressed: () async {
                    int response =
                        await sqlDb.deleteData("DELETE FROM 'notes' WHERE id = 3 ");
                    print(response);
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.orange)),
                  child: Text('DeleteData')),
                  Divider(
                height: 15,
              ),
                    ElevatedButton(
                  onPressed: () async {
                    int response =
                        await sqlDb.updateData("UPDATE 'notes' SET 'note' = 'note There' WHERE id = 4 ");
                    print(response);
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blueGrey)),
                  child: Text('UpdateData')),
            ],
          ),
        ),
      ),
    );
  }
}
