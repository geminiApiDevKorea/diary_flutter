class GenerativeResult {
  final String message;
  final bool isSuccess;

  GenerativeResult({
    required this.isSuccess,
    required this.message,
  });
}

abstract class LLMRepository {
  Future<GenerativeResult> request(String input);
}
