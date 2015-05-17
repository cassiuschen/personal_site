module Tagable
  extend ActiveSupport::Concern

  included do
    field :tags, type: String

    def tags_array
      self.tags.split(',')
    end
  end

  module ClassMethods
  end
end
