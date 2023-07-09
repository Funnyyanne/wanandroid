import 'package:flutter/material.dart';
import 'package:wanandroid/screen/hoem_page.dart';
import 'package:wanandroid/screen/login.dart';



void main() {
  // runApp(const MyApp());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // print('MyApp build+$context');
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      // theme: shrineTheme,
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 183, 102, 58)),
        useMaterial3: true,
      ),
      home:  HomePage(),
      // home: const LoginPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return LoginPage();
                    }),
                  );
                },
                child: const Text('跳转'))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}




// Widget _buildHead(BuildContext context) {
//   return Container(
//     decoration: BoxDecoration(color: GlobalConfig.colorPrimary),
//     child: GestureDetector(
//       onTap: () {
//         if (User().isLogin())
//           _showLogout(context);
//         else {
//           _toLogin(context);
//         }
//       },
//       child: _buildAvatar(),
//     ),
//   );
// }

// void _toLogin(BuildContext context) async {
//   await Router().openLogin(context);
//   User().refreshUserData(callback: () {
//     setState(() {});
//   });
// }
