import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tugasakhir_sanbercode/Screen/edit_profile.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _name = 'Niko Fernanda';
  String _phone = '081237902245';
  String _address = 'Boyolali, Jawa Tengah';
  String _email = 'nikofernanda4@gmail.com';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage('assets/foto.png'),
              ),
              const SizedBox(height: 20),
              itemProfile('Nama', _name, CupertinoIcons.person),
              const SizedBox(height: 10),
              itemProfile('Telepon', _phone, CupertinoIcons.phone),
              const SizedBox(height: 10),
              itemProfile('Alamat', _address, CupertinoIcons.location),
              const SizedBox(height: 10),
              itemProfile('Email', _email, CupertinoIcons.mail),
              const SizedBox(height: 20,),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () async {
                      final updatedData = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditableProfilePage(
                          name: _name,
                          phone: _phone,
                          address: _address,
                          email: _email,
                        )),
                      );

                      if (updatedData != null) {
                        setState(() {
                          _name = updatedData['name'];
                          _phone = updatedData['phone'];
                          _address = updatedData['address'];
                          _email = updatedData['email'];
                        });
                      }
                    },
                child: const Text('Edit Profile'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget itemProfile(String title, String subtitle, IconData iconData) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 5),
                color: Colors.deepOrange.withOpacity(.2),
                spreadRadius: 2,
                blurRadius: 10
            )
          ]
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(iconData),
        tileColor: Colors.white,
      ),
    );
  }
}
