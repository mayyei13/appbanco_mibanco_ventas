import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodel/cartera_viewmodel.dart';

class CarteraDiariaScreen extends StatefulWidget {
  const CarteraDiariaScreen({super.key});

  @override
  State<CarteraDiariaScreen> createState() => _CarteraDiariaScreenState();
}

class _CarteraDiariaScreenState extends State<CarteraDiariaScreen> {

  int _selectedIndex = 0;

  // COLORES TEMÁTICOS MI BANCO
  static const Color mibancoGreen =
      Color(0xFF00843D);

  static const Color mibancoYellow =
      Color(0xFFFFD100);

  static const Color mibancoLight =
      Color(0xFFF5F7F6);

  @override
  Widget build(BuildContext context) {

    final carteraVM =
        Provider.of<CarteraViewModel>(context);

    return Scaffold(

      backgroundColor: mibancoGreen,

      appBar: AppBar(

        backgroundColor: mibancoGreen,

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

                fontWeight: FontWeight.bold,

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

              color: Colors.white,

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

                color: mibancoLight,

                borderRadius: BorderRadius.only(

                  topLeft: Radius.circular(30),

                  topRight: Radius.circular(30),

                ),

              ),

              child: Column(

                children: [

                  _buildQuickActions(),

                  Expanded(

                    child: Padding(

                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 20.0,
                      ),

                      child: Column(

                        crossAxisAlignment:
                            CrossAxisAlignment.start,

                        children: [

                          const Row(

                            mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceBetween,

                            children: [

                              Text(

                                "Hoja de Ruta",

                                style: TextStyle(

                                  fontSize: 20,

                                  fontWeight:
                                      FontWeight.bold,

                                  color: mibancoGreen,

                                ),

                              ),

                              Icon(

                                Icons.filter_list,

                                color: mibancoGreen,

                              ),

                            ],

                          ),

                          const SizedBox(height: 15),

                          Expanded(

                            child: ListView.builder(

                              itemCount:
                                  carteraVM.clientes.length,

                              physics:
                                  const BouncingScrollPhysics(),

                              itemBuilder:
                                  (context, index) {

                                final cliente =
                                    carteraVM
                                        .clientes[index];

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

        backgroundColor: mibancoYellow,

        elevation: 4,

        child: const Icon(

          Icons.add_location_alt_rounded,

          color: mibancoGreen,

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

      padding: const EdgeInsets.symmetric(

        vertical: 20,

        horizontal: 25,

      ),

      child: Row(

        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,

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

        Icon(

          icon,

          color: mibancoYellow,

          size: 24,

        ),

        const SizedBox(height: 6),

        Text(

          value,

          style: const TextStyle(

            color: Colors.white,

            fontSize: 22,

            fontWeight: FontWeight.bold,

          ),

        ),

        Text(

          label,

          style: const TextStyle(

            color: Colors.white70,

            fontSize: 11,

            fontWeight: FontWeight.w500,

          ),

        ),

      ],

    );

  }

  Widget _buildQuickActions() {

    return Container(

      margin: const EdgeInsets.symmetric(

        vertical: 20,

        horizontal: 10,

      ),

      child: Row(

        mainAxisAlignment:
            MainAxisAlignment.spaceEvenly,

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

          padding: const EdgeInsets.all(12),

          decoration: BoxDecoration(

            color: mibancoYellow.withOpacity(0.2),

            shape: BoxShape.circle,

          ),

          child: Icon(

            icon,

            color: mibancoGreen,

            size: 24,

          ),

        ),

        const SizedBox(height: 8),

        Text(

          label,

          style: const TextStyle(

            fontSize: 11,

            fontWeight: FontWeight.w600,

            color: mibancoGreen,

          ),

        ),

      ],

    );

  }

  Widget _buildProfessionalClientCard(
    cliente,
    int index,
    CarteraViewModel vm,
  ) {

    bool isVisitado =
        cliente.estado == "Visitado";

    return Container(

      margin: const EdgeInsets.only(
        bottom: 15,
      ),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
            BorderRadius.circular(20),

        boxShadow: [

          BoxShadow(

            color:
                Colors.black.withOpacity(0.04),

            blurRadius: 10,

            offset: const Offset(0, 4),

          ),

        ],

      ),

      child: Material(

        color: Colors.transparent,

        child: ListTile(

          onTap: () {

            vm.marcarComoVisitado(index);

          },

          contentPadding:
              const EdgeInsets.symmetric(

            horizontal: 20,

            vertical: 10,

          ),

          leading: Container(

            padding: const EdgeInsets.all(10),

            decoration: BoxDecoration(

              color: isVisitado
                  ? mibancoGreen.withOpacity(0.1)
                  : mibancoYellow.withOpacity(0.2),

              borderRadius:
                  BorderRadius.circular(12),

            ),

            child: Icon(

              isVisitado
                  ? Icons.check_circle_rounded
                  : Icons.pending_rounded,

              color: isVisitado
                  ? mibancoGreen
                  : mibancoYellow,

            ),

          ),

          title: Text(

            cliente.nombre,

            style: const TextStyle(

              fontWeight: FontWeight.bold,

              fontSize: 15,

              color: Color(0xFF2D3142),

            ),

          ),

          subtitle: Padding(

            padding: const EdgeInsets.only(
              top: 6.0,
            ),

            child: Row(

              children: [

                Text(

                  cliente.gestion,

                  style: const TextStyle(

                    fontSize: 12,

                    color: Colors.grey,

                  ),

                ),

                const SizedBox(width: 8),

                const Text(
                  "•",
                ),

                const SizedBox(width: 8),

                Text(

                  cliente.estado,

                  style: TextStyle(

                    fontSize: 12,

                    fontWeight: FontWeight.bold,

                    color: isVisitado
                        ? mibancoGreen
                        : Colors.orange,

                  ),

                ),

              ],

            ),

          ),

          trailing: const Icon(

            Icons.chevron_right_rounded,

            color: mibancoGreen,

          ),

        ),

      ),

    );

  }

  Widget _buildBottomNav() {

    return Container(

      decoration: BoxDecoration(

        boxShadow: [

          BoxShadow(

            color:
                Colors.black.withOpacity(0.1),

            blurRadius: 10,

          ),

        ],

      ),

      child: BottomNavigationBar(

        currentIndex: _selectedIndex,

        onTap: (index) {

          setState(() {

            _selectedIndex = index;

          });

        },

        type:
            BottomNavigationBarType.fixed,

        backgroundColor: Colors.white,

        selectedItemColor: mibancoGreen,

        unselectedItemColor:
            Colors.grey.shade400,

        selectedLabelStyle:
            const TextStyle(

          fontWeight: FontWeight.bold,

          fontSize: 12,

        ),

        items: const [

          BottomNavigationBarItem(

            icon: Icon(Icons.home_rounded),

            label: "Inicio",

          ),

          BottomNavigationBarItem(

            icon: Icon(
              Icons.assignment_ind_rounded,
            ),

            label: "Mi Cartera",

          ),

          BottomNavigationBarItem(

            icon: Icon(
              Icons.chat_bubble_outline_rounded,
            ),

            label: "Mensajes",

          ),

          BottomNavigationBarItem(

            icon: Icon(
              Icons.more_horiz_rounded,
            ),

            label: "Más",

          ),

        ],

      ),

    );

  }

}