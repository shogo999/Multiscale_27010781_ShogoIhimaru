require 'fileutils'

class FileHandler
  def copy_file(source_path, destination_path)
    begin
      content = File.read(source_path)
      File.open(destination_path, 'w') { |file| file.write(content) }
      puts "File copied successfully from #{source_path} to #{destination_path}."
    rescue Errno::ENOENT
      puts "Error: File not found."
    rescue StandardError => e
      puts "An error occurred: #{e.message}"
    end
  end

  def list_files_in_directory(directory_path)
    begin
      files = Dir.entries(directory_path).select { |file| File.file?(File.join(directory_path, file)) }
      puts "Files in #{directory_path}:"
      files.each { |file| puts file }
    rescue Errno::ENOENT
      puts "Error: Directory not found."
    rescue StandardError => e
      puts "An error occurred: #{e.message}"
    end
  end

  def search_and_display_files(directory_path, keyword)
    begin
      files = Dir.entries(directory_path).select { |file| File.file?(File.join(directory_path, file)) }

      puts "Files containing '#{keyword}' in #{directory_path}:"
      files.each do |file|
        file_path = File.join(directory_path, file)
        File.foreach(file_path).with_index do |line, index|
          puts "#{file_path}:#{index + 1} - #{line}" if line.include?(keyword)
        end
      end
    rescue Errno::ENOENT
      puts "Error: Directory not found."
    rescue StandardError => e
      puts "An error occurred: #{e.message}"
    end
  end
end

def main
  file_handler = FileHandler.new

  loop do
    puts "\nOptions:"
    puts "1. Copy File"
    puts "2. List Files in Directory"
    puts "3. Search and Display Files"
    puts "4. Quit"

    print "Select an option: "
    STDOUT.flush  # フラッシュして即座に表示されるようにする
    choice = gets.chomp.to_i

    case choice
    when 1
      print "Enter source file path: "
      STDOUT.flush
      source_path = gets.chomp
      print "Enter destination file path: "
      STDOUT.flush
      destination_path = gets.chomp
      file_handler.copy_file(source_path, destination_path)
    when 2
      print "Enter directory path: "
      STDOUT.flush
      directory_path = gets.chomp
      file_handler.list_files_in_directory(directory_path)
    when 3
      print "Enter directory path: "
      STDOUT.flush
      directory_path = gets.chomp
      print "Enter keyword to search: "
      STDOUT.flush
      keyword = gets.chomp
      file_handler.search_and_display_files(directory_path, keyword)
    when 4
      break
    else
      puts "Invalid option. Please try again."
    end
  end
end

main
