class DowngradeController < ApplicationController

  def downgrade
    current_user.update_attribute(:premium, false)
    revert_users_wikis_to_public if !current_user.admin?
    redirect_to edit_user_registration_path(current_user)
    flash[:notice] = "Your account has been downgraded from premium to standard."
  end

end
