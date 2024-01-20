import 'package:flutter/material.dart';
import 'package:maseef_app/core/app_export.dart';
import 'package:maseef_app/widgets/scaffold_background.dart';

class PrivacyPolicy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy'),
        leading: IconButton(onPressed: () {
          Get.back();
        }, icon: Icon(Icons.arrow_back_ios)),
      ),
      body: ScaffoldBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Introduction',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'This Privacy Policy describes how we collect, use, and disclose your personal information when you use our services.',
                ),
                SizedBox(height: 16.0),
        
                Text(
                  'Information We Collect',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'We collect the following information from you:',
                ),
                SizedBox(height: 8.0),
                Text(
                  '* Your name',
                ),
                SizedBox(height: 8.0),
                Text(
                  '* Your email address',
                ),
                SizedBox(height: 8.0),
                Text(
                  '* Your phone number',
                ),
                SizedBox(height: 8.0),
                Text(
                  '* Your location',
                ),
                SizedBox(height: 8.0),
                Text(
                  '* Your IP address',
                ),
                SizedBox(height: 16.0),
        
                Text(
                  'How We Use Your Information',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'We use your information to:',
                ),
                SizedBox(height: 8.0),
                Text(
                  '* Provide you with our services',
                ),
                SizedBox(height: 8.0),
                Text(
                  '* Improve our services',
                ),
                SizedBox(height: 8.0),
                Text(
                  '* Customize your experience',
                ),
                SizedBox(height: 8.0),
                Text(
                  '* Market our services to you',
                ),
                SizedBox(height: 16.0),
        
                Text(
                  'How We Share Your Information',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'We share your information with:',
                ),
                SizedBox(height: 8.0),
                Text(
                  '* Our service providers',
                ),
                SizedBox(height: 8.0),
                Text(
                  '* Our business partners',
                ),
                SizedBox(height: 8.0),
                Text(
                  '* Law enforcement agencies',
                ),
                SizedBox(height: 8.0),
                Text(
                  '* Government agencies',
                ),
                SizedBox(height: 16.0),
        
                Text(
                  'Your Rights',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'You have the following rights:',
                ),
                SizedBox(height: 8.0),
                Text(
                  '* The right to access your information',
                ),
                SizedBox(height: 8.0),
                Text(
                  '* The right to correct your information',
                ),
                SizedBox(height: 8.0),
                Text(
                  '* The right to delete your information',
                ),
                SizedBox(height: 8.0),
                Text(
                  '* The right to object to the processing of your information',
                ),
                SizedBox(height: 8.0),
                Text(
                  '* The right to data portability',
                ),
                SizedBox(height: 16.0),
        
                Text(
                  'Changes to This Privacy Policy',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'We may update this Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on our website.',
                ),
                SizedBox(height: 16.0),
        
                Text(
                  'Contact Us',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'If you have any questions about this Privacy Policy, please contact us at [email protected]',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}