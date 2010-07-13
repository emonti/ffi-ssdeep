
require 'ffi'

module Ssdeep
  SPAMSUM_LENGTH = 64
  FUZZY_MAX_RESULT = (SPAMSUM_LENGTH + (SPAMSUM_LENGTH/2 + 20)) 

  class FuzzyHash < FFI::MemoryPointer
    def initialize()
      super(FUZZY_MAX_RESULT)
    end

    def to_s
      self.read_string()
    end

    # implements a _dump method for Marshal
    def _dump(depth)
      self.to_s
    end

    # implements a _load method for Marshal
    def self._load(raw)
      new().write_string( 
        if raw.size < FUZZY_MAX_RESULT 
          raw + "\x00" 
        else 
          raw[0,FUZZY_MAX_RESULT]
        end )
    end

    # @return [Integer]
    #   Returns a value from zero to 100 indicating the match score of the 
    #   two signatures. A match score of zero indicates the sigantures did 
    #   not match. 
    #
    # @return [
    #   When an error occurs, such as if one of the inputs is NULL.
    def compare(other)
      unless other.is_a?(FuzzyHash)
        raise(TypeError, "a FuzzyHash can only be compared to another FuzzyHash")
      end
      if (ret=Ssdeep.fuzzy_compare(self, other)) > -1
        return ret
      end
    end

    def self.from_string(buf)
      fh = new()
      p = FFI::MemoryPointer.new(buf.size)
      p.write_string(buf)
      ret = Ssdeep.fuzzy_hash_buf(p, buf.size, fh)
      if ret == 0
        return fh
      else
        fh.free
        raise(StandardError, "An error occurred hashing a string")
      end
    end

    def self.from_file(filename)
      fh = new()
      ret = Ssdeep.fuzzy_hash_filename(filename, fh)
      if ret == 0
        return fh
      else
        fh.free
        raise(StandardError, "An error occurred hashing file: #{filename.inspect}")
      end
    end

  end
end
