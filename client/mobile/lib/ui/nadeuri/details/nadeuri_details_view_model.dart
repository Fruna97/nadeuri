import 'package:mobile/domain/model/nadeuri/nadeuri.dart';

class NadeuriDetailsViewModel {
  final Nadeuri _nadeuri;

  NadeuriDetailsViewModel({required Nadeuri nadeuri}) : _nadeuri = nadeuri;

  Nadeuri get nadeuri => _nadeuri;
}
