# frozen_string_literal: true

require 'rails_helper'

describe Representative, type: :model do
  describe '.civic_api_to_representative_params' do
    before do
      @office_double = instance_double('office', name: 'Sheriff', division_id: 'Armadillo', official_indices: [0])
      @official_double = instance_double('official', name: 'John Marston')
      @rep_info_double = instance_double('rep_info', offices: [@office_double], officials: [@official_double])
    end

    context 'when a representative with the same OCD ID already exists' do
      it 'does not create a duplicate representative' do
        described_class.create!(name: 'John Marston', ocdid: 'Armadillo', title: 'Sheriff')

        expect { described_class.civic_api_to_representative_params(@rep_info_double) }.not_to change(described_class, :count)
      end
    end

    context 'when a representative with the same OCD ID does not already exist' do
      it 'creates a new representative' do
        described_class.create!(name: 'Jack Marston', ocdid: 'Blackgate', title: 'Deputy')

        described_class.civic_api_to_representative_params(@rep_info_double)
        expect(described_class.count).to eq 2
      end
    end
  end
end
