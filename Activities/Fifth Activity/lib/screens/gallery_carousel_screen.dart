import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

// Keyboard navigation intents
class _PrevIntent extends Intent {
  const _PrevIntent();
}

class _NextIntent extends Intent {
  const _NextIntent();
}

class GalleryCarouselScreen extends StatefulWidget {
  const GalleryCarouselScreen({super.key});

  @override
  State<GalleryCarouselScreen> createState() => _GalleryCarouselScreenState();
}

class _GalleryCarouselScreenState extends State<GalleryCarouselScreen> {
  final List<String> _images = const [
    // Use web-friendly network images to avoid 404s when assets are missing
    'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?auto=format&fit=crop&w=1200&q=60', // hotel
    'https://images.unsplash.com/photo-1559599101-f0c7352e62b8?auto=format&fit=crop&w=1200&q=60', // room
    'https://images.unsplash.com/photo-1542273917363-3b1817f69a2d?auto=format&fit=crop&w=1200&q=60', // pool
    'https://images.unsplash.com/photo-1528605248644-14dd04022da1?auto=format&fit=crop&w=1200&q=60', // restaurant
  ];

  late final PageController _pageController;
  int _currentIndex = 0;
  Timer? _autoSlideTimer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.9);
    // Precache initial images and start auto slide
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _precacheAround(0);
    });
    _startAutoSlide();
  }

  @override
  void dispose() {
    _autoSlideTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _goTo(int index) {
    if (index < 0 || index >= _images.length) return;
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
    _startAutoSlide();
  }

  void _precacheAround(int index) {
    // Preload current, previous, and next images to smooth navigation
    final ctx = context;
    ImageProvider providerFor(String src) {
      ImageProvider provider;
      if (src.startsWith('http')) {
        provider = NetworkImage(src);
      } else {
        provider = AssetImage(src);
      }
      return provider;
    }
    precacheImage(providerFor(_images[index]), ctx);
    if (index - 1 >= 0) precacheImage(providerFor(_images[index - 1]), ctx);
    if (index + 1 < _images.length) precacheImage(providerFor(_images[index + 1]), ctx);
  }

  void _startAutoSlide() {
    _autoSlideTimer?.cancel();
    _autoSlideTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      final next = (_currentIndex + 1) % _images.length;
      _goTo(next);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gallery Carousel')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          // Responsive height targeting ~16:9 ratio, capped for very large screens
          final height = (width * 0.56).clamp(240.0, 520.0);

          return Center(
            child: Focus(
              autofocus: true,
              child: Shortcuts(
                shortcuts: <LogicalKeySet, Intent>{
                  LogicalKeySet(LogicalKeyboardKey.arrowLeft): const _PrevIntent(),
                  LogicalKeySet(LogicalKeyboardKey.arrowRight): const _NextIntent(),
                },
                child: Actions(
                  actions: <Type, Action<Intent>>{
                    _PrevIntent: CallbackAction<_PrevIntent>(
                      onInvoke: (intent) {
                        _goTo(_currentIndex - 1);
                        return null;
                      },
                    ),
                    _NextIntent: CallbackAction<_NextIntent>(
                      onInvoke: (intent) {
                        _goTo(_currentIndex + 1);
                        return null;
                      },
                    ),
                  },
                  child: SizedBox(
                  height: height,
                  child: Stack(
                children: [
                  PageView.builder(
                    itemCount: _images.length,
                    controller: _pageController,
                  onPageChanged: (i) {
                    setState(() => _currentIndex = i);
                    _precacheAround(i);
                    _startAutoSlide();
                  },
                    itemBuilder: (context, index) {
                      final img = _images[index];
                      return AnimatedBuilder(
                        animation: _pageController,
                        builder: (context, child) {
                          double page = _currentIndex.toDouble();
                          if (_pageController.hasClients && _pageController.page != null) {
                            page = _pageController.page!;
                          }
                          final delta = (index - page).abs().clamp(0.0, 1.0);
                          final scale = 0.92 + (1.0 - delta) * 0.08; // subtle zoom for active card
                          final opacity = 0.65 + (1.0 - delta) * 0.35; // fade neighbors

                          return Semantics(
                            label: 'Hotel room photo ${index + 1} of ${_images.length}',
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
                              child: Opacity(
                                opacity: opacity,
                                child: Transform.scale(
                                  scale: scale,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        _OptimizedNetworkImage(
                                          img,
                                          fit: BoxFit.cover,
                                        ),
                                        Positioned(
                                          bottom: 12,
                                          left: 12,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                                            decoration: BoxDecoration(
                                              color: Colors.black54,
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              'Photo ${index + 1}',
                                              style: const TextStyle(color: Colors.white, fontSize: 14),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                
                  // Previous button
                  Positioned(
                    left: 8,
                    top: 0,
                    bottom: 0,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: _NavButton(
                        icon: Icons.chevron_left,
                        tooltip: 'Previous image',
                        onPressed: _currentIndex > 0 ? () => _goTo(_currentIndex - 1) : null,
                      ),
                    ),
                  ),

                  // Next button
                  Positioned(
                    right: 8,
                    top: 0,
                    bottom: 0,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: _NavButton(
                        icon: Icons.chevron_right,
                        tooltip: 'Next image',
                        onPressed: _currentIndex < _images.length - 1 ? () => _goTo(_currentIndex + 1) : null,
                      ),
                    ),
                  ),

                  // Indicators
                  Positioned(
                    bottom: 8,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(_images.length, (i) {
                          final selected = i == _currentIndex;
                          return GestureDetector(
                            onTap: () => _goTo(i),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: selected ? 12 : 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: selected ? Theme.of(context).colorScheme.primary : Colors.white70,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  if (selected)
                                    BoxShadow(
                                      color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.35),
                                      blurRadius: 6,
                                      offset: const Offset(0, 2),
                                    ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
        },
      ),
    );
  }
}

// Button with semi-transparent background for better contrast on images
class _NavButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  const _NavButton({required this.icon, this.onPressed, this.tooltip});

  @override
  Widget build(BuildContext context) {
    final button = Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(24),
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.black45,
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
        ),
      ),
    );
    return tooltip != null ? Tooltip(message: tooltip!, child: button) : button;
  }
}

// Optimized asset image widget with proper scaling and high filter quality
class _OptimizedNetworkImage extends StatelessWidget {
  final String url;
  final BoxFit fit;
  const _OptimizedNetworkImage(this.url, {this.fit = BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final dpr = MediaQuery.of(context).devicePixelRatio;
        final targetWidth = (constraints.maxWidth * dpr).round();
        final targetHeight = (constraints.maxHeight * dpr).round();
        return Image.network(
          url,
          fit: fit,
          gaplessPlayback: true,
          filterQuality: FilterQuality.high,
          cacheWidth: targetWidth > 0 ? targetWidth : null,
          cacheHeight: targetHeight > 0 ? targetHeight : null,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey.shade300,
              alignment: Alignment.center,
              child: const Text('Image failed to load'),
            );
          },
          frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
            if (wasSynchronouslyLoaded) return child;
            return AnimatedOpacity(
              opacity: frame == null ? 0 : 1,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              child: child,
            );
          },
        );
      },
    );
  }
}