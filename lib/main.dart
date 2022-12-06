import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:price_tracker/app/cubit/active_symbols_cubit.dart';
import 'package:price_tracker/app/data/providers/api_provider.dart';
import 'package:price_tracker/app/data/repositories/api_repository.dart';
import 'package:price_tracker/app/ui/pages/home_page.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RepositoryProvider(
        create: (_) => ApiRepository(apiProvider: ApiProvider()),
        child: BlocProvider(
          create: (context) => ActiveSymbolsCubit(
            apiRepository: context.read<ApiRepository>(),
          ),
          child: Builder(
            builder: (context) {
              context.watch<ActiveSymbolsCubit>().getActiveSymbolRequest();
              return const HomePage();
            },
          ),
        ),
      ),
    ),
  );
}
