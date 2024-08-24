module Iterable
  def iterate_iterator_file
    File.open('iterator.txt', 'r') do |file|
      $iterator = file.read.to_i
      $iterator += 1
    end
  end

  def write_iterator_file
    File.open('iterator.txt', 'w') { |file| file.write($iterator.to_s) }
  end
end
