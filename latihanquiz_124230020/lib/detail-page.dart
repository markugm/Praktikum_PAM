import 'package:flutter/material.dart';
import 'vehicle-data.dart'; 

class DetailPage extends StatelessWidget {
  final Vehicle vehicle;

  const DetailPage({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(vehicle.name),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Carousel Gambar (bisa diganti dengan satu gambar jika mau lebih sederhana)
            SizedBox(
              height: 250,
              width: double.infinity,
              child: PageView.builder(
                itemCount: vehicle.imageUrls.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.network(
                        vehicle.imageUrls[index],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => 
                          const Center(child: Icon(Icons.image_not_supported, size: 100, color: Colors.grey)),
                      ),
                    ),
                  );
                },
              ),
            ),
            
            // Detail Informasi Kendaraan
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Nama dan Harga
                  Text(
                    vehicle.name,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    vehicle.price,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.redAccent,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Deskripsi
                  const Text(
                    'Deskripsi:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(),
                  Text(
                    vehicle.description,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Spesifikasi
                  const Text(
                    'Spesifikasi Utama:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(),
                  _buildSpecificationRow('Tipe', vehicle.type),
                  _buildSpecificationRow('Mesin', vehicle.engine),
                  _buildSpecificationRow('Tipe Bahan Bakar', vehicle.fuelType),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget pembantu untuk merapikan spesifikasi
  Widget _buildSpecificationRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 150,
            child: Text(
              '$title:',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}