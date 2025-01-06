# frozen_string_literal: true

require_relative "base_scanner"

# Scanner for Windows
class WindowsScanner < BaseScanner
  def applies?(file_system)
    %w[ntfs fuseblk].include?(file_system)
  end

  def scan(path)
    return [] unless Dir.exist?("#{path}/Users")

    puts("Found Windows...")

    # Firefox (+ Dev and Nightly as profiles)
    result = Dir["#{path}/Users/*/AppData/Roaming/Mozilla"].map { |p| FirefoxResult.new("Firefox", "Windows", p) }
    # Chrome
    # TODO: check if this includes extensions
    result + Dir["#{path}/Users/*/AppData/Local/Google/Chrome/User Data"].map { |p| ChromeResult.new("Chrome", "Windows", p) }
  end
end
