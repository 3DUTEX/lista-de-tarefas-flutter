import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/screens/add_activity.dart';

void main() {
  // ignore: prefer_const_constructors
  runApp(MaterialApp(
    // ignore: prefer_const_constructors
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Widget> _screens = [
    const AddActivity(),
    const Text("Pendentes"),
    const Text("Concluídas")
  ];

  int _itemSelected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_itemSelected],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _itemSelected,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Adicionar"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Pendentes"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Concluídas"),
        ],
        onTap: (index) => setState(() {
          _itemSelected = index;
        }),
      ),
    );
  }
}
