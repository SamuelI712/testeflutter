import 'package:cloud_firestore/cloud_firestore.dart';
import '../modelo/resposta.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _Collection = _firestore.collection('Cliente');

class FirebaseCrud {

  static Future<Resposta> addCliente({
    required String name,
    required String email,
    required String senha,
    required String permissao,
  }) async {

    Resposta resposta = Resposta();
    DocumentReference documentReferencer =
    _Collection.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "cliente_name": name,
      "email": email,
      "senha" : senha
    };

    var result = await documentReferencer
        .set(data)
        .whenComplete(() {
      resposta.codigo = 200;
      resposta.mensagem = "Adicionado com sucesso à base de dados";
    })
        .catchError((e) {
      resposta.codigo = 500;
      resposta.mensagem = e;
    });

    return resposta;
  }



  static Future<Resposta> updateCliente({
    required String name,
    required String email,
    required String senha,
    required String permissao,
  }) async {
    Resposta resposta = Resposta();
    DocumentReference documentReferencer =
    _Collection.doc(permissao);

    Map<String, dynamic> data = <String, dynamic>{
      "cliente_name": name,
      "email": email,
      "senha" : senha
    };

    await documentReferencer
        .update(data)
        .whenComplete(() {
      resposta.codigo = 200;
      resposta.mensagem = "Atualizado com sucesso";
    })
        .catchError((e) {
      resposta.codigo = 500;
      resposta.mensagem = e;
    });

    return resposta;
  }

  static Stream<QuerySnapshot> readCliente() {
    CollectionReference notesItemCollection =
        _Collection;

    return notesItemCollection.snapshots();
  }

  static Future<Resposta> deleteCliente({
    required String uid,
  }) async {
    Resposta resposta = Resposta();
    DocumentReference documentReferencer =
    _Collection.doc(uid);

    await documentReferencer
        .delete()
        .whenComplete((){
      resposta.codigo= 200;
      resposta.mensagem = "Remoção efetuada com sucesso";
    })
        .catchError((e) {
      resposta.codigo = 500;
      resposta.mensagem = e;
    });

    return resposta;
  }

}