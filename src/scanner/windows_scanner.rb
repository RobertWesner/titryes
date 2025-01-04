require_relative "base_scanner"

class WindowsScanner < BaseScanner
  def applies?(file_system)
    file_system == "ntfs"
  end

  def scan(path); end
end
