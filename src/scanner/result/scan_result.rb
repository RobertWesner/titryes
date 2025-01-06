# frozen_string_literal: true

# Result of a successful scan.
# Contains information about found browser, operating system, and path
class ScanResult
  attr_reader :browser, :os

  def initialize(browser, os, path)
    @browser = browser
    @os = os
    @path = path
  end

  def copy(to); end

  def run(at); end
end
