import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ConsultaVisitasViewModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<QueryDocumentSnapshot> familias = [];
  List<QueryDocumentSnapshot> familiasFiltradas = [];

  bool loading = true;

  Future<void> carregarFamilias() async {
    try {
      final snapshot = await _firestore
          .collection('familias')
          .get();

      familias = snapshot.docs;
      familiasFiltradas = snapshot.docs;
      loading = false;

      notifyListeners();

    } catch (e) {
      loading = false;
      notifyListeners();
      rethrow;
    }
  }

  void filtrar(String texto) {
    familiasFiltradas = familias.where((doc) {
      final nome = doc['nomeTitular']
          .toString()
          .toLowerCase();

      return nome.contains(
        texto.toLowerCase(),
      );
    }).toList();

    notifyListeners();
  }
}