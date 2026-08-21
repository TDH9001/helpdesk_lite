import 'package:flutter/widgets.dart';
import 'package:helpdesk_lite/features/overview/data/model/overview_agent_item_model.dart';
import 'package:helpdesk_lite/features/overview/data/model/overview_static_model.dart';

/// Abstract contract repository for the Overview feature.
abstract class OverviewRepo {
  Future<OverviewStaticModel> getOverviewData(BuildContext context);

  Future<List<OverviewAgentItemModel>> getAgentsOverview();
}
