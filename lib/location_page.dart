import 'package:flutter/material.dart';
import 'package:geo/map_page.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationPage extends StatelessWidget {
  const LocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 80, 24, 80),
            child: Column(children: <Widget>[
              Image.asset("assets/images/global.png"),
              SizedBox(height: 26),
              Text(
                "Compartilhe sua localização",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 26),
              Text(
                  "Para o GPS funcionar corretamente, vamos precisar da localização do seu dispositivo."),
              SizedBox(height: 26),
              InkWell(
                onTap: () async {
                  await Permission.location.request();
                  if (await Permission.location.isGranted) {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MapPage()));
                  } else {
                    showDialog(context: context, builder: (context) {
                      return AlertDialog(
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text("OK"),
                          ),
                        ],
                        title: Text("Permissão negada"),
                        content: Text("É necessário permitir a localização para utilizar o app"),
                      );
                    });
                  }
                },
                borderRadius: BorderRadius.circular(30),
                child: Ink(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color(0xFF4D5BD9),
                  ),
                  child: Text(
                    "Compartilhar localização",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextButton(
                  onPressed: () {},
                  child: Text("Agora não",
                      style: TextStyle(
                        color: Color(0xFF4D5BD9),
                      ))),
            ]),
          ),
        ));
  }
}
