import 'package:bloc_structure/blocs/home/home.dart';
import 'package:bloc_structure/core/app_string.dart';
import 'package:bloc_structure/core/network/network_provider.dart';
import 'package:bloc_structure/data/model/user.dart';
import 'package:bloc_structure/data/repository/user/user_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_bloc_test.mocks.dart';



@GenerateMocks([UserRepository, NetworkProvider])
void main() {
  late MockUserRepository mockUserRepository;
  late MockNetworkProvider mockNetworkProvider;
  int oldTimeStamp = 120;
  List<User> testLocalUser = [
    User(
        name: Name.fromString('Mr Nikhil Vadoliya'),
        phone: '90806043423',
        email: 'nikhil.va@gmail.com',
        gender: 'male')
  ];
  List<User> testRemoteUser = [
    User(
        name: Name.fromString('Mr Nikhil Vadoliya-Remote'),
        phone: '90806043423',
        email: 'nikhil.va@gmail-remote.com',
        gender: 'male')
  ];
  List<User> emptyLocalUser = [];

  setUpAll(() {
    mockUserRepository = MockUserRepository();
    mockNetworkProvider = MockNetworkProvider();
  });

  blocTest<HomeBloc, HomeState>('No Internet Connection and Few Data in Local DB',
      setUp: () {
        when(mockNetworkProvider.hasInternetConnection())
            .thenAnswer((realInvocation) => Future.value(false));
        when(mockUserRepository.getUsersFromLocal()).thenAnswer((_) => Future.value(testLocalUser));
      },
      build: () => HomeBloc(mockUserRepository, mockNetworkProvider),
      act: (bloc) => bloc.add(GetUserData()),
      wait: const Duration(seconds: 1),
      tearDown: () {
        //  reset(mockUserRepository);
        // reset(mockNetworkProvider);
      },
      expect: () => [Loading(), GetUser(testLocalUser)]);

  blocTest<HomeBloc, HomeState>('No Internet Connection and Empty Data in Local DB',
      setUp: () {
        when(mockNetworkProvider.hasInternetConnection())
            .thenAnswer((realInvocation) => Future.value(false));
        when(mockUserRepository.getUsersFromLocal())
            .thenAnswer((_) => Future.value(emptyLocalUser));
      },
      wait: const Duration(seconds: 1),
      build: () => HomeBloc(mockUserRepository, mockNetworkProvider),
      act: (bloc) => bloc.add(GetUserData()),
      expect: () {
        return [Loading(), const Error(notDataFound)];
      });

  blocTest<HomeBloc, HomeState>('Internet Connection and Remote Data ',
      setUp: () {
        when(mockNetworkProvider.hasInternetConnection())
            .thenAnswer((realInvocation) => Future.value(true));
        when(mockUserRepository.getUsersFromLocal()).thenAnswer((_) => Future.value(testLocalUser));
        when(mockUserRepository.getRemoteUser()).thenAnswer((_) => Future.value(testRemoteUser));
        when(mockUserRepository.addListOfUserInLocal(testRemoteUser)).thenAnswer((_) {
          testLocalUser.addAll(testRemoteUser);
          return Future.value();
        });
        when(mockUserRepository.deleteAllUsersFromLocal()).thenAnswer((_) {
          testLocalUser.clear();
          return Future.value(0);
        });
        when(mockUserRepository.getLatestResponseTimeStamp()).thenAnswer((_) {
          testLocalUser.clear();
          return Future.value(0);
        });
        when(mockUserRepository.getLatestResponseTimeStamp())
            .thenAnswer((realInvocation) => Future.value(oldTimeStamp));
      },
      wait: const Duration(seconds: 1),
      build: () => HomeBloc(mockUserRepository, mockNetworkProvider),
      act: (bloc) => bloc.add(GetUserData()),
      expect: () {
        return [
          Loading(),
          GetUser(testLocalUser),
          LoadingForLastUpdatedRecodeDate(),
          GetLastUpdatedRecodeDate(oldTimeStamp),
          GetUser(testRemoteUser),
          RefreshData()
        ];
      });
}
