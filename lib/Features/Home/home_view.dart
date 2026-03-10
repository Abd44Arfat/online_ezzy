import 'package:flutter/material.dart';
import 'package:online_ezzy/core/utils/styles/colors.dart';
import 'package:online_ezzy/Features/Cart/cart_view.dart';
import 'package:online_ezzy/Features/Shipment/shipment_view.dart';

import 'widgets/home_app_bar.dart';
import 'widgets/home_bottom_nav_bar.dart';
import 'widgets/home_quick_actions.dart';
import 'widgets/home_promo_banner.dart';
import 'widgets/home_active_shipments_section.dart';
import 'widgets/home_track_shipment_section.dart';
import 'widgets/home_warehouse_section.dart';
import 'widgets/home_plans_section.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyLight,
      bottomNavigationBar: HomeBottomNavBar(
        currentIndex: _currentIndex,
        onTabSelected: (index) {
          setState(() => _currentIndex = index);
        },
      ),
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          children: [
            _buildHomeTab(context),
            CartView(onBack: () => setState(() => _currentIndex = 0)),
            const ShipmentView(),
            const Center(child: Text('Profile (placeholder)')),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeTab(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                HomeAppBar(),
                SizedBox(height: 16),
                HomeQuickActions(),
                SizedBox(height: 16),
                HomePromoBanner(),
                SizedBox(height: 16),
                HomeActiveShipmentsSection(),
                SizedBox(height: 16),
                HomeTrackShipmentSection(),
                SizedBox(height: 16),
                HomeWarehouseSection(),
                SizedBox(height: 16),
                HomePlansSection(),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

