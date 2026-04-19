# Flutter 相关
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# 保留所有序列化相关的类
-keepclassmembers class * implements java.io.Serializable {
    static final long serialVersionUID;
    private static final java.io.ObjectStreamField[] serialPersistentFields;
    !static !transient <fields>;
    private void writeObject(java.io.ObjectOutputStream);
    private void readObject(java.io.ObjectInputStream);
    java.lang.Object writeReplace();
    java.lang.Object readResolve();
}

# 保留所有反射调用的类
-keepclassmembers class ** {
    @com.google.gson.annotations.SerializedName <fields>;
    @com.google.gson.annotations.Expose <fields>;
}

# 保留 JSON 序列化生成的类
-keep class **.g.** { *; }
-keep class **.freezed.** { *; }
-keep class **_freezed { *; }
-keep class **.g { *; }
-keepclassmembers class **_freezed { *; }
-keepclassmembers class **.g { *; }

# Riverpod 状态管理
-keep class * extends org.dartlang.** { *; }
-keepclassmembers class * extends org.dartlang.** { *; }

# enough_mail 邮件协议
-keep class com.enough.** { *; }
-keepclassmembers class com.enough.** { *; }

# flutter_secure_storage 安全存储
-keep class com.it_nomads.fluttersecurestorage.** { *; }
-keepclassmembers class com.it_nomads.fluttersecurestorage.** { *; }

# shared_preferences 本地存储
-keep class io.flutter.plugins.sharedpreferences.** { *; }
-keepclassmembers class io.flutter.plugins.sharedpreferences.** { *; }

# 保留所有 Kotlin 协程相关
-keepclassmembers class kotlinx.coroutines.** {
    volatile <fields>;
}
-keepnames class kotlinx.coroutines.internal.MainDispatcherFactory {}
-keepnames class kotlinx.coroutines.CoroutineExceptionHandler {}

# 保留所有 Dart 互操作相关的类
-keep class **.dart.** { *; }
-keepclassmembers class **.dart.** { *; }

# 优化选项
-optimizationpasses 5
-dontusemixedcaseclassnames
-dontskipnonpubliclibraryclasses
-verbose

# 优化配置
-optimizations !code/simplification/arithmetic,!field/*,!class/merging/*,!code/allocation/variable

# 保留注解
-keepattributes *Annotation*
-keepattributes SourceFile,LineNumberTable

# 保留泛型签名
-keepattributes Signature

# 保留异常
-keepattributes Exceptions

# 警告处理
-dontwarn org.conscrypt.**
-dontwarn org.bouncycastle.**
-dontwarn org.openjsse.**
-dontwarn com.google.android.play.core.splitcompat.SplitCompatApplication
-dontwarn com.google.android.play.core.splitinstall.SplitInstallException
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManager
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManagerFactory
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest$Builder
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest
-dontwarn com.google.android.play.core.splitinstall.SplitInstallSessionState
-dontwarn com.google.android.play.core.splitinstall.SplitInstallStateUpdatedListener
-dontwarn com.google.android.play.core.tasks.OnFailureListener
-dontwarn com.google.android.play.core.tasks.OnSuccessListener
-dontwarn com.google.android.play.core.tasks.Task
