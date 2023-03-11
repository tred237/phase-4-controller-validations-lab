class PostsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_post_data_response


  def show
    post = find_posts
    render json: post
  end

  def update
    post = find_posts
    post.update!(post_params)
    render json: post
  end

  private

  def post_params
    params.permit(:category, :content, :title)
  end

  def find_posts
    Post.find(params[:id])
  end

  def unprocessable_post_data_response(invalid)
    render json: { errors: invalid.record.errors }, status: :unprocessable_entity
  end

end
