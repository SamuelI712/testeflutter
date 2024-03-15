class Cliente{
  String? uid;//Identificador único do usuário no sistema.
  String? clientename;// Nome do usuário.
  String? email;// Endereço de e-mail do usuário.
  String? senha;//Senha do usuário (criptografada).
  String? permissao;//Nível de acesso do usuário no aplicativo.

  //Cliente({this.uid,this.clientename,this.email,this.senha,this.permissao});
  Cliente({this.clientename,this.email,this.senha,this.permissao});

}
