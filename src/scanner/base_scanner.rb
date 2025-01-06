# frozen_string_literal: true

# Base-class scanning a file system partition for specific operating systems
class BaseScanner
  def applies?(file_system); end

  def scan(path); end
end
