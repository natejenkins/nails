class UserController < Nails::Controller

  def show
    @user = User.find(params["user_id"])
    @posts = @user.post
  end

  def index
    @users = User.all
  end

  def create
    @user = User.new(params["user"])
    @user.save
    @posts = []
    render "show"
  end

  def new
    @user = User.new
  end
end