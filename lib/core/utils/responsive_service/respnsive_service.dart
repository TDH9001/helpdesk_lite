import 'package:flutter/material.dart';
import 'package:mvvvm_template_with_basic_services/core/utils/responsive_service/breakpoints.dart';

enum DeviceTypes { mobile, tablet, desktop }

class ResponsiveService extends StatelessWidget {
  final WidgetBuilder mobile;
  final WidgetBuilder? tablet;
  final WidgetBuilder? desktop;

  const ResponsiveService({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  static DeviceTypes getDeviceType(double deviceWidth) {
    if (deviceWidth < Breakpoints.mobile) {
      return DeviceTypes.mobile;
    } else if (deviceWidth < Breakpoints.tablet) {
      return DeviceTypes.tablet;
    } else {
      return DeviceTypes.desktop;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final type = getDeviceType(constraints.maxWidth);
        switch (type) {
          case DeviceTypes.mobile:
            return mobile(context);
          case DeviceTypes.tablet:
            return tablet?.call(context) ?? mobile(context);

          case DeviceTypes.desktop:
            return desktop?.call(context) ??
                tablet?.call(context) ??
                mobile(context);
        }
      },
    );
  }
}
