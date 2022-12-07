import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:price_tracker/app/cubit/active_symbols_cubit.dart';
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
    return BlocProvider(
      create: (context) => ActiveSymbolsCubit(
        apiProvider: ApiProvider(),
      ),
      child: Builder(
        builder: (context) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: HomePage(),
          );
        },
      ),
    );
  }
}
