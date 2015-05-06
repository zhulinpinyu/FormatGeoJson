require "json"

input = File.open("sz_stores_ma.json")
json_input = JSON.parse(input.read)["hits"]

output_hash = {
  "type" => "FeatureCollection",
  "features" => []
}

json_input.each do |e|
  store = e["_source"]
  feature = {
    "type" => "Feature",
    "properties" => {
      "lgl_geo3" => store["lgl_geo3"],
      "lgl_biz_name" => store["lgl_biz_name"]
    },
    "geometry" => {
      "type" => "Point",
      "coordinates" => [store["lgl_longitude_ma"].to_f, store["lgl_latitude_ma"].to_f]
    }
  }
  output_hash["features"] << feature
end


output = File.open("sz_stores_ma.geo.json", "w")
output.write(output_hash.to_json)
output.close