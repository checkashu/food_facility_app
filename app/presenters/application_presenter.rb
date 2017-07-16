class ApplicationPresenter
    class << self    
        def present_applicants_by_name(name_substring)
            applications = Application.where("applicant like ? ",  "%#{name_substring}%")
            applications.map {|application| present_application(application) }
        end

        def present_applicants_by_street_name(street)
            applications = Application.where("address like ? ",  "%#{street}%")
            applications.map {|application| present_application(application) }
        end

        def present_expired(date)
            applications = Application.where("expirationdate < ? OR expirationdate IS NULL", date)
            applications.map {|application| present_application(application) }
        end

        def add_entry(params)
            application = Application.new(params)
            application.save
        end

        def delete_entry(object_id)
            Application.find(object_id.to_i).destroy
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
