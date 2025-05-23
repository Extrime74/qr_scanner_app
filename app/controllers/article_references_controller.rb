class ArticleReferencesController < ApplicationController
  before_action :set_article_reference, only: %i[ show edit update destroy ]

  # GET /article_references or /article_references.json
  def index
    @article_references = ArticleReference.all
  end

  # GET /article_references/1 or /article_references/1.json
  def show
  end

  # GET /article_references/new
  def new
    @article_reference = ArticleReference.new
  end

  # GET /article_references/1/edit
  def edit
  end

  # POST /article_references or /article_references.json
  def create
    @article_reference = ArticleReference.new(article_reference_params)

    respond_to do |format|
      if @article_reference.save
        format.html { redirect_to @article_reference, notice: "Article reference was successfully created." }
        format.json { render :show, status: :created, location: @article_reference }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article_reference.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /article_references/1 or /article_references/1.json
  def update
    respond_to do |format|
      if @article_reference.update(article_reference_params)
        format.turbo_stream
        format.html { redirect_to @article_reference, notice: "Article reference was successfully updated." }
        format.json { render :show, status: :ok, location: @article_reference }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@article_reference, partial: "article_references/form", locals: { article_reference: @article_reference }) }
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article_reference.errors, status: :unprocessable_entity }
      end
    end
  end



  # DELETE /article_references/1 or /article_references/1.json
  def destroy
    @article_reference.destroy!

    respond_to do |format|
      format.html { redirect_to article_references_path, status: :see_other, notice: "Article reference was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  private

  def set_article_reference
    @article_reference = ArticleReference.find(params[:id])
  end

  def article_reference_params
    params.require(:article_reference).permit(:article, :name)
  end
end
