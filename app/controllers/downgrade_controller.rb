class DowngradeController < ApplicationController

  def downgrade
    current_user.update_attribute(:premium, false)
    redirect_to edit_user_registration_path(current_user)
    flash[:alert] = "Your account has been downgraded from premium to standard"
  end

end
