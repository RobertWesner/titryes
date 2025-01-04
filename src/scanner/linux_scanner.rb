require_relative "base_scanner"
require_relative "result/firefox_result"
require_relative "result/chrome_result"

class LinuxScanner < BaseScanner
  def applies?(file_system)
    %w[ext ext2 ext3 ext4 btrfs xfs zfs].include?(file_system)
  end

  def scan(path)
    unless Dir.exist?(path + "home")
      return []
    end

    result = []
    # Firefox (+ Dev and Nightly as profiles)
    Dir[path + "home/*/.mozilla/firefox"].each do |p|
      result.push(FirefoxResult.new("Firefox", "Linux", p))
    end

    # Chromium
    Dir[path + "home/*/.config/chromium"].each do |p|
      result.push(ChromeResult.new("Chrome", "Linux", p))
    end

    # TODO: chrome and stuff

    result
  end
end
