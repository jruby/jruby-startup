module JRuby::Startup::AppCDS
  def self.regenerate_archive(argv)
    # Sanity check a few things
    java_version = ENV_JAVA['java.specification.version']

    if java_version < '11'
      puts "*** Warning: this feature is only supported on Java 11 or higher"
    end

    if JRUBY_VERSION < '9.2.1.0'
      puts "*** JRuby 9.2.1 or higher recommended"
    end

    # Go for it
    command_line = argv[0] || "-e 1"
    jruby_home = ENV_JAVA['jruby.home']
    jruby_bin = File.join(jruby_home, 'bin')
    jruby_lib = File.join(jruby_home, 'lib')
    jruby_exe = File.join(jruby_bin, 'jruby')
    jruby_list = File.join(jruby_lib, 'jruby.list')
    jruby_jsa = File.join(jruby_lib, 'jruby.jsa')

    # Force JRuby to be verified so its classes are seen by AppCDS
    ENV['VERIFY_JRUBY'] = '1'

    # Dump list of classes for this command line
    puts "*** Outputting list of classes at #{jruby_list}"

    fail unless system "VERIFY_JRUBY=1 JAVA_OPTS='-XX:DumpLoadedClassList=#{jruby_list}' #{jruby_exe} #{command_line}"

    # Use class list to generate AppCDS archive
    puts "*** Generating shared AppCDS archive at #{jruby_jsa}"

    fail unless system "VERIFY_JRUBY=1 JAVA_OPTS='-Xshare:dump -XX:G1HeapRegionSize=2m -XX:+UnlockDiagnosticVMOptions -XX:SharedClassListFile=#{jruby_list} -XX:SharedArchiveFile=#{jruby_jsa}' #{jruby_exe} #{command_line}"

    # Display env vars to use for the new archive
    puts <<~END
    *** Success!

    Set the following environment variables to use the shared archive:

    VERIFY_JRUBY=1 # Only for JRuby versions 9.2.0.0 or earlier
    JAVA_OPTS="-XX:G1HeapRegionSize=2m -XX:SharedArchiveFile=#{jruby_jsa}"
    END
  end
end
