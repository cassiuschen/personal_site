module Likeable
  extend ActiveSupport::Concern

  included do
    field :like, type: Integer, default: 0

    def do_like
      self.like += 1
      self.save
    end

    def dislike
      self.like -= 1
      self.save
    end
  end

  module ClassMethods
  end
end
