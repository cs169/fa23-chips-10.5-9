# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NewsItem, type: :model do
  let(:valid_issues) do
    ['Free Speech', 'Immigration', 'Terrorism', 'Social Security and Medicare', 'Abortion', 'Student Loans',
     'Gun Control', 'Unemployment', 'Climate Change', 'Homelessness', 'Racism', 'Tax Reform', 'Net Neutrality',
     'Religious Freedom', 'Border Security', 'Minimum Wage', 'Equal Pay']
  end

  it 'is valid with a valid issue' do
    valid_issues.each do |issue|
      news_article = described_class.new(issue: issue)
      expect(news_article).to be_valid
    end
  end

  it 'is invalid with an invalid issue' do
    news_article = described_class.new(issue: 'Invalid Issue')
    expect(news_article).not_to be_valid
  end
end
