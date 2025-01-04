# frozen_string_literal: true

require_relative "base_runner"

# Executes the Firefox profile manager in a container
class FirefoxRunner < BaseRunner
  @built = false

  def self.run(at)
    unless @built
      puts("Building container...")
      system("docker build --build-arg user=$USER -t titryes/firefox docker/firefox > /dev/null 2>&1")
      @built = true
    end

    start_container("firefox", at)
  end
end
