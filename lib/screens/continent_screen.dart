import 'package:flutter/material.dart';
import 'country_screen.dart';

class ContinentScreen extends StatelessWidget {
  final List<String> continents = [
    'Africa',
    'Asia',
    'Europe',
    'North America',
    'Oceania',
    'South America'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ibu Kota Negara',
            style: TextStyle(fontFamily: 'Inter', fontSize: 20)),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Jumlah kolom
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 1.5, // Rasio aspek setiap item
        ),
        padding: EdgeInsets.all(10.0),
        itemCount: continents.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CountryScreen(continent: continents[index]),
                ),
              );
            },
            child: Card(
              elevation: 4,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    continents[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontFamily: 'Inter'),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
