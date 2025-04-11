import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  String _searchQuery = '';
  
  // Demo data for player suggestions
  final List<Map<String, dynamic>> _playerSuggestions = [
    {
      'username': 'ProSniper23',
      'game': 'Valorant',
      'rank': 'Diamond',
      'avatar': 'assets/images/avatar1.jpg',
    },
    {
      'username': 'MidLaneKing',
      'game': 'League of Legends',
      'rank': 'Platinum',
      'avatar': 'assets/images/avatar2.jpg',
    },
    {
      'username': 'HeadshotQueen',
      'game': 'CS:GO',
      'rank': 'Global Elite',
      'avatar': 'assets/images/avatar3.jpg',
    },
    {
      'username': 'FlankMaster',
      'game': 'Valorant',
      'rank': 'Immortal',
      'avatar': 'assets/images/avatar4.jpg',
    },
    {
      'username': 'TopFragger',
      'game': 'CS:GO',
      'rank': 'Supreme',
      'avatar': 'assets/images/avatar5.jpg',
    },
    {
      'username': 'JungleGap',
      'game': 'League of Legends',
      'rank': 'Diamond',
      'avatar': 'assets/images/avatar6.jpg',
    },
    {
      'username': 'AimGod',
      'game': 'Apex Legends',
      'rank': 'Predator',
      'avatar': 'assets/images/avatar7.jpg',
    },
    {
      'username': 'TacticalPlayer',
      'game': 'Valorant',
      'rank': 'Ascendant',
      'avatar': 'assets/images/avatar8.jpg',
    }
  ];
  
  // Demo data for gaming communities
  final List<Map<String, dynamic>> _communitySuggestions = [
    {
      'name': 'Valorant Tactics',
      'members': '34.5K',
      'image': 'assets/images/community1.jpg',
    },
    {
      'name': 'League Pro Tips',
      'members': '128K',
      'image': 'assets/images/community2.jpg',
    },
    {
      'name': 'CS:GO Strategy',
      'members': '82.1K',
      'image': 'assets/images/community3.jpg',
    },
    {
      'name': 'FPS Aim Training',
      'members': '45.3K',
      'image': 'assets/images/community4.jpg',
    }
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
      _isSearching = _searchQuery.isNotEmpty;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
      _searchQuery = '';
      _isSearching = false;
      FocusScope.of(context).unfocus();
    });
  }

List<Map<String, dynamic>> get _filteredPlayers {
    if (_searchQuery.isEmpty) {
      return [];
    }

    return _playerSuggestions.where((player) {
      return player['username'].toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: TextField(
                controller: _searchController,
                cursorColor: Colors.green,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  fillColor: const Color(0xFF2C2F33),
                  filled: true,
                  hintText: 'Search players...',
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  suffixIcon: _isSearching
                      ? IconButton(
                          icon: const Icon(Icons.clear, color: Colors.grey),
                          onPressed: _clearSearch,
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            
            // Content (only search results when searching, otherwise empty)
            Expanded(
              child: _isSearching ? _buildSearchResults() : Container(), // Empty container when not searching
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Player results
          if (_filteredPlayers.isNotEmpty) ...[
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                'Players',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _filteredPlayers.length,
              itemBuilder: (context, index) {
                final player = _filteredPlayers[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey.shade800,
                    child: Text(
                      player['username'][0].toUpperCase(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(
                    player['username'],
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    '${player['game']} • ${player['rank']}',
                    style: TextStyle(color: Colors.grey.shade400),
                  ),
                  onTap: () {
                    // Navigate to player profile
                    print('Navigating to ${player['username']}\'s profile');
                  },
                );
              },
            ),
          ],
        ],
      ),
    );
  }
}