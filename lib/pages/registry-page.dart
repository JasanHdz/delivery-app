import 'package:delivery/constants/estados.dart';
import 'package:delivery/providers/user-provider.dart';
import 'package:delivery/utils/util.dart';
import 'package:delivery/widgets/common/button.dart';
import 'package:delivery/widgets/common/drawer.dart';
import 'package:delivery/widgets/common/wrapper.dart';
import 'package:flutter/material.dart';

class RegistryPage extends StatefulWidget {
  @override
  _RegistryPageState createState() => _RegistryPageState();
}

class _RegistryPageState extends State<RegistryPage> {
  final userProvider = UserProvider();
  final title = '¡Hola!';
  final greating = 'Crea una nueva cuenta';
  final userItems = ['Cliente', 'Vendedor'];

  String _fullName = '';
  String _lastName = '';
  String _largeName = '';
  String _address = '';
  String _state = '';
  String _user = '';
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawer: DrawerWidget(),
        bottomNavigationBar: Container(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.038,
              right: MediaQuery.of(context).size.width * 0.038,
              bottom: MediaQuery.of(context).size.width * 0.038),
          // height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(padding: EdgeInsets.only(top: 10.0)),
              Text('¿Ya tienes una cuenta?'),
              SizedBox(height: 5.0),
              ButtonWidget(
                  text: 'iniciar sesión'.toUpperCase(),
                  fullWidth: true,
                  primary: false,
                  callback: () =>
                      Navigator.of(context).pushReplacementNamed('login'))
            ],
          ),
        ),
        body: Stack(
          children: [
            DrawerWidget.burgerButton(),
            WrapperWidget(
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 24.0),
                    width: MediaQuery.of(context).size.width,
                    child: _message,
                  ),
                  Container(
                    child: Column(children: _createForm()),
                  ),
                ],
              ),
            )
          ],
        ));
  }

  List<Widget> _createForm() {
    final spaceHeight = 20.0;
    final spaceWidth = 12.0;
    return [
      _createTextField(
          label: 'Nombres(s)',
          type: TextInputType.name,
          onChanged: (value) {
            setState(() {
              _fullName = value;
            });
          }),
      SizedBox(height: spaceHeight),
      Row(children: [
        Flexible(
          child: _createTextField(
              label: 'Apellido Paterno',
              type: TextInputType.name,
              onChanged: (value) {
                setState(() {
                  _lastName = value;
                });
              }),
        ),
        SizedBox(width: spaceWidth),
        Flexible(
          child: _createTextField(
              label: 'Apellido Materno',
              type: TextInputType.name,
              onChanged: (value) {
                setState(() {
                  _largeName = value;
                });
              }),
        )
      ]),
      SizedBox(height: spaceHeight),
      _createTextField(
          label: 'Dirección',
          type: TextInputType.emailAddress,
          onChanged: (value) {
            setState(() {
              _address = value;
            });
          }),
      SizedBox(height: spaceHeight),
      Row(children: [
        Flexible(
          child: _createDropDown(estados, (value) {
            setState(() {
              _state = value;
            });
          }),
        ),
        SizedBox(width: spaceWidth),
        Flexible(
            child: _createDropDown(userItems, (value) {
          _user = value;
        }))
      ]),
      SizedBox(height: spaceHeight),
      _createTextField(
          label: 'Email',
          type: TextInputType.emailAddress,
          onChanged: (value) {
            setState(() {
              _email = value;
            });
          }),
      SizedBox(height: spaceHeight),
      _createTextField(
          label: 'Password',
          obscureText: true,
          type: TextInputType.visiblePassword,
          onChanged: (value) {
            setState(() {
              _password = value;
            });
          }),
      SizedBox(height: spaceHeight),
      ButtonWidget(
          text: 'registrarme'.toUpperCase(),
          fullWidth: true,
          callback: _handleSubmit),
      SizedBox(height: 5.0),
      Text('¿Olvidate tu contraseña?',
          textAlign: TextAlign.center,
          style: TextStyle(color: Theme.of(context).primaryColor)),
      SizedBox(height: 50.0),
    ];
  }

  Widget _createTextField(
      {String label,
      TextInputType type = TextInputType.text,
      Function onChanged,
      bool obscureText = false}) {
    return TextField(
      obscureText: obscureText,
      decoration:
          InputDecoration(border: OutlineInputBorder(), labelText: label),
      onChanged: onChanged,
      keyboardType: type,
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
          return DropdownMenuItem(
              child: Text(
                element,
                style: TextStyle(fontSize: 13.5),
              ),
              value: element);
        }).toList());
  }

  Widget get _message {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 12.0),
        Text(title,
            style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold)),
        SizedBox(height: 10.0),
        Text(greating,
            style: TextStyle(
                fontSize: 18.0, color: Theme.of(context).primaryColor))
      ],
    );
  }

  void _handleSubmit() async {
    final payload = transforValuesToFields({
      'name': _fullName,
      'lastName': _lastName,
      'largeName': _largeName,
      'address': _address,
      'state': _state,
      'user': _user,
      'email': _email,
    });
    // print(payload);
    final user = await UserProvider().createUser(_email, _password);
    await UserProvider().registerUserData(user, payload);

    if (user['ok']) {
      Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
    }
  }
}
