import 'package:flutter/material.dart';
import 'widgets.dart';

class HomeCampoView extends StatefulWidget {
  const HomeCampoView({Key? key}) : super(key: key);

  @override
  State<HomeCampoView> createState() => _HomeCampoViewState();
}

class _HomeCampoViewState extends State<HomeCampoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LOGO'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
      ),
      body: LayoutBuilder(
  builder: (context, constraints) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
        minHeight: constraints.maxHeight,
        ),
        child: IntrinsicHeight(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
          
                Expanded( 
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("Cadastros:", style: const TextStyle(fontSize: 20)),
                        ],
                      ),
                     


                    
                    ],
                  ),
                ),

                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    CustomElevatedButton(
                      onPressed: () {},
                      icon: Icons.sync,
                      label: "Sincronizar",
                    ),

                    CustomElevatedButton(
                      onPressed: () {},
                      icon: Icons.add,
                      label: "Adicionar",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  },
),
      bottomNavigationBar: const CustomBottomNavigationBar(currentIndex: 0),
    );
  }
}



