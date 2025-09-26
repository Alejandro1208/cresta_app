import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cresta_app/features/auth/access_screen.dart';
import 'package:cresta_app/features/onboarding/widgets/onboarding_slide_widget.dart';
import 'package:cresta_app/features/onboarding/widgets/page_indicator_widget.dart';
import 'package:google_fonts/google_fonts.dart';

final onboardingPageIndexProvider = StateProvider<int>((ref) => 0);

class OnboardingSlideData {
  final String imageUrl;
  final String title;
  final String description;
  final List<String> keyFeatures;

  OnboardingSlideData({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.keyFeatures,
  });
}

final onboardingSlides = [
  OnboardingSlideData(
    imageUrl: 'https://images.unsplash.com/photo-1521737604893-d14cc237f11d?w=1200&q=80',
    title: 'Tu Perfil Profesional, Verificado',
    description: 'Crea un perfil que demuestre tu talento con validaciones de personas que han trabajado contigo.',
    keyFeatures: ['Validación por pares', 'Credibilidad aumentada', 'Perfil profesional completo'],
  ),
  OnboardingSlideData(
    imageUrl: 'https://images.unsplash.com/photo-1552664730-d307ca884978?w=1200&q=80',
    title: 'Consigue el Sello de Confianza',
    description: 'Solicita verificaciones de tus habilidades clave y haz que tu perfil destaque ante los reclutadores.',
    keyFeatures: ['Solicitudes simples por email', 'Sello de verificación visual', 'Destaca en búsquedas'],
  ),
  OnboardingSlideData(
    imageUrl: 'https://images.unsplash.com/photo-1556761175-5973dc0f32e7?w=1200&q=80',
    title: 'Encuentra y Sé Encontrado',
    description: 'Busca talento con credenciales reales o deja que las mejores oportunidades te encuentren a ti.',
    keyFeatures: ['Buscador de talento por habilidad', 'Resultados confiables', 'Conecta con profesionales'],
  ),
];

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPageIndex = ref.watch(onboardingPageIndexProvider);
    final pageController = PageController();
    final isDesktop = MediaQuery.of(context).size.width > 800;

    Widget buildKeyFeatures(OnboardingSlideData slide) {
      return Column(
        crossAxisAlignment: isDesktop ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: slide.keyFeatures.map((feature) => Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle_outline, color: Theme.of(context).colorScheme.secondary, size: 20),
              const SizedBox(width: 12),
              Text(feature, style: const TextStyle(fontSize: 16)),
            ],
          ),
        )).toList(),
      );
    }

    Widget buildContentColumn(OnboardingSlideData slide, {required bool isCentered}) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: isCentered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          Text(
            slide.title,
            textAlign: isCentered ? TextAlign.center : TextAlign.left,
            style: GoogleFonts.inter(fontSize: isDesktop ? 32 : 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Text(
            slide.description,
            textAlign: isCentered ? TextAlign.center : TextAlign.left,
            style: GoogleFonts.inter(fontSize: isDesktop ? 18 : 16, color: Theme.of(context).textTheme.bodySmall?.color, height: 1.5),
          ),
          const SizedBox(height: 32),
          buildKeyFeatures(slide),
          const SizedBox(height: 48),
          PageIndicatorWidget(pageCount: onboardingSlides.length, currentPage: currentPageIndex),
          const SizedBox(height: 32),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              if (currentPageIndex == onboardingSlides.length - 1) {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AccessScreen()));
              } else {
                pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
              }
            },
            child: Text(currentPageIndex == onboardingSlides.length - 1 ? 'Comenzar' : 'Siguiente'),
          ),
        ],
      );
    }

    Widget buildImageArea() {
      return PageView.builder(
        controller: pageController,
        onPageChanged: (index) => ref.read(onboardingPageIndexProvider.notifier).state = index,
        itemBuilder: (context, index) => OnboardingSlideWidget(imageUrl: onboardingSlides[index].imageUrl),
        itemCount: onboardingSlides.length,
      );
    }

    return Scaffold(
      body: isDesktop
          ? Row(
              children: [
                Expanded(flex: 1, child: buildImageArea()),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 48.0),
                    child: buildContentColumn(onboardingSlides[currentPageIndex], isCentered: true),
                  ),
                ),
              ],
            )
          : Stack(
              children: [
                buildImageArea(),
                Positioned(
                  bottom: 0, left: 0, right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
                    ),
                    child: buildContentColumn(onboardingSlides[currentPageIndex], isCentered: false),
                  ),
                ),
              ],
            ),
    );
  }
}