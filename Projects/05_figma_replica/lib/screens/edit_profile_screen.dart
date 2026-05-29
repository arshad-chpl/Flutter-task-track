// import 'package:flutter/material.dart';

// import '../models/editable_profile.dart';
// import '../services/local_storage_service.dart';

// class EditProfileScreen extends StatefulWidget {
//   const EditProfileScreen({super.key});

//   @override
//   State<EditProfileScreen> createState() => _EditProfileScreenState();
// }

// class _EditProfileScreenState extends State<EditProfileScreen> {
//   final _formKey = GlobalKey<FormState>();

//   final LocalStorageService _storageService = LocalStorageService();

//   TextEditingController? firstNameController;
//   TextEditingController? lastNameController;
//   TextEditingController? userNameController;
//   TextEditingController? emailController;
//   TextEditingController? phoneController;

//   @override
//   void dispose() {
//     firstNameController?.dispose();
//     lastNameController?.dispose();
//     userNameController?.dispose();
//     emailController?.dispose();
//     phoneController?.dispose();
//     super.dispose();
//   }

//   Future<void> saveProfile() async {
//     if (!_formKey.currentState!.validate()) {
//       return;
//     }

//     final updatedProfile = EditableProfile(
//       firstName: firstNameController!.text.trim(),
//       lastName: lastNameController!.text.trim(),
//       userName: userNameController!.text.trim(),
//       email: emailController!.text.trim(),
//       phone: phoneController!.text.trim(),
//     );

//     await _storageService.saveEditedProfile(updatedProfile);

//     if (!mounted) return;

//     Navigator.pop(context, true);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final profile =
//         ModalRoute.of(context)!.settings.arguments as EditableProfile;

//     firstNameController ??= TextEditingController(text: profile.firstName);

//     lastNameController ??= TextEditingController(text: profile.lastName);

//     userNameController ??= TextEditingController(text: profile.userName);

//     emailController ??= TextEditingController(text: profile.email);

//     phoneController ??= TextEditingController(text: profile.phone);

//     return Scaffold(
//       appBar: AppBar(title: const Text('Edit Profile')),

//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),

//         child: Form(
//           key: _formKey,

//           child: Column(
//             children: [
//               TextFormField(
//                 controller: firstNameController,

//                 decoration: const InputDecoration(labelText: 'First Name'),

//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Enter first name';
//                   }

//                   return null;
//                 },
//               ),

//               const SizedBox(height: 20),

//               TextFormField(
//                 controller: lastNameController,

//                 decoration: const InputDecoration(labelText: 'Last Name'),

//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Enter last name';
//                   }

//                   return null;
//                 },
//               ),
//               const SizedBox(height:20),

//               TextFormField(
//                 controller: userNameController,

//                 decoration: const InputDecoration(labelText: 'Username'),

//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Enter last name';
//                   }

//                   return null;
//                 },
//               ),

//               const SizedBox(height: 20),

//               TextFormField(
//                 controller: emailController,

//                 decoration: const InputDecoration(labelText: 'Email'),

//                 keyboardType: TextInputType.emailAddress,

//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Enter email';
//                   }

//                   final emailRegex = RegExp(
//                     r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
//                   );

//                   if (!emailRegex.hasMatch(value)) {
//                     return 'Enter valid email';
//                   }

//                   return null;
//                 },
//               ),

//               const SizedBox(height: 20),

//               TextFormField(
//                 controller: phoneController,

//                 decoration: const InputDecoration(labelText: 'Phone'),

//                 keyboardType: TextInputType.phone,

//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Enter phone number';
//                   }

//                   if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
//                     return 'Phone must be 10 digits';
//                   }

//                   return null;
//                 },
//               ),

//               const SizedBox(height: 30),

//               SizedBox(
//                 width: double.infinity,

//                 child: ElevatedButton(
//                   onPressed: saveProfile,

//                   child: const Text('Save Profile'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }