import 'package:flutter/material.dart';
import 'package:string_encryption/string_encryption.dart';

class Enkripsi extends StatefulWidget {
  const Enkripsi({Key? key}) : super(key: key);

  @override
  _EnkripsiState createState() => _EnkripsiState();
}

class _EnkripsiState extends State<Enkripsi> {
  var textCtrl = TextEditingController();

  String _randomKey = "";
  String _encrypted = "";
  String _decrypted = "";
  bool _isEncrypted = false;
  bool _isDecrypted = false;
  final cryptor = StringEncryption();

  encrypt() async {
    final key = await cryptor.generateRandomKey();
    final encrypted = await cryptor.encrypt(textCtrl.text, key!);

    setState(() {
      _randomKey = key;
      _encrypted = encrypted!;

      _isEncrypted = true;
    });
  }

  decrypt() async {
    final decrypted = await cryptor.decrypt(_encrypted, _randomKey);
    setState(() {
      _decrypted = decrypted!;
      _isDecrypted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Text Encrypt"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 20, right: 20, left: 20),
          child: Column(
            children: [
              TextField(
                controller: textCtrl,
                decoration: InputDecoration(
                  hintText: 'input Text',
                  hintStyle: const TextStyle(color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  isDense: true, // Added this
                  contentPadding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                ),
                cursorColor: Colors.white,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.enhanced_encryption),
                    label: const Text('Encrypt'),
                    onPressed: () {
                      encrypt();
                    },
                  ),
                  if (_isEncrypted)
                    ElevatedButton.icon(
                      icon: const Icon(Icons.no_encryption),
                      label: const Text('Decrypt'),
                      onPressed: () {
                        decrypt();
                      },
                    ),
                ],
              ),
              if (_isEncrypted)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Key : ",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.grey,
                                blurRadius: 2.0,
                                offset: Offset(2.0, 2.0))
                          ]),
                      child: Text(
                        _randomKey,
                        style:
                            const TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Encription : ",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.grey,
                                blurRadius: 2.0,
                                offset: Offset(2.0, 2.0))
                          ]),
                      child: Text(
                        _encrypted,
                        style:
                            const TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    )
                  ],
                ),
              const SizedBox(
                height: 20,
              ),
              if (_isDecrypted)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Decrypted : ",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.grey,
                                blurRadius: 2.0,
                                offset: Offset(2.0, 2.0))
                          ]),
                      child: Text(
                        _decrypted,
                        style:
                            const TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
