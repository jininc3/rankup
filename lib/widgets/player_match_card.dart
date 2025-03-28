import 'package:flutter/material.dart';

class PlayerMatchCard extends StatefulWidget {
  final Map<String, dynamic> cardData;
  final VoidCallback onSwipeLeft;
  final VoidCallback onSwipeRight;

  const PlayerMatchCard({
    Key? key,
    required this.cardData,
    required this.onSwipeLeft,
    required this.onSwipeRight,
  }) : super(key: key);

  @override
  State<PlayerMatchCard> createState() => _PlayerMatchCardState();
}

class _PlayerMatchCardState extends State<PlayerMatchCard> {
  double _dragOffset = 0;
  bool _isDragging = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 0.85;
    final cardHeight = cardWidth * 1.3;
    
    // Determine game color theme
    Color gameColor = _getGameColor(widget.cardData['game']);
    
    return GestureDetector(
      onHorizontalDragStart: (details) {
        setState(() {
          _isDragging = true;
        });
      },
      onHorizontalDragUpdate: (details) {
        setState(() {
          _dragOffset += details.delta.dx;
        });
      },
      onHorizontalDragEnd: (details) {
        setState(() {
          if (_dragOffset.abs() > 100) {
            if (_dragOffset > 0) {
              widget.onSwipeRight();
            } else {
              widget.onSwipeLeft();
            }
          }
          _dragOffset = 0;
          _isDragging = false;
        });
      },
      child: Transform.rotate(
        angle: _isDragging ? _dragOffset * 0.001 : 0,
        child: Container(
          width: cardWidth,
          height: cardHeight,
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: gameColor.withOpacity(0.3),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Stack(
              children: [
                // Card background
                Container(
                  decoration: BoxDecoration(
                    color: gameColor,
                  ),
                ),
                
                // Geometric pattern overlay
                _buildGeometricPattern(gameColor),
                
                // Game info and player details
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: cardHeight * 0.25,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.75),
                      border: Border(
                        top: BorderSide(
                          color: Colors.white.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          // Player profile image
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.white.withOpacity(0.2),
                            backgroundImage: NetworkImage(widget.cardData['profileImage']),
                          ),
                          const SizedBox(width: 12),
                          
                          // Player info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Username and age
                                Row(
                                  children: [
                                    _buildFlagIcon(widget.cardData['country']),
                                    const SizedBox(width: 6),
                                    Text(
                                      widget.cardData['username'],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      widget.cardData['age'],
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.7),
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                
                                const SizedBox(height: 12),
                                
                                // Main agent and rank
                                Row(
                                  children: [
                                    // Main agent section
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'MAIN AGENT',
                                            style: TextStyle(
                                              color: Colors.white.withOpacity(0.5),
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 12,
                                                backgroundColor: Colors.transparent,
                                                backgroundImage: NetworkImage(widget.cardData['agentImage']),
                                              ),
                                              const SizedBox(width: 6),
                                              Text(
                                                widget.cardData['mainAgent'],
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    
                                    // Rank section
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'RANK',
                                            style: TextStyle(
                                              color: Colors.white.withOpacity(0.5),
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Row(
                                            children: [
                                              _buildRankIcon(widget.cardData['rank']),
                                              const SizedBox(width: 6),
                                              Text(
                                                widget.cardData['rank'],
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                
                // Game logo at top
                Positioned(
                  top: 16,
                  left: 16,
                  child: _buildGameLogo(widget.cardData['game']),
                ),
                
                // Swipe indicators
                if (_isDragging)
                  Positioned(
                    top: 30,
                    right: _dragOffset > 50 ? 30 : null,
                    left: _dragOffset < -50 ? 30 : null,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: _dragOffset > 50 ? Colors.green : Colors.red,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: Text(
                        _dragOffset > 50 ? 'MATCH' : 'PASS',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildGeometricPattern(Color baseColor) {
    return Stack(
      children: [
        // Top right triangle
        Positioned(
          top: 0,
          right: 0,
          child: CustomPaint(
            size: const Size(120, 120),
            painter: TrianglePainter(
              color: baseColor.withOpacity(0.8),
              direction: 'topRight',
            ),
          ),
        ),
        
        // Bottom left corner lines
        Positioned(
          bottom: 0,
          left: 0,
          child: SizedBox(
            width: 100,
            height: 100,
            child: CustomPaint(
              painter: CornerLinesPainter(
                color: Colors.white.withOpacity(0.3),
              ),
            ),
          ),
        ),
        
        // Center geometric shape (simplified)
        Center(
          child: ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.black,
                  baseColor.withOpacity(0.7),
                ],
              ).createShader(bounds);
            },
            child: CustomPaint(
              size: const Size(200, 200),
              painter: GeometricShapePainter(
                color: Colors.white.withOpacity(0.9),
              ),
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildFlagIcon(String country) {
    // For simplicity, using a plain icon for countries
    // In a real app, you'd use country flag images
    switch (country.toUpperCase()) {
      case 'USA':
        return const Text('🇺🇸');
      case 'CANADA':
        return const Text('🇨🇦');
      case 'UK':
        return const Text('🇬🇧');
      case 'GERMANY':
        return const Text('🇩🇪');
      default:
        return const Text('🌎');
    }
  }
  
  Widget _buildRankIcon(String rank) {
    // Simplified - in a real app, you'd use game-specific rank icons
    Color rankColor;
    IconData rankIcon;
    
    if (rank.contains('IRON') || rank.contains('BRONZE')) {
      rankColor = Colors.brown;
      rankIcon = Icons.shield;
    } else if (rank.contains('SILVER')) {
      rankColor = Colors.grey.shade300;
      rankIcon = Icons.shield;
    } else if (rank.contains('GOLD')) {
      rankColor = Colors.amber;
      rankIcon = Icons.shield; 
    } else if (rank.contains('PLATINUM')) {
      rankColor = Colors.cyan;
      rankIcon = Icons.shield;
    } else if (rank.contains('DIAMOND')) {
      rankColor = Colors.lightBlue;
      rankIcon = Icons.diamond;
    } else if (rank.contains('IMMORTAL') || rank.contains('MASTER')) {
      rankColor = Colors.purple;
      rankIcon = Icons.workspace_premium;
    } else if (rank.contains('RADIANT') || rank.contains('GLOBAL')) {
      rankColor = Colors.orange;
      rankIcon = Icons.stars;
    } else {
      rankColor = Colors.grey;
      rankIcon = Icons.shield;
    }
    
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: rankColor.withOpacity(0.3),
        shape: BoxShape.circle,
      ),
      child: Icon(
        rankIcon,
        color: rankColor,
        size: 16,
      ),
    );
  }
  
  Widget _buildGameLogo(String game) {
    // In a real app, you'd use actual game logos
    Icon gameIcon;
    switch (game.toLowerCase()) {
      case 'valorant':
        gameIcon = const Icon(Icons.gps_fixed, color: Colors.white, size: 20);
        break;
      case 'league of legends':
        gameIcon = const Icon(Icons.shield, color: Colors.white, size: 20);
        break;
      case 'cs:go':
        gameIcon = const Icon(Icons.my_location, color: Colors.white, size: 20);
        break;
      default:
        gameIcon = const Icon(Icons.gamepad, color: Colors.white, size: 20);
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
      ),
      child: Row(
        children: [
          gameIcon,
          const SizedBox(width: 6),
          Text(
            game.toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
  
  Color _getGameColor(String game) {
    switch (game.toLowerCase()) {
      case 'valorant':
        return const Color(0xFF0F1923); // Dark blue
      case 'league of legends':
        return const Color(0xFF091428); // LoL blue
      case 'cs:go':
        return const Color(0xFF1E2327); // CS:GO dark
      default:
        return const Color(0xFF0A1A2A); // Default navy
    }
  }
}

// Custom painters for geometric patterns

class TrianglePainter extends CustomPainter {
  final Color color;
  final String direction;
  
  TrianglePainter({required this.color, required this.direction});
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    
    final path = Path();
    if (direction == 'topRight') {
      path.moveTo(size.width, 0);
      path.lineTo(size.width, size.height);
      path.lineTo(0, 0);
      path.close();
    }
    
    canvas.drawPath(path, paint);
  }
  
  @override
  bool shouldRepaint(TrianglePainter oldDelegate) => 
      color != oldDelegate.color || direction != oldDelegate.direction;
}

class CornerLinesPainter extends CustomPainter {
  final Color color;
  
  CornerLinesPainter({required this.color});
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
    
    // Bottom-left corner lines
    canvas.drawLine(
      Offset(0, size.height),
      Offset(size.width * 0.3, size.height),
      paint,
    );
    
    canvas.drawLine(
      Offset(0, size.height),
      Offset(0, size.height * 0.7),
      paint,
    );
  }
  
  @override
  bool shouldRepaint(CornerLinesPainter oldDelegate) => color != oldDelegate.color;
}

class GeometricShapePainter extends CustomPainter {
  final Color color;
  
  GeometricShapePainter({required this.color});
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final radius = size.width * 0.4;
    
    // This is a simplified geometric pattern
    // You would create a more complex pattern for a real app
    
    // Draw diamond
    final diamondPath = Path();
    diamondPath.moveTo(centerX, centerY - radius);
    diamondPath.lineTo(centerX + radius, centerY);
    diamondPath.lineTo(centerX, centerY + radius);
    diamondPath.lineTo(centerX - radius, centerY);
    diamondPath.close();
    canvas.drawPath(diamondPath, paint);
    
    // Draw inner lines
    canvas.drawLine(
      Offset(centerX - radius * 0.5, centerY),
      Offset(centerX + radius * 0.5, centerY),
      paint,
    );
    
    canvas.drawLine(
      Offset(centerX, centerY - radius * 0.5),
      Offset(centerX, centerY + radius * 0.5),
      paint,
    );
    
    // Draw triangle accents
    final trianglePath1 = Path();
    trianglePath1.moveTo(centerX + radius * 0.8, centerY - radius * 0.2);
    trianglePath1.lineTo(centerX + radius * 0.6, centerY - radius * 0.4);
    trianglePath1.lineTo(centerX + radius * 0.9, centerY - radius * 0.4);
    trianglePath1.close();
    canvas.drawPath(trianglePath1, paint);
    
    final trianglePath2 = Path();
    trianglePath2.moveTo(centerX - radius * 0.8, centerY + radius * 0.2);
    trianglePath2.lineTo(centerX - radius * 0.6, centerY + radius * 0.4);
    trianglePath2.lineTo(centerX - radius * 0.9, centerY + radius * 0.4);
    trianglePath2.close();
    canvas.drawPath(trianglePath2, paint);
  }
  
  @override
  bool shouldRepaint(GeometricShapePainter oldDelegate) => color != oldDelegate.color;
}
