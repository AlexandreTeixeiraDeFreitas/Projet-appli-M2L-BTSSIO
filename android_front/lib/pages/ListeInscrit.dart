import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterapp/livre.dart';

class ListeInscrit extends StatefulWidget {
  const ListeInscrit({Key? key}) : super(key: key);

  @override
  State<ListeInscrit> createState() => _AffichageState();
}

class _AffichageState extends State<ListeInscrit> {
  late Future<List> _Inscrit;

  String? idCompt;
  String? idUser;
  @override
  //void initState() {
  // TODO: implement initState
  //super.initState();

  //}

  Future call_getAllInscrit(context, idComp) async {
    _Inscrit = Competition.getAllInscrit(context, idComp);
  }

  @override
  Widget build(BuildContext context) {
    call_getAllInscrit(context, ModalRoute.of(context)!.settings.arguments);
    if (ModalRoute.of(context)!.settings.arguments != null) {
      Object? arguments = ModalRoute.of(context)?.settings.arguments;
      Object? arg = ModalRoute.of(context)!.settings.arguments;
      var newList = jsonDecode(arg.toString());
      var newLivre = jsonDecode(arg.toString());
      setState(() {
        _Inscrit = _Inscrit.then<List>((value) {
          return [newList, ...value];
        });
      });
    }
    return Scaffold(
      appBar: AppBar(
          title: const Text("Liste Inscrit"),
          backgroundColor: Color.fromARGB(255, 218, 53, 53)),
      body: Container(
        child: FutureBuilder<List>(
          future: _Inscrit,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data?[1].length > 0) {
              return ListView.builder(
                  itemCount: snapshot.data?[1].length,
                  itemBuilder: (context, i) {
                    return Card(
                      child: ListTile(
                        title: Text(
                          snapshot.data?[1][i]['nom'],
                          style: TextStyle(fontSize: 30),
                        ),
                        subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: [
                                  const Text('Prenom : ',
                                      style: TextStyle(fontSize: 20)),
                                  Text(snapshot.data?[1][i]['prenom'],
                                      style: const TextStyle(fontSize: 20)),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Email : ',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                    snapshot.data?[1][i]['email'],
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  idCompt = snapshot.data![1][i]
                                          ['idcompetition']
                                      .toString();
                                  idUser =
                                      snapshot.data![1][i]['iduser'].toString();
                                  print('del');
                                  print(idCompt);
                                  Competition.delinscrit(
                                      context, idCompt, idUser);
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color.fromARGB(255, 218, 53, 53)),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(360),
                                        side: BorderSide(color: Colors.white)),
                                  ),
                                ),
                                child: IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      idCompt = snapshot.data![1][i]
                                              ['idcompetition']
                                          .toString();
                                      idUser = snapshot.data![1][i]['iduser']
                                          .toString();
                                      print('del');
                                      print(idCompt);
                                      Competition.delinscrit(
                                          context, idCompt, idUser);
                                    }),
                              ),
                            ]),
                      ),
                    );
                  });
            } else {
              return const Center(
                child: Text("Personne ne s'est inscrit à cette compétition"),
              );
            }
          },
        ),
      ),
    );
  }
}
