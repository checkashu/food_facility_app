class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  
  def index
    #show applicants' info, takes a parameter 'name'
    if params['check_expiration'] == true
      presenter_response = get_expired_permits(params['date'])
    elsif params['street_name_search'] == true
      presenter_response = get_applicant_by_street_name(params['street_name'])
    else
      presenter_response = get_applicant_by_name(params['name'])
    end  
    render_success(presenter_response)
  end

  def add_entry
    ApplicationPresenter.add_entry(params)
    render_success(I18n.t 'entry_made')
  end

  def destroy
    ApplicationPresenter.delete_entry(params)
    render_success(I18n.t 'entry_deleted')
  end

  private
  
  def get_applicant_by_street_name(street_name)
    render_failure({:error => I18n.t 'no_name'}) if street_name.nil?
    ApplicationPresenter.present_applicants_by_street_name(street_name)
  end
  
  def get_expired_permits(date)
    validate_date(date)
    time = Time.parse(date)
    ApplicationPresenter.present_expired(time)
  end
  
  def validate_date(date)
    begin
      Date.parse(date)
    rescue ArgumentError
      render_failure({:error => I18n.t 'incorrect_date'})
    end
  end
    
  def get_applicant_by_name(name_substring)
    render_failure({:error => I18n.t 'no_name'}) if name_substring.nil?
    ApplicationPresenter.present_applicants_by_name(name_substring)
  end
  
  def render_success(response)
    render :json => {:http_code => 200, :status => :ok, :response => response}
  end
  
  def render_failure(failure_response = {}, status = 400)
    render :json => {:status => :error, :http_code => status}.merge(failure_response)
  end
end
