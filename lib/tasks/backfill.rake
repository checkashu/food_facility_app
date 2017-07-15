namespace :backfill do
    desc 'Backfilling data with data at https://data.sfgov.org/resource/rqzj-sfat.json'
    task :my_task1 => :environment do
        request = Typhoeus::Request.new("https://data.sfgov.org/resource/rqzj-sfat.json",method: :get)
        #debugger
        json_response = JSON.parse(request.run.response_body)
        raise 'Service didnt response' if json_response.key?('error')
        
        json_response.each do |response|
            puts response
            app = Application.new(process_response(response))
            #debugger
            puts app.status
            puts app.applicant
            puts app.expirationdate
            puts app.locationdescription
            puts app.address
            app.save
        end
    end
    def process_response(response)
        response.except!("cnn", "priorpermit", "latitude", "blocklot", "received", "lot", "schedule", "dayshours", "approved", "permit",\
        "x", "y", "block", "location", "facilitytype", "objectid", "fooditems", "status", "longitude", "noisent")
    end
    
end