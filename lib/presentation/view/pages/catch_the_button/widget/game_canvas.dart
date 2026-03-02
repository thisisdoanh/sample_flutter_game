part of '../catch_the_button_page.dart';

// ─────────────────────────────────────────────────────────────────────────────
// _Particle — hạt nền bay lên tạo cảm giác tốc độ
// ─────────────────────────────────────────────────────────────────────────────

class _Particle {
  _Particle({
    required this.x,
    required this.y,
    required this.speed,
    required this.size,
    required this.opacity,
  });
  double x;
  double y;
  final double speed;
  final double size;
  final double opacity;
}

// ─────────────────────────────────────────────────────────────────────────────
// Trạng thái nội bộ của button trong canvas
// ─────────────────────────────────────────────────────────────────────────────

enum _BtnPhase { idle, appearing, visible, disappearing }

// ─────────────────────────────────────────────────────────────────────────────
// _CatchGameCanvas — widget chứa toàn bộ logic hiển thị game
// ─────────────────────────────────────────────────────────────────────────────

class _CatchGameCanvas extends StatefulWidget {
  const _CatchGameCanvas({
    required this.gamePhase,
    required this.onTap,
  });

  final GamePhase gamePhase;
  final VoidCallback onTap; // gọi khi player tap đúng button

  @override
  State<_CatchGameCanvas> createState() => _CatchGameCanvasState();
}

class _CatchGameCanvasState extends State<_CatchGameCanvas>
    with TickerProviderStateMixin {
  // ── Animation controllers ──────────────────────────────────────────────────
  late final AnimationController _scaleCtrl; // appear / disappear button
  late final AnimationController _countdownCtrl; // countdown ring trên button
  late final Animation<double> _scaleAnim; // elastic pop-in feel

  // ── Button state ───────────────────────────────────────────────────────────
  _BtnPhase _btnPhase = _BtnPhase.idle;
  double _btnX = 0, _btnY = 0; // tâm button (px)

  // ── Screen & game state ───────────────────────────────────────────────────
  bool _sizeReady = false;
  double _width = 0, _height = 0;
  bool _gameRunning = false;

  // ── Background particles ───────────────────────────────────────────────────
  final List<_Particle> _particles = [];
  final Random _random = Random();
  late final Ticker _particleTicker;
  Duration _lastParticleElapsed = Duration.zero;

  // ── Constants ──────────────────────────────────────────────────────────────
  static const double _btnHalf = 44.0; // bán kính logic button (px, nhân .r khi render)
  static const double _margin = 90.0; // khoảng cách tối thiểu button → biên màn hình
  static const int _particleCount = 18;

  @override
  void initState() {
    super.initState();

    _scaleCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
      reverseDuration: const Duration(milliseconds: 180),
    );
    _scaleAnim = CurvedAnimation(
      parent: _scaleCtrl,
      curve: Curves.easeOutBack, // nhẹ nhàng overshoot tạo "bung ra" đẹp
      reverseCurve: Curves.easeIn,
    );

    _countdownCtrl = AnimationController(vsync: this);
    _scaleCtrl.addStatusListener(_onScaleStatus);
    _countdownCtrl.addStatusListener(_onCountdownStatus);

    _particleTicker = createTicker(_onParticleTick)..start();
  }

  // ── Scale status → điều phối button state machine ─────────────────────────
  void _onScaleStatus(AnimationStatus status) {
    if (!mounted) return;
    if (_btnPhase == _BtnPhase.appearing && status == AnimationStatus.completed) {
      // Button đã xuất hiện đầy đủ → bắt đầu đếm ngược
      _btnPhase = _BtnPhase.visible;
      _countdownCtrl.reset();
      _countdownCtrl.forward();
      setState(() {});
    } else if (_btnPhase == _BtnPhase.disappearing &&
        status == AnimationStatus.dismissed) {
      // Button đã biến mất hoàn toàn → chờ rồi spawn lại
      _btnPhase = _BtnPhase.idle;
      Future.delayed(const Duration(milliseconds: 280), _maybeSpawn);
    }
  }

  // ── Countdown status → timeout khi hết thời gian hiển thị ─────────────────
  void _onCountdownStatus(AnimationStatus status) {
    if (!mounted || _btnPhase != _BtnPhase.visible) return;
    if (status == AnimationStatus.completed) {
      _btnPhase = _BtnPhase.disappearing;
      _scaleCtrl.reverse();
      setState(() {});
    }
  }

  // ── Particle animation ─────────────────────────────────────────────────────
  void _onParticleTick(Duration elapsed) {
    if (_particles.isEmpty || !mounted) return;
    if (_lastParticleElapsed == Duration.zero) {
      _lastParticleElapsed = elapsed;
      return;
    }
    final dt = (elapsed - _lastParticleElapsed).inMilliseconds / 1000.0;
    _lastParticleElapsed = elapsed;
    if (dt <= 0 || dt > 0.1) return;
    for (final p in _particles) {
      p.y -= p.speed * dt;
      if (p.y < 0) {
        p.y = _height + 10;
        p.x = _random.nextDouble() * _width;
      }
    }
    setState(() {});
  }

  void _initParticles() {
    _particles.clear();
    for (int i = 0; i < _particleCount; i++) {
      _particles.add(_Particle(
        x: _random.nextDouble() * _width,
        y: _random.nextDouble() * _height,
        speed: 30 + _random.nextDouble() * 60,
        size: 1.0 + _random.nextDouble() * 2.5,
        opacity: 0.08 + _random.nextDouble() * 0.25,
      ));
    }
  }

  // ── Game control ───────────────────────────────────────────────────────────
  void _startGame() {
    _gameRunning = true;
    _btnPhase = _BtnPhase.idle;
    _scaleCtrl.reset();
    _countdownCtrl.reset();
    _spawnButton();
  }

  void _stopGame() {
    _gameRunning = false;
    _btnPhase = _BtnPhase.idle;
    _scaleCtrl.reset();
    _countdownCtrl.stop();
    if (mounted) setState(() {});
  }

  void _maybeSpawn() {
    if (!mounted || !_gameRunning || _btnPhase != _BtnPhase.idle) return;
    _spawnButton();
  }

  void _spawnButton() {
    if (!_gameRunning || !mounted) return;

    // Vị trí ngẫu nhiên trong vùng an toàn
    final safeW = _width - _margin * 2;
    final safeH = _height - _margin * 2;
    _btnX = _margin + _random.nextDouble() * safeW;
    _btnY = _margin + _random.nextDouble() * safeH;

    // Thời gian hiển thị ngẫu nhiên 1–3 giây
    final durMs = 1000 + _random.nextInt(2000);
    _countdownCtrl.duration = Duration(milliseconds: durMs);

    _btnPhase = _BtnPhase.appearing;
    _scaleCtrl.reset();
    _scaleCtrl.forward();
    setState(() {});
  }

  // ── Tap handler ────────────────────────────────────────────────────────────
  void _onButtonTapped() {
    if (_btnPhase != _BtnPhase.visible || !_gameRunning) return;
    _btnPhase = _BtnPhase.disappearing;
    _countdownCtrl.stop();
    widget.onTap(); // thông báo lên Bloc +1 score
    _scaleCtrl.reverse();
    setState(() {});
  }

  @override
  void didUpdateWidget(_CatchGameCanvas old) {
    super.didUpdateWidget(old);
    if (old.gamePhase == widget.gamePhase) return;
    if (widget.gamePhase == GamePhase.playing && _sizeReady) {
      _startGame();
    } else if (widget.gamePhase != GamePhase.playing) {
      _stopGame();
    }
  }

  @override
  void dispose() {
    _scaleCtrl.dispose();
    _countdownCtrl.dispose();
    _particleTicker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (!_sizeReady) {
          _width = constraints.maxWidth;
          _height = constraints.maxHeight;
          _sizeReady = true;
          _initParticles();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted && widget.gamePhase == GamePhase.playing) _startGame();
          });
        }

        final btnHalfPx = _btnHalf.r; // bán kính thực tế (dp → px theo ScreenUtil)
        final btnSizePx = btnHalfPx * 2;

        return Stack(
          children: [
            // Nền chung: gradient tối + lưới cyber
            const GameBackground(
              topColor: Color(0xFF0D1020),
              bottomColor: Color(0xFF1A1230),
              gridColor: Color(0xFF2A1F5A),
              gridAlpha: 0.35,
            ),
            // Lớp hạt nền purple + button
            CustomPaint(
              painter: _ParticlePainter(particles: _particles),
              size: Size(_width, _height),
              child: Stack(
                children: [
                  if (_sizeReady && _btnPhase != _BtnPhase.idle)
                    AnimatedBuilder(
                      animation: Listenable.merge([_scaleAnim, _countdownCtrl]),
                      builder: (context, _) => Positioned(
                        left: _btnX - btnHalfPx,
                        top: _btnY - btnHalfPx,
                        child: GestureDetector(
                          onTap: _btnPhase == _BtnPhase.visible ? _onButtonTapped : null,
                          child: Transform.scale(
                            scale: _scaleAnim.value.clamp(0.0, 1.2),
                            child: _CatchButton(
                              ringRemaining: 1 - _countdownCtrl.value,
                              size: btnSizePx,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// _CatchButton — widget hiển thị button + countdown ring
// ─────────────────────────────────────────────────────────────────────────────

class _CatchButton extends StatelessWidget {
  const _CatchButton({required this.ringRemaining, required this.size});

  final double ringRemaining; // 1.0 = ring đầy, 0.0 = ring trống
  final double size;

  @override
  Widget build(BuildContext context) {
    final innerSize = size * 0.78; // thân button nhỏ hơn ring một chút
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer glow
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF9B5DE5).withValues(alpha: 0.35),
                  blurRadius: 24,
                  spreadRadius: 6,
                ),
              ],
            ),
          ),
          // Countdown ring
          CustomPaint(
            painter: _RingPainter(remaining: ringRemaining),
            size: Size(size, size),
          ),
          // Button body
          Container(
            width: innerSize,
            height: innerSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF9B5DE5), Color(0xFFE040FB)],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF9B5DE5).withValues(alpha: 0.6),
                  blurRadius: 16,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Icon(
              Icons.touch_app_rounded,
              size: innerSize * 0.46,
              color: Colors.white,
            ),
          ),
          // Highlight sáng góc trên
          Positioned(
            top: size * 0.17,
            left: size * 0.28,
            child: Container(
              width: size * 0.14,
              height: size * 0.14,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.55),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// _RingPainter — vẽ countdown arc xung quanh button
// ─────────────────────────────────────────────────────────────────────────────

class _RingPainter extends CustomPainter {
  const _RingPainter({required this.remaining});

  final double remaining; // 1.0 = full ring → 0.0 = empty

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 3;

    // Track (vòng nền mờ)
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.5
        ..color = Colors.white.withValues(alpha: 0.12),
    );

    // Arc countdown (gold)
    if (remaining > 0) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -pi / 2, // bắt đầu từ đỉnh (12 giờ)
        2 * pi * remaining,
        false,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3.5
          ..strokeCap = StrokeCap.round
          ..color = const Color(0xFFFFD700),
      );
    }
  }

  @override
  bool shouldRepaint(_RingPainter old) => old.remaining != remaining;
}

// ─────────────────────────────────────────────────────────────────────────────
// _ParticlePainter — vẽ hạt nền purple nhẹ (nền được xử lý bởi GameBackground)
// ─────────────────────────────────────────────────────────────────────────────

class _ParticlePainter extends CustomPainter {
  const _ParticlePainter({required this.particles});

  final List<_Particle> particles;

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in particles) {
      canvas.drawCircle(
        Offset(p.x, p.y),
        p.size,
        Paint()..color = const Color(0xFFB39DDB).withValues(alpha: p.opacity),
      );
    }
  }

  @override
  bool shouldRepaint(_ParticlePainter old) => true;
}
