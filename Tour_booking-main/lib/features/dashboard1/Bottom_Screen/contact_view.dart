import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking/features/auth/domain/entity/contact_entity.dart';
import 'package:hotel_booking/features/dashboard1/Bottom_Screen/view_model/contact_bloc_view.dart';
import 'package:hotel_booking/features/dashboard1/Bottom_Screen/view_model/contact_event.dart';
import 'package:hotel_booking/features/dashboard1/Bottom_Screen/view_model/contact_state.dart';

class ContactView extends StatefulWidget {
  const ContactView({super.key});

  @override
  _ContactViewState createState() => _ContactViewState();
}

class _ContactViewState extends State<ContactView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  void _clearFields() {
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        title: const Text(
          'Contact Us',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Contact Form Section (Now on Top)
              BlocConsumer<ContactBlocView, ContactState>(
                listener: (context, state) {
                  if (state is ContactSuccessState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Message sent successfully!"),
                        backgroundColor: Colors.green,
                      ),
                    );
                    _clearFields();
                  } else if (state is ContactErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return _buildContactForm(state);
                },
              ),
              const SizedBox(height: 20),
              // Company Information Section (Now on Bottom)
              _buildCompanyInfo(),
            ],
          ),
        ),
      ),
    );
  }

  /// **Company Information Widget**
  Widget _buildCompanyInfo() {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text(
              "Ghumantey",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              "We offer the finest hotels for your stays, business trips, and vacations. Book with us for a comfortable, luxurious, and hassle-free experience.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const SizedBox(height: 12),
            const Divider(),
            _buildContactDetail(Icons.email, "info@Ghumantey.com"),
            _buildContactDetail(Icons.location_on, "Kathmandu, Nepal"),
            _buildContactDetail(Icons.phone, "+977 9823456710"),
          ],
        ),
      ),
    );
  }

  /// **Contact Detail Row Widget with Blue Icons**
  Widget _buildContactDetail(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 12),
          Text(text, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  /// **Contact Form Widget**
  Widget _buildContactForm(ContactState state) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text(
                "Send Us a Message",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildTextField("Full Name", nameController, Icons.person),
              _buildTextField("Email", emailController, Icons.email),
              _buildTextField("Phone", phoneController, Icons.phone),
              _buildTextField("Your Message", messageController, Icons.message,
                  maxLines: 4),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 30),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final contact = ContactEntity(
                      name: nameController.text,
                      email: emailController.text,
                      phone: phoneController.text,
                      message: messageController.text,
                      id: '',
                    );
                    context
                        .read<ContactBlocView>()
                        .add(SubmitContactEvent(contact));
                  }
                },
                child: state is ContactLoadingState
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        "Submit",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// **Reusable TextField Widget with Blue Icons**
  Widget _buildTextField(
      String label, TextEditingController controller, IconData icon,
      {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        validator: (value) =>
            value == null || value.isEmpty ? "$label is required" : null,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey.shade100,
          prefixIcon: Icon(icon, color: Colors.blue),
          labelText: label,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
