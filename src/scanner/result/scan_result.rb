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
