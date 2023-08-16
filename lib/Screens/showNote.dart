import 'package:flutter/material.dart';

class showNote extends StatefulWidget {
  const showNote({Key? key}) : super(key: key);

  @override
  State<showNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<showNote> {
  @override
  Widget build(BuildContext context) {
    var note = ModalRoute.of(context)!.settings.arguments ;
        return Scaffold(
          backgroundColor: Colors.grey,
      appBar: AppBar(backgroundColor:Colors.grey ,
        title: Text('MY Note'),
      ),
      body: Container(


        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(note.toString(),style:TextStyle(fontSize: 20,
           fontStyle:FontStyle.italic 
               ) ,),
            ],
          ),
        ),
      ),
    );
  }
}
