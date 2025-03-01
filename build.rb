# frozen_string_literal: true

require_relative "src/setup"
require_relative "src/runner/firefox_runner"
require_relative "src/runner/chrome_runner"
require_relative "src/runner/opera_runner"

Setup.run
FirefoxRunner.build
ChromeRunner.build
OperaRunner.build
