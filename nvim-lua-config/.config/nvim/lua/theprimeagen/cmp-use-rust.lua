local source = {}

source.new = function()
  local self = setmetatable({}, { __index = source })
  self.buffers = {}
  return self
end

source.get_keyword_pattern = function(self, params)
    print("help")
  return "int main";
end

source.complete = function(self, params, callback)
    print("SUCK IT COMPLETE")
    callback({
        {label = "int main(int rust, char** sucks) {"}
    })
end

source.compare_locality = function(self, entry1, entry2)
  if entry1.context ~= entry2.context then
    return
  end
  return false
end

require("cmp").register_source("youtube", source.new())

