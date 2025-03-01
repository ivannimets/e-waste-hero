import 'package:ewastehero/screens/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NotificationsScreen extends StatefulWidget {
  final int userId;

  NotificationsScreen({required this.userId});

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final SupabaseClient supabase = Supabase.instance.client;
  List<Map<String, dynamic>> notifications = [];

  @override
  void initState() {
    super.initState();
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    final response = await supabase
        .from('notification')
        .select()
        .eq('receiver_id', widget.userId);

    if (response.isNotEmpty) {
      setState(() {
        notifications = List<Map<String, dynamic>>.from(response);
      });
    }
  }

  Future<void> acceptNotification(int id, int binId) async {
    await supabase.from('notification').delete().eq('notification_id', id);
    await supabase.from('joining_bin_user').insert({'user_id': widget.userId, 'bin_id': binId});
    WidgetsBinding.instance.addPostFrameCallback((_) => fetchNotifications());
    WidgetsBinding.instance.addPostFrameCallback((_) => {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NotificationsScreen(userId: widget.userId),
        ),
      ),
    });
  }

  Future<void> denyNotification(int id) async {
    await supabase.from('notification').delete().eq('notification_id', id);
    WidgetsBinding.instance.addPostFrameCallback((_) => fetchNotifications());
    WidgetsBinding.instance.addPostFrameCallback((_) => {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NotificationsScreen(userId: widget.userId),
        ),
      ),
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
                      title: Text("You have been invited to join ${notification['bin_name']}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.check, color: Colors.green),
                            onPressed: () => acceptNotification(notification['notification_id'], notification['bin_id']),
                          ),
                          IconButton(
                            icon: Icon(Icons.close, color: Colors.red),
                            onPressed: () => denyNotification(notification['notification_id']),
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
