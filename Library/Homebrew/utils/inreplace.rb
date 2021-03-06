module Utils
  module Inreplace
    def inreplace paths, before=nil, after=nil
      Array(paths).each do |path|
        f = File.open(path, 'rb')
        s = f.read

        if before.nil? && after.nil?
          s.extend(StringInreplaceExtension)
          yield s
        else
          after = after.to_s if Symbol === after
          sub = s.gsub!(before, after)
          if sub.nil?
            opoo "inreplace in '#{path}' failed"
            puts "Expected replacement of '#{before}' with '#{after}'"
          end
        end

        f.reopen(path, 'wb').write(s)
        f.close
      end
    end
  end
end
