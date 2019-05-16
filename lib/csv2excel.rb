require 'csv2excel/version'
require 'csv'
require 'axlsx'

module Csv2excel
  class Error < StandardError; end

  # Convert csv to xlsx
  #
  # @param [String] file csv file path
  def self.to_xlsx(file:)
    Axlsx::Package.new do |p|
      p.workbook.add_worksheet(name: 'Sheet1') do |sheet|
        CSV.foreach file do |row|
          sheet.add_row row
        end
      end
      p.serialize("#{File.dirname(file)}/#{File.basename(file, '.csv')}.xlsx")
    end
  end
end

class CSV

  # Convert csv to xlsx
  #
  # @param [String] file csv file path
  # @param [String] dir directory path
  def self.to_xlsx(file: nil, dir: nil)
    unless dir.nil?
      Dir.glob("#{dir}/*.csv").each do |file|
        Csv2excel.to_xlsx(file: file)
      end
      return
    end

    raise ArgumentError, 'Please input named argument(:file)!' if file.nil?

    Csv2excel.to_xlsx(file: file)
  end
end