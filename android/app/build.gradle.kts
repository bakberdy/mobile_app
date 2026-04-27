import java.io.File
import java.io.FileInputStream
import java.util.Properties
import org.gradle.api.GradleException
import org.jetbrains.kotlin.gradle.dsl.JvmTarget
import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

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

/**
 * [storeFile] in key.*.properties:
 * - **Absolute** — must be a real path (e.g. `~/...` expanded to `/Users/you/...`). A value like
 *   `/keys/...` is the filesystem root, not "keys under your home" — that file must exist or we fail
 *   with a clear error.
 * - **Relative** — resolved from the [android] project directory (`rootProject`, not `app/`),
 *   e.g. `keys/upload.jks` → `android/keys/upload.jks`.
 */
fun resolveKeyStoreFile(propsFile: String, raw: String): File {
    val trimmed = raw.trim()
    if (trimmed.isEmpty()) {
        throw GradleException("$propsFile: storeFile is empty")
    }
    val direct = File(trimmed)
    if (direct.isAbsolute) {
        if (direct.isFile) return direct
        val home = System.getProperty("user.home") ?: "your home"
        throw GradleException(
            """
            $propsFile: keystore not found at storeFile=$trimmed
              That path is absolute from the disk root. A path like /keys/... is NOT your home folder.
              Use the full path to the .jks (e.g. $home/keys/.../upload.jks) or a path under this repo's
              android/ directory (e.g. keys/upload.jks for android/keys/upload.jks).
            """.trimIndent(),
        )
    }
    val fromAndroid = rootProject.file(trimmed)
    if (fromAndroid.isFile) return fromAndroid
    throw GradleException(
        "$propsFile: keystore not found at storeFile=$trimmed (looked for ${fromAndroid.absoluteFile})",
    )
}

val productionKeyProps = loadKeyProps("key.production.properties")
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
                storeFile = resolveKeyStoreFile("key.production.properties", props.getProperty("storeFile")!!)
                storePassword = props.getProperty("storePassword")
            }
        }
        developmentKeyProps?.let { props ->
            create("development") {
                keyAlias = props.getProperty("keyAlias")
                keyPassword = props.getProperty("keyPassword")
                storeFile = resolveKeyStoreFile("key.development.properties", props.getProperty("storeFile")!!)
                storePassword = props.getProperty("storePassword")
            }
        }
        sharedKeyProps?.let { props ->
            create("release") {
                keyAlias = props.getProperty("keyAlias")
                keyPassword = props.getProperty("keyPassword")
                storeFile = resolveKeyStoreFile("key.properties", props.getProperty("storeFile")!!)
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

tasks.withType<KotlinCompile>().configureEach {
    compilerOptions {
        jvmTarget.set(JvmTarget.JVM_17)
    }
}

flutter {
    source = "../.."
}
