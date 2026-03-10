import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:online_ezzy/core/utils/styles/colors.dart';

import 'widgets/shipment_app_bar.dart';
import 'widgets/shipment_filter_tabs.dart';
import 'widgets/shipment_search_bar.dart';
import 'widgets/shipment_list.dart';

class ShipmentView extends StatefulWidget {
  const ShipmentView({super.key});

  @override
  State<ShipmentView> createState() => _ShipmentViewState();
}

class _ShipmentViewState extends State<ShipmentView> {
  int _selectedTab = 1; // e.g. 1 = في المستودع as default

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyLight,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const ShipmentAppBar(),
            const SizedBox(height: 12),
            ShipmentFilterTabs(
              selectedIndex: _selectedTab,
              onChanged: (index) {
                setState(() => _selectedTab = index);
              },
            ),
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ShipmentSearchBar(),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ShipmentList(
                statusFilterIndex: _selectedTab,
              ),
            ),
          ],
        ),
      ),
   
    );
  }
}

