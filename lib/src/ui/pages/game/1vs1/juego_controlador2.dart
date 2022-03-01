import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:puzle_hack/src/domain/models/move_to.dart';
import 'package:puzle_hack/src/domain/models/puzzle.dart';
import 'package:puzle_hack/src/domain/models/puzzle_image.dart';
import 'package:puzle_hack/src/domain/models/tile.dart';
import 'package:puzle_hack/src/domain/repositories/audio_repository.dart';
import 'package:puzle_hack/src/domain/repositories/images_repository.dart';
import 'package:puzle_hack/src/ui/pages/game/1vs1/estado_juego2.dart';
import 'package:puzle_hack/src/ui/pages/game/controller/estado_juego.dart';

class GameController2 extends ChangeNotifier {
  final ImagesRepository _imagesRepository = GetIt.I.get();
  final AudioRepository audioRepository = GetIt.I.get();

  GameState2 _state = GameState2(
    crossAxisCount: 3,
    puzzle: Puzzle.create(3),
    solved: false,
    moves: 0,
    status: GameStatus2.created,
    sound: true,
    vibration: true,
  );

  final ValueNotifier<int> time = ValueNotifier(0);

  final StreamController<void> _streamController = StreamController.broadcast();

  Stream<void> get onFinish => _streamController.stream;

  Timer? _timer;

  GameState2 get state => _state;

  Puzzle get puzzle => _state.puzzle;

  void onTileTapped(Tile tile) {
    final canMove = puzzle.canMove(tile.position);

    if (canMove) {
      final newPuzzle = puzzle.move(tile);

      final solved = newPuzzle.isSolved();
      _state = state.copyWith(
        puzzle: newPuzzle,
        moves: state.moves + 1,
        status: solved ? GameStatus2.solved : state.status,
      );
      notifyListeners();

      if (state.vibration) {
        HapticFeedback.lightImpact();
      }

      if (state.sound) {
       
       
        audioRepository.playMove();
      }

      if (solved) {
        _timer?.cancel(); 
        _streamController.sink.add(null);
      }
    }
  }

   void shuffle() {
    if (_timer != null) {
      time.value = 0;
      _timer!.cancel();
    }
    _state = state.copyWith(
      puzzle: puzzle.shuffle(),
      status: GameStatus2.playing,
      moves: 0,
    );
    notifyListeners();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        time.value++;
      },
    );
  }
 
  Future<void> changeGrid(
    int crossAxisCount,
    PuzzleImage? image,
  ) async {
    _timer?.cancel();
    time.value = 0;

    List<Uint8List>? segmentedImage;

    if (image != null) {
      segmentedImage = await _imagesRepository.split(
        image.assetPath,
        crossAxisCount,
      );
    }

    /// reset the game with a new puzzle
    final newState = GameState2(
      crossAxisCount: crossAxisCount,
      puzzle: Puzzle.create(
        crossAxisCount,
        segmentedImage: segmentedImage,
        image: image,
      ),
      solved: false,
      moves: 0,
      status: GameStatus2.created,
      sound: state.sound,
      vibration: state.vibration,
    );
    _state = newState;
    notifyListeners();
  }

  void toggleSound() {
    _state = state.copyWith(
      sound: !state.sound,
    );
    notifyListeners();
  }

  void toggleVibration() {
    _state = state.copyWith(
      vibration: !state.vibration,
    );
    notifyListeners();
  }

  /// handle the keyboard events and  check if
  /// the keyboard action can move a tile using as
  /// reference the empty position
  void onMoveByKeyboard(MoveTo moveTo) {
    final index = _handleKeyboard(moveTo, state);

    if (index != null) {
      onTileTapped(
        puzzle.tiles[index],
      );
    }
  }


  int? _handleKeyboard(MoveTo moveTo, GameState2 state) {
    final crossAxisCount = state.crossAxisCount;
    final emptyPosition = puzzle.emptyPosition;
    final tiles = puzzle.tiles;

    /// will store the tile index to be moved
    int? index;

    switch (moveTo) {
      case MoveTo.up:
        if (emptyPosition.y + 1 <= crossAxisCount) {
          index = tiles.indexWhere(
            (e) {
              return e.position.x == emptyPosition.x && e.position.y == emptyPosition.y + 1;
            },
          );
        }
        break;
      case MoveTo.down:
        if (emptyPosition.y > 0) {
          index = tiles.indexWhere(
            (e) {
              return e.position.x == emptyPosition.x && e.position.y == emptyPosition.y - 1;
            },
          );
        }
        break;
      case MoveTo.left:
        if (emptyPosition.x >= 1) {
          index = tiles.indexWhere(
            (e) {
              return e.position.x - 1 == emptyPosition.x && e.position.y == emptyPosition.y;
            },
          );
        }
        break;
      case MoveTo.right:
        if (emptyPosition.x <= crossAxisCount) {
          index = tiles.indexWhere(
            (e) {
              return e.position.x + 1 == emptyPosition.x && e.position.y == emptyPosition.y;
            },
          );
        }
        break;
    }

    return index;
  }

  /// release memory
  @override
  void dispose() {
    _streamController.close();
    _timer?.cancel();
    super.dispose();
  }
}
