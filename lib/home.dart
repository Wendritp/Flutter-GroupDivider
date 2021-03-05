import 'package:flutter/material.dart';
import 'dart:core';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController listNameController = TextEditingController();
  final TextEditingController lengthGroupController = TextEditingController();

  totalnama() {
    // ignore: non_constant_identifier_names
    var list_namanya = this.listNameController.text.split("\n");
    var hitung = 0;
    for (var i = 0; i < list_namanya.length; i++) {
      var e = list_namanya[i];
      if (e != "") {
        hitung++;
      }
    }
    return hitung;
  }

  tampil() {
    List<String> tampl = this.listNameController.text.split("\n");
    String asp = tampl.toString();
    return asp;
  }

  buatkel() {
    String nama = this.listNameController.text;

    int bagi = int.parse(this.lengthGroupController.text);

    final listNama = nama.split('\n');
    listNama.shuffle();

    final groupNama = createGroup(data: listNama, groupNumber: bagi);
    print(groupNama);
    groupNama.forEach((items) {
      items.forEach((item) {
        print(item);
      });
    });
    return groupNama.toString();
  }

  List<dynamic> createGroup({List data, int groupNumber}) {
    List _groups = List(groupNumber);
    List dataTemp = List.from(data);
    int _groupStepIteration = groupNumber;
    int i = 0;

    while (true) {
      List _temp = [];

      for (i; i < _groupStepIteration; i++) {
        // add data to temp
        if (dataTemp.asMap().containsKey(i)) {
          _temp.add(dataTemp[i]);
        }
      }

      // random data in temp
      _temp.shuffle();

      if (_temp.isNotEmpty) {
        // add data to each group element
        _temp.asMap().forEach((index, item) {
          if (_groups[index] == null) {
            _groups[index] = [item];
          } else {
            _groups[index] = [
              ..._groups[index],
              ...[item]
            ];
          }
        });
      } else {
        // stop if empty
        break;
      }

      // next step iteration
      _groupStepIteration += groupNumber;
    }

    // random data in group
    _groups.shuffle();

    return _groups;
  }

  List<dynamic> chunk({List data, int chunkSize}) {
    var chunks = [];
    int n = data.length;
    for (var i = 0; i < n; i += chunkSize) {
      int size = i + chunkSize;
      final _temp = data.sublist(i, size > n ? n : size);

      chunks.add(_temp);
      if (_temp.length < chunkSize) {
        chunks.removeLast();
        final lastIndex = chunks.length;

        chunks[lastIndex - 1] = [...chunks.last, ..._temp];
      }
    }
    return chunks;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pembagi Kelompok Acak")),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 25,
                ),
                TextFormField(
                  controller: listNameController,
                  minLines: 4,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                      labelText: "Masukkan List Nama",
                      hintText: "Masukkan Nama : Contoh \nabidin \njajang",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                Text("Jumlah Nama = ${totalnama()}"),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: lengthGroupController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Jumlah kelompok",
                      hintText: 'Jumlah Kelompok ',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
                Container(
                    child: RaisedButton(
                        child: Text("Gass"),
                        onPressed: () {
                          setState(() {
                            buatkel();
                          });
                        })),
                Text("output : ${buatkel()}")
              ],
            ),
          )
        ],
      ),
    );
  }
}
