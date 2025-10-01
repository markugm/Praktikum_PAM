import 'package:flutter/material.dart';
import 'vehicle-data.dart'; 
import 'login-page.dart';
import 'detail-page.dart';

class HomePage extends StatelessWidget {
  final String username;
  
  // Menerima username dari LoginPage
  const HomePage({super.key, required this.username});

  // Fungsi untuk logout dan kembali ke LoginPage
  void _logout(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (Route<dynamic> route) => false, // Hapus semua route sebelumnya
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Kendaraan'),
        backgroundColor: Colors.teal,
        actions: [
          // Tombol Logout
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Selamat Datang {username}
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Selamat datang, $username!',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal),
            ),
          ),
          const Divider(height: 1, color: Colors.grey),
          // List Kendaraan
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 kolom untuk tampilan yang lebih menarik
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 12.0,
                childAspectRatio: 0.75, // Ratio untuk tampilan card yang lebih proporsional
              ),
              itemCount: vehicleList.length,
              itemBuilder: (BuildContext context, int index) {
                final vehicle = vehicleList[index];
                return InkWell(
                  onTap: () {
                    // Navigasi ke DetailPage saat card diklik
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(vehicle: vehicle),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Gambar dengan layout yang rapi
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0)),
                            child: Image.network(
                              vehicle.imageUrls.first, // Ambil gambar pertama dari list
                              fit: BoxFit.cover,
                              width: double.infinity,
                              // ErrorBuilder untuk gambar yang tidak muncul (sesuai NOTE)
                              errorBuilder: (context, error, stackTrace) => 
                                const Center(child: Icon(Icons.image_not_supported, color: Colors.grey)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                vehicle.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${vehicle.type} | ${vehicle.fuelType}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                vehicle.price,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.teal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}