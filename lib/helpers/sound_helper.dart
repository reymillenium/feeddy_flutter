// Packages:
import 'package:feeddy_flutter/_inner_packages.dart';
import 'package:feeddy_flutter/_external_packages.dart';

// Helpers:

// Utilities:

class SoundHelper {
  // Properties:
  final AudioCache player = AudioCache(prefix: 'assets/audio/');

  // ***********************************************************************************
  // *                * * *  S O U N D  R E P R O D U C T I O N  * * *                 *
  // ***********************************************************************************

  // Plays a click sound:
  void playSmallButtonClick({double volume = 1.00}) {
    playNote(fileName: 'zapsplat_multimedia_notification_pop_message_tooltip_small_click_007_63077.mp3', volume: volume);
  }

  // Plays a sound from a given file name and the volume:
  void playNote({String fileName, double volume = 1.00}) {
    player.play(fileName, volume: volume);
  }
}
