module SanitizeFileName
  extend ActiveSupport::Concern

  HTML_MNEMONICS = {
    '&nbsp;' => ' ',
    '&quot;' => '"',
    '&laquo;' => '«',
    '&raquo;' => '»',
    '&rsquo;' => '’',
    '&lsquo;' => '‘',
    '&ndash;' => '–',
    '&mdash;' => '—',
    '&amp;' => '&',
    '&copy;' => '©',
    '&gt;' => '>',
    '&lt;' => '<'
  }

  STRANGE_CHARACTERS = %w(★)

  module ClassMethods
    def sanitize_writer *fields
      for field in fields
        class_eval <<-RUBY, __FILE__, __LINE__ + 1
          def #{field}= arg
            super sanitize(arg)
          end
        RUBY
      end
    end
  end

  module InstanceMethods
    def sanitize string
      _replace_html_mnemonics! string
      _replace_strange_characters! string
      _replace_ascii_characters! string
      string = _fix_errors string
      strip_whitespaces! string
      _if_start_with_bad_characters! string
      string.strip!
      string
    end

    def _fix_errors string
      string.gsub! '/', ', '
      string.gsub! ',', ', '
      string.gsub! ' .', '.'
      string.gsub! ')', ' ) '
      string.gsub! '(', ' ( '
      string.gsub! ' ?', '?'
      if string =~ /[\.\,]$/ and string[-3..-1] != '...'
        string = string[0...-1]
      end
      string.gsub! /\.{4,}$/, '...'
      string
    end

    def _replace_html_mnemonics! string
      for mnemonic in HTML_MNEMONICS.keys
        string.gsub! mnemonic, HTML_MNEMONICS[mnemonic]
      end
    end

    def _if_start_with_bad_characters! string
      string.gsub! /^[\,\.!\*\/]/, ''
    end

    def _replace_strange_characters! string
      for character in STRANGE_CHARACTERS
        string.gsub! character, ' '
      end
    end

    def _replace_ascii_characters! string
      string.scan(/\&\#(\d+)\;/).flatten.each do |char_code|
        string.gsub! "&##{char_code};", char_code.to_i.chr
      end
    end

    def strip_whitespaces! string
      string.gsub! ' ,', ','
      string.gsub! '( ', '('
      string.gsub! ' )', ')'
      string.gsub! /\s{2,}/, ' '
    end
  end
end
