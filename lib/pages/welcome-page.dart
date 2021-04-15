import 'package:delivery/widgets/common/button.dart';
import 'package:delivery/widgets/common/drawer.dart';
import 'package:delivery/widgets/common/wrapper.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  final title = 'Hola';
  final description = 'El mejor lugar para vender y comprar, en logistic puedes enviar tus productos a cualquier lugar de la republica méxicana.';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: DrawerWidget(),
      body: Stack(
        children: [
          DrawerWidget.burgerButton(),
          WrapperWidget(
            child: Column(
              children: [
                Image(image: AssetImage('auth.png')),
                Container(
                  child: Column(
                    children: [
                      Text(title, style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
                      SizedBox(height: 12.0),
                      Text(
                        description, 
                        textAlign: TextAlign.center, 
                        style: TextStyle(fontSize: 16.0, color: Color(0xFF959595), fontWeight: FontWeight.bold)
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ButtonWidget(
                          text: 'Registrarse'.toUpperCase(), 
                          callback: _useRoute(context, 'registry'),
                          fullWidth: true,
                        ),
                        SizedBox(height: 20.0),
                        ButtonWidget(
                          text: 'Iniciar Sesión'.toUpperCase(), 
                          callback: _useRoute(context, 'login'),
                          fullWidth: true,
                          primary: false,
                        ),
                      ]
                    )
                  )
                ),
              ],
            ),
          ),
        ],
      )
    );
  }

  Function _useRoute(BuildContext context, path) {
    return () => Navigator.pushNamed(context, path);
  }
}
