import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:price_tracker/app/cubit/active_symbols_cubit.dart';
import 'package:price_tracker/app/cubit/symbol_ticks_cubit.dart';
import 'package:price_tracker/app/data/models/active_symbol.dart';
import 'package:price_tracker/app/ui/global_widgets/custom_dropdown.dart';
import 'package:price_tracker/app/ui/global_widgets/loading_widget.dart';
import 'package:price_tracker/app/ui/theme/app_colors.dart';
import 'package:price_tracker/app/ui/theme/app_sizes.dart';
import 'package:price_tracker/app/ui/utils/app_strings.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.appName),
        elevation: 1,
        centerTitle: true,
      ),
      body: BlocBuilder<SymbolTicksCubit, GetSymbolTicksState>(
        bloc: context.read<SymbolTicksCubit>(),
        builder: (contex, symbolTicksBlocState) {
          return BlocBuilder<ActiveSymbolsCubit, GetActiveSymbolsState>(
            bloc: context.read<ActiveSymbolsCubit>(),
            builder: (context, activeSymbolsBlocState) {
              final activeSymbolsBloc = BlocProvider.of<ActiveSymbolsCubit>(context);
              final symbolTicksBloc = BlocProvider.of<SymbolTicksCubit>(context);
              if (activeSymbolsBlocState is GetActiveSymbolsLoadingState) {
                return const Center(child: LoadingWidget());
              } else if (activeSymbolsBlocState is GetActiveSymbolsSuccessState) {
                return _SuccessWidget(
                  activeSymbolsBlocState: activeSymbolsBlocState,
                  symbolTicksBlocState: symbolTicksBlocState,
                  onSelectMarket: (market) {
                    activeSymbolsBloc.selectMarket(market);
                  },
                  onSelectAsset: (asset) {
                    activeSymbolsBloc.selectAsset(symbolTicksBloc, asset);
                  },
                );
              }
              return Container();
            },
          );
        },
      ),
    );
  }
}

class _SuccessWidget extends StatelessWidget {
  const _SuccessWidget({
    required this.activeSymbolsBlocState,
    required this.symbolTicksBlocState,
    required this.onSelectMarket,
    required this.onSelectAsset,
    Key? key,
  }) : super(key: key);

  final GetActiveSymbolsSuccessState activeSymbolsBlocState;
  final GetSymbolTicksState symbolTicksBlocState;
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
            value: activeSymbolsBlocState.selectedMarket,
            items: activeSymbolsBlocState.markets
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
            value: activeSymbolsBlocState.selectedAsset,
            items: activeSymbolsBlocState.activeSymbols
                .map(
                  (symbol) => DropdownMenuItem<ActiveSymbol>(
                    value: symbol,
                    child: Text(symbol.displayName ?? ''),
                  ),
                )
                .toList(),
            onChanged: (asset) => onSelectAsset(asset),
          ),
          SizedBox(height: AppSizes.defaultPadding),
          Expanded(
            child: Center(
              child: Builder(
                builder: (context) {
                  if (symbolTicksBlocState is GetSymbolTicksLoadingState) {
                    return const LoadingWidget();
                  } else if (symbolTicksBlocState is GetSymbolTicksSuccessState) {
                    final state = symbolTicksBlocState as GetSymbolTicksSuccessState;
                    final tick = state.symbolTick;
                    return Text(
                      tick?.quote.toString() ?? '',
                      style: TextStyle(
                        fontSize: 24,
                        color: state.diff > 0
                            ? AppColors.dangerColor
                            : state.diff < 0
                                ? AppColors.successColor
                                : AppColors.txtBodyColor,
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
