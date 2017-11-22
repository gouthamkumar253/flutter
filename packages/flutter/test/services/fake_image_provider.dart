// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:ui' as ui show Codec;

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// An image provider implementation for testing that is using a [ui.Codec]
/// that it was given at construction time (typically the job of real image
/// providers is to resolve some data and instantiate a [ui.Codec] from it).
class FakeImageProvider extends ImageProvider<FakeImageProvider> {

  const FakeImageProvider(this._codec, { this.scale: 1.0 });

  final ui.Codec _codec;

  /// The scale to place in the [ImageInfo] object of the image.
  final double scale;

  @override
  Future<FakeImageProvider> obtainKey(ImageConfiguration configuration) {
    return new SynchronousFuture<FakeImageProvider>(this);
  }

  @override
  ImageStreamCompleter load(FakeImageProvider key) {
    assert(key == this);
    return new MultiFrameImageStreamCompleter(
      codec: new SynchronousFuture<ui.Codec>(_codec),
      scale: scale
    );
  }
}
