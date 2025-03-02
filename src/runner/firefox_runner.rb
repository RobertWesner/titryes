# frozen_string_literal: true

require_relative "base_runner"

# Executes the Firefox profile manager in a container
class FirefoxRunner < BaseRunner
  @built = false

  def self.build
    puts("Building Firefox...")
    system("docker build --build-arg user=$USER -t titryes/firefox docker/firefox > /dev/null 2>&1")
  end

  def self.run(at)
    unless @built
      build
      @built = true
    end

    start_container("firefox", at)
  end
end
