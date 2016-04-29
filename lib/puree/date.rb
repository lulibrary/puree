module Puree

  module Date

    # Converts a date with three components (year, month, day) to ISO8601 format
    #
    # @param data [Hash]
    # @return [String]
    def self.iso(data)
      isoDate = ''
      year =  data['year']
      month = data['month']
      day = data['day']
      if !year.empty?
        isoDate << year
      else
        isoDate
      end
      if !month.empty?
        # Add leading zero to convert to ISO 8601
        if month.length < 2
          month.insert(0, '0')
        end
        isoDate << '-' + month
      else
        isoDate
      end
      if !day.empty?
        # Add leading zero to convert to ISO 8601
        if day.length < 2
          day.insert(0, '0')
        end
        isoDate << '-' + day
      end
      isoDate
    end

    private

    # Forces a date to have three components (year, month, day)
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