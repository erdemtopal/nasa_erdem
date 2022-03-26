class Mission < ApplicationRecord
  validates :name, presence: true	
  validates :weight, presence: true
  validates :firstlocation, presence: true
  validate :secondcontrol, on: :create

  def secondcontrol
    errors.add(:secondlocation, "is can not same as firstlocation!") unless secondlocation != firstlocation
  end


  before_create :set_fuel


  def set_fuel
  	if self.secondlocation == "We don't have second location"
    	set_for_two_location
    else
    	set_for_three_location
    end
  end

  def set_for_two_location
  	set_gravity_for_two_location
 	  calculate_fuel_for_two_location
  end


  def set_for_three_location
 	  set_gravity_for_three_location
 	  calculate_fuel_for_three_location
  end

  def set_gravity_for_two_location
  	if self.firstlocation =="Moon"
  		@@weight = self.weight
  		@@earth_gravity = 9.807
  		@@location1_gravity = 1.62
  	else
  		@@weight = self.weight
  		@@earth_gravity = 9.807
  		@@location1_gravity = 3.711
  	end
  end



  def set_gravity_for_three_location
  	if self.firstlocation =="Moon"
  		@@weight = self.weight
  		@@earth_gravity = 9.807
  		@@location1_gravity = 1.62
  		@@location2_gravity = 3.711
  	else
  		@@weight = self.weight
  		@@earth_gravity = 9.807
  		@@location2_gravity = 1.62
  		@@location1_gravity = 3.711
  	end
  end

  def calculate_fuel_for_two_location
      @a1 = 0
      @a2 = 0
      @a3 = 0
      @a4 = 0
      @b1 = []
      @b2 = []
      @b3 = []
      @b4 = []
    @fuel_for_two = @@weight
    while ((@fuel_for_two*@@earth_gravity*0.033).floor) > 42
      @a1 = ((@fuel_for_two*@@earth_gravity*0.033).floor - 42)
      @b1.push(@a1) 
      @fuel_for_two = @a1
    end
    @fuel_for_two = @b1.sum + @@weight
    while ((@fuel_for_two*@@location1_gravity*0.042).floor ) > 33
      @a2 = ((@fuel_for_two*@@location1_gravity*0.042).floor - 33)
      @b2.push(@a2)
      @fuel_for_two = @a2
    end
    @fuel_for_two = @b1.sum+ @b2.sum + @@weight
    while ((@fuel_for_two*@@location1_gravity*0.033).floor) > 42
      @a3 = ((@fuel_for_two*@@location1_gravity*0.033).floor - 42)
      @b3.push(@a3) 
      @fuel_for_two = @a3
    end
    @fuel_for_two =@b1.sum + @b2.sum + @b3.sum + @@weight
    while ((@fuel_for_two*@@earth_gravity*0.042).floor ) > 33
      @a4 = ((@fuel_for_two*@@earth_gravity*0.042).floor - 33)
      @b4.push(@a4)
      @fuel_for_two = @a4
    end
    self.fuel = @b4.sum + @b3.sum+ @b2.sum+ @b1.sum
  end



  def calculate_fuel_for_three_location
      @a1 = 0
      @a2 = 0
      @a3 = 0
      @a4 = 0
      @a5 = 0
      @a6 = 0
      @b1 = []
      @b2 = []
      @b3 = []
      @b4 = []
      @b5 = []
      @b6 = []
    @fuel_for_two = @@weight
    while ((@fuel_for_two*@@earth_gravity*0.033).floor) > 42
      @a1 = ((@fuel_for_two*@@earth_gravity*0.033).floor - 42)
      @b1.push(@a1) 
      @fuel_for_two = @a1
    end
    @fuel_for_two = @b1.sum + @@weight
    while ((@fuel_for_two*@@location2_gravity*0.042).floor ) > 33
      @a2 = ((@fuel_for_two*@@location2_gravity*0.042).floor - 33)
      @b2.push(@a2)
      @fuel_for_two = @a2
    end
    @fuel_for_two = @b1.sum+ @b2.sum + @@weight
    while ((@fuel_for_two*@@location2_gravity*0.033).floor) > 42
      @a3 = ((@fuel_for_two*@@location2_gravity*0.033).floor - 42)
      @b3.push(@a3) 
      @fuel_for_two = @a3
    end
    @fuel_for_two = @b1.sum + @b2.sum + @b3.sum + @@weight
    while ((@fuel_for_two*@@location1_gravity*0.042).floor ) > 33
      @a4 = ((@fuel_for_two*@@location1_gravity*0.042).floor - 33)
      @b4.push(@a4)
      @fuel_for_two = @a4
    end
    @fuel_for_two = @b1.sum+ @b2.sum + @b3.sum + @b4.sum + @@weight
    while ((@fuel_for_two*@@location1_gravity*0.033).floor) > 42
      @a5 = ((@fuel_for_two*@@location1_gravity*0.033).floor - 42)
      @b5.push(@a5) 
      @fuel_for_two = @a5
    end
    @fuel_for_two =@b1.sum + @b2.sum + @b3.sum + @b4.sum + @b5.sum + @@weight
    while ((@fuel_for_two*@@earth_gravity*0.042).floor ) > 33
      @a6 = ((@fuel_for_two*@@earth_gravity*0.042).floor - 33)
      @b6.push(@a6)
      @fuel_for_two = @a6
    end
    self.fuel = @b6.sum + @b5.sum + @b4.sum + @b3.sum+ @b2.sum+ @b1.sum
  end

end

