// import 'package:diary_flutter/common/enums.dart';
// import 'package:diary_flutter/presentation/common/router.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:palestine_console/palestine_console.dart';

// FeedbackType? useFeedbackType(WidgetRef ref) {
//   final feedbackTypeState = useState<FeedbackType?>(null);

//   useEffect(() {
//     void updateFeedbackType() {
//       final router = ref.read(routerProvider);
//       final queryParams =
//           router.routeInformationProvider.value.uri.queryParameters;
//       final feedbackTypeString =
//           queryParams[QueryParameterKeys.feedbackType.value];
//       Print.green(feedbackTypeString ?? 'null');

//       if (feedbackTypeString != null) {
//         try {
//           feedbackTypeState.value =
//               getFeedbackTypeFromString(feedbackTypeString);
//         } catch (e) {
//           // 파싱 오류 시 null로 설정하지 않고 이전 값을 유지
//           Print.red('Error parsing feedback type: $e');
//         }
//       }
//       // feedbackTypeString이 null이더라도 이전 값을 유지
//     }

//     // 초기 실행
//     updateFeedbackType();

//     // 리스너 설정
//     final routeInformationProvider =
//         ref.read(routerProvider).routeInformationProvider;
//     routeInformationProvider.addListener(updateFeedbackType);

//     // cleanup 함수 반환
//     return () {
//       routeInformationProvider.removeListener(updateFeedbackType);
//     };
//   }, []);

//   return feedbackTypeState.value;
// }
