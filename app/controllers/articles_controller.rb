class ArticlesController < ApplicationController
  def index

    @articles=Article.all.order(:created_at).page(params[:page]).per(8)
    @comments = Comment.all

    respond_to do |format|
      format.html
      format.csv { send_data Article.to_csv }
      format.xls

    end
  end

  def show
    @article = Article.find_by_id(params[:id])
    @comments = @article.comments.order("id desc")
    @comment = Comment.new
    respond_to do |format|
      format.html
      format.csv { send_data Article.to_csv }
      format.xls
    end

  end

  def new
    @article_import = Article.new

  end

  def edit
    @article = Article.find_by_id(params[:id])
  end

  def create

    @article_import = Article.new(params[:article_import])

    if @article_import.save
      redirect_to root_url, notice: "Imported products successfully."
    else
      render :new
    end

  end

  def update

    @article = Article.find_by_id(params[:id])

    if @article.update(params_article)

      flash[:notice] = "Success Update Records"

      redirect_to action: 'index'

    else

      flash[:error] = "data not valid"

      render 'edit'

    end

  end

  def import

    valid_keys= ["id","title","content","created_at","updated_at"]

    total_row = 0
    spreadsheet = Import.open_spreadsheet(params[:file])

    header = Array.new
    spreadsheet.row(1).each { |row| header << row.downcase.tr(' ', '_') }
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
        valid=row.to_hash.slice(*valid_keys)

      data = Article.create(valid)

      spreadsheet.default_sheet= spreadsheet.sheets.last

      header = Array.new
      spreadsheet.row(1).each { |row| header << row.downcase.tr(' ', '_') }
      (2..spreadsheet.last_row).each do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        data=row.to_hash.slice(*valid_keys)

        comment = Article.last.comments.create(data)

      end
    end

    redirect_to root_url, notice: "Products imported."
  end

  def destroy

    @article = Article.find_by_id(params[:id])

    if @article.destroy

      flash[:notice] = "Success Delete a Records"

      redirect_to action: 'index'

    else

      flash[:error] = "fails delete a records"

      redirect_to action: 'index'

    end

  end

  private

  def params_article
    params.require(:article).permit(:title, :content, :status)

  end

  private

  def change_format
    request.format = "xls"
  end

  def params_comment
    params.require(:comment).permit(:content)

  end

end
