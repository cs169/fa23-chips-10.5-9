# frozen_string_literal: true

FactoryBot.define do
  factory :representative do
    name { 'Kevin Yoder' }
    street { '215 Cannon HOB' }
    city { 'washington d.c.' }
    state { 'DC' }
    zip { '20515' }
    party { 'Republican' }
    photo { 'http://yoder.house.gov/images/user_images/headshot.jpg' }
    ocdid { 'ocdid1' }
    title { 'Mayor' }
  end
end
