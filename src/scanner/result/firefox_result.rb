# frozen_string_literal: true

require_relative "scan_result"
require_relative "../../runner/firefox_runner"

# Found Firefox
class FirefoxResult < ScanResult
  def copy(to)
    to += "/.mozilla/firefox"
    FileUtils.mkdir_p(to)
    FileUtils.copy_entry(@path, to)
  end

  def run(at)
    copy(at)
    FirefoxRunner.run(at)
  end
end
