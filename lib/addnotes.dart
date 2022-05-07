import 'package:flutter/material.dart';
import 'package:sqlflite_flutter/DB/sqlflite.dart';
import 'package:sqlflite_flutter/home2.dart';

class AddNote extends StatefulWidget {
  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  TextEditingController? note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();
  SqlDb sqlDb = SqlDb();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: note,
              decoration: InputDecoration(hintText: 'note'),
            ),
            TextFormField(
              controller: title,
              decoration: InputDecoration(hintText: 'title'),
            ),
            TextFormField(
              controller: color,
              decoration: InputDecoration(hintText: 'color'),
            ),
            SizedBox(
              height: 15,
            ),
            MaterialButton(
                textColor: Colors.white,
                child: Text('ADD'),
                color: Colors.red,
                onPressed: () async {
                  int response = await sqlDb.insertData('''
                  INSERT INTO notes (title , note , color) VALUES ("${title.text}" , "${note!.text}" , "${color.text}")
              ''');
                  if (response > 0) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen2()));
                  }

                  print(response);
                }),
          ],
        ),
      ),
    );
  }
}
