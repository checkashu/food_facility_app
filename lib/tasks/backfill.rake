namespace :backfill do
    desc 'Backfilling data with data at https://data.sfgov.org/resource/rqzj-sfat.json'
    task :backfill_dataset => :environment do
        request = Typhoeus::Request.new("https://data.sfgov.org/resource/rqzj-sfat.json",method: :get)
        json_response = JSON.parse(request.run.response_body)
        raise 'Service didnt response' unless json_response.is_a?(Array)
        json_response.each do |response|
            app = Application.new(process_response(response))
            app.save
        end
    end
    def process_response(response)
        response.except!("cnn", "priorpermit", "latitude", "blocklot", "received", "lot", "schedule", "dayshours", "approved", "permit",\
        "x", "y", "block", "location", "facilitytype", "fooditems", "longitude", "noisent")
    end
    
end