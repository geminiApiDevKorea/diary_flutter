import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'agreement_notifier.g.dart';

enum AgreementType {
  termsOfService,
  privacyPolicy,
}

extension AgreementTypeExtension on AgreementType {
  String get title {
    switch (this) {
      case AgreementType.termsOfService:
        return 'Terms of Service';
      case AgreementType.privacyPolicy:
        return 'Privacy Policy';
    }
  }

  bool get isRequired {
    switch (this) {
      case AgreementType.termsOfService:
      case AgreementType.privacyPolicy:
        return true;
    }
  }

  String get url {
    switch (this) {
      case AgreementType.termsOfService:
        return 'https://example.com/terms';
      case AgreementType.privacyPolicy:
        return 'https://example.com/privacy';
    }
  }
}

class AgreementState {
  final Map<AgreementType, bool> agreements;
  bool isChecked(AgreementType agreementType) =>
      agreements[agreementType] ?? false;
  bool get isAllAgreed => agreements.values.every((isAgreed) => isAgreed);

  bool get isAllRequiredAgreed => agreements.entries
      .where((entry) => entry.key.isRequired)
      .every((entry) => entry.value);

  AgreementState({required this.agreements});

  AgreementState copyWith(AgreementType type, bool newValue) {
    return AgreementState(
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
    return AgreementState(agreements: {
      AgreementType.termsOfService: false,
      AgreementType.privacyPolicy: false,
    });
  }

  void toggleAllAgreements() {
    final newValue = !state.isAllAgreed;
    state = AgreementState(
      agreements: state.agreements.map(
        (key, _) => MapEntry(key, newValue),
      ),
    );
  }

  void toggleAgreement(AgreementType agreementType) {
    final newValue = !state.isChecked(agreementType);
    state = state.copyWith(agreementType, newValue);
  }
}
