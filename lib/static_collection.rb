require "static_collection/version"

module StaticCollection
  class Base
  end

  module ClassMethods
    def all
      []
    end
  end
  Base.extend(ClassMethods)
end
