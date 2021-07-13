import 'dart:math';
import 'dart:typed_data';
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pointycastle/key_generators/rsa_key_generator.dart';
import 'package:pointycastle/pointycastle.dart';
import 'package:pointycastle/random/fortuna_random.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      ),
      home: Home(),
    );
  }

}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SecureRandom getSecureRandom() {
    var secureRandom = FortunaRandom();
    var random = Random.secure();
    List<int> seeds = [];
    for (int i = 0; i < 32; i++) {
      seeds.add(random.nextInt(255));
    }
    secureRandom.seed(new KeyParameter(new Uint8List.fromList(seeds)));
    return secureRandom;
  }

  AsymmetricKeyPair<PublicKey, PrivateKey> createKeys(
      SecureRandom secureRandom) {
    var rsapars = new RSAKeyGeneratorParameters(BigInt.from(65537), 2048, 5);
    var params = new ParametersWithRandom(rsapars, secureRandom);
    var keyGenerator = new RSAKeyGenerator();
    keyGenerator.init(params);
    return keyGenerator.generateKeyPair();
  }

  @override
  void initState() {
    // TODO: implement initState
    var s = createKeys(getSecureRandom());
    print(s.publicKey.toString());
    print(s.privateKey.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              margin: EdgeInsets.only(left: 20),
              alignment: Alignment.centerLeft,
              child: Text(
                "username",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              )),
          Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.grey.shade300,
            ),
            child: TextField(
              obscureText: false,
            ),
          ),
          Container(
              margin: EdgeInsets.only(left: 20),
              alignment: Alignment.centerLeft,
              child: Text("password",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
          Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.grey.shade300,
            ),
            child: TextField(
              obscureText: true,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>Register()));
                },
                child: Container(
                  margin: EdgeInsets.only(top: 50),
                  child: Text("New user?\nRegister",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade600)),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 50),
                height: 50,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.blue.shade300,
                ),
                child: Center(
                  child: Text("Login"),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}


class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                margin: EdgeInsets.only(left: 20),
                alignment: Alignment.centerLeft,
                child: Text(
                  "username",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                )),
            Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey.shade300,
              ),
              child: TextField(
                obscureText: false,
              ),
            ),
            Container(
                margin: EdgeInsets.only(left: 20),
                alignment: Alignment.centerLeft,
                child: Text("password",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
            Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey.shade300,
              ),
              child: TextField(
                obscureText: true,
              ),
            ),
            Container(
                margin: EdgeInsets.only(left: 20),
                alignment: Alignment.centerLeft,
                child: Text("verify password",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
            Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey.shade300,
              ),
              child: TextField(
                obscureText: true,
              ),
            ),
            Container(
                margin: EdgeInsets.only(left: 20),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Enter Mobile Number",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                )),
            Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey.shade300,
              ),
              child: TextField(
                obscureText: false,
              ),
            ),


            Container(
              margin: EdgeInsets.only(top: 50),
              height: 50,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.blue.shade300,
              ),
              child: Center(
                child: Text("Register"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
@override
Widget build(BuildContext context) {
  return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      body: Padding(padding: const EdgeInsets.all(8),
        child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _phoneNumberController,
                  decoration: const InputDecoration(labelText: 'Phone number (+xx xxx-xxx-xxxx)'),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  alignment: Alignment.center,
                  child: RaisedButton(child: Text("Get current number"),
                      onPressed: () async => {
                        _phoneNumberController.text = await _autoFill.hint
                      },
                      color: Colors.greenAccent[700]),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  alignment: Alignment.center,
                  child: RaisedButton(
                    color: Colors.greenAccent[400],
                    child: Text("Verify Number"),
                    onPressed: () async {
                      verifyPhoneNumber();
                    },
                  ),
                ),
                TextFormField(
                  controller: _smsController,
                  decoration: const InputDecoration(labelText: 'Verification code'),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 16.0),
                  alignment: Alignment.center,
                  child: RaisedButton(
                      color: Colors.greenAccent[200],
                      onPressed: () async {
                        signInWithPhoneNumber();
                      },
                      child: Text("Sign in")),
                ),
              ],
            )
        ),
      )
  );

}

