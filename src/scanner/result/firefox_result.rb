require_relative "scan_result"
require_relative "../../runner/firefox_runner"

class FirefoxResult < ScanResult
  def run(at)
    copy(at)
    FirefoxRunner.run(at)
  end
end
