require 'spec_helper'

describe Ssdeep::FuzzyHash do
  context "basic features" do
    before(:all) do
      @fh1 = Ssdeep::FuzzyHash.from_file(sample_file("ssdeep.gemspec"))
    end

    it "should support a from_string class method to hash from a string buffer" do
      Ssdeep::FuzzyHash.from_file(sample_file("ssdeep.gemspec")).should be_kind_of(Ssdeep::FuzzyHash)
    end

    it "should support a from_string class method to hash from a string buffer" do
      Ssdeep::FuzzyHash.from_string("helu").should be_kind_of(Ssdeep::FuzzyHash)
    end

    it "should support a compare method to compare one FuzzyHash to another" do
      fh2 = Ssdeep.hash_file(sample_file("ffi-ssdeep.gemspec"))
      sh = Ssdeep.hash_string("helu")
      @fh1.compare(@fh1).should == 100
      @fh1.compare(fh2).should > 90
      @fh1.compare(sh).should == 0
    end

    it "should raise an exception when comparing null hash data" do
      hh = Ssdeep::FuzzyHash.new()
      lambda{ @fh1.compare(hh)}.should raise_error(StandardError)
      lambda{ hh.compare(@fh1)}.should raise_error(StandardError)
    end
  end

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
