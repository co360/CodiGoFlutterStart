import 'package:flutter/material.dart';
import 'package:flutter_grocery_list/models/shopping_list.dart';
import 'package:flutter_grocery_list/routes/items_screen.dart';
import 'package:flutter_grocery_list/util/dbHelper.dart';
import 'package:flutter_grocery_list/widgets/shopping_list_dialog.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: GroceryList(),
    );
  }
}

class GroceryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ShList();
  }
}

class ShList extends StatefulWidget {
  @override
  _ShListState createState() => _ShListState();
}

class _ShListState extends State<ShList> {
  DbHelper helper = DbHelper();
  List<ShoppingList> shoppingList;
  ShoppingListDialog dialog = ShoppingListDialog();

  Future showData() async {
    await helper.openDb();
    shoppingList = await helper.getLists();
    setState(() {
      shoppingList = shoppingList;
    });
  }

  @override
  Widget build(BuildContext context) {
    showData();
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de compras"),
      ),
      body: Column(
        children: [
          // RaisedButton(
          //   onPressed: () async {
          //     await helper
          //         .insertList(ShoppingList(0, "Lista Agreada Boton", 1));
          //     showData();
          //   },
          // ),
          Expanded(
            child: ListView.builder(
                itemCount: shoppingList != null ? shoppingList.length : 0,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(shoppingList[index].name),
                    background: Container(
                      color: Colors.red,
                    ),
                    onDismissed: (direction) {
                      String name = shoppingList[index].name;
                      helper.deleteList(shoppingList[index]);
                      setState(() {
                        shoppingList.removeAt(index);
                      });
                      // Es como si estuvieramos llamando al metodo de su padre
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text('Eliminado: $name')));
                    },
                    child: ListTile(
                      title: Text(shoppingList[index].name),
                      leading: CircleAvatar(
                        child: Text(shoppingList[index].priority.toString()),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => dialog.buildDialog(
                                  context, shoppingList[index], false));
                        },
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (c) {
                            return ItemsScreen(shoppingList[index]);
                          },
                        ));
                      },
                    ),
                  );
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) =>
                  dialog.buildDialog(context, ShoppingList(0, "", 0), true));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
