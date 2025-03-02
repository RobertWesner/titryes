# frozen_string_literal: true

require_relative "base_runner"

# Executes a Chromium instance in a container
class OperaRunner < BaseRunner
  @built = false

  def self.build
    puts("Building Opera...")
    system("docker build --build-arg user=$USER -t titryes/opera docker/opera > /dev/null 2>&1")
  end

  def self.run(at)
    unless @built
      build
      @built = true
    end

    start_container("opera", at)
  end
end
