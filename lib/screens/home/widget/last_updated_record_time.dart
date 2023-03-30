import 'package:bloc_structure/core/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/home/home.dart';

class LastUpdatedRecordTime extends StatelessWidget {
  const LastUpdatedRecordTime({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (oldState, newState) =>
          newState != RefreshData() && newState is LastUpdateDataState,
      builder: (context, state) {
        if (state is GetLastUpdatedRecodeDate) {
          return Text(
            '$lastUpdatedOn ${state.timestamp}',
            style: const TextStyle(fontSize: 10),
          );
        } else if (state is LoadingForLastUpdatedRecodeDate) {
          return const SizedBox(
            width: 20,
            height: 20,
            child: Center(
                child: CircularProgressIndicator(
              color: Colors.green,
            )),
          );
        }
        return const Offstage();
      },
    );
  }
}
