import 'package:flutter/material.dart';
import '../widgets/flippable_player_card.dart';

// Import the Discord theme from profile_screen.dart
class DiscordTheme {
  static const primaryRed = Color(0xFFED4245);
  static const darkGrey = Color(0xFF2C2F33);
  static const charcoalGrey = Color(0xFF23272A);
  static const lightGrey = Color(0xFFB9BBBE);
  static const white = Color(0xFFFFFFFF);
  static const mutedRed = Color(0xFFA83232);
  static const softGrey = Color(0xFF99AAB5);
}

class PlayerCardsScreen extends StatefulWidget {
  const PlayerCardsScreen({Key? key}) : super(key: key);

  @override
  State<PlayerCardsScreen> createState() => _PlayerCardsScreenState();
}

class _PlayerCardsScreenState extends State<PlayerCardsScreen> {
  // Scroll controller to track card scrolling position
  final ScrollController _cardsScrollController = ScrollController();
  
  // Arrow visibility flags
  bool _showLeftArrow = false;
  bool _showRightArrow = true;

  @override
  void initState() {
    super.initState();
    
    // Add listener to hide/show arrows
    _cardsScrollController.addListener(_updateArrowVisibility);
  }
  
  void _updateArrowVisibility() {
    final position = _cardsScrollController.position;
    setState(() {
      _showLeftArrow = position.pixels > 10;
      _showRightArrow = position.pixels < position.maxScrollExtent - 10;
    });
  }

  @override
  void dispose() {
    _cardsScrollController.removeListener(_updateArrowVisibility);
    _cardsScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DiscordTheme.charcoalGrey,
      appBar: AppBar(
        backgroundColor: DiscordTheme.darkGrey.withOpacity(0.9),
        elevation: 0,
        title: const Text(
          'Player Cards',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: DiscordTheme.white,
          ),
        ),
        actions: [
          // Add Card button
          IconButton(
            icon: const Icon(Icons.add_circle_outline, color: DiscordTheme.lightGrey),
            tooltip: 'Add New Card',
            onPressed: () {
              // Add new card logic
            },
          ),
          const SizedBox(width: 8), // Add some padding on the right
        ],
      ),
      body: Container(
        // Add a subtle gradient background
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              DiscordTheme.charcoalGrey,
              DiscordTheme.charcoalGrey.withBlue(35),
            ],
          ),
        ),
        child: _buildPlayerCardsContent(),
      ),
    );
  }

  Widget _buildPlayerCardsContent() {
    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            // Add some padding at the top of the tab
            const SliverToBoxAdapter(
              child: SizedBox(height: 16),
            ),
            
            // Horizontal scrolling cards with more padding
            SliverToBoxAdapter(
              child: SizedBox(
                height: 520, // Increased height for cards with margins
                child: Stack(
                  children: [
                    // Actual card list
                    ListView.builder(
                      controller: _cardsScrollController,
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.zero, // Remove padding
                      physics: const PageScrollPhysics(), // Change to page scrolling
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        String game = index % 3 == 0 ? 'League of Legends' :
                                    index % 3 == 1 ? 'Valorant' : 'CS:GO';
                        
                        String rank = index % 3 == 0 ? 'Platinum' :
                                    index % 3 == 1 ? 'Diamond' : 'Global Elite';
                        
                        List<String> characters = index % 3 == 0 ? ['Ahri', 'Lux', 'Jinx'] :
                                               index % 3 == 1 ? ['Jett', 'Reyna', 'Sage'] :
                                               ['AWP', 'AK-47', 'M4A1-S'];
                        
                        String bio = index % 3 == 0 ? 'Mid lane main since Season 3' :
                                   index % 3 == 1 ? 'Duelist main with 1.8 K/D ratio' :
                                   'Entry fragger with 8 years of experience';
                        
                        String username = 'Player${index + 1}';
                        String country = index % 3 == 0 ? 'USA' : 
                                       index % 3 == 1 ? 'Canada' : 'UK';
                        
                        // Generate some sample stats for the card back
                        Map<String, dynamic> playerStats = {
                          'kd_ratio': (1.0 + index * 0.2).toStringAsFixed(1),
                          'win_rate': '${50 + index * 3}%',
                          'headshot': '${30 + index * 5}%',
                          'accuracy': (0.4 + index * 0.05).clamp(0.0, 1.0),
                          'clutch_rate': (0.3 + index * 0.06).clamp(0.0, 1.0),
                          'support': (0.6 + index * 0.03).clamp(0.0, 1.0),
                          'achievements': [
                            {
                              'title': 'First Place Tournament',
                              'date': '2 weeks ago'
                            },
                            {
                              'title': '5-Win Streak',
                              'date': '3 days ago'
                            },
                            {
                              'title': 'MVP of the Match',
                              'date': 'Yesterday'
                            }
                          ]
                        };
                        
                        // Add card with improved appearance
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: FlippablePlayerCard(
                            gameName: game,
                            rank: rank,
                            mainCharacters: characters,
                            bio: bio,
                            username: username,
                            country: country,
                            stats: playerStats,
                          ),
                        );
                      },
                    ),
                    
                    // Right arrow (always shown when there are more cards)
                    Positioned(
                      right: 0,
                      top: 0,
                      bottom: 0,
                      width: 32,
                      child: AnimatedOpacity(
                        opacity: _showRightArrow ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 200),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Colors.transparent,
                                DiscordTheme.primaryRed.withOpacity(0.1),
                                DiscordTheme.primaryRed.withOpacity(0.2),
                              ],
                            ),
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.chevron_right,
                              color: DiscordTheme.white,
                              size: 24,
                            ),
                            onPressed: _showRightArrow ? () {
                              // Scroll to the next card
                              final nextPosition = _cardsScrollController.position.pixels + MediaQuery.of(context).size.width;
                              _cardsScrollController.animateTo(
                                nextPosition,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            } : null,
                          ),
                        ),
                      ),
                    ),
                    
                    // Left arrow
                    Positioned(
                      left: 0,
                      top: 0,
                      bottom: 0,
                      width: 32,
                      child: AnimatedOpacity(
                        opacity: _showLeftArrow ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 200),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft,
                              colors: [
                                Colors.transparent,
                                DiscordTheme.primaryRed.withOpacity(0.1),
                                DiscordTheme.primaryRed.withOpacity(0.2),
                              ],
                            ),
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.chevron_left,
                              color: DiscordTheme.white,
                              size: 24,
                            ),
                            onPressed: _showLeftArrow ? () {
                              // Scroll to the previous card
                              final prevPosition = _cardsScrollController.position.pixels - MediaQuery.of(context).size.width;
                              _cardsScrollController.animateTo(
                                prevPosition.clamp(0.0, _cardsScrollController.position.maxScrollExtent),
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            } : null,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Empty state (when no cards are present)
            SliverToBoxAdapter(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    children: [
                      // Only show this when itemCount is 0 (moved to a separate widget for this example)
                      if (false) // Replace with actual condition (here showing it as false for example)
                        _buildEmptyStateWidget(),
                    ],
                  ),
                ),
              ),
            ),
            
            // Add extra padding at the bottom to ensure content doesn't get hidden behind nav bar
            const SliverToBoxAdapter(
              child: SizedBox(height: 80), // Increase padding to account for bottom nav bar
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEmptyStateWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 40),
        Icon(
          Icons.add_circle_outline,
          size: 60,
          color: DiscordTheme.softGrey.withOpacity(0.6),
        ),
        const SizedBox(height: 16),
        const Text(
          'No player cards yet',
          style: TextStyle(
            color: DiscordTheme.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Create your first player card to showcase your gaming skills and achievements',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: DiscordTheme.softGrey,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: DiscordTheme.primaryRed,
            foregroundColor: DiscordTheme.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () {
            // Create new player card
          },
          child: const Text('Create Player Card'),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}