import 'package:flutter/material.dart';

class RangeSliderPage extends StatefulWidget {
  const RangeSliderPage({super.key});

  @override
  State<RangeSliderPage> createState() => _RangeSliderPageState();
}

class _RangeSliderPageState extends State<RangeSliderPage> {
  double _singleValue = 40.0;
  RangeValues _rangeValues = const RangeValues(20, 80);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Range Slider'),
        actions: const [
          Icon(Icons.grid_view_rounded),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSliderCard(
              title: 'Default Slider',
              subtitle: 'Default single slider style',
              child: Column(
                children: [
                  Slider(
                    value: _singleValue,
                    min: 0,
                    max: 100,
                    activeColor: const Color(0xFF8E44AD),
                    onChanged: (double value) {
                      setState(() {
                        _singleValue = value;
                      });
                    },
                  ),
                  Text('Value: ${_singleValue.round()}', 
                    style: TextStyle(color: Colors.grey[600])),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildSliderCard(
              title: 'Range Slider',
              subtitle: 'Slider with start and end values',
              child: Column(
                children: [
                  RangeSlider(
                    values: _rangeValues,
                    min: 0,
                    max: 100,
                    activeColor: const Color(0xFF8E44AD),
                    labels: RangeLabels(
                      _rangeValues.start.round().toString(),
                      _rangeValues.end.round().toString(),
                    ),
                    onChanged: (RangeValues values) {
                      setState(() {
                        _rangeValues = values;
                      });
                    },
                  ),
                  Text(
                    'Range: ${_rangeValues.start.round()} - ${_rangeValues.end.round()}',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSliderCard({required String title, required String subtitle, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 14)),
          const Divider(height: 30),
          child,
        ],
      ),
    );
  }
}