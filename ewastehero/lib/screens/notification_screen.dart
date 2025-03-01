import 'package:ewastehero/screens/base_screen.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  final int userId;

  NotificationsScreen({required this.userId});
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  // Sample list of notifications (Replace this with your query results)
  List<Map<String, dynamic>> notifications = [
    {'id': 1, 'message': 'John sent you a friend request.'},
    {'id': 2, 'message': 'Your recycling request has been approved!'},
    {'id': 3, 'message': 'You won 50 points in the weekly raffle!'},
  ];

  void acceptNotification(int id) {
    // Handle accept action (e.g., API call or DB update)
    setState(() {
      notifications.removeWhere((notification) => notification['id'] == id);
    });
  }

  void denyNotification(int id) {
    // Handle deny action (e.g., API call or DB update)
    setState(() {
      notifications.removeWhere((notification) => notification['id'] == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      userId: widget.userId,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Notifications',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: notifications.isEmpty
                  ? Center(
                child: Text(
                  'No notifications at the moment.',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              )
                  : ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final notification = notifications[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(notification['message']),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.check, color: Colors.green),
                            onPressed: () => acceptNotification(notification['id']),
                          ),
                          IconButton(
                            icon: Icon(Icons.close, color: Colors.red),
                            onPressed: () => denyNotification(notification['id']),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}