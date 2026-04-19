import 'package:flutter/material.dart';
import '../models/visita.dart';
import '../database/visita_dao.dart';

class HomeCampoViewModel extends ChangeNotifier {
  final VisitaDao _visitaDao = VisitaDao();
  
  List<Visita> _visitas = [];
  bool _isLoading = false;

  List<Visita> get visitas => _visitas;
  bool get isLoading => _isLoading;

  // Carrega as visitas do SQLite
  Future<void> carregarVisitas() async {
    _isLoading = true;
    notifyListeners(); // Notifica a View que está carregando

    try {
      _visitas = await _visitaDao.listarVisitas();
    } catch (e) {
      debugPrint("Erro ao carregar visitas: $e");
    } finally {
      _isLoading = false;
      notifyListeners(); // Notifica a View com os novos dados
    }
  }
}