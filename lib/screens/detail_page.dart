import 'package:flutter/material.dart';
import '../models/hutang_piutang.dart';
import '../services/api_service.dart';
import 'add_edit_page.dart';

class DetailPage extends StatelessWidget {
  final HutangPiutang hutangPiutang;

  DetailPage({required this.hutangPiutang});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${hutangPiutang.person} - Detail'),
        backgroundColor: Colors.orange,
        elevation: 0,
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
              color: Colors.white, // Orange background for the content box
              borderRadius: BorderRadius.circular(15), // Rounded corners
            ),
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0), // Adjusted padding
            constraints: BoxConstraints(
              maxWidth: 400, // Maximum width to prevent excessive size
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Display information inside the orange box
                Text(
                  'Nama: ${hutangPiutang.person}',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  'Jumlah: Rp ${hutangPiutang.amount}',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  'Status: ${hutangPiutang.status}',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Edit Button with yellow color
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddEditPage(hutangPiutang: hutangPiutang),
                          ),
                        );
                      },
                      child: Text('Edit'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange.shade300, 
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ),
                    ),
                    // Delete Button
                    ElevatedButton(
                      onPressed: () {
                        ApiService().deleteHutangPiutang(hutangPiutang.id);
                        Navigator.pop(context);
                      },
                      child: Text('Hapus'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
