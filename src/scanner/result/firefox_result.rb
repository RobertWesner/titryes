# frozen_string_literal: true

require_relative "scan_result"
require_relative "../../runner/firefox_runner"

# Found Firefox
class FirefoxResult < ScanResult
  def copy(to)
    to += "/.mozilla/"
    FileUtils.mkdir_p(to)
    FileUtils.copy_entry(@path, to)
    FileUtils.mv("#{to}/Firefox", "#{to}/firefox") if File.exist?("#{to}/Firefox")
    FileUtils.mv("#{to}/Extensions", "#{to}/extensions") if File.exist?("#{to}/Extensions")
  end

  def run(at)
    copy(at)
    FirefoxRunner.run(at)
  end
end
