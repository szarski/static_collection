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

    def method_missing(method_name, *args, &block)
      if match = (method_name.to_s.match /^item_([0-9]+)$/)
        id = match[1].to_i
        if find(id)
          raise Exception
        end
        item *args
        item.instance_variable_set("@id", 3)
      else
        super(method_name, *args, &block)
      end
    end

    def find(id)
      all.select{|x| x.id == id}.first || nil#raise(Exception)
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
