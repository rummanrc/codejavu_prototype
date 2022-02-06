class SnippetsController < ApplicationController
  before_action :require_login

  def index
    render json: Snippet.where(:user_id => current_user_id)
  end

  def show
    snippet_id = params.permit(:id)['id']
    snippet = Snippet.includes(:language, :url).where(:user_id => current_user_id, :id => snippet_id).first
    render json: snippet
  end

  def create
    snippet = Snippet.new(snippet_params)

    if snippet.invalid?
      return render :json => {
        :errors => snippet.errors.full_messages
      }, :status => :unprocessable_entity
    end

    snippet.user_id = current_user_id
    snippet.save
    render json: snippet
  end

  def update
    snippet = Snippet.find(params[:id])
    snippet.update(snippet_params)
    render json: snippet
  end

  def destroy
    Snippet.destroy(params[:id])
  end

  private

  def snippet_params
    params.permit(:id, :language_id, :title, :snippet)
  end
end
