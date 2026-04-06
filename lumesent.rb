class Lumesent < Formula
  desc "macOS menu bar app for system notification monitoring and filtering"
  homepage "https://github.com/shadyabhi/Lumesent"
  url "https://github.com/shadyabhi/Lumesent/archive/refs/tags/v1.2.16.tar.gz"
  sha256 "890707e1d82f122db8171d92038fddfac48bc799d9b3a5072d1e5c9bc499914c"
  license "MIT"
  head "https://github.com/shadyabhi/Lumesent.git", branch: "main"

  depends_on xcode: ["15.0", :build]
  depends_on macos: :sonoma

  def install
    # Build in release mode; SPM fetches Sparkle automatically
    system "swift", "build", "-c", "release", "--disable-sandbox"

    # Assemble the .app bundle (ad-hoc signed, no distribution cert needed)
    ENV["CODESIGN_IDENTITY"] = "-"
    ENV["SHORT_VERSION"] = version.to_s
    ENV["VERSION"] = version.to_s
    system "bash", "scripts/bundle.sh"

    # Install the .app bundle into the prefix
    prefix.install "Lumesent.app"
  end

  def post_install
    app_path = Pathname("/Applications/Lumesent.app")
    # Remove existing app/symlink so we can place ours
    app_path.rmtree if app_path.exist? && !app_path.symlink?
    app_path.unlink if app_path.symlink?
    ln_sf prefix/"Lumesent.app", app_path
  end

  def post_uninstall
    app_path = Pathname("/Applications/Lumesent.app")
    app_path.unlink if app_path.symlink?
  end

  def caveats
    <<~EOS
      The app requires Full Disk Access and Accessibility permissions.
      Grant these in System Settings → Privacy & Security after first launch.
    EOS
  end
end
