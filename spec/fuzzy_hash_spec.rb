require 'spec_helper'

describe Ssdeep::FuzzyHash do
  context "marshal serialization" do
    before(:all) do
      @fh = Ssdeep::FuzzyHash.from_file(sample_file("ssdeep.gemspec"))
      @ser = Marshal.dump(@fh)
    end

    it "should be serializable with Marshal.dump()" do
      @ser.should be_kind_of(String)
      @ser.should_not be_empty
      @ser.index(@fh.to_s).should_not be_nil
    end

    it "should be unserializable with Marshal.load()" do
      fh_restore = Marshal.load(@ser)
      fh_restore.should be_kind_of(Ssdeep::FuzzyHash)
      fh_restore.compare(@fh).should == 100
    end
  end
end
