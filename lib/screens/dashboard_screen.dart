import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/umrah_service.dart';
import '../services/mock_data_service.dart';
import 'settings_screen.dart'; // Ensure this path is correct

class DashboardScreen extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) toggleDarkMode;

  DashboardScreen({
    super.key,
    required this.isDarkMode,
    required this.toggleDarkMode,
  });

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final MockDataService _mockDataService = MockDataService();
  final UmrahService _umrahService = UmrahService();

  List<Map<String, dynamic>> _allDeals = [];
  List<Map<String, dynamic>> _filteredDeals = [];
  ScrollController _scrollController = ScrollController();

  bool _isHoneymoonDeals = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _loadDeals();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _loadMoreDeals();
    }
  }

  void _loadDeals() {
    setState(() {
      _isLoading = true;
    });

    List<Map<String, dynamic>> newDeals = _isHoneymoonDeals
        ? _mockDataService.getHoneymoonDestinations()
        : _umrahService.getUmrahDeals();

    setState(() {
      _allDeals = newDeals;
      _filteredDeals = newDeals;
      _isLoading = false;
    });
  }

  void _loadMoreDeals() async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(Duration(seconds: 2));

    List<Map<String, dynamic>> newDeals = _isHoneymoonDeals
        ? _mockDataService.getHoneymoonDestinations()
        : _umrahService.getUmrahDeals();

    setState(() {
      _allDeals.addAll(newDeals);
      _filteredDeals = _allDeals;
      _isLoading = false;
    });
  }

  void _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);

    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch URL')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.isDarkMode ? Colors.grey.shade900 : Colors.white,
      appBar: AppBar(
        title: Text(
          _isHoneymoonDeals ? 'Honeymoon Destinations' : 'Umrah Deals',
          style: TextStyle(color: widget.isDarkMode ? Colors.white : Colors.black),
        ),
        backgroundColor: widget.isDarkMode ? Colors.black : Colors.blue,
        actions: [
          IconButton(
            icon: Icon(
              widget.isDarkMode ? Icons.brightness_7 : Icons.brightness_4,
              color: widget.isDarkMode ? Colors.white : Colors.black,
            ),
            onPressed: () {
              widget.toggleDarkMode(!widget.isDarkMode);
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  widget.isDarkMode ? Colors.blue.shade900 : Colors.blue.shade300,
                  Colors.orange.shade200,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _isHoneymoonDeals ? 'Honeymoon Destinations' : 'Umrah Deals',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: widget.isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.mosque, color: widget.isDarkMode ? Colors.white : Colors.black),
                          Switch(
                            value: _isHoneymoonDeals,
                            onChanged: (value) {
                              setState(() {
                                _isHoneymoonDeals = value;
                                _loadDeals();
                              });
                            },
                            activeColor: Colors.orange,
                            inactiveThumbColor: widget.isDarkMode ? Colors.white : Colors.black,
                            inactiveTrackColor: widget.isDarkMode
                                ? Colors.blue.shade100
                                : Colors.blue.shade300,
                          ),
                          Icon(Icons.beach_access, color: widget.isDarkMode ? Colors.white : Colors.black),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      _loadDeals();
                    },
                    child: _isLoading
                        ? Center(
                            child: Container(
                              height: 100,
                              width: 100,
                              child: Image.asset('assets/plane_loader.gif'),
                            ),
                          )
                        : ListView.builder(
                            controller: _scrollController,
                            itemCount: _filteredDeals.length,
                            itemBuilder: (context, index) {
                              final deal = _filteredDeals[index];
                              final String title = deal['title'] ?? 'No Title';
                              final String price = deal['price'] ?? 'Price not available';
                              final String imageUrl =
                                  deal['imageUrl'] ?? 'https://via.placeholder.com/300x200';
                              final String sourceUrl = deal['sourceUrl'] ?? '';

                              return GestureDetector(
                                onTap: () {
                                  if (sourceUrl.isNotEmpty) {
                                    _launchUrl(sourceUrl);
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text('No URL Available'),
                                        content: Text(
                                            'This deal does not have a URL. Please try another one.'),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(context),
                                            child: Text('OK'),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    elevation: 5,
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(15),
                                          child: Image.network(
                                            imageUrl,
                                            height: 200,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                title,
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: widget.isDarkMode
                                                      ? Colors.white
                                                      : Colors.blue.shade700,
                                                ),
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                price,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: widget.isDarkMode
                                                      ? Colors.white70
                                                      : Colors.grey.shade600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade700,
                          minimumSize: Size(150, 50),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SettingsScreen(
                                isDarkMode: widget.isDarkMode,
                                toggleDarkMode: widget.toggleDarkMode,
                              ),
                            ),
                          );
                        },
                        child: Text('Settings', style: TextStyle(fontSize: 18)),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade700,
                          minimumSize: Size(150, 50),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Logged out successfully!')),
                          );
                        },
                        child: Text('Logout', style: TextStyle(fontSize: 18)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
