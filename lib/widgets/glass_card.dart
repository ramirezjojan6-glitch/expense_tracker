import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';

class GlassCard extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final double hoverScale;
  final VoidCallback? onTap;

  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.borderRadius = 20,
    this.hoverScale = 1.02,
    this.onTap,
  });

  @override
  State<GlassCard> createState() => _GlassCardState();
}

class _GlassCardState extends State<GlassCard> {
  static const _shadowColor = Color(0xFF00312E);
  static const _duration = Duration(milliseconds: 240);
  static const _curve = Curves.easeOutCubic;
  static const _lightRadius = 150.0;

  bool _hovering = false;
  Offset _pointer = Offset.zero;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(widget.borderRadius);

    return MouseRegion(
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : MouseCursor.defer,
      onEnter: (e) => setState(() {
        _hovering = true;
        _pointer = e.localPosition;
      }),
      onHover: (e) => setState(() => _pointer = e.localPosition),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _hovering ? widget.hoverScale : 1.0,
          duration: _duration,
          curve: _curve,
          child: AnimatedContainer(
            duration: _duration,
            curve: _curve,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: radius,
              boxShadow: [
                BoxShadow(
                  color: _shadowColor.withValues(alpha: _hovering ? 0.26 : 0.18),
                  blurRadius: _hovering ? 38 : 30,
                  offset: Offset(0, _hovering ? 18 : 14),
                ),
                BoxShadow(
                  color: _shadowColor.withValues(alpha: 0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: radius,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Stack(
                  fit: StackFit.passthrough,
                  children: [
                    Container(
                      padding: widget.padding,
                      decoration: BoxDecoration(
                        borderRadius: radius,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withValues(alpha: 0.55),
                            Colors.white.withValues(alpha: 0.18),
                          ],
                        ),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.65),
                          width: 1.2,
                        ),
                      ),
                      child: widget.child,
                    ),
                    Positioned.fill(
                      child: IgnorePointer(
                        child: AnimatedOpacity(
                          opacity: _hovering ? 1 : 0,
                          duration: const Duration(milliseconds: 250),
                          child: LayoutBuilder(
                            builder: (context, box) {
                              final w = math.max(1.0, box.maxWidth);
                              final h = math.max(1.0, box.maxHeight);
                              final shortest = math.min(w, h);
                              return DecoratedBox(
                                decoration: BoxDecoration(
                                  borderRadius: radius,
                                  gradient: RadialGradient(
                                    center: Alignment(
                                      (_pointer.dx / w) * 2 - 1,
                                      (_pointer.dy / h) * 2 - 1,
                                    ),
                                    radius: _lightRadius / shortest,
                                    colors: [
                                      Colors.white.withValues(alpha: 0.55),
                                      Colors.white.withValues(alpha: 0.0),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}