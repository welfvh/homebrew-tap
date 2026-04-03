cask "amber-tint" do
  version "0.1.0"
  sha256 "0fb19efef129a67edee6ffbdeb862200fed9bef5ccad54ead56b44cf958a96a3"

  url "https://github.com/welfvh/amber-tint/releases/download/v#{version}/amber-tint-#{version}.zip"
  name "Amber Tint"
  desc "Full-screen amber color filter for macOS using CoreGraphics gamma tables"
  homepage "https://github.com/welfvh/amber-tint"

  depends_on macos: ">= :sonoma"

  app "Amber Tint.app"
end
