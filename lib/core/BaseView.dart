import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Locator.dart';

class BaseView<T extends ChangeNotifier> extends StatefulWidget {
  final Widget Function(BuildContext context, T viewModel, Widget? child)
      builder;
  final Function(T viewModel) onModelReady;

  BaseView({required this.builder, required this.onModelReady});

  @override
  State<StatefulWidget> createState() => BaseViewState<T>();
}

class BaseViewState<T extends ChangeNotifier> extends State<BaseView<T>> {
  T viewModel = getIt<T>();

  @override
  void initState() {
    widget.onModelReady(viewModel);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Consumer<T>(
        builder: widget.builder,
      ),
    );
  }
}
