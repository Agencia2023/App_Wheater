import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import '../models/datos.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<MaterialColor> color = [
    Colors.deepOrange,
    Colors.red,
    Colors.green,
    Colors.purple,
    Colors.brown
  ];
  Future<List<Datos>> getAllDatos() async {
    var urlApli = Uri.https(
        'www.jsonplaceholder.typicode.com', '/photos', {'q': '{http}'});
    var data = await http.get(urlApli);
    var jsonDatos = json.decode(data.body);

    List<Datos> listOf = [];

    for (var i in jsonDatos) {
      Datos data = new Datos(i["id"], i["title"], i["url"], i["thumbnailUrl"]);
      listOf.add(data);
    }
    return listOf;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Json parting App"),
        backgroundColor: Colors.deepOrange,
        actions: <Widget>[
          new IconButton(
            onPressed: () => debugPrint("Search"),
            icon: new Icon(Icons.search),
          ),
          new IconButton(
            onPressed: () => debugPrint("Add"),
            icon: new Icon(Icons.add),
          ),
        ],
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text("Aplicación Weather"),
              accountEmail: new Text("ydc@gmail.com"),
              decoration: new BoxDecoration(
                color: Colors.deepOrange,
              ),
            ),
            new ListTile(
              title: new Text("First Page"),
              leading: new Icon(Icons.search, color: Colors.orange),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            new ListTile(
              title: new Text("Second Page"),
              leading: new Icon(Icons.search, color: Colors.red),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            new ListTile(
              title: new Text("Third Page"),
              leading: new Icon(Icons.title, color: Colors.purple),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            new ListTile(
              title: new Text("Fourt Page"),
              leading: new Icon(Icons.title, color: Colors.purple),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            new Divider(
              height: 5.0,
            ),
            new ListTile(
              title: new Text("Close"),
              leading: new Icon(Icons.title, color: Colors.red),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
      body: new ListView(
        children: <Widget>[

          new Container(
            margin: EdgeInsets.all(10.0),
            height: 250.0,
            child: new FutureBuilder(
              future: getAllDatos(),
              builder: (BuildContext c, AsyncSnapshot Snapshot) {
                if (Snapshot.data == null) {
                  return Center(
                    child: new Text("Loading Data..."),
                  );
                } else {
                  return ListView.builder(
                    itemCount: Snapshot.data.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext c, int index) {
                      MaterialColor mcolor = color[index & color.length];
                      return Card(
                        elevation: 10.0,
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Image.network(
                              Snapshot.data[index].url,
                              height: 150.0,
                              width: 150.0,
                              fit: BoxFit.cover,
                            ),
                            new SizedBox(
                              height: 7.0,
                            ),
                            new Container(
                              margin: EdgeInsets.all(6.0),
                              height: 50.0,
                              child: new Row(
                                children: <Widget>[
                                  new Container(
                                    child: new CircleAvatar(
                                      child: new Text(
                                          Snapshot.data[index].id.toString()),
                                      backgroundColor: mcolor,
                                      foregroundColor: Colors.white,
                                    ),
                                  ),
                                  new SizedBox(
                                    width: 6.0,
                                  ),
                                  new Container(
                                    width: 80.0,
                                    child: new Text(
                                      Snapshot.data[index].title,
                                      maxLines: 1,
                                      style: TextStyle(
                                        color: Colors.deepOrange,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),

          new SizedBox(
            height: 7.0,),
          
          new Container(
            margin: EdgeInsets.all(10.0),
            child: new FutureBuilder(
              future: getAllDatos(),
              builder: (BuildContext c, AsyncSnapshot snapshot) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext c, int index){
                    return Card(
                      elevation: 7.0,
                      child: new Row(
                        children: <Widget> [
                          new Expanded(
                           flex: 1,
                           child: new Image.network(
                            snapshot.data[index].url,
                            height: 60.0,
                            fit: BoxFit.cover,
                           ),
                        ],
                      ),
                    );
                  }
                )
              },
              ),
          )

        ],
      ),
    );
  }
}
