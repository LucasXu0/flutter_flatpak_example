import 'package:app_links/app_links.dart';
import 'package:app_links/src/app_links_platform_interface.dart';
import 'package:app_links/src/app_links_linux.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

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
  late final SupabaseClient supabase;
  late final AppLinks appLinks;

  String email = 'NONE';

  @override
  void initState() {
    super.initState();

    initWithSupabase();
    // initWithAppLink();
  }

  void initWithAppLink() {
    appLinks = AppLinks();
    appLinks.registerDBusService(
      '/com/example/FlutterApp/Object',
      'com.example.FlutterApp',
    );
    appLinks.stringLinkStream.listen((link) {
      print('Received link: $link');
      setState(() {
        email = link;
      });
    });
  }

  Future<void> initWithSupabase() async {
    await Supabase.initialize(
      url: 'https://qjpatenivklvahpwpark.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFqcGF0ZW5pdmtsdmFocHdwYXJrIiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODUwMDIzMDYsImV4cCI6MjAwMDU3ODMwNn0.Q5ew-ksJ0kak8jNprJjzkZR1q576q2l6H72OM553Vnc',
    );

    SupabaseAuth.instance.registerDBusService(
      '/com/example/FlutterApp/Object',
      'com.example.FlutterApp',
    );

    supabase = Supabase.instance.client;

    // Listen to auth state changes
    supabase.auth.onAuthStateChange.listen((data) {
      final AuthChangeEvent event = data.event;
      final Session? session = data.session;
      if (event == AuthChangeEvent.signedIn) {
        setState(() {
          email = session!.user.email!;
        });
      } else if (event == AuthChangeEvent.signedOut) {
        print('User signed out');
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Did receive supabase callback, User $event, Session $session'),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              email,
            ),
            TextButton(
              onPressed: () async {
                await supabase.auth.signInWithOAuth(
                  Provider.google,
                  redirectTo: 'appflowy-flutter://login-callback',
                  queryParams: {
                    'access_type': 'offline',
                    'prompt': 'consent',
                  },
                );
              },
              child: const Text('Login with Google'),
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _incrementCounter() {
    final x = AppLinksPlatform.instance as AppLinkPluginLinux;
    x;
  }
}
