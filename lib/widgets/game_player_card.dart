import 'package:flutter/material.dart';

class GamePlayerCard extends StatelessWidget {
  final String gameName;
  final String rank;
  final List<String> mainCharacters;
  final String bio;
  final VoidCallback onTap;
  final String username;
  final String country;

  const GamePlayerCard({
    Key? key,
    required this.gameName,
    required this.rank,
    required this.mainCharacters,
    required this.bio,
    required this.onTap,
    this.username = 'User',
    this.country = 'Unknown',
  }) : super(key: key);

  Color getRankColor(String rank) {
    switch (rank.toLowerCase()) {
      case 'iron':
        return const Color(0xFF8E9093);
      case 'bronze':
        return const Color(0xFFCD7F32);
      case 'silver':
        return const Color(0xFFC0C0C0);
      case 'gold':
        return const Color(0xFFFFD700);
      case 'platinum':
        return const Color(0xFF00FFFF);
      case 'diamond':
        return const Color(0xFF4B92DB);
      case 'master':
        return const Color(0xFF9A35FF);
      case 'grandmaster':
        return const Color(0xFFFF4655);
      case 'challenger':
      case 'radiant':
      case 'global elite':
        return const Color(0xFFFF9800);
      default:
        return const Color(0xFF2996F8); // Valorant blue default
    }
  }

  @override
  Widget build(BuildContext context) {
    final rankColor = getRankColor(rank);
    final isPlatinum = rank.toLowerCase().contains('platinum');

    // Get the available width from the parent container
    // This will be used to maintain the 100:200 width-to-height ratio
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate height based on width to maintain 100:200 ratio
        final cardWidth = constraints.maxWidth;
        final cardHeight = cardWidth * 2; // 100:200 ratio
        
        return GestureDetector(
          onTap: onTap,
          child: Container(
            height: cardHeight,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: rankColor, width: 2),
              boxShadow: [
                BoxShadow(
                  color: rankColor.withOpacity(0.35),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Background image for platinum rank
                if (isPlatinum)
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Opacity(
                        opacity: 0.85, // Slightly transparent so other elements are visible
                        child: Image.asset(
                          'assets/images/platinum_bg.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                
                // Geometric patterns for Valorant-style aesthetic
                Positioned(
                  top: 0,
                  right: 0,
                  child: ClipPath(
                    clipper: DiagonalClipper(),
                    child: Container(
                      height: 60,
                      width: 60,
                      color: rankColor.withOpacity(0.6),
                    ),
                  ),
                ),
                // Left bottom corner line
                Positioned(
                  bottom: 20,
                  left: 0,
                  child: Container(
                    height: 2,
                    width: 60,
                    color: rankColor.withOpacity(0.3),
                  ),
                ),
                // Top main content (game card design)
                Positioned.fill(
                  child: Column(
                    children: [
                      // Top section (80% of the card)
                      Expanded(
                        flex: 8,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(isPlatinum ? 0.2 : 0.5),
                                Colors.transparent,
                              ],
                            ),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Game icon (could be replaced with game logo)
                                Icon(
                                  _getGameIcon(gameName),
                                  size: 60,
                                  color: rankColor.withOpacity(isPlatinum ? 0.7 : 0.4),
                                ),
                                const SizedBox(height: 20),
                                // Optional: Add geometric patterns for visual appeal
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Bottom info section (20% of the card)
                      Expanded(
                        flex: 5,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(isPlatinum ? 0.6 : 0.5),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(6),
                              bottomRight: Radius.circular(6),
                            ),
                          ),
                          child: _buildCardInfo(rankColor),
                        ),
                      ),
                    ],
                  ),
                ),
                // Game label at top
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(_getGameIcon(gameName),
                          size: 14, color: Colors.white70),
                      const SizedBox(width: 6),
                      Text(
                        gameName.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.white60,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
                // Platinum rank indicator
                if (isPlatinum)
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: rankColor, width: 1.5),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.workspace_premium, size: 14, color: rankColor),
                          const SizedBox(width: 4),
                          Text(
                            'PLATINUM',
                            style: TextStyle(
                              color: rankColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      }
    );
  }

  Widget _buildCardInfo(Color rankColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Username
        Text(
          username,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),

        // Country & Rank Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(Icons.public,
                    size: 16, color: Colors.white54),
                const SizedBox(width: 4),
                Text(
                  country,
                  style: const TextStyle(
                      color: Colors.white60, fontSize: 13),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: rankColor.withOpacity(0.2),
                border: Border.all(color: rankColor, width: 1),
              ),
              child: Text(
                rank.toUpperCase(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: rankColor,
                    fontSize: 12),
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        // Agents / Characters
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'MAIN: ',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white54,
                fontSize: 12,
              ),
            ),
            Expanded(
              child: Text(
                mainCharacters.join(' • '),
                style: const TextStyle(
                    fontSize: 13, color: Colors.white),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }

  IconData _getGameIcon(String game) {
    switch (game.toLowerCase()) {
      case 'league of legends':
        return Icons.shield;
      case 'valorant':
        return Icons.gps_fixed;
      case 'cs:go':
      case 'counter-strike':
        return Icons.my_location;
      case 'apex legends':
        return Icons.flash_on;
      case 'fortnite':
        return Icons.landscape;
      default:
        return Icons.gamepad;
    }
  }
}

class DiagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.6);
    path.lineTo(size.width * 0.4, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}