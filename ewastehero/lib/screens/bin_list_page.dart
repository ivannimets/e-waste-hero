import 'package:ewastehero/entites/bin.dart';
import 'package:ewastehero/screens/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'bin_page.dart';


class BinsScreen extends StatefulWidget {
  final int userId;

  BinsScreen({required this.userId});

  @override
  BinsScreenState createState() {
    return BinsScreenState();
  }
}

class BinsScreenState extends State<BinsScreen> {
  List<Bin> binsList = [];

  @override
  void initState() {
    super.initState();
    fetchUserBins();
  }

  Future<void> fetchUserBins() async {
    final supabase = Supabase.instance.client;
    final List<dynamic> binIds = await supabase
        .from('joining_bin_user')
        .select('bin_id')
        .eq('user_id', widget.userId);

    final List<dynamic> bins = await supabase
        .from('bin')
        .select('*')
        .filter('bin_id', 'in', binIds.map((bin) => bin['bin_id']).toList());

    setState(() {
      binsList = bins.map((data) => Bin(binId: data['bin_id'], name: data['name'])).toList();
    });
  }

  Future<void> addBin(String binName) async {
    final supabase = Supabase.instance.client;
    final response = await supabase.from('bin').insert({'name': binName}).select().single();
    final binId = response['bin_id'];
    await supabase.from('joining_bin_user').insert({'user_id': widget.userId, 'bin_id': binId});
    fetchUserBins();
  }

  Future<void> removeBin(int binId) async {
    final supabase = Supabase.instance.client;
    await supabase.from('joining_bin_user').delete().eq('user_id', widget.userId).eq('bin_id', binId);
    fetchUserBins();
  }

  void _showAddBinDialog() {
    String binName = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add New Bin'),
          content: TextField(
            decoration: InputDecoration(labelText: 'Bin Name'),
            onChanged: (value) {
              binName = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (binName.isNotEmpty) {
                  addBin(binName);
                  Navigator.pop(context);
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      userId: widget.userId,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Your Bins',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: binsList.isEmpty
                  ? Center(
                child: Text(
                  'You have no bins',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                  ),
                ),
              )
                  : ListView.separated(
                itemCount: binsList.length,
                separatorBuilder: (context, index) =>
                    Divider(color: Colors.grey[300]),
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.delete_outline, color: Colors.red),
                    title: Text(
                      binsList[index].name,
                      style: TextStyle(fontSize: 18),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        removeBin(binsList[index].binId);
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BinScreen(userId: widget.userId, binId: binsList[index].binId,),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _showAddBinDialog,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Add New Bin',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
