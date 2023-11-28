# frozen_string_literal: true

FactoryBot.define do
  factory :news_item do
    title { 'title' }
    link { 'link' }
    issue { 'Free Speech' }
    description { 'description' }
    representative { association :representative }
  end
end
