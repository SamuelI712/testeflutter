/*import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<ProfileScreen>(
                  builder: (context) => ProfileScreen(
                    appBar: AppBar(
                      title: const Text('Perfil'),
                    ),
                    actions: [
                      SignedOutAction((context) {
                        Navigator.of(context).pop();
                      })
                    ],
                    children: [
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: AspectRatio(
                          aspectRatio: 1,
                         // child: Image.asset('flutterfire_300x.png'),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        ],
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          children: [
            //Image.asset('dash.png'),
            Text(
              'Bem vindo!',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SignOutButton(),
          ],
        ),
      ),
    );
  }
}*/
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:testeflutter/modelo/resposta.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _Collection = _firestore.collection('usuarios');
Resposta resposta = Resposta();
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () async {
              final user = FirebaseAuth.instance.currentUser;
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AuthScreen()),
              );

            },
          )
        ],
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          children: [
            //Image.asset('dash.png'),
            Text(
              'Bem vindo!',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SignOutButton(),
          ],
        ),
      ),
    );
  }
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _requestController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _requestController=TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _requestController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de pedidos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu nome';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu novo email';
                  }
                  if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                    return 'Por favor, insira um email válido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Senha'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira sua nova senha';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _requestController,
                decoration: InputDecoration(labelText: 'Pedido'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira sua requisição';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final name = _nameController.text;
                    final email = _emailController.text;
                    final password = _passwordController.text;
                    final request=_requestController.text;

                    try {
                      // Criptografa a senha usando SHA-256
                      final passwordHash = sha256.convert(utf8.encode(password)).toString();

                      // Cria o usuário no Firebase Auth
                      final UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: email,
                        password: passwordHash,
                      );

                      // Envia os dados para o Firestore
                      DocumentReference documentReferencer =
                      _Collection.doc();

                     // await FirebaseFirestore.instance._Collection.doc(userCredential.user!.uid).set({

              Map<String, dynamic> data = <String, dynamic>{
                    'uid': userCredential.user!.uid,
                        'name': name,
                        'email': email,
                        'password':passwordHash,
                        'request':request,
                        'permission': '1',
                      };
                      var result = await documentReferencer
                          .set(data)
                          .whenComplete(() {
                        resposta.codigo = 200;
                        resposta.mensagem = "Adicionado com sucesso à base de dados";
                      });

                      Navigator.pop(context); // Fecha a tela de cadastro após sucesso
                    } catch (error) {
                      // Handle error
                      print('Erro durante o cadastro: $error');
                    }
                  }
                },
                child: Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SignOutButton extends StatelessWidget {
  const SignOutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await FirebaseAuth.instance.signOut();
      },
      child: Text('Sair'),
    );
  }
}
