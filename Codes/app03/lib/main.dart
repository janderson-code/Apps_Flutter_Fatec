import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'app03',
    home: TelaPrincipal(),
  ));
}

//--------------------------
// Tela principal
//--------------------------
// digitar stl e dar tab na primeira opção para aparecer extend abaixo

class TelaPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold /*Widget para a bar no topo da tela*/ (
        appBar: AppBar(
        title: Text('Layout com fluuter'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          Text('Texto de Exemplo 1'),
          Text('Texto de Exemplo 2'),
          Row(
            children: [
              
              Container(
                width: 200,
                height: 200,
                color: Colors.deepPurple[100],
                child: Icon(Icons.home, size: 60),
              ),
              Container(
                width: 200,
                height: 200,
                color: Colors.deepPurple[100],
                child: Icon(Icons.home, size: 60),
              ),
              Container(
                color: Colors.deepOrange,
                child: Column(
                  children: [
                    Text('Texto 1'),
                    Text('Texto 2'),
                    Text('Texto 3'),
                  ],
                ),
              ),
              Container(
                color: Colors.pink,
                width: 500,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
