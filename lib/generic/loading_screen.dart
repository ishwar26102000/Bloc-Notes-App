import 'dart:async';

import 'package:basic_bloc_notes_app/generic/loading_screen_controller.dart';
import 'package:flutter/material.dart';

class LoadingScreen {
  LoadingScreen._sharedInstace();
  static final LoadingScreen _shared = LoadingScreen._sharedInstace();
  factory LoadingScreen.instance() => _shared;

  LoadingScreenController? _controller;

  void show({required BuildContext context, required String text}) {
    if (_controller?.update(text) ?? false) {
      return;
    } else {
      _controller = _showOverlay(context: context, text: text);
    }
  }

  void hide() {
    _controller?.close();
    _controller = null;
  }

  LoadingScreenController _showOverlay({
    required BuildContext context,
    required String text,
  }) {
    final text0 = StreamController<String>();
    text0.add(text);

    /// get the size
    final state = Overlay.of(context);
    final renderbox = context.findRenderObject() as RenderBox;
    final size = renderbox.size;

    final overlay = OverlayEntry(
      builder: (context) {
        return Material(
          color: Colors.black.withAlpha(150),
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                maxHeight: size.height * 0.8,
                maxWidth: size.width * 0.8,
                minWidth: size.width * 0.5,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      const CircularProgressIndicator(),
                      const SizedBox(height: 20),
                      StreamBuilder(
                        stream: text0.stream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              snapshot.data!,
                              textAlign: TextAlign.center,
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    state.insert(overlay);
    
    
    return LoadingScreenController(
      close: () {
        text0.close();

        overlay.remove();
        return true;
      },
      update: (text) {
        text0.add(text);
        return true;
      },
    );
  }
}
