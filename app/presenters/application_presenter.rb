class ApplicationPresenter
    class << self    
        def index(name_substring)
            applications = Application.where("applicant like ? ",  "%#{name_substring}%")
            applications.map {|application| present_application(application) }
        end
        private
        def present_application(application)
            {
                :application_status => application[:status],
                :applicant_name => application[:applicant],
                :address => application[:address],
                :expiration_date => application[:expirationdate],
                :object_id => application[:objectid]
            }
        end
        
    end
end
