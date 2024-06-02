import 'package:flutter/material.dart';

class EditableProfilePage extends StatefulWidget {
  final String name;
  final String phone;
  final String address;
  final String email;

  EditableProfilePage({
    required this.name,
    required this.phone,
    required this.address,
    required this.email,
  });

  @override
  _EditableProfilePageState createState() => _EditableProfilePageState();
}

class _EditableProfilePageState extends State<EditableProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _phoneController = TextEditingController(text: widget.phone);
    _addressController = TextEditingController(text: widget.address);
    _emailController = TextEditingController(text: widget.email);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nama'),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Telepon'),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Alamat'),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Mengirimkan data profil yang diperbarui kembali ke halaman sebelumnya
                  Navigator.pop(context, {
                    'name': _nameController.text,
                    'phone': _phoneController.text,
                    'address': _addressController.text,
                    'email': _emailController.text,
                  });
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
