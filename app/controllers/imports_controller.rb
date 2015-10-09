require 'csv'
require 'roo'
require 'spreadsheet'
require 'zip'

# require 'zip/zip'

require 'roo/base'

class ImportsController < ApplicationController
  def import

    valid_keys= ["title","content","status"]

    total_row = 0
    spreadsheet = Import.open_spreadsheet(params[:file])

    # spreadsheet.sheets.each_with_index do |sheet, index|
    #   spreadsheet.default_sheet = spreadsheet.sheets[index]
    # byebug
    header = Array.new
    spreadsheet.row(1).each { |row| header << row.downcase.tr(' ', '_') }
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      data = Article.create(row)

      spreadsheet.default_sheet= spreadsheet.sheets.last

      header = Array.new
      spreadsheet.row(1).each { |row| header << row.downcase.tr(' ', '_') }
      (2..spreadsheet.last_row).each do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        user_is=Article.all.select(:id)
        # accesible=["id","content"]

        # comment= row.to_hash.slice(accesible)
        # byebug

        comment = Comment.create(row)

        @articles=Article.all.order(:created_at).page(params[:page]).per(5)
        @comments = Comment.all
        redirect_to action: 'articles/index'

      end

    # end

    end
  end

end
