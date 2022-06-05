import 'package:flutter/material.dart';
import 'package:quick_chat_app/service/socket_service.dart';
import 'package:quick_chat_app/utils/constants.dart';
import 'package:quick_chat_app/views/chat/chat_page.dart';

class SetupPage extends StatelessWidget {
  const SetupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var name = '';

    proceed() {
      if (name.length < 3) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Favor de ingresar un nombre')));
      } else {
        SocketService.setUserName(name);
        SocketService.connectAndListen();
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const ChatPage(),
        ));
      }
    }

    return Scaffold(
      // backgroundColor: Color.fromARGB(190, 0, 255, 179),
      appBar: AppBar(centerTitle: true, title: const Text(appName)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
              width: size.width * 0.6,
              child: TextField(
                textAlign: TextAlign.center,
                autofocus: true,
                onChanged: (s) {
                  name = s;
                },
                onSubmitted: (s) => proceed(),
                decoration: const InputDecoration(
                    hintText: 'Ingresa tu nombre',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder()),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
                onPressed: () => proceed(), child: const Text('Conectarse')),
            SizedBox(height: size.height * 0.3),
            // const Text(
            //   'Made with Flutter and Node.js',
            //   style: TextStyle(fontSize: 11, color: Colors.grey),
            // )
          ],
        ),
      ),
    );
  }
}
