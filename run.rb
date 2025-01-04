require 'tmpdir'

require_relative "src/scanner/windows_scanner"
require_relative "src/scanner/linux_scanner"

puts(<<'EOS'
 _____ _ _                        
|_   _(_) |_ _ __ _   _  ___  ___ 
  | | | | __| '__| | | |/ _ \/ __|
  | | | | |_| |  | |_| |  __/\__ \
  |_| |_|\__|_|   \__, |\___||___/
                  |___/           

EOS
)

# TODO: check for docker being installed
# TODO: check for Xorg

puts("/!\\ Make sure to have mounted all partitions you intend to scan.\n\n")

puts("Running setup...")
system("""
    docker build --build-arg user=$USER --build-arg uid=$(id -u) --build-arg gid=$(id -g) \\
        -t titryes/base \\
        docker >/dev/null 2>&12
""")
system("xauth nlist $DISPLAY | sed -e \"s/^..../ffff/\" | xauth -f /tmp/.docker.xauth nmerge - > /dev/null 2>&1")

scanners = [
  WindowsScanner.new,
  LinuxScanner.new,
]

puts("Scanning mounted partitions.")
partitions = `df -h --output=fstype,target | tail -n +2 | tr -s ' '`
  .split("\n")
  .map { |line| line.split(" ") }
  .map { |part| {type: part[0].downcase, path: part[1]} }
  .select { |item| item[:type] != "tmpfs" }

scan_results = []
partitions.each do |partition|
  puts("Found partition of type \"" + partition[:type] + "\" on path \"" + partition[:path] + "\"...")

  scanners.each do |scanner|
    unless scanner.applies?(partition[:type])
      next
    end

    puts("Scanning...")
    scan_results.push(*scanner.scan(partition[:path]))
  end
end

puts("\nFound the following browsers:")

# @type result [ScanResult]
scan_results.each_with_index do |result, i|
  puts((i + 1).to_s + ") " + result.browser + " on " + result.os)
end
puts("e) Exit")

while true
  print("> ")
  input = (gets || "").strip.downcase

  if input == "e"
    break
  end

  # @type result [ScanResult]
  result = scan_results[input.to_i - 1] || nil
  if result == nil
    next
  end

  Dir.mktmpdir do |d|
    result.run(d)
  end
end