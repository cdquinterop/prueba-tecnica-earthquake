class Api::FeaturesController < ApplicationController
  MAX_PER_PAGE = 1000
  def index
    # Obtener todos los terremotos
    @records = Record.all

    # Filtrar por mag_type si se proporciona en los parámetros
    @records = @records.where(mag_type: params[:mag_type]) if params[:mag_type].present?

     # Validar el parámetro per_page para asegurarse de que no exceda el límite máximo
     per_page = params[:per_page].to_i
     per_page = MAX_PER_PAGE if per_page > MAX_PER_PAGE


    # Paginar resultados utilizando will_paginate
    @paginated_records = @records.paginate(page: params[:page], per_page: per_page)

    render json: {
      data: serialize_features(@paginated_records),
      pagination: {
        current_page: @paginated_records.current_page,
        total: @records.count,
        per_page: @paginated_records.per_page
      }
    }
  end

  private

  def serialize_features(features)
    features.map do |feature|
      {
        id: feature.id,
        type: 'feature',
        attributes: {
          external_id: feature.external_id,
          magnitude: feature.magnitude,
          place: feature.place,
          time: feature.time.to_s,
          tsunami: feature.tsunami,
          mag_type: feature.mag_type,
          title: feature.title,
          coordinates: {
            longitude: feature.longitude,
            latitude: feature.latitude
          }
        },
        links: {
          external_url: feature.url
        }
      }
    end
  end
end
