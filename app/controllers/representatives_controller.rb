# frozen_string_literal: true

class RepresentativesController < ApplicationController
  def index
    @representatives = Representative.all
  end

  def show
    @id = params[:id]
    @representative = Representative.find(@id)

    return unless @representative

    @rep_name = @representative.name
    @rep_ocdid = @representative.ocdid
    @rep_title = @representative.title
    @rep_street = @representative.street
    @rep_city = @representative.city
    @rep_state = @representative.state
    @rep_zip = @representative.zip
    @rep_party = @representative.party
    @rep_photo = @representative.photo
  end
end
