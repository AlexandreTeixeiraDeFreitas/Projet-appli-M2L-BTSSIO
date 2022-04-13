import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterapp/livre.dart';

class Affichage extends StatefulWidget {
  const Affichage({Key? key}) : super(key: key);

  @override
  State<Affichage> createState() => _AffichageState();
}

class _AffichageState extends State<Affichage> {
  late Future<List> _CompList;

  String? idCompt;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _CompList = Competition.getAllComp();
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      Object? arg = ModalRoute.of(context)!.settings.arguments;
      var newLivre = jsonDecode(arg.toString());
      setState(() {
        _CompList = _CompList.then<List>((value) {
          return [newLivre, ...value];
        });
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Compétitons"),
      ),
      body: Container(
        child: FutureBuilder<List>(
          future: _CompList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, i) {
                    return Card(
                      child: ListTile(
                        title: Text(
                          snapshot.data![i]['nomcompetition'],
                          style: const TextStyle(fontSize: 30),
                        ),
                        subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: [
                                  const Text('Date : ',
                                      style: TextStyle(fontSize: 20)),
                                  Text(
                                      snapshot.data![i]['date']
                                          .substring(0, 10),
                                      style: const TextStyle(fontSize: 20)),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Heure : ',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                    snapshot.data![i]['heure'],
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Nombre de tours : ',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                    snapshot.data![i]['tours'].toString(),
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      idCompt = snapshot.data![i]
                                              ['idcompetition']
                                          .toString();
                                      Competition.supprimer(context, idCompt);
                                    },
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(360),
                                            side:
                                                BorderSide(color: Colors.red)),
                                      ),
                                    ),
                                    child: const Text('delete'),
                                  ),
                                ],
                              )
                            ]),
                      ),
                    );
                  });
            } else {
              return const Center(
                child: Text("Pas de données"),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/ajout');
        },
        child: const Text("+"),
      ),
    );
  }
}
