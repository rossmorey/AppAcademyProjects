json.array! @benches do |bench|
  json.partial! 'bench', bench: bench
end
