class ArticlesController < ApplicationController
   # before_filter :change_format






    # @paginatable_array = Kaminari.paginate_array(my_array_object).page(params[:page]).per(10)
  def index





  	@articles=Article.all.order(:created_at).page(params[:page]).per(5)
    @comments = Comment.all



    respond_to do |format|
      format.html
      format.csv { send_data Article.to_csv }
      # format.pdf{send_data Article.to_csv}
         # format.xlsx 

   format.xls
   # format.xls { send_data Article.to_csv(col_sep: "\t") }

    end
    # @articles =Article.status_active






  end


 




  def show
   @article = Article.find_by_id(params[:id])
    @comments = @article.comments.order("id desc")
    @comment = Comment.new
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
  Article.import(params[:file])
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


end
