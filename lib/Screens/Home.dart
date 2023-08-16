 import 'package:flutter/material.dart';
import 'package:noteapp/Screens/edit.dart';
import 'package:noteapp/function/database.dart';
import 'package:noteapp/model/NodeModel.dart';
 
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  Db db = Db();

  Future<List<Map>> getData() async {
    List<Map> respons = await db.readData("SELECT*FROM 'notes'");

    setState(() {
      //this line make futureBuilder as Stream to fetch data from local database(sqflite) continuously
    });

    // print(respons);

    return respons;
  }

  @override
  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
        var h= MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(elevation: 0,
        backgroundColor:Colors.grey, 
        title: Text('MyNote'),centerTitle: true,),
        backgroundColor: Colors.grey,
        floatingActionButton: FloatingActionButton(backgroundColor:Color.fromARGB(255, 143, 130, 130) ,
          onPressed: () {
            Navigator.pushNamed(context, 'addNote');
          },
          child: const Icon(Icons.add),
        ),
        body: ListView(
          children: [
            FutureBuilder(
              future: getData(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Map>> snapshot) {
                if (snapshot.hasData) {
                  return Stack(
                    
                    children: [
                      
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(  
                          height:h*100 ,
                          child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 23,
                                      crossAxisSpacing: 37,
                                      childAspectRatio: 1),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, 'showNote',
                                        arguments: snapshot.data![index]['note']);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
color: Color.fromARGB(255, 187, 116, 116),
borderRadius: BorderRadius.circular(20),
boxShadow: [BoxShadow(
  blurRadius: 4,
  color: Color.fromARGB(255, 136, 113, 113)
)]
                                    ),
                                      
                                      child: Stack(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 30, left: 30),
                                            child: Text(
                                              "${snapshot.data![index]['title']}",
                                              style: const TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.w400,
                                                  fontStyle: FontStyle.italic),
                                            ),
                                          ), 
                                          Positioned(
                                            top: 5,right: 10,
                                            child:Icon(Icons.note_alt,color: Color.fromARGB(255, 204, 198, 198),)),
                                          Positioned(
                                              bottom: 10,
                                              right: 5,
                                              child: IconButton(
                                                  onPressed: () {
                                                    db.deleteData(
                                                        "DELETE FROM notes WHERE id=${snapshot.data![index]['id']} ");
                                                    setState(() {});
                                                  },
                                                  icon: Icon(Icons.delete))),
                                          Positioned(
                                            bottom: 10,
                                            right: 50,
                                            child: IconButton(
                                                onPressed: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) => EditNote(
                                                              id: snapshot.data![
                                                                  index]['id'],
                                                              body: snapshot
                                                                      .data![
                                                                  index]['note'],
                                                              title: snapshot
                                                                      .data![
                                                                  index]['title'])));
                                                },
                                                icon: Icon(Icons.edit)),
                                          ),
                                          Positioned(
                                            top: 70,
                                            left: 10,
                                            child: Text(
                                              "${snapshot.data![index]['note']}",
                                              style: const TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w300,
                                                  fontStyle: FontStyle.italic),
                                            ),
                                          )
                                        ],
                                      )),
                                );
                              }),
                        ),
                      )
                    ],
                  );
                }
                return Center(child: Text('data'));
              },
            ),
          ],
        ));
  }
}
