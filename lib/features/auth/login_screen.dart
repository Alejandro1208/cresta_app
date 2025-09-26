import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cresta_app/features/main_screen.dart';
import 'package:cresta_app/main.dart';
import 'package:cresta_app/theme/theme_provider.dart';
import 'package:cresta_app/widgets/app_logo.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm() {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      backgroundColor: isDesktop ? Theme.of(context).cardColor : Theme.of(context).scaffoldBackgroundColor,
      appBar: isDesktop ? null : AppBar(title: const Text('Bienvenido de Nuevo')),
      floatingActionButton: isDesktop ? null : FloatingActionButton(
        onPressed: () => ref.read(themeProvider.notifier).toggleTheme(),
        backgroundColor: Theme.of(context).cardColor,
        elevation: 1,
        child: Icon(
          ref.watch(themeProvider) == ThemeMode.dark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
          color: AppColors.lavandaSuave,
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (isDesktop) {
            return Row(
              children: [
                Expanded(child: _buildBrandingPanel()),
                Expanded(child: _buildFormPanel()),
              ],
            );
          } else {
            return SingleChildScrollView(child: _buildFormPanel());
          }
        },
      ),
    );
  }

  Widget _buildBrandingPanel() {
    return Container(
      color: AppColors.lavandaSuave,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AppLogo(height: 60, color: Colors.white),
            const SizedBox(height: 16),
            Text(
              'Bienvenido de nuevo\na la red de confianza.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormPanel() {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Inicia Sesión',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
              validator: (v) => v == null || !v.contains('@') ? 'Ingresa un email válido.' : null,
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                suffixIcon: IconButton(
                  icon: Icon(_isPasswordVisible ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                ),
              ),
              validator: (v) => v == null || v.isEmpty ? 'Ingresa tu contraseña.' : null,
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text('¿Olvidaste tu contraseña?'),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 20)),
              child: const Text('Iniciar Sesión'),
            ),
          ],
        ),
      ),
    );
  }
}