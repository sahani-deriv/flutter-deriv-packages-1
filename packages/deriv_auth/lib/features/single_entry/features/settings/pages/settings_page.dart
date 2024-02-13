import 'package:deriv_auth/deriv_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_deriv_api/services/connection/api_manager/connection_information.dart';
import 'package:flutter_deriv_api/state/connection/connection_cubit.dart';

/// Setting page
class SettingsPage extends StatefulWidget {
  /// Constructor for setting page
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) => DerivSettingLayout(
        updateFlavorConfigs: _updateFlavorConfigs(),
        appLabel: 'blanc',
        saveValues: _saveValues,
        appId: PrefService.getString('appId') ?? defaultAppId,
        endpoint: PrefService.getString('endpoint') ?? defaultEndpoint,
      );
  Future<void> _saveValues({
    required String endpoint,
    required String appId,
  }) async {
    await PrefService.setString('endpoint', endpoint);
    await PrefService.setString('appId', appId);
  }

  Future<void> _updateFlavorConfigs() async {
    final authEndpoint = generateEndpointUrl(
          endpoint: PrefService.getString('endpoint'),
          isAuthUrl: true,
        ) ??
        defaultAuthEndpoint;

    final endpoint =
        generateEndpointUrl(endpoint: PrefService.getString('endpoint')) ??
            defaultEndpoint;

    FlavorConfig.instance.copyWith(
      FlavorValues(
        endPoint: endpoint,
        authEndPoint: authEndpoint,
        appId: PrefService.getString('appId')!,
      ),
    );

    await BlocProvider.of<ConnectionCubit>(context).reconnect(
      connectionInformation: ConnectionInformation(
        appId: FlavorConfig.instance.flavorValues.appId,
        brand: 'deriv',
        endpoint: FlavorConfig.instance.flavorValues.endPoint!,
        authEndpoint: FlavorConfig.instance.flavorValues.authEndPoint!,
      ),
    );
  }
}
