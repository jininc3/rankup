import 'package:flutter/material.dart';
import '../widgets/game_player_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // Changed to 2 tabs
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          // Card Activity button
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: 'Card Activity',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CardActivityScreen()),
              );
            },
          ),
          // Settings button
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Open settings
            },
          ),
        ],
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            // Profile Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Profile picture
                    const CircleAvatar(
                      radius: 50,
                      backgroundColor: Color(0xFF0A1A2A),
                      child: Text(
                        'PG',
                        style: TextStyle(fontSize: 36, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'ProGamerName',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text('Competitive player since 2015'),
                    const SizedBox(height: 16),
                    
                    // Stats row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStatColumn('PlayerCards', '7'),
                        _buildStatColumn('Followers', '1.2k'),
                        _buildStatColumn('Following', '342'),
                      ],
                    ),
                    const SizedBox(height: 16),
                    
                    // Edit profile button
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF2996F8)), // Blue border
                        foregroundColor: const Color(0xFF2996F8), // Blue text
                      ),
                      onPressed: () {
                        // Navigate to edit profile
                      },
                      child: const Text('Edit Profile'),
                    ),
                  ],
                ),
              ),
            ),
            
            // Pinned TabBar - now with just 2 tabs
            SliverPersistentHeader(
              delegate: _SliverAppBarDelegate(
                TabBar(
                  controller: _tabController,
                  // Custom tab styling for blue selection
                  indicator: const UnderlineTabIndicator(
                    borderSide: BorderSide(
                      width: 2.0,
                      color: Color(0xFF2996F8), // Blue indicator
                    ),
                  ),
                  labelColor: const Color(0xFF2996F8), // Blue text for selected tab
                  unselectedLabelColor: Colors.grey, // Grey text for unselected tabs
                  tabs: const [
                    Tab(text: 'PLAYER CARDS'),
                    Tab(text: 'HIGHLIGHTS'),
                  ],
                ),
              ),
              pinned: true,
            ),
          ];
        },
        // TabBarView as the body - now with 2 tabs only
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildPlayerCardsTab(),
            _buildHighlightsTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatColumn(String title, String count) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildPlayerCardsTab() {
    return CustomScrollView(
      slivers: [
        // Title section
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              'My Game Cards',
              style: TextStyle(
                fontSize: 18, 
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        
        // Horizontal scrolling cards section
        SliverToBoxAdapter(
          child: SizedBox(
            height: 400, // Height for the card ratio
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
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
                      
                return Container(
                  width: 350, // Card width
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: GamePlayerCard(
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
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHighlightsTab() {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Using Container with color instead of network image
              Container(
                color: Colors.grey.shade800,
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
                        Colors.black.withOpacity(0.7),
                      ],
                      stops: const [0.6, 1.0],
                    ),
                  ),
                ),
              ),
              // Play button
              Center(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0A1A2A).withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.play_arrow,
                    size: 36,
                    color: Colors.white,
                  ),
                ),
              ),
              // Title at bottom
              Positioned(
                bottom: 8,
                left: 8,
                right: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Highlight ${index + 1}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${(index + 1) * 124} views',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// Separate Card Activity Screen
class CardActivityScreen extends StatelessWidget {
  const CardActivityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Card Activity'),
        backgroundColor: const Color(0xFF1E1E1E),
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: CircleAvatar(
              backgroundColor: index % 3 == 0 ? Colors.blue.shade800 :
                              index % 3 == 1 ? Colors.purple.shade800 : 
                                            Colors.orange.shade800,
              child: Icon(
                index % 3 == 0 ? Icons.update :
                index % 3 == 1 ? Icons.star : Icons.trending_up,
                color: Colors.white,
                size: 20,
              ),
              
            ),
            title: Text(
              index % 4 == 0 ? 'Updated your Valorant rank to Diamond' :
              index % 4 == 1 ? 'Gained 14 new followers this week' :
              index % 4 == 2 ? 'Win streak: 5 games in League of Legends' :
                            'Matched with Player${index + 10} for duo queue',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text('${index * 3 + 1} hours ago'),
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
  double get minExtent => _tabBar.preferredSize.height;
  
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}