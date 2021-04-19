import 'package:delivery/providers/user-provider.dart';
import 'package:delivery/widgets/common/button.dart';
import 'package:delivery/widgets/common/drawer.dart';
import 'package:delivery/widgets/common/wrapper.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userProvider = UserProvider();
  final title = 'Bienvenido';
  final greating = 'Iniciar sesión para continuar';

  String _email = '';
  String _password = '';
  String _error = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawer: DrawerWidget(),
        body: Stack(
          children: [
            DrawerWidget.burgerButton(),
            // _bodyWidget(context)
            WrapperWidget(
              child: LayoutBuilder(builder:
                  (BuildContext context, BoxConstraints viewportConstraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: viewportConstraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: _bodyWidget(context),
                    ),
                  ),
                );
              }),
            )
          ],
        ));
  }

  Widget _bodyWidget(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12.0),
                Text(title,
                    style:
                        TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold)),
                SizedBox(height: 10.0),
                Text(greating,
                    style: TextStyle(
                        fontSize: 18.0, color: Theme.of(context).primaryColor))
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 32.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Correo'),
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                },
              ),
              SizedBox(height: 32.0),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Contraseña'),
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
              ),
              SizedBox(height: 32.0),
              ButtonWidget(
                  text: 'ingresar'.toUpperCase(),
                  fullWidth: true,
                  callback: _handleSubmit),
              SizedBox(height: 12.0),
              Text('¿Olvidate tu contraseña?',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Theme.of(context).primaryColor))
            ],
          ),
        ),
        Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('¿Aún no tienes cuenta?'),
              SizedBox(height: 12.0),
              ButtonWidget(
                  text: 'registrarse'.toUpperCase(),
                  fullWidth: true,
                  primary: false,
                  callback: () =>
                      Navigator.of(context).pushReplacementNamed('registry'))
            ],
          ),
        )
      ],
    );
  }

  void _handleSubmit() async {
    print(_email);
    print(_password);
    final payload =
        await userProvider.loginWithEmailAndPassword(_email, _password);
    if (payload['ok']) {
      Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
    } else {
      setState(() {
        _error = payload['error'];
      });
    }
  }
}
