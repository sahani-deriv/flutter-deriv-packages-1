import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:update_checker/update_checker.dart';

class MockFirebaseDatabaseRepository extends Mock
    implements FirebaseDatabaseRepository {}

class MockPackageInfoRepository extends Mock implements PackageInfoRepository {}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  group('Update bloc', () {
    MockFirebaseDatabaseRepository mockFirebaseDatabaseRepository;
    MockPackageInfoRepository mockPackageInfoRepository;

    setUp(() {
      mockFirebaseDatabaseRepository = MockFirebaseDatabaseRepository();
      mockPackageInfoRepository = MockPackageInfoRepository();
    });

    final UpdateInfo updateInfoOptional = UpdateInfo(
      buildNumber: 2,
      isOptional: true,
      changelog: '',
      changelogs: null,
      url: '',
    );

    final UpdateInfo updateInfoMandatory = UpdateInfo(
      buildNumber: 2,
      isOptional: false,
      changelog: '',
      changelogs: null,
      url: '',
    );

    blocTest(
      'should emit UpdateInitialState as initial state',
      build: () {
        when(mockFirebaseDatabaseRepository.fetchUpdateData())
            .thenAnswer((_) async => null);
        when(mockPackageInfoRepository.getAppBuildNumber())
            .thenAnswer((_) async => 1);
        return UpdateBloc(
          firebaseDatabaseRepository: mockFirebaseDatabaseRepository,
          packageInfoRepository: mockPackageInfoRepository,
        );
      },
      act: (UpdateBloc bloc) => bloc.add(UpdateFetchEvent()),
      expect: [
        // UpdateInitialState(),
        UpdateInProgressState(),
        UpdateNotAvailableState(),
      ],
    );
  });
}
