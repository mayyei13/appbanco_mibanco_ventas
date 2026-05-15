import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodel/cartera_viewmodel.dart';

class CarteraDiariaScreen extends StatefulWidget {
  const CarteraDiariaScreen({super.key});

  @override
  State<CarteraDiariaScreen> createState() =>
      _CarteraDiariaScreenState();
}

class _CarteraDiariaScreenState
    extends State<CarteraDiariaScreen> {

  int _selectedIndex = 0;

  // PALETA OSCURA VERDE
  static const Color mibancoGreen =
      Color(0xFF00A859);

  static const Color mibancoYellow =
      Color(0xFFFFD100);

  static const Color mibancoDark =
      Color(0xFF001A0D);

  static const Color mibancoCard =
      Color(0xFF063B22);

  static const Color mibancoCard2 =
      Color(0xFF0B4F2D);

  static const Color mibancoListBg =
      Color(0xFF01150C);

  @override
  Widget build(BuildContext context) {

    final carteraVM =
        Provider.of<CarteraViewModel>(context);

    return Scaffold(

      backgroundColor: mibancoDark,

      appBar: AppBar(

        backgroundColor: mibancoDark,

        elevation: 0,

        centerTitle: false,

        title: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            const Text(

              "Panel de Gestión",

              style: TextStyle(

                fontSize: 12,

                color: Colors.white70,

                letterSpacing: 1,

              ),

            ),

            Text(

              "OFICIAL: ${carteraVM.nombreOficial}",

              style: const TextStyle(

                fontSize: 18,

                fontWeight:
                    FontWeight.bold,

                color: Colors.white,

              ),

            ),

          ],

        ),

        actions: [

          IconButton(

            icon: const Icon(

              Icons.notifications_none_rounded,

              color: Colors.white,

            ),

            onPressed: () {},

          ),

          IconButton(

            icon: const Icon(

              Icons.logout_rounded,

              color: mibancoYellow,

            ),

            onPressed: () {

              Navigator.pushReplacementNamed(

                context,

                '/',

              );

            },

          ),

        ],

      ),

      body: Column(

        children: [

          _buildEnhancedHeader(carteraVM),

          Expanded(

            child: Container(

              width: double.infinity,

              decoration: const BoxDecoration(

                color: mibancoListBg,

                borderRadius:
                    BorderRadius.only(

                  topLeft:
                      Radius.circular(30),

                  topRight:
                      Radius.circular(30),

                ),

              ),

              child: Column(

                children: [

                  _buildQuickActions(),

                  Expanded(

                    child: Container(

                      margin:
                          const EdgeInsets.only(
                        top: 10,
                      ),

                      padding:
                          const EdgeInsets.only(
                        top: 20,
                      ),

                      decoration:
                          const BoxDecoration(

                        color: Color(
                          0xFF021E12,
                        ),

                        borderRadius:
                            BorderRadius.only(

                          topLeft:
                              Radius.circular(
                            30,
                          ),

                          topRight:
                              Radius.circular(
                            30,
                          ),

                        ),

                      ),

                      child: Padding(

                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 20.0,
                        ),

                        child: Column(

                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,

                          children: [

                            const Row(

                              mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,

                              children: [

                                Text(

                                  "Hoja de Ruta",

                                  style: TextStyle(

                                    fontSize: 22,

                                    fontWeight:
                                        FontWeight
                                            .bold,

                                    color:
                                        Colors.white,

                                  ),

                                ),

                                Icon(

                                  Icons.filter_list,

                                  color:
                                      mibancoYellow,

                                ),

                              ],

                            ),

                            const SizedBox(
                                height: 18),

                            Expanded(

                              child:
                                  ListView.builder(

                                itemCount:
                                    carteraVM
                                        .clientes
                                        .length,

                                physics:
                                    const BouncingScrollPhysics(),

                                itemBuilder:
                                    (
                                      context,
                                      index,
                                    ) {

                                  final cliente =
                                      carteraVM
                                              .clientes[
                                          index];

                                  return _buildProfessionalClientCard(

                                    cliente,

                                    index,

                                    carteraVM,

                                  );

                                },

                              ),

                            ),

                          ],

                        ),

                      ),

                    ),

                  ),

                ],

              ),

            ),

          ),

        ],

      ),

      bottomNavigationBar:
          _buildBottomNav(),

      floatingActionButton:
          FloatingActionButton(

        backgroundColor:
            mibancoYellow,

        elevation: 6,

        child: const Icon(

          Icons.add_location_alt_rounded,

          color: mibancoDark,

        ),

        onPressed: () {},

      ),

    );

  }

  // HEADER MÉTRICAS
  Widget _buildEnhancedHeader(
      CarteraViewModel vm) {

    double efectividad =
        vm.totalVisitas > 0

            ? (vm.completados /
                vm.totalVisitas)

            : 0;

    return Container(

      padding:
          const EdgeInsets.symmetric(

        vertical: 20,

        horizontal: 25,

      ),

      child: Row(

        mainAxisAlignment:
            MainAxisAlignment
                .spaceBetween,

        children: [

          _buildMetric(

            "Visitas",

            vm.totalVisitas.toString(),

            Icons.assignment_outlined,

          ),

          _buildMetric(

            "Pendientes",

            vm.pendientes.toString(),

            Icons.hourglass_top_rounded,

          ),

          _buildMetric(

            "Efectividad",

            "${(efectividad * 100).toInt()}%",

            Icons.stars_rounded,

          ),

        ],

      ),

    );

  }

  Widget _buildMetric(
    String label,
    String value,
    IconData icon,
  ) {

    return Column(

      children: [

        Container(

          padding:
              const EdgeInsets.all(10),

          decoration: BoxDecoration(

            color:
                mibancoCard.withOpacity(0.9),

            shape: BoxShape.circle,

          ),

          child: Icon(

            icon,

            color: mibancoYellow,

            size: 24,

          ),

        ),

        const SizedBox(height: 8),

        Text(

          value,

          style: const TextStyle(

            color: Colors.white,

            fontSize: 22,

            fontWeight:
                FontWeight.bold,

          ),

        ),

        Text(

          label,

          style: const TextStyle(

            color: Colors.white70,

            fontSize: 11,

            fontWeight:
                FontWeight.w500,

          ),

        ),

      ],

    );

  }

  // ACCIONES RÁPIDAS
  Widget _buildQuickActions() {

    return Container(

      margin:
          const EdgeInsets.symmetric(

        vertical: 20,

        horizontal: 15,

      ),

      padding:
          const EdgeInsets.symmetric(

        vertical: 18,

        horizontal: 10,

      ),

      decoration: BoxDecoration(

        gradient: const LinearGradient(

          colors: [

            mibancoCard,

            mibancoCard2,

          ],

        ),

        borderRadius:
            BorderRadius.circular(24),

        border: Border.all(

          color:
              mibancoGreen.withOpacity(0.4),

        ),

        boxShadow: [

          BoxShadow(

            color:
                Colors.black.withOpacity(
              0.25,
            ),

            blurRadius: 10,

          ),

        ],

      ),

      child: Row(

        mainAxisAlignment:
            MainAxisAlignment
                .spaceEvenly,

        children: [

          _buildCircleAction(
            Icons.map_rounded,
            "Mapa",
          ),

          _buildCircleAction(
            Icons.calendar_today_rounded,
            "Agenda",
          ),

          _buildCircleAction(
            Icons.insights_rounded,
            "Metas",
          ),

          _buildCircleAction(
            Icons.group_add_rounded,
            "Prospecto",
          ),

        ],

      ),

    );

  }

  Widget _buildCircleAction(
    IconData icon,
    String label,
  ) {

    return Column(

      children: [

        Container(

          padding:
              const EdgeInsets.all(14),

          decoration: BoxDecoration(

            color: mibancoDark,

            shape: BoxShape.circle,

            border: Border.all(

              color: mibancoGreen
                  .withOpacity(0.5),

            ),

            boxShadow: [

              BoxShadow(

                color: Colors.black
                    .withOpacity(0.2),

                blurRadius: 8,

              ),

            ],

          ),

          child: Icon(

            icon,

            color: mibancoYellow,

            size: 24,

          ),

        ),

        const SizedBox(height: 8),

        Text(

          label,

          style: const TextStyle(

            fontSize: 11,

            fontWeight:
                FontWeight.w600,

            color: Colors.white,

          ),

        ),

      ],

    );

  }

  // TARJETAS CLIENTES
  Widget _buildProfessionalClientCard(

    cliente,

    int index,

    CarteraViewModel vm,

  ) {

    bool isVisitado =
        cliente.estado == "Visitado";

    return Container(

      margin:
          const EdgeInsets.only(
        bottom: 15,
      ),

      decoration: BoxDecoration(

        gradient: const LinearGradient(

          begin: Alignment.topLeft,

          end: Alignment.bottomRight,

          colors: [

            mibancoCard,

            mibancoCard2,

          ],

        ),

        borderRadius:
            BorderRadius.circular(22),

        border: Border.all(

          color:
              mibancoGreen.withOpacity(0.3),

        ),

        boxShadow: [

          BoxShadow(

            color:
                Colors.black.withOpacity(0.25),

            blurRadius: 12,

            offset:
                const Offset(0, 6),

          ),

        ],

      ),

      child: Material(

        color: Colors.transparent,

        child: ListTile(

          onTap: () {

            vm.marcarComoVisitado(
              index,
            );

          },

          contentPadding:
              const EdgeInsets.symmetric(

            horizontal: 20,

            vertical: 12,

          ),

          leading: Container(

            padding:
                const EdgeInsets.all(10),

            decoration: BoxDecoration(

              color: isVisitado

                  ? mibancoGreen
                      .withOpacity(0.2)

                  : mibancoYellow
                      .withOpacity(0.2),

              borderRadius:
                  BorderRadius.circular(
                14,
              ),

            ),

            child: Icon(

              isVisitado

                  ? Icons
                      .check_circle_rounded

                  : Icons
                      .pending_rounded,

              color: isVisitado

                  ? mibancoGreen

                  : mibancoYellow,

            ),

          ),

          title: Text(

            cliente.nombre,

            style: const TextStyle(

              fontWeight:
                  FontWeight.bold,

              fontSize: 16,

              color: Colors.white,

            ),

          ),

          subtitle: Padding(

            padding:
                const EdgeInsets.only(
              top: 8.0,
            ),

            child: Row(

              children: [

                Text(

                  cliente.gestion,

                  style:
                      const TextStyle(

                    fontSize: 12,

                    color:
                        Colors.white70,

                  ),

                ),

                const SizedBox(
                    width: 8),

                const Text(

                  "•",

                  style: TextStyle(
                    color:
                        Colors.white70,
                  ),

                ),

                const SizedBox(
                    width: 8),

                Text(

                  cliente.estado,

                  style: TextStyle(

                    fontSize: 12,

                    fontWeight:
                        FontWeight.bold,

                    color: isVisitado

                        ? mibancoGreen

                        : mibancoYellow,

                  ),

                ),

              ],

            ),

          ),

          trailing: const Icon(

            Icons.chevron_right_rounded,

            color: mibancoYellow,

          ),

        ),

      ),

    );

  }

  // BOTTOM NAV
  Widget _buildBottomNav() {

    return Container(

      decoration: BoxDecoration(

        color: mibancoCard,

        boxShadow: [

          BoxShadow(

            color:
                Colors.black.withOpacity(
              0.3,
            ),

            blurRadius: 12,

          ),

        ],

      ),

      child: BottomNavigationBar(

        currentIndex:
            _selectedIndex,

        onTap: (index) {

          setState(() {

            _selectedIndex =
                index;

          });

        },

        type:
            BottomNavigationBarType.fixed,

        backgroundColor:
            mibancoCard,

        selectedItemColor:
            mibancoYellow,

        unselectedItemColor:
            Colors.white54,

        selectedLabelStyle:
            const TextStyle(

          fontWeight:
              FontWeight.bold,

          fontSize: 12,

        ),

        items: const [

          BottomNavigationBarItem(

            icon:
                Icon(Icons.home_rounded),

            label: "Inicio",

          ),

          BottomNavigationBarItem(

            icon: Icon(

              Icons
                  .assignment_ind_rounded,

            ),

            label: "Mi Cartera",

          ),

          BottomNavigationBarItem(

            icon: Icon(

              Icons
                  .chat_bubble_outline_rounded,

            ),

            label: "Mensajes",

          ),

          BottomNavigationBarItem(

            icon: Icon(

              Icons
                  .more_horiz_rounded,

            ),

            label: "Más",

          ),

        ],

      ),

    );

  }

}