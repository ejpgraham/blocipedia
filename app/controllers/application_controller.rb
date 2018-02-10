class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def user_is_collobarator?(wiki)
    wiki.collaborators.pluck(:user_id).include?(current_user.id)
  end

  def revert_users_wikis_to_public
    current_user.wikis.each do |wiki|
      wiki.update_attribute(:private, false)
    end
  end

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end

end
