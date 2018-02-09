class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def revert_users_wikis_to_public
    current_user.wikis.each do |wiki|
      wiki.update_attribute(:private, false)
    end
  end

end
