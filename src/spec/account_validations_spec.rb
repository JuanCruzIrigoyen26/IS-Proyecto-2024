# frozen_string_literal: true

ENV['APP_ENV'] = 'test'
require File.expand_path('../models/init', __dir__)
require 'rspec'
require 'rack/test'
require 'spec_helper'

describe Account, 'validations' do
  let(:valid_attributes) do
    { name: 'Juan', email: 'juandoe@gmail.com', password: 'password1', nickname: 'juanito123', progress: 0 }
  end

  describe 'with valid attributes' do
    subject { Account.new(valid_attributes) }

    it 'is valid' do
      expect(subject).to be_valid
    end
  end

  describe 'with invalid attributes' do
    describe 'when email format is invalid' do
      subject { Account.new(valid_attributes.merge(email: 'juanitoyieil.com')) }

      it 'is invalid' do
        expect(subject.valid? && subject.correct_format_of_fields?).to be_falsey
      end
    end

    describe 'when password is too short' do
      subject { Account.new(valid_attributes.merge(password: 'ju')) }

      it 'is invalid' do
        expect(subject.valid? && subject.correct_format_of_fields?).to be_falsey
      end
    end

    describe 'when nickname contains spaces' do
      subject { Account.new(valid_attributes.merge(nickname: 'ju anito')) }

      it 'is invalid' do
        expect(subject.valid? && subject.correct_format_of_fields?).to be_falsey
      end
    end

    describe 'when name contains numbers' do
      subject { Account.new(valid_attributes.merge(name: 'Juanit0')) }

      it 'is invalid' do
        expect(subject.valid? && subject.correct_format_of_fields?).to be_falsey
      end
    end
  end
end
