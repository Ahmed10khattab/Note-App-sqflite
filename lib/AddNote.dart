 import 'package:flutter/material.dart';
import 'package:noteapp/function/database.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  TextEditingController title = TextEditingController();
  TextEditingController body = TextEditingController();
  TextEditingController color = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  validation() {
    var current = formstate.currentState;
    if (current!.validate()) {
      current.save();
    }
  }

  Db db = Db();
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(backgroundColor: Colors.grey,
        body: ListView(
          children: [
            Padding(
      padding: const EdgeInsets.only(top: 60),
      child: Form(
            key: formstate,
            child: Container(
              margin:EdgeInsets.symmetric(horizontal: 20,vertical: 10) ,
              child: Column(
                children: [
                  TextFormField(
                    validator: (val) {
                      if (val!.isEmpty) {
                        return ('enter title');
                      }
                      return null;
                    },
                    controller: title,
                    decoration:  InputDecoration(
                      focusedBorder: OutlineInputBorder(borderSide:BorderSide(color: Colors.black,),borderRadius: BorderRadius.circular(w*.02)),
                                  enabledBorder: OutlineInputBorder(borderSide:BorderSide(color: Colors.black,),borderRadius: BorderRadius.circular(w*.02)),
                                  disabledBorder: OutlineInputBorder(borderSide:BorderSide(color: Colors.black,),borderRadius: BorderRadius.circular(w*.02)),
                                  
                      hintText: 'title'),
                  ),

                  SizedBox(height:h *.04,),
                  TextFormField(
                     maxLines:15 ,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return ('enter text');
                      }
                      return null;
                    },
                    controller: body,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(borderSide:BorderSide(color: Colors.black,),borderRadius: BorderRadius.circular(w*.02)),
                                  enabledBorder: OutlineInputBorder(borderSide:BorderSide(color: Colors.black,),borderRadius: BorderRadius.circular(w*.02)),
                                  disabledBorder: OutlineInputBorder(borderSide:BorderSide(color: Colors.black,),borderRadius: BorderRadius.circular(w*.02)),
                                  
                      hintText: 'body'),
                  ),
                  SizedBox(height:20 ,),
                  MaterialButton(
                    minWidth:80,
                    height: 40,
                    color: Color.fromARGB(255, 209, 209, 209),
                      child: Text('ADD'),
                      onPressed: () async {
                        var i = formstate.currentState;
                        if (i!.validate()) {
                          i.save();
                           int respons = await db.insertData(
                            "INSERT INTO notes ('note','color','title')VALUES('${body.text}','${color.text}','${title.text}')");

                        print(respons);
                        Navigator.pop(context);
                        }

                       
                      }),
                  
                ],
              ),
            ),
      ),
    ),
          ],
        ));
  }
}
