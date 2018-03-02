class CoursesController < ApplicationController
  protect_from_forgery except: [:payment_notification]

  def index
    @courses = Course.all
  end

  def show
    @course = Course.find(params[:id])
    @tasks = @course.tasks
  end

  def subscribe
    @course = Course.find(params[:id])
    @subscription = Subscription.find_or_create_by(user: current_user, course_id: params[:id])
    if @subscription.active?
      redirect_to @course
    else
      values = {
        :business => "adhamkurniawan29-facilitator@gmail.com",
        :cmd => "_xclick",
        :amount => @course.price,
        :notify_url => "https://course-sell.herokuapp.com/payment-notification",
        :item_name => @course.title,
        :item_number => @subscription.id,
        :quantity => 1,
        :return_url => "https://course-sell.herokuapp.com/my-courses"
      }
      redirect_to "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
    end
  end

  def my_courses
    @courses = current_user.courses
  end

  def payment_notification
    params.permit!
    @subscription = Subscription.find(params[:item_number])
    @subscription.update_attributes({active: true}) if @subscription.active == false && params[:payment_status] == "Completed"
    respond_to do |format|
      format.html { render text: "ok" }
    end
  end
end
