require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

DATETIME_MPA_PROC = proc do |attribute, year, month, day, hour, minute|
  {"#{attribute}(1i)" => year.to_s, "#{attribute}(2i)" => month.to_s, "#{attribute}(3i)" => day.to_s,
   "#{attribute}(4i)" => hour.to_s, "#{attribute}(5i)" => minute.to_s}
end

DATE_MPA_PROC = proc do |attribute, year, month, day|
  {"#{attribute}(1i)" => year.to_s, "#{attribute}(2i)" => month.to_s, "#{attribute}(3i)" => day.to_s}
end

describe "Multiparameter assignment" do
  
  context 'conditions with actual attribute names' do
    
    it "should handle basic date multiparameter assignment on new searches" do
      search = Order.search(DATE_MPA_PROC.call("shipped_on", 1990, 12, 28))
      search.shipped_on.should == Date.new(1990, 12, 28)
    end
    
    it "should handle basic date multiparameter assignment on conditions=" do
      search = Order.search
      search.conditions = DATE_MPA_PROC.call("shipped_on", 1990, 12, 28)
      search.shipped_on.should == Date.new(1990, 12, 28)
    end
    
    it "should support basic time multiparameter assignment on new searches" do
      search = User.search(DATETIME_MPA_PROC.call("created_at", 2009, 2, 12, 12, 30))
      time = search.created_at
      time.should be_kind_of(Time)
      time.year.should == 2009
      time.month.should == 2
      time.day.should == 12
      time.hour.should == 12
      time.min.should == 30
    end
    
    it "should support basic time multiparameter assignment on conditions=" do
      search = User.search
      search.conditions = DATETIME_MPA_PROC.call("created_at", 2009, 2, 12, 12, 30)
      time = search.created_at
      time.should be_kind_of(Time)
      time.year.should == 2009
      time.month.should == 2
      time.day.should == 12
      time.hour.should == 12
      time.min.should == 30
    end
    
  end
  
  context 'conditions with derived attribute names' do
    
    it "should handle basic date multiparameter assignment on new searches" do
      search = Order.search(DATE_MPA_PROC.call("shipped_on_lt", 1990, 12, 28))
      search.shipped_on_lt.should == Date.new(1990, 12, 28)
    end
    
    it "should handle basic date multiparameter assignment on conditions=" do
      search = Order.search
      search.conditions = DATE_MPA_PROC.call("shipped_on_lt", 1990, 12, 28)
      search.shipped_on_lt.should == Date.new(1990, 12, 28)
    end
    
    it "should support basic time multiparameter assignment on new searches" do
      search = User.search(DATETIME_MPA_PROC.call("created_at_gt", 2009, 2, 12, 12, 30))
      time = search.created_at_gt
      time.should be_kind_of(Time)
      time.year.should == 2009
      time.month.should == 2
      time.day.should == 12
      time.hour.should == 12
      time.min.should == 30
    end
    
    it "should support basic time multiparameter assignment on conditions=" do
      search = User.search
      search.conditions = DATETIME_MPA_PROC.call("created_at_gt", 2009, 2, 12, 12, 30)
      time = search.created_at_gt
      time.should be_kind_of(Time)
      time.year.should == 2009
      time.month.should == 2
      time.day.should == 12
      time.hour.should == 12
      time.min.should == 30
    end
    
  end
  
  context 'conditions on associations' do
    
    it "should handle basic date multiparameter assignment on a relationship" do
      search = User.search(DATE_MPA_PROC.call("orders_shipped_on_lt", 1990, 12, 28))
      search.orders_shipped_on_lt.should == Date.new(1990, 12, 28)
    end
    
    it "should handle basic time multiparameter assignment on a relationship" do
      search = User.search(DATETIME_MPA_PROC.call("orders_created_at_gt", 2009, 2, 12, 12, 30))
      time = search.orders_created_at_gt
      time.should be_kind_of(Time)
      time.year.should == 2009
      time.month.should == 2
      time.day.should == 12
      time.hour.should == 12
      time.min.should == 30
    end
    
  end
  
end