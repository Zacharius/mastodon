# frozen_string_literal: true

class Auth::ConfirmationsController < Devise::ConfirmationsController
  layout 'auth'

  before_action :set_user, only: [:finish_signup]

  # GET/PATCH /users/:id/finish_signup
  def finish_signup
    return unless request.patch? && params[:user]
    if @user.update(user_params)
      @user.skip_reconfirmation!
      bypass_sign_in(@user)
      redirect_to root_path, notice: I18n.t('devise.confirmations.send_instructions')
    else
      @show_errors = true
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:email)
  end
end
