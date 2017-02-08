class Property < ApplicationRecord
  require_dependency "static_property"

  acts_as_paranoid

  belongs_to :propertiable, polymorphic: true
  belongs_to :ownerable, polymorphic: true
end
