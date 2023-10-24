# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Calsync < Formula
  desc "Sync a local calendar to a remote Google Calendar"
  homepage "http://github.com/shadyabhi/calsync"
  version "0.0.40"

  depends_on "ical-buddy"

  on_macos do
    url "https://github.com/shadyabhi/calsync/releases/download/v0.0.40/calsync_Darwin_all.tar.gz"
    sha256 "4816eb2dac2e02baf547ad1bc29a5dfad4441a31ad33e27e41866da37f1c14a1"

    def install
      bin.install "calsync"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/shadyabhi/calsync/releases/download/v0.0.40/calsync_Linux_arm64.tar.gz"
      sha256 "c1dc9bfcdaecc35f7382aa46649782ad2b7725514c0b7f13fcea8513d9c81fb3"

      def install
        bin.install "calsync"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/shadyabhi/calsync/releases/download/v0.0.40/calsync_Linux_x86_64.tar.gz"
      sha256 "bfc8fcea17ccb03b0799e0daf2070f5850b28a8f624d0cf1b7cb49c33e08fa84"

      def install
        bin.install "calsync"
      end
    end
  end

  def caveats
    <<~EOS
      For install instructions, visit: https://github.com/shadyabhi/calsync/wiki
    EOS
  end
end
