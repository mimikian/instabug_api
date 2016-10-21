collection @bugs
attributes :number, :status, :priority, :comment
@bugs.each do |bug|
  child ((State.find_by(bug_id: bug.id))) {
    attributes :os, :device, :memory, :storage
  }
end