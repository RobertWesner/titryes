# frozen_string_literal: true

require "tmpdir"
require "sinatra"

require_relative "src/setup"
require_relative "src/partition_processor"
require_relative "src/scanner/windows_scanner"
require_relative "src/scanner/linux_scanner"

Setup.run
scan_results = []

set :port, 48723

get "/exit" do
  system("kill #{Process.pid}")
  system("docker kill titryes-desktop")
end

get "/svg" do
  send_file("svg/#{params[:name]}")
end

get "/" do
  send_file("app.html")
end

get "/scan" do
  scan_results = PartitionProcessor.new([
    WindowsScanner.new,
    LinuxScanner.new,
  ]).process
  scan_results.map { |scan_result| { browser: scan_result.browser, os: scan_result.os }}.to_json
end

get "/run" do
  Dir.mktmpdir do |d|
    scan_results[Integer(params[:id])].run(d)
  end
end

system("docker remove titryes-desktop")
system("docker build --build-arg user=$USER -t titryes/desktop docker/desktop #> /dev/null 2>&1")
system(%(
  docker run -d -e DISPLAY=$DISPLAY \\
    -v /tmp/.X11-unix:/tmp/.X11-unix \\
    -v /tmp/.docker.xauth:/tmp/.docker.xauth:rw \\
    -e XAUTHORITY=/tmp/.docker.xauth \\
    --shm-size=2gb \\
    --network host \\
    --name titryes-desktop \\
    -t titryes/desktop #> /dev/null 2>&1
))
