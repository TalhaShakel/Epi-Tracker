// import 'package:flutter/material.dart';
// class Approutes {
//   static const String AddMedication = "Add_medication";
//   static const String AddSeizures = "Add_seizures";
//   static const String viewEvent = "view_event";
//
//   static Route<dynamic> onGenerateRoute(RouteSettings settings) {
//     return MaterialPageRoute(
//         settings: settings,
//         builder: (_) {
//           switch (settings.name) {
//             case editEvent:
//               return AddEventPage(event: settings.arguments);
//             case viewEvent:
//               return EventDetails(event: settings.arguments);
//             case addEvent:
//               return AddEventPage(
//                 selectedDate: settings.arguments,
//               );
//           }
//         });
//   }
// }