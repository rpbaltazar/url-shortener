module UrlShortener
  class Encoder
    ENCODING_CHARS = ('a'..'z').to_a

    def self.encode(id)
      return ENCODING_CHARS[id] if id.zero?
      short_code = ''
      while id != 0
        remainder = id % ENCODING_CHARS.count
        short_code << ENCODING_CHARS[remainder]
        id /= ENCODING_CHARS.count
      end
      short_code
    end
  end
end
