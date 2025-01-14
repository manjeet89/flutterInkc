// version_checker.dart

import 'package:dio/dio.dart';

class VersionChecker {
  static Future<String?> getAndroidVersionFromGooglePlay() async {
    final Dio dio = Dio();

    // Get html containing code with application version. For example:
    // ...
    // ,[[["2.0.7-rc609"]]
    // ...
    final response = await dio
        .get('https://play.google.com/store/apps/details?id=net.inkcdogs.doggylocker');

    // Look for all ,[[[ pattern and split all matches into an array
    List<String> splitted = response.data.split(',[[["');

    // In each element, remove everything after "]] pattern
    List<String> removedLast = splitted.map((String e) {
      return e.split('"]],').first;
    }).toList();

    // We are looking for a version in the array that satisfies the regular expression:
    // starts with one or more digits (\d), followed by a period (.), followed by one or more digits.
    List<String> filteredByVersion = removedLast
        .map((String e) {
          RegExp regex = RegExp(r'^\d+\.\d+');
          if (regex.hasMatch(e)) {
            return e;
          }
        })
        .whereType<String>()
        .toList();

    if (filteredByVersion.length == 1) {
      // print(filteredByVersion.first);
      return filteredByVersion.first;
    }

    return null;
  }
}



// version_checker.dart
// import 'package:http/http.dart' as http;
// import 'package:html/parser.dart' show parse;
// import 'package:html/dom.dart';

// class VersionChecker {
//   static Future<String?> getLatestVersionFromPlayStore() async {
//     final url =
//         'https://play.google.com/store/apps/details?id=com.affcats.app&hl=en';
//     final response = await http.get(Uri.parse(url));

//     print(response.body);

//     if (response.statusCode == 200) {
//       var document = parse(response.body);
//       // Modify the selectors based on the current Play Store structure
//       Element? versionElement = document
//           .getElementsByClassName('hAyfc')
//           .firstWhereOrNull(
//               (element) => element.text.contains('Current version'));

//       if (versionElement != null) {
//         var version = versionElement.querySelector('.htlgb')?.text;
//         return version?.trim();
//       } else {
//         print('Version element not found');
//       }
//     } else {
//       print('Failed to load Play Store page');
//     }
//     return null;
//   }
// }

// // Helper extension to handle `firstWhereOrNull`
// extension FirstWhereOrNullExtension<E> on List<E> {
//   E? firstWhereOrNull(bool Function(E element) test) {
//     for (E element in this) {
//       if (test(element)) return element;
//     }
//     return null;
//   }
// }




// version_checker.dart
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:html/parser.dart' show parse;
// import 'package:html/dom.dart';

// class VersionChecker {
//   static Future<String?> getLatestVersionFromPlayStore() async {
//     final url =
//         'https://play.google.com/store/apps/details?id=com.affcats.app';
//     final response = await http.get(Uri.parse(url));

//     if (response.statusCode == 200) {
//       var document = parse(response.body);
//       print(document.outerHtml); // Print the entire HTML document

//       Element? versionElement = document
//           .getElementsByClassName('hAyfc')
//           .firstWhereOrNull(
//               (element) => element.text.contains('Current version'));

//       if (versionElement != null) {
//         var version = versionElement.querySelector('.htlgb')?.text;
//         return version?.trim();
//       } else {
//         print('Version element not found');
//       }
//     } else {
//       print('Failed to load Play Store page');
//     }
//     return null; // Return null if the version couldn't be found
//   }
// }


// // version_checker.dart
// import 'package:http/http.dart' as http;
// import 'package:html/parser.dart' show parse;
// import 'package:html/dom.dart';

// class VersionChecker {
//   static Future<String?> getLatestVersionFromPlayStore() async {
//     final url =
//         'https://play.google.com/store/apps/details?id=com.affcats.app&hl=en';
//     final response = await http.get(Uri.parse(url));

//     if (response.statusCode == 200) {
//       var document = parse(response.body);
//       // Safely get the version element, ensuring it's not null
//       Element? versionElement = document
//           .getElementsByClassName('hAyfc')
//           .firstWhereOrNull(
//               (element) => element.text.contains('Current version'));

//       // If a valid element is found, parse the version
//       if (versionElement != null) {
//         var version = versionElement.querySelector('.htlgb')?.text;
//         return version?.trim();
//       } else {
//         print('Version element not found');
//       }
//     } else {
//       print('Failed to load Play Store page');
//     }
//     return null; // Return null if the version couldn't be found
//   }
// }

// // Helper extension to handle `firstWhereOrNull`
// extension FirstWhereOrNullExtension<E> on List<E> {
//   E? firstWhereOrNull(bool Function(E element) test) {
//     for (E element in this) {
//       if (test(element)) return element;
//     }
//     return null;
//   }
// }
