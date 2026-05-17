import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/usuarioModel.dart';

class UsuarioService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> cadastrarUsuario(UsuarioModel usuario) async {
    await _firestore
        .collection('usuarios')
        .doc(usuario.id)
        .set(usuario.toMap());
  }

  Future<List<UsuarioModel>> listarEntrevistadores() async {
    final snapshot = await _firestore
        .collection('usuarios')
        .where('tipo', isEqualTo: 'entrevistador')
        .get();

    return snapshot.docs
        .map((doc) => UsuarioModel.fromMap(doc.data()))
        .toList(); 
    }
}