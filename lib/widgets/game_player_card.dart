import 'package:flutter/material.dart';
import 'dart:ui' as ui;

// Discord-style color palette
class DiscordColors {
  static const Color primaryRed = Color(0xFFED4245);
  static const Color darkGrey = Color(0xFF2C2F33);
  static const Color charcoalGrey = Color(0xFF23272A);
  static const Color lightGrey = Color(0xFFB9BBBE);
  static const Color white = Color(0xFFFFFFFF);
  static const Color mutedRed = Color(0xFFA83232);
  static const Color softGrey = Color(0xFF99AAB5);
}

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

  @override
  Widget build(BuildContext context) {
    final rankColor = getRankColor(rank);
    
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = constraints.maxWidth * 0.85; // Make card 85% of available width
        // Making the card more rectangular like in the image
        final cardHeight = cardWidth * 1.5; // Slightly shorter aspect ratio
        
        return GestureDetector(
          onTap: onTap,
          child: Container(
            width: cardWidth,
            height: cardHeight,
            margin: const EdgeInsets.fromLTRB(8.0, 24.0, 8.0, 16.0), // More space above the card
            child: Stack(
              children: [
                // Card background with border
                _buildCardBackground(cardWidth, cardHeight, rankColor),
                
                // Card content
                Positioned.fill(
                  child: Padding(
                    padding: EdgeInsets.all(cardWidth * 0.05),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Top section - Username
                        Padding(
                          padding: EdgeInsets.only(top: cardWidth * 0.05),
                          child: Text(
                            username.toUpperCase(),
                            style: const TextStyle(
                              color: DiscordColors.white,
                              fontSize: 22, // Reduced font size
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.5, // Slightly reduced letter spacing
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        
                        // Middle section - Rank icon
                        SizedBox(
                          height: cardWidth * 0.4,
                          child: _buildRankEmblem(rank, rankColor, cardWidth * 0.2),
                        ),
                                                
                        // Bottom section - Rank name
                        Column(
                          children: [
                            Text(
                              rank.toUpperCase(),
                              style: const TextStyle(
                                color: DiscordColors.white,
                                fontSize: 22, // Reduced font size
                                fontWeight: FontWeight.w700,
                                letterSpacing: 2, // Slightly reduced letter spacing
                              ),
                              textAlign: TextAlign.center,
                            ),
                            
                            // Game name at bottom like "VALORANT" in the reference image
                            Padding(
                              padding: EdgeInsets.only(top: 10, bottom: cardWidth * 0.05),
                              child: Text(
                                gameName.toUpperCase(),
                                style: TextStyle(
                                  color: rankColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.5,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
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

  Widget _buildCardBackground(double width, double height, Color borderColor) {
    return Center(
      child: CustomPaint(
        size: Size(width, height),
        painter: ValorantCardPainter(borderColor),
      ),
    );
  }

  Widget _buildRankEmblem(String rank, Color rankColor, double size) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Octagonal container with diamond inside
          Container(
            width: size * 2,
            height: size * 2,
            decoration: BoxDecoration(
              color: DiscordColors.darkGrey,
              borderRadius: BorderRadius.circular(size * 0.3),
            ),
            child: Center(
              child: CustomPaint(
                size: Size(size * 1.2, size * 1.2),
                painter: DiamondPainter(rankColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ValorantCardPainter extends CustomPainter {
  final Color borderColor;
  
  ValorantCardPainter(this.borderColor);
  
  @override
  void paint(Canvas canvas, Size size) {
    final borderWidth = size.width * 0.03; // Reduced border width from 5% to 3%
    
    // Create a rounded rectangle path with clipped corners (octagonal shape)
    final path = _createOctagonalPath(size, borderWidth * 1.5);
    
    // Draw shadow
    canvas.drawShadow(path, Colors.black.withOpacity(0.5), 10, true);
    
    // Draw background
    final backgroundPaint = Paint()
      ..color = DiscordColors.charcoalGrey
      ..style = PaintingStyle.fill;
    
    canvas.drawPath(path, backgroundPaint);
    
    // Draw border
    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;
    
    canvas.drawPath(path, borderPaint);
    
    // Draw inner accent line
    final innerPath = _createOctagonalPath(
      Size(size.width - borderWidth * 2, size.height - borderWidth * 2),
      borderWidth,
      offset: Offset(borderWidth, borderWidth)
    );
    
    final innerBorderPaint = Paint()
      ..color = DiscordColors.darkGrey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    
    canvas.drawPath(innerPath, innerBorderPaint);
  }
  
  Path _createOctagonalPath(Size size, double cornerCut, {Offset offset = Offset.zero}) {
    final path = Path();
    
    // Define points for an octagonal shape (clipped corners rectangle)
    path.moveTo(offset.dx + cornerCut, offset.dy);
    path.lineTo(offset.dx + size.width - cornerCut, offset.dy);
    path.lineTo(offset.dx + size.width, offset.dy + cornerCut);
    path.lineTo(offset.dx + size.width, offset.dy + size.height - cornerCut);
    path.lineTo(offset.dx + size.width - cornerCut, offset.dy + size.height);
    path.lineTo(offset.dx + cornerCut, offset.dy + size.height);
    path.lineTo(offset.dx, offset.dy + size.height - cornerCut);
    path.lineTo(offset.dx, offset.dy + cornerCut);
    path.close();
    
    return path;
  }

  @override
  bool shouldRepaint(ValorantCardPainter oldDelegate) => 
    oldDelegate.borderColor != borderColor;
}

class DiamondPainter extends CustomPainter {
  final Color baseColor;
  
  DiamondPainter(this.baseColor);
  
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final diamondSize = size.width * 0.9;
    
    // Draw a more detailed diamond like in the Valorant rank icon
    _drawValorantDiamond(canvas, center, diamondSize, baseColor);
  }
  
  void _drawValorantDiamond(Canvas canvas, Offset center, double size, Color color) {
    // Main diamond
    final diamondPath = Path();
    
    // Diamond points
    final top = Offset(center.dx, center.dy - size / 2);
    final right = Offset(center.dx + size / 2, center.dy);
    final bottom = Offset(center.dx, center.dy + size / 2);
    final left = Offset(center.dx - size / 2, center.dy);
    
    diamondPath.moveTo(top.dx, top.dy);
    diamondPath.lineTo(right.dx, right.dy);
    diamondPath.lineTo(bottom.dx, bottom.dy);
    diamondPath.lineTo(left.dx, left.dy);
    diamondPath.close();
    
    // Paint with linear gradient for 3D effect
    final gradientPaint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(center.dx - size / 4, center.dy - size / 4),
        Offset(center.dx + size / 4, center.dy + size / 4),
        [
          color.withOpacity(0.8),
          color,
          color.withOpacity(0.6),
        ],
        [0.0, 0.5, 1.0]
      );
    
    canvas.drawPath(diamondPath, gradientPaint);
    
    // Inner diamond
    final innerSize = size * 0.5;
    final innerDiamondPath = Path();
    
    // Inner diamond points
    final innerTop = Offset(center.dx, center.dy - innerSize / 2);
    final innerRight = Offset(center.dx + innerSize / 2, center.dy);
    final innerBottom = Offset(center.dx, center.dy + innerSize / 2);
    final innerLeft = Offset(center.dx - innerSize / 2, center.dy);
    
    innerDiamondPath.moveTo(innerTop.dx, innerTop.dy);
    innerDiamondPath.lineTo(innerRight.dx, innerRight.dy);
    innerDiamondPath.lineTo(innerBottom.dx, innerBottom.dy);
    innerDiamondPath.lineTo(innerLeft.dx, innerLeft.dy);
    innerDiamondPath.close();
    
    // Paint with lighter color
    final innerPaint = Paint()
      ..color = color.withOpacity(0.5)
      ..style = PaintingStyle.fill;
    
    canvas.drawPath(innerDiamondPath, innerPaint);
    
    // Add highlight reflection
    final highlightPath = Path();
    final highlightSize = size * 0.3;
    
    // Creating a smaller diamond for the highlight
    final hTop = Offset(center.dx, center.dy - highlightSize / 2);
    final hRight = Offset(center.dx + highlightSize / 2, center.dy);
    
    highlightPath.moveTo(hTop.dx, hTop.dy);
    highlightPath.lineTo(hRight.dx, hRight.dy);
    highlightPath.lineTo(center.dx, center.dy);
    highlightPath.close();
    
    // Light reflection
    final highlightPaint = Paint()
      ..color = Colors.white.withOpacity(0.7)
      ..style = PaintingStyle.fill;
    
    canvas.drawPath(highlightPath, highlightPaint);
  }
  
  @override
  bool shouldRepaint(DiamondPainter oldDelegate) => 
    oldDelegate.baseColor != baseColor;
}