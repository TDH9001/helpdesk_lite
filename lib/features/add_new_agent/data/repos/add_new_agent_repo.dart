import 'package:flutter/widgets.dart';
import 'package:helpdesk_lite/features/add_new_agent/data/model/add_new_agent_static_model.dart';

/// Abstract contract repository for the Add New Agent feature.
abstract class AddNewAgentRepo {
  Future<AddNewAgentStaticModel> getAddNewAgentData(BuildContext context);
}
