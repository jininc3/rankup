import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../widgets/game_player_card.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DiscordColors.charcoalGrey,
      appBar: AppBar(
        backgroundColor: DiscordColors.darkGrey,
        elevation: 0,
        title: const Text(
          'FEED',
          style: TextStyle(
            letterSpacing: 1.2,
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: DiscordColors.white,
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
      body: ListView.separated(
        itemCount: 10,
        separatorBuilder: (context, index) {
          return Container(
            height: 16,
            color: Colors.black,
          );
        },
        itemBuilder: (context, index) {
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

  // Get the appropriate profile image based on type
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

  Widget _buildPlayerCardPost(BuildContext context, int index) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.black,
      border: Border.all(
        color: const Color(0xFF4A80EB), // Blue border
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(8.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header Row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              _getProfileImage('F'),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'ProGamerName',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '${(index % 8) + 1}d ago',
                    style: const TextStyle(
                      color: DiscordColors.softGrey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.more_horiz, color: Colors.white),
                iconSize: 20,
                onPressed: () {},
              ),
            ],
          ),
        ),

        // Status text
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Just updated my ${index % 2 == 0 ? "Valorant" : "League of Legends"} card!',
            style: const TextStyle(fontSize: 14, color: Colors.white),
          ),
        ),

        const SizedBox(height: 8),

        // Game Card content
        Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(4.0),
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
                      'ProGamerName',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      index % 2 == 0 ? 'Valorant' : 'League of Legends',
                      style: const TextStyle(
                        color: DiscordColors.lightGrey,
                        fontSize: 12,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.more_vert, color: Colors.white),
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
                        color: Colors.white.withOpacity(0.3),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Interaction buttons
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              IconButton(icon: const Icon(Icons.favorite_border, color: Colors.white), onPressed: () {}),
              IconButton(icon: const Icon(Icons.chat_bubble_outline, color: Colors.white), onPressed: () {}),
              IconButton(icon: const Icon(Icons.send_outlined, color: Colors.white), onPressed: () {}),
              const Spacer(),
              IconButton(icon: const Icon(Icons.bookmark_border, color: Colors.white), onPressed: () {}),
            ],
          ),
        ),

        // Likes
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '${267 - (index * 30)} likes',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ),

        // Caption
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 4.0),
          child: RichText(
            text: const TextSpan(
              style: TextStyle(fontSize: 14, color: Colors.white),
              children: [
                TextSpan(text: 'ProGamerName ', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: 'Duelist main with 1.8 K/D ratio'),
              ],
            ),
          ),
        ),

        // Hashtags
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 2.0, 16.0, 8.0),
          child: Text(
            index % 2 == 0 ? '#Jett #Reyna #Sage' : '#Ahri #Lux #Jinx',
            style: const TextStyle(color: DiscordColors.primaryRed, fontSize: 14),
          ),
        ),

        // Timestamp
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
          child: Text(
            '${(index % 8) + 1} days ago',
            style: const TextStyle(color: DiscordColors.softGrey, fontSize: 12),
          ),
        ),
      ],
    ),
  );
}


 Widget _buildTextPost(BuildContext context, int index) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.black,
      border: Border.all(
        color: const Color(0xFF4A80EB), // Thin blue border
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(8.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    margin: const EdgeInsets.symmetric(horizontal: 2),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              _getProfileImage('P'),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Pro_Gamer7',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '${(index % 6) + 2}h ago',
                    style: const TextStyle(
                      color: DiscordColors.softGrey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.more_horiz, color: Colors.white),
                iconSize: 20,
                onPressed: () {},
              ),
            ],
          ),
        ),

        // Post message content
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: const Text(
            'Looking for a Diamond+ support main for duo queue tonight. Must have mic and good comms. DM me if interested!',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              height: 1.4,
            ),
          ),
        ),

        // Hashtags
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: const Text(
            '#Diamond #Support #VoiceComms',
            style: TextStyle(
              color: DiscordColors.primaryRed,
              fontSize: 14,
            ),
          ),
        ),

        // Interaction buttons
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.favorite_border, color: Colors.white),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.chat_bubble_outline, color: Colors.white),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.send_outlined, color: Colors.white),
                onPressed: () {},
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.bookmark_border, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
        ),

        // Likes and timestamp
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '${42 + index * 7} likes',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
          child: Text(
            '${(index % 6) + 2} hours ago',
            style: const TextStyle(
              color: DiscordColors.softGrey,
              fontSize: 12,
            ),
          ),
        ),
      ],
    ),
  );
}


  Widget _buildHighlightClipPost(BuildContext context, int index) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.black,
      border: Border.all(
        color: const Color(0xFF4A80EB), // Thin blue
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(8.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    margin: const EdgeInsets.symmetric(horizontal: 2),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              _getProfileImage('C'),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'ProGamerName',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '${(index % 10) + 1}d ago',
                    style: const TextStyle(
                      color: DiscordColors.softGrey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.more_horiz, color: Colors.white),
                iconSize: 20,
                onPressed: () {},
              ),
            ],
          ),
        ),

        // Video area (placeholder)
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.width * 0.75,
          color: Colors.black,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(Icons.movie_outlined, size: 80, color: Colors.white.withOpacity(0.2)),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: DiscordColors.primaryRed.withOpacity(0.3),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const Icon(Icons.play_arrow, size: 40, color: Colors.white),
              ),
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

        // Buttons
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              IconButton(icon: const Icon(Icons.favorite_border, color: Colors.white), onPressed: () {}),
              IconButton(icon: const Icon(Icons.chat_bubble_outline, color: Colors.white), onPressed: () {}),
              IconButton(icon: const Icon(Icons.send_outlined, color: Colors.white), onPressed: () {}),
              const Spacer(),
              IconButton(icon: const Icon(Icons.bookmark_border, color: Colors.white), onPressed: () {}),
            ],
          ),
        ),

        // Views and likes
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${(index + 1) * 124} views', style: const TextStyle(color: Colors.white, fontSize: 14)),
              const SizedBox(height: 2),
              Text('${(index + 1) * 23} likes', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 14)),
            ],
          ),
        ),

        // Caption
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 4.0),
          child: RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 14, color: Colors.white),
              children: [
                const TextSpan(text: 'ProGamerName ', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: index % 2 == 0 ? 'Clutched a 1v5 in Valorant! Check this out!' : 'My best play this season! #BronzeToRadiant'),
              ],
            ),
          ),
        ),

        // Hashtags
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 2.0, 16.0, 8.0),
          child: Text(
            index % 2 == 0 ? '#Clutch #Valorant #Gaming' : '#BronzeToRadiant #GrindTime',
            style: const TextStyle(color: DiscordColors.primaryRed, fontSize: 14),
          ),
        ),

        // Timestamp
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
          child: Text(
            '${(index % 10) + 1} days ago',
            style: const TextStyle(color: DiscordColors.softGrey, fontSize: 12),
          ),
        ),
      ],
    ),
  );
}

  
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
        return DiscordColors.primaryRed;
    }
  }
}

// For temporary compatibility - assume DiscordColors is defined in game_player_card.dart
class DiscordColors {
  static const primaryRed = Color(0xFFED4245);
  static const darkGrey = Color(0xFF2C2F33);
  static const charcoalGrey = Color(0xFF23272A);
  static const lightGrey = Color(0xFFB9BBBE);
  static const white = Color(0xFFFFFFFF);
  static const mutedRed = Color(0xFFA83232);
  static const softGrey = Color(0xFF99AAB5);
}

class FeedVideoPlayer extends StatefulWidget {
  final String videoUrl;
  const FeedVideoPlayer({super.key, required this.videoUrl});

  @override
  State<FeedVideoPlayer> createState() => _FeedVideoPlayerState();
}

class _FeedVideoPlayerState extends State<FeedVideoPlayer> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? GestureDetector(
            onTap: () {
              setState(() {
                _controller.value.isPlaying ? _controller.pause() : _controller.play();
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: _controller.value.size.width,
                      height: _controller.value.size.height,
                      child: VideoPlayer(_controller),
                    ),
                  ),
                ),
                if (!_controller.value.isPlaying)
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: DiscordColors.primaryRed.withOpacity(0.3),
                      shape: BoxShape.circle,
                      border: Border.all(color: DiscordColors.white, width: 2),
                    ),
                    child: const Icon(Icons.play_arrow, size: 40, color: DiscordColors.white),
                  ),
              ],
            ),
          )
        : const Center(child: CircularProgressIndicator());
  }
}