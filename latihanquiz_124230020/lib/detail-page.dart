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
            SizedBox(
              height: 280, 
              width: double.infinity,
              child: PageView.builder(
                itemCount: vehicle.imageUrls.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0), 
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0), 
                      child: Image.network(
                        vehicle.imageUrls[index],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => 
                          const Center(child: Icon(Icons.broken_image, size: 100, color: Colors.grey)),
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
                  Text(
                    vehicle.name,
                    style: const TextStyle(
                      fontSize: 30, 
                      fontWeight: FontWeight.w900,
                      color: maroon, 
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    vehicle.price,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Deskripsi
                  const Text(
                    'Deskripsi Produk:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const Divider(color: maroon, thickness: 2, height: 10),
                  Text(
                    vehicle.description,
                    style: const TextStyle(
                      fontSize: 17, 
                      height: 1.6,
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
                      color: Colors.black87,
                    ),
                  ),
                  const Divider(color: maroon, thickness: 2, height: 10),
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

  Widget _buildSpecificationRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, color: maroon, size: 20), 
          const SizedBox(width: 10),
          SizedBox(
            width: 120, 
            child: Text(
              '$title:',
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.black87),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}