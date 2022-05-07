import 'package:flutter/material.dart';
import 'package:sqlflite_flutter/DB/sqlflite.dart';
import 'package:sqlflite_flutter/home2.dart';

class EditNote extends StatefulWidget {
  String note, title, color, id;
  EditNote(
      {required this.note,
      required this.title,
      required this.color,
      required this.id});

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();
  SqlDb sqlDb = SqlDb();

  @override
  void initState() {
    note.text = widget.note;
    title.text = widget.title;
    color.text = widget.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ُEdit Note'),
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
                child: Text('Update'),
                color: Colors.red,
                onPressed: () async {
                  int response = await sqlDb.updateData('''
                    UPDATE notes SET
                    note = "${note.text}",
                    title = "${title.text}",
                    color = "${color.text}",
                    id    = "${widget.id}" 
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
