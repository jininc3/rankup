import 'package:flutter/material.dart';
import '../widgets/game_player_card.dart';

// Define the Discord Red & Grey theme colors
class DiscordTheme {
  static const primaryRed = Color(0xFFED4245);
  static const darkGrey = Color(0xFF2C2F33);
  static const charcoalGrey = Color(0xFF23272A);
  static const lightGrey = Color(0xFFB9BBBE);
  static const white = Color(0xFFFFFFFF);
  static const mutedRed = Color(0xFFA83232);
  static const softGrey = Color(0xFF99AAB5);
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  // Scroll controller to track card scrolling position
  final ScrollController _cardsScrollController = ScrollController();
  
  // Arrow visibility flags
  bool _showLeftArrow = false;
  bool _showRightArrow = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    
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
    _tabController.dispose();
    _cardsScrollController.removeListener(_updateArrowVisibility);
    _cardsScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Add a subtle gradient background
      backgroundColor: DiscordTheme.charcoalGrey,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: DiscordTheme.darkGrey.withOpacity(0.9),
        elevation: 0,
        title: const Text(
          'ProGamerName',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: DiscordTheme.white,
          ),
        ),
        actions: [
          // Card Activity button with cleaner icon
          IconButton(
            icon: const Icon(Icons.history_outlined, color: DiscordTheme.lightGrey),
            tooltip: 'Card Activity',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CardActivityScreen()),
              );
            },
          ),
          // Settings button with more modern icon
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: DiscordTheme.lightGrey),
            onPressed: () {
              // Open settings
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
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              // Profile Header with more white space and modern styling
              SliverToBoxAdapter(
                child: SafeArea(
                  bottom: false,
                  child: Stack(
                    children: [
                      // Background image with improved visibility
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            color: DiscordTheme.charcoalGrey,
                          ),
                          child: Opacity(
                            opacity: 0.2, // Increased opacity for better visibility
                            child: Container(
                              alignment: Alignment.center,
                              child: const Image(
                                image: AssetImage('assets/images/profile2.png'),
                                fit: BoxFit.cover, // Change to cover to fill the space
                                width: double.infinity, // Make it full width
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Profile content
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Profile picture, stats, name, edit button, etc.
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Profile picture with enhanced border
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    // Border container
                                    Container(
                                      width: 96,
                                      height: 96,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: const Color(0xFF4A80EB), // Diamond color
                                          width: 2,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0xFF4A80EB).withOpacity(0.3),
                                            blurRadius: 8,
                                            spreadRadius: 1,
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Actual profile image
                                    CircleAvatar(
                                      radius: 44,
                                      backgroundColor: DiscordTheme.darkGrey,
                                      backgroundImage: const AssetImage('assets/images/placeholder.png'),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 24), // More spacing
                                
                                // Stats in a single column with bolder text
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      _buildStatColumn('7', 'Cards'),
                                      _buildStatColumn('1.2k', 'Followers'),
                                      _buildStatColumn('342', 'Following'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            
                            const SizedBox(height: 20), // More spacing
                            
                            // User info section with improved typography hierarchy
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Competitive player since 2015',
                                  style: TextStyle(
                                    color: DiscordTheme.softGrey,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            
                            const SizedBox(height: 24), // More spacing
                            
                            // Edit profile button with Discord red styling and enhanced appearance
                           SizedBox(
  width: double.infinity,
  child: DecoratedBox(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: DiscordTheme.primaryRed.withOpacity(0.2),
          blurRadius: 6, // Reduced from 8
          spreadRadius: 0,
        ),
      ],
    ),
    child: OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: DiscordTheme.primaryRed, width: 1),
        foregroundColor: DiscordTheme.primaryRed,
        padding: const EdgeInsets.symmetric(vertical: 6), // Reduced from 12
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        // Add minimumSize to control the minimum height
        minimumSize: const Size(0, 32), // Set a lower minimum height
      ),
      onPressed: () {
        // Navigate to edit profile
      },
      child: const Text(
        'Edit Profile',
        style: TextStyle(
          fontSize: 14, // Slightly reduced font size
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
        ),
      ),
    ),
  ),
),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // Tabs with Discord red styling and improved indicator
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    controller: _tabController,
                    // More minimal, modern tab indicator
                    indicator: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 2.0, // Reduced from 3.0
                          color: DiscordTheme.primaryRed,
                        ),
                      ),
                    ),
                    labelColor: DiscordTheme.white,
                    unselectedLabelColor: DiscordTheme.softGrey,
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12, // Reduced from 14
                      letterSpacing: 0.6, // Reduced from 0.8
                    ),
                    unselectedLabelStyle: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 12, // Reduced from 14
                      letterSpacing: 0.4, // Reduced from 0.5
                    ),
                    // Reduced padding in the tabs
                    padding: const EdgeInsets.symmetric(vertical: 0), // Add this line
                    indicatorPadding: const EdgeInsets.symmetric(horizontal: 4), // Add this line
                    tabs: const [
                      Tab(
                        icon: Icon(Icons.grid_view_rounded, size: 18), // Reduced from default size
                        text: 'PLAYER CARDS',
                        height: 38, // Reduced from default height
                      ),
                      Tab(
                        icon: Icon(Icons.play_circle_outline, size: 18), // Reduced from default size
                        text: 'HIGHLIGHTS',
                        height: 38, // Reduced from default height
                      ),
                    ],
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          // TabBarView with modern styling
          body: TabBarView(
            controller: _tabController,
            children: [
              _buildPlayerCardsTab(),
              _buildHighlightsTab(),
            ],
          ),
        ),
      ),
      // Remove the bottom navigation bar from here - it will be provided by the parent widget
    );
  }

  Widget _buildStatColumn(String count, String title) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(
            fontSize: 24, // Increased size
            fontWeight: FontWeight.w800, // Bolder font
            color: DiscordTheme.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(
            color: DiscordTheme.softGrey,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildPlayerCardsTab() {
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
                        
                        // Add card with improved appearance
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              // The card itself
                              GamePlayerCard(
                                gameName: game,
                                rank: rank,
                                mainCharacters: characters,
                                bio: bio,
                                username: username,
                                country: country,
                                onTap: () {
                                  // View card details
                                },
                              ),
                              
                              // Game-specific icon (smaller logos for each game)
                             
                            ],
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

  Widget _buildGameLogo(String game) {
    IconData iconData;
    Color color;
    
    switch (game) {
      case 'Valorant':
        iconData = Icons.filter_tilt_shift; // Approximating Valorant icon
        color = const Color(0xFFFF4655); // Valorant red
        break;
      case 'League of Legends':
        iconData = Icons.shield; // Approximating LoL icon
        color = const Color(0xFF1CA0DC); // LoL blue
        break;
      case 'CS:GO':
        iconData = Icons.gps_fixed; // Approximating CS:GO icon
        color = const Color(0xFFFFD700); // CS:GO gold/yellow
        break;
      default:
        iconData = Icons.games;
        color = DiscordTheme.primaryRed;
    }
    
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: DiscordTheme.darkGrey.withOpacity(0.8),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        iconData,
        color: color,
        size: 16,
      ),
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

  Widget _buildHighlightsTab() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0), // Increase padding to account for bottom nav bar
      child: GridView.builder(
        padding: const EdgeInsets.all(16.0), // More padding
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 16, // More spacing between items
          mainAxisSpacing: 16, // More spacing between items
        ),
        itemCount: 10,
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(12), // More modern rounded corners
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Using Container with color instead of network image
                Container(
                  decoration: BoxDecoration(
                    color: DiscordTheme.darkGrey,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                ),
                // Gradient overlay for better text visibility
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          DiscordTheme.charcoalGrey.withOpacity(0.7),
                          DiscordTheme.charcoalGrey.withOpacity(0.9),
                        ],
                        stops: const [0.6, 0.8, 1.0],
                      ),
                    ),
                  ),
                ),
                // Play button with improved styling
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: DiscordTheme.primaryRed.withOpacity(0.3),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: DiscordTheme.white,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: DiscordTheme.primaryRed.withOpacity(0.3),
                          blurRadius: 12,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.play_arrow,
                      size: 36,
                      color: DiscordTheme.white,
                    ),
                  ),
                ),
                // Add a game icon overlay
                Positioned(
                  top: 12,
                  left: 12,
                  child: _buildGameLogo(index % 3 == 0 ? 'Valorant' : 
                                     index % 3 == 1 ? 'League of Legends' : 'CS:GO'),
                ),
                // Title at bottom
                Positioned(
                  bottom: 12,
                  left: 12,
                  right: 12,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Highlight ${index + 1}',
                        style: const TextStyle(
                          color: DiscordTheme.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.visibility_outlined,
                            size: 14,
                            color: DiscordTheme.softGrey,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${(index + 1) * 124} views',
                            style: const TextStyle(
                              color: DiscordTheme.softGrey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Add duration badge
                Positioned(
                  bottom: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '0:${30 + (index * 7)}',
                      style: const TextStyle(
                        color: DiscordTheme.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// Modernized Card Activity Screen with Discord theme
class CardActivityScreen extends StatelessWidget {
  const CardActivityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DiscordTheme.charcoalGrey,
      appBar: AppBar(
        title: const Text('Activity'),
        backgroundColor: DiscordTheme.darkGrey,
        elevation: 0,
      ),
      body: ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemCount: 20,
        separatorBuilder: (context, index) => const Divider(
          color: DiscordTheme.darkGrey,
          height: 1,
          indent: 70,
        ),
        itemBuilder: (context, index) {
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            leading: CircleAvatar(
              backgroundColor: index % 3 == 0 ? DiscordTheme.primaryRed :
                            index % 3 == 1 ? DiscordTheme.mutedRed : 
                                        DiscordTheme.darkGrey,
              child: Icon(
                index % 3 == 0 ? Icons.update :
                index % 3 == 1 ? Icons.star : Icons.trending_up,
                color: DiscordTheme.white,
                size: 20,
              ),
            ),
            title: Text(
              index % 4 == 0 ? 'Updated your Valorant rank to Diamond' :
              index % 4 == 1 ? 'Gained 14 new followers this week' :
              index % 4 == 2 ? 'Win streak: 5 games in League of Legends' :
                          'Matched with Player${index + 10} for duo queue',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: DiscordTheme.white,
                fontSize: 15,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 6.0),
              child: Text(
                '${index * 3 + 1} hours ago',
                style: const TextStyle(
                  color: DiscordTheme.softGrey,
                  fontSize: 13,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Helper class for the sticky tab bar
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height - 8; // Reduced height
  
  @override
  double get maxExtent => _tabBar.preferredSize.height - 8; // Reduced height

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: DiscordTheme.darkGrey.withOpacity(0.9),
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}