.PHONY: help ios-pod ios-clean-pod \
	ios-production-deploy ios-staging-deploy ios-development-deploy

.DEFAULT_GOAL := help

CONFIG_DEVELOPMENT := config/run/config.development.json
CONFIG_STAGING := config/run/config.staging.json
CONFIG_PRODUCTION := config/run/config.production.json

help:
	@echo "iOS (repo root). Use: make -f MakeFile <target>"
	@echo "  ios-pod"
	@echo "  ios-clean-pod"
	@echo "  ios-production-deploy | ios-staging-deploy | ios-development-deploy  (Fastlane TestFlight; run: cd ios && bundle install once)"

ios-pod:
	cd ios && pod install

ios-clean-pod:
	cd ios && rm -rf Pods Podfile.lock

ios-production-deploy:
	cd ios && bundle exec fastlane beta_production

ios-staging-deploy:
	cd ios && bundle exec fastlane beta_staging

ios-development-deploy:
	cd ios && bundle exec fastlane beta_development