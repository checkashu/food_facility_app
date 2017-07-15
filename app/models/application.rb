class Application < ActiveRecord::Base

    attr_reader :address, :applicant, :locationdescription, :expirationdate, :status
    
    
    def initialize(options = {})
            super(options)
            #@address = options["address"] if options["address"]
            #@applicant_name = options["applicant"]
            #build_for_and_from(options['locationdescription'])
            build_expiration_date(options['expirationdate'])
            #@is_expired = expired?
            
    end
    
    #def expired?
    #    @expiration_date ? Time.now - @expiration_date >= 0 : false
    #end
    
    private
    def build_expiration_date(expirationdate)
        return unless expirationdate
        @expirationdate = Time.parse(expirationdate)
    end
    
    def build_for_and_from(locationdescription)
        return unless locationdescription
        @from, @to = locationdescription.split("to")
    end
    
end