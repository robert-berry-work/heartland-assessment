def solution(s)
  lines = s.split("\n")

  city_photos = Hash.new { |hash, key| hash[key] = [] }

  lines.each do |line|
    parts = line.split(", ")
    photo_name, city_name, datetime = parts[0], parts[1], parts[2..-1].join(", ")
    city_photos[city_name] << { photo_name: photo_name, datetime: datetime }
  end

  max_photos = city_photos.values.map(&:size).max
  num_digits = max_photos.to_s.length

  result = []
  city_photos.each do |city_name, photos|
    photos.sort_by! { |photo| photo[:datetime] }
    photos.each_with_index do |photo, index|
      padded_number = (index + 1).to_s.rjust(num_digits, "0")
      new_name = "#{city_name}#{padded_number}#{File.extname(photo[:photo_name])}"
      result << new_name
    end
  end

  result.join("\n")
end
