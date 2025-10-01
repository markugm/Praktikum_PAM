import 'package:flutter/material.dart';
import 'vehicle-data.dart';
import 'main.dart';

class DetailPage extends StatelessWidget {
  final Vehicle vehicle;

  const DetailPage({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(vehicle.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Galeri Gambar dengan tampilan yang lebih lapang
            SizedBox(
              height: 200, // Tinggi gambar 
              width: double.infinity,
              child: PageView.builder(
                itemCount: vehicle.imageUrls.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    // Mengganti Padding menjadi Container dengan Decoration
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        // Menambahkan border
                        border: Border.all(
                          color: primaryColor.withOpacity(0.5), // Warna border sedikit transparan
                          width: 2.5, // Ketebalan border
                        ),
                        // Menambahkan shadow tipis (opsional, tapi bagus untuk tampilan modern)
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      // ClipRRect diletakkan di dalam Container
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.network(
                          vehicle.imageUrls[index],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => 
                            const Center(child: Icon(Icons.broken_image, size: 100, color: Colors.grey)),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Nama dan Harga
                  Text(
                    vehicle.name,
                    style: const TextStyle(
                      fontSize: 32, 
                      fontWeight: FontWeight.w900,
                      color: primaryColor, 
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    vehicle.price,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: accentColor, // Harga dengan warna aksen
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Deskripsi
                  const Text(
                    'Deskripsi Produk',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Divider(color: Colors.grey, thickness: 1, height: 1),
                  const SizedBox(height: 10),
                  Text(
                    vehicle.description,
                    style: const TextStyle(
                      fontSize: 16, 
                      height: 1.5,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Spesifikasi
                  const Text(
                    'Spesifikasi Utama',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Divider(color: Colors.grey, thickness: 1, height: 1),
                  const SizedBox(height: 10),
                  _buildSpecificationRow(Icons.category, 'Tipe', vehicle.type),
                  _buildSpecificationRow(Icons.precision_manufacturing, 'Mesin', vehicle.engine),
                  _buildSpecificationRow(Icons.local_gas_station, 'Bahan Bakar', vehicle.fuelType),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget pembantu (helper) untuk merapikan baris spesifikasi
  Widget _buildSpecificationRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, color: accentColor, size: 20), // Icon dengan warna aksen
          const SizedBox(width: 15),
          SizedBox(
            width: 120, 
            child: Text(
              '$title',
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: primaryColor),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}