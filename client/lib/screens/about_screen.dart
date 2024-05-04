import 'package:flutter/material.dart';

import '../widgets/custom_appbar.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "About",
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("App Version"),
            _buildSectionContent("1.0.0"), // Replace with your actual version number

            _buildSectionTitle("Developer"),
            _buildSectionContent("Ninad Bangal"),

            _buildSectionTitle("Acknowledgments"),
            _buildSectionContent("three_dart: ^0.0.14\n"
                "three_dart_jsm: ^0.0.9\n"
                "flutter_gl: ^0.0.21"),

            _buildSectionTitle("Technologies"),
            _buildSectionContent("Frontend: Flutter\n"
                "Backend: Node.js\n"
                "Database: MongoDB"),

            _buildSectionTitle("Legal Information"),
            _buildSectionContent(_termsOfService()),
            _buildSectionContent(_privacyPolicy()),

            _buildSectionTitle("Description"),
            _buildSectionContent("This is a to-do app where users can manage their tasks. Users can create profiles, add tasks with titles, descriptions, and completion status. They can view single tasks, lists of tasks, and delete tasks. Additionally, users can edit their profile, change passwords, logout, and delete accounts."),

            _buildSectionTitle("Feedback/Contact"),
            _buildSectionContent("Contact us at: ninadbangal99@gmail.com"),

            _buildSectionTitle("Credits"),
            _buildSectionContent("Designed and developed by Ninad Bangal"),

            _buildSectionTitle("Changelog"),
            _buildSectionContent("Version 1.0.0 - Initial Release"),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSectionContent(String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: RichText(
        textAlign: TextAlign.justify,
        text: TextSpan(
          style: const TextStyle(fontSize: 16, color: Colors.black),
          children: [
            TextSpan(text: content),
          ],
        ),
      ),
    );
  }

  String _termsOfService() {
    return """
      Welcome to our app! By using this app, you agree to comply with and be bound by the following terms and conditions of use. Please review these terms carefully. If you do not agree to these terms, you should not use this app.

      The use of this app is subject to the following terms of service:
      - The content of the pages of this app is for your general information and use only. It is subject to change without notice.
      - Your use of any information or materials on this app is entirely at your own risk, for which we shall not be liable. It shall be your own responsibility to ensure that any products, services, or information available through this app meet your specific requirements.
      - This app contains material which is owned by or licensed to us. This material includes, but is not limited to, the design, layout, look, appearance, and graphics. Reproduction is prohibited other than in accordance with the copyright notice, which forms part of these terms and conditions.
      - All trademarks reproduced in this app, which are not the property of, or licensed to the operator, are acknowledged on the app.
      - Unauthorized use of this app may give rise to a claim for damages and/or be a criminal offense.
      - From time to time, this app may also include links to other apps. These links are provided for your convenience to provide further information. They do not signify that we endorse the app(s). We have no responsibility for the content of the linked app(s).
      - Your use of this app and any dispute arising out of such use of the app is subject to the laws of [Your Country/State].

      For any questions regarding the Terms of Service, please contact us at ninadbangal99@gmail.com.
    """;
  }

  String _privacyPolicy() {
    return """
      We are committed to protecting your privacy. This privacy policy governs our collection, processing, and usage of your personal data. Please read the following privacy policy carefully to understand how we use and protect the information that you provide to us.

      - Information we collect:
        We collect personal information such as your name, email address, and profile information when you register an account with us or use our services. We may also collect non-personal information such as device information and usage statistics.
      - How we use your information:
        We use your personal information to provide and improve our services, communicate with you, and personalize your experience. We may also use your information to send you promotional emails or newsletters.
      - Data security:
        We implement appropriate technical and organizational measures to protect your personal data against unauthorized access, alteration, disclosure, or destruction.
      - Third-party services:
        We may use third-party services to help us operate our app or administer activities on our behalf, such as sending out newsletters or surveys. We may share your information with these third parties for those limited purposes provided that you have given us your permission.
      - Changes to this privacy policy:
        We reserve the right to update or change our privacy policy at any time. Any changes to the privacy policy will be posted on this page.

      By using our app, you consent to our privacy policy.

      For any questions regarding the Privacy Policy, please contact us at ninadbangal99@gmail.com.
    """;
  }
}
