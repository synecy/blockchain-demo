require 'pry'
require 'digest'


def hash_lookup(data)
  work_counter = 0
  calculated_hash = ""
  puts "Looking for correct hash .."
  while calculated_hash[0..3] != "0000"
    calculated_hash = Digest::SHA256.hexdigest("#{data}#{work_counter}")
    work_counter += 1
    puts "#{work_counter} => #{calculated_hash}"
  end
  puts "Hash solution found after checking #{work_counter} hashes:"
  puts calculated_hash
end
hash_lookup("test")
