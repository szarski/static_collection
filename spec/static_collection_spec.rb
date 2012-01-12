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

      it "should assign an id" do
        id = mock
        subject.stubs(:next_available_id).returns(id)
        item = subject.item :sth
        item.id.should == id
      end
    end

    describe ".next_available_id" do
      context "there is no items" do
        before {subject.stubs(:all).returns([])}
        it "should return 1" do
          subject.next_available_id.should == 1
        end
      end
      context "there are some items already" do
        let(:last_id) {mock}
        before do
          subject.item :one
          subject.item :two
          subject.all.last.stubs(:id).returns(last_id)
        end
        it "should return the first available id" do
          result = mock
          last_id.expects(:+).with(1).returns result
          subject.next_available_id.should == result
        end
      end
    end

  end
end
