# frozen_string_literal: true

if Rails.env.development?
  User.create!(
    email: 'admin@example.com',
    first_name: 'Admin',
    last_name: 'User',
    password: 'password',
    password_confirmation: 'password'
  )
end
