class LookAndSay

  def self.lns_gsub string
    string.gsub(/(.)\1*/){ |substr| substr.length.to_s + substr.first }
  end

  def self.perform count
    start_value = "1"
    count.times do
      p start_value.to_i
      start_value = lns_gsub(start_value)
    end
  end

end
