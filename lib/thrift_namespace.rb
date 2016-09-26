require "thrift_namespace/version"
require "fileutils"

module ThriftNamespace

  $build_dir  = "/tmp/thrift-build"
  $output_dir = "lib/thrift"

  module_function

  def file_to_thrift_namespace(path)
    basename = File.basename(path).gsub!(".thrift", "")

    service_name = basename.split("_").map(&:capitalize).join

    "Thrift.#{service_name}"
  end

  def insert_namespaces
    FileUtils.rm_rf($build_dir)
    FileUtils.cp_r("thrift", $build_dir)

    FileUtils.rm_rf($output_dir)
    FileUtils.mkdir($output_dir)

    thrift_files = Dir["#{$build_dir}/*"]

    thrift_files.each do |path|
      if File.read(path) =~ /namespace rb/
        puts "\e[31mInvalid namespace. Please remove ruby namespace definition.\e[0m"
        exit 1
      end

      namespace = file_to_thrift_namespace(path)
      thrift_namespace_def = "namespace rb #{namespace}\n\n"

      File.write(path, thrift_namespace_def + File.read(path))

      puts "---> Generating thift model for \e[32m#{File.basename(path)}\e[0m in \e[32m#{$output_dir}\e[0m"
            `thrift -r --gen rb -out #{$output_dir} #{path}`

      # make thfit work with Rails by removing unnecessary requires
      `sed -i "s|^require '.*'\$||g" #{$output_dir}/*`

      puts "---> Done"
    end
  end
end
