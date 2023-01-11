import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final WidgetBuilder builder;

  // optional
  final bool showProgressIndicator;
  final bool isLoading;
  final bool isProgressing;

  //0.0-1.0
  final double progressOpacity;

  const LoadingWidget({
    Key? key,
    required this.builder,
    this.showProgressIndicator = true,
    this.isLoading = false,
    this.isProgressing = false,
    this.progressOpacity = 0.4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const _Loading()
        : Stack(
            children: [
              builder(context),
              if (isProgressing)
                Opacity(
                  opacity: progressOpacity,
                  child: AbsorbPointer(
                    absorbing: true,
                    child: _Loading(showIndicator: showProgressIndicator),
                  ),
                )
            ],
          );
  }
}

class _Loading extends StatelessWidget {
  final bool showIndicator;

  const _Loading({this.showIndicator = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: showIndicator
          ? const Center(
              child: CupertinoActivityIndicator(radius: 15),
            )
          : const SizedBox.expand(),
    );
  }
}
