import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
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

  @override
  void initState() {
    super.initState();
    // Now we have two tabs - Highlights and My Feed
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
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
              // Navigate to the card activity screen
              // When we create that component, we'll uncomment this
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const CardActivityScreen()),
              // );
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
              
              // Two tabs: Highlights and My Feed
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
                        icon: Icon(Icons.play_circle_outline, size: 18), // Reduced from default size
                        text: 'HIGHLIGHTS',
                        height: 38, // Reduced from default height
                      ),
                      Tab(
                        icon: Icon(Icons.dynamic_feed, size: 18), // Added feed icon
                        text: 'MY FEED',
                        height: 38, // Reduced from default height
                      ),
                    ],
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          // TabBarView with two tabs: highlights and my feed
          body: TabBarView(
            controller: _tabController,
            children: [
              _buildHighlightsTab(),
              _buildMyFeedTab(),
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

  Widget _buildHighlightsTab() {
  return GridView.builder(
    padding: const EdgeInsets.all(2.0), // Reduced padding to match Instagram's tight grid
    physics: const BouncingScrollPhysics(),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3, // Instagram uses 3 columns
      childAspectRatio: 1.0, // Square aspect ratio
      crossAxisSpacing: 2, // Minimal spacing between items
      mainAxisSpacing: 2, // Minimal spacing between items
    ),
    itemCount: 2,
    itemBuilder: (context, index) {
      return Stack(
        fit: StackFit.expand,
        children: [
          // Background container (image/video placeholder)
          Container(
            color: DiscordTheme.darkGrey,
            child: Center(
              child: Icon(
                Icons.play_circle_outline,
                size: 30,
                color: DiscordTheme.white.withOpacity(0.4),
              ),
            ),
          ),
          
          // Play icon in top right (like Instagram's video indicator)
          Positioned(
            top: 8,
            right: 8,
            child: Icon(
              Icons.play_arrow,
              size: 16,
              color: DiscordTheme.white,
            ),
          ),
          
          // View count in bottom right (like Instagram)
          Positioned(
            bottom: 8,
            right: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(3),
              ),
              child: Text(
                '${(index + 1) * 124}',
                style: const TextStyle(
                  color: DiscordTheme.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}

  // New method to build the My Feed tab with posts in chronological order
  Widget _buildMyFeedTab() {
    return ListView.separated(
      padding: const EdgeInsets.all(12.0),
      physics: const BouncingScrollPhysics(),
      itemCount: 10, // Number of feed posts
      separatorBuilder: (context, index) {
        return Container(
          height: 16,
          color: Colors.transparent,
        );
      },
      itemBuilder: (context, index) {
        // Show different types of posts based on index, similar to feed_screen.dart
        if (index % 3 == 0) {
          return _buildPlayerCardPost(context, index);
        } else if (index % 3 == 1) {
          return _buildTextPost(context, index);
        } else {
          return _buildHighlightClipPost(context, index);
        }
      },
    );
  }

  // Get the appropriate profile image based on type (copied from feed_screen.dart)
  Widget _getProfileImage(String type) {
    String imagePath;
    switch (type.toLowerCase()) {
      case 'f':
        imagePath = 'assets/images/among_us_icon.jpg'; // Image 1
        break;
      case 'p':
        imagePath = 'assets/images/rick_icon.jpg'; // Image 2
        break;
      case 'c':
        imagePath = 'assets/images/cartoon_icon.jpg'; // Image 3
        break;
      default:
        imagePath = 'assets/images/among_us_icon.jpg';
    }
    
    return ClipOval(
      child: Image.asset(
        imagePath,
        width: 32,
        height: 32,
        fit: BoxFit.cover,
      ),
    );
  }
  
  // Get the rank color (copied from feed_screen.dart)
  Color _getRankColor(String rank) {
    switch (rank.toLowerCase()) {
      case 'iron':
        return const Color(0xFF7C8792);
      case 'bronze':
        return const Color(0xFFAD7F47);
      case 'silver':
        return const Color(0xFFAFB8C4);
      case 'gold':
        return const Color(0xFFECCE52);
      case 'platinum':
        return const Color(0xFF47B986);
      case 'diamond':
        return const Color(0xFF4A80EB);
      case 'ascendant':
        return const Color(0xFF44CE9C);
      case 'immortal':
        return const Color(0xFFBF4D4D);
      case 'radiant':
        return const Color(0xFFFFD700);
      default:
        return DiscordTheme.primaryRed;
    }
  }

  // Build player card post (adapted from feed_screen.dart)
  Widget _buildPlayerCardPost(BuildContext context, int index) {
    return Container(
      decoration: BoxDecoration(
        color: DiscordTheme.charcoalGrey,
        border: Border.all(
          color: DiscordTheme.darkGrey.withOpacity(0.8),
          width: 2.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
        borderRadius: BorderRadius.circular(8.0), // Added rounded corners
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                // Profile image
                _getProfileImage('F'),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'ProGamerName', // Use the user's username instead of a generated one
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: DiscordTheme.white,
                      ),
                    ),
                    Text(
                      '${(index % 8) + 1}d ago', // Changed to days ago
                      style: const TextStyle(
                        color: DiscordTheme.softGrey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.more_horiz, color: DiscordTheme.white),
                  iconSize: 20,
                  onPressed: () {},
                ),
              ],
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Just updated my ${index % 2 == 0 ? "Valorant" : "League of Legends"} card!',
              style: const TextStyle(
                fontSize: 14,
                color: DiscordTheme.white,
              ),
            ),
          ),
          
          const SizedBox(height: 8),
          
          Container(
            decoration: BoxDecoration(
              color: DiscordTheme.darkGrey,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: index % 2 == 0 
                    ? [DiscordTheme.primaryRed.withOpacity(0.7), DiscordTheme.charcoalGrey]
                    : [DiscordTheme.darkGrey, DiscordTheme.charcoalGrey],
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      _getProfileImage('F'),
                      const SizedBox(width: 8),
                      const Text(
                        'ProGamerName', // User's name
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: DiscordTheme.white,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        index % 2 == 0 ? 'Valorant' : 'League of Legends',
                        style: const TextStyle(
                          color: DiscordTheme.lightGrey,
                          fontSize: 12,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.more_vert, color: DiscordTheme.white),
                        iconSize: 16,
                        constraints: const BoxConstraints(),
                        padding: const EdgeInsets.only(left: 8),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                
                SizedBox(
                  height: 220,
                  child: Stack(
                    children: [
                      Center(
                        child: Icon(
                          index % 2 == 0 ? Icons.gps_fixed : Icons.shield,
                          size: 80,
                          color: DiscordTheme.white.withOpacity(0.3),
                        ),
                      ),
                      
                      Positioned(
                        top: 12,
                        left: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: DiscordTheme.charcoalGrey.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.public,
                                size: 14,
                                color: DiscordTheme.lightGrey,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                index % 3 == 0 ? 'USA' : (index % 3 == 1 ? 'Canada' : 'UK'),
                                style: const TextStyle(
                                  color: DiscordTheme.lightGrey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      Positioned(
                        top: 12,
                        right: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: DiscordTheme.charcoalGrey.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.emoji_events,
                                size: 14,
                                color: _getRankColor(index % 4 == 0 ? 'Platinum' : 
                                                  index % 4 == 1 ? 'Diamond' : 
                                                  index % 4 == 2 ? 'Gold' : 'Radiant'),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                index % 4 == 0 ? 'PLATINUM' : 
                                index % 4 == 1 ? 'DIAMOND' : 
                                index % 4 == 2 ? 'GOLD' : 'RADIANT',
                                style: TextStyle(
                                  color: _getRankColor(index % 4 == 0 ? 'Platinum' : 
                                                    index % 4 == 1 ? 'Diamond' : 
                                                    index % 4 == 2 ? 'Gold' : 'Radiant'),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.favorite_border, color: DiscordTheme.white),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.chat_bubble_outline, color: DiscordTheme.white),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.send_outlined, color: DiscordTheme.white),
                  onPressed: () {},
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.bookmark_border, color: DiscordTheme.white),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              '${267 - (index * 30)} likes', // Decreasing number of likes based on age
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: DiscordTheme.white,
                fontSize: 14,
              ),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 4.0),
            child: RichText(
              text: const TextSpan(
                style: TextStyle(fontSize: 14, color: DiscordTheme.white),
                children: [
                  TextSpan(
                    text: 'ProGamerName ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: 'Duelist main with 1.8 K/D ratio',
                  ),
                ],
              ),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 2.0, 16.0, 8.0),
            child: Text(
              index % 2 == 0 
                ? '#Jett #Reyna #Sage' 
                : '#Ahri #Lux #Jinx',
              style: const TextStyle(
                color: DiscordTheme.primaryRed,
                fontSize: 14,
              ),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
            child: Text(
              '${(index % 8) + 1} days ago',
              style: const TextStyle(
                color: DiscordTheme.softGrey,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextPost(BuildContext context, int index) {
  return Container(
    decoration: BoxDecoration(
      color: DiscordTheme.charcoalGrey,
      border: Border.all(
        color: DiscordTheme.darkGrey.withOpacity(0.8),
        width: 2.0,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
      borderRadius: BorderRadius.circular(8.0), // Added rounded corners
    ),
    margin: const EdgeInsets.symmetric(horizontal: 2),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              // Profile image using the logged-in user's image
              _getProfileImage('P'),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'ProGamerName', // User's name instead of generated name
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: DiscordTheme.white,
                    ),
                  ),
                  Text(
                    '${(index % 6) + 2}d ago', // Changed to days ago
                    style: const TextStyle(
                      color: DiscordTheme.softGrey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.more_horiz, color: DiscordTheme.white),
                iconSize: 20,
                onPressed: () {},
              ),
            ],
          ),
        ),
        
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          color: DiscordTheme.darkGrey,
          child: Text(
            index % 2 == 0 
                ? 'Looking for a Diamond+ support main for duo queue tonight. Must have mic and good comms. DM me if interested!' 
                : 'Just hit Diamond rank in Valorant! Looking for a team to grind with this weekend. Discord voice preferred.',
            style: const TextStyle(
              fontSize: 16,
              color: DiscordTheme.white,
              height: 1.4,
            ),
          ),
        ),
        
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            index % 2 == 0 
                ? '#Diamond #Support #VoiceComms' 
                : '#Valorant #Grinding #WeekendWarrior',
            style: const TextStyle(
              color: DiscordTheme.primaryRed,
              fontSize: 14,
            ),
          ),
        ),
        
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.favorite_border, color: DiscordTheme.white),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.chat_bubble_outline, color: DiscordTheme.white),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.send_outlined, color: DiscordTheme.white),
                onPressed: () {},
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.bookmark_border, color: DiscordTheme.white),
                onPressed: () {},
              ),
            ],
          ),
        ),
        
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '${42 + (index * 7)} likes',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: DiscordTheme.white,
              fontSize: 14,
            ),
          ),
        ),
        
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
          child: Text(
            '${(index % 6) + 2} days ago',
            style: const TextStyle(
              color: DiscordTheme.softGrey,
              fontSize: 12,
            ),
          ),
        ),
      ],
    ),
  );
}

// Build highlight clip post (adapted from feed_screen.dart)
Widget _buildHighlightClipPost(BuildContext context, int index) {
  return Container(
    decoration: BoxDecoration(
      color: DiscordTheme.charcoalGrey,
      border: Border.all(
        color: DiscordTheme.darkGrey.withOpacity(0.8),
        width: 2.0,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
      borderRadius: BorderRadius.circular(8.0), // Added rounded corners
    ),
    margin: const EdgeInsets.symmetric(horizontal: 2),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              // Profile image
              _getProfileImage('C'),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'ProGamerName', // User's name
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: DiscordTheme.white,
                    ),
                  ),
                  Text(
                    '${(index % 10) + 1}d ago', // Changed to days ago
                    style: const TextStyle(
                      color: DiscordTheme.softGrey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.more_horiz, color: DiscordTheme.white),
                iconSize: 20,
                onPressed: () {},
              ),
            ],
          ),
        ),
        
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.width * 0.75, // Make it a bit shorter than the feed
          color: DiscordTheme.darkGrey,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Placeholder for video
              Container(
                color: DiscordTheme.darkGrey,
                child: Center(
                  child: Icon(
                    Icons.movie_outlined,
                    size: 80,
                    color: DiscordTheme.white.withOpacity(0.2),
                  ),
                ),
              ),
              // Play button
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: DiscordTheme.primaryRed.withOpacity(0.3),
                  shape: BoxShape.circle,
                  border: Border.all(color: DiscordTheme.white, width: 2),
                ),
                child: const Icon(Icons.play_arrow, size: 40, color: DiscordTheme.white),
              ),
              // Video duration
              Positioned(
                bottom: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '0:${30 + (index * 5)}',
                    style: const TextStyle(
                      color: DiscordTheme.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.favorite_border, color: DiscordTheme.white),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.chat_bubble_outline, color: DiscordTheme.white),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.send_outlined, color: DiscordTheme.white),
                onPressed: () {},
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.bookmark_border, color: DiscordTheme.white),
                onPressed: () {},
              ),
            ],
          ),
        ),
        
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${(index + 1) * 124} views',
                style: const TextStyle(
                  color: DiscordTheme.white,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '${(index + 1) * 23} likes',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: DiscordTheme.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 4.0),
          child: RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 14, color: DiscordTheme.white),
              children: [
                const TextSpan(
                  text: 'ProGamerName ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: index % 2 == 0 
                    ? 'Clutched a 1v5 in Valorant! Check this out!' 
                    : 'My best play this season! #BronzeToRadiant',
                ),
              ],
            ),
          ),
        ),
        
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 2.0, 16.0, 8.0),
          child: Text(
            index % 2 == 0 
              ? '#Clutch #Valorant #Gaming' 
              : '#BronzeToRadiant #GrindTime',
            style: const TextStyle(
              color: DiscordTheme.primaryRed,
              fontSize: 14,
            ),
          ),
        ),
        
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
          child: Text(
            '${(index % 10) + 1} days ago',
            style: const TextStyle(
              color: DiscordTheme.softGrey,
              fontSize: 12,
            ),
          ),
        ),

        
      ],

      
    ),

    
  );

  
}


}

// Add the _SliverAppBarDelegate class here
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