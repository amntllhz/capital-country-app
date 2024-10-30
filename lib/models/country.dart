class Country {
  final String name;
  final String capital;
  final String region;
  final String flagUrl;
  final int population;
  final double area;
  final List<String> languages;
  final String currency;

  Country({
    required this.name,
    required this.capital,
    required this.region,
    required this.flagUrl,
    required this.population,
    required this.area,
    required this.languages,
    required this.currency,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name']['common'] ?? 'Unknown', // Menghindari null
      capital: (json['capital'] != null && (json['capital'] as List).isNotEmpty)
          ? json['capital'][0]
          : 'No Capital',
      region: json['region'] ?? 'Unknown', // Menghindari null
      flagUrl:
          json['flags']['png'] ?? 'default_flag_url.png', // Menghindari null
      population: json['population'] ?? 0, // Menghindari null
      area: (json['area'] != null)
          ? json['area'].toDouble()
          : 0.0, // Menghindari null
      languages: (json['languages'] as Map<String, dynamic>?)
              ?.values
              .map((lang) => lang as String)
              .toList() ??
          [], // Menghindari null
      currency: (json['currencies'] != null && json['currencies'].isNotEmpty)
          ? json['currencies'].values.first['name'] ?? 'No Currency'
          : 'No Currency',
    );
  }
}
