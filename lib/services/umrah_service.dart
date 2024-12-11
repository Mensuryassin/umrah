class UmrahService {
  // Mock data for Umrah Deals
  List<Map<String, dynamic>> getUmrahDeals() {
    return [
      {
        'title': 'Economy Umrah Package',
        'price': '\$1,000',
        'imageUrl': 'https://via.placeholder.com/150?text=Umrah+Economy',
        'sourceUrl': 'https://example.com/umrah-economy',
      },
      {
        'title': 'Premium Umrah Package',
        'price': '\$2,000',
        'imageUrl': 'https://via.placeholder.com/150?text=Umrah+Premium',
        'sourceUrl': 'https://example.com/umrah-premium',
      },
      {
        'title': 'VIP Umrah Package',
        'price': '\$3,500',
        'imageUrl': 'https://via.placeholder.com/150?text=Umrah+VIP',
        'sourceUrl': 'https://example.com/umrah-vip',
      },
    ];
  }
}
