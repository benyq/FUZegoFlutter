import 'package:flutter/material.dart';

class ZegoSliderBar extends StatefulWidget {
  const ZegoSliderBar(
      {Key? key,
      this.progressStream,
      required this.onProgressChanged,
      this.value = 0,
      this.min = 0.0,
      this.max = 1.0,
      this.realTimeRefresh = false})
      : super(key: key);

  final Stream<double>? progressStream;
  final Function(double) onProgressChanged;
  final double value;
  final double min;
  final double max;
  final bool realTimeRefresh;

  @override
  _ZegoSliderBarState createState() => _ZegoSliderBarState();
}

class _ZegoSliderBarState extends State<ZegoSliderBar> {
  late double _playProgress;

  void setPlayProgress(double progress) {
    if (progress > widget.max || progress < widget.min) {
      return;
    }
    setState(() {
      _playProgress = progress;
    });
  }

  @override
  void initState() {
    super.initState();

    _playProgress = widget.value;
    widget.progressStream?.listen(setPlayProgress);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Slider(
        min: widget.min,
        max: widget.max,
        value: _playProgress,
        onChanged: (double value) {
          setState(() => _playProgress = value);
          if (widget.realTimeRefresh) {
            widget.onProgressChanged(value);
          }
        },
        onChangeEnd: widget.onProgressChanged);
  }
}
