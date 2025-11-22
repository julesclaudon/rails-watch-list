class HomeController < ApplicationController
  def home
    @lists = List.order(created_at: :desc)
  end
end


