import 'package:flutter/material.dart';
import '../models/country.dart';
import '../services/api_service.dart';

class CountryScreen extends StatefulWidget {
  final String continent;

  const CountryScreen({super.key, required this.continent});

  @override
  CountryScreenState createState() => CountryScreenState();
}

class CountryScreenState extends State<CountryScreen> {
  late Future<List<Country>> futureCountries;

  @override
  void initState() {
    super.initState();
    futureCountries = ApiService().fetchCountries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Negara di ${widget.continent}',
          style: const TextStyle(fontFamily: 'Inter', fontSize: 20),
        ),
      ),
      body: FutureBuilder<List<Country>>(
        future: futureCountries,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No Countries Found'));
          }

          // Filter berdasarkan benua yang dipilih
          final countriesInContinent = snapshot.data!.where((country) {
            if (widget.continent == 'North America') {
              return country.region == 'Americas' &&
                  (country.name == 'United States' ||
                      country.name == 'Canada' ||
                      country.name == 'Mexico');
            } else if (widget.continent == 'South America') {
              return country.region == 'Americas' &&
                  !(country.name == 'United States' ||
                      country.name == 'Canada' ||
                      country.name == 'Mexico');
            }
            return country.region == widget.continent;
          }).toList();

          // Mengurutkan negara berdasarkan nama
          countriesInContinent.sort((a, b) => a.name.compareTo(b.name));

          return ListView.builder(
            itemCount: countriesInContinent.length,
            itemBuilder: (context, index) {
              final country = countriesInContinent[index];
              return Card(
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                child: ListTile(
                  leading: SizedBox(
                    width: 50,
                    height: 30,
                    child: Image.network(
                      country.flagUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    country.name,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Ibukota: ${country.capital}',
                          style: const TextStyle(fontSize: 14)),
                      Text('Populasi: ${country.population}',
                          style: const TextStyle(fontSize: 14)),
                      Text('Area: ${country.area} km²',
                          style: const TextStyle(fontSize: 14)),
                      Text('Bahasa: ${country.languages.join(', ')}',
                          style: const TextStyle(fontSize: 14)),
                      Text('Mata Uang: ${country.currency}',
                          style: const TextStyle(fontSize: 14)),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
