class SnippetsController < ApplicationController
  before_action :require_login

  def index
    snippet_list = Snippet.includes(:language).where(:user_id => current_user_id)
    render json: snippet_list.map{|snippet| prepare_response_data(snippet, true)}
  end

  def show
    snippet_id = params.permit(:id)['id']
    snippet = Snippet.where(:user_id => current_user_id, :id => snippet_id).first
    render json: prepare_response_data(snippet)
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

    render json: prepare_response_data(snippet)
  end

  def update
    existing_snippet = Snippet.includes(:urls, :tags).find(params[:id])
    #existing_snippet.urls.destroy_all
    existing_snippet.update(snippet_params)
    
    render json: prepare_response_data(existing_snippet)
  end

  def destroy
    Snippet.destroy(params[:id])
  end

  private

  def prepare_response_data(snippet, is_index = false)
    url_list = snippet.urls.map{|item| {'id' => item.id, 'url' => item.url}}
    tag_list = snippet.tags.map{|tag| {'id' => tag.id, 'tag_assigns_id' => tag.tag_assigns.where(snippet_id: snippet.id).pluck(:id).first, 'name' => tag.name}}
    snippet_object = { id: snippet.id, title: snippet.title,
    language: snippet.language.name, :tags => tag_list}

    if is_index == false
      snippet_object[:snippet] = snippet.snippet
      snippet_object[:urls] = url_list
    end
    
    return snippet_object
 end

  def snippet_params
    params.permit(:id, :language_id, :title, :snippet, :tag_assigns_attributes  => [:id, :tag_id, :_destroy], :urls_attributes => [:id, :url, :_destroy])
  end
end
