# frozen_string_literal: true

FactoryBot.define do
  factory :monthly_streaming do
    month { 1 }
    year { 1 }
    streams { 1 }
    listeners { 1 }
    followers { 1 }
    month_streaming_import
  end
end
