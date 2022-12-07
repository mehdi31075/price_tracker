import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:price_tracker/app/cubit/active_symbols_cubit.dart';
import 'package:price_tracker/app/data/models/active_symbol.dart';
import 'package:price_tracker/app/ui/global_widgets/custom_dropdown.dart';
import 'package:price_tracker/app/ui/global_widgets/loading_widget.dart';
import 'package:price_tracker/app/ui/theme/app_sizes.dart';
import 'package:price_tracker/app/ui/utils/app_strings.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selectedMarket;
  String? selectedAsset;

  @override
  void initState() {
    context.read<ActiveSymbolsCubit>().getActiveSymbolRequest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.appName),
        elevation: 1,
        centerTitle: true,
      ),
      body: BlocBuilder<ActiveSymbolsCubit, GetActiveSymbolsState>(
        bloc: context.read<ActiveSymbolsCubit>(),
        builder: (context, blocState) {
          final bloc = BlocProvider.of<ActiveSymbolsCubit>(context);
          if (blocState is GetActiveSymbolsLoadingState) {
            return const Center(child: LoadingWidget());
          } else if (blocState is GetActiveSymbolsSuccessState) {
            return _SuccessWidget(
              state: blocState,
              onSelectMarket: (market) {
                bloc.selectMarket(market);
              },
              onSelectAsset: (asset) {
                bloc.selectAsset(asset);
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}

class _SuccessWidget extends StatelessWidget {
  const _SuccessWidget({
    required this.state,
    required this.onSelectMarket,
    required this.onSelectAsset,
    Key? key,
  }) : super(key: key);

  final GetActiveSymbolsSuccessState state;
  final Function(String) onSelectMarket;
  final Function(ActiveSymbol) onSelectAsset;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppSizes.defaultPadding),
      child: Column(
        children: [
          CustomDropDown<String>(
            hint: AppStrings.selectMarketHint,
            value: state.selectedMarket,
            items: state.markets
                .map(
                  (market) => DropdownMenuItem<String>(
                    value: market,
                    child: Text(market),
                  ),
                )
                .toList(),
            onChanged: (market) => onSelectMarket(market),
          ),
          SizedBox(height: AppSizes.defaultPadding),
          CustomDropDown<ActiveSymbol>(
            hint: AppStrings.selectAssetHint,
            value: state.selectedAsset,
            items: state.activeSymbols
                .map(
                  (symbol) => DropdownMenuItem<ActiveSymbol>(
                    value: symbol,
                    child: Text(symbol.displayName ?? ''),
                  ),
                )
                .toList(),
            onChanged: (asset) => onSelectAsset(asset),
          ),
        ],
      ),
    );
  }
}
