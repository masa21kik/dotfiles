require "optparse"
require "fileutils"

class SymlinkMaker
  def run(args)
    parse_args(args)
    targets.each {|f| make_symlink(f) }
  end

  private

  def parse_args(args)
    @option = {}
    opt = OptionParser.new
    opt.on("-p", "--platform PLATFORM") {|v| @option[:platform] = v }
    opt.on("--dry-run") { @option[:dry_run] = true }
    opt.parse!(args)
    abort(opt.help) if @option[:platform].nil?
  end

  def config_path
    case @option[:platform].downcase
    when "osx" then File.join(ENV["HOME"], "Library/Application Support/Code/User/")
    else raise "NotImplemented"
    end
  end

  def make_symlink(f)
    backup_original(f)
    src_file = File.expand_path(File.join(here, f))
    dst_file = File.join(config_path, f)
    puts "Create symlink src=#{src_file}, dst=#{dst_file}"
    FileUtils.ln_s(src_file, dst_file) unless @option[:dry_run]
  end

  def backup_original(f)
    org_file = File.join(config_path, f)
    if File.exist?(org_file)
      puts "Backup file: #{org_file}"
      FileUtils.mv(org_file, org_file + ".org") unless @option[:dry_run]
    end
  end

  def targets
    Dir.glob(File.join(here, "*.json")).map {|f| File.basename(f) } + %w[snippets]
  end

  def here
    File.dirname(__FILE__)
  end
end

SymlinkMaker.new.run(ARGV) if $PROGRAM_NAME == __FILE__
