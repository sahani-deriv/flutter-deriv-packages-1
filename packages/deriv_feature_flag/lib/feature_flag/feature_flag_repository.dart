import 'package:flutter/material.dart';

import 'package:deriv_feature_flag/growthbook/deriv_growth_book.dart';
import 'package:growthbook_sdk_flutter/growthbook_sdk_flutter.dart';

/// Service that provides feature flag functionality for us.
class FeatureFlagRepository {
  /// Getter for the instance
  factory FeatureFlagRepository.getInstance() => _instance;

  // Private constructor
  FeatureFlagRepository._();

  // Singleton instance
  static final FeatureFlagRepository _instance = FeatureFlagRepository._();

  // Growth Book SDK instance.
  late final GrowthBookSDK _growthBookSDK;

  /// initialize the GrowthBook sdk instance.
  Future<void> setup({required DerivGrowthBook derivGrowthBook}) async {
    _growthBookSDK = await derivGrowthBook.initializeSDK();
  }

  /// get the feature flags value from the sdk.
  bool isFeatureOn(String key, {bool defaultValue = false}) =>
      _growthBookSDK.feature(key).on ?? defaultValue;

  @visibleForTesting
  GrowthBookSDK get growthBookSDK => _growthBookSDK;
}