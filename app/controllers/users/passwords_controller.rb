class Users::PasswordsController < Devise::PasswordsController
  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  def create
    if !current_user.nil?
      @user = current_user
      if params[:new_password] == params[:confirm_password] && !params[:new_password].empty?
        @user.reset_password(params[:new_password], params[:confirm_password])
        render status: :ok, json: @user
      else
        passwords_not_correct
      end
    elsif (@user = User.find_by(email: params[:email])).present?
        if params[:new_password] == params[:confirm_password] && !params[:new_password].empty?
          @user.reset_password(params[:new_password], params[:confirm_password])
          render status: :ok, json: @user
        else
          passwords_not_correct
        end
    else
        user_not_found 
    end
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  def edit
    super
  end

  # PUT /resource/password
  def update
    super
  end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end

  private

  def user_not_found
    render json: {error:"User not Found"}, status: :not_found
  end

  def passwords_not_correct
    render json: {error:"Passwords not Same"}, status: :bad_request
  end

end