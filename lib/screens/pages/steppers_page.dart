import 'package:flutter/material.dart';

class SteppersPage extends StatefulWidget {
  const SteppersPage({super.key});

  @override
  State<SteppersPage> createState() => _SteppersPageState();
}

class _SteppersPageState extends State<SteppersPage> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Steppers'),
        actions: const [
          Icon(Icons.grid_view_rounded),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildStepperCard(
              title: 'Default Steppers',
              subtitle: 'Default steppers style',
              child: Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme.light(primary: Color(0xFF8E44AD)),
                ),
                child: Stepper(
                  physics: const ClampingScrollPhysics(), 
                  currentStep: _currentStep,
                  onStepTapped: (step) => setState(() => _currentStep = step),
                  onStepContinue: () {
                    if (_currentStep < 2) setState(() => _currentStep += 1);
                  },
                  onStepCancel: () {
                    if (_currentStep > 0) setState(() => _currentStep -= 1);
                  },
                  steps: [
                    Step(
                      title: const Text('Design'),
                      subtitle: const Text('Setup your design'),
                      content: const Text('This is the first step of the design process.'),
                      isActive: _currentStep >= 0,
                      state: _currentStep > 0 ? StepState.complete : StepState.indexed,
                    ),
                    Step(
                      title: const Text('Development'),
                      subtitle: const Text('Start coding'),
                      content: const Text('Here you can build the core features.'),
                      isActive: _currentStep >= 1,
                      state: _currentStep > 1 ? StepState.complete : StepState.indexed,
                    ),
                    Step(
                      title: const Text('Deployment'),
                      subtitle: const Text('Go live'),
                      content: const Text('Final check before launching the app.'),
                      isActive: _currentStep >= 2,
                    ),
                  ],
                  controlsBuilder: (context, details) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Row(
                        children: [
                          ElevatedButton(
                            onPressed: details.onStepContinue,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF8E44AD),
                              foregroundColor: Colors.white,
                              elevation: 0,
                            ),
                            child: const Text('Next'),
                          ),
                          const SizedBox(width: 12),
                          TextButton(
                            onPressed: details.onStepCancel,
                            child: const Text('Back', style: TextStyle(color: Colors.grey)),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepperCard({required String title, required String subtitle, required Widget child}) {
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