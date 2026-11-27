# Qandil (قنديل) — Project Automation Makefile
# Usage:
#   make run                 # Run with dev env on default device
#   make run ENV=staging     # Run with staging env
#   make run-ios ENV=dev     # Run on iOS with dev env
#   make run-android ENV=dev # Run on Android with dev env
#   make ios-config ENV=dev  # Sync env into Xcode (for running directly from Xcode)

ENV ?= dev
DEVICE ?=
MODE ?=
FLUTTER ?= $(shell command -v flutter 2>/dev/null || echo /Users/mohamedmazen/Desktop/flutter/bin/flutter)
DART ?= $(shell command -v dart 2>/dev/null || echo /Users/mohamedmazen/Desktop/flutter/bin/dart)

ENV_FILE := config/env.$(ENV).json
DEVICE_FLAG := $(if $(DEVICE),-d $(DEVICE),)

.DEFAULT_GOAL := help

.PHONY: help check-env devices run run-dev run-staging run-prod \
        run-android run-ios ios-config \
        build-apk build-aab build-ios build-ipa \
        build-android-prod build-apk-prod build-ios-prod build-prod-all \
        open-ios-archive android-keystore \
        pub pods gen format analyze test clean

help: ## Show available targets
	@echo ""
	@echo "Qandil Makefile (ENV=$(ENV), ENV_FILE=$(ENV_FILE))"
	@echo "------------------------------------------------------------"
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}'
	@echo ""
	@echo "Examples:"
	@echo "  make run-ios ENV=dev        # Run dev on iPhone/Simulator"
	@echo "  make run-android ENV=dev    # Run dev on Android"
	@echo "  make build-android-prod     # Build Google Play prod AAB (ENV=prod)"
	@echo "  make build-ios-prod         # Build App Store prod IPA/Archive (ENV=prod)"
	@echo "  make open-ios-archive       # Open iOS Archive in Xcode Organizer"
	@echo "  make build-prod-all         # Build both Android AAB & iOS Archive (ENV=prod)"
	@echo ""

check-env:
	@if [ ! -f "$(ENV_FILE)" ]; then \
		echo "Error: Environment file '$(ENV_FILE)' not found."; \
		echo "Available configs:"; \
		ls -1 config/env.*.json 2>/dev/null || true; \
		exit 1; \
	fi

devices: ## List connected Flutter devices
	$(FLUTTER) devices

run: check-env ## Run app with ENV (default: dev). Optional DEVICE=<id>
	$(FLUTTER) run $(DEVICE_FLAG) --dart-define-from-file=$(ENV_FILE)

run-dev: ## Run app with dev environment
	@$(MAKE) run ENV=dev DEVICE="$(DEVICE)"

run-staging: ## Run app with staging environment
	@$(MAKE) run ENV=staging DEVICE="$(DEVICE)"

run-prod: ## Run app with production environment
	@$(MAKE) run ENV=prod DEVICE="$(DEVICE)"

run-android: check-env ## Run app on Android with flavor ENV (pass DEVICE=<id> if multiple Android devices)
	@if [ -n "$(DEVICE)" ]; then \
		$(FLUTTER) run -d $(DEVICE) --flavor $(ENV) --dart-define-from-file=$(ENV_FILE); \
	else \
		ANDROID_ID=$$($(FLUTTER) devices --machine | python3 -c "import sys,json; devs=json.load(sys.stdin); print(next((d['id'] for d in devs if 'android' in d.get('targetPlatform','').lower()), ''))"); \
		if [ -z "$$ANDROID_ID" ]; then \
			echo "Error: No Android device or emulator found. Run 'make devices' to check."; \
			exit 1; \
		fi; \
		echo "Running on Android device: $$ANDROID_ID (flavor=$(ENV), $(ENV_FILE))"; \
		$(FLUTTER) run -d "$$ANDROID_ID" --flavor $(ENV) --dart-define-from-file=$(ENV_FILE); \
	fi

run-ios: check-env ## Run app on iOS (defaults to --release on physical iPhone so it launches standalone after terminate; pass MODE=debug for hot-reload)
	@if [ -n "$(DEVICE)" ]; then \
		MODE_FLAG=$$(if [ -n "$(MODE)" ]; then echo "--$(MODE)"; else echo "--release"; fi); \
		$(FLUTTER) run -d $(DEVICE) $$MODE_FLAG --dart-define-from-file=$(ENV_FILE); \
	else \
		IOS_INFO=$$($(FLUTTER) devices --machine | python3 -c "import sys,json; devs=json.load(sys.stdin); d=next((d for d in devs if 'ios' in d.get('targetPlatform','').lower()), None); print(f\"{d['id']}|{1 if d.get('emulator') else 0}\" if d else '')"); \
		IOS_ID=$$(echo "$$IOS_INFO" | cut -d'|' -f1); \
		IS_SIM=$$(echo "$$IOS_INFO" | cut -d'|' -f2); \
		if [ -z "$$IOS_ID" ]; then \
			echo "Error: No iOS device or simulator found. Run 'make devices' to check."; \
			exit 1; \
		fi; \
		if [ -n "$(MODE)" ]; then \
			MODE_FLAG="--$(MODE)"; \
		elif [ "$$IS_SIM" = "1" ]; then \
			MODE_FLAG="--debug"; \
		else \
			MODE_FLAG="--release"; \
		fi; \
		echo "Running on iOS device: $$IOS_ID ($$MODE_FLAG, $(ENV_FILE))"; \
		$(FLUTTER) run -d "$$IOS_ID" $$MODE_FLAG --dart-define-from-file=$(ENV_FILE); \
	fi

ios-config: check-env ## Sync ENV into ios/Flutter/Generated.xcconfig for Xcode runs
	$(FLUTTER) build ios --config-only --dart-define-from-file=$(ENV_FILE)

build-apk: check-env ## Build release Android APK with flavor ENV
	$(FLUTTER) build apk --release --flavor $(ENV) --dart-define-from-file=$(ENV_FILE)

build-aab: check-env ## Build release Android App Bundle (AAB) with flavor ENV
	$(FLUTTER) build appbundle --release --flavor $(ENV) --dart-define-from-file=$(ENV_FILE)

build-ios: check-env ## Build release iOS app (no codesign) with ENV
	$(FLUTTER) build ios --release --no-codesign --dart-define-from-file=$(ENV_FILE)

build-ipa: check-env ## Build release iOS IPA / Xcode Archive with ENV
	$(FLUTTER) build ipa --release --dart-define-from-file=$(ENV_FILE)

build-android-prod: ## Build Google Play production Android App Bundle (.aab) with ENV=prod
	@$(MAKE) build-aab ENV=prod

build-apk-prod: ## Build production Android release APK (.apk) with ENV=prod
	@$(MAKE) build-apk ENV=prod

build-ios-prod: ## Build App Store production iOS Archive (.xcarchive) & IPA with ENV=prod
	@$(MAKE) ios-config ENV=prod
	$(FLUTTER) build ipa --release --dart-define-from-file=config/env.prod.json

open-ios-archive: ## Open built iOS Xcode Archive in Xcode Organizer for App Store upload
	@if [ -d "build/ios/archive/Runner.xcarchive" ]; then \
		open build/ios/archive/Runner.xcarchive; \
	else \
		echo "Error: build/ios/archive/Runner.xcarchive not found. Run 'make build-ios-prod' first."; \
		exit 1; \
	fi

build-prod-all: ## Build both Google Play Android AAB and App Store iOS Archive/IPA (ENV=prod)
	@$(MAKE) build-android-prod
	@$(MAKE) build-ios-prod

android-keystore: ## Generate Android upload keystore and android/key.properties if missing
	@if [ -f "android/key.properties" ] || [ -f "android/app/upload-keystore.jks" ]; then \
		echo "Android keystore already exists at android/app/upload-keystore.jks (skipping to protect existing key)."; \
	else \
		STORE_PASS=$$(python3 -c "import secrets; print(secrets.token_urlsafe(18))"); \
		keytool -genkeypair -v -keystore android/app/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload -dname "CN=Mohamed Mazen, OU=Mobile, O=Qandil, L=Cairo, ST=Cairo, C=EG" -storepass "$$STORE_PASS" -keypass "$$STORE_PASS"; \
		printf "storePassword=%s\nkeyPassword=%s\nkeyAlias=upload\nstoreFile=upload-keystore.jks\n" "$$STORE_PASS" "$$STORE_PASS" > android/key.properties; \
		chmod 600 android/key.properties; \
		echo "Created android/app/upload-keystore.jks and android/key.properties"; \
	fi

pub: ## Install Flutter dependencies
	$(FLUTTER) pub get

pods: ## Run CocoaPods install in ios/
	cd ios && pod install

gen: ## Generate l10n and Drift/Freezed/JSON code
	$(FLUTTER) gen-l10n
	$(DART) run build_runner build --delete-conflicting-outputs

format: ## Format Dart code
	$(DART) format .

analyze: ## Run static analysis
	$(FLUTTER) analyze

test: ## Run all Flutter unit/widget tests
	$(FLUTTER) test

clean: ## Clean build artifacts and fetch dependencies
	$(FLUTTER) clean
	$(FLUTTER) pub get
