require_relative "base_scanner"
require_relative "result/linux/linux_firefox_result"

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
      result.push(LinuxFirefoxResult.new("Firefox", "Linux", p))
    end

    # TODO: chrome and stuff

    result
  end
end
