class Country {
  final String name;
  final String isoCode; // Ex: 'BR', 'US', 'FR'
  final String continent;

  const Country({
    required this.name,
    required this.isoCode,
    required this.continent,
  });
}