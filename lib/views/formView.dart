import 'package:flutter/material.dart';
import 'widgets.dart';

class FormView extends StatefulWidget {



  @override
  State<FormView> createState() => _FormViewState();
}

class _FormViewState extends State<FormView> {

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),

        

        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              CustomIconTextField(
                labelText: 'Nome Completo',
                hintText: 'Digite o nome completo',
                prefixIcon: Icons.person,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, preencha este campo';
                  }
                  return null;
                },
              ),

              SizedBox(height: 16.0),

              
              ElevatedButton(
                onPressed: () {
                  // Isso dispara o validador e faz o texto de erro aparecer
                  if (_formKey.currentState!.validate()) {
                    print('Formulário válido!');
                  }
                },
                child: const Text('Enviar'),
              ),

              
              
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(currentIndex: 0),
    );
  }
}
