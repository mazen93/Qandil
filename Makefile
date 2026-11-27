# Qandil (قنديل) — Project Automation Makefile
# Usage:
#   make run                 # Run with dev env on default device
#   make run ENV=staging     # Run with staging env
#   make run-ios ENV=dev     # Run on iOS with dev env
#   make run-android ENV=dev # Run on Android with dev env
#   make ios-config ENV=dev  # Sync env into Xcode (for running directly from Xcode)

ENV ?= dev
DEVICE ?=
FLUTTER ?= $(shell command -v flutter 2>/dev/null || echo /Users/mohamedmazen/Desktop/flutter/bin/flutter)
DART ?= $(shell command -v dart 2>/dev/null || echo /Users/mohamedmazen/Desktop/flutter/bin/dart)

ENV_FILE := config/env.$(ENV).json
DEVICE_FLAG := $(if $(DEVICE),-d $(DEVICE),)

.DEFAULT_GOAL := help

.PHONY: help check-env devices run run-dev run-staging run-prod \
        run-android run-ios ios-config \
        build-apk build-aab build-ios build-ipa \
        pub pods gen format analyze test clean

help: ## Show available targets
	@echo ""
	@echo "Qandil Makefile (ENV=$(ENV), ENV_FILE=$(ENV_FILE))"
	@echo "------------------------------------------------------------"
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-16s\033[0m %s\n", $$1, $$2}'
	@echo ""
	@echo "Examples:"
	@echo "  make run                  # Run with config/env.dev.json"
	@echo "  make run-ios ENV=dev      # Run on iOS device/simulator"
	@echo "  make run-android ENV=prod # Run on Android with prod env"
	@echo "  make ios-config ENV=dev   # Sync env.dev.json for Xcode Cmd+R"
	@echo "  make build-apk ENV=prod   # Build release APK"
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

run-ios: check-env ## Run app on iOS (pass DEVICE=<id> if multiple iOS devices)
	@if [ -n "$(DEVICE)" ]; then \
		$(FLUTTER) run -d $(DEVICE) --dart-define-from-file=$(ENV_FILE); \
	else \
		IOS_ID=$$($(FLUTTER) devices --machine | python3 -c "import sys,json; devs=json.load(sys.stdin); print(next((d['id'] for d in devs if 'ios' in d.get('targetPlatform','').lower()), ''))"); \
		if [ -z "$$IOS_ID" ]; then \
			echo "Error: No iOS device or simulator found. Run 'make devices' to check."; \
			exit 1; \
		fi; \
		echo "Running on iOS device: $$IOS_ID ($(ENV_FILE))"; \
		$(FLUTTER) run -d "$$IOS_ID" --dart-define-from-file=$(ENV_FILE); \
	fi

ios-config: check-env ## Sync ENV into ios/Flutter/Generated.xcconfig for Xcode runs
	$(FLUTTER) build ios --config-only --dart-define-from-file=$(ENV_FILE)

build-apk: check-env ## Build release Android APK with flavor ENV
	$(FLUTTER) build apk --release --flavor $(ENV) --dart-define-from-file=$(ENV_FILE)

build-aab: check-env ## Build release Android App Bundle (AAB) with flavor ENV
	$(FLUTTER) build appbundle --release --flavor $(ENV) --dart-define-from-file=$(ENV_FILE)

build-ios: check-env ## Build release iOS app (no codesign) with ENV
	$(FLUTTER) build ios --release --no-codesign --dart-define-from-file=$(ENV_FILE)

build-ipa: check-env ## Build release iOS IPA with ENV
	$(FLUTTER) build ipa --release --dart-define-from-file=$(ENV_FILE)

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
