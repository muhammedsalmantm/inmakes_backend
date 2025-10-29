import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../login/login.dart';
import '../model/user_model.dart';
import 'update_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? userId;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('id');
    setState(() => loading = false);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
  }

  Future<void> deleteUser(String id) async {
    await FirebaseFirestore.instance.collection("details").doc(id).delete();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("User deleted successfully")),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page",style: TextStyle(
          color: Colors.white
        ),),
        backgroundColor: Colors.green.shade900,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout,color: Colors.white,),
            onPressed: logout,
          ),
        ],
      ),
      body:

      Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.green.shade900,
              Colors.green.shade800,
              Colors.white,
              Colors.white.withOpacity(0.5),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: loading
            ? const Center(child: CircularProgressIndicator())
            : StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("details")
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            var data = snapshot.data!.docs;

            if (data.isEmpty) {
              return const Center(child: Text("No users found"));
            }

            return ListView.separated(
              itemCount: data.length,
              itemBuilder: (context, index) {

                var item = data[index];

                final user = UserModel(
                  id: item.id,
                  reference: item.reference,
                  name: item['name'] ?? '',
                  email: item['email'] ?? '',
                  password: item.data().toString().contains('password')
                      ? item['password']
                      : '',
                  createAt: item.data().toString().contains('createAt')
                      ? (item['createAt'] as Timestamp).toDate()
                      : DateTime.now(),
                );

                return Card(
                  margin:  EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 5,
                  child: ListTile(
                    title: Text(
                      user.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    subtitle: Text(user.email),
                    trailing: Wrap(
                      spacing: 10,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit,
                              color: Colors.blueAccent),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => UpdatePage(user: user),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete,
                              color: Colors.redAccent),
                          onPressed: () => deleteUser(user.id),
                        ),
                      ],
                    ),
                  ),
                );
              }, separatorBuilder: (BuildContext context, int index) {
                return SizedBox(width: width*0.04,);
            },
            );
          },
        ),
      ),
    );
  }
}
