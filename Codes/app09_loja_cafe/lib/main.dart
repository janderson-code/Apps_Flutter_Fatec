import 'package:app09_loja_cafe/criarconta.dart';
import 'package:app09_loja_cafe/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'model/cafe.dart';

Future<void> main() async {
  //Inicializar o FIRESTORE
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/login',
    routes: {
      '/principal': (context) => TelaPrincipal(),
      '/cadastro': (context) => TelaCadastro(),
      '/login': (context) => TelaLogin(),
      '/criarconta': (context) => TelaCriarConta(),
    },
  ));

  //
  // TESTE DO FIRESTORE
  //
  /*
  var db = FirebaseFirestore.instance;

  //Adicionar um novo DOCUMENTO
  db.collection('cafes').add(
    {
      'nome' : 'Café Fatec Ribeirão 1 Kg',
      'preco': '14,68',
    }
  );
  */
}

//
// TELA PRINCIPAL
//
class TelaPrincipal extends StatefulWidget {
  @override
  _TelaPrincipalState createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  //Referenciar a coleção nomeada "cafes"
  late CollectionReference cafes;

  @override
  void initState() {
    super.initState();
    cafes = FirebaseFirestore.instance.collection("cafes");
  }

  //
  // Definir a aparência de como cada documento deve ser exibido
  //
  Widget exibirDocumento(item) {
    //Converter um DOCUMENTO em um OBJETO
    Cafe cafe = Cafe.fromJson(item.data(), item.id);

    return ListTile(
        title: Text(cafe.nome, style: TextStyle(fontSize: 26)),
        subtitle: Text('R\$ ${cafe.preco}',
            style: TextStyle(fontSize: 22, fontStyle: FontStyle.italic)),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            //
            // Apagar um documento da coleção "cafes"
            //
            cafes.doc(cafe.id).delete();
          },
        ),
        onTap: () {
          Navigator.pushNamed(context, '/cadastro', arguments: cafe.id);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Café Store'),
        centerTitle: true,
        backgroundColor: Colors.brown,
      ),
      backgroundColor: Colors.brown[50],

      //
      // Exibir os documentos
      //
      body: Container(
        padding: EdgeInsets.all(30),
        child: StreamBuilder<QuerySnapshot>(

            //fonte de dados
            stream: cafes.snapshots(),

            //aparência
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Center(child: Text('Erro ao conectar ao Firestore'));

                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());

                default:
                  //dados recebidos do Firestore
                  final dados = snapshot.requireData;

                  return ListView.builder(
                      itemCount: dados.size,
                      itemBuilder: (context, index) {
                        return exibirDocumento(dados.docs[index]);
                      });
              }
            }),
      ),

      floatingActionButton: FloatingActionButton(
          foregroundColor: Colors.white,
          backgroundColor: Colors.brown,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, '/cadastro');
          }),
    );
  }
}

//
// TELA CADASTRO
//
class TelaCadastro extends StatefulWidget {
  @override
  _TelaCadastroState createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  var txtNome = TextEditingController();
  var txtPreco = TextEditingController();

  void getDocumentById(id) async {
    await FirebaseFirestore.instance
        .collection('cafes')
        .doc(id)
        .get()
        .then((resultado) {
      txtNome.text = resultado.get('nome');
      txtPreco.text = resultado.get('preco');
    });
  }

  @override
  Widget build(BuildContext context) {
    var id = ModalRoute.of(context)?.settings.arguments;

    if (id != null) {
      if (txtNome.text == '' && txtPreco.text == '') {
        getDocumentById(id);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Café Store'),
        centerTitle: true,
        backgroundColor: Colors.brown,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.brown[50],
      body: Container(
        padding: EdgeInsets.all(30),
        child: ListView(children: [
          TextField(
            controller: txtNome,
            style: TextStyle(color: Colors.brown, fontSize: 36),
            decoration: InputDecoration(
              labelText: 'Nome',
              labelStyle: TextStyle(color: Colors.brown, fontSize: 22),
            ),
          ),
          SizedBox(height: 30),
          TextField(
            controller: txtPreco,
            style: TextStyle(color: Colors.brown, fontSize: 36),
            decoration: InputDecoration(
              labelText: 'Preço',
              labelStyle: TextStyle(color: Colors.brown, fontSize: 22),
            ),
          ),
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 150,
                child: OutlinedButton(
                  child: Text('salvar'),
                  onPressed: () {
                    var db = FirebaseFirestore.instance;

                    if (id == null) {
                      //Adicionar um novo DOCUMENTO
                      db.collection('cafes').add({
                        'nome': txtNome.text,
                        'preco': txtPreco.text,
                      });
                    } else {
                      db.collection('cafes').doc(id.toString()).update({
                        'nome': txtNome.text,
                        'preco': txtPreco.text,
                      });
                    }
                    Navigator.pop(context);
                  },
                ),
              ),
              Container(
                width: 150,
                child: OutlinedButton(
                  child: Text('cancelar'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
