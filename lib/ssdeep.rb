require 'ffi'

require 'ssdeep/fuzzy_hash'

module Ssdeep
  extend FFI::Library

  ffi_lib 'fuzzy'

  typedef :pointer, :fuzzy_hash

  # Compute the fuzzy hash of a buffer.
  # 
  # Computes the fuzzy hash of the first buf_len bytes of the buffer. It is the caller's 
  # responsibility to append the filename, if any, to result after computation.
  # 
  # Parameters:
  #     	buf 	The data to be fuzzy hashed
  #     	buf_len 	The length of the data being hashed
  #     	result 	Where the fuzzy hash of buf is stored. This variable 
  #     	        must be allocated to hold at least FUZZY_MAX_RESULT bytes.
  # 
  # Returns:
  #     Returns zero on success, non-zero on error. 
  attach_function :fuzzy_hash_buf, [:pointer, :uint32, :fuzzy_hash], :int

  # Compute the fuzzy hash of a file.
  # 
  # Opens, reads, and hashes the contents of the file 'filename' The 
  # result must be allocated to hold FUZZY_MAX_RESULT characters. It 
  # is the caller's responsibility to append the filename to the 
  # result after computation.
  # 
  # Parameters:
  #     	filename 	The file to be hashed
  #     	result 	Where the fuzzy hash of the file is stored. This variable 
  #     	        must be allocated to hold at least FUZZY_MAX_RESULT bytes.
  # 
  # Returns:
  #     Returns zero on success, non-zero on error. 
  attach_function :fuzzy_hash_filename, [:string, :fuzzy_hash], :int

  # Computes the match score between two fuzzy hash signatures.
  #
  # Returns:
  #   Returns a value from zero to 100 indicating the match score of the 
  #   two signatures. A match score of zero indicates the sigantures did 
  #   not match. When an error occurs, such as if one of the inputs is 
  #   NULL, returns -1. 
  attach_function :fuzzy_compare, [:fuzzy_hash, :fuzzy_hash], :int


  def self.hash_string(str)
    FuzzyHash.from_string(str)
  end

  def self.hash_file(fname)
    FuzzyHash.from_file(fname)
  end

  def self.compare_hashes(h1, h2)
    h1.compare(h2)
  end

  def self.compare_strings(s1, s2)
    compare_hashes(hash_string(s1), hash_string(s2))
  end

  def self.compare_files(f1, f2)
    compare_hashes(hash_file(f1), hash_file(f2))
  end

end
