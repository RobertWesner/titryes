# frozen_string_literal: true

require_relative "scan_result"
require_relative "../../runner/opera_runner"

# Found Opera or Opera GX
class OperaResult < ScanResult
  def copy(to)
    to += "/.config/opera/"
    FileUtils.mkdir_p(to)
    FileUtils.copy_entry(@path, to)
  end

  def run(at)
    copy(at)
    OperaRunner.run(at)
  end
end
