// ignore_for_file: avoid_print

import 'dart:io';
import 'dart:math';

import 'package:band_names/models/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'Arctik Monkeys', votes: 2),
    Band(id: '2', name: 'The Black Keys', votes: 5),
    Band(id: '3', name: 'Wolfmother', votes: 1),
    Band(id: '4', name: 'The Heavy', votes: 3),
    Band(id: '5', name: 'Bloc Party', votes: 4),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Center(
          child: Text(
            'BandNames',
            style: TextStyle(color: Colors.black87),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (context, i) => _bandTile(bands[i]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNewBand,
        elevation: 1,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        print("Direccion: $direction");
        print("Banda id: ${band.id}");
      },
      background: Container(
        color: Color.fromARGB(255, 252, 34, 34),
        child: const Padding(
          padding: EdgeInsets.only(left: 8),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 20,
                  // shadows: [
                  //   Shadow(
                  //       color: Color.fromARGB(255, 255, 255, 255),
                  //       offset: Offset(1, 1))
                  // ],
                ),
                Text(
                  'Delete band',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    // shadows: [
                    //   Shadow(
                    //       color: Color.fromARGB(255, 253, 253, 253),
                    //       offset: Offset(1, 1))
                    // ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(
            band.name.substring(0, 2),
          ),
        ),
        title: Text(band.name),
        trailing: Text(
          '${band.votes}',
          style: const TextStyle(fontSize: 20),
        ),
        onTap: () => print(band.name),
      ),
    );
  }

  addNewBand() {
    // print("object");
    final textController = TextEditingController();
    if (Platform.isAndroid) {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('New band name:'),
            content: TextField(
              controller: textController,
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5,
                textColor: Colors.blue,
                onPressed: () {
                  addBand(textController.text);
                },
                child: const Text('Add'),
              ),
            ],
          );
        },
      );
    }
    return showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: const Text('New band name: '),
              content: CupertinoTextField(
                controller: textController,
              ),
              actions: [
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: const Text('Add'),
                  onPressed: () {
                    addBand(textController.text);
                  },
                ),
                CupertinoDialogAction(
                  isDestructiveAction: true,
                  child: const Text('Dismiss'),
                  onPressed: () {
                    addBand(textController.text);
                  },
                )
              ],
            ));
  }

  void addBand(String nombre) {
    if (nombre.length > 1) {
      setState(() {
        // ignore: unnecessary_this
        this.bands.add(Band(
            id: DateTime.now().microsecond.toString(), name: nombre, votes: 0));
      });
    }

    Navigator.pop(context);
  }
}
