class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  
  def index
    #show applicants' info, takes a parameter 'name'
    presenter_response = get_applicant_details(params['name'])
    render_success(presenter_response)
  end
  
  def show
    #takes day month and year as parameter and prints all users whose permits has expired as parameter
    
  end
  
  private
  def get_applicant_details(name_substring)
    ApplicationPresenter.index(name_substring)
    
  end
  
  def render_success(response)
    render :json => {:http_code => 200, :status => :ok, :response => response}
  end
end
