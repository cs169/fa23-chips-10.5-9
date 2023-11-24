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

  private

  def self.get_attributes(official, offices, index)
    office = offices.find { |potential_office| potential_office.official_indices.include? index }
    ocdid = office.division_id ||= ''
    title = office.name ||= ''
    address = official.address.first ||= ''
    { name: official.name, ocdid: ocdid, title: title, street: address['line1'],
      city: address['city'], state: address['state'],
      zip: address['zip'], party: official.party, photo: official.photoUrl }
  end
end
