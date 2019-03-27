class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    arg = ["articles.id > '0'"]
    search_columns = %w(users.name title content)

    search_columns.each do |column|
      if params[:"#{column}"].present?
        arg[0] << " AND #{column} LIKE ?"
        arg << '%' + params[:"#{column}"] + '%'
      end      
    end
    # @articles = Article.joins(:user).where(
      # "articles.id > '0' AND users.name LIKE ? title LIKE ?", '1', 'こころ'
    # )
    @articles = Article.joins(:user).where(arg)
  end

  def show
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :content, :user_id, :blog_id, :is_published)
    end
end
