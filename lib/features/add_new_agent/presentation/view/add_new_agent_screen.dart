import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpdesk_lite/core/utils/responsive_service/respnsive_service.dart';
import 'package:helpdesk_lite/features/add_new_agent/data/repos/implementations/static_add_new_agent_repo.dart';
import 'package:helpdesk_lite/features/add_new_agent/presentation/view/layouts/add_new_agent_desktop.dart';
import 'package:helpdesk_lite/features/add_new_agent/presentation/view/layouts/add_new_agent_mobile.dart';
import 'package:helpdesk_lite/features/add_new_agent/presentation/view_model/add_new_agent_cubit.dart';

/// Screen entry point for Add New Agent, wiring Cubit state management and responsive layouts.
class AddNewAgentScreen extends StatelessWidget {
  final VoidCallback? onCancel;
  final VoidCallback? onSuccess;

  const AddNewAgentScreen({
    super.key,
    this.onCancel,
    this.onSuccess,
  });

  @override
  Widget build(BuildContext context) {
    final staticData = StaticAddNewAgentRepository.getStaticData(context);

    return BlocProvider(
      create: (_) => AddNewAgentCubit(),
      child: ResponsiveService(
        mobile: (context) => AddNewAgentMobile(
          staticData: staticData,
          onCancel: onCancel,
          onSuccess: onSuccess,
        ),
        desktop: (context) => AddNewAgentDesktop(
          staticData: staticData,
          onCancel: onCancel,
          onSuccess: onSuccess,
        ),
      ),
    );
  }
}
