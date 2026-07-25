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

// Some plugins (e.g. tflite_flutter) pin their own Java target (11) while
// the Kotlin compiler infers a different one from the toolchain, which
// AGP rejects as an "Inconsistent JVM-target compatibility" error. Force
// every subproject's Java/Kotlin compile tasks to the same target as the
// app module (17) so a plugin's stale setting can't drift out of sync.
subprojects {
    tasks.withType<org.jetbrains.kotlin.gradle.tasks.KotlinCompile>().configureEach {
        compilerOptions.jvmTarget.set(org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17)
    }
    // AGP re-derives JavaCompile's source/targetCompatibility from the
    // android.compileOptions extension after the subproject's own
    // build.gradle runs, so overriding the JavaCompile tasks directly (as
    // above for Kotlin) gets clobbered. Override compileOptions itself,
    // once the subproject's android extension exists, so ours is the value
    // AGP reads. Uses withGroovyBuilder instead of AGP's extension types
    // directly since those types/generics have shifted across AGP versions.
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
