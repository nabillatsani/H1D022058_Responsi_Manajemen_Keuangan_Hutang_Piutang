import 'package:flutter/material.dart';
import '../models/hutang_piutang.dart';
import '../services/api_service.dart';

class AddEditPage extends StatefulWidget {
  final HutangPiutang? hutangPiutang;

  AddEditPage({this.hutangPiutang});

  @override
  _AddEditPageState createState() => _AddEditPageState();
}

class _AddEditPageState extends State<AddEditPage> {
  final _formKey = GlobalKey<FormState>();
  late String _person;
  late int _amount;
  late String _status;

  @override
  void initState() {
    super.initState();
    if (widget.hutangPiutang != null) {
      _person = widget.hutangPiutang!.person;
      _amount = widget.hutangPiutang!.amount;
      _status = widget.hutangPiutang!.status;
    } else {
      _person = '';
      _amount = 0;
      _status = 'Belum Lunas';
    }
  }

  // Menampilkan dialog jika ada data yang belum lengkap
  void _showIncompleteDataDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Data Tidak Lengkap'),
          content: Text('Silakan lengkapi semua data sebelum melanjutkan.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Menutup dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.hutangPiutang == null ? 'Tambah Data' : 'Edit Data'),
        backgroundColor: Colors.orange,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange.shade300, Colors.yellow.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white, // Background putih untuk konten
              borderRadius: BorderRadius.circular(15), // Sudut melengkung
            ),
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0), // Padding dalam kotak
            constraints: BoxConstraints(
              maxWidth: 400, // Lebar maksimum
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min, // Menyesuaikan tinggi dengan konten
                children: [
                  TextFormField(
                    initialValue: _person,
                    decoration: InputDecoration(labelText: 'Nama Orang'),
                    onSaved: (value) {
                      _person = value!;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nama harus diisi';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    initialValue: _amount.toString(),
                    decoration: InputDecoration(labelText: 'Jumlah'),
                    keyboardType: TextInputType.number,
                    onSaved: (value) {
                      _amount = int.parse(value!);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Jumlah harus diisi';
                      }
                      if (int.tryParse(value) == null || int.parse(value) <= 0) {
                        return 'Jumlah harus berupa angka positif';
                      }
                      return null;
                    },
                  ),
                  DropdownButtonFormField<String>(
                    value: _status,
                    items: ['Belum Lunas', 'Lunas'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _status = newValue!;
                      });
                    },
                    decoration: InputDecoration(labelText: 'Status'),
                    validator: (value) {
                      if (value == null) {
                        return 'Status harus dipilih';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        if (widget.hutangPiutang == null) {
                          ApiService().createHutangPiutang(HutangPiutang(
                            id: 0,
                            person: _person,
                            amount: _amount,
                            status: _status,
                          ));
                        } else {
                          ApiService().updateHutangPiutang(
                            widget.hutangPiutang!.id,
                            HutangPiutang(
                              id: widget.hutangPiutang!.id,
                              person: _person,
                              amount: _amount,
                              status: _status,
                            ),
                          );
                        }
                        Navigator.pop(context); // Kembali ke halaman sebelumnya
                      } else {
                        _showIncompleteDataDialog(); // Tampilkan dialog jika data tidak lengkap
                      }
                    },
                    child: Text(widget.hutangPiutang == null ? 'Tambah' : 'Edit'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange.shade300,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
