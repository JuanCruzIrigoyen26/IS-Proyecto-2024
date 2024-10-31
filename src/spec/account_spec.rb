# frozen_string_literal: true

ENV['APP_ENV'] = 'test'
require File.expand_path('../models/init', __dir__)
require 'rspec'
require 'rack/test'
require 'spec_helper'

describe Account do
  describe 'validations' do
    it 'is valid with valid attributes' do
      account = Account.new(
        name: 'Juan',
        email: 'juandoe@gmail.com',
        password: 'password1',
        nickname: 'juanito123',
        progress: 0
      )
      expect(account).to be_valid
    end
    context 'not valid situations' do
      it 'should be invalid (email blame)' do
        account = Account.new(name: 'Juan', email: 'juanitoyieil.com', password: 'Juanito32', nickname: 'juanito')
        expect(account.valid? && account.correct_format_of_fields?).to be_falsey
      end

      it 'should be invalid (password blame)' do
        account = Account.new(name: 'Juan', email: 'juanito@gmail.com', password: 'ju', nickname: 'juanito')
        expect(account.valid? && account.correct_format_of_fields?).to be_falsey
      end

      it 'should be invalid (nickname blame)' do
        account = Account.new(name: 'Juan', email: 'juanito@gmail.com', password: 'Juanito32', nickname: 'ju anito')
        expect(account.valid? && account.correct_format_of_fields?).to be_falsey
      end

      it 'should be invalid (name blame)' do
        account = Account.new(name: 'Juanit0', email: 'juanito@gmail.com', password: 'Juanito32', nickname: 'juanito')
        expect(account.valid? && account.correct_format_of_fields?).to be_falsey
      end
    end
  end
  describe 'Create same account' do
    it 'should be invalid (email blame)' do
      account1 = Account.new(name: 'Juan', email: 'juanito@gmail.com', password: 'Juanito32', nickname: 'juanito')
      account1.save
      account2 = Account.new(name: account1.name, email: account1.email, password: account1.password,
                             nickname: account1.nickname)
      expect(account2.save).to be_truthy
    end
  end
end
