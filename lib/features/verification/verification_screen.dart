import 'package:flutter/material.dart';
import 'package:cresta_app/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cresta_app/widgets/app_logo.dart'; 

class VerificationScreen extends StatelessWidget {
  final String applicantName = 'Alejandro Sabater';
  final String applicantTitle = 'Desarrollador Flutter';
  final String applicantImageUrl = 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=800&q=80';
  final String skillName = 'Flutter';

  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      backgroundColor: AppColors.blancoPuro,
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (isDesktop) {
            return Row(
              children: [
                Expanded(child: _buildBrandingPanel()),
                Expanded(child: _buildActionsPanel(context)),
              ],
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  _buildBrandingPanel(isMobile: true),
                  _buildActionsPanel(context),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildBrandingPanel({bool isMobile = false}) {
    return Container(
      padding: const EdgeInsets.all(32.0),
      height: isMobile ? 300 : null,
      decoration: const BoxDecoration(
        color: AppColors.lavandaSuave,
        gradient: LinearGradient(
          colors: [AppColors.lavandaSuave, Color(0xFF8E7AC5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AppLogo(height: 80, color: Colors.white),
            const SizedBox(height: 24),
            Text(
              'Solicitud de Verificación de Cresta',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [Shadow(blurRadius: 2, color: Colors.black.withOpacity(0.2))],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionsPanel(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(applicantImageUrl),
          ),
          const SizedBox(height: 16),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: GoogleFonts.inter(fontSize: 24, color: AppColors.grisOscuro),
              children: [
                TextSpan(
                  text: applicantName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const TextSpan(text: ' solicita tu validación.'),
              ],
            ),
          ),
          const SizedBox(height: 24),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: GoogleFonts.inter(fontSize: 16, color: AppColors.grisMedio, height: 1.5),
              children: [
                const TextSpan(text: '¿Confirmas que trabajaste con esta persona y que demostró tener un dominio profesional de la habilidad '),
                TextSpan(
                  text: skillName,
                  style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.grisOscuro),
                ),
                const TextSpan(text: '?'),
              ],
            ),
          ),
          const SizedBox(height: 48),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.mentaFresca,
              padding: const EdgeInsets.symmetric(vertical: 20),
            ),
            child: const Text('Sí, confirmo esta habilidad'),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {},
            child: const Text('No puedo verificarlo', style: TextStyle(color: AppColors.grisMedio)),
          ),
        ],
      ),
    );
  }
}