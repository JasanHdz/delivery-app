import 'package:delivery/constants/estados.dart';
import 'package:delivery/prefs/shared_preferences.dart';
import 'package:delivery/providers/user-provider.dart';
import 'package:delivery/utils/util.dart';
import 'package:delivery/widgets/common/button.dart';
import 'package:delivery/widgets/common/drop-down-widget.dart';
import 'package:delivery/widgets/common/text-field.dart';
import 'package:delivery/widgets/common/wrapper.dart';
import 'package:flutter/material.dart';

class OrderInformation extends StatefulWidget {
  @override
  _OrderInformationState createState() => _OrderInformationState();
}

class _OrderInformationState extends State<OrderInformation> {
  final userProvider = UserProvider();
  final _prefs = new UserPreferents();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _inputConcepto = TextEditingController();
  TextEditingController _inputNombre = TextEditingController();
  String _state = '';
  String _concepto = '';
  String _name = '';

  @override
  Widget build(BuildContext context) {
    return WrapperWidget(
      child: ListView(
        children: [
          SizedBox(height: 20.0),
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
          SizedBox(height: 20.0),
          _createForm(),
          SizedBox(height: 40.0),
          Text(
              'Con esta información podremos crear tu orden y enviarla a tu domicilio',
              style: TextStyle(fontSize: 14.0)),
          SizedBox(height: 20.0),
          Container(
            width: MediaQuery.of(context).size.width * 0.6,
            child: ButtonWidget(
                text: 'Ordenar'.toUpperCase(),
                fullWidth: true,
                callback: _handleSubmit),
          )
        ],
      ),
    );
  }

  Widget _createForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFieldWidget(
            label: 'Concepto',
            onChanged: (value) => setState(() => _concepto = value),
          ),
          SizedBox(height: 20.0),
          TextFieldWidget(
            label: 'Nombre',
            onChanged: (value) => setState(() => _name = value),
          ),
          SizedBox(height: 20.0),
          Container(
            child: DropDownWidget(
              items: estados,
              onChanged: (value) {
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

  void _handleSubmit() async {
    print(_concepto);
    print(_name);
    print(_state);
    final payload = transforValuesToFields({
      'concepto': _concepto,
      'name': _name,
      'state': _state,
    });

    await userProvider.creatOrder(_prefs.token, payload);
  }
}
