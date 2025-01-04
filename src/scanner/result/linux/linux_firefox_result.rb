require_relative "../firefox_result"

class LinuxFirefoxResult < FirefoxResult
  def copy(to)
    to = to + "/.mozilla/firefox"
    FileUtils.mkdir_p(to)
    FileUtils.copy_entry(@path, to)
  end
end
