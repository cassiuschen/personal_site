module Countable
  extend ActiveSupport::Concern

  included do
    include Redis::Objects
    counter :viewer

    def visit
      viewer.increment
    end
  end

  module ClassMethods
  end
end
