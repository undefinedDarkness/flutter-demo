import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}


enum Operation {
  Add,
  Sub,
  Mul,
  Div,
  Value,
  Space
}

class Value {
  Operation type = Operation.Value;
  int value = -1;

  String asString() {
    switch (type) {
      case Operation.Add:
        return '+';
      case Operation.Div:
        return '/';
      case Operation.Mul:
        return '*';
      case Operation.Sub:
        return '-';
      case Operation.Value:
        return value.toString();
      case Operation.Space:
        return ' ';
    }
  }

  Value(this.type, this.value);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PoleCalc',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'PRN Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int _counter = 0;

  // void _incrementCounter() {
  //   setState(() {
  //     // This call to setState tells the Flutter framework that something has
  //     // changed in this State, which causes it to rerun the build method below
  //     // so that the display can reflect the updated values. If we changed
  //     // _counter without calling setState(), then the build method would not be
  //     // called again, and so nothing would appear to happen.
  //     _counter++;
  //   });
  // }

  // var display = Text("$hd", style: TextStyle(fontSize: 40), textAlign: TextAlign.left);

  void updateDisplay() {
    var a = "";
    for (var c in memory) {
      a += c.asString();
    }
    setState(() {
      display = a;
    });
  }

  void Eval() {
    var list = memory;
    var state = 0;
    var replica = <double>[];
    while (list.isNotEmpty) {
      print("---");
      print(replica);
      print(list);
      // print
      var last = list.removeLast();
      print(last.type);
      switch (last.type) {
        case Operation.Add:
          var a = replica.removeLast();
          var b = replica.removeLast();
          replica.add(a + b);
          break;
        case Operation.Sub:
          var a = replica.removeLast();
          var b = replica.removeLast();
          replica.add(a - b);
          break;
        case Operation.Mul:
          var a = replica.removeLast();
          var b = replica.removeLast();
          replica.add(a * b);
          break;
        case Operation.Div:
          var b = replica.removeLast();
          var a = replica.removeLast();
          replica.add(a / b);
          break;
        case Operation.Value:
          replica.add(last.value + 0.0);
          break;
        case Operation.Space:
          continue;
      }
    }
    print(replica);
    var result = replica.isNotEmpty ? replica.removeLast().toString() : "ERR";
    // print(result);
    setState(() {
      display = "=$result";//result;
    }); 
  }  

  void Add(String txt) {
    switch (txt) {
      case "-":
        memory.add(Value(Operation.Sub, -1));
      break;
      case "+":
      memory.add(Value(Operation.Add, -1));
      break;
      case "*":
      memory.add(Value(Operation.Mul, -1));
      break;
      case "/":
      memory.add(Value(Operation.Div, -1));
      break;
      case "CLR":
      memory.clear();
      break;
      case "SPC":
      memory.add(Value(Operation.Space, -1));
      break;
      case "BS":
      if (memory.isNotEmpty) {
        memory.removeLast();
      }
      break;
      case "EVAL":
        Eval();
        return;
      default: {
        if (memory.isNotEmpty) {
          var last = memory.last;
          if (last.type == Operation.Value) {
            memory.last.value = memory.last.value * 10 + int.parse(txt);
          } else {
            memory.add(Value(Operation.Value, int.parse(txt)));
          }
        } else {
          // list is empty
          memory.add(Value(Operation.Value, int.parse(txt)));
        }
      }
    }
    updateDisplay();
  }

  var display = "";
  var memory = <Value>[];

  @override
  Widget build(BuildContext context) {
    
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    // var display = "";
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: ListView(
            // physics: NeverScrollableScrollPhysics(),
            // scrollDirection: Axis.,
        children: [
          // Row(children: [
            Container(child: Text("$display", style: TextStyle(fontSize:  40),), padding: EdgeInsets.all(10), decoration: BoxDecoration(border: Border.all(color: Colors.black12)),), //Padding(padding: EdgeInsets.all(10), child:  display,),
          // ]),
          
           GridView.count(
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            crossAxisCount: 5,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.all(25),
            // childAspectRatio: 1 / .43,
            children: (["/", "CLR", "EVAL", "BS", "SPC", "0", "1", "2", "3", "+", "4", "5", "6", "-", "7", "8", "9", "*",].map((e) {
                return ElevatedButton(onPressed: () {
                  Add(e);
                }, style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(fontSize: 20),
                  // maximumSize: Size(50, 50),
                  shape: RoundedRectangleBorder(side: BorderSide.none)
                ), child: Text(e));
  })).toList()
          ) 
        ],
      )),
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
