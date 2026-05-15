import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodel/auth_oficial_viewmodel.dart';

class LoginOficialScreen extends StatefulWidget {
  const LoginOficialScreen({super.key});

  @override
  State<LoginOficialScreen> createState() =>
      _LoginOficialScreenState();
}

class _LoginOficialScreenState
    extends State<LoginOficialScreen> {

  final TextEditingController employeeController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  bool _obscurePassword = true;

  static const Color mibancoGreen =
      Color(0xFF00A859);

  static const Color mibancoDark =
      Color(0xFF002E18);

  static const Color mibancoCard =
      Color(0xFF063B22);

  static const Color mibancoYellow =
      Color(0xFFFFD100);

  @override
  Widget build(BuildContext context) {

    final authVM =
        Provider.of<AuthOficialViewModel>(context);

    return Scaffold(

      backgroundColor: mibancoDark,

      body: SingleChildScrollView(

        child: Column(

          children: [

            // CABECERA VERDE
            Stack(

              children: [

                ClipPath(

                  clipper: CustomCurveClipper(),

                  child: Container(

                    width: double.infinity,

                    height: 320,

                    decoration: const BoxDecoration(

                      color: mibancoGreen,

                    ),

                  ),

                ),

                Positioned(

                  top: 60,

                  left: 0,

                  right: 0,

                  child: Column(

                    children: [

                      Image.asset(

                        'assets/logo_mibanco.png',

                        height: 90,

                        fit: BoxFit.contain,

                        errorBuilder:
                            (
                              context,
                              error,
                              stackTrace,
                            ) => const Icon(

                              Icons.account_balance,

                              size: 80,

                              color: Colors.white,

                            ),

                      ),

                      const SizedBox(height: 20),

                      Container(

                        padding:
                            const EdgeInsets.symmetric(

                          horizontal: 20,

                          vertical: 8,

                        ),

                        decoration: BoxDecoration(

                          color: mibancoYellow
                              .withOpacity(0.15),

                          borderRadius:
                              BorderRadius.circular(30),

                          border: Border.all(

                            color: mibancoYellow,

                            width: 1.5,

                          ),

                        ),

                        child: const Text(

                          "PORTAL OFICIAL",

                          style: TextStyle(

                            color: mibancoYellow,

                            fontSize: 14,

                            fontWeight:
                                FontWeight.bold,

                            letterSpacing: 3,

                          ),

                        ),

                      ),

                      const SizedBox(height: 15),

                      const Text(

                        "GESTIÓN DE CRÉDITO",

                        style: TextStyle(

                          color: Colors.white,

                          fontSize: 28,

                          fontWeight:
                              FontWeight.w900,

                          letterSpacing: 1,

                        ),

                      ),

                    ],

                  ),

                ),

              ],

            ),

            Padding(

              padding:
                  const EdgeInsets.symmetric(
                horizontal: 30.0,
              ),

              child: Column(

                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  const Text(

                    "Ingreso Institucional",

                    style: TextStyle(

                      fontSize: 20,

                      fontWeight:
                          FontWeight.bold,

                      color: Colors.white,

                    ),

                  ),

                  const SizedBox(height: 25),

                  _buildLabel(
                    "Código de empleado",
                  ),

                  const SizedBox(height: 8),

                  _buildTextField(

                    controller:
                        employeeController,

                    hint:
                        "Usuario del sistema",

                    icon:
                        Icons.person_pin_rounded,

                  ),

                  const SizedBox(height: 20),

                  _buildLabel(
                    "Contraseña",
                  ),

                  const SizedBox(height: 8),

                  _buildTextField(

                    controller:
                        passwordController,

                    hint: "Clave de acceso",

                    icon:
                        Icons.vpn_key_outlined,

                    isPassword: true,

                  ),

                  const SizedBox(height: 30),

                  // ERROR
                  if (authVM.error.isNotEmpty)
                    _buildErrorMessage(
                      authVM.error,
                    ),

                  const SizedBox(height: 20),

                  // BOTÓN
                  authVM.loading

                      ? const Center(

                          child:
                              CircularProgressIndicator(

                            color: mibancoYellow,

                          ),

                        )

                      : SizedBox(

                          width: double.infinity,

                          height: 60,

                          child: ElevatedButton(

                            style:
                                ElevatedButton.styleFrom(

                              backgroundColor:
                                  mibancoYellow,

                              foregroundColor:
                                  mibancoDark,

                              elevation: 8,

                              shape:
                                  RoundedRectangleBorder(

                                borderRadius:
                                    BorderRadius.circular(
                                  18,
                                ),

                              ),

                            ),

                            onPressed: () async {

                              bool result =
                                  await authVM.login(

                                employeeController
                                    .text,

                                passwordController
                                    .text,

                              );

                              if (result) {

                                Navigator
                                    .pushReplacementNamed(

                                  context,

                                  '/cartera',

                                );

                              }

                            },

                            child: const Text(

                              'INGRESAR AL SISTEMA',

                              style: TextStyle(

                                fontSize: 16,

                                fontWeight:
                                    FontWeight.bold,

                                letterSpacing: 1.5,

                              ),

                            ),

                          ),

                        ),

                  const SizedBox(height: 40),

                  // TARJETA OSCURA
                  Container(

                    width: double.infinity,

                    padding:
                        const EdgeInsets.all(18),

                    decoration: BoxDecoration(

                      color: mibancoCard,

                      borderRadius:
                          BorderRadius.circular(20),

                      border: Border.all(

                        color: mibancoGreen
                            .withOpacity(0.4),

                      ),

                    ),

                    child: const Column(

                      children: [

                        Icon(

                          Icons.security,

                          color: mibancoYellow,

                          size: 35,

                        ),

                        SizedBox(height: 10),

                        Text(

                          "Acceso seguro para oficiales de crédito",

                          textAlign:
                              TextAlign.center,

                          style: TextStyle(

                            color: Colors.white,

                            fontWeight:
                                FontWeight.bold,

                            fontSize: 14,

                          ),

                        ),

                      ],

                    ),

                  ),

                  const SizedBox(height: 50),

                  const Center(

                    child: Opacity(

                      opacity: 0.6,

                      child: Text(

                        "Sistemas Internos - MiBanco",

                        style: TextStyle(

                          color: Colors.white70,

                          fontSize: 12,

                          fontWeight:
                              FontWeight.bold,

                        ),

                      ),

                    ),

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

  // ERROR
  Widget _buildErrorMessage(String msg) {

    return Container(

      padding:
          const EdgeInsets.symmetric(

        horizontal: 15,

        vertical: 12,

      ),

      decoration: BoxDecoration(

        color: Colors.red.withOpacity(0.15),

        border: Border.all(

          color: Colors.red.shade300,

        ),

        borderRadius:
            BorderRadius.circular(10),

      ),

      child: Row(

        children: [

          const Icon(

            Icons.error_outline,

            color: Colors.red,

            size: 20,

          ),

          const SizedBox(width: 10),

          Expanded(

            child: Text(

              msg,

              style: const TextStyle(

                color: Colors.white,

                fontSize: 13,

              ),

            ),

          ),

        ],

      ),

    );

  }

  // LABEL
  Widget _buildLabel(String text) {

    return Text(

      text.toUpperCase(),

      style: const TextStyle(

        fontWeight: FontWeight.bold,

        color: mibancoYellow,

        fontSize: 11,

        letterSpacing: 1,

      ),

    );

  }

  // INPUTS
  Widget _buildTextField({

    required TextEditingController controller,

    required String hint,

    required IconData icon,

    bool isPassword = false,

  }) {

    return TextField(

      controller: controller,

      obscureText:
          isPassword ? _obscurePassword : false,

      style: const TextStyle(
        color: Colors.white,
      ),

      decoration: InputDecoration(

        hintText: hint,

        hintStyle: const TextStyle(
          color: Colors.white54,
        ),

        prefixIcon: Icon(

          icon,

          color: mibancoYellow,

        ),

        suffixIcon: isPassword

            ? IconButton(

                icon: Icon(

                  _obscurePassword

                      ? Icons.visibility_off

                      : Icons.visibility,

                  color: mibancoYellow,

                ),

                onPressed: () {

                  setState(() {

                    _obscurePassword =
                        !_obscurePassword;

                  });

                },

              )

            : null,

        filled: true,

        fillColor: mibancoCard,

        border: OutlineInputBorder(

          borderRadius:
              BorderRadius.circular(15),

          borderSide: BorderSide.none,

        ),

        enabledBorder: OutlineInputBorder(

          borderRadius:
              BorderRadius.circular(15),

          borderSide: BorderSide(

            color:
                mibancoGreen.withOpacity(0.4),

          ),

        ),

        focusedBorder: OutlineInputBorder(

          borderRadius:
              BorderRadius.circular(15),

          borderSide: const BorderSide(

            color: mibancoYellow,

            width: 2,

          ),

        ),

        contentPadding:
            const EdgeInsets.symmetric(
          vertical: 18,
        ),

      ),

    );

  }

}

class CustomCurveClipper
    extends CustomClipper<Path> {

  @override
  Path getClip(Size size) {

    Path path = Path();

    path.lineTo(0, size.height - 60);

    path.quadraticBezierTo(

      size.width / 2,

      size.height,

      size.width,

      size.height - 60,

    );

    path.lineTo(size.width, 0);

    path.close();

    return path;

  }

  @override
  bool shouldReclip(
      CustomClipper<Path> oldClipper) {

    return false;

  }

}