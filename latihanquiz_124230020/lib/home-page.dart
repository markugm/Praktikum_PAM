import 'package:flutter/material.dart';
import 'vehicle-data.dart'; 
import 'login-page.dart';
import 'detail-page.dart';
import 'main.dart'; 

class HomePage extends StatelessWidget {
  final String username;
  
  const HomePage({super.key, required this.username});

  void _logout(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (Route<dynamic> route) => false, 
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicle ShowApp'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // snackbar logout sukses floating
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Berhasil logout"),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                ),
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            }
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 10.0),
            child: Text(
              'Selamat datang, $username.',
              style: const TextStyle(
                fontSize: 20, 
                fontWeight: FontWeight.w600, 
                color: primaryColor, 
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Jelajahi pilihan terbaik kami:',
              style: TextStyle(
                fontSize: 14, 
                color: Colors.grey[600],
              ),
            ),
          ),
          const SizedBox(height: 10),
          
          // Grid View
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, 
                crossAxisSpacing: 16.0, 
                mainAxisSpacing: 16.0,
                childAspectRatio: 0.72, 
              ),
              itemCount: vehicleList.length,
              itemBuilder: (BuildContext context, int index) {
                final vehicle = vehicleList[index];
                // inkwell biar bisa di tap
                return InkWell(
                  onTap: () {
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
                      borderRadius: BorderRadius.circular(15.0), 
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(15.0)),
                            child: Image.network(
                              vehicle.imageUrls.first, 
                              fit: BoxFit.cover,
                              width: double.infinity,
                              errorBuilder: (context, error, stackTrace) => 
                                const Center(child: Icon(Icons.broken_image, size: 50, color: Colors.grey)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
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
                                '${vehicle.type} / ${vehicle.fuelType}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[500],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                vehicle.price,
                                style: const TextStyle(
                                  fontSize: 16, 
                                  fontWeight: FontWeight.w800,
                                  color: accentColor, 
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