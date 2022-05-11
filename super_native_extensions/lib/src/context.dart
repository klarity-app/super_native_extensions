import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:nativeshell_core/nativeshell_core.dart';

MessageChannelContext _getContext() {
  final dylib = defaultTargetPlatform == TargetPlatform.android
      ? DynamicLibrary.open("libsuper_native_extensions.so")
      : (defaultTargetPlatform == TargetPlatform.windows
          ? DynamicLibrary.open("super_native_extensions.dll")
          : DynamicLibrary.process());
  final function =
      dylib.lookup<NativeFunction<MessageChannelContextInitFunction>>(
          "super_native_extensions_init_message_channel_context");
  return MessageChannelContext.forInitFunction(function);
}

final MessageChannelContext superNativeExtensionsContext = _getContext();