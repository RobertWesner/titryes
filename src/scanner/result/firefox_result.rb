require_relative "scan_result"
require_relative "../../runner/firefox_runner"

class FirefoxResult < ScanResult
  def copy(to)
    to = to + "/.mozilla/firefox"
    FileUtils.mkdir_p(to)
    FileUtils.copy_entry(@path, to)
  end

  def run(at)
    copy(at)
    FirefoxRunner.run(at)
  end
end
