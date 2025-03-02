# frozen_string_literal: true

require_relative "base_runner"

# Executes a Chromium instance in a container
class ChromeRunner < BaseRunner
  @built = false

  def self.build
    puts("Building Chrome...")
    system("docker build --build-arg user=$USER -t titryes/chrome docker/chrome > /dev/null 2>&1")
  end

  def self.run(at)
    unless @built
      build
      @built = true
    end

    start_container("chrome", at)
  end
end
