class Import < ActiveRecord::Base









def self.open_spreadsheet(file)
  case File.extname(file.original_filename)
  when '.csv' then Roo::Csv.new(file.path,csv_options: {encoding: "iso-8859-1:utf-8"})
when '.xls' then Roo::Excel2003XML.new(file.path, nil,  :ignore)
when  '.ods' then Roo::OpenOffice.new(file.path, :password => "password") 
  else raise "Unknown file type: #{file.original_filename}"
  end
end


end
