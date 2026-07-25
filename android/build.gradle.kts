allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

// tflite_flutter pins Java 11 for its own module while Kotlin infers a
// different target from the toolchain, which AGP rejects. Force every
// subproject to build against 17 (matching :app) instead.
subprojects {
    tasks.withType<org.jetbrains.kotlin.gradle.tasks.KotlinCompile>().configureEach {
        compilerOptions.jvmTarget.set(org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17)
    }
    // compileOptions (not the JavaCompile tasks) is the value AGP actually
    // reads, and only after the subproject's own build.gradle has run.
    afterEvaluate {
        extensions.findByName("android")?.withGroovyBuilder {
            getProperty("compileOptions").withGroovyBuilder {
                setProperty("sourceCompatibility", JavaVersion.VERSION_17)
                setProperty("targetCompatibility", JavaVersion.VERSION_17)
            }
        }
    }
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
