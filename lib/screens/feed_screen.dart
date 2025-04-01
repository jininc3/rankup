import 'package:flutter/material.dart';
import '../widgets/game_player_card.dart';


class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'FEED',
          style: TextStyle(
            letterSpacing: 1.2,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_box_outlined),
            onPressed: () {
              // Add new post
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded),
            onPressed: () {
              // View notifications
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 10, // Sample post count
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
    );
  }

  Widget _buildPlayerCardPost(BuildContext context, int index) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      color: const Color(0xFF1E1E1E),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'FPS_Master${index * 3}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '${(index % 8) + 1}h ago',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.more_horiz),
                  color: Colors.grey[400],
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
              style: const TextStyle(fontSize: 14),
            ),
          ),
          const SizedBox(height: 12),
          
          // Player Card Preview
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: GamePlayerCard(
              gameName: index % 2 == 0 ? 'Valorant' : 'League of Legends',
              rank: index % 4 == 0 ? 'Platinum' : 
                    index % 4 == 1 ? 'Diamond' : 
                    index % 4 == 2 ? 'Gold' : 'Radiant',
              mainCharacters: index % 2 == 0 
                ? ['Jett', 'Reyna', 'Sage'] 
                : ['Ahri', 'Lux', 'Jinx'],
              bio: index % 2 == 0 
                ? 'Duelist main with 1.8 K/D ratio' 
                : 'Mid lane main since Season 3',
              username: 'FPS_Master${index * 3}',
              country: index % 3 == 0 ? 'USA' : 
                      index % 3 == 1 ? 'Canada' : 'UK',
              onTap: () {
                // View card details
              },
            ),
          ),
          
          // Divider
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              height: 1,
              color: const Color(0xFF2A2A2A),
            ),
          ),
          
          // Post Actions
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton.icon(
                  icon: Icon(
                    Icons.favorite_border,
                    size: 18,
                    color: Colors.grey[400],
                  ),
                  label: Text(
                    'Like',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 12,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                  ),
                  onPressed: () {},
                ),
                TextButton.icon(
                  icon: Icon(
                    Icons.chat_bubble_outline,
                    size: 18,
                    color: Colors.grey[400],
                  ),
                  label: Text(
                    'Comment',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 12,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                  ),
                  onPressed: () {},
                ),
                TextButton.icon(
                  icon: Icon(
                    Icons.share_outlined,
                    size: 18,
                    color: Colors.grey[400],
                  ),
                  label: Text(
                    'Share',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 12,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextPost(BuildContext context, int index) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      color: const Color(0xFF1E1E1E),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pro_Gamer${index * 7}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '${(index % 6) + 2}h ago',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.more_horiz),
                  color: Colors.grey[400],
                  iconSize: 20,
                  onPressed: () {},
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Text(
              'Looking for a Diamond+ support main for duo queue tonight. Must have mic and good comms. DM me if interested!',
              style: TextStyle(fontSize: 15),
            ),
          ),
          
          // Tags
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Wrap(
              spacing: 8,
              children: const [
                Chip(
                  label: Text('Diamond+', style: TextStyle(fontSize: 11)),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding: EdgeInsets.zero,
                  labelPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                  backgroundColor: Color(0xFF0A1A2A),
                ),
                Chip(
                  label: Text('Support', style: TextStyle(fontSize: 11)),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding: EdgeInsets.zero,
                  labelPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                  backgroundColor: Color(0xFF0A1A2A),
                ),
                Chip(
                  label: Text('Voice Comms', style: TextStyle(fontSize: 11)),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding: EdgeInsets.zero,
                  labelPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                  backgroundColor: Color(0xFF0A1A2A),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 12),
          
          // Divider
          Container(
            height: 1,
            color: const Color(0xFF2A2A2A),
          ),
          
          // Post Actions
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton.icon(
                  icon: Icon(
                    Icons.favorite_border,
                    size: 18,
                    color: Colors.grey[400],
                  ),
                  label: Text(
                    'Like',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 12,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                  ),
                  onPressed: () {},
                ),
                TextButton.icon(
                  icon: Icon(
                    Icons.chat_bubble_outline,
                    size: 18,
                    color: Colors.grey[400],
                  ),
                  label: Text(
                    'Comment',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 12,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                  ),
                  onPressed: () {},
                ),
                TextButton.icon(
                  icon: Icon(
                    Icons.share_outlined,
                    size: 18,
                    color: Colors.grey[400],
                  ),
                  label: Text(
                    'Share',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 12,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHighlightClipPost(BuildContext context, int index) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      color: const Color(0xFF1E1E1E),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ClipMaster${index * 5}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '${(index % 24) + 1}h ago',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.more_horiz),
                  color: Colors.grey[400],
                  iconSize: 20,
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              index % 2 == 0 
                ? 'Clutched a 1v5 in Valorant! Check this out!' 
                : 'My best play this season! #BronzeToRadiant',
              style: const TextStyle(fontSize: 14),
            ),
          ),
          const SizedBox(height: 12),
          
          // Video Thumbnail with Play Button
          AspectRatio(
            aspectRatio: 16/9,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    image: const DecorationImage(
                      image: NetworkImage('https://via.placeholder.com/800x450'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Play button with accent color
                Container(
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
                // Video duration indicator
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Text(
                      '0:${30 + index * 7}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Post information
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Icon(
                  Icons.visibility_outlined,
                  size: 14,
                  color: Colors.grey[400],
                ),
                const SizedBox(width: 4),
                Text(
                  '${(index + 1) * 124} views',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 12),
                Icon(
                  Icons.favorite,
                  size: 14,
                  color: const Color(0xFFFF4655),
                ),
                const SizedBox(width: 4),
                Text(
                  '${(index + 1) * 23}',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          
          // Divider
          Container(
            height: 1,
            color: const Color(0xFF2A2A2A),
          ),
          
          // Post Actions
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton.icon(
                  icon: Icon(
                    Icons.favorite_border,
                    size: 18,
                    color: Colors.grey[400],
                  ),
                  label: Text(
                    'Like',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 12,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                  ),
                  onPressed: () {},
                ),
                TextButton.icon(
                  icon: Icon(
                    Icons.chat_bubble_outline,
                    size: 18,
                    color: Colors.grey[400],
                  ),
                  label: Text(
                    'Comment',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 12,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                  ),
                  onPressed: () {},
                ),
                TextButton.icon(
                  icon: Icon(
                    Icons.share_outlined,
                    size: 18,
                    color: Colors.grey[400],
                  ),
                  label: Text(
                    'Share',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 12,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}