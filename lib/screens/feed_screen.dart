import 'package:flutter/material.dart';
import '../widgets/game_player_card.dart';

// Use the DiscordColors class from game_player_card.dart instead of attempting to import from theme directory
// This assumes the class is accessible from game_player_card.dart as shown in your documents

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DiscordColors.charcoalGrey, // Use DiscordColors
      appBar: AppBar(
        backgroundColor: DiscordColors.darkGrey, // Use DiscordColors
        elevation: 0,
        title: const Text(
          'FEED',
          style: TextStyle(
            letterSpacing: 1.2,
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: DiscordColors.white, // Use DiscordColors
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_box_outlined, color: DiscordColors.white),
            onPressed: () {
              // Add new post
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded, color: DiscordColors.white),
            onPressed: () {
              // View notifications
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          // Alternate between post types for demo
          if (index % 3 == 0) {
            return _buildPlayerCardPost(context, index);
          } else if (index % 3 == 1) {
            return _buildTextPost(context, index);
          } else {
            return _buildHighlightClipPost(context, index);
          }
        },
      ),
      // Removed the bottom navigation bar - it will be provided by the parent widget
    );
  }

  Widget _buildPlayerCardPost(BuildContext context, int index) {
    // Instagram-style post with player card
    return Container(
      color: DiscordColors.charcoalGrey, // Use DiscordColors
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Post header with username and time
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                // User avatar
                CircleAvatar(
                  radius: 16,
                  backgroundColor: DiscordColors.darkGrey, // Use DiscordColors
                  child: Text(
                    'F',
                    style: const TextStyle(
                      color: DiscordColors.primaryRed, // Use DiscordColors
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // Username and time
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'FPS_Master${index * 3}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: DiscordColors.white, // Use DiscordColors
                      ),
                    ),
                    Text(
                      '${(index % 8) + 1}h ago',
                      style: const TextStyle(
                        color: DiscordColors.softGrey, // Use DiscordColors
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                // More options button
                IconButton(
                  icon: const Icon(Icons.more_horiz, color: DiscordColors.white),
                  iconSize: 20,
                  onPressed: () {},
                ),
              ],
            ),
          ),
          
          // Post caption
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Just updated my ${index % 2 == 0 ? "Valorant" : "League of Legends"} card!',
              style: const TextStyle(
                fontSize: 14,
                color: DiscordColors.white, // Use DiscordColors
              ),
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Game card - now integrated as part of the post, not as a separate widget
          // This lets us match the Instagram style more closely
          Container(
            decoration: BoxDecoration(
              color: DiscordColors.darkGrey, // Use DiscordColors
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: index % 2 == 0 
                    ? [DiscordColors.primaryRed.withOpacity(0.7), DiscordColors.charcoalGrey]
                    : [DiscordColors.darkGrey, DiscordColors.charcoalGrey],
              ),
            ),
            child: Column(
              children: [
                // Game card header with user info
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 14,
                        backgroundColor: DiscordColors.charcoalGrey.withOpacity(0.7), // Use DiscordColors
                        child: Text(
                          'F',
                          style: const TextStyle(
                            color: DiscordColors.white, // Use DiscordColors
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'FPS_Master${index * 3}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: DiscordColors.white, // Use DiscordColors
                        ),
                      ),
                      const Spacer(),
                      Text(
                        index % 2 == 0 ? 'Valorant' : 'League of Legends',
                        style: const TextStyle(
                          color: DiscordColors.lightGrey, // Use DiscordColors
                          fontSize: 12,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.more_vert, color: DiscordColors.white),
                        iconSize: 16,
                        constraints: const BoxConstraints(),
                        padding: const EdgeInsets.only(left: 8),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                
                // Game card content
                SizedBox(
                  height: 220,
                  child: Stack(
                    children: [
                      // Center icon
                      Center(
                        child: Icon(
                          index % 2 == 0 ? Icons.gps_fixed : Icons.shield,
                          size: 80,
                          color: DiscordColors.white.withOpacity(0.3), // Use DiscordColors
                        ),
                      ),
                      
                      // Country badge
                      Positioned(
                        top: 12,
                        left: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: DiscordColors.charcoalGrey.withOpacity(0.6), // Use DiscordColors
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.public,
                                size: 14,
                                color: DiscordColors.lightGrey, // Use DiscordColors
                              ),
                              const SizedBox(width: 6),
                              Text(
                                index % 3 == 0 ? 'USA' : (index % 3 == 1 ? 'Canada' : 'UK'),
                                style: const TextStyle(
                                  color: DiscordColors.lightGrey, // Use DiscordColors
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      // Rank badge
                      Positioned(
                        top: 12,
                        right: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: DiscordColors.charcoalGrey.withOpacity(0.6), // Use DiscordColors
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
          
          // Post interaction buttons - Instagram style
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.favorite_border, color: DiscordColors.white),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.chat_bubble_outline, color: DiscordColors.white),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.send_outlined, color: DiscordColors.white),
                  onPressed: () {},
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.bookmark_border, color: DiscordColors.white),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          
          // Likes count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              '267 likes',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: DiscordColors.white, // Use DiscordColors
                fontSize: 14,
              ),
            ),
          ),
          
          // Caption with username and bio
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 4.0),
            child: RichText(
              text: const TextSpan(
                style: TextStyle(fontSize: 14, color: DiscordColors.white), // Use DiscordColors
                children: [
                  TextSpan(
                    text: 'FPS_Master ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: 'Duelist main with 1.8 K/D ratio',
                  ),
                ],
              ),
            ),
          ),
          
          // Main characters as hashtags
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 2.0, 16.0, 8.0),
            child: Text(
              index % 2 == 0 
                ? '#Jett #Reyna #Sage' 
                : '#Ahri #Lux #Jinx',
              style: const TextStyle(
                color: DiscordColors.primaryRed, // Use DiscordColors red
                fontSize: 14,
              ),
            ),
          ),
          
          // Time indicator
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
            child: Text(
              '2 hours ago',
              style: TextStyle(
                color: DiscordColors.softGrey, // Use DiscordColors
                fontSize: 12,
              ),
            ),
          ),
          
          // Divider between posts
          Divider(height: 1, color: DiscordColors.darkGrey), // Use DiscordColors
        ],
      ),
    );
  }

  Widget _buildTextPost(BuildContext context, int index) {
    // Instagram-style text post
    return Container(
      color: DiscordColors.charcoalGrey, // Use DiscordColors
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Post header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                // User avatar
                CircleAvatar(
                  radius: 16,
                  backgroundColor: DiscordColors.darkGrey, // Use DiscordColors
                  child: Text(
                    'P',
                    style: const TextStyle(
                      color: DiscordColors.primaryRed, // Use DiscordColors
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // Username and time
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pro_Gamer${index * 7}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: DiscordColors.white, // Use DiscordColors
                      ),
                    ),
                    Text(
                      '${(index % 6) + 2}h ago',
                      style: const TextStyle(
                        color: DiscordColors.softGrey, // Use DiscordColors
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                // More options button
                IconButton(
                  icon: const Icon(Icons.more_horiz, color: DiscordColors.white),
                  iconSize: 20,
                  onPressed: () {},
                ),
              ],
            ),
          ),
          
          // Text post content
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            color: DiscordColors.darkGrey, // Use DiscordColors
            child: const Text(
              'Looking for a Diamond+ support main for duo queue tonight. Must have mic and good comms. DM me if interested!',
              style: TextStyle(
                fontSize: 16,
                color: DiscordColors.white, // Use DiscordColors
                height: 1.4,
              ),
            ),
          ),
          
          // Tags as Instagram-style hashtags
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '#Diamond #Support #VoiceComms',
              style: TextStyle(
                color: DiscordColors.primaryRed, // Use DiscordColors
                fontSize: 14,
              ),
            ),
          ),
          
          // Post interaction buttons - Instagram style
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.favorite_border, color: DiscordColors.white),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.chat_bubble_outline, color: DiscordColors.white),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.send_outlined, color: DiscordColors.white),
                  onPressed: () {},
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.bookmark_border, color: DiscordColors.white),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          
          // Likes count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              '${42 + index * 7} likes',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: DiscordColors.white, // Use DiscordColors
                fontSize: 14,
              ),
            ),
          ),
          
          // Time indicator
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
            child: Text(
              '${(index % 6) + 2} hours ago',
              style: const TextStyle(
                color: DiscordColors.softGrey, // Use DiscordColors
                fontSize: 12,
              ),
            ),
          ),
          
          // Divider between posts
          Divider(height: 1, color: DiscordColors.darkGrey), // Use DiscordColors
        ],
      ),
    );
  }

  Widget _buildHighlightClipPost(BuildContext context, int index) {
    // Instagram-style video post
    return Container(
      color: DiscordColors.charcoalGrey, // Use DiscordColors
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Post header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                // User avatar
                CircleAvatar(
                  radius: 16,
                  backgroundColor: DiscordColors.darkGrey, // Use DiscordColors
                  child: Text(
                    'C',
                    style: const TextStyle(
                      color: DiscordColors.primaryRed, // Use DiscordColors
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // Username and time
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ClipMaster${index * 5}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: DiscordColors.white, // Use DiscordColors
                      ),
                    ),
                    Text(
                      '${(index % 24) + 1}h ago',
                      style: const TextStyle(
                        color: DiscordColors.softGrey, // Use DiscordColors
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                // More options button
                IconButton(
                  icon: const Icon(Icons.more_horiz, color: DiscordColors.white),
                  iconSize: 20,
                  onPressed: () {},
                ),
              ],
            ),
          ),
          
          // Video post content
          AspectRatio(
            aspectRatio: 1, // Instagram-like square video
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  color: DiscordColors.darkGrey, // Use DiscordColors
                ),
                // Play button
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: DiscordColors.primaryRed.withOpacity(0.3), // Use DiscordColors
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: DiscordColors.white,
                      width: 2,
                    ),
                  ),
                  child: const Icon(
                    Icons.play_arrow,
                    size: 40,
                    color: DiscordColors.white, // Use DiscordColors
                  ),
                ),
                // Video duration
                Positioned(
                  bottom: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: DiscordColors.charcoalGrey.withOpacity(0.7), // Use DiscordColors
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '0:${30 + index * 7}',
                      style: const TextStyle(
                        color: DiscordColors.white, // Use DiscordColors
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Post interaction buttons - Instagram style
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.favorite_border, color: DiscordColors.white),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.chat_bubble_outline, color: DiscordColors.white),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.send_outlined, color: DiscordColors.white),
                  onPressed: () {},
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.bookmark_border, color: DiscordColors.white),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          
          // Likes and views
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${(index + 1) * 124} views',
                  style: const TextStyle(
                    color: DiscordColors.white, // Use DiscordColors
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${(index + 1) * 23} likes',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: DiscordColors.white, // Use DiscordColors
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          
          // Caption with username
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 4.0),
            child: RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 14, color: DiscordColors.white), // Use DiscordColors
                children: [
                  TextSpan(
                    text: 'ClipMaster${index * 5} ',
                    style: const TextStyle(fontWeight: FontWeight.bold),
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
          
          // Hashtags
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 2.0, 16.0, 8.0),
            child: Text(
              index % 2 == 0 
                ? '#Clutch #Valorant #Gaming' 
                : '#BronzeToRadiant #GrindTime',
              style: TextStyle(
                color: DiscordColors.primaryRed, // Use DiscordColors
                fontSize: 14,
              ),
            ),
          ),
          
          // Time indicator
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
            child: Text(
              '${(index % 24) + 1} hours ago',
              style: const TextStyle(
                color: DiscordColors.softGrey, // Use DiscordColors
                fontSize: 12,
              ),
            ),
          ),
          
          // Divider between posts
          Divider(height: 1, color: DiscordColors.darkGrey), // Use DiscordColors
        ],
      ),
    );
  }
  
  Color _getRankColor(String rank) {
    // Match colors to Valorant rank colors
    switch (rank.toLowerCase()) {
      case 'iron':
        return const Color(0xFF7C8792); // Grey
      case 'bronze':
        return const Color(0xFFAD7F47); // Bronze
      case 'silver':
        return const Color(0xFFAFB8C4); // Silver
      case 'gold':
        return const Color(0xFFECCE52); // Gold
      case 'platinum':
        return const Color(0xFF47B986); // Teal
      case 'diamond':
        return const Color(0xFF4A80EB); // Blue (adjusted to match image)
      case 'ascendant':
        return const Color(0xFF44CE9C); // Green
      case 'immortal':
        return const Color(0xFFBF4D4D); // Red
      case 'radiant':
        return const Color(0xFFFFD700); // Gold/Yellow
      default:
        return DiscordColors.primaryRed; // Discord red default
    }
  }
}

// Remove the local Discord theme class since we're using the one from game_player_card.dart
// Use DiscordColors from game_player_card.dart instead