function conky_hwmon(dev, type, n)
  return string.format("${hwmon %i %s %i}", dev, type, n)
end
