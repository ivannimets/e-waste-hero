import 'package:ewastehero/entites/euser.dart';
import 'package:ewastehero/screens/bin_page.dart';
import 'package:flutter/material.dart';
import 'package:ewastehero/screens/base_screen.dart'; // Import BaseScreen
import 'package:supabase_flutter/supabase_flutter.dart'; // Import Supabase package

final supabase = Supabase.instance.client;

class HomeScreen extends StatefulWidget {
  final int userId;  // Accept userId as a parameter

  // Constructor that accepts userId
  HomeScreen({required this.userId});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<EUser> _userData; // To hold user data

  @override
  void initState() {
    super.initState();
    _userData = fetchUserData(widget.userId);  // Load user data on screen init
  }

  // Function to fetch user data from Supabase based on userId
  Future<EUser> fetchUserData(int userId) async {
    try {
      final response = await supabase
          .from('users')
          .select('username, first_name, last_name, email, experience')
          .eq('user_id', userId)
          .single();

      return EUser(
        username: response['username'],
        firstName: response['first_name'],
        lastName: response['last_name'],
        email: response['email'],
        experience: response['experience'],
      );
    } catch (e) {
      throw Exception('Error loading user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<EUser>(
      future: _userData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error loading user data: ${snapshot.error}'));
        }

        final userData = snapshot.data;

        if (userData == null) {
          return Center(child: Text('No data found for the user.'));
        }

        // Set default profile image if null
        String profileImage = 'https://i.imgur.com/71QkHNF.png'; // Temporary image URL

        return BaseScreen(
          userId: widget.userId,
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Personalized Greeting
                Text(
                  'Welcome back, ${userData.firstName}!',
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
                        painter: CircularProgressPainter(0.7),  // Use a fixed progress for now
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
                // Level Display (Experience based for now)
                Text(
                  'Level: ${userData.experience}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 30),

                // Points and Rewards Section with Icons (Dummy data for now)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Points Section with Icon
                    Column(
                      children: [
                        Icon(Icons.monetization_on, color: Colors.green, size: 40),
                        SizedBox(height: 8),
                        Text(
                          'Points: 120',  // Placeholder for actual points data
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
                          'Achievements: 15',  // Placeholder for actual achievements data
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

                // Friends Section
                Text(
                  'Friends: 16',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                SizedBox(height: 10),

                // Enlarged "Start Recycling" Button
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the BinScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BinScreen(userId: widget.userId)),
                    );
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
              ],
            ),
          ),
        );
      },
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
