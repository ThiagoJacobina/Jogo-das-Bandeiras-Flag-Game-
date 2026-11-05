import '../models/country.dart';

class CountriesData {
  static const List<Country> allCountries = [
    // América
Country(name: 'Brasil', isoCode: 'BR', continent: 'América'),
    Country(name: 'Argentina', isoCode: 'AR', continent: 'América'),
    Country(name: 'Canadá', isoCode: 'CA', continent: 'América'),
    Country(name: 'Estados Unidos', isoCode: 'US', continent: 'América'),
    Country(name: 'México', isoCode: 'MX', continent: 'América'),
    Country(name: 'Chile', isoCode: 'CL', continent: 'América'),
    Country(name: 'Colômbia', isoCode: 'CO', continent: 'América'),
    Country(name: 'Uruguai', isoCode: 'UY', continent: 'América'),
    Country(name: 'Paraguai', isoCode: 'PY', continent: 'América'),
    Country(name: 'Peru', isoCode: 'PE', continent: 'América'),
    Country(name: 'Bolívia', isoCode: 'BO', continent: 'América'),
    Country(name: 'Equador', isoCode: 'EC', continent: 'América'),
    Country(name: 'Venezuela', isoCode: 'VE', continent: 'América'),
    Country(name: 'Cuba', isoCode: 'CU', continent: 'América'),
    Country(name: 'Jamaica', isoCode: 'JM', continent: 'América'),

    // Europa
Country(name: 'Alemanha', isoCode: 'DE', continent: 'Europa'),
    Country(name: 'França', isoCode: 'FR', continent: 'Europa'),
    Country(name: 'Itália', isoCode: 'IT', continent: 'Europa'),
    Country(name: 'Espanha', isoCode: 'ES', continent: 'Europa'),
    Country(name: 'Portugal', isoCode: 'PT', continent: 'Europa'),
    Country(name: 'Reino Unido', isoCode: 'GB', continent: 'Europa'),
    Country(name: 'Holanda', isoCode: 'NL', continent: 'Europa'),
    Country(name: 'Bélgica', isoCode: 'BE', continent: 'Europa'),
    Country(name: 'Suíça', isoCode: 'CH', continent: 'Europa'),
    Country(name: 'Suécia', isoCode: 'SE', continent: 'Europa'),
    Country(name: 'Noruega', isoCode: 'NO', continent: 'Europa'),
    Country(name: 'Dinamarca', isoCode: 'DK', continent: 'Europa'),
    Country(name: 'Grécia', isoCode: 'GR', continent: 'Europa'),
    Country(name: 'Polônia', isoCode: 'PL', continent: 'Europa'),
    Country(name: 'Croácia', isoCode: 'HR', continent: 'Europa'),

    // Ásia
Country(name: 'Japão', isoCode: 'JP', continent: 'Ásia'),
    Country(name: 'China', isoCode: 'CN', continent: 'Ásia'),
    Country(name: 'Coreia do Sul', isoCode: 'KR', continent: 'Ásia'),
    Country(name: 'Índia', isoCode: 'IN', continent: 'Ásia'),
    Country(name: 'Tailândia', isoCode: 'TH', continent: 'Ásia'),
    Country(name: 'Indonésia', isoCode: 'ID', continent: 'Ásia'),
    Country(name: 'Vietnã', isoCode: 'VN', continent: 'Ásia'),
    Country(name: 'Filipinas', isoCode: 'PH', continent: 'Ásia'),
    Country(name: 'Arábia Saudita', isoCode: 'SA', continent: 'Ásia'),
    Country(name: 'Emirados Árabes', isoCode: 'AE', continent: 'Ásia'),
    Country(name: 'Israel', isoCode: 'IL', continent: 'Ásia'),
    Country(name: 'Catar', isoCode: 'QA', continent: 'Ásia'),
    Country(name: 'Malásia', isoCode: 'MY', continent: 'Ásia'),
    Country(name: 'Singapura', isoCode: 'SG', continent: 'Ásia'),
    Country(name: 'Turquia', isoCode: 'TR', continent: 'Ásia'),

    // África
Country(name: 'Egito', isoCode: 'EG', continent: 'África'),
    Country(name: 'Nigéria', isoCode: 'NG', continent: 'África'),
    Country(name: 'África do Sul', isoCode: 'ZA', continent: 'África'),
    Country(name: 'Marrocos', isoCode: 'MA', continent: 'África'),
    Country(name: 'Quênia', isoCode: 'KE', continent: 'África'),
    Country(name: 'Gana', isoCode: 'GH', continent: 'África'),
    Country(name: 'Senegal', isoCode: 'SN', continent: 'África'),
    Country(name: 'Etiópia', isoCode: 'ET', continent: 'África'),
    Country(name: 'Angola', isoCode: 'AO', continent: 'África'),
    Country(name: 'Moçambique', isoCode: 'MZ', continent: 'África'),
    Country(name: 'Camarões', isoCode: 'CM', continent: 'África'),
    Country(name: 'Tunísia', isoCode: 'TN', continent: 'África'),
    // Oceania
Country(name: 'Austrália', isoCode: 'AU', continent: 'Oceania'),
    Country(name: 'Nova Zelândia', isoCode: 'NZ', continent: 'Oceania'),
    Country(name: 'Fiji', isoCode: 'FJ', continent: 'Oceania'),
    Country(name: 'Samoa', isoCode: 'WS', continent: 'Oceania'),
    Country(name: 'Papua Nova Guiné', isoCode: 'PG', continent: 'Oceania'),
    Country(name: 'Tonga', isoCode: 'TO', continent: 'Oceania'),
    Country(name: 'Vanuatu', isoCode: 'VU', continent: 'Oceania'),
  ];

  static List<String> get continents => ['África', 'América', 'Ásia', 'Europa', 'Oceania'];

  static List<Country> getByContinent(String continent) {
    return allCountries.where((c) => c.continent == continent).toList();
  }
}