# frozen_string_literal: true

# Runs through all mounted partitions providing ScanResults.
class PartitionProcessor
  def initialize(scanners)
    @scanners = scanners
  end

  def partitions
    `df -h --output=fstype,target | tail -n +2 | tr -s ' '`
      .split("\n")
      .map(&:split)
      .map { |part| { type: part[0].downcase, path: part[1] } }
      .reject { |item| item[:type] == "tmpfs" }
  end

  def process
    puts("Scanning mounted partitions.")

    scan_results = []
    partitions.each do |partition|
      puts("Found partition of type \"#{partition[:type]}\" on path \"#{partition[:path]}\"...")

      @scanners.each do |scanner|
        next unless scanner.applies?(partition[:type])

        scan_results.push(*scanner.scan(partition[:path]))
      end
    end

    scan_results
  end
end
