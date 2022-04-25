module LookupTable

  def create_dictionary
    hash = {}
    hash["a"] = "0....."
    hash["b"] = "0.0..."
    hash["c"] = "00...."
    hash["d"] = "00.0.."
    hash["e"] = "0..0.."
    hash["f"] = "000..."
    hash["g"] = "0000.."

    hash["h"] = "0.00.."
    hash["i"] = ".00..."
    hash["j"] = ".000.."
    hash["k"] = "0...0."
    hash["l"] = "0.0.0."
    hash["m"] = "00..0."
    hash["n"] = "00.00."
    hash["o"] = "0..00."
    hash["p"] = "000.0."

    hash["q"] = "00000."
    hash["r"] = "0.000."
    hash["s"] = ".00.0."
    hash["t"] = ".0000."
    hash["u"] = "0...00"
    hash["v"] = "0.0.00"
    hash["w"] = ".000.0"
    hash["x"] = "00..00"
    hash["y"] = "00.000"
    hash["z"] = "0..000"

    hash[" "] = "......"
    hash["cap"] = ".....0"
    return hash
  end

end
