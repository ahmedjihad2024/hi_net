import 'package:hi_net/data/request/request.dart';
import 'package:hi_net/data/responses/responses.dart';

import 'dio_factory.dart';

abstract class AppServicesClientAbs {
  }

class AppServices implements AppServicesClientAbs {
  final DioFactory _dio;

  AppServices(this._dio);

  
}
