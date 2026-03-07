cask "daylight-mirror" do
  version "1.8.0"
  sha256 "52b4f7295c568e1e927cef61d8d300080a5218751de81dc6a92be275e4a15242"

  url "https://github.com/welfvh/daylight-mirror/releases/download/v#{version}/DaylightMirror-v#{version}.dmg"
  name "Daylight Mirror"
  desc "Use your Daylight DC-1 as a real-time external display for your Mac"
  homepage "https://github.com/welfvh/daylight-mirror"

  depends_on macos: ">= :sonoma"
  depends_on formula: "android-platform-tools"

  app "Daylight Mirror.app"

  # Install the Android APK alongside the app for easy access
  postflight do
    system_command "curl",
      args: [
        "-sL",
        "-o", "#{staged_path}/DaylightMirror.apk",
        "https://github.com/welfvh/daylight-mirror/releases/download/v#{version}/app-debug.apk"
      ]
    system_command "mkdir", args: ["-p", "/opt/homebrew/share/daylight-mirror"]
    system_command "cp",
      args: ["#{staged_path}/DaylightMirror.apk", "/opt/homebrew/share/daylight-mirror/"]
  end

  uninstall_postflight do
    system_command "rm", args: ["-rf", "/opt/homebrew/share/daylight-mirror"]
  end

  caveats <<~EOS
    To complete setup, install the Android app on your Daylight DC-1:

      adb install /opt/homebrew/share/daylight-mirror/DaylightMirror.apk

    Enable USB debugging on the Daylight (one-time):
      Settings > About tablet > tap "Build number" 7 times
      Settings > Developer options > enable "USB debugging"
    Connect the Daylight to your Mac via USB-C and tap "Allow" on the prompt.
  EOS
end
