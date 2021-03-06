import 'package:flutter/material.dart';
import 'package:flutter_grocery_list/models/shopping_list.dart';
import 'package:flutter_grocery_list/util/dbHelper.dart';

class ShoppingListDialog {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtPriority = TextEditingController();

  Widget buildDialog(BuildContext context, ShoppingList list, bool isNew) {
    if (!isNew) {
      txtName.text = list.name;
      txtPriority.text = list.priority.toString();
    } else {
      txtName.text = "";
      txtPriority.text = "";
    }
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      title: Text(isNew ? "Nueva Lista" : "Editar lista"),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: txtName,
              decoration: InputDecoration(hintText: "Nombre de la lista"),
            ),
            TextField(
              controller: txtPriority,
              decoration: InputDecoration(hintText: "Prioridad (1-3)"),
              keyboardType: TextInputType.number,
            ),
            RaisedButton(
              child: Text("Guardar Lista"),
              onPressed: () async {
                list.name = txtName.text;
                list.priority = int.tryParse(txtPriority.text);
                DbHelper helper = DbHelper();
                await helper.openDb();
                await helper.insertList(list);
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
