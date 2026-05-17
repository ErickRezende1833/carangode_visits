import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/usuarioModel.dart';

class UsuarioService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> cadastrarEntrevistador({
    required String nome,
    required String email,
    required String senha,
  }) async {

    final credencial = await _auth
        .createUserWithEmailAndPassword(
      email: email,
      password: senha,
    );

    final usuario = UsuarioModel(
      id: credencial.user!.uid,
      nome: nome,
      email: email,
      tipo: 'entrevistador',
    );

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