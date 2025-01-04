require_relative "scan_result"
require_relative "../../runner/chrome_runner"

class ChromeResult < ScanResult
  def copy(to)
    to += "/.google-chrome/chromium"
    FileUtils.mkdir_p(to)
    FileUtils.copy_entry(@path, to)
    # Bypass "The profile appears to be in use by another..."
    Dir.glob(to + "/Singleton*").each { |file| File.delete(file) }
  end

  def run(at)
    copy(at)
    ChromeRunner.run(at)
  end
end
