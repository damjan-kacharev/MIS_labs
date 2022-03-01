import 'package:flutter/material.dart';
import 'database/db.dart';
import 'database/todo_item.dart';

void main() async{
  WidgetsFlutterBinding().ensureVisualUpdate();
  await DB.init();
  runApp(MyApp());

}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Kolokvium',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blueGrey,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.grey),
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}


class MyHomePage extends StatefulWidget {

  const MyHomePage({Key? key,required String title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



  List<ToDoItem> _todo = [];
  List<Widget> get _items => _todo.map((item) => format(item)).toList();

  late String _name;
  late String _datum;

  Widget format(ToDoItem item) {
    return Padding(padding: EdgeInsets.fromLTRB(10, 5, 10, 5),child: Dismissible(key: Key(item.id.toString()),
      child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.indigo,
              shape: BoxShape.rectangle,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black,
                    blurRadius: 10,
                    offset: Offset(0.0,5)
                )

              ]
          ),
          child: Row(children: <Widget>[

            Expanded(
              child: Text(item.name,style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
            ),


            // Expanded(
            //   child: Text(item.name,style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
            // )

          ]
          )
      ),
      onDismissed: (DismissDirection d){
        DB.delete(ToDoItem.table, item);
        refresh();
      },
    ),
    );
  }
  void _create(BuildContext context)
  {
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Dodadi termin za kolokvium'),
            content: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    autofocus: true,
                    decoration: InputDecoration(labelText: 'Ime na predmet'),
                    onChanged: (name){_name=name;},
                  ),
                  TextField(
                    autofocus: true,
                    decoration: InputDecoration(labelText: 'Datum i vreme'),
                    onChanged: (datum){_datum=_name+'\n'+datum;},
                  )

                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(onPressed: ()=>_save(),
                  child: Text('Dodadi'))
            ],
          );
        }
    );
  }

  void _save() async{
    Navigator.of(context).pop();
    ToDoItem item = ToDoItem(name: _datum, id: 0);
    await DB.insert(ToDoItem.table, item);

    setState(()=>_datum='');

    refresh();

  }

  void initState(){
    refresh();
    super.initState();
  }

  void refresh() async{
    List<Map<String,dynamic>> _results = await DB.query(ToDoItem.table);
    _todo=_results.map((item) => ToDoItem.fromMap(item)).toList();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dodaj kolokvium:"),
        //automaticallyImplyLeading: false,
        // leading: IconButton (
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: () {
        //     /** Do something */
        //   },
        // ),
        backgroundColor: Colors.indigo,
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: IconButton(
                onPressed: (){
                  //Navigator.push(context,MaterialPageRoute(builder: (context)=>DemoApp()));

                  showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2022), lastDate: DateTime(2023));
                },
                icon: Icon(
                  Icons.assignment_rounded,
                  size: 26.0,
                ),
              )
          ),
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: IconButton(
                onPressed: ()=> _create(context),
                icon: Icon(
                  Icons.add_to_photos_outlined,
                  size: 26.0,
                ),
              )
          )

        ],
      ),

      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        child: ListView(
          children:<Widget> [

            Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 0, 10),
              child: Text("Kolokviumi:",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
            ),



            ListView(
              children: _items,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
            ),

            FloatingActionButton(onPressed: (){},child: Icon(Icons.doorbell))
          ],
        ),
      ),

      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.redAccent,
      //   onPressed: ()=> _create(context),
      //   child: Icon(Icons.add,color: Colors.white,),
      // ),

    );
  }
}


