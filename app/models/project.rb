# frozen_string_literal: true

##
# Model class for projects.
class Project < ApplicationRecord
  validates :name, presence: true
end
