import 'package:flutter/material.dart';
import 'package:cresta_app/main.dart'; // Para AppColors
import 'package:cresta_app/features/search/search_results_screen.dart';

class TalentSearchScreen extends StatelessWidget {
  const TalentSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const popularTags = [
      'React',
      'Diseño UX',
      'Gestión de Proyectos',
      'Node.js',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Buscar Talentos')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Barra de Búsqueda ---
            TextField(
              decoration: InputDecoration(
                hintText: 'Buscar habilidad, puesto o tecnología...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: AppColors.blancoPuro,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          SearchResultsScreen(searchTerm: value),
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 32),

            // --- Contenido Inicial ---
            Text(
              'Búsquedas Populares',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: popularTags.map((tag) {
                return Chip(
                  label: Text(tag),
                  backgroundColor: AppColors.blancoPuro,
                  side: BorderSide(color: AppColors.grisMedio.withOpacity(0.2)),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
