# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Representative, type: :model do
  describe '.civic_api_to_representative_params' do
    api_response = {
      officials: [
        OpenStruct.new({ name: 'Kevin Yoder',
          address: [{ 'line1' => '215 Cannon HOB', 'city' => 'washington d.c.', 'state' => 'DC', 'zip' => '20515' }],
          party: 'Republican', photoUrl: 'http://yoder.house.gov/images/user_images/headshot.jpg' })
      ],
      offices:   [OpenStruct.new({ name: 'Mayor', division_id: 'ocdid1', official_indices: [0] })]
    }

    before do
      allow(described_class).to receive(:find_or_create_by).and_call_original

      @office_double = instance_double('office', name: 'Sheriff', division_id: 'Armadillo', official_indices: [0])
      @official_double = instance_double('official', name: 'John Marston',
      address: [{ 'line1' => '215 Cannon HOB', 'city' => 'washington d.c.', 'state' => 'DC', 'zip' => '20515' }],
      party: 'Republican', photoUrl: 'http://yoder.house.gov/images/user_images/headshot.jpg')
      @rep_info_double = instance_double('rep_info', offices: [@office_double], officials: [@official_double])
    end

    context 'when a representative with the same OCD ID already exists' do
      it 'does not create a duplicate representative' do
        described_class.civic_api_to_representative_params(@rep_info_double)

        expect { described_class.civic_api_to_representative_params(@rep_info_double) }.not_to change(described_class, :count)
      end
    end

    context 'when a representative with the same OCD ID does not already exist' do
      it 'creates a new representative' do
        described_class.civic_api_to_representative_params(OpenStruct.new(api_response))

        described_class.civic_api_to_representative_params(@rep_info_double)
        expect(described_class.count).to eq 2
      end
    end

    it 'creates representatives with additional address information' do
      described_class.civic_api_to_representative_params(OpenStruct.new(api_response))
      expect_create_with_attributes(
        name: 'Kevin Yoder', ocdid: 'ocdid1', title: 'Mayor', street: '215 Cannon HOB', city: 'washington d.c.',
        state: 'DC', zip: '20515', party: 'Republican', photo: 'http://yoder.house.gov/images/user_images/headshot.jpg'
      )
    end

    def expect_create_with_attributes(attributes)
      expect(described_class).to have_received(:find_or_create_by).with(attributes).exactly(1).times
    end
  end
end
