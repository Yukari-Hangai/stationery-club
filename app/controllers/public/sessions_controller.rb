# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :user_state, only: [:create]
  before_action :authenticate_user!
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  
  def after_sign_in_path_for(resource)
    my_page_path
  end
  
  def after_sign_out_path_for(resource)
    root_path
  end
  
  protected
  
  # 退会しているかを判断するメソッド
  def user_state
    @user = User.find_by(email: params[:user][:email])#入力されたemailとuserの中のemailが一致するアカウントを@userに代入
    if @user
      if @user.valid_password?(params[:user][:password]) && (@user.is_deleted == true)#@userのpasswordと入力されたpasswordが一致している且つ退会フラグ（is_deleted)がtrue（退会）か
        flash[:notice] = "退会済みです。再度ご登録をしてご利用ください"
        redirect_to new_user_registration_path#true && trueの時true=退会している
      end
    else
      flash[:notice] = "該当するユーザーが見つかりません"
    end
  end
end
