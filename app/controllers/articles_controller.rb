class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  #impressionist actions: [:show], unique: [:session_hash, :params, :referrer]

  # GET /articles
  # GET /articles.json
  def index
    if params[:search]
      @articles = Article.search(params[:search])
    elsif params[:tag]
      @articles = Article.tagged_with(params[:tag])
    else
      @articles = Article.all
    end
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @article = Article.find(params[:id])
    impressionist(@article, nil ,unique: [:session_hash])
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)    
  end

  # GET /articles/new
  def new
    p "begin new"
    @article = Article.new
    p "end new"
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create

    @article = Article.create(params.require(:article).permit(:title, :body, :create_date, :all_tags))

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

  def create_comment
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(params.require(:article).permit(:title, :body, :create_date, :all_tags))
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :body, :create_date)
    end
end
