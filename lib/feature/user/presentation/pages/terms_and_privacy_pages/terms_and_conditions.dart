import 'package:car_seat/feature/global/widget/global_widgets/global_widgets.dart';
import 'package:car_seat/feature/global/widget/safe_area_widget.dart';
import 'package:car_seat/feature/user/presentation/provider/base_pages_section_provider.dart';
import 'package:car_seat/resources/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../../resources/resources.dart';

class TermsAndConditions extends StatefulWidget {
  static String route = "/TermsAndConditions";
  const TermsAndConditions({super.key});

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  String pageTitle = "terms_of_use";

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        pageTitle = Get.arguments["pageTitle"];
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BasePagesSectionProvider>(
      builder: (context, themeColor, child) {
        return SafeAreaWidget(
          child: Scaffold(
            backgroundColor: R.appColors.white,
            appBar: AppBar(
              backgroundColor: themeColor.themeModel.themeColor,
              surfaceTintColor: themeColor.themeModel.themeColor,
              leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: R.appColors.white,
                    size: 25,
                  )),
              centerTitle: true,
              title: Text(
                pageTitle.L(),
                textAlign: TextAlign.center,
                style: R.textStyles.poppins(
                    fontSize: 20.sp,
                    color: R.appColors.white,
                    fontWeight: FontWeight.w500),
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "welcome_to_the_car_seat_companion_app_by_using_our_services_you_agree_to_the_following_terms_and_conditions"
                        .L(),
                    style: R.textStyles.poppins(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  GlobalWidgets.labelText(
                      text: "1_user_accounts_", fontWight: FontWeight.w600),
                  pointText(
                      title:
                          "you_must_create_an_account_to_use_our_app_ensure_that_your_information_is_accurate_and_kept_up_to_date"),
                  pointText(
                      title:
                          "you_are_responsible_for_maintaining_the_confidentiality_of_your_account_credentials"),
                  GlobalWidgets.labelText(
                      text: "2_data_privacy_", fontWight: FontWeight.w600),
                  pointText(title: "data_collection_"),
                  subPointText(
                      subTitle:
                          "the_app_collects_and_processes_personal_information_including_location_data_child_status_e_g_pressure_sensor_data_and_vehicle_information_to_provide_its_services"),
                  pointText(title: "data_storage_"),
                  subPointText(
                      subTitle:
                          "all_personal_data_is_stored_securely_and_in_compliance_with_applicable_data_protection_laws_we_use_encryption_to_safeguard_your_information"),
                  pointText(title: "third_party_access_"),
                  subPointText(
                      subTitle:
                          "we_may_share_certain_data_with_third_party_services_such_as_emergency_response_providers_however_no_personal_data_will_be_shared_with_third_parties_for_marketing_purposes"),
                  GlobalWidgets.labelText(
                      text: "3_emergency_notifications_",
                      fontWight: FontWeight.w600),
                  pointText(title: "escalation_timing_"),
                  subPointText(
                      subTitle:
                          "while_the_app_is_designed_to_escalate_notifications_based_on_time_thresholds_e_g_3_5_7_minutes_delays_may_occur_due_to_network_issues_device_malfunctions_or_signal_loss"),
                  pointText(title: "emergency_response_"),
                  subPointText(
                      subTitle:
                          "the_apps_notification_to_emergency_services_is_intended_as_a_backup_you_should_still_call_emergency_responders_immediately_if_needed"),
                  GlobalWidgets.labelText(
                      text: "4_content_", fontWight: FontWeight.w600),
                  subPointText(
                      subTitle:
                          "any_content_you_share_must_adhere_to_community_guidelines_we_reserve_the_right_to_remove_any_content_deemed_inappropriate"),
                  subPointText(
                      subTitle:
                          "by_posting_you_grant_us_a_non_exclusive_right_to_use_your_content_for_app_related_purposes"),
                  GlobalWidgets.labelText(
                      text: "5_modifications_", fontWight: FontWeight.w600),
                  subPointText(
                      subTitle:
                          "we_reserve_the_right_to_modify_these_terms_at_any_time_continued_use_of_the_app_implies_acceptance_of_the_updated_terms"),
                  GlobalWidgets.labelText(
                      text: "6_termination_", fontWight: FontWeight.w600),
                  subPointText(
                      subTitle:
                          "we_may_suspend_or_terminate_your_account_if_you_violate_these_terms"),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "by_using_the_car_seat_companion_app_you_agree_to_abide_by_these_terms_if_you_have_any_questions_please_contact_us_through_customer_support"
                        .L(),
                    style: R.textStyles.poppins(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Padding pointText({required String title}) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 2),
      child: Text(
        "•\t${title.L()}",
        style: R.textStyles.poppins(color: R.appColors.black.withOpacity(0.5)),
      ),
    );
  }

  Padding subPointText({required String subTitle}) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 35,
      ),
      child: Text(
        "•\t${subTitle.L()}",
        style: R.textStyles.poppins(color: R.appColors.black.withOpacity(0.5)),
      ),
    );
  }
}
