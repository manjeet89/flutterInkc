// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class RegistrationCompletePage extends StatelessWidget {
//   const RegistrationCompletePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Registration Complete"),
//         automaticallyImplyLeading: false,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Icon(
//               Icons.check_circle,
//               color: Colors.green,
//               size: 80,
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               "Registration Completed 🎉",
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 30),
//             optionButton(
//               "Become Member",
//               Icons.card_membership,
//               () {
//                 Get.to(() => const BecomeMemberPage());
//               },
//             ),
//             const SizedBox(height: 15),
//             optionButton(
//               "Register Kennel Name",
//               Icons.home_work,
//               () {
//                 Get.to(() => const KennelRegistrationPage());
//               },
//             ),
//             const SizedBox(height: 15),
//             optionButton(
//               "Sign Dog Registration",
//               Icons.pets,
//               () {
//                 Get.to(() => const DogRegistrationPage());
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget optionButton(String title, IconData icon, VoidCallback onTap) {
//     return SizedBox(
//       width: double.infinity,
//       height: 55,
//       child: ElevatedButton.icon(
//         onPressed: onTap,
//         icon: Icon(icon),
//         label: Text(title),
//       ),
//     );
//   }
// }
