import 'package:flutter/material.dart';
import 'package:mvvvm_template_with_basic_services/core/utils/responsive_service/respnsive_service.dart';
import 'package:mvvvm_template_with_basic_services/features/customer_authentication/data/repos/customer_authentication_repo.dart';
import 'package:mvvvm_template_with_basic_services/features/customer_authentication/presentation/view/layouts/customer_authentication_desktop.dart';
import 'package:mvvvm_template_with_basic_services/features/customer_authentication/presentation/view/layouts/customer_authentication_mobile.dart';

class CustomerAuthenticationScreen extends StatelessWidget {
  const CustomerAuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final staticData =
        StaticCustomerAuthenticationRepository.getStaticData(context);

    return ResponsiveService(
      mobile: (context) => CustomerAuthenticationMobile(
        staticData: staticData,
      ),
      desktop: (context) => CustomerAuthenticationDesktop(
        staticData: staticData,
      ),
    );
  }
}
