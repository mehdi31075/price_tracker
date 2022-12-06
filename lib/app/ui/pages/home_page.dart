import 'package:flutter/material.dart';
import 'package:price_tracker/app/ui/global_widgets/custom_dropdown.dart';
import 'package:price_tracker/app/ui/theme/app_sizes.dart';
import 'package:price_tracker/app/ui/utils/app_strings.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.appName),
        elevation: 1,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(AppSizes.defaultPadding),
        child: Column(
          children: [
            CustomDropDown<String>(
              hint: AppStrings.selectMarketHint,
              items: [],
            ),
            SizedBox(height: AppSizes.defaultPadding),
            CustomDropDown<String>(
              hint: AppStrings.selectAssetHint,
              items: [],
            ),
          ],
        ),
      ),
    );
  }
}
