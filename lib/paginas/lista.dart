import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testeflutter/modelo/cliente.dart';
import 'package:testeflutter/paginas/add.dart';
import 'package:testeflutter/paginas/edit.dart';
import 'package:flutter/material.dart';

import '../servico/firebase_crud.dart';

class ListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ListPage();
  }
}

class _ListPage extends State<ListPage> {
  final Stream<QuerySnapshot> collectionReference = FirebaseCrud.readCliente();
  //FirebaseFirestore.instance.collection('Employee').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Lista de clientes"),
        backgroundColor: Theme.of(context).primaryColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.app_registration,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushAndRemoveUntil<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) => AddPage(),
                ),
                    (route) =>
                false, //if you want to disable back feature set to false
              );
            },
          )
        ],
      ),
      body: StreamBuilder(
        stream: collectionReference,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ListView(
                children: snapshot.data!.docs.map((e) {
                  return Card(
                      child: Column(children: [
                        ListTile(
                          title: Text(e["cliente_name"]),
                          subtitle: Container(
                            child: (Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Email: " + e['email'],
                                    style: const TextStyle(fontSize: 14)),
                                Text("Permissão: " + e['permissao'],
                                    style: const TextStyle(fontSize: 12)),
                              ],
                            )),
                          ),
                        ),
                        ButtonBar(
                          alignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: const Color.fromARGB(255, 143, 133, 226), padding: const EdgeInsets.all(5.0),
                                textStyle: const TextStyle(fontSize: 20),
                              ),
                              child: const Text('Editar'),
                              onPressed: () {
                                Navigator.pushAndRemoveUntil<dynamic>(
                                  context,
                                  MaterialPageRoute<dynamic>(
                                    builder: (BuildContext context) => EditPage(
                                      cliente: Cliente(
                                         // uid: e.id,
                                          clientename: e["cliente_name"],
                                          email: e["email"],
                                          permissao: e["permissao"]),
                                    ),
                                  ),
                                      (route) =>
                                  false, //if you want to disable back feature set to false
                                );
                              },
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: const Color.fromARGB(255, 143, 133, 226), padding: const EdgeInsets.all(5.0),
                                textStyle: const TextStyle(fontSize: 20),
                              ),
                              child: const Text('Delete'),
                              onPressed: () async {
                                var resposta =
                                await FirebaseCrud.deleteCliente(uid: e.id);
                                if (resposta.codigo != 200) {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content:
                                          Text(resposta.mensagem.toString()),
                                        );
                                      });
                                }
                              },
                            ),
                          ],
                        ),
                      ]));
                }).toList(),
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}
