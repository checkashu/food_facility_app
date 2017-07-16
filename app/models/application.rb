class Application < ActiveRecord::Base

    attr_reader :address, :applicant, :locationdescription, :expirationdate, :status, :objectid
    
    self.primary_key = 'objectid'
    def initialize(options = {})
            super(options)
            #@address = options["address"] if options["address"]
            #@applicant_name = options["applicant"]
            #build_for_and_from(options['locationdescription'])
            build_expiration_date(options['expirationdate'])
            build_object_id(options['objectid'])
            #@is_expired = expired?
            
    end
    
    def expired?
        @expirationdate ? Time.now - @expirationdate >= 0 : false
    end
    
    private
    def build_expiration_date(expirationdate)
        return unless expirationdate
        @expirationdate = Time.parse(expirationdate)
    end
    def build_object_id(objectid)
        #assuming is never nil
        @objectid = objectid.to_i
    end
    
    def build_for_and_from(locationdescription)
        return unless locationdescription
        @from, @to = locationdescription.split("to")
    end
    
end