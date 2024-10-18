// memasukan paket paket ke main.dart
import 'package:english_words/english_words.dart'; // paket bahasa inggris
import 'package:flutter/material.dart'; // paket tampilan ui
import 'package:provider/provider.dart'; // paket interaksi

void main() {
  runApp(MyApp());
}

// membuat class abstract dari class StatelessWidget untuk tujuan aplikasi
class MyApp extends StatelessWidget {
  // unnable change value from variable
  const MyApp({super.key});

  @override // mulai ganti kolom kode yang lama yang sudah ada di original ckass dengan kode yang baru
  Widget build(BuildContext context) {
    // mengatur ui, posisi widget

    // change notifier profider untuk mendeteksi interaksi di apliksi
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp( // menggunakan class MaterialApp()
        title: 'Namer App', // informasi judul aplikasi
        theme: ThemeData( // informasi tema
          useMaterial3: true, // menggunakan useMaterial3
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange), // menggunakan warnaschema oren
        ),
        home: MyHomePage(), // list widget
      ),
    );
  }
}


class MyAppState extends ChangeNotifier {
  // mengisi variable current dengan 2 nilai random 
  var current = WordPair.random();
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold( // base layout
      body: Column(
        children: [
          Text('hello world fufufafa:'),
          Text(appState.current.asLowerCase),
          ElevatedButton( // create button
            onPressed: () { // bila di tekan tombolnya maka akan exekusi function shadow dengan value print hello world
              print("hello world");
            },
            child: Text("klik saja"), // ini adalah teks dari button
          )
        ],
      ),
    );
  }
}