import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/custom_appbar.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Contact",
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("Contact Information"),
            _buildSectionContent("Email: ninadbangal99@gmail.com"),
            _buildSectionContent("Phone: +918355981708"),
            _buildSectionContent("Address: Mumbai, Maharashtra, India"),

            _buildSectionTitle("Feedback"),
            _buildSectionContent("We'd love to hear from you! If you have any questions, suggestions, or feedback, please don't hesitate to contact us."),

            _buildSectionTitle("LinkedIn"),
            _buildSectionContent("Connect with us on LinkedIn:"),
            _buildLinkedinLink(),
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
      child: Text(
        content,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildLinkedinLink() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: GestureDetector(
        onTap: () => _launchLinkedInProfile(),
        child: const Text.rich(
          TextSpan(
            text: "Ninad Bangal LinkedIn Profile: ",
            style: TextStyle(
              fontSize: 16,
            ),
            children: [
              TextSpan(
                text: "LinkedIn",
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  void _launchLinkedInProfile() async {
    const url = "https://www.linkedin.com/search/results/all/?fetchDeterministicClustersOnly=true&heroEntityKey=urn%3Ali%3Afsd_profile%3AACoAADKvnH4BF1JIbNXBiVJItP5pE7OzT0wML9o&keywords=ninad%20bangal&origin=RICH_QUERY_SUGGESTION&position=0&searchId=9228d56d-ed59-4701-b631-ed6de4a489dc&sid=%3BE0&spellCorrectionEnabled=false";
    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error launching URL: $e');
    }
  }

}
