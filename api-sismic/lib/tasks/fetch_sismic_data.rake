namespace :fetch_sismic_data do
    desc "Fetch and persist sismic data from USGS"
    task :fetch_and_persist => :environment do
        require 'rest-client'
        require 'json'
    
        url = 'https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson'
        response = RestClient.get(url)
        data = JSON.parse(response.body)

        data['features'].each do |feature|
            properties = feature['properties']
            coordinates = feature['geometry']['coordinates']
        
        # Verificar si los campos requeridos no son nulos
        next if properties['title'].nil? || properties['url'].nil? || properties['place'].nil? ||
        properties['magType'].nil? || coordinates[0].nil? || coordinates[1].nil?

        # Verificar si ya existe un registro con el mismo external_id
         existing_record = Record.find_by(external_id: feature['id'])

        # Verificar rangos de los valores
        mag = properties['mag'].to_f
        longitude = coordinates[0].to_f
        latitude = coordinates[1].to_f
        next unless (mag >= -1.0 && mag <= 10.0) && (latitude >= -90.0 && latitude <= 90.0) &&
            (longitude >= -180.0 && longitude <= 180.0)

        # Persistir los datos en la base de datos
            # Si no existe, crear un nuevo registro
            unless existing_record
                Record.create(
                external_id: feature['id'],
                magnitude: mag,
                place: properties['place'],
                time: Time.at(properties['time'] / 1000),
                url: properties['url'],
                tsunami: properties['tsunami'],
                mag_type: properties['magType'],
                title: properties['title'],
                longitude: longitude,
                latitude: latitude
                )
            end
        end
    end
end
