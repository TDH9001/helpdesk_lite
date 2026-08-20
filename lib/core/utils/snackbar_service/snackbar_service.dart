// import 'package:flutter/material.dart';
// import 'package:mvvvm_template_with_basic_services/core/utils/app%20fonts/app_fonts.dart';
// import 'package:mvvvm_template_with_basic_services/core/utils/app_theme/app_theme_colors.dart';

// class SnackBarService {
//   SnackBarService._();

//   static void showInfo(BuildContext context, String message) {
//     final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

//     ScaffoldMessenger.of(context).clearSnackBars();
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Row(
//           children: [
//             const SizedBox(width: 12),
//             Expanded(
//               child: Text(
//                 message,
//                 style: AppFonts().mobileCoreSnackBarCairo14Medium(
//                   context,
//                   color: widgetColors.onSurface,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         backgroundColor: widgetColors.surfaceContainerHigh,
//         behavior: SnackBarBehavior.floating,
//         margin: const EdgeInsets.all(16),
//         elevation: 4,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(4),
//           side: BorderSide(
//             color: widgetColors.outlineVariant.withValues(alpha: 0.3),
//             width: 1,
//           ),
//         ),
//       ),
//     );
//   }

//   static void showError(BuildContext context, String errorMessage) {
//     final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

//     ScaffoldMessenger.of(context).clearSnackBars();
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Row(
//           children: [
//             Icon(Icons.error_outline, color: widgetColors.error, size: 20),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Text(
//                 errorMessage,
//                 style: AppFonts().mobileCoreSnackBarCairo14Medium(
//                   context,
//                   color: widgetColors.onSurface,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         backgroundColor: widgetColors.surfaceContainerHigh,
//         behavior: SnackBarBehavior.floating,
//         margin: const EdgeInsets.all(16),
//         elevation: 4,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(4),
//           side: BorderSide(
//             color: widgetColors.error.withValues(alpha: 0.3),
//             width: 1,
//           ),
//         ),
//       ),
//     );
//   }
// }
