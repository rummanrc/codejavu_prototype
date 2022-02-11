class TagsController < ApplicationController
  before_action :require_login

  def index
    render json: Tag.all.map{|tag| {'id' => tag.id, 'name' => tag.name}}
  end
end
