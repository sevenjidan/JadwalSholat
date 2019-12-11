import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jadwal_sholat/model/ResponJadwal.dart';

import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
      home: MyHomeScreen(),
    ));

class MyHomeScreen extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MyHomeScreen> {
  //Membuat request data
  Future<ResponJadwal> getJadwal() async {
    //Ngambil json yang ada di url
    final response = await http.get(
        "https://muslimsalat.com/jonggol.json?key=e2e0511ab6d09a2e19f7e0d1ecf19024");
    //memilah (decoce) json dari variable response
    final jsonResponse = json.decode(response.body);

    return ResponJadwal.fromJsonMap(jsonResponse);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: <Widget>[
      Stack(
        children: <Widget>[
          Container(
            color: Colors.grey,
            height: MediaQuery.of(context).size.width - 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 6.0,
                      offset: Offset(0.0, 2.0),
                      color: Colors.black26)
                ],
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        "https://i.pinimg.com/originals/f6/4a/36/f64a368af3e8fd29a1b6285f3915c7d4.jpg"))),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                    color: Colors.white,
                    icon: Icon(Icons.location_on),
                    onPressed: () {}),
                IconButton(
                    color: Colors.white,
                    icon: Icon(Icons.map),
                    onPressed: () {}),
              ],
            ),
          ),
          FutureBuilder()
        ],
      ),
    ]));
  }

  Widget containerWaktu(String waktu, String jam) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Container(
          padding: EdgeInsets.all(16.0),
          height: 70.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5.0)],
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Color(0xffffffff), Color(0xfffffff)])),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                waktu,
                style: TextStyle(color: Colors.white, fontSize: 24.0),
              ),
              Text(
                jam,
                style: TextStyle(color: Colors.white, fontSize: 24.0),
              ),
            ],
          )),
    );
  }
}

class HeaderContent extends StatelessWidget {
  HeaderContent(data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[


        ],
      ),
    );
  }
}

class ListJadwal extends StatelessWidget {
  ResponJadwal data;

  ListJadwal(this.data);

  Widget containerWaktu(String waktu, String jam) {}
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        containerWaktu(
          "Subuh",
          data.items[0].fajr.toUpperCase(),
        ),
        containerWaktu(
          "Dzuhur",
          data.items[0].dhuhr.toUpperCase(),
        ),
        containerWaktu(
          "Ashar",
          data.items[0].asr.toUpperCase(),
        ),
        containerWaktu(
          "Maghrib",
          data.items[0].maghrib,
        ),
        containerWaktu(
          "Isya",
          data.items[0].isha,
        ),
      ],
    );
  }
}
