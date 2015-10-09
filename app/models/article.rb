require 'csv'
require 'roo'
require 'spreadsheet'
require 'zip'
# require 'zip/zip'

require 'roo/base'
class Article < ActiveRecord::Base






  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |article|
        csv << article.attributes.values_at(*column_names)
      end
    end
  end





def self.import(file)
  
valid_keys= ["title","content","status"]

total_row = 0
    spreadsheet = open_spreadsheet(file)

    spreadsheet.sheets.each_with_index do |sheet, index|
      spreadsheet.default_sheet = spreadsheet.sheets[index]
# byebug
      header = Array.new
      spreadsheet.row(1).each { |row| header << row.downcase.tr(' ', '_') }
      (2..spreadsheet.last_row).each do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        data = find_by_id(row["id"]) || new
    data.attributes = row.to_hash.slice(*valid_keys)
    data.save!

      end

end  
end

  




def self.open_spreadsheet(file)
  case File.extname(file.original_filename)
  when '.csv' then Roo::Csv.new(file.path,csv_options: {encoding: "iso-8859-1:utf-8"})
when '.xls' then Roo::Excel2003XML.new(file.path, nil,  :ignore)
when  '.ods' then Roo::OpenOffice.new(file.path, :password => "password") 
  else raise "Unknown file type: #{file.original_filename}"
  end
end




  has_many :comments, dependent: :destroy

  #       validates :title, presence: true, length: { minimum: 1 }

  #       validates :content, presence: true, length: { minimum: 1 }

  #       validates :status, presence: true

  #       scope :status_active, -> {where(status: 'active')}
end
