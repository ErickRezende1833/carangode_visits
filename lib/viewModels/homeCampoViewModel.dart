import 'package:flutter/material.dart';
import '../models/familiaModel.dart';
import '../database/familia_dao.dart';

class HomeCampoViewModel extends ChangeNotifier {
  final FamiliaDao _familiaDao = FamiliaDao();
  
  List<Familia> _familias = [];
  bool _isLoading = false;

  List<Familia> get familias => _familias;
  bool get isLoading => _isLoading;

  Future<void> carregarFamilias() async {
    _isLoading = true;
    notifyListeners();

    try {
      _familias = await _familiaDao.listarFamilias();
    } catch (e) {
      debugPrint("Erro ao carregar famílias: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}