import 'package:flutter/material.dart';

//
// BLOCO PRINCIPAL
//
void main(){

  //Indicar qual a UI do App será exibida
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meu primeiro App',
      home: TelaPrincipal(),
    )
  );

}

//
// TELA PRINCIPAL
//
class TelaPrincipal extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("App"),
        backgroundColor:Colors.deepOrange,
      ),
      body: Text("Este é o meu primeiro App com Flutter"),
      backgroundColor: Colors.grey[200],
    );
  }

}




