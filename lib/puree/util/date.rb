module Puree
  module Util

    # Date transformations.
    #
    module Date

      # Converts a date with variable components present (year, month, day) to Time format.
      #
      # @param data [Hash]
      # @return [Time]
      def self.hash_to_time(data)
        h = normalise data
        if !h['year'].empty? && !h['month'].empty? && !h['day'].empty?
          return Time.new h['year'].to_i,
                          h['month'].to_i,
                          h['day'].to_i
        end
        if !h['year'].empty? && !h['month'].empty?
          return Time.new h['year'].to_i,
                          h['month'].to_i
        end
        if !h['year'].empty?
          return Time.new h['year'].to_i
        end
        nil
      end

      # Converts a date with three components (year, month, day) to ISO 8601 date format.
      #
      # @param data [Hash]
      # @return [String]
      def self.iso(data)
        iso_date = ''
        year =  data['year']
        month = data['month']
        day = data['day']
        if !year.empty?
          iso_date << year
        else
          iso_date
        end
        if !month.empty?
          # Add leading zero to convert to ISO 8601 date component
          if month.length < 2
            month.insert(0, '0')
          end
          iso_date << '-' + month
        else
          iso_date
        end
        if !day.empty?
          # Add leading zero to convert to ISO 8601 date component
          if day.length < 2
            day.insert(0, '0')
          end
          iso_date << '-' + day
        end
        iso_date
      end

      # Forces a date to have three components (year, month, day).
      #
      # @param data [Hash]
      # @return [Hash]
      def self.normalise(data)
        if !data.nil? && !data.empty?
          date = {}
          year =  data['year']
          month = data['month']
          day = data['day']
          date['year'] = year ? year : ''
          date['month'] = month ? month : ''
          date['day'] = day ? day : ''
          date
        else
          {}
        end
      end

    end

  end
end