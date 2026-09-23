import 'package:flutter/material.dart';

class LoadingSkeleton extends StatefulWidget {
  const LoadingSkeleton({super.key});

  @override
  State<LoadingSkeleton> createState() => _LoadingSkeletonState();
}

class _LoadingSkeletonState extends State<LoadingSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '正在加载天气',
      liveRegion: true,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final color = Color.lerp(
            const Color(0xFFE3EAF4),
            const Color(0xFFF2F6FB),
            _controller.value,
          )!;
          return Column(
            children: [
              _block(color, 270),
              const SizedBox(height: 16),
              _block(color, 116),
              const SizedBox(height: 24),
              Row(
                children: List.generate(
                  3,
                  (index) => Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: index == 2 ? 0 : 10),
                      child: _block(color, 132),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _block(Color color, double height) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(24),
      ),
    );
  }
}
