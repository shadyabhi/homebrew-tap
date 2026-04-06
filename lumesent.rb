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

    # Create a bin wrapper so `lumesent` opens the app (and forwards CLI args)
    (bin/"lumesent").write <<~SH
      #!/bin/bash
      if [ $# -eq 0 ]; then
        open "#{prefix}/Lumesent.app"
      else
        exec "#{prefix}/Lumesent.app/Contents/MacOS/Lumesent" "$@"
      fi
    SH
  end

  def caveats
    <<~EOS
      To add Lumesent to your Applications folder, run:
        ln -sf #{prefix}/Lumesent.app /Applications/Lumesent.app

      Or launch from the terminal with: lumesent

      The app requires Full Disk Access and Accessibility permissions.
      Grant these in System Settings → Privacy & Security after first launch.
    EOS
  end
end
