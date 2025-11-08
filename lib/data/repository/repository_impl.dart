import 'package:dartz/dartz.dart';
import 'package:hi_net/data/network/error_handler/error_handler.dart';
import 'package:hi_net/data/network/error_handler/failure.dart';
import 'package:hi_net/data/network/internet_checker.dart';
import 'package:hi_net/data/responses/responses.dart';
import 'package:hi_net/domain/repository/repository.dart';

import '../network/api.dart';
import '../request/request.dart';

class Repository implements RepositoryAbs {
  final AppServices _appServices;
  final NetworkConnectivity _networkConnectivity;

  Repository(this._appServices, this._networkConnectivity);

  
}
