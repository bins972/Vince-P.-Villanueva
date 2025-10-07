import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:audioplayers/audioplayers.dart';

class MediaPlayerScreen extends StatefulWidget {
  const MediaPlayerScreen({super.key});

  @override
  State<MediaPlayerScreen> createState() => _MediaPlayerScreenState();
}

class _MediaPlayerScreenState extends State<MediaPlayerScreen> {
  late VideoPlayerController _videoController;
  ChewieController? _chewieController;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.networkUrl(Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'));
    _videoController.initialize().then((_) {
      _chewieController = ChewieController(
        videoPlayerController: _videoController,
        autoPlay: false,
        looping: false,
      );
      setState(() {});
    });
  }

  @override
  void dispose() {
    _chewieController?.dispose();
    _videoController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Video + Audio Player')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('10 + 11) Video with controls (Chewie):'),
            const SizedBox(height: 8),
            AspectRatio(
              aspectRatio: _videoController.value.isInitialized ? _videoController.value.aspectRatio : 16 / 9,
              child: _chewieController != null && _chewieController!.videoPlayerController.value.isInitialized
                  ? Chewie(controller: _chewieController!)
                  : const Center(child: CircularProgressIndicator()),
            ),
            const SizedBox(height: 24),
            const Text('12 + 19) Audio player controls:'),
            const SizedBox(height: 8),
            Row(
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Play'),
                  onPressed: () async {
                    if (kIsWeb) {
                      // On web, prefer a known-compatible MP3 URL to avoid asset 404s and codec issues
                      await _audioPlayer.play(
                        UrlSource(
                          'https://interactive-examples.mdn.mozilla.net/media/cc0-audio/t-rex-roar.mp3',
                        ),
                      );
                    } else {
                      try {
                        await _audioPlayer.play(AssetSource('audio/hotel_music.mp3'));
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Playing web-safe sample stream')),
                        );
                        await _audioPlayer.play(
                          UrlSource(
                            'https://interactive-examples.mdn.mozilla.net/media/cc0-audio/t-rex-roar.mp3',
                          ),
                        );
                      }
                    }
                  },
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  icon: const Icon(Icons.pause),
                  label: const Text('Pause'),
                  onPressed: () async {
                    await _audioPlayer.pause();
                  },
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  icon: const Icon(Icons.stop),
                  label: const Text('Stop'),
                  onPressed: () async {
                    await _audioPlayer.stop();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}