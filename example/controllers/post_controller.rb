class PostController < Nails::Controller
  def show
    @user = User.find(params["user_id"])
    @post = Post.find(params["post_id"])

    ### You can include a specific template to render instead of the default
    #render "alternate_show"
  end

  def index
    @posts = Post.all
  end

  def new
    @user = User.find(params["user_id"])
    @post = Post.new
  end

  def create
    @user = User.find(params["user_id"])
    @post = Post.new(params["post"])
    @post.save
    render "show"
  end

end