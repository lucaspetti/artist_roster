# frozen_string_literal: true

module Upload
  class BaseService
    def self.valid_file?(file, file_format = :csv)
      new.load(file, separator[file_format])
      true
    rescue CSV::MalformedCSVError
      false
    end

    def self.run(file, import_file)
      new.run(file, import_file)
    end

    def load(file, separator = ',')
      CSV.parse(file, headers: true, col_sep: separator)
    end

    def self.separator
      { csv: ',', tsv: "\t" }
    end
  end
end
