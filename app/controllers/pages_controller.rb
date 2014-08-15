class PagesController < ApplicationController
	skip_authorization_check
	before_filter :authenticate_user!
  def dashboard
  end
end
