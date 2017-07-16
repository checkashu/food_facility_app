class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  
  
  def index
    puts params
    if params['check_expiration'] == 'true'
      return unless params['date'] && validate_date(params['date'])
      presenter_response = get_expired_permits(params['date'])
    elsif params['street_name_search'] == 'true'
      unless params['street_name']
        render_failure(:error => I18n.t('no_street'))
        return
      end
      presenter_response = get_applicant_by_street_name(params['street_name'])
    else
      unless params['name']
        render_failure(:error => I18n.t('no_name'))
        return
      end
      presenter_response = get_applicant_by_name(params['name'])
    end  
    render_success(presenter_response)
  end

  def add_entry
    begin
      ApplicationPresenter.add_entry(params)
      render_success(I18n.t 'entry_made')
    rescue
      render_failure(:error => I18n.t('something_wrong'))
    end
  end

  def destroy
    begin
      ApplicationPresenter.delete_entry(params['objectid'])
      render_success(I18n.t 'entry_deleted')
    rescue
      render_failure(:error => I18n.t('no_object_id'))
    end
  end

  private
  
  def get_applicant_by_street_name(street_name)
    ApplicationPresenter.present_applicants_by_street_name(street_name)
  end
  
  def get_expired_permits(date)
    time = Time.parse(date)
    ApplicationPresenter.present_expired(time)
  end
  
  def validate_date(date)
    begin
      Date.parse(date)
      return true
    rescue ArgumentError
      render_failure(:error => I18n.t('incorrect_date'))
      return false
    end
  end
    
  def get_applicant_by_name(name_substring)
    ApplicationPresenter.present_applicants_by_name(name_substring)
  end
  
  def render_success(response)
    render :json => {:http_code => 200, :status => :ok, :response => response}
  end
  
  def render_failure(failure_response = {}, status = 400)
    render :json => {:status => :error, :http_code => status}.merge(failure_response)
  end
end
