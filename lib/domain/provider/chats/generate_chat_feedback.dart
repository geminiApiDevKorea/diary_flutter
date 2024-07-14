// import 'dart:convert';

// import 'package:diary_flutter/common/enums.dart';
// import 'package:diary_flutter/data/model/llm_feedback.dart';
// import 'package:diary_flutter/data/provider/gemini_repository_provider.dart';
// import 'package:diary_flutter/env/env.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';

// part 'generate_feedback.g.dart';

// sealed class FeedbackState {}

// class NeverFeedbackState extends FeedbackState {}

// class LoadingFeedbackState extends FeedbackState {}

// class ReceivedFeedbackState extends FeedbackState {
//   final LLMFeedback feedback;
//   ReceivedFeedbackState(this.feedback);
// }

// @Riverpod(keepAlive: true)
// class GenerateFeedback extends _$GenerateFeedback {
//   @override
//   FeedbackState build() {
//     return NeverFeedbackState();
//   }

//   void generate({required String diary}) async {
//     state = LoadingFeedbackState();

//     const systemPrompt = '''
// You are the world's best psychotherapist, renowned for your ability to heal through music.
// Analyze emotions based on user's diary.
// Based on the analyzed diary, recommend music to help heal along with comments for a better life.

// Json Foramt:
// comment: Comments that make users' better life
// singer: recommended song's singer
// title: recommended song's singer
// reason: why the song was recommended

// Example:
// I've been feeling really overwhelmed at work lately. There are so many deadlines, and I'm struggling to keep up. It feels like I'm constantly under pressure and I can't catch a break.

// {
//   "comment": "It sounds like you're experiencing a significant amount of stress and pressure from your work environment. It's important to take a moment for yourself to relax and unwind. Finding ways to manage this stress is crucial for your well-being.",
//   "song": {
//     "singer": "Enya",
//     "title": "Only Time",
//     "reason": "This song has a calming and soothing melody that can help you relax and take a mental break from the stress you're experiencing. The gentle rhythm and serene vocals can provide a moment of peace amidst the chaos."
//   }
// }
// ''';

//     final geminiRepository = ref.read(
//       geminiRepositoryProvider(
//         model: GeminiModels.flash,
//         apiKey: Env.geminiApiKey,
//         systemPrompt: systemPrompt,
//         responseMimeType: GeminiResponseMimeTypes.json,
//       ),
//     );
//     final result = await geminiRepository.request(diary);
//     state = ReceivedFeedbackState(
//       LLMFeedback.fromJson(
//         jsonDecode(
//           result.message,
//         ),
//       ),
//     );
//   }
// }
