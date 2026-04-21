import 'package:flutter/material.dart';
import 'package:responsi1apb/screens/job/apply_job.dart';

class DetailJobPage extends StatelessWidget {
  final String companyName;
  final String jobTitle;
  final String salary;
  final String location;
  final String logoPath;

  const DetailJobPage({
    super.key,
    required this.companyName,
    required this.jobTitle,
    required this.salary,
    required this.location,
    required this.logoPath,
  });

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF673AB7);
    const Color bgColor = Color(0xFFF7F7F7);
    const Color titleColor = Color(0xFF212529);
    const Color textColor = Color(0xFF7E7E7E);
    const Color softPurple = Color(0xFFF3EDF9);
    const Color borderSoft = Color(0xFFE9E1F4);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 74,
              padding: const EdgeInsets.symmetric(horizontal: 18),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(color: Color(0xFFEAEAEA)),
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Color(0xFF9A9A9A),
                      size: 24,
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Details',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: titleColor,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.bookmark_border_rounded,
                      color: primaryColor,
                      size: 28,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(18, 22, 18, 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                companyName,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: textColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                jobTitle,
                                style: const TextStyle(
                                  fontSize: 22,
                                  height: 1.2,
                                  fontWeight: FontWeight.w700,
                                  color: titleColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            logoPath,
                            width: 108,
                            height: 108,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 108,
                                height: 108,
                                color: Colors.blue,
                                alignment: Alignment.center,
                                child: const Icon(
                                  Icons.image_not_supported,
                                  color: Colors.white,
                                  size: 32,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 44,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _buildChip('Fulltime', primaryColor, borderSoft),
                          const SizedBox(width: 12),
                          _buildChip('Remote Working', primaryColor, borderSoft),
                          const SizedBox(width: 12),
                          _buildChip('Hourly', primaryColor, borderSoft),
                          const SizedBox(width: 12),
                          _buildChip('Remote', primaryColor, borderSoft),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),
                    const Divider(color: Color(0xFFE8E8E8), height: 1),
                    const SizedBox(height: 28),
                    _buildInfoTile(
                      icon: Icons.monetization_on_outlined,
                      title: 'Salary',
                      value: '$salary/monthly',
                      iconBg: softPurple,
                      iconColor: primaryColor,
                    ),
                    const SizedBox(height: 18),
                    _buildInfoTile(
                      icon: Icons.work_outline_rounded,
                      title: 'Location',
                      value: location,
                      iconBg: softPurple,
                      iconColor: primaryColor,
                    ),
                    const SizedBox(height: 28),
                    const Divider(color: Color(0xFFE8E8E8), height: 1),
                    const SizedBox(height: 28),
                    const Text(
                      'Job Description',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: titleColor,
                      ),
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.6,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildCheckItem('Sed ut perspiciatis unde omnis', primaryColor),
                    _buildCheckItem('Doloremque laudantium', primaryColor),
                    _buildCheckItem('Ipsa quae ab illo inventore', primaryColor),
                    _buildCheckItem('Architecto beatae vitae dicta', primaryColor),
                    _buildCheckItem('Sunt explicabo', primaryColor),
                    const SizedBox(height: 28),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(18, 14, 18, 18),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: Color(0xFFEAEAEA)),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: const Color(0xFFE5E5E5)),
                    ),
                    child: const Icon(
                      Icons.bookmark_border_rounded,
                      color: primaryColor,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: SizedBox(
                      height: 58,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ApplyJobPage(
                                companyName: companyName,
                                jobTitle: jobTitle,
                                logoPath: logoPath,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22),
                          ),
                        ),
                        child: const Text(
                          'APPLY JOB',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: 0.4,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(String text, Color color, Color borderColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: borderColor),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    required String value,
    required Color iconBg,
    required Color iconColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: iconBg,
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFE3DCEF)),
          ),
          child: Icon(icon, color: iconColor, size: 34),
        ),
        const SizedBox(width: 18),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF7E7E7E),
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  color: Color(0xFF212529),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCheckItem(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle, color: color, size: 24),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                height: 1.35,
                color: Color(0xFF212529),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}