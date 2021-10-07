import 'package:flutter/material.dart';
import 'package:linio/linio.dart';
import 'package:linio/linio.dart';

void main() {
  Linio.custom(
    headers: [
      // UpTimeLogHeader(),
      DateTimeLinioHeader(),
      TagLinioHeader(),
      LevelConsoleLinioHeader(),
      LiveLinioHeader(),
    ],
    filters: [
      TagLinioFilter(),
    ],
    manipulators: [
      // EmptyCommand(),
      StopwatchCommand(),
      TagManagerCommand(),
      LogPointCommand(),
    ],
    printers: [
      // TerminalPrinter(),
      ConsolePrinter(),
    ],
    formatters: [
      FileLinioFormatter(),
      SimpleLinioFormatter(),
    ],
  );
  LC.log('stopwatch -s counter_timer', 'Start Stopwatch');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  void initState() {
   LC.log('stopwatch -s counter_timer', 'Start timer');
    super.initState();
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;

     LC.log('stopwatch -l counter_timer', 'Duration since last click');
      //L.log('--mode live --level error', 'Current counter value: $_counter');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          //Simple log
          simpleLog(),
          Divider(),
          //Simple log with tag
          simpleLogWithTag(),
          Divider(),
          //Timer
          timer(),
          Divider(),
          //Tag Managger
          tagManager(),
          Divider(),
          ElevatedButton(
            onPressed: () {
             L.log('log_point');
            },
            child: Text('Log point'),
          ),
        ],
      ),
    );
  }

  Widget tagManager() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                   L.log('tag_manager -b all');
                  },
                  child: Text('Block all'),
                ),
                ElevatedButton(
                  onPressed: () {
                   L.log('tag_manager -a all');
                  },
                  child: Text('Allow all'),
                ),
              ],
            ),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                   L.log('tag_manager -a simple_tag');
                  },
                  child: Text('Allow simple_tag'),
                ),
                ElevatedButton(
                  onPressed: () {
                   L.log('tag_manager -b simple_tag');
                  },
                  child: Text('Block simple_tag'),
                ),
              ],
            ),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                   L.log('tag_manager -a compound_tag');
                  },
                  child: Text('Allow compound_tag'),
                ),
                ElevatedButton(
                  onPressed: () {
                   L.log('tag_manager -b compound_tag');
                  },
                  child: Text('Block compound_tag'),
                ),
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
               LC.log('simple_tag', 'simple message');
              },
              child: Text('Log simple_tag'),
            ),
            ElevatedButton(
              onPressed: () {
               LC.log('compound_tag', 'simple log');
              },
              child: Text('log with compound_tag'),
            ),
          ],
        )
      ],
    );
  }

  Row timer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          onPressed: () {
           L.log('stopwatch -s simple_timer');
          },
          child: Text('Start timer'),
        ),
        ElevatedButton(
          onPressed: () {
           L.log('stopwatch -l simple_timer');
          },
          child: Text('Make a Loop'),
        ),
        ElevatedButton(
          onPressed: () {
           L.log('stopwatch -e simple_timer');
          },
          child: Text('Stop Timer'),
        ),
      ],
    );
  }

  Row simpleLogWithTag() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          onPressed: () {
           LC.log('simple_tag', 'simple log');
          },
          child: Text('log with simple_tag'),
        ),
      ],
    );
  }

  ElevatedButton simpleLog() {
    return ElevatedButton(
      onPressed: () {
       L.log('simple log');
      },
      child: Text('Simple log'),
    );
  }
}
