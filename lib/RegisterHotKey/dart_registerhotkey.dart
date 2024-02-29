import 'dart:async';
import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef RegisterHotKeyC = Int32 Function(
    IntPtr hWnd, Int32 id, Uint32 fsModifiers, Uint32 vk);
typedef RegisterHotKeyDart = int Function(
    int hWnd, int id, int fsModifiers, int vk);

typedef UnregisterHotKeyC = Int32 Function(IntPtr hWnd, Int32 id);
typedef UnregisterHotKeyDart = int Function(int hWnd, int id);

typedef GetMessageC = Int32 Function(Pointer<NativeType> msg, IntPtr hWnd,
    Uint32 wMsgFilterMin, Uint32 wMsgFilterMax);
typedef GetMessageDart = int Function(
    Pointer<MSG> msg, int hWnd, int wMsgFilterMin, int wMsgFilterMax);

typedef PeekMessageC = Int32 Function(Pointer<NativeType> msg, IntPtr hWnd,
    Uint32 wMsgFilterMin, Uint32 wMsgFilterMax, Uint32 wRemoveMsg);
typedef PeekMessageDart = int Function(Pointer<MSG> msg, int hWnd,
    int wMsgFilterMin, int wMsgFilterMax, int wRemoveMsg);

class DartRegisterHotKey {
  late final RegisterHotKeyDart _registerHotKey;
  late final UnregisterHotKeyDart _unregisterHotKey;
  late final GetMessageDart _getMessage;
  late final PeekMessageDart _peekMessage;
  late final Stream<int> _messageStream;
  final int hWnd = 0;
  static final DartRegisterHotKey _instance = DartRegisterHotKey._internal();

  DartRegisterHotKey._internal() {
    final DynamicLibrary user32 = DynamicLibrary.open('user32.dll');

    _registerHotKey = user32
        .lookupFunction<RegisterHotKeyC, RegisterHotKeyDart>('RegisterHotKey');
    _unregisterHotKey =
        user32.lookupFunction<UnregisterHotKeyC, UnregisterHotKeyDart>(
            'UnregisterHotKey');
    _getMessage =
        user32.lookupFunction<GetMessageC, GetMessageDart>('GetMessageW');
    _peekMessage =
        user32.lookupFunction<PeekMessageC, PeekMessageDart>('PeekMessageW');
    _messageStream = createGetMessageStream();
  }

  factory DartRegisterHotKey() {
    return _instance;
  }

  int registerHotKeyWrapper(int id, int fsModifiers, int vk) {
    return _registerHotKey(hWnd, id, fsModifiers, vk);
  }

  int unregisterHotKeyWrapper(int id) {
    return _unregisterHotKey(hWnd, id);
  }

  Stream<int> get messageStream => _messageStream;

  bool _peekMessageWrapper(
      Pointer<MSG> msg, int wMsgFilterMin, int wMsgFilterMax, int wRemoveMsg) {
    return _peekMessage(msg, hWnd, wMsgFilterMin, wMsgFilterMax, wRemoveMsg) !=
        0;
  }

  Future<int?> _getMessageWrapper(
      Pointer<MSG> msg, int wMsgFilterMin, int wMsgFilterMax) async {
    return _getMessage(msg, 0, wMsgFilterMin, wMsgFilterMax);
  }

  Stream<int> createGetMessageStream() async* {
    final msg = calloc<MSG>();
    try {
      while (true) {
        await Future.delayed(const Duration(milliseconds: 100));
        while (_peekMessageWrapper(msg, 0, 0, 1)) {
          final msgRef = msg.ref;
          if (msgRef.message == 786) {
            yield msgRef.wParam;
            // print all fields of MSG
            debugPrint(
                'MSG: ${msgRef.hwnd}, ${msgRef.message}, ${msgRef.wParam}, ${msgRef.lParam}, ${msgRef.time}, ${msgRef.pt_x}, ${msgRef.pt_y}');
          } else {
            debugPrint('MSG: ${msgRef.message}');
          }
        }
      }
    } finally {
      calloc.free(msg);
    }
  }
}

sealed class MSG extends Struct {
  @IntPtr()
  external int hwnd;
  @Int32()
  external int message;
  @IntPtr()
  external int wParam;
  @IntPtr()
  external int lParam;
  @Uint32()
  external int time;
  @Int32()
  external int pt_x;
  @Int32()
  external int pt_y;
}
