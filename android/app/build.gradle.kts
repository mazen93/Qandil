import java.util.Base64

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

val dartEnvironmentVariables = mutableMapOf<String, String>()
if (project.hasProperty("dart-defines")) {
    val dartDefines = project.property("dart-defines") as String
    dartDefines.split(",").forEach { entry ->
        val decoded = String(Base64.getDecoder().decode(entry), Charsets.UTF_8)
        val parts = decoded.split("=", limit = 2)
        if (parts.size == 2) {
            dartEnvironmentVariables[parts[0]] = parts[1]
        }
    }
}

android {
    namespace = "com.mmazin.qandil"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.mmazin.qandil"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        manifestPlaceholders["appName"] = dartEnvironmentVariables["APP_NAME"] ?: "Qandil"
    }

    flavorDimensions += "env"
    productFlavors {
        create("dev") {
            dimension = "env"
            manifestPlaceholders["appName"] = dartEnvironmentVariables["APP_NAME"] ?: "Qandil (Dev)"
        }
        create("staging") {
            dimension = "env"
            manifestPlaceholders["appName"] = dartEnvironmentVariables["APP_NAME"] ?: "Qandil (Staging)"
        }
        create("prod") {
            dimension = "env"
            manifestPlaceholders["appName"] = dartEnvironmentVariables["APP_NAME"] ?: "Qandil"
        }
    }

    buildTypes {
        release {
            // TODO: Add your own production keystore signingConfig for Play Store upload.
            // Signing with the debug keys for now, so `flutter run --release` works out of the box.
            signingConfig = signingConfigs.getByName("debug")
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro",
            )
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}
