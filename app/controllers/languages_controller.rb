class LanguagesController < ApplicationController
  before_action :require_login

  def index
    render json: Language.all.map{|language| {'id' => language.id, 'name' => language.name}}
  end
end
