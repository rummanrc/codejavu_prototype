class SnippetsController < ApplicationController
  before_action :require_login

  def index
    render json: render_snippet(snippet).where(:user_id => current_user_id)
  end

  def show
    snippet_id = params.permit(:id)['id']
    snippet = Snippet.includes(:language, :url).where(:user_id => current_user_id, :id => snippet_id).first
    render json: render_snippet(snippet)
  end

  def create
    snippet = Snippet.new(snippet_params)
    snippet.user_id = current_user_id

    if snippet.invalid?
      return render :json => {
        :errors => snippet.errors.full_messages
      }, :status => :unprocessable_entity
    end

    snippet.save
    render json: render_snippet(snippet)
  end

  def update
    snippet = Snippet.find(params[:id])
    snippet.update(snippet_params)
    render json: render_snippet(snippet)
  end

  def destroy
    Snippet.destroy(params[:id])
  end

  private

  def render_snippet(snippet)
    { id: snippet.id, title: snippet.title, snippet: snippet.snippet, language: snippet.language.name}
  end

  def snippet_params
    params.permit(:id, :language_id, :title, :snippet)
  end
end
