import 'package:audio_pal/enums/enums.dart';
import 'package:hotkey_manager/hotkey_manager.dart';

class AudioHotKey {
  int? id;
  final List<KeyModifier>? modifiers;
  final KeyCode keyCode;
  final String deviceName;
  final String deviceGuid;
  final DeviceType deviceType;

  AudioHotKey({
    this.id,
    required this.modifiers,
    required this.keyCode,
    required this.deviceName,
    required this.deviceGuid,
    required this.deviceType,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      // comma separated list of modifiers
      'modifiers': modifiers?.map((e) => e.index).join(',') ?? '',
      'keyCode': keyCode.index,
      'deviceName': deviceName,
      'deviceGuid': deviceGuid,
      'deviceType': deviceType.index,
    };
  }

  @override
  String toString() {
    return 'AudioHotKey2{id: $id, modifiers: $modifiers, keyCode: $keyCode, deviceName: $deviceName, deviceGuid: $deviceGuid, deviceType: $deviceType}';
  }
}
