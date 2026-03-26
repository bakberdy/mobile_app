// import 'package:flutter/material.dart';
// // import 'package:toastification/toastification.dart';

// enum ToastType {
//   success,
//   error,
//   info,
//   warning,
// }

// class ToastHelper {
//   static void showToast({
//     required BuildContext context,
//     required String message,
//     required ToastType type,
//     String? title,
//     Duration? duration,
//     ToastificationAnimationBuilder? animationBuilder,
//   }) {
//     final toastType = switch (type) {
//       ToastType.success => ToastificationType.success,
//       ToastType.error => ToastificationType.error,
//       ToastType.info => ToastificationType.info,
//       ToastType.warning => ToastificationType.warning,
//     };

//     final icon = switch (type) {
//       ToastType.success => Icons.check_circle,
//       ToastType.error => Icons.error,
//       ToastType.info => Icons.info,
//       ToastType.warning => Icons.warning_amber_rounded,
//     };

//     toastification.show(
//       context: context,
//       type: toastType,
//       style: ToastificationStyle.flatColored,
//       title: title != null ? Text(title) : null,
//       description: Text(message),
//       alignment: Alignment.topCenter,
//       autoCloseDuration: duration ?? const Duration(seconds: 4),
//       icon: Icon(icon, color: type == ToastType.error ? Colors.red: null,),
//       closeOnClick: true,
//       pauseOnHover: true,
//       dragToClose: true,
//       foregroundColor: type == ToastType.error ? Colors.red: null,
//       animationBuilder: animationBuilder,
//     );
//   }

//   static void success({
//     required BuildContext context,
//     required String message,
//     String? title,
//     Duration? duration,
//   }) {
//     showToast(
//       context: context,
//       message: message,
//       type: ToastType.success,
//       title: title,
//       duration: duration,
//     );
//   }

//   static void error({
//     required BuildContext context,
//     required String message,
//     String? title,
//     Duration? duration,
//   }) {
//     showToast(
//       context: context,
//       message: message,
//       type: ToastType.error,
//       title: title,
//       duration: duration,
//     );
//   }

//   static void info({
//     required BuildContext context,
//     required String message,
//     String? title,
//     Duration? duration,
//   }) {
//     showToast(
//       context: context,
//       message: message,
//       type: ToastType.info,
//       title: title,
//       duration: duration,
//     );
//   }

//   static void warning({
//     required BuildContext context,
//     required String message,
//     String? title,
//     Duration? duration,
//   }) {
//     showToast(
//       context: context,
//       message: message,
//       type: ToastType.warning,
//       title: title,
//       duration: duration,
//     );
//   }
// }
