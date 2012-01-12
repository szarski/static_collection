require "static_collection/version"

module StaticCollection
  class Base
    def initialize(name)
    end
  end

  module ClassMethods
    def all
      @items || []
    end
    def item(name)
      item = new(name)
      @items ||= []
      @items << item
      return item
    end
  end
  Base.extend(ClassMethods)
end
