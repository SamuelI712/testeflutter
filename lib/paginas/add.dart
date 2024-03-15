import 'package:testeflutter/paginas/lista.dart';
import 'package:flutter/material.dart';

import '../servico/firebase_crud.dart';

class AddPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddPage();
  }
}

class _AddPage extends State<AddPage> {
  final _cliente_name = TextEditingController();
  final _cliente_email = TextEditingController();
  final _cliente_senha = TextEditingController();
  final _cliente_permissao='1';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final nameField = TextFormField(
        controller: _cliente_name,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Campo Obrigatório';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Nome",
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));
    final emailField = TextFormField(
        controller: _cliente_email,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Campo Obrigatório';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Email",
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));
    final senhaField = TextFormField(
        controller: _cliente_senha,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Campo Obrigatório';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Senha",
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final viewListbutton = TextButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil<dynamic>(
            context,
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => ListPage(),
            ),
                (route) => false, //if you want to disable back feature set to false
          );
        },
        child: const Text('Listar clientes'));

    final SaveButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Theme.of(context).primaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            var resposta = await FirebaseCrud.addCliente(
                name: _cliente_name.text,
                email: _cliente_email.text,
                senha: _cliente_senha.text,
                permissao:_cliente_permissao);
            if (resposta.codigo != 200) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(resposta.mensagem.toString()),
                    );
                  });
            } else {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(resposta.mensagem.toString()),
                    );
                  });
            }
          }
        },
        child: Text(
          "Save",
          style: TextStyle(color: Theme.of(context).primaryColorLight),
          textAlign: TextAlign.center,
        ),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('TesteFlutterWeb'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  nameField,
                  const SizedBox(height: 25.0),
                  emailField,
                  const SizedBox(height: 35.0),
                  senhaField,
                  viewListbutton,
                  const SizedBox(height: 45.0),
                  SaveButon,
                  const SizedBox(height: 15.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
