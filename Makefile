.PHONY: help ios-pod \
	ios-release-development ios-release-staging ios-release-production \
	ios-ipa-development ios-ipa-staging ios-ipa-production

.DEFAULT_GOAL := help

CONFIG_DEVELOPMENT := config/run/config.development.json
CONFIG_STAGING := config/run/config.stage.json
CONFIG_PRODUCTION := config/run/config.production.json

EXPORT_OPTIONS_PLIST ?=

export_plist_arg :=
ifneq ($(strip $(EXPORT_OPTIONS_PLIST)),)
export_plist_arg := --export-options-plist=$(EXPORT_OPTIONS_PLIST)
endif

help:
	@echo "iOS (repo root), same toolArgs as .vscode/launch.json. Use: make -f MakeFile <target>"
	@echo "  ios-pod"
	@echo "  ios-release-development / ios-release-staging / ios-release-production"
	@echo "  ios-ipa-development / ios-ipa-staging / ios-ipa-production"
	@echo "Optional: EXPORT_OPTIONS_PLIST=ios/fastlane/ExportOptions.plist"
	@echo "TestFlight (from ios/, after bundle install): fastlane beta_development | beta_staging | beta_production"
	@echo "  Local Fastlane: ios/keys/.env; CI: same key names as secrets. Doc: .github/docs/ios/build.md"

ios-pod:
	cd ios && pod install

ios-release-development:
	flutter build ios --flavor=development --release --no-codesign --dart-define-from-file=$(CONFIG_DEVELOPMENT)

ios-release-staging:
	flutter build ios --flavor=staging --release --no-codesign --dart-define-from-file=$(CONFIG_STAGING)

ios-release-production:
	flutter build ios --flavor=production --release --no-codesign --dart-define-from-file=$(CONFIG_PRODUCTION)

ios-ipa-development:
	flutter build ipa --flavor=development --release --dart-define-from-file=$(CONFIG_DEVELOPMENT) $(export_plist_arg)

ios-ipa-staging:
	flutter build ipa --flavor=staging --release --dart-define-from-file=$(CONFIG_STAGING) $(export_plist_arg)

ios-ipa-production:
	flutter build ipa --flavor=production --release --dart-define-from-file=$(CONFIG_PRODUCTION) $(export_plist_arg)
