import 'package:flutter/material.dart';
import 'carrosWidget.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false, //Tirar o simbolo de banner que vem padrão
    title: 'Carros',
    home: TelaPrincipal(),
  ));
}

class TelaPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Carros')),
      body: SingleChildScrollView( //Colocando para habilitar tela modo scrool
              child: Column(children: [
          Text('Lista de Carros Disponíveis'),
          CarroWidget('Audi','Q8','lib/imagens/audi_q8.jpg'),
          CarroWidget('Audi','R8','lib/imagens/audi_r8.jpg'),
          CarroWidget('BMW','m2','lib/imagens/bmw_m2.jpg'),
          CarroWidget('Ferrari','488','lib/imagens/ferrari_488.jpg'),
          CarroWidget('Lamborguini','Huracan','lib/imagens/lamborguini_huracan.jpg'),
          CarroWidget('Lamborguini','Urus','lib/imagens/lamborguini_urus.jpg'),
          CarroWidget('Maserati','GTS','lib/imagens/maserati_gts.jpg'),
        ]),
      ),
    );
  }
}
