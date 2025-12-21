# frozen_string_literal: true

class EMeta < ApplicationRecord
  belongs_to :e_empresa
  belongs_to :user, optional: true
end
