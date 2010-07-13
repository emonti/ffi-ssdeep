require 'spec_helper'

describe Ssdeep do

  it "should have a compare_strings method that compares two strings" do
    str1 = File.read(__FILE__)
    str2 = str1.dup; str2[10,0]="insert some other junk"
    Ssdeep.compare_strings(str1, str1).should == 100
    Ssdeep.compare_strings(str2, str1).should < 100
    Ssdeep.compare_strings(str2, str1).should >= 80
    Ssdeep.compare_strings(str1, "something else").should == 0
    Ssdeep.compare_strings(str2, "something else").should == 0
  end

  it "should have a compare_files method that compares two files" do
    f1 = __FILE__
    f2 = File.join(File.dirname(__FILE__), "spec_helper.rb")
    Ssdeep.compare_files(f1, f1).should == 100
    Ssdeep.compare_files(f1, f2 ).should < 20
    Ssdeep.compare_files(f1, f2 ).should >= 0
  end

  it "should have a compare_strings method that compares two strings" do
    str1 = File.read(__FILE__)
    str2 = str1.dup; str2[10,0]="insert some other junk"
    h1 = Ssdeep::FuzzyHash.from_string(str1)
    h2 = Ssdeep::FuzzyHash.from_string(str2)
    h3 = Ssdeep::FuzzyHash.from_string("something_else")
    Ssdeep.compare_hashes(h1, h1).should == 100
    Ssdeep.compare_hashes(h2, h2).should == 100
    Ssdeep.compare_hashes(h1, h2).should < 100
    Ssdeep.compare_hashes(h1, h2).should >= 80
    Ssdeep.compare_strings(str1, "something else").should == 0
    Ssdeep.compare_strings(str2, "something else").should == 0
  end

  it "should have a hash_string method that generates a fuzzy hash from a string" do
    fh = Ssdeep.hash_string("this is a test string")
    fh.should be_kind_of Ssdeep::FuzzyHash
    fh.to_s.should == "3:YKEpFZ2:YfrI"
  end

  it "should have a hash_file method that generates a fuzzy hash from a filename" do
    fh = Ssdeep.hash_file(sample_file("ssdeep.gemspec"))
    fh.should be_kind_of Ssdeep::FuzzyHash
    fh.to_s.should == "24:ZkR5abenafgr2ph4glPlXeh/Tzj1wfgrUERNvnNyx/7/i/vA:fbenDr2ph9S/TzjvrUQvnoh/i/I"
  end
end

