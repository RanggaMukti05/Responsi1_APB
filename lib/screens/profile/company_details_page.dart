import 'package:flutter/material.dart';

class CompanyDetailsPage extends StatelessWidget {
  final String companyName;
  final String logoPath;

  const CompanyDetailsPage({
    super.key,
    required this.companyName,
    required this.logoPath,
  });

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF6F42C1);
    const Color bgColor = Color(0xFFF6F6F6);
    const Color titleColor = Color(0xFF212529);
    const Color textColor = Color(0xFF8E8E93);
    const Color softPurple = Color(0xFFF3EDF9);
    const Color borderSoft = Color(0xFFE7DDF6);
    const Color starColor = Color(0xFFFF992E);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 305,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.asset(
                                'assets/images/company_cover.jpg',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey.shade300,
                                    child: const Icon(
                                      Icons.broken_image,
                                      size: 50,
                                      color: Colors.grey,
                                    ),
                                  );
                                },
                              ),
                              Container(
                                color: Colors.black.withValues(alpha: 0.12),
                              ),
                            ],
                          ),
                        ),

                        Positioned(
                          top: 12,
                          left: 10,
                          right: 10,
                          child: SizedBox(
                            height: 60,
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () => Navigator.pop(context),
                                  icon: const Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                    color: Colors.white,
                                    size: 26,
                                  ),
                                ),
                                const Expanded(
                                  child: Center(
                                    child: Text(
                                      'Company Details',
                                      style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Icon(
                                    Icons.grid_view_rounded,
                                    color: Colors.white,
                                    size: 28,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        Positioned(
                          left: 22,
                          right: 22,
                          top: 236,
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.fromLTRB(18, 18, 18, 22),
                            decoration: BoxDecoration(
                              color: bgColor,
                              borderRadius: BorderRadius.circular(0),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 66,
                                      height: 66,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withValues(
                                              alpha: 0.04,
                                            ),
                                            blurRadius: 10,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(14),
                                        child: Image.asset(
                                          logoPath,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Container(
                                              color: primaryColor.withValues(
                                                alpha: 0.1,
                                              ),
                                              child: const Icon(
                                                Icons.business,
                                                color: primaryColor,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '$companyName.',
                                            style: const TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w700,
                                              color: titleColor,
                                              height: 1.15,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          const Text(
                                            'Medan, Indonesia',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: textColor,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      children: const [
                                        Icon(
                                          Icons.star_rounded,
                                          color: starColor,
                                          size: 30,
                                        ),
                                        SizedBox(height: 2),
                                        Text(
                                          '4.5',
                                          style: TextStyle(
                                            color: Color(0xFFFFB400),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    Container(
                      width: double.infinity,
                      color: bgColor,
                      padding: const EdgeInsets.fromLTRB(24, 34, 24, 28),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          const Divider(color: Color(0xFFEAEAEA), height: 1),
                          const SizedBox(height: 22),

                          _buildInfoRow(
                            icon: Icons.call_rounded,
                            label: 'Telephone',
                            value: '+51 632 445 556',
                            iconBg: softPurple,
                            iconBorder: borderSoft,
                            iconColor: primaryColor,
                          ),
                          const SizedBox(height: 20),
                          _buildInfoRow(
                            icon: Icons.mail_rounded,
                            label: 'Email',
                            value: 'highspeedst@mail.com',
                            iconBg: softPurple,
                            iconBorder: borderSoft,
                            iconColor: primaryColor,
                          ),
                          const SizedBox(height: 20),
                          _buildInfoRow(
                            icon: Icons.location_on_rounded,
                            label: 'Website',
                            value: 'highspeed.studio',
                            iconBg: softPurple,
                            iconBorder: borderSoft,
                            iconColor: primaryColor,
                          ),

                          const SizedBox(height: 30),
                          const Text(
                            'About Company',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: titleColor,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                            style: TextStyle(
                              fontSize: 16,
                              color: textColor,
                              height: 1.65,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 18),
                          const Text(
                            'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in',
                            style: TextStyle(
                              fontSize: 16,
                              color: textColor,
                              height: 1.65,
                              fontWeight: FontWeight.w400,
                            ),
                          ),

                          const SizedBox(height: 34),

                          SizedBox(
                            width: double.infinity,
                            height: 62,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(34),
                                ),
                              ),
                              child: Row(
                                children: const [
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        '21 Available Jobs',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.white,
                                    size: 22,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    required Color iconBg,
    required Color iconBorder,
    required Color iconColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: iconBg,
            border: Border.all(color: iconBorder),
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 30,
          ),
        ),
        const SizedBox(width: 18),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF8E8E93),
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  color: Color(0xFF111111),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}