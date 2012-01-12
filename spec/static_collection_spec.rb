require File.join(File.dirname(__FILE__), '..', 'lib', 'static_collection')
describe StaticCollection do
  require 'mocha'

  it "should alow to inherit after it" do
    class A < StaticCollection::Base
    end
  end

  describe "methods" do

    subject do
      if defined?(TestClass)
        Object.send :remove_const, :TestClass
      end
      class TestClass < StaticCollection::Base
      end
      TestClass
    end

    describe ".all" do
      it "should return an empty array by default" do
        subject.all.should == []
      end

      it "should return an array" do
        subject.all.should be_a(Array)
      end

      it "should return all the items" do
        items = mock
        subject.instance_variable_set("@items", items)
        subject.all.should == items
      end
    end

  describe ".item" do
    it "should return an instance of this class" do
      subject.item(:sth).should be_a(subject)
    end
    it "should add an item" do
      item = subject.item :sth
      subject.all.should include(item)
    end
  end

  end

end
