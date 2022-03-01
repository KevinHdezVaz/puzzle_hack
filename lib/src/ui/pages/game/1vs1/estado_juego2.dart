import 'package:equatable/equatable.dart';
import 'package:puzle_hack/src/domain/models/puzzle.dart';

enum GameStatus2 {
  created,
  playing,
  solved,
}

class GameState2 extends Equatable {
 
  final int crossAxisCount;
  final Puzzle puzzle;
  final bool solved;
  final int moves;
  final GameStatus2 status;
  final bool vibration;
  final bool sound;

  const GameState2({
    required this.crossAxisCount,
    required this.puzzle,
    required this.solved,
    required this.moves,
    required this.status,
    required this.vibration,
    required this.sound,
  }) : assert(crossAxisCount >= 3);

  GameState2 copyWith({
    int? crossAxisCount,
    int? moves,
    Puzzle? puzzle,
    bool? solved,
    GameStatus2? status,
    bool? sound,
    bool? vibration,
  }) {
    return GameState2(
      status: status ?? this.status,
      moves: moves ?? this.moves,
      crossAxisCount: crossAxisCount ?? this.crossAxisCount,
      puzzle: puzzle ?? this.puzzle,
      solved: solved ?? this.solved,
      sound: sound ?? this.sound,
      vibration: vibration ?? this.vibration,
    );
  }

  @override
  List<Object?> get props => [
        moves,
        crossAxisCount,
        puzzle,
        solved,
        status,
        sound,
        vibration,
      ];
}
