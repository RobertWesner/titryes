# frozen_string_literal: true

require_relative "base_runner"

# Executes a Chromium instance in a container
class ChromeRunner < BaseRunner
  @built = false

  def self.run(at)
    unless @built
      puts("Building container...")
      system("docker build --build-arg user=$USER -t titryes/chrome docker/chrome > /dev/null 2>&1")
      @built = true
    end

    start_container("chrome", at)
  end
end
