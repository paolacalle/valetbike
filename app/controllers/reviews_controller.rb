class ReviewsController < ApplicationController
  def new
    @review = Review.new
    render :new
  end

  def create
    logger.info("entered create")
    puts params[:message]
    @user = User.find(current_user.id)
    user_id = @user
    message = :message
    @review = Review.new(review_params)

    save_review
  end

  def save_review
  end

  def review_params
    params.permit(:message, :station_id)
  end
end
