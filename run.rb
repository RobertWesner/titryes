# frozen_string_literal: true

require "tmpdir"

require_relative "src/scanner/windows_scanner"
require_relative "src/scanner/linux_scanner"

puts(
  <<~'TITLE'
     _____ _ _
    |_   _(_) |_ _ __ _   _  ___  ___
      | | | | __| '__| | | |/ _ \/ __|
      | | | | |_| |  | |_| |  __/\__ \
      |_| |_|\__|_|   \__, |\___||___/
                      |___/

  TITLE
)

# TODO: check for docker being installed
# TODO: check for Xorg

puts("/!\\ Make sure to have mounted all partitions you intend to scan.\n\n")

puts("Running setup...")
system("
    docker build --build-arg user=$USER --build-arg uid=$(id -u) --build-arg gid=$(id -g) \\
        -t titryes/base \\
        docker >/dev/null 2>&12
")
system("xauth nlist $DISPLAY | sed -e \"s/^..../ffff/\" | xauth -f /tmp/.docker.xauth nmerge - > /dev/null 2>&1")

scanners = [
  WindowsScanner.new,
  LinuxScanner.new
]

puts("Scanning mounted partitions.")
partitions = `df -h --output=fstype,target | tail -n +2 | tr -s ' '`
             .split("\n")
             .map(&:split)
             .map { |part| { type: part[0].downcase, path: part[1] } }
             .reject { |item| item[:type] == "tmpfs" }

scan_results = []
partitions.each do |partition|
  puts("Found partition of type \"#{partition[:type]}\" on path \"#{partition[:path]}\"...")

  scanners.each do |scanner|
    next unless scanner.applies?(partition[:type])

    puts("Scanning...")
    scan_results.push(*scanner.scan(partition[:path]))
  end
end

puts("\nFound the following browsers:")

results_text = "\n"
# @type result [ScanResult]
scan_results.each_with_index do |result, i|
  results_text += "#{i + 1}) #{result.browser} on #{result.os}\n"
end
results_text += "e) Exit\n\n> "

loop do
  print(results_text)
  input = (gets || "").strip.downcase

  break if input == "e"

  # @type result [ScanResult]
  result = scan_results[input.to_i - 1] || nil
  next if result.nil?

  Dir.mktmpdir do |d|
    result.run(d)
  end
end
