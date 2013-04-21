module Cat
  class Tool
    class << self

      def encrypt_password password
        return nil if password.blank?
        Digest::SHA1.hexdigest(password.to_s)
      end

      def encrypt_id id
        str = id.to_s
        res = (str.first.to_i * 7).to_s.last + id.to_s + (str.last.to_i * 3).to_s.last
        res.to_i.to_s(16)
      end

      def decrypt_id string
        return nil if string.blank?
        res = string.to_s.hex.to_s
        uid = res[1..-2]
        if (uid.first.to_i * 7).to_s.last == res.first and (uid.last.to_i * 3).to_s.last == res.last
          uid.to_i
        else
          nil
        end
      end

      def generate_key size = 32
        Base64.encode64(OpenSSL::Random.random_bytes(size)).gsub(/\W/, '')
      end

      def random_str length = 4
        SecureRandom.hex(length)
      end

      def nil2n(str)
        str.nil? ? '' : str
      end

      def ids_to_arr ids
        ids = ids.to_s
        if ids.blank?
          []
        else
          id_arr = []
          ids.split(',').each do |id|
            id = id.strip
            id = id.to_i
            id_arr << id if id > 0
          end
          id_arr == [] ? nil : id_arr
        end
      end

      # key1: value1, key2: value2
      # {key1 => value1, key2 => value2}
      def str_to_hash (str, key_value_is_integer = true)
        arr = str.split(',')
        hash = {}
        arr.each do |r|
          k, v = r.strip.split(':')
          if key_value_is_integer
            hash[k.strip.to_i] = v.strip.to_i
          else
            hash[k.strip] = v.strip
          end
        end
        hash
      end

      def to_date(date, nil_to_today = false)
        if date
          begin
            return Date.parse(date)
          rescue
            nil
          end
        end
        nil_to_today ? Date.today : nil
      end

    end
  end
end