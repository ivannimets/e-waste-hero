import 'package:flutter/material.dart';
import 'package:ewastehero/screens/base_screen.dart'; // Import BaseScreen

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Define some dummy data for now
    int userLevel = 5;
    double progress = 0.7; // 70% progress
    int userPoints = 120;
    int userRecyclingAchievements = 15;
    String profileImage = 'https://i.imgur.com/71QkHNF.png'; // Temporary image URL

    return BaseScreen(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Personalized Greeting
            Text(
              'Welcome back, Ethan!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 20),

            // Profile Image with Circular Progress Indicator
            Stack(
              alignment: Alignment.center,
              children: [
                // Circular Progress Bar (fixed version)
                Container(
                  height: 160,
                  width: 160,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.green, width: 4),
                  ),
                  child: CustomPaint(
                    painter: CircularProgressPainter(progress),
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.green, width: 4),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipOval(
                            child: Image.network(
                              profileImage,
                              height: 140,
                              width: 140,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            // Level Display
            Text(
              'Level: $userLevel',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 30),

            // Points and Rewards Section with Icons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Points Section with Icon
                Column(
                  children: [
                    Icon(Icons.monetization_on, color: Colors.green, size: 40),
                    SizedBox(height: 8),
                    Text(
                      'Points: $userPoints',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 40),

                // Achievements Section with Icon
                Column(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 40),
                    SizedBox(height: 8),
                    Text(
                      'Achievements: $userRecyclingAchievements',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 30),

            // Enlarged "Start Recycling" Button
            ElevatedButton(
              onPressed: () {
                // Add action for button (e.g., navigate to another screen)
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Button background color
                foregroundColor: Colors.white, // Button text color
                padding: EdgeInsets.symmetric(vertical: 18, horizontal: 40), // Enlarged padding
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // Rounded corners
                ),
                elevation: 5, // Shadow effect
              ),
              child: Text(
                'Start Recycling',
                style: TextStyle(fontSize: 20), // Increased text size
              ),
            ),
            SizedBox(height: 30),

            // E-Waste Impact Information
            Text(
              'Did you know? Recycling 1 phone saves 1,000 pounds of CO2!',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.green[800],
              ),
            ),
            SizedBox(height: 20),

            // Map or Nearby Locations
            Container(
              height: 150,
              width: double.infinity,
              color: Colors.green[100],
              child: Center(
                child: Text(
                  'Find Nearby Recycling Locations',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Leaderboard / Challenges Section
            Container(
              color: Colors.green[50],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Leaderboard',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[700],
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'You are ranked #3 in your community!',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Challenges: Recycle 10 items this week to earn extra points!',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.green[800],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// CustomPainter to create circular progress indicator starting from the bottom and going clockwise
class CircularProgressPainter extends CustomPainter {
  final double progress;

  CircularProgressPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;

    // Draw background circle (gray)
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), size.width / 2, paint..color = Colors.grey[300]!);

    // Draw progress circle (green), starting from the bottom
    double startAngle = -3.14159 / 2; // Start from the bottom
    double sweepAngle = 2 * 3.14159 * progress;

    paint.color = Colors.green;
    canvas.drawArc(
      Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: size.width / 2),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
