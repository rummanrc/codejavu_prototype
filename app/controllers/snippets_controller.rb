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

    params[:urls].each {|item| Url.new(snippet_id: snippet.id,url: item).save}
    params[:tags].each {|item| TagAssign.new(snippet_id: snippet.id, tag_id: item).save}

    render json: prepare_response_data(snippet)
  end

  def update
    snippet = Snippet.find(params[:id])
    snippet.update(snippet_params)
    render json: prepare_response_data(snippet)
  end

  def destroy
    Snippet.destroy(params[:id])
  end

  private

  def prepare_response_data(snippet, is_index = false)
    url_list = snippet.urls.map{|item| item.url}
    tag_list = snippet.tags.map{|tag| {'id' => tag.id, 'name' => tag.name}}
    snippet_object = { id: snippet.id, title: snippet.title,
    language: snippet.language.name, :tags => tag_list}

    if is_index == false
      snippet_object[:snippet] = snippet.snippet
      snippet_object[:urls] = url_list
    end
    
    return snippet_object
  end

  def snippet_params
    params.permit(:id, :language_id, :title, :snippet, :urls, :tags)
  end
end
