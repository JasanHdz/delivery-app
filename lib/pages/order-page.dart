import 'package:delivery/constants/estados.dart';
import 'package:delivery/widgets/common/button.dart';
import 'package:flutter/material.dart';

class OrderInformation extends StatefulWidget {
  @override
  _OrderInformationState createState() => _OrderInformationState();
}

class _OrderInformationState extends State<OrderInformation> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _inputConcepto = TextEditingController();
  TextEditingController _inputNombre = TextEditingController();
  String _state = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          margin: EdgeInsets.symmetric(vertical: 15.0),
          child: ListView(
            children: [
              Text(
                'Crear Orden',
                style: TextStyle(color: Colors.black, fontSize: 22.0),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10.0),
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Text(
                  'Llena el formulario con la información de tu orden',
                  style: TextStyle(fontSize: 14.0),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 15.0),
              _createForm(),
              SizedBox(height: 40.0),
              _createText(
                  'Con esta información podremos crear tu orden y enviarla a tu domicilio'),
              SizedBox(height: 20.0),
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                child: ButtonWidget(
                    text: 'Ordenar'.toUpperCase(),
                    fullWidth: true,
                    callback: () {}),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _createText(String text) {
    return Text(text,
        textAlign: TextAlign.center, style: TextStyle(fontSize: 14.0));
  }

  Widget _createForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: 'Concepto'),
            controller: _inputConcepto,
            validator: _handleValidator,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Nombre'),
            controller: _inputNombre,
            validator: _handleValidator,
          ),
          SizedBox(height: 20.0),
          Container(
            child: _createDropDown(
              estados,
              (value) {
                setState(() {
                  _state = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _createDropDown(List<String> items, Function onChanged) {
    return DropdownButtonFormField(
        onChanged: onChanged,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
        value: items[0],
        items: items.map((element) {
          return DropdownMenuItem(child: Text(element), value: element);
        }).toList());
  }

  String _handleValidator(String value) {
    if (value.isEmpty) {
      return 'Esté campo es requerido';
    }
    return null;
  }
}
