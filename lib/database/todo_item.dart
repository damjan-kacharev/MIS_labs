class ToDoItem{

  static String table ='todo';

  int id;
  String name;

  ToDoItem({
    required this.id,
    required this.name,
});

  Map<String,dynamic> toMap(){
    Map<String, dynamic> map = {
      'name': name
    };
    return map;
  }

  static ToDoItem fromMap(Map<String, dynamic>map){
    return ToDoItem(id: map['id'], name: map['name']);
  }

}