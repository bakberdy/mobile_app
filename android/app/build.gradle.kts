import java.io.FileInputStream
import java.util.Properties

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

// Signing config resolution (per release variant, evaluated at productFlavor level
// because AGP gives buildType.signingConfig precedence over productFlavor.signingConfig
// — so we leave buildTypes.release.signingConfig unset and assign per-flavor here):
//   1. android/key.<flavor>.properties → flavor-specific signingConfig (per flavor)
//   2. android/key.properties           → shared "release" signingConfig (used by any
//                                         flavor that doesn't have a per-flavor file)
//   3. neither                          → falls back to the debug keystore so
//                                         `flutter run --release` works locally
fun loadKeyProps(name: String): Properties? {
    val f = rootProject.file(name)
    if (!f.exists()) return null
    val p = Properties()
    FileInputStream(f).use { p.load(it) }
    return p
}

val productionKeyProps = loadKeyProps("key.production.properties")
val stagingKeyProps = loadKeyProps("key.staging.properties")
val developmentKeyProps = loadKeyProps("key.development.properties")
val sharedKeyProps = loadKeyProps("key.properties")

android {
    namespace = "com.bakberdi.mobile_app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "com.bakberdi.mobile_app"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        productionKeyProps?.let { props ->
            create("production") {
                keyAlias = props.getProperty("keyAlias")
                keyPassword = props.getProperty("keyPassword")
                storeFile = file(props.getProperty("storeFile"))
                storePassword = props.getProperty("storePassword")
            }
        }
        stagingKeyProps?.let { props ->
            create("staging") {
                keyAlias = props.getProperty("keyAlias")
                keyPassword = props.getProperty("keyPassword")
                storeFile = file(props.getProperty("storeFile"))
                storePassword = props.getProperty("storePassword")
            }
        }
        developmentKeyProps?.let { props ->
            create("development") {
                keyAlias = props.getProperty("keyAlias")
                keyPassword = props.getProperty("keyPassword")
                storeFile = file(props.getProperty("storeFile"))
                storePassword = props.getProperty("storePassword")
            }
        }
        sharedKeyProps?.let { props ->
            create("release") {
                keyAlias = props.getProperty("keyAlias")
                keyPassword = props.getProperty("keyPassword")
                storeFile = file(props.getProperty("storeFile"))
                storePassword = props.getProperty("storePassword")
            }
        }
    }

    flavorDimensions += "ENVIRONMENT"
    productFlavors {
        create("development") {
            dimension = "ENVIRONMENT"
            applicationIdSuffix = ".development"
            versionNameSuffix = "-development"
            signingConfig = signingConfigs.findByName("development")
                ?: signingConfigs.findByName("release")
                ?: signingConfigs.getByName("debug")
        }
        create("staging") {
            dimension = "ENVIRONMENT"
            applicationIdSuffix = ".staging"
            versionNameSuffix = "-staging"
            signingConfig = signingConfigs.findByName("staging")
                ?: signingConfigs.findByName("release")
                ?: signingConfigs.getByName("debug")
        }
        create("production") {
            dimension = "ENVIRONMENT"
            signingConfig = signingConfigs.findByName("production")
                ?: signingConfigs.findByName("release")
                ?: signingConfigs.getByName("debug")
        }
    }

    buildTypes {
        release {
            // Intentionally NOT setting signingConfig here — AGP treats buildType
            // as higher priority than productFlavor for signingConfig, so any value
            // set here would override the per-flavor cascade above.
        }
    }
}

flutter {
    source = "../.."
}
