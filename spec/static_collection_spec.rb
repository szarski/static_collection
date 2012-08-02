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

    describe ".item_xxx" do
      it "should work with any nuber" do
        lambda{subject.item_123(:sth)}.should_not raise_error
      end

      it "should not accept anything but numbers" do
        lambda{subject.item_1a3(:sth)}.should raise_error
      end

      context "there is no item with id 5" do
        before {subject.stubs(:find).with(5).returns nil}

        it "should assign the id 5" do
          subject.item_5 :sth
          subject.find(5).should_not be_nil
        end
      end

      context "there is an item with id 5" do
        before {subject.stubs(:find).with(5).returns mock}

        it "should raise" do
          lambda{subject.item_5 :sth}.should raise_error
        end
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

    describe ".find" do
      context "there are no items" do
        before {subject.all.should be_empty}
        it "should raise" do
          lambda {subject.find(5)}.should raise_error
        end
      end
      context "there is no item with id 5, but there are other items" do
        before {subject.item :sth}

        it "should raise when searching for 5" do
          lambda {subject.find(5)}.should raise_error
        end
      end
      context "there is an item with id 5" do
        let(:item) {subject.item_5 :sth}

        it "should return that item when searching for 5" do
          item
          subject.find(5).should == item
        end
      end
    end

  end
end
