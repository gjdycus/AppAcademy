class PostsController < ApplicationController

  def new
    @post = Post.new
    @subs = Sub.all
    render :new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to post_url(@post)
    else
      flash.now['errors'] = @post.errors.full_messages
      render :new
    end
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash.now['errors'] = @post.errors.full_messages
      render :edit
    end
  end

  def edit
    @post = Post.find(params[:id])
    render :edit
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to subs_url
    else
      flash.now['errors'] = @post.errors.full_messages
      render :show
    end
  end

  def show
    @post = Post.find(params[:id])
    render :show
  end

  private

  def post_params
    params[:post][:author_id] = current_user.id
    params.require(:post).permit(:title, :url, :content, :author_id, sub_ids: [])
  end

end
