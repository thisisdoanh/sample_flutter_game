part of '../balance_ball_page.dart';

// ─────────────────────────────────────────────────────────────────────────────
// _PathPoint — một điểm trên đường đi (world space)
//
// Đường đi được biểu diễn bằng danh sách các điểm trung tâm liên tiếp.
// [worldY] là tọa độ Y trong không gian thế giới (không phụ thuộc camera),
// [centerX] là tọa độ X trung tâm của đường tại vị trí Y đó.
// [width] là độ rộng đường tại điểm này (px)
// ─────────────────────────────────────────────────────────────────────────────

class _PathPoint {
  const _PathPoint({required this.centerX, required this.worldY, required this.width});
  final double centerX;
  final double worldY;
  final double width;
}

// ─────────────────────────────────────────────────────────────────────────────
// _Particle — hạt nền (speed lines)
//
// Các hạt nhỏ bay ngược lên màn hình tạo cảm giác tốc độ.
// Khi ra khỏi top màn hình, chúng được spawn lại ở bottom với vị trí X ngẫu nhiên.
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
  final double speed; // tốc độ bay lên (px/s)
  final double size; // bán kính hạt (px)
  final double opacity; // độ trong suốt (0.0 – 1.0)
}

// ─────────────────────────────────────────────────────────────────────────────
// _ExplosionParticle — hạt vụ nổ khi bóng va chạm
//
// Khi bóng ra khỏi đường, một loạt hạt được spawn tại vị trí bóng và bay ra
// theo nhiều hướng ngẫu nhiên, sau đó mờ dần rồi biến mất.
// ─────────────────────────────────────────────────────────────────────────────

class _ExplosionParticle {
  _ExplosionParticle({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.opacity,
    required this.size,
    required this.color,
  });
  double x;
  double y;
  double vx; // vận tốc ngang (px/s)
  double vy; // vận tốc dọc (px/s)
  double opacity; // fades từ 1.0 → 0.0
  final double size;
  final Color color;
}

// ─────────────────────────────────────────────────────────────────────────────
// _GameCanvas — widget chứa toàn bộ logic và rendering của game
//
// Nhận [gamePhase] từ BLoC bên ngoài để biết khi nào bắt đầu/dừng game.
// Callbacks [onScoreUpdate] và [onGameOver] được gọi để cập nhật BLoC.
// ─────────────────────────────────────────────────────────────────────────────

class _GameCanvas extends StatefulWidget {
  const _GameCanvas({
    required this.gamePhase,
    required this.onScoreUpdate,
    required this.onGameOver,
  });

  final GamePhase gamePhase;
  final ValueChanged<int> onScoreUpdate;
  final ValueChanged<int> onGameOver;

  @override
  State<_GameCanvas> createState() => _GameCanvasState();
}

class _GameCanvasState extends State<_GameCanvas> with SingleTickerProviderStateMixin {
  // ── Ticker (game loop) ────────────────────────────────────────────────────
  // Ticker gọi _onTick mỗi frame (~60fps), là vòng lặp chính của game.
  late Ticker _ticker;

  // ── Screen dimensions ─────────────────────────────────────────────────────
  double _width = 0;
  double _height = 0;
  bool _sizeReady = false; // true sau lần build đầu tiên khi có kích thước

  // ── Ball state ────────────────────────────────────────────────────────────
  double _ballX = 0; // vị trí ngang bóng (px, tính từ left)
  double _ballVelX = 0; // vận tốc ngang bóng (px/s)

  // ── Path (đường đi) ───────────────────────────────────────────────────────
  final List<_PathPoint> _pathPoints = []; // danh sách điểm trung tâm đường
  double _scrollY = 0; // camera đã scroll bao nhiêu px trong world space
  double _scrollSpeed = 90; // tốc độ cuộn (px/s), tăng dần theo thời gian
  double _pathWidth = 130; // độ rộng cơ sở (px), hẹp dần theo thời gian
  double _widthCurrent = 130.0; // độ rộng thực tế hiện tại (sau random hoá zone)
  double _widthTarget = 130.0; // độ rộng đích của zone hiện tại
  int _widthZoneCountdown = 20; // số segment còn lại trong zone hiện tại
  Duration _lastElapsed = Duration.zero; // thời điểm tick trước để tính dt
  bool _gameStarted = false; // true khi game đang chạy (có path & ball)

  // ── Sensor ────────────────────────────────────────────────────────────────
  StreamSubscription<AccelerometerEvent>? _accelSub;
  // _tiltInput: giá trị nghiêng chuẩn hóa (-1.0 = trái, +1.0 = phải)
  double _tiltInput = 0;

  // ── Background particles (speed lines) ───────────────────────────────────
  final List<_Particle> _particles = [];
  final Random _random = Random();

  // ── Explosion particles ───────────────────────────────────────────────────
  final List<_ExplosionParticle> _explosionParticles = [];
  bool _isExploding = false; // đang chạy animation vụ nổ
  double _explosionTimer = 0.0; // thời gian đã trôi qua kể từ lúc nổ (s)
  int _gameOverScore = 0; // lưu score để emit sau khi nổ xong

  // ── Constants ─────────────────────────────────────────────────────────────
  static const double _segmentSpacing = 36.0; // khoảng cách giữa 2 PathPoint (px)
  static const double _ballRadius = 15.0; // bán kính bóng (px)
  static const double _ballScreenYRatio = 0.55; // bóng cố định tại 55% chiều cao màn hình
  static const double _sensitivity = 150.0; // độ nhạy cảm biến → gia tốc bóng
  static const double _damping = 0.80; // hệ số ma sát: vận tốc *= damping mỗi frame
  static const int _particleCount = 25; // số hạt nền
  static const double _explosionDuration = 0.65; // thời gian animation vụ nổ (s)
  static const int _explosionParticleCount = 32; // số hạt vụ nổ

  // ── Speed tiers ───────────────────────────────────────────────────────────
  // Mỗi cặp [milestone_giây, tốc_độ_px/s]:
  //   0s → 90   : giai đoạn khởi động, dễ làm quen
  //   15s → 155 : bắt đầu cảm nhận tốc độ
  //   30s → 260 : đường cong rõ thách thức
  //   40s → 380 : tốc độ cao, cần tập trung
  //   60s → 540 : chế độ sinh tử
  // Giữa các mốc: tốc độ tăng tuyến tính (lerp).
  // Sau mốc cuối (60s): tiếp tục tăng thêm 10 px/s mỗi giây.
  static const List<int> _speedMilestones = [0, 15, 30, 40, 60];
  static const List<double> _speedTargets = [90.0, 155.0, 260.0, 380.0, 540.0];
  static const double _postLastTierGain = 10.0; // px/s tăng thêm mỗi giây sau mốc 60s

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_onTick);
    _initSensors();
  }

  // ── Sensor init ───────────────────────────────────────────────────────────
  // Lắng nghe accelerometer để lấy góc nghiêng trái/phải.
  // e.x là gia tốc trọng lực trên trục X (đơn vị m/s²),
  // chia cho 9.8 để chuẩn hóa về [-1, 1].
  void _initSensors() {
    _accelSub = accelerometerEventStream(
      samplingPeriod: SensorInterval.gameInterval,
    ).listen((e) => _tiltInput = e.x / 9.8);
  }

  // ── Start game ────────────────────────────────────────────────────────────
  // Reset toàn bộ trạng thái về giá trị ban đầu và bắt đầu game loop.
  void _startGame() {
    _ballX = _width / 2; // bóng bắt đầu ở giữa màn hình
    _ballVelX = 0;
    _scrollY = 0;
    _scrollSpeed = 90;
    _pathWidth = 130;
    _widthCurrent = 130.0;
    _widthTarget = 130.0;
    _widthZoneCountdown = 5; // zone đầu tiên được chọn ngay sau 5 segment
    _lastElapsed = Duration.zero;
    _gameStarted = true;
    _isExploding = false;
    _explosionTimer = 0.0;
    _pathPoints.clear();
    _particles.clear();
    _explosionParticles.clear();
    _generateInitialPath();
    _generateParticles();
    if (!_ticker.isActive) {
      _ticker.start();
    }
  }

  // ── Generate initial path ─────────────────────────────────────────────────
  // Tạo đủ PathPoint để lấp đầy màn hình khi game bắt đầu, cộng thêm buffer.
  void _generateInitialPath() {
    double centerX = _width / 2;
    // Tạo thêm 30 điểm buffer ngoài tầm nhìn để đường luôn liên tục
    final count = (_height / _segmentSpacing).ceil() + 30;
    for (int i = 0; i < count; i++) {
      final w = _advanceWidth(_pathWidth);
      _pathPoints.add(_PathPoint(centerX: centerX, worldY: i * _segmentSpacing, width: w));
      centerX = _nextCenterX(centerX, 0, w);
    }
  }

  // ── Generate background particles ─────────────────────────────────────────
  // Tạo các hạt nhỏ ngẫu nhiên rải đều màn hình, mỗi hạt có tốc độ khác nhau.
  void _generateParticles() {
    for (int i = 0; i < _particleCount; i++) {
      _particles.add(
        _Particle(
          x: _random.nextDouble() * _width,
          y: _random.nextDouble() * _height,
          speed: 60 + _random.nextDouble() * 120,
          size: 1 + _random.nextDouble() * 2,
          opacity: 0.2 + _random.nextDouble() * 0.5,
        ),
      );
    }
  }

  // ── Trigger explosion ─────────────────────────────────────────────────────
  // Spawn các hạt vụ nổ tại vị trí bóng va chạm.
  // Mỗi hạt có hướng ngẫu nhiên (0–2π) và tốc độ ngẫu nhiên.
  void _triggerExplosion(double x, double y, int score) {
    _isExploding = true;
    _explosionTimer = 0.0;
    _gameOverScore = score;
    _explosionParticles.clear();

    // Màu sắc của các hạt vụ nổ (lấy từ màu bóng và hiệu ứng lửa)
    const colors = [
      Color(0xFFFF5757),
      Color(0xFFFF9F1C),
      Color(0xFFFFD700),
      Color(0xFFFF8484),
      Color(0xFFFFFFFF),
      Color(0xFFFF3030),
    ];

    for (int i = 0; i < _explosionParticleCount; i++) {
      final angle = _random.nextDouble() * 2 * pi;
      // Tốc độ chia 2 nhóm: nhóm nhanh (mảnh vỡ lớn) và chậm (tia sáng nhỏ)
      final speed = i < 12
          ? 200.0 +
                _random.nextDouble() *
                    350.0 // nhóm nhanh
          : 60.0 + _random.nextDouble() * 160.0; // nhóm chậm
      _explosionParticles.add(
        _ExplosionParticle(
          x: x,
          y: y,
          vx: cos(angle) * speed,
          vy: sin(angle) * speed,
          opacity: 1.0,
          size: i < 12
              ? 3.0 +
                    _random.nextDouble() *
                        6.0 // hạt lớn
              : 1.5 + _random.nextDouble() * 3.0, // hạt nhỏ
          color: colors[_random.nextInt(colors.length)],
        ),
      );
    }
  }

  // ── Next center X ─────────────────────────────────────────────────────────
  // Tính tọa độ X trung tâm cho PathPoint tiếp theo bằng random walk.
  // maxDelta tăng dần theo [score] để đường uốn lượn nhiều hơn khi chơi lâu.
  // margin đảm bảo đường không vượt quá biên màn hình.
  double _nextCenterX(double prev, int score, double width) {
    final maxDelta = 5.0 + (score / 15) * 3.0;
    final delta = (_random.nextDouble() * 2 - 1) * maxDelta.clamp(0, 18);
    final margin = width / 2 + 24;
    return (prev + delta).clamp(margin, _width - margin);
  }

  // ── Advance width zone ────────────────────────────────────────────────────
  // Mỗi "zone" gồm 18-40 segment có cùng width đích.
  // Width hiện tại lerp mượt về đích, tạo hiệu ứng đường rộng/hẹp xen kẽ.
  // [baseMin] là độ rộng tối thiểu do độ khó quyết định (giảm theo thời gian).
  double _advanceWidth(double baseMin) {
    _widthZoneCountdown--;
    if (_widthZoneCountdown <= 0) {
      // Giới hạn trên: rộng gấp ~1.75 lần baseMin, tối đa 220px
      final baseMax = (baseMin * 1.75).clamp(baseMin + 20.0, 220.0);
      _widthTarget = baseMin + _random.nextDouble() * (baseMax - baseMin);
      _widthZoneCountdown = 18 + _random.nextInt(22); // 18-40 segment/zone
    }
    // Lerp mượt về target (hệ số 0.08 = thay đổi chậm, không giật)
    _widthCurrent += (_widthTarget - _widthCurrent) * 0.08;
    return _widthCurrent.clamp(baseMin, 220.0);
  }

  // ── Compute scroll speed ──────────────────────────────────────────────────
  // Trả về tốc độ cuộn (px/s) dựa trên số giây đã chơi.
  // Trong mỗi tier: lerp tuyến tính từ tốc độ đầu tier → tốc độ cuối tier.
  // Sau mốc cuối cùng (60s): tiếp tục tăng thêm [_postLastTierGain] px/s/giây.
  double _computeScrollSpeed(int seconds) {
    final n = _speedMilestones.length;
    for (int i = n - 1; i >= 0; i--) {
      if (seconds >= _speedMilestones[i]) {
        if (i < n - 1) {
          // Lerp tuyến tính giữa tier i và tier i+1
          final span = (_speedMilestones[i + 1] - _speedMilestones[i]).toDouble();
          final t = (seconds - _speedMilestones[i]) / span;
          return _speedTargets[i] + (_speedTargets[i + 1] - _speedTargets[i]) * t;
        }
        // Vượt mốc cuối: tăng thêm hằng số mỗi giây
        return (_speedTargets.last + (seconds - _speedMilestones.last) * _postLastTierGain)
            .clamp(0.0, 800.0);
      }
    }
    return _speedTargets.first;
  }

  // ── Main game loop ────────────────────────────────────────────────────────
  // Được Ticker gọi mỗi frame. Tính dt (delta time giữa 2 frame),
  // cập nhật vật lý, đường đi, hạt nền, và kiểm tra va chạm.
  void _onTick(Duration elapsed) {
    if (!_gameStarted) {
      return;
    }

    // Lần đầu tick: lưu thời điểm để tính dt ở frame tiếp theo
    if (_lastElapsed == Duration.zero) {
      _lastElapsed = elapsed;
      return;
    }

    final dt = (elapsed - _lastElapsed).inMilliseconds / 1000.0;
    _lastElapsed = elapsed;
    // Bỏ qua frame có dt bất thường (ví dụ: app bị pause rồi resume)
    if (dt <= 0 || dt > 0.1) {
      return;
    }

    // ── Explosion animation phase ──────────────────────────────────────────
    // Khi đang nổ: cập nhật hạt vụ nổ và chờ animation kết thúc.
    // Game logic bình thường bị tạm dừng trong giai đoạn này.
    if (_isExploding) {
      _explosionTimer += dt;
      // progress: 0.0 (vừa nổ) → 1.0 (hết animation)
      final progress = (_explosionTimer / _explosionDuration).clamp(0.0, 1.0);

      for (final p in _explosionParticles) {
        // Di chuyển hạt theo vận tốc
        p.x += p.vx * dt;
        p.y += p.vy * dt;
        // Giả lập trọng lực kéo hạt xuống
        p.vy += 380 * dt;
        // Hạt mờ dần theo thời gian, nhanh hơn ở cuối animation
        p.opacity = (1.0 - progress * 1.3).clamp(0.0, 1.0);
      }

      // Khi animation kết thúc: dừng ticker và thông báo game over lên BLoC
      if (_explosionTimer >= _explosionDuration) {
        _isExploding = false;
        _ticker.stop();
        widget.onGameOver(_gameOverScore);
      }

      setState(() {});
      return;
    }

    if (widget.gamePhase != GamePhase.playing) {
      return;
    }

    final seconds = elapsed.inSeconds;

    // ── Difficulty scaling ─────────────────────────────────────────────────
    // Tốc độ tăng theo speed tiers: lerp tuyến tính giữa các mốc thời gian.
    _scrollSpeed = _computeScrollSpeed(seconds);

    // Độ rộng đường hẹp dần: 130px ban đầu → tối thiểu 60px
    _pathWidth = (130.0 - (seconds * 0.8).clamp(0.0, 70.0)).clamp(60.0, 130.0);

    // ── Scroll ────────────────────────────────────────────────────────────
    // Camera dịch chuyển lên (scrollY tăng) tạo ảo giác bóng chạy về phía trước
    _scrollY += _scrollSpeed * dt;

    // ── Ball physics ──────────────────────────────────────────────────────
    // _tiltInput từ accelerometer: gia tốc bóng tỉ lệ với góc nghiêng
    _ballVelX += _tiltInput * _sensitivity * dt;
    // Damping: mỗi frame nhân với 0.8 để bóng không trượt mãi khi đặt thẳng
    _ballVelX *= _damping;
    // Giới hạn bóng không ra ngoài màn hình
    _ballX = (_ballX + _ballVelX).clamp(_ballRadius, _width - _ballRadius);

    // ── Generate new path segments ────────────────────────────────────────
    // Luôn giữ đường dài hơn tầm nhìn 15 segment để tránh đường bị cắt đột ngột
    while (_pathPoints.isEmpty ||
        _pathPoints.last.worldY < _scrollY + _height + _segmentSpacing * 15) {
      final last = _pathPoints.last;
      final newWidth = _advanceWidth(_pathWidth);
      _pathPoints.add(
        _PathPoint(
          centerX: _nextCenterX(last.centerX, seconds, newWidth),
          worldY: last.worldY + _segmentSpacing,
          width: newWidth,
        ),
      );
    }

    // ── Remove off-screen segments ────────────────────────────────────────
    // Xóa các segment đã cuộn ra khỏi tầm nhìn phía trên để tiết kiệm bộ nhớ
    _pathPoints.removeWhere((p) => p.worldY < _scrollY - _segmentSpacing * 5);

    // ── Update background particles ───────────────────────────────────────
    // Mỗi hạt bay lên theo tốc độ riêng. Khi ra ngoài top thì spawn lại ở bottom.
    for (final p in _particles) {
      p.y -= p.speed * dt;
      if (p.y < 0) {
        p.y = _height + 10;
        p.x = _random.nextDouble() * _width;
      }
    }

    // ── Collision detection ───────────────────────────────────────────────
    // Tính vị trí Y của bóng trong world space rồi nội suy tâm đường tại đó.
    // Nếu bóng vượt ra ngoài biên đường (± pathWidth/2) → kích hoạt vụ nổ.
    final ballWorldY = _scrollY + _height * _ballScreenYRatio;
    final cx = _pathCenterXAt(ballWorldY);
    final pw = _pathWidthAt(ballWorldY);
    if (cx != null && pw != null) {
      final leftBound = cx - pw / 2 + _ballRadius * 0.6;
      final rightBound = cx + pw / 2 - _ballRadius * 0.6;
      if (_ballX < leftBound || _ballX > rightBound) {
        // Clamp bóng vào đúng vị trí va chạm để hiệu ứng nổ đẹp hơn
        _ballX = _ballX.clamp(leftBound, rightBound);
        _triggerExplosion(_ballX, _height * _ballScreenYRatio, seconds);
        setState(() {});
        return;
      }
    }

    widget.onScoreUpdate(seconds);
    setState(() {});
  }

  // ── Path interpolation ────────────────────────────────────────────────────
  // Tìm 2 PathPoint kẹp worldY và nội suy tuyến tính (lerp) để lấy centerX.
  // Trả về null nếu không tìm thấy (chưa có đủ segment).
  double? _pathCenterXAt(double worldY) {
    for (int i = 0; i < _pathPoints.length - 1; i++) {
      final p1 = _pathPoints[i];
      final p2 = _pathPoints[i + 1];
      if (p1.worldY <= worldY && worldY < p2.worldY) {
        final t = (worldY - p1.worldY) / (p2.worldY - p1.worldY);
        return p1.centerX + (p2.centerX - p1.centerX) * t;
      }
    }
    return null;
  }

  // Nội suy chiều rộng đường tại vị trí worldY (giữa 2 PathPoint liền kề).
  double? _pathWidthAt(double worldY) {
    for (int i = 0; i < _pathPoints.length - 1; i++) {
      final p1 = _pathPoints[i];
      final p2 = _pathPoints[i + 1];
      if (p1.worldY <= worldY && worldY < p2.worldY) {
        final t = (worldY - p1.worldY) / (p2.worldY - p1.worldY);
        return p1.width + (p2.width - p1.width) * t;
      }
    }
    return null;
  }

  // ── Widget lifecycle ──────────────────────────────────────────────────────
  // Phản ứng khi gamePhase thay đổi từ bên ngoài (BLoC emit state mới).
  @override
  void didUpdateWidget(_GameCanvas old) {
    super.didUpdateWidget(old);
    if (old.gamePhase == widget.gamePhase) {
      return;
    }
    if (widget.gamePhase == GamePhase.playing && _sizeReady) {
      _startGame();
    } else if (widget.gamePhase != GamePhase.playing) {
      _ticker.stop();
      _gameStarted = false;
    }
  }

  @override
  void dispose() {
    _ticker.dispose();
    _accelSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Lấy kích thước màn hình lần đầu tiên build
        if (!_sizeReady) {
          _width = constraints.maxWidth;
          _height = constraints.maxHeight;
          _sizeReady = true;
        }

        // Chưa có game data → chỉ vẽ background tối
        if (!_gameStarted || _pathPoints.isEmpty) {
          return _buildBackground();
        }

        // Truyền toàn bộ dữ liệu cần thiết vào CustomPainter để render
        return CustomPaint(
          painter: _GamePainter(
            pathPoints: List.unmodifiable(_pathPoints),
            particles: List.unmodifiable(_particles),
            explosionParticles: List.unmodifiable(_explosionParticles),
            scrollY: _scrollY,
            ballX: _ballX,
            ballY: _height * _ballScreenYRatio,
            ballRadius: _ballRadius,
            isExploding: _isExploding,
          ),
          size: Size(_width, _height),
          child: const SizedBox.expand(),
        );
      },
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF0D1B2A), Color(0xFF1A1A2E)],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// _GamePainter — CustomPainter vẽ toàn bộ game mỗi frame
//
// Thứ tự vẽ (painter's algorithm): background → particles → road → ball → explosion
// ─────────────────────────────────────────────────────────────────────────────

class _GamePainter extends CustomPainter {
  const _GamePainter({
    required this.pathPoints,
    required this.particles,
    required this.explosionParticles,
    required this.scrollY,
    required this.ballX,
    required this.ballY,
    required this.ballRadius,
    required this.isExploding,
  });

  final List<_PathPoint> pathPoints;
  final List<_Particle> particles;
  final List<_ExplosionParticle> explosionParticles;
  final double scrollY;
  final double ballX;
  final double ballY;
  final double ballRadius;
  final bool isExploding; // ẩn bóng khi đang nổ để tránh bóng đè lên hạt nổ

  @override
  void paint(Canvas canvas, Size size) {
    _drawBackground(canvas, size);
    _drawParticles(canvas);
    _drawRoad(canvas, size);
    // Ẩn bóng ngay khi va chạm, chỉ hiện hiệu ứng nổ
    if (!isExploding) {
      _drawBall(canvas);
    }
    if (isExploding) {
      _drawExplosion(canvas);
    }
  }

  // ── Background ────────────────────────────────────────────────────────────
  // Vẽ gradient tối từ trên xuống dưới và lưới ô vuông tạo cảm giác cyber/game.
  // Lưới dịch chuyển theo scrollY để có ảo giác di chuyển liên tục.
  void _drawBackground(Canvas canvas, Size size) {
    // Gradient nền
    final rect = Offset.zero & size;
    canvas.drawRect(
      rect,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF0D1B2A), Color(0xFF1A1A2E)],
        ).createShader(rect),
    );

    // Lưới ngang & dọc cuộn theo scrollY để tạo hiệu ứng chuyển động
    final gridPaint = Paint()
      ..color = const Color(0xFF1E3A5A).withValues(alpha: 0.4)
      ..strokeWidth = 0.5;
    const gridSpacing = 40.0;
    final offsetGrid = scrollY % gridSpacing;

    for (double y = -offsetGrid; y < size.height; y += gridSpacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }
    for (double x = 0; x < size.width; x += gridSpacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
  }

  // ── Background particles ──────────────────────────────────────────────────
  // Vẽ các chấm sáng nhỏ màu cyan bay ngược chiều để tạo cảm giác tốc độ.
  void _drawParticles(Canvas canvas) {
    for (final p in particles) {
      canvas.drawCircle(
        Offset(p.x, p.y),
        p.size,
        Paint()..color = const Color(0xFF22F3F8).withValues(alpha: p.opacity),
      );
    }
  }

  // ── Road ──────────────────────────────────────────────────────────────────
  // Vẽ đường đi gồm: phần nền đường, viền neon phát sáng, vạch kẻ giữa.
  // Dùng Bezier trung điểm để các đường cong trơn mượt, không bị gãy góc.
  // Mỗi PathPoint có width riêng để tạo hiệu ứng đường rộng/hẹp theo zone.
  void _drawRoad(Canvas canvas, Size size) {
    if (pathPoints.length < 2) {
      return;
    }

    // Chuyển PathPoint → tọa độ màn hình (mỗi điểm dùng width riêng của nó)
    final leftEdge = <Offset>[];
    final rightEdge = <Offset>[];
    for (final point in pathPoints) {
      final screenY = point.worldY - scrollY;
      leftEdge.add(Offset(point.centerX - point.width / 2, screenY));
      rightEdge.add(Offset(point.centerX + point.width / 2, screenY));
    }

    final n = leftEdge.length;

    // Helper: xây dựng path Bezier mượt qua danh sách điểm.
    // Thuật toán trung điểm: dùng P[i] làm control point, đi qua midpoint(P[i], P[i+1]).
    // Kết quả là đường cong C1-continuous, không bị gãy khúc tại các điểm nối.
    Path buildSmoothPath(List<Offset> pts) {
      final path = Path();
      if (pts.length < 2) {
        return path;
      }
      path.moveTo(pts.first.dx, pts.first.dy);
      if (pts.length == 2) {
        path.lineTo(pts.last.dx, pts.last.dy);
        return path;
      }
      // Đi đến trung điểm của segment đầu tiên
      path.lineTo((pts[0].dx + pts[1].dx) / 2, (pts[0].dy + pts[1].dy) / 2);
      // Bezier qua các điểm giữa, dùng pts[i] làm control point
      for (int i = 1; i < pts.length - 1; i++) {
        final midX = (pts[i].dx + pts[i + 1].dx) / 2;
        final midY = (pts[i].dy + pts[i + 1].dy) / 2;
        path.quadraticBezierTo(pts[i].dx, pts[i].dy, midX, midY);
      }
      path.lineTo(pts.last.dx, pts.last.dy);
      return path;
    }

    // Xây dựng polygon đường (left đi xuống, right đi ngược lên) với Bezier mượt
    final roadPath = Path();
    roadPath.moveTo(leftEdge.first.dx, leftEdge.first.dy);
    if (n >= 3) {
      roadPath.lineTo((leftEdge[0].dx + leftEdge[1].dx) / 2, (leftEdge[0].dy + leftEdge[1].dy) / 2);
      for (int i = 1; i < n - 1; i++) {
        final midX = (leftEdge[i].dx + leftEdge[i + 1].dx) / 2;
        final midY = (leftEdge[i].dy + leftEdge[i + 1].dy) / 2;
        roadPath.quadraticBezierTo(leftEdge[i].dx, leftEdge[i].dy, midX, midY);
      }
    }
    roadPath.lineTo(leftEdge.last.dx, leftEdge.last.dy);
    // Nối sang cạnh phải
    roadPath.lineTo(rightEdge.last.dx, rightEdge.last.dy);
    // Right edge đi ngược lên
    if (n >= 3) {
      roadPath.lineTo(
        (rightEdge[n - 1].dx + rightEdge[n - 2].dx) / 2,
        (rightEdge[n - 1].dy + rightEdge[n - 2].dy) / 2,
      );
      for (int i = n - 2; i >= 1; i--) {
        final midX = (rightEdge[i].dx + rightEdge[i - 1].dx) / 2;
        final midY = (rightEdge[i].dy + rightEdge[i - 1].dy) / 2;
        roadPath.quadraticBezierTo(rightEdge[i].dx, rightEdge[i].dy, midX, midY);
      }
    }
    roadPath.lineTo(rightEdge.first.dx, rightEdge.first.dy);
    roadPath.close();

    canvas.drawPath(
      roadPath,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF1E3A5A).withValues(alpha: 0.9),
            const Color(0xFF243B55).withValues(alpha: 0.95),
          ],
        ).createShader(Rect.fromLTWH(0, 0, size.width, size.height)),
    );

    // Helper: vẽ viền neon glow (dùng smooth Bezier path đã build)
    void drawGlowLine(List<Offset> points, Color color) {
      final path = buildSmoothPath(points);
      // Lớp ngoài: blur rộng tạo hào quang
      canvas.drawPath(
        path,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 6
          ..color = color.withValues(alpha: 0.3)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8),
      );
      // Lớp trong: đường solid rõ nét
      canvas.drawPath(
        path,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.5
          ..color = color,
      );
    }

    drawGlowLine(leftEdge, const Color(0xFF00A8CC));
    drawGlowLine(rightEdge, const Color(0xFF00A8CC));

    // Vạch kẻ giữa đường (dashed line)
    // dashOffset cuộn cùng với scrollY để vạch di chuyển liên tục
    final dashOffset = scrollY % 60;
    for (int i = 0; i < pathPoints.length - 1; i++) {
      final p1 = pathPoints[i];
      final p2 = pathPoints[i + 1];
      final sy1 = p1.worldY - scrollY;
      final sy2 = p2.worldY - scrollY;
      if (sy2 < 0 || sy1 > size.height) {
        continue; // bỏ qua nếu ngoài màn hình
      }

      final cx1 = p1.centerX;
      final cx2 = p2.centerX;
      final segWorldLen = p2.worldY - p1.worldY;
      final startFrac = (dashOffset % 60) / segWorldLen;

      // Mỗi vạch dài 20px, cách nhau 60px trong world space
      for (double f = startFrac; f < 1.0; f += 60 / segWorldLen) {
        final fEnd = (f + 20 / segWorldLen).clamp(0.0, 1.0);
        canvas.drawLine(
          Offset(cx1 + (cx2 - cx1) * f, sy1 + (sy2 - sy1) * f),
          Offset(cx1 + (cx2 - cx1) * fEnd, sy1 + (sy2 - sy1) * fEnd),
          Paint()
            ..color = const Color(0xFFFFFFFF).withValues(alpha: 0.2)
            ..strokeWidth = 1.5,
        );
      }
    }
  }

  // ── Ball ──────────────────────────────────────────────────────────────────
  // Vẽ bóng với 3 lớp hiệu ứng: outer glow → inner glow → body gradient.
  // Thêm highlight nhỏ ở góc trên trái để tạo cảm giác 3D.
  void _drawBall(Canvas canvas) {
    final center = Offset(ballX, ballY);

    // Lớp 1: outer glow đỏ nhạt, blur rộng
    canvas.drawCircle(
      center,
      ballRadius * 2.2,
      Paint()
        ..color = const Color(0xFFFF5757).withValues(alpha: 0.18)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 14),
    );

    // Lớp 2: inner glow cam, blur hẹp hơn
    canvas.drawCircle(
      center,
      ballRadius * 1.5,
      Paint()
        ..color = const Color(0xFFFF9F1C).withValues(alpha: 0.25)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8),
    );

    // Lớp 3: thân bóng với gradient hướng tâm (sáng ở trên, tối ở dưới)
    final ballRect = Rect.fromCircle(center: center, radius: ballRadius);
    canvas.drawCircle(
      center,
      ballRadius,
      Paint()
        ..shader = const RadialGradient(
          center: Alignment(-0.3, -0.4),
          radius: 0.9,
          colors: [Color(0xFFFF8484), Color(0xFFFF5757), Color(0xFFE03030)],
          stops: [0.0, 0.6, 1.0],
        ).createShader(ballRect),
    );

    // Highlight trắng nhỏ ở góc trên trái tạo hiệu ứng ánh sáng
    canvas.drawCircle(
      Offset(ballX - ballRadius * 0.32, ballY - ballRadius * 0.35),
      ballRadius * 0.28,
      Paint()..color = Colors.white.withValues(alpha: 0.65),
    );

    // Bóng nhỏ ở dưới tạo chiều sâu
    canvas.drawCircle(
      Offset(ballX + ballRadius * 0.2, ballY + ballRadius * 0.3),
      ballRadius * 0.15,
      Paint()..color = Colors.black.withValues(alpha: 0.3),
    );
  }

  // ── Explosion ─────────────────────────────────────────────────────────────
  // Vẽ các hạt vụ nổ. Mỗi hạt là một vòng tròn nhỏ với màu và opacity riêng.
  // Thêm glow blur để hạt trông như tia lửa.
  void _drawExplosion(Canvas canvas) {
    for (final p in explosionParticles) {
      if (p.opacity <= 0) {
        continue;
      }

      final center = Offset(p.x, p.y);

      // Vòng glow xung quanh hạt
      canvas.drawCircle(
        center,
        p.size * 2.0,
        Paint()
          ..color = p.color.withValues(alpha: p.opacity * 0.35)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6),
      );

      // Thân hạt solid
      canvas.drawCircle(center, p.size, Paint()..color = p.color.withValues(alpha: p.opacity));
    }
  }

  // shouldRepaint luôn true vì game state thay đổi mỗi frame
  @override
  bool shouldRepaint(_GamePainter old) => true;
}
