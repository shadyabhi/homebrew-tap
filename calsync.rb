# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Calsync < Formula
  desc "Sync a local calendar to a remote Google Calendar"
  homepage "http://github.com/shadyabhi/calsync"
  version "0.1.14"

  depends_on "ical-buddy"

  on_macos do
    url "https://github.com/shadyabhi/calsync/releases/download/v0.1.14/calsync_Darwin_all.tar.gz"
    sha256 "db33d926d0b7fade80f31898f259282d0a62a7c8e543e8fd5656dd4bdb4702ba"

    def install
      bin.install "calsync"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/shadyabhi/calsync/releases/download/v0.1.14/calsync_Linux_x86_64.tar.gz"
        sha256 "ff10fee35400143d55953db57a7252ae009c2690cb2908cf9bf9df8897610563"

        def install
          bin.install "calsync"
        end
      end
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/shadyabhi/calsync/releases/download/v0.1.14/calsync_Linux_arm64.tar.gz"
        sha256 "5da3cacfa487bbbe18f86136c45231f3738771c08e727736171043d640ed5370"

        def install
          bin.install "calsync"
        end
      end
    end
  end

  def caveats
    <<~EOS
      For install instructions, visit: https://github.com/shadyabhi/calsync/wiki
    EOS
  end
end
