require "json"

output_hash = {
  "type" => "FeatureCollection",
  "features" => []
}

input = File.open("china.city.json")

json_input = JSON.parse(input.read)

json_input.each_pair do |province, val_hash|
  val_hash.each_pair do |city, val|
    feature = {
      "type" => "Feature",
      "properties" => {
        "province" => province,
        "city" => city
      },
      "geometry" => {
        "type" => "Point",
        "coordinates" => [val["x"].to_f, val["y"].to_f]
      }
    }
    output_hash["features"] << feature
  end
end


output = File.open("china.city.geo.json", "w")
output.write(output_hash.to_json)
output.close