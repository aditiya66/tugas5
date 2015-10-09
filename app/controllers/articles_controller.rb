class ArticlesController < ApplicationController

  def index

  	@articles=Article.all.order(:created_at).page(params[:page]).per(5)
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
    #  @article = Article.new(params_article)
    # if @article.save
    #     flash[:notice] = "Success Add Records"
    #     redirect_to action: 'index'
    # else
    # Article.import(params[:file])
    #  redirect_to root_url, notice: "Products imported."
    # @article = Article.new(params[:article])
    #    if @article.save
    #      redirect_to root_url, notice: "Imported products successfully."
    #    end



      
      @article_import = Article.new(params[:article_import])


      if @article_import.save
      redirect_to root_url, notice: "Imported products successfully."
    else
      render :new
    end
  







    #     flash[:error] = "data not valid"

    #     render 'new'

    # end

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

               comment = Article.last.comments.create(row)


    @articles=Article.all.order(:created_at).page(params[:page]).per(5)
    @comments = Comment.all

end




      # end

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
