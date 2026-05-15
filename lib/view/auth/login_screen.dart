import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodel/auth_viewmodel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscurePassword = true;

  static const Color mibancoGreen = Color(0xFF00A859);

  @override
  Widget build(BuildContext context) {
    final authVM = Provider.of<AuthViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // PARTE SUPERIOR CURVADA PROFESIONAL
            Stack(
              children: [
                ClipPath(
                  clipper: CustomCurveClipper(),
                  child: Container(
                    width: double.infinity,
                    height: 280,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          mibancoGreen,
                          Color(0xFF006D32),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned( 
                  top: 70,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Image.asset(
                          'assets/logo_mibanco.png',
                          height: 100,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.account_balance,
                                size: 80, color: Colors.white);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "¡Bienvenido!",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: mibancoGreen,
                    ),
                  ),
                  const Text(
                    "Ingresa tus datos para continuar",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  const SizedBox(height: 35),

                  // CAMPO: DOCUMENTO
                  _buildLabel("Número de documento"),
                  const SizedBox(height: 8),
                  _buildTextField(
                    controller: userController,
                    hint: "DNI / CE / Pasaporte",
                    icon: Icons.badge_outlined,
                    type: TextInputType.number,
                  ),

                  const SizedBox(height: 25),

                  // CAMPO: CLAVE
                  _buildLabel("Clave de internet"),
                  const SizedBox(height: 8),
                  _buildTextField(
                    controller: passwordController,
                    hint: "Clave de 6 dígitos",
                    icon: Icons.lock_outline,
                    type: TextInputType.number,
                    isPassword: true,
                  ),

                  // OLVIDASTE TU CLAVE
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        "¿Olvidaste tu clave?",
                        style: TextStyle(
                          color: mibancoGreen,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  // ERROR DEL VIEWMODEL
                  if (authVM.error.isNotEmpty)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Text(
                          authVM.error,
                          style: const TextStyle(color: Colors.red, fontSize: 14),
                        ),
                      ),
                    ),

                  // BOTÓN INGRESAR
                  authVM.loading
                      ? const Center(child: CircularProgressIndicator(color: mibancoGreen))
                      : SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: mibancoGreen,
                              foregroundColor: Colors.white,
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: () async {
                              bool result = await authVM.login(
                                userController.text,
                                passwordController.text,
                              );
                              if (result) {
                                Navigator.pushReplacementNamed(context, '/dashboard');
                              }
                            },
                            child: const Text(
                              'INGRESAR',
                              style: TextStyle(
                                  fontSize: 16, 
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),

                  const SizedBox(height: 40),

                  // PIE DE PÁGINA
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("¿No tienes una cuenta? "),
                      GestureDetector(
                        onTap: () {
                          print("Registrar aquí");
                        },
                        child: const Text(
                          "Regístrate aquí",
                          style: TextStyle(
                            color: mibancoGreen,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // WIDGETS AUXILIARES
  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Color(0xFF424242),
        fontSize: 14,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isPassword = false,
    TextInputType type = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword ? _obscurePassword : false,
        keyboardType: type,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon, color: mibancoGreen),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                )
              : null,
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: mibancoGreen, width: 2),
          ),
        ),
      ),
    );
  }
}

// CLASE PARA LA CURVA
class CustomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
      size.width / 2, size.height, 
      size.width, size.height - 80
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}