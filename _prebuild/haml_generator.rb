require "haml"
require "ostruct"
require "byebug"

module Debug
  def generate
    debugger
    super
  end
end

# Jekyll::Site.send :prepend, Debug

module Jekyll
  class HamlGenerator < Generator
    def self.custom_dirs
      @custom_dirs ||= []
    end
    
    def self.process_directories *dirs
      @custom_dirs = dirs
    end
    
    def generate(site)
      @site = site
      process_directories self.class.custom_dirs + default_dirs
      re_read_layouts
    end

    def default_dirs
      [
       File.join(@site.source, @site.config['layouts']),
       "_includes"
      ]
    end

    def re_read_layouts
      @site.read_layouts
    end

    def process_directories(dirs)
      dirs.each {|dir|
        entries = read_haml_files(dir)
        entries.each { |f|
          transform_file(f, dir)
        }
      }
    end
    
    def read_haml_files(dir)
      return unless File.exists?(dir)
      entries = []
      Dir.chdir(dir) { entries = filter_haml_entries(Dir['**/*.*']) }
      entries
    end

    def filter_haml_entries(files)
      files.keep_if {|e|
        e =~ /^_.+\.haml$/
      }
    end

    def transform_file(file, dir)
      target_file = html_file(file, dir)
      content = convert_haml(file, dir)
      File.open(target_file, "wb") {|f|
        f.write content
      }
    end

    def convert_haml(file, dir)
      haml_content = File.read File.join(dir, file)
      Haml::Engine.new(haml_content).render(haml_context)
    end

    def haml_context
      _site = OpenStruct.new(@site.config)
      OpenStruct.new(site: _site, pages: @site.pages)
    end

    def html_file(file, dir)
      File.join(dir, file.gsub("_", "").gsub("haml", "html"))
    end
  end
end

