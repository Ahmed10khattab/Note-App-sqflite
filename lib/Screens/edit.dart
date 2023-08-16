 
 
 
import 'package:flutter/material.dart';
import 'package:noteapp/function/database.dart';
import 'package:sqflite/sqflite.dart';

class EditNote extends StatefulWidget {
  const EditNote({Key? key,required this.id, required this.body, required this.title})
      : super(key: key);
  final body;
  final title;
  final id;
  @override
  State<EditNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<EditNote> {
  TextEditingController title = TextEditingController();
  TextEditingController body = TextEditingController();

  TextEditingController color = TextEditingController();

  Db db = Db();
  @override
  void initState() {
    title.text = widget.title;
    body.text = widget.body;
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
var w=MediaQuery.of(context).size.width;
        var h= MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey,
      floatingActionButton:FloatingActionButton(onPressed:()async{
         int respons = await db.upDateData(
                    ''' UPDATE notes SET
                   note="${body.text}",
                   color="${color.text}",
                   title="${title.text}"
                   WHERE id=${widget.id}
                   ''');

                print(respons);
                Navigator.pop(context);
      },child:Column(children: [
        Icon(Icons.save_sharp) ,
        Text('save')
      ],) ) ,
        body: Padding(
      padding: const EdgeInsets.only(top: 60),
      child: Column(
        children: [
          TextFormField(
            controller: title,
            decoration: InputDecoration(
               
                  focusedBorder: OutlineInputBorder(borderSide:BorderSide(color: Colors.black,),borderRadius: BorderRadius.circular(w*.02)),
                              enabledBorder: OutlineInputBorder(borderSide:BorderSide(color: Colors.black,),borderRadius: BorderRadius.circular(w*.02)),
                              disabledBorder: OutlineInputBorder(borderSide:BorderSide(color: Colors.black,),borderRadius: BorderRadius.circular(w*.02)),
                              
                  hintText: 'title'),
              
              
          ),
          TextFormField(
            maxLines: 10,
            controller: body,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(borderSide:BorderSide(color: Colors.black,),borderRadius: BorderRadius.circular(w*.02)),
                              enabledBorder: OutlineInputBorder(borderSide:BorderSide(color: Colors.black,),borderRadius: BorderRadius.circular(w*.02)),
                              disabledBorder: OutlineInputBorder(borderSide:BorderSide(color: Colors.black,),borderRadius: BorderRadius.circular(w*.02)),
                              
              hintText: 'body'),
          ),
           
          // MaterialButton(
          //     child: Text('get'),
          //     onPressed: () async {
          //       await db.DeleteDb();
          //     }),
         // MaterialButton(
              // child: Text('ADD'),
              // onPressed: () async {
              //   int respons = await db.upDateData(
              //       ''' UPDATE notes SET
              //      note="${body.text}",
              //      color="${color.text}",
              //      title="${title.text}"
              //      WHERE id=${widget.id}
              //      ''');

              //   print(respons);
              //   Navigator.pop(context);
              // }),
     

        ],
      ),
    ));
  }
}
