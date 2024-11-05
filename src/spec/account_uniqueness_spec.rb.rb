# frozen_string_literal: true

ENV['APP_ENV'] = 'test'
require File.expand_path('../models/init', __dir__)
require 'rspec'
require 'rack/test'
require 'spec_helper'

describe Account, 'uniqueness validation' do
  let(:valid_attributes) do
    { name: 'Juan', email: 'juandoe@gmail.com', password: 'password1', nickname: 'juanito123', progress: 0 }
  end

  it 'is invalid due to duplicate email' do
    Account.create(valid_attributes)
    duplicate_account = Account.new(valid_attributes)

    expect(duplicate_account.save).to be_falsey
  end
end
