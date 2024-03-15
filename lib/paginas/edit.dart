import 'package:testeflutter/paginas/lista.dart';
import 'package:flutter/material.dart';

import '../modelo/cliente.dart';
import '../servico/firebase_crud.dart';

class EditPage extends StatefulWidget {
  final Cliente? cliente;
  EditPage({this.cliente});

  @override
  State<StatefulWidget> createState() {

    return _EditPage();
  }
}

class _EditPage extends State<EditPage> {
  final _cliente_name = TextEditingController();
  final _cliente_email = TextEditingController();
  final _cliente_senha = TextEditingController();
  final  _cliente_permissao="1";
  final _cleinte_docid = TextEditingController();


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    _cleinte_docid.value = TextEditingValue(text: widget.cliente!.uid.toString());
    _cliente_name.value = TextEditingValue(text: widget.cliente!.clientename.toString());
    _cliente_email.value = TextEditingValue(text: widget.cliente!.email.toString());
    _cliente_senha.value = TextEditingValue(text: widget.cliente!.senha.toString());

  }

  @override
  Widget build(BuildContext context) {


    final DocIDField = TextField(
        controller:_cleinte_docid,
        readOnly: true,
        autofocus: false,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "doc",
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));



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
        child: const Text('Carregar lista de clientes'));

    final SaveButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Theme.of(context).primaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            var resposta = await FirebaseCrud.updateCliente(
                name: _cliente_name.text,
                email: _cliente_email.text,
                permissao: _cliente_permissao,
                senha: _cliente_senha.text);
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
          "Atualizar",
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
