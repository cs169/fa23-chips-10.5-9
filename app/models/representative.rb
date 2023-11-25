# frozen_string_literal: true

class Representative < ApplicationRecord
  has_many :news_items, dependent: :delete_all

  def self.civic_api_to_representative_params(rep_info)
    reps = []

    rep_info.officials.each_with_index do |official, index|
      attributes = get_attributes(official, rep_info.offices, index)
      rep = Representative.find_or_create_by(attributes)
      reps.push(rep)
    end

    reps
  end

  def self.get_attributes(official, offices, index)
    office = offices.find { |potential_office| potential_office.official_indices.include? index }
    ocdid = office.division_id || ''
    title = office.name || ''
    street = get_address(official, :line1)
    city = get_address(official, :city)
    state = get_address(official, :state)
    zip = get_address(official, :zip)
    photo_url = official.photo_url ||= ''
    { name: official.name, ocdid: ocdid, title: title, street: street,
      city: city, state: state, zip: zip, party: official.party, photo: photo_url }
  end

  def self.get_address(official, key)
    if official.address
      official.address[0].send(key)
    else
      ''
    end
  end
end
