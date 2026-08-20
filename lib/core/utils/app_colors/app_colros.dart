import 'dart:ui';

abstract class AppColors {
  Color get main;
  Color get background;
  Color get onBackground;

  // Primary
  Color get primary;
  Color get onPrimary;
  Color get primaryContainer;
  Color get onPrimaryContainer;
  Color get inversePrimary;
  Color get primaryFixed;
  Color get primaryFixedDim;
  Color get onPrimaryFixed;
  Color get onPrimaryFixedVariant;

  // Secondary
  Color get secondary;
  Color get onSecondary;
  Color get secondaryContainer;
  Color get onSecondaryContainer;
  Color get secondaryFixed;
  Color get secondaryFixedDim;
  Color get onSecondaryFixed;
  Color get onSecondaryFixedVariant;

  // Tertiary
  Color get tertiary;
  Color get onTertiary;
  Color get tertiaryContainer;
  Color get onTertiaryContainer;
  Color get tertiaryFixed;
  Color get tertiaryFixedDim;
  Color get onTertiaryFixed;
  Color get onTertiaryFixedVariant;

  // Error
  Color get error;
  Color get onError;
  Color get errorContainer;
  Color get onErrorContainer;

  // Surface
  Color get surface;
  Color get onSurface;
  Color get surfaceVariant;
  Color get onSurfaceVariant;
  Color get surfaceDim;
  Color get surfaceBright;
  Color get surfaceContainerLowest;
  Color get surfaceContainerLow;
  Color get surfaceContainer;
  Color get surfaceContainerHigh;
  Color get surfaceContainerHighest;
  Color get inverseSurface;
  Color get inverseOnSurface;

  // Outline & Tint
  Color get outline;
  Color get outlineVariant;
  Color get surfaceTint;

  // Layout & Semantic
  Color get border;
  Color get textPrimary;
  Color get textSecondary;

  // Status Colors
  Color get statusOpen;
  Color get statusPending;
  Color get statusWaiting;
  Color get statusDelayed;
  Color get statusResolved;
  Color get statusClosed;
}
