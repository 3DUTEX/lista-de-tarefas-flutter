import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/activities/add_activity.dart';
import 'package:lista_de_tarefas/activities/all_activity.dart';
import 'package:lista_de_tarefas/activities/completed_activity.dart';
import 'package:lista_de_tarefas/activities/pending_activity.dart';

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
  final Color bottomColor = Colors.indigo;

  final List<Widget> _screens = [
    const AddActivity(),
    const PendingActivity(),
    const CompletedActivity(),
    const AllActivity()
  ];

  int _itemSelected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_itemSelected],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _itemSelected,
        items: [
          BottomNavigationBarItem(
              backgroundColor: bottomColor,
              icon: const Icon(
                Icons.add_circle_outline_outlined,
              ),
              label: "Adicionar"),
          BottomNavigationBarItem(
              backgroundColor: bottomColor,
              icon: const Icon(
                Icons.task_alt,
              ),
              label: "Pendentes"),
          BottomNavigationBarItem(
              backgroundColor: bottomColor,
              icon: const Icon(Icons.check_circle),
              label: "Concluídas"),
          BottomNavigationBarItem(
              backgroundColor: bottomColor,
              icon: const Icon(Icons.list),
              label: "Todas"),
        ],
        onTap: (index) => setState(() {
          _itemSelected = index;
        }),
      ),
    );
  }
}
