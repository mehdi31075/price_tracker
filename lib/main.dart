import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:price_tracker/app/cubit/active_symbols_cubit.dart';
import 'package:price_tracker/app/cubit/symbol_ticks_cubit.dart';
import 'package:price_tracker/app/data/providers/api_provider.dart';
import 'package:price_tracker/app/ui/pages/home_page.dart';

void main() {
  runApp(
    const _MyApp(),
  );
}

class _MyApp extends StatelessWidget {
  const _MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final apiProvider = ApiProvider();
    return MultiBlocProvider(
      providers: [
        BlocProvider<ActiveSymbolsCubit>(
          create: (context) => ActiveSymbolsCubit(
            apiProvider: apiProvider,
          ),
        ),
        BlocProvider<SymbolTicksCubit>(
          create: (context) => SymbolTicksCubit(
            apiProvider: apiProvider,
          ),
        ),
      ],
      child: Builder(
        builder: (context) {
          context.read<ActiveSymbolsCubit>().getActiveSymbolRequest();

          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: HomePage(),
          );
        },
      ),
    );
  }
}
