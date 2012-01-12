require "static_collection/version"

module StaticCollection
  class Base
    def initialize(name)
      @id = self.class.next_available_id
    end

    def id
      @id
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

    def next_available_id
      if all.empty?
        1
      else
        all.last.id + 1
      end
    end
  end
  Base.extend(ClassMethods)
end
