import 'package:sqa/utils/routing_data.dart';

extension StringExtension on String {
  RoutingData get getRoutingData {
    Uri uriData = Uri.parse(this);
    return RoutingData(
      queryParameters: uriData.queryParameters,
      route: uriData.path,
    );
  }
}
