
# Keep uCrop classes
-keep class com.yalantis.ucrop.** { *; }

# Keep OkHttp classes used by uCrop
-keep class okhttp3.** { *; }

# Suppress warnings
-dontwarn com.yalantis.ucrop.**
-dontwarn okhttp3.**
