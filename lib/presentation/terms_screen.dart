import 'package:diary_flutter/presentation/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class TermsScreen extends HookWidget {
  static const String routeName = '/terms';
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();
    final isBottomReached = useState(false);
    final isChecked = useState(false);

    useEffect(() {
      void checkScrollPosition() {
        if (!scrollController.hasClients) return;

        if (scrollController.position.maxScrollExtent == 0 ||
            scrollController.offset >=
                    scrollController.position.maxScrollExtent &&
                !scrollController.position.outOfRange) {
          isBottomReached.value = true;
        }
      }

      // 초기 상태 확인
      WidgetsBinding.instance.addPostFrameCallback((_) {
        checkScrollPosition();
      });

      // 스크롤 이벤트 리스너 추가
      scrollController.addListener(checkScrollPosition);

      return () {
        scrollController.removeListener(checkScrollPosition);
      };
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms of Service'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          children: [
            Flexible(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Your privacy is of utmost importance to us. It is our unwavering policy to respect your privacy regarding any and all information we may collect from you across our application, Diary, and other sites we own and operate.\n\nWe only request personal information when it is truly necessary to provide a service to you. We collect this information by fair and lawful means, always with your full knowledge and consent. We also want to ensure that you are fully aware of why we are collecting your information and how it will be used.\n\nWe retain collected information only for as long as is necessary to provide you with your requested service. Any data we store, we will protect using commercially acceptable means to prevent loss and theft, as well as unauthorized access, disclosure, copying, use, or modification. We implement a variety of security measures to maintain the safety of your personal information when you enter, submit, or access your personal information.\n\nWe do not share any personally identifying information publicly or with third parties, except when required to do so by law. We may use your personal information to send you promotional information about third parties which we think you may find interesting if you tell us that you wish this to happen.\n\nOur application may contain links to external sites that are not operated by us. Please be aware that we have no control over the content and practices of these sites, and we cannot accept responsibility or liability for their respective privacy policies. We strongly advise you to review the Privacy Policy of every site you visit.\n\nYou are free to refuse our request for your personal information, with the understanding that we may be unable to provide you with some or all of your desired services without this information. Your continued use of our application will be regarded as acceptance of our practices around privacy and personal information.\n\nIf you have any questions about how we handle user data and personal information, please do not hesitate to contact us. We are committed to conducting our business in accordance with these principles in order to ensure that the confidentiality of personal information is protected and maintained.\n\nBy using this application, you hereby consent to our privacy policy and agree to its terms. This policy is effective as of July 17, 2024, and will remain in effect except with respect to any changes in its provisions in the future, which will be in effect immediately after being posted on this page. We reserve the right to update or change our privacy policy at any time, and you should check this privacy policy periodically for any changes.\n\nIf you do not agree with this policy, please do not use our application. Your continued use of the application following the posting of changes to this policy will be deemed your acceptance of those changes.\n\nData Collection and Usage:\nWe collect various types of information for various purposes to provide and improve our service to you. Types of data collected may include, but are not limited to, personal data (such as name, email address, phone number), usage data (information on how the service is accessed and used), and device data (information about the device you use to access our service).\n\nCookies and Tracking Technologies:\nWe use cookies and similar tracking technologies to track activity on our service and hold certain information. Cookies are files with small amount of data which may include an anonymous unique identifier. You can instruct your browser to refuse all cookies or to indicate when a cookie is being sent.\n\nThird-Party Service Providers:\nWe may employ third party companies and individuals to facilitate our service, provide the service on our behalf, perform service-related services, or assist us in analyzing how our service is used. These third parties have access to your personal data only to perform these tasks on our behalf and are obligated not to disclose or use it for any other purpose.\n\nSecurity:\nThe security of your data is important to us, but remember that no method of transmission over the Internet, or method of electronic storage is 100% secure. While we strive to use commercially acceptable means to protect your personal data, we cannot guarantee its absolute security.\n\nChildren's Privacy:\nOur service does not address anyone under the age of 13. We do not knowingly collect personally identifiable information from children under 13. If you are a parent or guardian and you are aware that your child has provided us with personal data, please contact us.\n\nChanges to This Privacy Policy:\nWe may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page. You are advised to review this Privacy Policy periodically for any changes. Changes to this Privacy Policy are effective when they are posted on this page.\n\nContact Us:\nIf you have any questions about this Privacy Policy, please contact us via email or through the contact information provided in our application.\n\nBy using our application, you agree to the collection and use of information in accordance with this policy. If you do not agree with any part of this policy, please do not use our application or services.",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Checkbox(
                  value: isChecked.value,
                  onChanged: isBottomReached.value
                      ? (bool? value) {
                          isChecked.value = value!;
                        }
                      : null,
                ),
                const Text('I agree to the Terms of Service'),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: isChecked.value
                  ? () {
                      context.go(HomeScreen.routeName);
                      // 동의 버튼 클릭 시 수행할 동작
                    }
                  : null,
              child: const Text('Agree'),
            ),
          ],
        ),
      ),
    );
  }
}
