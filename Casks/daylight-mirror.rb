cask "daylight-mirror" do
  version "1.0"
  sha256 "d6e1a7b5a532e514b9afec95713d11fd687e8226a073e6e21b936f013dbc7486"

  url "https://github.com/welfvh/daylight-mirror/releases/download/v#{version}/DaylightMirror-#{version}-mac.zip"
  name "Daylight Mirror"
  desc "Use your Daylight DC-1 as a real-time external display for your Mac"
  homepage "https://github.com/welfvh/daylight-mirror"

  depends_on macos: ">= :sonoma"

  app "Daylight Mirror.app"

  # Install the Android APK alongside the app for easy access
  postflight do
    system_command "curl",
      args: [
        "-sL",
        "-o", "#{staged_path}/app-debug.apk",
        "https://github.com/welfvh/daylight-mirror/releases/download/v#{version}/app-debug.apk"
      ]
    system_command "mkdir", args: ["-p", "/opt/homebrew/share/daylight-mirror"]
    system_command "cp",
      args: ["#{staged_path}/app-debug.apk", "/opt/homebrew/share/daylight-mirror/"]
  end

  uninstall_postflight do
    system_command "rm", args: ["-rf", "/opt/homebrew/share/daylight-mirror"]
  end

  caveats <<~EOS
    To complete setup, install the Android app on your Daylight DC-1:

      adb install /opt/homebrew/share/daylight-mirror/app-debug.apk

    If adb is not installed: brew install android-platform-tools

    Enable USB debugging on the Daylight (one-time):
      Settings > About tablet > tap "Build number" 7 times
      Settings > Developer options > enable "USB debugging"
  EOS
end
