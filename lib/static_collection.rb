require "static_collection/version"

module StaticCollection
  class Base
  end

  module ClassMethods
    def all
      @items || []
    end
  end
  Base.extend(ClassMethods)
end
