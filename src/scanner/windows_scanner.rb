# frozen_string_literal: true

require_relative "base_scanner"

# Scanner for Windows
class WindowsScanner < BaseScanner
  def applies?(file_system)
    %w[ntfs ntfs1 ntfs2 ntfs3 fuseblk].include?(file_system)
  end

  def scan(path)
    return [] unless Dir.exist?("#{path}/Users")

    puts("Found Windows...")

    [
      # Firefox (+ Dev and Nightly as profiles)
      Dir["#{path}/Users/*/AppData/Roaming/Mozilla"].map { |p| FirefoxResult.new("Firefox", "Windows", p) },
      # Chrome
      Dir["#{path}/Users/*/AppData/Local/Google/Chrome/User Data"].map { |p| ChromeResult.new("Chrome", "Windows", p) },
      Dir["#{path}/Users/*/AppData/Local/Google/Chrome Beta/User Data"].map { |p| ChromeResult.new("Chrome Beta", "Windows", p) },
      Dir["#{path}/Users/*/AppData/Local/Google/Chrome SxS/User Data"].map { |p| ChromeResult.new("Chrome Canary", "Windows", p) },
    ].flatten
  end
end
