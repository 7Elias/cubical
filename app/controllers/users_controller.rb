class UsersController < Clearance::UsersController


  def new
    @user = user_from_params
    render template: "users/new"
  end

  def create

    @user = user_from_params

    if @user.save
      sign_in @user
      redirect_back_or url_after_create
    else
      render template: "users/new"
    end
  end

  def edit
  end

  private

  def user_from_params

    email = user_params.delete(:email)
    password = user_params.delete(:password)
    name = user_params.delete(:name)
    avatar = user_params.delete(:avatar)

    Clearance.configuration.user_model.new(user_params).tap do |user|
      user.email = email
      user.password = password
      user.name = name
      user.avatar = avatar
    end
  end

  def user_params

    params.require(:user).permit(:email,:name, :password, :avatar_cache, :avatar,:user_id)
  end
end
