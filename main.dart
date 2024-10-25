// memasukan paket paket ke main.dart
import 'package:english_words/english_words.dart'; // paket bahasa inggris
import 'package:flutter/material.dart'; // paket tampilan ui
import 'package:provider/provider.dart'; // paket interaksi

void main() {
  runApp(
    MyApp(
    )
  );
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
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 255, 0, 0)), // menggunakan warnaschema oren
        ),
        home: MyHomePage(), // list widget
      ),
    );
  }
}


class MyAppState extends ChangeNotifier {
  // mengisi variable current dengan 2 nilai random 
  var current = WordPair.random();
  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }
  var favorites = <WordPair>[]; // membuat variable favorites yang menyimpan list string
  void toggleFavorites() {
    if(favorites.contains(current)) { // bila di array ada string dari value current maka string current di array favorites dihapus
      favorites.remove(current);
    } else { // bila di array tidak ada string dari value variable current maka array favorites di tambah value dari string current
      favorites.add(current);
    }
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SafeArea(
            child: NavigationRail(
              extended: false,
              destinations: [
                NavigationRailDestination(
                  icon: Icon(Icons.home),
                  label: Text('Home'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.favorite),
                  label: Text('Favorites'),
                ),
              ],
              selectedIndex: 0,
              onDestinationSelected: (value) {
                print('selected: $value');
              },
            ),
          ),
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: GeneratorPage(),
            ),
          ),
        ],
      ),
    );
  }
}



class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigCards(pair: pair),
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  appState.toggleFavorites();
                },
                icon: Icon(icon),
                label: Text('Like'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  appState.getNext();
                },
                child: Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


class BigCards extends StatelessWidget {
  const BigCards({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    ); // membuat variable style untuk teks
    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          pair.asLowerCase, // mengubah string pair jadi lowe case
          style: style,
          semanticsLabel: "${pair.first} ${pair.second}" // memberi label pada masing masing kata, supaya teks terbaca dengan benar oleh aplikasi
        ), // variable style untuk teks dimuat
      ),
    );
  }
}
