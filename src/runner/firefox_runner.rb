require_relative "base_runner"

class FirefoxRunner < BaseRunner
  @built = false

  def self.run(at)
    unless @built
      puts("Building container...")
      system("docker build --build-arg user=$USER -t titryes/firefox docker/firefox > /dev/null 2>&1")
      @built = true
    end

    self.start_container("firefox", at)
  end
end
