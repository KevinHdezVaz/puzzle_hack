import 'dart:typed_data';
import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart';
import 'package:puzle_hack/src/domain/models/puzzle_image.dart';
import 'package:puzle_hack/src/domain/repositories/images_repository.dart';

const puzzleOptions = <PuzzleImage>[
  PuzzleImage(
    name: 'Numerico',
    assetPath: 'assets/figuras/numeric-puzzle.png',
    soundPath: 'assets/sounds/clika.mp3',
  ),

   PuzzleImage(
    name: 'Gallina',
    assetPath: 'assets/figuras/tigre.png',
    soundPath: 'assets/sounds/clika.mp3',
  ),

  PuzzleImage(
    name: 'Leon',
    assetPath: 'assets/figuras/leon.webp',
    soundPath: 'assets/sounds/clika.mp3',
  ),
  PuzzleImage(
    name: 'Koala',
    assetPath: 'assets/figuras/koala.webp',
    soundPath: 'assets/sounds/clika.mp3',
  ),
  PuzzleImage(
    name: 'Pato',
    assetPath: 'assets/figuras/tucan.png',
    soundPath: 'assets/sounds/clika.mp3',
  ),
  PuzzleImage(
    name: 'Perro',
    assetPath: 'assets/figuras/perro.png',
    soundPath: 'assets/sounds/clika.mp3',
  ),
  PuzzleImage(
    name: 'Koala',
    assetPath: 'assets/figuras/tiburon.png',
    soundPath: 'assets/sounds/clika.mp3',
  ),
  PuzzleImage(
    name: '2vs2',
    assetPath: 'assets/figuras/tiburon.png',
    soundPath: 'assets/sounds/clika.mp3',
  )
];

Future<Image> decodeAsset(ByteData bytes) async {
  return decodeImage(
    bytes.buffer.asUint8List(),
  )!;
}

class SPlitData {
  final Image image;
  final int crossAxisCount;
  SPlitData(this.image, this.crossAxisCount);
}

Future<List<Uint8List>> splitImage(SPlitData data) {
  final image = data.image;
  final crossAxisCount = data.crossAxisCount;
  final int length = (image.width / crossAxisCount).round();
  List<Uint8List> pieceList = [];

  for (int y = 0; y < crossAxisCount; y++) {
    for (int x = 0; x < crossAxisCount; x++) {

      
      pieceList.add(
        Uint8List.fromList(
          encodePng(
            copyCrop(
              image,
              x * length,
              y * length,
              length,
              length,
            ),
          ),
        ),
      );
    }
  }
  return Future.value(pieceList);
}

class ImagesRepositoryImpl implements ImagesRepository {
  Map<String, Image> cache = {};

  @override
  Future<List<Uint8List>> split(String asset, int crossAxisCount) async {
    late Image image;
    if (cache.containsKey(asset)) {
      image = cache[asset]!;
    } else {
      final bytes = await rootBundle.load(asset);

   
      image = await compute(decodeAsset, bytes);

      final width = math.min(image.width, image.height);

      /// convert to square
      image = copyResizeCropSquare(image, width);
      cache[asset] = image;
    }

    final pieces = await compute(
      splitImage,
      SPlitData(image, crossAxisCount),
    );

    return pieces;
  }
}
