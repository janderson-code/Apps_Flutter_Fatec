import 'package:flutter/material.dart';

void main(){
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Navegação',

      //
      //ROTAS DE NAVEGAÇÃO
      //
      initialRoute: '/tela1',
      routes: {
        '/tela1': (context) => PrimeiraTela(),
        '/tela2': (context) => SegundaTela(),
        '/tela3': (context) => TerceiraTela(),
      },

    )
  );
}

//
// PRIMEIRA TELA
//
class PrimeiraTela extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Primeira Tela')),
      body: Center(
        child: ElevatedButton(
          child: Text('Próximo'),
          onPressed: (){

            //Navegar para tela indicada
            /*Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SegundaTela()
              )
            );*/

            //Navegar para tela usando rota nomeada
            Navigator.pushNamed(context, '/tela2');

          },
        )
      ),
    );
  }
}

//
// SEGUNDA TELA
//
class SegundaTela extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Segunda Tela')),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('Anterior'),
              onPressed: (){
                //Navegar para tela anterior
                Navigator.pop(context);
              },
            ),

            ElevatedButton(
              child: Text('Próximo'),
              onPressed: (){
                Navigator.pushNamed(context, '/tela3');
              },
            ),
          ],
        )
      ),
    );
  }
}

//
// TERCEIRA TELA
//
class TerceiraTela extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Terceira Tela')),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('Anterior'),
              onPressed: (){
                //Navegar para tela anterior
                Navigator.pop(context);
              },
            ),

            ElevatedButton(
              child: Text('Próximo'),
              onPressed: (){

              },
            ),
          ],
        )
      ),
    );
  }
}