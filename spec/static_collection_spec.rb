require File.join(File.dirname(__FILE__), '..', 'lib', 'static_collection')
describe StaticCollection do

  it "should alow to inherit after it" do
    class A < StaticCollection::Base
    end
  end

end
