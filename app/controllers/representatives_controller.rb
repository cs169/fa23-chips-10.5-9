# frozen_string_literal: true

class RepresentativesController < ApplicationController
  def index
    @representatives = Representative.all
  end

  def search
    @representatives = Representative.all
  end

  def show
    @id = params[:id]
    # @rep_name = "Rep Name"
    # @rep_ocdid = "1111111"
    # @rep_title = "Rep title"
    # @rep_street = "Rep street"
    # @rep_city = "rep city"
    # @rep_state = "rep state"
    # @rep_zip = "94704"
    # @rep_party = "rep party"
    # @rep_photo = "https://a1cf74336522e87f135f-2f21ace9a6cf0052456644b80fa06d4f.ssl.cf2.rackcdn.com/images/characters/large/2800/Joey-Tribbiani.Friends.webp"

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
