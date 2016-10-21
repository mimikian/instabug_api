collection @bugs
attributes :number, :status, :priority, :comment
@bugs.each do |bug|
  child (bug.state) {
    attributes :os, :device, :memory, :storage
  }
end