import 'package:flutter/material.dart';
import '../models/country.dart';
import '../services/api_service.dart';

class CountryScreen extends StatefulWidget {
  final String continent;

  CountryScreen({required this.continent});

  @override
  _CountryScreenState createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
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
        title: Text('Negara di ${widget.continent}',
            style: TextStyle(fontFamily: 'Inter', fontSize: 20)),
      ),
      body: FutureBuilder<List<Country>>(
        future: futureCountries,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No Countries Found'));
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
              return Card(
                child: ListTile(
                  leading: Container(
                    width: 50,
                    height: 30,
                    child: Image.network(
                      countriesInContinent[index].flagUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(countriesInContinent[index].name,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 18,
                      )),
                  subtitle:
                      Text('Ibukota: ${countriesInContinent[index].capital}',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                          )),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
