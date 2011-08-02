# core extensions to ruby
class Object

  def blank?
    respond_to?(:empty?) ? empty? : !self
  end

  def to_param
    to_s
  end

  def to_query key
    require 'cgi' unless defined?(CGI) && defined?(CGI::escape)
    _key = CGI.escape(key.to_s.camelize(:lower)).gsub(/%(5B|5D)/n) {
             [$1].pack('H*')
           }
    value = CGI.escape(to_param.to_s)

    "#{_key}=#{value}"
  end

end

class Hash

  def to_param namespace = nil
    collect do |key, value|
      value.to_query(namespace ? "#{namespace}[#{key}]" : key)
    end.sort * '&'
  end

end

class String

  def camelize first_letter = :upper
    case first_letter
      when :upper then
        self.gsub(/\/(.?)/) {"::#{$1.upcase}"}.gsub(/(?:^|_)(.)/) {$1.upcase}
      when :lower then
        self[0].chr.downcase + camelize()[1..-1]
    end
  end

end

