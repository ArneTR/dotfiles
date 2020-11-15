#!/bin/bash

# IMPORTANT: Don't forget to logout from your Apple ID in the settings before running it!
# IMPORTANT: You will need to run this script from Recovery. In fact, macOS Catalina brings read-only filesystem which prevent this script from working from the main OS.
# This script needs to be run from the volume you wish to use.
# E.g. run it like this: cd /Volumes/Macintosh\ HD && sh /Volumes/Macintosh\ HD/Users/sabri/Desktop/disable.sh
# WARNING: It might disable things that you may not like. Please double check the services in the TODISABLE vars.

# Get active services: launchctl list | grep -v "\-\t0"
# Find a service: grep -lR [service] /System/Library/Launch* /Library/Launch* ~/Library/LaunchAgents

# Agents to disable
# 'com.apple.speech.speechdatainstallerd' 'com.apple.speech.speechsynthesisd' 'com.apple.speech.synthesisserver' will freeze Edit menus
# 'com.apple.bird' will prevent saving prompt from being shown
TODISABLE=()

# iCloud
TODISABLE+=('com.apple.security.cloudkeychainproxy3' \
  'com.apple.iCloudUserNotifications' \
  'com.apple.icloud.findmydeviced.findmydevice-user-agent' \
  'com.apple.icloud.fmfd' \
  'com.apple.icloud.searchpartyuseragent' \
  'com.apple.cloudd' \
  'com.apple.cloudpaird' \
  'com.apple.cloudphotod' \
  'com.apple.followupd' \
  'com.apple.protectedcloudstorage.protectedcloudkeysyncing')

# Safari useless stuff
TODISABLE+=('com.apple.SafariBookmarksSyncAgent' \
  'com.apple.SafariCloudHistoryPushAgent' \
  'com.apple.SafariHistoryServiceAgent' \
  'com.apple.SafariLaunchAgent' \
  'com.apple.SafariNotificationAgent' \
  'com.apple.SafariPlugInUpdateNotifier' \
  'com.apple.WebKit.PluginAgent')

# iMessage / Facetime
TODISABLE+=('com.apple.imagent' \
  'com.apple.imautomatichistorydeletionagent' \
  'com.apple.imklaunchagent' \
  'com.apple.imtransferagent' \
  'com.apple.avconferenced')

# Game Center / Passbook / Apple TV / Homekit...
TODISABLE+=('com.apple.gamed' \
  'com.apple.passd' \
  'com.apple.Maps.pushdaemon' \
  'com.apple.videosubscriptionsd' \
  'com.apple.CommCenter-osx' \
  'com.apple.homed')

# Ad-related
TODISABLE+=('com.apple.ap.adprivacyd' \
  'com.apple.ap.adservicesd')

# Screensharing
TODISABLE+=('com.apple.screensharing.MessagesAgent' \
  'com.apple.screensharing.agent' \
  'com.apple.screensharing.menuextra')

# Siri
TODISABLE+=('com.apple.siriknowledged' \
  'com.apple.assistant_service' \
  'com.apple.assistantd' \
  'com.apple.Siri.agent' \
  'com.apple.parsec-fbf')

# VoiceOver / accessibility-related stuff
TODISABLE+=('com.apple.VoiceOver' \
  'com.apple.voicememod' \
  'com.apple.accessibility.dfrhud' \
  'com.apple.accessibility.heard')

#  'com.apple.accessibility.AXVisualSupportAgent' \ needed for zoom


# Quicklook
#TODISABLE+=('com.apple.quicklook.ui.helper' \
#  'com.apple.quicklook.ThumbnailsAgent' \
#  'com.apple.quicklook')

# Sidecar
TODISABLE+=('com.apple.sidecar-hid-relay' \
  'com.apple.sidecar-relay')

# Debugging process
TODISABLE+=('com.apple.spindump_agent' \
  'com.apple.ReportCrash' \
  'com.apple.ReportGPURestart' \
  'com.apple.ReportPanic' \
  'com.apple.DiagnosticReportCleanup' \
  'com.apple.TrustEvaluationAgent')

# Screentime
TODISABLE+=('com.apple.ScreenTimeAgent' \
  'com.apple.UsageTrackingAgent')

# Others
TODISABLE+=('com.apple.telephonyutilities.callservicesd' \
  'com.apple.photoanalysisd' \
  'com.apple.parsecd' \
  'com.apple.AOSPushRelay' \
  'com.apple.AOSHeartbeat' \
  'com.apple.AirPortBaseStationAgent' \
  'com.apple.familycircled' \
  'com.apple.familycontrols.useragent' \
  'com.apple.familynotificationd' \
  'com.apple.findmymacmessenger' \
  'com.apple.sharingd' \
  'com.apple.identityservicesd' \
  'com.apple.java.InstallOnDemand' \
  'com.apple.parentalcontrols.check' \
  'com.apple.security.keychain-circle-notification' \
  'com.apple.syncdefaultsd' \
  'com.apple.appleseed.seedusaged' \
  'com.apple.appleseed.seedusaged.postinstall' \
  'com.apple.CallHistorySyncHelper' \
  'com.apple.RemoteDesktop' \
  'com.apple.CallHistoryPluginHelper' \
  'com.apple.SocialPushAgent' \
  'com.apple.touristd' \
  'com.apple.macos.studentd' \
  'com.apple.KeyboardAccessAgent' \
  'com.apple.exchange.exchangesyncd' \
  'com.apple.suggestd' \
  'com.apple.AddressBook.AssistantService' \
  'com.apple.AddressBook.ContactsAccountsService' \
  'com.apple.AddressBook.abd' \
  'com.apple.AddressBook.SourceSync' \
  'com.apple.helpd' \
  'com.apple.amp.mediasharingd' \
  'com.apple.mediaanalysisd' \
  'com.apple.mediaremoteagent' \
  'com.apple.keyboardservicesd' \
  'com.apple.telephonyutilities.callservicesd' \
  'com.apple.mobileassetd' \
  'com.apple.knowledge-agent')

#  'com.apple.AirPlayUIAgent' \ Want to use it
#  'com.apple.CalendarAgent' \ needed
#  'com.apple.remindd' \ needed

# routined -- A daemon that learns the historical location patterns of a user.
# routined is a per-user daemon that learns historical location patterns of a user and predicts future visits to locations.
TODISABLE+=('com.apple.routined.plist')

# something with apple media
TODISABLE+=('com.apple.amsaccountsd.plist')



for agent in "${TODISABLE[@]}"
do
    mv ./System/Library/LaunchAgents/${agent}.plist ./System/Library/LaunchAgents/${agent}.plist.bak
    echo "[OK] Agent ${agent} disabled"
done

# Daemons to disable
TODISABLE=()

# iCloud
TODISABLE+=('com.apple.analyticsd', 'com.apple.icloud.findmydeviced')

# Others
TODISABLE+=('com.apple.netbiosd' \
  'com.apple.preferences.timezone.admintool' \
  'com.apple.remotepairtool' \
  'com.apple.security.FDERecoveryAgent' \
  'com.apple.SubmitDiagInfo' \
  'com.apple.screensharing' \
  'com.apple.appleseed.fbahelperd' \
  'com.apple.apsd' \
  'com.apple.ManagedClient.cloudconfigurationd' \
  'com.apple.ManagedClient.enroll' \
  'com.apple.ManagedClient' \
  'com.apple.ManagedClient.startup' \
  'com.apple.locate' \
  'com.apple.locationd' \
  'com.apple.eapolcfg_auth' \
  'com.apple.RemoteDesktop.PrivilegeProxy' \
  'com.apple.mediaremoted')

for daemon in "${TODISABLE[@]}"
do
    mv ./System/Library/LaunchDaemons/${daemon}.plist ./System/Library/LaunchDaemons/${daemon}.plist.bak
    echo "[OK] Daemon ${daemon} disabled"
done
