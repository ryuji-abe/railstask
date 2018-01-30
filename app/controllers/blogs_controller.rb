class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  before_action :require_login, only: [:new, :edit, :show]

  def index
    @blogs = Blog.all
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.create(blog_params)
    @blog.user_id = current_user.id
    if @blog.save
      BlogMailer.created_blog_mail(@blog).deliver
      redirect_to blogs_path, notice: 'ブログを作成しました'
    else
      render 'new'
    end
  end

  def edit
    @blog = Blog.find(params[:id])
  end

  def update
    @blog = Blog.find(params[:id])
    if @blog.update(blog_params)
      redirect_to blogs_path, notice: 'ブログを更新しました'
    else
      render 'edit'
    end
  end

  def destroy
    @blog.destroy
    redirect_to blogs_path, notice: 'ブログを削除しました'
  end

  def show
    @blog = Blog.find(params[:id])
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)
  end

  private
  def blog_params
    params.require(:blog).permit(:title, :content, :image)
  end

  def set_blog
    @blog = Blog.find(params[:id])
  end

  def require_login
    unless logged_in?
      redirect_to new_session_path
    end
  end

end
