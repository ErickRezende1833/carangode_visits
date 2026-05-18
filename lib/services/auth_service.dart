import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> login({
    required String email,
    required String senha,
  }) async {
    final credencial = await _auth.signInWithEmailAndPassword(
      email: email,
      password: senha,
    );

    final doc = await _firestore
        .collection('usuarios')
        .doc(credencial.user!.uid)
        .get();

    if (!doc.exists) {
      throw Exception('Usuário não encontrado');
    }

    final dados = doc.data()!;
    return dados['tipo'];
  }

  Future<bool> usuarioAtualEhGerente() async {
    final usuario = _auth.currentUser;

    if (usuario == null) {
      return false;
    }

    final doc = await _firestore
        .collection('usuarios')
        .doc(usuario.uid)
        .get();

    if (!doc.exists) {
      return false;
    }

    final dados = doc.data()!;
    return dados['tipo'] == 'gerente';
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}