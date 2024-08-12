import 'package:diary_flutter/common/enums.dart';
import 'package:diary_flutter/data/provider/users_repository_provider.dart';
import 'package:diary_flutter/data/repository/users_repository.dart';
import 'package:diary_flutter/domain/provider/auth/get_my_id_token.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'agreement_notifier.g.dart';

sealed class AgreementState {
  final Map<AgreementType, bool> agreements;

  bool isChecked(AgreementType agreementType) =>
      agreements[agreementType] ?? false;
  bool get isAllAgreed => agreements.values.every((isAgreed) => isAgreed);

  bool get isAllRequiredAgreed => agreements.entries
      .where((entry) => entry.key.isRequired)
      .every((entry) => entry.value);

  AgreementState({required this.agreements});
}

class AgreementedState extends AgreementState {
  final bool isAgreed;
  AgreementedState({
    required super.agreements,
    required this.isAgreed,
  });
}

class SelectionAgreementState extends AgreementState {
  SelectionAgreementState({
    required super.agreements,
  });

  SelectionAgreementState copyWith(AgreementType type, bool newValue) {
    return SelectionAgreementState(
      agreements: agreements.map(
        (key, val) =>
            key == type ? MapEntry(key, newValue) : MapEntry(key, val),
      ),
    );
  }
}

@riverpod
class AgreementNotifier extends _$AgreementNotifier {
  @override
  AgreementState build() {
    return SelectionAgreementState(agreements: {
      AgreementType.termsOfService: false,
      AgreementType.privacyPolicy: false,
    });
  }

  void toggleAllAgreements() {
    var agreementState = state;
    if (agreementState is SelectionAgreementState) {
      final newValue = !agreementState.isAllAgreed;
      state = SelectionAgreementState(
        agreements: agreementState.agreements.map(
          (key, _) => MapEntry(key, newValue),
        ),
      );
    }
  }

  void toggleAgreement(AgreementType agreementType) {
    var agreementState = state;
    if (agreementState is SelectionAgreementState) {
      final newValue = !agreementState.isChecked(agreementType);
      state = agreementState.copyWith(agreementType, newValue);
    }
  }

  agree() async {
    try {
      final idToken = ref.read(getMyIdTokenProvider);
      final response =
          await ref.read(usersRepositoryProvider).putUsersAgreement(
                bearerToken: 'Bearer $idToken',
                body: UsersAgreementBody(agreement: true),
              );
      state = AgreementedState(
        agreements: state.agreements,
        isAgreed: response.isAgreed,
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
