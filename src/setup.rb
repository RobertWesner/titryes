# frozen_string_literal: true

class Setup
  def self.run
    puts("Running setup...")
    build_base_image
    build_desktop_image
    create_xorg_configuration
  end

  def self.build_base_image
    puts("Creating alpine base image...")
    system(
      <<~'SHELL'
        docker build --build-arg user=$USER --build-arg uid=$(id -u) --build-arg gid=$(id -g) \
          --target base \
          -t titryes/base \
          docker > /dev/null 2>&1
      SHELL
    )
    puts("Creating ubuntu base image...")
    system(
      <<~'SHELL'
        docker build --build-arg user=$USER --build-arg uid=$(id -u) --build-arg gid=$(id -g) \
          --target base_ubuntu \
          -t titryes/base-ubuntu \
          docker > /dev/null 2>&1
      SHELL
    )
  end

  def self.build_desktop_image
    puts("Creating desktop image...")
    system("docker build --build-arg user=$USER -t titryes/desktop docker/desktop > /dev/null 2>&1")
  end

  def self.create_xorg_configuration
    puts("Creating Xorg configuration...")
    system("xauth nlist $DISPLAY | sed -e \"s/^..../ffff/\" | xauth -f /tmp/.docker.xauth nmerge - > /dev/null 2>&1")
  end
end
