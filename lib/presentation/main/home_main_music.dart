import 'package:diary_flutter/data/repository/chats_repository.dart';
import 'package:diary_flutter/domain/provider/query_youtube_music_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeMainMusic extends ConsumerStatefulWidget {
  final ChatsContent feedback;
  const HomeMainMusic({
    super.key,
    required this.feedback,
  });

  @override
  ConsumerState<HomeMainMusic> createState() => _HomeMainMusicState();
}

class _HomeMainMusicState extends ConsumerState<HomeMainMusic> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref
          .watch(queryYoutubeMusicProvider.notifier)
          .request(query: widget.feedback.queryString);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(queryYoutubeMusicProvider);
    if (state is LoadingQueryYoutubeMusicState) {
      return const CircularProgressIndicator();
    } else if (state is SuccessQueryYoutubeMusicState) {
      return GestureDetector(
        onTap: () async {
          await launchUrl(Uri.parse(state.item.videoUrl));
        },
        child: Image.network(state.item.thumbnailUrl),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
