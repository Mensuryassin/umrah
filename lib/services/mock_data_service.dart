class MockDataService {
  // Mock data for Honeymoon Destinations
  List<Map<String, dynamic>> getHoneymoonDestinations() {
    return [
      {
        'title': 'Romantic Bali Getaway',
        'price': '\$1,500',
        'imageUrl': 'https://via.placeholder.com/150?text=Bali+Honeymoon',
        'sourceUrl': 'https://example.com/bali-honeymoon',
      },
      {
        'title': 'Paris Honeymoon Special',
        'price': '\$3,000',
        'imageUrl': 'https://via.placeholder.com/150?text=Paris+Honeymoon',
        'sourceUrl': 'https://example.com/paris-honeymoon',
      },
      {
        'title': 'Luxury Maldives Retreat',
        'price': '\$5,000',
        'imageUrl': 'https://via.placeholder.com/150?text=Maldives+Honeymoon',
        'sourceUrl': 'https://example.com/maldives-honeymoon',
      },
    ];
  }
}
