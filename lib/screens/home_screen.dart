import 'package:flutter/material.dart';
import 'continent_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Selamat Datang',
                style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20), // Jarak antara teks dan gambar
              Image.asset(
                'assets/backg.jpg', // Ganti dengan path ke gambar siluet peta dunia Anda
                height: 200,
              ),
              const SizedBox(height: 20), // Jarak antara gambar dan deskripsi
              const Text(
                'Aplikasi ini membantu Anda menjelajahi berbagai negara di seluruh dunia berdasarkan benua.',
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'Inter', fontSize: 18),
              ),
              const SizedBox(height: 40), // Jarak antara deskripsi dan tombol
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ContinentScreen(),
                    ),
                  );
                },
                child: const Text('Mulai',
                    style: TextStyle(fontFamily: 'Inter', fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
