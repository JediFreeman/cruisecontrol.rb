module SourceControl
  class Subversion

    class Subversion::PropgetParser
      def parse(lines)
        lines = lines.lines if lines.is_a?(String) && lines.respond_to?(:lines)
        
        directories = {}
        current_dir = nil
        lines.each do |line|
          split = line.split(" - ")
          if split.length > 1
            current_dir = split[0]
            line = split[1]
          end
          split = line.split(" ")

          # refactored method to handle .. in external path
          if !split[0].blank? and !(split.length > 2)
            base_dir = current_dir
            while split[0].index("../") == 0
              split[0].sub!("../", '')
              base_dir = base_dir.split("/").slice(0..-2).join("/")
            end            
            directories["#{base_dir}/#{split[0]}"] = split.last
          end
        end
        directories
      end
    end
    
  end
end
