//
// TELA PRINCIPAL
//
import 'dart:math';
import 'package:flutter/material.dart';

class TelaPrincipal extends StatefulWidget {
  @override
  _TelaPrincipalState createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  /* atributos */

  //Armazenar valores digitados no campo peso e altura

  var txtPeso = TextEditingController();
  var txtAltura = TextEditingController();

  //chave que identifica unicamente o formulario

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora IMC'),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                formKey.currentState.reset();
                txtPeso.text = "";
                txtAltura.text = "";
                             
              });
            },
          )
        ],
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        padding: EdgeInsets.all(40),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Icon(Icons.people,
                  size: 120, color: Theme.of(context).primaryColor),
              campoTexto('Peso', txtPeso),
              campoTexto('Altura', txtAltura),
              botao('calcular'),
            ],
          ),
        ),
      ),
    );
  }
  //
  //CAMPO DE TEXTO para entrada de dados
  //

  //
  // CAMPO DE TEXTO para entrada de dados
  //
  Widget campoTexto(rotulo, variavelControle) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: TextFormField(
          //Associar a variável ao campo de texto
          controller: variavelControle,

          // formatação estilo
          style: TextStyle(fontSize: 24),
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: rotulo,
            labelStyle: Theme.of(context).textTheme.headline1,
            hintText: 'Entre com o valor',
            hintStyle: TextStyle(fontSize: 10),
          ),

          validator: (value) {
            if (double.tryParse(value) == null) {
              return 'Entre com um valor numerico';
            } else {
              return null;
            }
          },
        ));
  }

  //
  // BOTÃO
  //
  Widget botao(rotulo) {
    return Container(
      /*Dimensões */
      padding: EdgeInsets.only(top: 40),
      width: 200,
      height: 80,

      /*Tipo Widget  ElevatedButton*/
      child: ElevatedButton(
          child: Text(
            rotulo,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () {
            //print('botão pressionado!');

            //se as info do form estão validas o calculo é feito
            if (formKey.currentState.validate()) {
              // o metodo setstate usado para alterar estado do app
              setState(() {
                // recuperar valores peso e altura
                double peso = double.parse(txtPeso.text);
                double altura = double.parse(txtAltura.text);
                
                double imc = peso / pow(altura, 2);

                
                //print('IMC: $imc');
                caixaDialogo(
                    'O resultado do cálculo do IMC foi ${imc.toStringAsFixed(2)}');
              });
            }
          }),
    );
  }

  //
  // CAIXA DE DIALOGO
  //

  caixaDialogo(msg) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Resultado'),
            content: Text(msg),
            actions: [
              TextButton(
                child: Text('fechar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
