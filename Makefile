.PHONY: help \
	ios-pod ios-clean-pod \
	ios-production-deploy ios-development-deploy \
	android-production-deploy android-development-deploy

.DEFAULT_GOAL := help

CONFIG_DEVELOPMENT := config/run/config.development.json
CONFIG_PRODUCTION := config/run/config.production.json

help:
	@echo "Repo root. Use: make -f MakeFile <target>"
	@echo ""
	@echo "iOS"
	@echo "  ios-pod"
	@echo "  ios-clean-pod"
	@echo "  ios-production-deploy | ios-development-deploy   (Fastlane TestFlight; run: cd ios && bundle install once)"
	@echo ""
	@echo "Android"
	@echo "  android-production-deploy | android-development-deploy   (Fastlane Google Play internal; run: cd android && bundle install once)"

ios-pod:
	cd ios && pod install

ios-clean-pod:
	cd ios && rm -rf Pods Podfile.lock

ios-production-deploy:
	cd ios && bundle exec fastlane beta_production

ios-development-deploy:
	cd ios && bundle exec fastlane beta_development

android-production-deploy:
	cd android && bundle exec fastlane beta_production

android-development-deploy:
	cd android && bundle exec fastlane beta_development
