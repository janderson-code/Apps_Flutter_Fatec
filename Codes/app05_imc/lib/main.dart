import 'package:app06_imc/homePage.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora IMC',

      //Tema
      theme: ThemeData(
        
        primaryColor: Colors.blue[900],
        backgroundColor: Colors.white,
        fontFamily: 'Roboto',
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 24,color: Colors.black)
        ),

      ),
      home: TelaPrincipal(),
    )
  );
}

