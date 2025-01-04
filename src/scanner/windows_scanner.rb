# frozen_string_literal: true

require_relative "base_scanner"

# Scanner for Windows
class WindowsScanner < BaseScanner
  def applies?(file_system)
    file_system == "ntfs"
  end

  def scan(path); end
end
