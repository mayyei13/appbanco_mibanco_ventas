import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodel/home_viewmodel.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int currentIndex = 0;
  static const Color mibancoGreen = Color(0xFF00A859);
  static const Color mibancoYellow = Color(0xFFFFD100);

  @override
  Widget build(BuildContext context) {
    final homeVM = Provider.of<HomeViewModel>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F2),
      appBar: AppBar(
        backgroundColor: mibancoGreen,
        elevation: 0,
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.white24,
            child: Icon(Icons.person, color: Colors.white, size: 20),
          ),
        ),
        title: const Text("Hola, Maylit", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(icon: const Icon(Icons.qr_code_scanner, color: Colors.white), onPressed: () {}),
          IconButton(icon: const Icon(Icons.notifications_none, color: Colors.white), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // HEADER CON ACCIONES RÁPIDAS PRINCIPALES
            _buildHeaderActions(),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SECCIÓN DE CUENTAS
                  _buildSectionTitle("Mis Cuentas", "Ver todas"),
                  const SizedBox(height: 12),
                  _buildAccountCard("Ahorro Corriente Soles", "S/ ${homeVM.account.savingsBalance}", "402-***-234"),
                  
                  const SizedBox(height: 25),

                  // SECCIÓN DE OPERACIONES (GRID DE BOTONES)
                  const Text("Operaciones", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 15),
                  _buildOperationsGrid(),

                  const SizedBox(height: 25),

                  // BANNER DE PRÉSTAMO (ESTILO MIBANCO)
                  _buildLoanBanner("¡Tienes un préstamo aprobado!", "Solicítalo ahora hasta por S/ 30,000"),

                  const SizedBox(height: 25),

                  // SECCIÓN DE OTROS SERVICIOS
                  const Text("Otros servicios", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  _buildOtherServices(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // --- COMPONENTES VISUALES ---

  Widget _buildHeaderActions() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: mibancoGreen,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
      ),
      padding: const EdgeInsets.only(bottom: 30, left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildTopCircleBtn(Icons.send_to_mobile, "Yapear"),
          _buildTopCircleBtn(Icons.swap_horiz, "Transferir"),
          _buildTopCircleBtn(Icons.receipt_long, "Pagar Servicios"),
          _buildTopCircleBtn(Icons.attach_money, "Cambio Sol/Dol"),
        ],
      ),
    );
  }

  Widget _buildTopCircleBtn(IconData icon, String label) {
    return Column(
      children: [
        Container(
          height: 55, width: 55,
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
          child: Icon(icon, color: Colors.white, size: 28),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildOperationsGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      mainAxisSpacing: 20,
      children: [
        _buildGridItem(Icons.phone_android, "Recargas"),
        _buildGridItem(Icons.security, "Seguros"),
        _buildGridItem(Icons.credit_card, "Mis Tarjetas"),
        _buildGridItem(Icons.trending_up, "Inversiones"),
        _buildGridItem(Icons.store, "Mis Negocios"),
        _buildGridItem(Icons.help_outline, "Ayuda"),
        _buildGridItem(Icons.location_on_outlined, "Agentes"),
        _buildGridItem(Icons.more_horiz, "Ver más"),
      ],
    );
  }

  Widget _buildGridItem(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: mibancoGreen, size: 30),
        const SizedBox(height: 5),
        Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 11, color: Colors.black87)),
      ],
    );
  }

  Widget _buildAccountCard(String title, String balance, String number) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.grey, fontSize: 13)),
              const SizedBox(height: 5),
              Text(balance, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: mibancoGreen)),
              Text(number, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
          const Icon(Icons.arrow_forward_ios, size: 16, color: mibancoGreen),
        ],
      ),
    );
  }

  Widget _buildLoanBanner(String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF006D32), mibancoGreen]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Icon(Icons.stars, color: mibancoYellow, size: 40),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                Text(subtitle, style: const TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOtherServices() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildSquareBtn(Icons.health_and_safety, "Seguro de Salud"),
          _buildSquareBtn(Icons.directions_car, "Seguro Vehicular"),
          _buildSquareBtn(Icons.home_work, "Crédito Hipotecario"),
        ],
      ),
    );
  }

  Widget _buildSquareBtn(IconData icon, String label) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          Icon(icon, color: mibancoGreen),
          const SizedBox(height: 10),
          Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, String link) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(link, style: const TextStyle(color: mibancoGreen, fontWeight: FontWeight.bold, fontSize: 14)),
      ],
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: mibancoGreen,
      unselectedItemColor: Colors.grey,
      currentIndex: currentIndex,
      onTap: (index) => setState(() => currentIndex = index),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Inicio"),
        BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: "Cuentas"),
        BottomNavigationBarItem(icon: Icon(Icons.qr_code_2), label: "Yape"),
        BottomNavigationBarItem(icon: Icon(Icons.star), label: "Para ti"),
        BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Menú"),
      ],
    );
  }
}