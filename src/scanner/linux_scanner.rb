# frozen_string_literal: true

require_relative "base_scanner"
require_relative "result/firefox_result"
require_relative "result/chrome_result"

# Scanner for GNU/Linux
class LinuxScanner < BaseScanner
  def applies?(file_system)
    %w[ext ext2 ext3 ext4 btrfs xfs zfs].include?(file_system)
  end

  def scan(path)
    return [] unless Dir.exist?("#{path}/home")

    puts("Found Linux...")

    [
      # Firefox (+ Dev and Nightly as profiles)
      Dir["#{path}home/*/.mozilla/"].map { |p| FirefoxResult.new("Firefox", "Linux", p) },
      # Chromium
      Dir["#{path}home/*/.config/chromium"].map { |p| ChromeResult.new("Chromium", "Linux", p) },
      Dir["#{path}home/*/.config/google-chrome"].map { |p| ChromeResult.new("Google Chrome", "Linux", p) },
      Dir["#{path}home/*/.config/google-chrome-beta"].map { |p| ChromeResult.new("Google Chrome Beta", "Linux", p) },
      Dir["#{path}home/*/.config/google-chrome-canary"].map { |p| ChromeResult.new("Google Chrome Canary", "Linux", p) },
    ].flatten
  end
end
