import 'package:pbplab/main.dart';
import 'package:flutter/material.dart';

class MyFormPage extends StatefulWidget {
  const MyFormPage({super.key});

  @override
  State<MyFormPage> createState() => _MyFormPageState();
}

class _MyFormPageState extends State<MyFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _namaLengkap = "";
  bool jenjangSarjana = false;
  bool jenjangDiploma = false;
  bool jenjangMagister = false;
  bool jenjangDoktor = false;

  double _umur = 0;

  String _kelasPBP = 'A';
  List<String> listKelasPBP = ['A', 'B', 'C', 'D', 'E', 'F', 'KI'];
  bool _nilaiSwitch = false;

  @override
  Widget build(BuildContext context) {
    String getJenjang() {
      if (jenjangSarjana) {
        return "Sarjana";
      } else if (jenjangDiploma) {
        return "Diploma";
      } else if (jenjangMagister) {
        return "Magister";
      } else if (jenjangDoktor) {
        return "Doktor";
      } else {
        return "Belum dipilih";
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Form'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Contoh: Pak Dengklek",
                      labelText: "Nama Lengkap",
                      icon: const Icon(Icons.people),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _namaLengkap = value!;
                      });
                    },
                    onSaved: (String? value) {
                      setState(() {
                        _namaLengkap = value!;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Nama lengkap tidak boleh kosong!';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ListTile(
                        leading: Icon(Icons.school),
                        title: Text("Jenjang"),
                      ),
                      CheckboxListTile(
                        title: const Text('Sarjana'),
                        value: jenjangSarjana,
                        onChanged: (bool? value) {
                          setState(() {
                            jenjangSarjana = value!;
                            if (value) {
                              jenjangMagister =
                                  jenjangDiploma = jenjangDoktor = false;
                            }
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: const Text('Diploma'),
                        value: jenjangDiploma,
                        onChanged: (bool? value) {
                          setState(() {
                            jenjangDiploma = value!;
                            if (value) {
                              jenjangMagister =
                                  jenjangSarjana = jenjangDoktor = false;
                            }
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: const Text('Magister'),
                        value: jenjangMagister,
                        onChanged: (bool? value) {
                          setState(() {
                            jenjangMagister = value!;
                            if (value) {
                              jenjangDiploma =
                                  jenjangSarjana = jenjangDoktor = false;
                            }
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: const Text('Doktor'),
                        value: jenjangDoktor,
                        onChanged: (bool? value) {
                          setState(() {
                            jenjangDoktor = value!;
                            if (value) {
                              jenjangMagister =
                                  jenjangSarjana = jenjangDiploma = false;
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.co_present),
                  title: Row(
                    children: [
                      Text('Umur: ${_umur.round()}'),
                    ],
                  ),
                  subtitle: Slider(
                    value: _umur,
                    max: 100,
                    divisions: 100,
                    label: _umur.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        _umur = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.class_),
                  title: const Text(
                    'Kelas PBP',
                  ),
                  trailing: DropdownButton(
                    value: _kelasPBP,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: listKelasPBP.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _kelasPBP = newValue!;
                      });
                    },
                  ),
                ),
                SwitchListTile(
                  title: const Text('Practice Mode'),
                  value: _nilaiSwitch,
                  onChanged: (bool value) {
                    setState(() {
                      _nilaiSwitch = value;
                    });
                  },
                  secondary: const Icon(Icons.run_circle_outlined),
                ),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 15,
                            child: Container(
                              child: ListView(
                                padding:
                                    const EdgeInsets.only(top: 20, bottom: 20),
                                shrinkWrap: true,
                                children: <Widget>[
                                  const Center(
                                      child: Text(
                                    'Informasi Data',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )),
                                  const SizedBox(height: 20),
                                  Center(
                                      child:
                                          Text('Nama Lengkap: $_namaLengkap')),
                                  const SizedBox(height: 5),
                                  Center(
                                      child: Text('Jenjang: ${getJenjang()}')),
                                  const SizedBox(height: 5),
                                  Center(child: Text('Umur: ${_umur.round()}')),
                                  const SizedBox(height: 5),
                                  Center(child: Text('Kelas PBP: $_kelasPBP')),
                                  const SizedBox(height: 5),
                                  Center(
                                      child: Text(
                                          'Practice Mode?: $_nilaiSwitch')),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'Kembali',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                  child: const Text(
                    "Simpan",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
