require "awesome_print"
########################################################
# RIDESHARE-PROJECT
# Forked From: https://github.com/ada-c14/ride-share

########################################################

########################################################
# Step 1: Establish the layers

# In this section of the file, as a series of comments,
# create a list of the layers you identify.
#   > ANSWER: driver_key, rides w/: date, rider, cost, rating
# Which layers are nested in each other?
#   > ANSWER: driver_key > rides > date/rider_id/cost/rating
# Which layers of data "have" within it a different layer?
#   > ANSWER: driver_key and rides
# Which layers are "next" to each other?
#   > ANSWER: ea. ride's date/rider_id/cost/rating

########################################################

########################################################

# Step 2: Assign a data structure to each layer

# Copy your list from above, and in this section
# determine what data structure each layer should have
#   > ANSWER:
#   rides ride_hash > driver_id key > an array of hashes as
#   the value, so that each ride is a ride_hash with date,
#   rider_id, cost, and rating key and value pairs

########################################################

########################################################
# Step 3: Make the data structure!

# Setup the entire data structure:
# based off of the notes you have above, create the
# and manually write in data presented in rides.csv
# You should be copying and pasting the literal data
# into this data structure, such as "DR0004"
# and "3rd Feb 2016" and "RD0022"
#   ANSWER: --->
########################################################
total_rides = {
    :DR0001 => [
        {date: "3rd Feb 2016", rider_id: "RD0003", cost: 10, rating: 3},
        {date: "3rd Feb 2016", rider_id: "RD0015", cost: 30, rating: 4},
        {date: "5th Feb 2016", rider_id: "RD0003", cost: 45, rating: 2}
    ],
    :DR0002 => [
        {date: "3rd Feb 2016", rider_id: "RD0073", cost: 25, rating: 5},
        {date: "4th Feb 2016", rider_id: "RD0013", cost: 15, rating: 1},
        {date: "5th Feb 2016", rider_id: "RD0066", cost: 35, rating: 3}
    ],
    :DR0003 => [
        {date: "4th Feb 2016", rider_id: "RD0066", cost: 5, rating: 5},
        {date: "5th Feb 2016", rider_id: "RD0003", cost: 50, rating: 2}
    ],
    :DR0004 => [
        {date: "3rd Feb 2016", rider_id: "RD0022", cost: 5, rating: 5},
        {date: "4th Feb 2016", rider_id: "RD0022", cost: 10, rating: 4},
        {date: "5th Feb 2016", rider_id: "RD0073", cost: 20, rating: 5}
    ]
}

puts puts "RIDESHARE DATA COLLECTION INPUT >>"
ap total_rides
puts ""
########################################################
# Step 4: Total Driver's Earnings and Number of Rides

# Use an iteration blocks to print the following answers:
# - 1. the number of rides each driver_key has given
# - 2. the total amount of money each driver_key has made
# - 3. the average rating for each driver_key
# - 4. Which driver_key made the most money?
# - 5. Which driver_key has the highest average rating?
#   ANSWER --->
########################################################

####################### OUTPUT #########################
puts "RIDESHARE DATA COLLECTION OUTPUT >>"
puts ""

# generate & print totals for each driver --->
total_rides.each do |driver_key, driver_array_value|
  driver_array_value.push({ rides_total: 0, ratings_total: 0, cost_total: 0, ratings_avg: 0 })
  driver_array_value.each_with_index do |ride_hash, index|
    ride_hash.each do |subkey, subvalue|
      if subkey == :cost
        driver_array_value.last[:cost_total] += subvalue.to_f.round(2)
      elsif subkey == :rating
        driver_array_value.last[:ratings_total] += subvalue.to_f.round(2)
      else ride_hash == driver_array_value.last # if its last, then that means the total is the final total for the driver
       driver_array_value.last[:rides_total] = (driver_array_value.length - 1)
      driver_array_value.last[:ratings_avg] = (driver_array_value.last[:ratings_total] / (driver_array_value.last[:rides_total])).round(2)
      end
    end
  end
  puts "  > #{driver_key} Totals:"
  puts "  Total Rides: #{driver_array_value.last[:rides_total]}"
  puts "  Total Earned: $#{driver_array_value.last[:cost_total]}"
  puts "  Average Rating: #{driver_array_value.last[:ratings_avg]}"
  puts ""
end

# generate a method to determine highest earning/rated drivers --->
def highest(hash, key)
  highest_total = 0

  hash.each do |driverkey, driver_array_value|
    if driver_array_value.last[key] > highest_total
      highest_total = driver_array_value.last[key]
    end
  end

  hash.each do |driverkey, driver_array_value|
    if driver_array_value.last[key] == highest_total
      return driverkey
    end
  end
end

puts "Highest Earning Driver: #{highest(total_rides, :cost_total)}"
puts "Highest Rated Driver: #{highest(total_rides, :ratings_avg)}"
