class LLMResult {
  final String message;
  final bool isSuccess;

  LLMResult({
    required this.isSuccess,
    required this.message,
  });
}

abstract class LLMRepository {
  Future<LLMResult> sendMessage(String message);
}
