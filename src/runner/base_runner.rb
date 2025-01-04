class BaseRunner
  def self.start_container(container, path)
    puts(container + " " + path)
    system(%{
      docker run -e DISPLAY=$DISPLAY \\
        -v /tmp/.X11-unix:/tmp/.X11-unix \\
        -v /tmp/.docker.xauth:/tmp/.docker.xauth:rw \\
        -v #{path}:/home/$USER \\
        -e XAUTHORITY=/tmp/.docker.xauth \\
        -t titryes/#{container} > /dev/null 2>&1
    })
  end

  def self.run(at)
  end
end
