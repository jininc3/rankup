import 'package:flutter/material.dart';
import '../widgets/player_match_card.dart';

class DuoScreen extends StatefulWidget {
  const DuoScreen({Key? key}) : super(key: key);

  @override
  State<DuoScreen> createState() => _DuoScreenState();
}

class _DuoScreenState extends State<DuoScreen> {
  int _currentCardIndex = 0;
  List<Map<String, dynamic>> _playerCards = [
    {
      'game': 'Valorant',
      'username': 'MASTERPOE',
      'age': '25',
      'country': 'USA',
      'mainAgent': 'SOVA',
      'rank': 'DIAMOND II',
      'profileImage': 'https://via.placeholder.com/150',
      'agentImage': 'https://via.placeholder.com/150',
    },
    {
      'game': 'League of Legends',
      'username': 'MidGap',
      'age': '23',
      'country': 'Canada',
      'mainAgent': 'AHRI',
      'rank': 'PLATINUM I',
      'profileImage': 'https://via.placeholder.com/150',
      'agentImage': 'https://via.placeholder.com/150',
    },
    {
      'game': 'CS:GO',
      'username': 'HeadshotKing',
      'age': '28',
      'country': 'Germany',
      'mainAgent': 'AWP',
      'rank': 'GLOBAL ELITE',
      'profileImage': 'https://via.placeholder.com/150',
      'agentImage': 'https://via.placeholder.com/150',
    },
    {
      'game': 'Valorant',
      'username': 'FlicksForDays',
      'age': '22',
      'country': 'UK',
      'mainAgent': 'JETT',
      'rank': 'IMMORTAL',
      'profileImage': 'https://via.placeholder.com/150',
      'agentImage': 'https://via.placeholder.com/150',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1923), // Valorant dark blue background
      body: Column(
        children: [
          // Game selection row
          Container(
            height: 80,
            padding: const EdgeInsets.only(top: 20),
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              children: [
                _buildGameIcon('Valorant', 'assets/images/valorant_icon.png', true),
                _buildGameIcon('League of Legends', 'assets/images/lol_icon.png', false),
                _buildGameIcon('CS:GO', 'assets/images/csgo_icon.png', false),
                _buildGameIcon('Fortnite', 'assets/images/fortnite_icon.png', false),
                _buildGameIcon('Apex', 'assets/images/apex_icon.png', false),
              ],
            ),
          ),
          
          // Main card area
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Card
                if (_playerCards.isNotEmpty)
                  PlayerMatchCard(
                    cardData: _playerCards[_currentCardIndex],
                    onSwipeLeft: _handleSwipeLeft,
                    onSwipeRight: _handleSwipeRight,
                  ),
                
                // Bottom controls
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Decline button
                      GestureDetector(
                        onTap: _handleSwipeLeft,
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.close,
                            color: Colors.red,
                            size: 30,
                          ),
                        ),
                      ),
                      
                      // Accept button
                      GestureDetector(
                        onTap: _handleSwipeRight,
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.favorite,
                            color: Colors.green,
                            size: 30,
                          ),
                        ),
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
  
  Widget _buildGameIcon(String name, String iconPath, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected 
                  ? const Color(0xFF0A1A2A) 
                  : Colors.grey.shade800,
              border: isSelected 
                  ? Border.all(color: const Color(0xFF2996F8), width: 2)
                  : null,
              image: DecorationImage(
                image: AssetImage(iconPath),
                fit: BoxFit.cover,
              ),
            ),
            // Fallback if asset image fails
            child: Container(),
          ),
        ],
      ),
    );
  }

  void _handleSwipeLeft() {
    setState(() {
      if (_currentCardIndex < _playerCards.length - 1) {
        _currentCardIndex++;
      } else {
        // Reset or show "no more players" message
        _currentCardIndex = 0;
      }
    });
  }

  void _handleSwipeRight() {
    // Handle match
    setState(() {
      if (_currentCardIndex < _playerCards.length - 1) {
        _currentCardIndex++;
      } else {
        // Reset or show "no more players" message
        _currentCardIndex = 0;
      }
    });
  }
}