import 'package:flutter/material.dart';
import 'package:maseef_app/widgets/scaffold_background.dart';

import '../../../core/app_export.dart';

class TermsAndConditions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms & Conditions'),
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
                  'These Terms & Conditions govern your use of our services. By using our services, you agree to these Terms & Conditions.',
                ),
                SizedBox(height: 16.0),
        
                Text(
                  'Use of Our Services',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'You may use our services only for lawful purposes.',
                ),
                SizedBox(height: 8.0),
                Text(
                  'You may not use our services to:',
                ),
                SizedBox(height: 8.0),
                Text(
                  '* Infringe the intellectual property rights of others',
                ),
                SizedBox(height: 8.0),
                Text(
                  '* Violate the privacy of others',
                ),
                SizedBox(height: 8.0),
                Text(
                  '* Send spam or other unsolicited communications',
                ),
                SizedBox(height: 8.0),
                Text(
                  '* Engage in any other activity that is harmful or illegal',
                ),
                SizedBox(height: 16.0),
        
                Text(
                  'Content',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'The content on our services is provided for your information and entertainment only.',
                ),
                SizedBox(height: 8.0),
                Text(
                  'We do not endorse or guarantee the accuracy or completeness of the content on our services.',
                ),
                SizedBox(height: 16.0),
        
                Text(
                  'Disclaimer of Warranties',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'OUR SERVICES ARE PROVIDED "AS IS" AND "AS AVAILABLE" WITHOUT ANY WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, AND NON-INFRINGEMENT.',
                ),
                SizedBox(height: 16.0),
        
                Text(
                  'Limitation of Liability',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'IN NO EVENT SHALL WE BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES, INCLUDING, BUT NOT LIMITED TO, DAMAGES FOR LOSS OF PROFITS, GOODWILL, USE, DATA, OR OTHER INTANGIBLE LOSSES (EVEN IF WE HAVE BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES), ARISING OUT OF OR IN ANY WAY CONNECTED WITH THE USE OF OR INABILITY TO USE OUR SERVICES.',
                ),
                SizedBox(height: 16.0),
        
                Text(
                  'Indemnification',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                    'You agree to indemnify and hold us harmless from and against any and all claims, losses, damages, liabilities, costs, and expenses, including reasonable attorney\'s fees, arising out of or in connection with your use of our services.',
                ),
                SizedBox(height: 16.0),
        
                Text(
                  'Governing Law',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'These Terms & Conditions shall be governed by and construed in accordance with the laws of the State of California, without regard to its conflict of law provisions.',
                ),
                SizedBox(height: 16.0),
        
                Text(
                  'Severability',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'If any provision of these Terms & Conditions shall be held to be invalid or unenforceable, such provision shall be struck and the remaining provisions shall remain in full force and effect.',
                ),
                SizedBox(height: 16.0),
        
                Text(
                  'Entire Agreement',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'These Terms & Conditions constitute the entire agreement between you and us with respect to the subject matter hereof and supersede all prior or contemporaneous communications, representations, or agreements, whether oral or written.',
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
                  'If you have any questions about these Terms & Conditions, please contact us at [email protected]',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}