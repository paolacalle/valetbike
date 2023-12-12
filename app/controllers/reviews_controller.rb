class ReviewsController < ApplicationController
  def new
    @review = Review.new
    render :new
  end

  def create
    logger.info("entered create")
    puts params[:message]
    puts params[:station_id]
    puts params[:review]
    @user = User.find(current_user.id)
    user_id = @user
    station_id = params[:station_id]
    @review = Review.new(review_params)

    save_review
  end

  def save_review
    @review.user_id = current_user.id
    if @review.save
      flash[:success] = "Response submitted. Thank you for your feedback!"
      redirect_to home_path
    else 
      flash.now[:error] = @review.errors.full_messages.to_sentence
      render :new, status:500
    end
  end
  
  def review_params
    params.permit(:message, :station_id, :rating)
  end
end
