# frozen_string_literal: true

require_relative "base_scanner"

# Scanner for Windows
class WindowsScanner < BaseScanner
  def applies?(file_system)
    %w[ntfs ntfs1 ntfs2 ntfs3 fuseblk].include?(file_system)
  end

  # rubocop:disable Metrics/AbcSize
  def scan(path)
    return [] unless Dir.exist?("#{path}/Users")

    puts("Found Windows...")

    [
      # Firefox (+ Dev and Nightly as profiles)
      Dir["#{path}/Users/*/AppData/Roaming/Mozilla"].map { |p| FirefoxResult.new("firefox", "Windows", p) },
      # Chrome
      Dir["#{path}/Users/*/AppData/Local/Google/Chrome/User Data"].map { |p| ChromeResult.new("chrome", "Windows", p) },
      Dir["#{path}/Users/*/AppData/Local/Google/Chrome Beta/User Data"].map { |p| ChromeResult.new("chrome-beta", "Windows", p) },
      Dir["#{path}/Users/*/AppData/Local/Google/Chrome SxS/User Data"].map { |p| ChromeResult.new("chrome-canary", "Windows", p) },
      # Opera
      Dir["#{path}/Users/*/AppData/Roaming/Opera Software/Opera Stable"].map { |p| OperaResult.new("opera", "Windows", p) }
    ].flatten
  end
end
