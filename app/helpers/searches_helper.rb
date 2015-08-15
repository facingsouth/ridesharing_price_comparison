module SearchesHelper

def find_availability(num)
  if num >= 4
    "High"
  elsif num <= 2
    "Low"
  else
    "Likely"
  end
end

end
