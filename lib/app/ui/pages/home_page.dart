import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:price_tracker/app/cubit/active_symbols_cubit.dart';
import 'package:price_tracker/app/data/models/active_symbol.dart';
import 'package:price_tracker/app/ui/global_widgets/custom_dropdown.dart';
import 'package:price_tracker/app/ui/global_widgets/loading_widget.dart';
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
      body: BlocBuilder<ActiveSymbolsCubit, GetActiveSymbolsState>(
        bloc: context.watch<ActiveSymbolsCubit>(),
        builder: (context, blocState) {
          if (blocState is GetActiveSymbolsLoadingState) {
            return const Center(child: LoadingWidget());
          } else if (blocState is GetActiveSymbolsSuccessState) {
            return _SuccessWidget(successBlocState: blocState);
          }
          return Container();
        },
      ),
    );
  }
}

class _SuccessWidget extends StatelessWidget {
  const _SuccessWidget({
    required this.successBlocState,
    Key? key,
  }) : super(key: key);

  final GetActiveSymbolsSuccessState successBlocState;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppSizes.defaultPadding),
      child: Column(
        children: [
          CustomDropDown<String>(
            hint: AppStrings.selectMarketHint,
            items: successBlocState.markets
                .map(
                  (market) => DropdownMenuItem<String>(
                    child: Text(market),
                  ),
                )
                .toList(),
          ),
          SizedBox(height: AppSizes.defaultPadding),
          CustomDropDown<ActiveSymbol>(
            hint: AppStrings.selectAssetHint,
            items: successBlocState.activeSymbols
                .map(
                  (symbol) => DropdownMenuItem<ActiveSymbol>(
                    child: Text(symbol.displayName ?? ''),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
