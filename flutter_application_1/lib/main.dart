import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Object {
  String body;
  String title;

  Object({this.body, this.title});
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tomeks app',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Object> objects = [];

  void newObject(String text) {
    this.setState(() {
      objects.add(new Object(body: text, title: text));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Form')),
        body: Column(children: <Widget>[
          Expanded(child: ObjectList(this.objects)),
          TextInputWidget(this.newObject)
        ]));
  }
}

class TextInputWidget extends StatefulWidget {
  final Function(String) callback; // function with String as argument

  TextInputWidget(this.callback);

  @override
  _TextInputWidgetState createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
  final controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void click() {
    widget.callback(controller.text);
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: this.controller,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.message),
            labelText: 'Type a text',
            suffixIcon: IconButton(
              icon: Icon(Icons.send),
              onPressed: this.click,
            )));
  }
}

class ObjectList extends StatefulWidget {
  final List<Object> listItems;

  ObjectList(this.listItems);

  @override
  _ObjectListState createState() => _ObjectListState();
}

class _ObjectListState extends State<ObjectList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.widget.listItems.length,
      itemBuilder: (context, index) {
        var object = this.widget.listItems[index];
        return Card(
          child: Row(children: <Widget>[
            Expanded(
          child: ListTile(
            title: Text(object.body),
            subtitle: Text(object.title),
          ))
          ]));
      },
    );
  }
}
