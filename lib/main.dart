import 'package:flutter/material.dart';
import 'tdee/screens/tdee/tdee_screen.dart';
import 'trainingweightscalculator/screens/trainingweightcalculator/trainingweightscalculator.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ManageOne',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      home: const SharedScaffold(
        body: MyHomePageContent(),
        title: 'Manage One',
        currentIndex: 0, // Home page è l'indice 0
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Classe base condivisa per tutte le pagine
class SharedScaffold extends StatelessWidget {
  final Widget body;
  final String title;
  final int currentIndex;

  const SharedScaffold({
    super.key,
    required this.body,
    required this.title,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      drawer: _buildDrawer(context),
      body: body,
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage('assets/icons/mainIcon.png'),
                ),
                SizedBox(height: 10),
                Text(
                  'ManageOne',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                Text(
                  'La tua app per la gestione lavoro',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          _buildDrawerItem(
            context,
            'Home',
            Icons.home,
            0,
            () => _navigateToPage(
                context, const MyHomePageContent(), 'Manage One', 0),
          ),
          _buildDrawerItem(
            context,
            'Calcolatore TDEE',
            Icons.calculate,
            1,
            () => _navigateToPage(
                context, const TdeePage(), 'Calcolatore TDEE', 1),
          ),
          _buildDrawerItem(
            context,
            'Allenamento',
            Icons.fitness_center,
            2,
            () => _navigateToPage(
                          context, const TrainingWeightCalculator(), 'Calcolo percentuali allenamento', 2),
          ),
          const Divider(),
          _buildDrawerItem(
            context,
            'Impostazioni',
            Icons.settings,
            5,
            () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  // Helper per costruire le voci di menu con evidenziazione della pagina corrente
  Widget _buildDrawerItem(BuildContext context, String title, IconData icon,
      int index, VoidCallback onTap) {
    final bool isSelected = index == currentIndex;

    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? Theme.of(context).colorScheme.primary : null,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? Theme.of(context).colorScheme.primary : null,
        ),
      ),
      selected: isSelected,
      onTap: onTap,
    );
  }

  // Helper per la navigazione
  void _navigateToPage(
      BuildContext context, Widget page, String title, int index) {
    Navigator.pop(context); // Chiude il drawer

    if (index == currentIndex)
      return; // Se siamo già nella pagina richiesta, non facciamo nulla

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SharedScaffold(
          body: page,
          title: title,
          currentIndex: index,
        ),
      ),
    );
  }
}

// Contenuto della Home Page
class MyHomePageContent extends StatelessWidget {
  const MyHomePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Benvenuto in ManageOne',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20)
        ],
      ),
    );
  }
}
