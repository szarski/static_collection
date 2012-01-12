require File.join(File.dirname(__FILE__), '..', 'lib', 'static_collection')
describe StaticCollection do

  it "should alow to inherit after it" do
    class A < StaticCollection::Base
    end
  end

  describe "methods" do

    subject do
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

  end

end
